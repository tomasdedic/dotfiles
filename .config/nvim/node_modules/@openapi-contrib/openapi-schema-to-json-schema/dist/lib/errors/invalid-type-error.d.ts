declare class InvalidTypeError extends Error {
    message: string;
    name: string;
    constructor(message: string);
}
export default InvalidTypeError;
