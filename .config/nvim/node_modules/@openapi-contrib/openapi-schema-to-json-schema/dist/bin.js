#!/usr/bin/env node
"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const yargs_1 = __importDefault(require("yargs"));
const helpers_1 = require("yargs/helpers");
const index_js_1 = require("./index.js");
const promises_1 = __importDefault(require("fs/promises"));
const process = __importStar(require("process"));
const args = (0, yargs_1.default)((0, helpers_1.hideBin)(process.argv))
    .options({
    input: { type: "string", alias: "f", demandOption: true },
    output: { type: "string", alias: "o" },
})
    .parseSync();
const { input, output } = args;
const getFileContents = async () => {
    try {
        const fileContents = await promises_1.default.readFile(input, "utf-8");
        return JSON.parse(fileContents);
    }
    catch (e) {
        console.error(`Error: ${e.message}`);
        process.exit(1);
    }
};
(async () => {
    try {
        const fileContents = await getFileContents();
        const convertedSchema = await (0, index_js_1.openapiSchemaToJsonSchema)(fileContents);
        const outputFile = output || input.replace(/\.json$/, "-converted.json");
        await promises_1.default.writeFile(outputFile, JSON.stringify(convertedSchema, null, 2));
    }
    catch (e) {
        console.error(`Error: ${e.message}`);
    }
})();
//# sourceMappingURL=bin.js.map