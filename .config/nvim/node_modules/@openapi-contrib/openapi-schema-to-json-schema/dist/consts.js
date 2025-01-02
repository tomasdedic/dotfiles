"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.VALID_OPENAPI_FORMATS = exports.STRUCTS = exports.NOT_SUPPORTED = void 0;
exports.NOT_SUPPORTED = [
    "nullable",
    "discriminator",
    "readOnly",
    "writeOnly",
    "xml",
    "externalDocs",
    "example",
    "deprecated",
];
exports.STRUCTS = ["allOf", "anyOf", "oneOf", "not", "items", "additionalProperties"];
// Valid JSON schema v4 formats
exports.VALID_OPENAPI_FORMATS = ["date-time", "email", "hostname", "ipv4", "ipv6", "uri", "uri-reference"];
//# sourceMappingURL=consts.js.map