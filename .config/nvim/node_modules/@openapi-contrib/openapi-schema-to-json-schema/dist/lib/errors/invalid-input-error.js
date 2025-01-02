"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class InvalidInputError extends Error {
    constructor(message) {
        super(message);
        this.name = "InvalidInputError";
        this.message = message;
    }
}
exports.default = InvalidInputError;
//# sourceMappingURL=invalid-input-error.js.map