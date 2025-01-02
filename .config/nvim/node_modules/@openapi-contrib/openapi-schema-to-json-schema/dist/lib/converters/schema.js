"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const isObject_1 = require("../utils/isObject");
const invalid_type_error_1 = __importDefault(require("../errors/invalid-type-error"));
const consts_1 = require("../../consts");
const cloneDeep_1 = __importDefault(require("lodash/cloneDeep"));
const get_1 = __importDefault(require("lodash/get"));
const set_1 = __importDefault(require("lodash/set"));
// Convert from OpenAPI 3.0 `SchemaObject` to JSON schema v4
function convertFromSchema(schema, options) {
    const newSchema = convertSchema(schema, options);
    newSchema.$schema = "http://json-schema.org/draft-04/schema#";
    return newSchema;
}
function convertSchema(schema, options) {
    if (options.cloneSchema) {
        schema = (0, cloneDeep_1.default)(schema);
    }
    const structs = options._structs;
    const notSupported = options._notSupported;
    const strictMode = options.strictMode;
    const definitionKeywords = options.definitionKeywords || [];
    const beforeTransform = options.beforeTransform;
    const afterTransform = options.afterTransform;
    if (beforeTransform) {
        schema = beforeTransform(schema, options);
    }
    for (const struct of structs) {
        if (Array.isArray(schema[struct])) {
            let cloned = false;
            for (let j = 0; j < schema[struct].length; j++) {
                if (!(0, isObject_1.isObject)(schema[struct][j])) {
                    if (options.cloneSchema && !cloned) {
                        cloned = true;
                        schema[struct] = schema[struct].slice();
                    }
                    schema[struct].splice(j, 1);
                    j--;
                    continue;
                }
                schema[struct][j] = convertSchema(schema[struct][j], options);
            }
        }
        else if (schema[struct] === null) {
            delete schema[struct];
        }
        else if (typeof schema[struct] === "object") {
            schema[struct] = convertSchema(schema[struct], options);
        }
    }
    let convertedSchema = schema;
    for (const def of definitionKeywords) {
        const innerDef = (0, get_1.default)(schema, def);
        if (typeof innerDef === "object") {
            const convertedInnerDef = convertProperties(innerDef, options);
            (0, set_1.default)(schema, def, convertedInnerDef);
        }
    }
    if ("properties" in convertedSchema) {
        convertedSchema.properties = convertProperties(convertedSchema.properties, options);
        if (Array.isArray(convertedSchema.required)) {
            convertedSchema.required = convertedSchema.required.filter((key) => "properties" in convertedSchema && convertedSchema.properties?.[key] !== undefined);
            if (convertedSchema.required.length === 0) {
                delete convertedSchema.required;
            }
        }
        if (Object.keys(convertedSchema.properties).length === 0) {
            delete convertedSchema.properties;
        }
    }
    if (strictMode && "type" in convertedSchema) {
        validateType(convertedSchema.type);
    }
    convertTypes(convertedSchema);
    convertFormat(convertedSchema, options);
    if ("x-patternProperties" in convertedSchema && options.supportPatternProperties) {
        convertedSchema = convertPatternProperties(convertedSchema, options.patternPropertiesHandler);
    }
    for (const item of notSupported) {
        delete convertedSchema[item];
    }
    if (afterTransform) {
        return afterTransform(convertedSchema, options);
    }
    return convertedSchema;
}
const validTypes = ["integer", "number", "string", "boolean", "object", "array", "null"];
function validateType(type) {
    if (type && !validTypes.includes(type)) {
        throw new invalid_type_error_1.default(`Type ${JSON.stringify(type)} is not a valid type`);
    }
}
function convertProperties(properties, options) {
    let key;
    const props = {};
    let removeProp;
    if (!(0, isObject_1.isObject)(properties) || !properties) {
        return props;
    }
    for (key in properties) {
        const property = properties[key];
        if (!(0, isObject_1.isObject)(property)) {
            continue;
        }
        removeProp = options._removeProps.some((prop) => property[prop] === true);
        if (removeProp) {
            continue;
        }
        props[key] = convertSchema(property, options);
    }
    return props;
}
function convertTypes(schema) {
    if ("type" in schema) {
        const type = schema.type;
        const schemaEnum = schema.enum;
        if (type !== undefined && schema.nullable === true) {
            schema.type = [type, "null"];
            if (Array.isArray(schemaEnum) && !schemaEnum.includes(null)) {
                // @ts-ignore
                schema.enum = schemaEnum.concat([null]);
            }
        }
    }
    return schema;
}
const formatConverters = {
    int32: convertFormatInt32,
    int64: convertFormatInt64,
    float: convertFormatFloat,
    double: convertFormatDouble,
    byte: convertFormatByte,
};
function convertFormat(schema, { dateToDateTime }) {
    const format = schema.format;
    const settings = {
        MIN_INT_32: 0 - 2 ** 31,
        MAX_INT_32: 2 ** 31 - 1,
        MIN_INT_64: 0 - 2 ** 63,
        MAX_INT_64: 2 ** 63 - 1,
        MIN_FLOAT: 0 - 2 ** 128,
        MAX_FLOAT: 2 ** 128 - 1,
        MIN_DOUBLE: 0 - Number.MAX_VALUE,
        MAX_DOUBLE: Number.MAX_VALUE,
        // Matches base64 (RFC 4648)
        // Matches `standard` base64 not `base64url`. The specification does not
        // exclude it but current ongoing OpenAPI plans will distinguish btoh.
        BYTE_PATTERN: "^[\\w\\d+\\/=]*$",
    };
    if (format === undefined || consts_1.VALID_OPENAPI_FORMATS.includes(format)) {
        return schema;
    }
    if (format === "date" && dateToDateTime === true) {
        return convertFormatDate(schema);
    }
    const converter = formatConverters[format];
    if (!converter) {
        return schema;
    }
    return converter(schema, settings);
}
function convertFormatInt32(schema, { MIN_INT_32, MAX_INT_32 }) {
    if ((!schema.minimum && schema.minimum !== 0) || schema.minimum < MIN_INT_32) {
        schema.minimum = MIN_INT_32;
    }
    if ((!schema.maximum && schema.maximum !== 0) || schema.maximum > MAX_INT_32) {
        schema.maximum = MAX_INT_32;
    }
    return schema;
}
function convertFormatInt64(schema, { MIN_INT_64, MAX_INT_64 }) {
    if ((!schema.minimum && schema.minimum !== 0) || schema.minimum < MIN_INT_64) {
        schema.minimum = MIN_INT_64;
    }
    if ((!schema.maximum && schema.maximum !== 0) || schema.maximum > MAX_INT_64) {
        schema.maximum = MAX_INT_64;
    }
    return schema;
}
function convertFormatFloat(schema, { MIN_FLOAT, MAX_FLOAT }) {
    if ((!schema.minimum && schema.minimum !== 0) || schema.minimum < MIN_FLOAT) {
        schema.minimum = MIN_FLOAT;
    }
    if ((!schema.maximum && schema.maximum !== 0) || schema.maximum > MAX_FLOAT) {
        schema.maximum = MAX_FLOAT;
    }
    return schema;
}
function convertFormatDouble(schema, { MIN_DOUBLE, MAX_DOUBLE }) {
    if ((!schema.minimum && schema.minimum !== 0) || schema.minimum < MIN_DOUBLE) {
        schema.minimum = MIN_DOUBLE;
    }
    if ((!schema.maximum && schema.maximum !== 0) || schema.maximum > MAX_DOUBLE) {
        schema.maximum = MAX_DOUBLE;
    }
    return schema;
}
function convertFormatDate(schema) {
    schema.format = "date-time";
    return schema;
}
function convertFormatByte(schema, { BYTE_PATTERN }) {
    schema.pattern = BYTE_PATTERN;
    return schema;
}
function convertPatternProperties(schema, handler) {
    if ((0, isObject_1.isObject)(schema["x-patternProperties"])) {
        schema.patternProperties = schema["x-patternProperties"];
    }
    delete schema["x-patternProperties"];
    return handler(schema);
}
exports.default = convertFromSchema;
//# sourceMappingURL=schema.js.map