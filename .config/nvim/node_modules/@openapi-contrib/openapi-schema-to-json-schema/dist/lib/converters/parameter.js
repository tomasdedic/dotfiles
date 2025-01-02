"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const schema_1 = __importDefault(require("./schema"));
const invalid_input_error_1 = __importDefault(require("../errors/invalid-input-error"));
const convertParameterSchema = ({ description }, schema, options) => {
    const jsonSchema = (0, schema_1.default)(schema || {}, options);
    if (description) {
        jsonSchema.description = description;
    }
    return jsonSchema;
};
const convertFromContents = (parameter, options) => {
    const schemas = {};
    for (const mime in parameter.content) {
        schemas[mime] = convertParameterSchema(parameter, parameter.content[mime].schema, options);
    }
    return schemas;
};
const isResponseObject = (parameter) => {
    return Boolean(parameter) && "content" in parameter && Boolean(parameter.content);
};
// Convert from OpenAPI 3.0 `ParameterObject` to JSON schema v4
const convertFromParameter = (parameter, options) => {
    if ("schema" in parameter && parameter.schema) {
        return convertParameterSchema(parameter, parameter.schema, options);
    }
    if (isResponseObject(parameter)) {
        return convertFromContents(parameter, options);
    }
    if (options.strictMode) {
        throw new invalid_input_error_1.default("OpenAPI parameter must have either a 'schema' or a 'content' property");
    }
    return convertParameterSchema(parameter, {}, options);
};
exports.default = convertFromParameter;
//# sourceMappingURL=parameter.js.map