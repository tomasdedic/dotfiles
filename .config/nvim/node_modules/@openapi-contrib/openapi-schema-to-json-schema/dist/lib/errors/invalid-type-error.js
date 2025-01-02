"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class InvalidTypeError extends Error {
    constructor(message) {
        super(message);
        this.name = "InvalidTypeError";
        this.message = message;
    }
}
exports.default = InvalidTypeError;
//# sourceMappingURL=invalid-type-error.js.map