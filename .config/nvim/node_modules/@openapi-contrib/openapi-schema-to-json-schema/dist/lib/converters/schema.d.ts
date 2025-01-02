import type { OptionsInternal } from "../../openapi-schema-types";
import type { JSONSchema4 } from "json-schema";
import type { AcceptibleInputSchema } from "../../openapi-schema-types";
declare function convertFromSchema<T extends AcceptibleInputSchema = AcceptibleInputSchema>(schema: T, options: OptionsInternal): JSONSchema4;
export default convertFromSchema;
