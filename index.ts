import { CharStream, CommonTokenStream } from "antlr4ng";

import { DiagnosticErrorListener } from "antlr4ng";
import { Lexer } from "antlr4ng";
import { Parser } from "antlr4ng";
import { ParserRuleContext } from "antlr4ng";
import { ParseTree } from "antlr4ng";
import { ParseTreeListener } from "antlr4ng";
import { ParseTreeWalker } from "antlr4ng";
// import {  RuleTagToken  } from "antlr4ng";

import { mxsParser } from "./parser/mxsParser";
// import { mxsParserBase } from "./parser/mxsParserBase";
import { mxsLexer } from "./parser/mxsLexer";

// import { TypeScriptParserBase } from "../TypeScript/TypeScriptParserBase";

// Create the lexer and parser
let inputStream = CharStream.fromString('if hola == true then print 123');
let lexer = new mxsLexer(inputStream);

let tokenStream = new CommonTokenStream(lexer);
// let parser = new mxsParserBase(tokenStream);
let parser = new mxsParser(tokenStream);

let tree = parser.program();

console.log(tree);