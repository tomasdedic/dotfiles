import type { OptionsInternal } from "../../openapi-schema-types";
import type { ParameterObject } from "openapi-typescript/src/types";
import type { ResponseObject } from "openapi-typescript/src/types";
import type { JSONSchema4 } from "json-schema";
declare const convertFromParameter: (parameter: ParameterObject | ResponseObject, options: OptionsInternal) => JSONSchema4;
export default convertFromParameter;
