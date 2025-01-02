declare class InvalidInputError extends Error {
    message: string;
    name: string;
    constructor(message: string);
}
export default InvalidInputError;
