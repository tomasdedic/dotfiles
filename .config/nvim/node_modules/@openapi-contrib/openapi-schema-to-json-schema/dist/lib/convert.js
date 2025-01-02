"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.fromParameter = exports.fromSchema = void 0;
const schema_1 = __importDefault(require("./converters/schema"));
const parameter_1 = __importDefault(require("./converters/parameter"));
exports.fromSchema = schema_1.default;
exports.fromParameter = parameter_1.default;
exports.default = {
    fromSchema: schema_1.default,
    fromParameter: parameter_1.default,
};
//# sourceMappingURL=convert.js.map