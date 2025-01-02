import convertFromSchema from "./converters/schema";
export declare const fromSchema: typeof convertFromSchema;
export declare const fromParameter: (parameter: import("openapi-typescript/src/types").ParameterObject | import("openapi-typescript/src/types").ResponseObject, options: import("../openapi-schema-types").OptionsInternal) => import("json-schema").JSONSchema4;
declare const _default: {
    fromSchema: typeof convertFromSchema;
    fromParameter: (parameter: import("openapi-typescript/src/types").ParameterObject | import("openapi-typescript/src/types").ResponseObject, options: import("../openapi-schema-types").OptionsInternal) => import("json-schema").JSONSchema4;
};
export default _default;
