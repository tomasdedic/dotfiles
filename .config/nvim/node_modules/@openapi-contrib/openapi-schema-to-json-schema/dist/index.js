"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.openapiSchemaToJsonSchema = exports.fromSchema = exports.fromParameter = void 0;
const fast_deep_equal_1 = __importDefault(require("fast-deep-equal"));
const convert_1 = require("./lib/convert");
const consts_1 = require("./consts");
const cloneDeep_1 = __importDefault(require("lodash/cloneDeep"));
const patternPropertiesHandler = (schema) => {
    let pattern;
    const patternsObj = schema.patternProperties;
    const additProps = schema.additionalProperties;
    if (typeof additProps !== "object") {
        return schema;
    }
    for (pattern in patternsObj) {
        if ((0, fast_deep_equal_1.default)(patternsObj[pattern], additProps)) {
            schema.additionalProperties = false;
            break;
        }
    }
    return schema;
};
const resolveOptions = (_options) => {
    const options = (0, cloneDeep_1.default)(_options || {});
    options.dateToDateTime = Boolean(options.dateToDateTime);
    options.cloneSchema ?? (options.cloneSchema = true);
    options.supportPatternProperties = Boolean(options.supportPatternProperties);
    options.keepNotSupported ?? (options.keepNotSupported = []);
    options.definitionKeywords ?? (options.definitionKeywords = []);
    options.strictMode ?? (options.strictMode = true);
    if (typeof options.patternPropertiesHandler !== "function") {
        options.patternPropertiesHandler = patternPropertiesHandler;
    }
    options._removeProps = [];
    if (options.removeReadOnly) {
        options._removeProps.push("readOnly");
    }
    if (options.removeWriteOnly) {
        options._removeProps.push("writeOnly");
    }
    options._structs = consts_1.STRUCTS;
    options._notSupported = consts_1.NOT_SUPPORTED.filter((l) => {
        return !options.keepNotSupported?.includes(l);
    });
    return options;
};
const openapiSchemaToJsonSchema = (schema, options) => {
    const optionsInternal = resolveOptions(options);
    return (0, convert_1.fromSchema)(schema, optionsInternal);
};
exports.fromSchema = openapiSchemaToJsonSchema;
exports.openapiSchemaToJsonSchema = openapiSchemaToJsonSchema;
const openapiParameterToJsonSchema = (parameter, options) => {
    const optionsInternal = resolveOptions(options);
    return (0, convert_1.fromParameter)(parameter, optionsInternal);
};
exports.fromParameter = openapiParameterToJsonSchema;
exports.default = openapiSchemaToJsonSchema;
//# sourceMappingURL=index.js.map