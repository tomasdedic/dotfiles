import type { Options } from "./openapi-schema-types";
import type { JSONSchema4 } from "json-schema";
import type { ParameterObject, ResponseObject } from "openapi-typescript/src/types";
import type { AcceptibleInputSchema } from "./openapi-schema-types";
declare const openapiSchemaToJsonSchema: <T extends AcceptibleInputSchema = AcceptibleInputSchema>(schema: T, options?: Options) => JSONSchema4;
declare const openapiParameterToJsonSchema: (parameter: ParameterObject | ResponseObject, options?: Options) => JSONSchema4;
export { openapiParameterToJsonSchema as fromParameter, openapiSchemaToJsonSchema as fromSchema, openapiSchemaToJsonSchema, };
export default openapiSchemaToJsonSchema;
