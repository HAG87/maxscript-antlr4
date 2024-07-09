import * as fs from "fs";
import * as path from "path";

import {
    CharStream,
    CommonTokenStream,
    DefaultErrorStrategy,
    BailErrorStrategy,
    PredictionMode,
    ParseCancellationException,
    RecognitionException,
    // DiagnosticErrorListener,
    // Lexer,
    // Parser,
    // ParserRuleContext,
    ParseTree,
    ParseTreeListener,
    ParseTreeWalker,
    // RuleTagToken
} from "antlr4ng";

let str:string = fs.readFileSync('./test/samples/input.ms', 'utf-8');

// import { mxsParserBase } from "./parser/mxsParserBase";
import { mxsParser } from "./parser/mxsParser";
import { mxsLexer } from "./parser/mxsLexer";

import { mxsParserVisitor } from "./parser/mxsParserVisitor";
import { mxsParserSymbolsListener } from "./parser/mxsParserSymbolsListener";
import MultiChannelTokenStream from "./parser/multiChannelTokenStream";
// import { mxsParserListener } from "./parser/mxsParserListener";

// imput stream
// const inputStream = CharStream.fromString('for t in 0f to 100f by 5f do sliderTime=t');
const inputStream = CharStream.fromString(str);
// Create the lexer and parser
const lexer       = new mxsLexer(inputStream);
// const tokenStream = new CommonTokenStream(lexer);
const tokenStream = new MultiChannelTokenStream(lexer);
const parser      = new mxsParser(tokenStream);
// let parser = new mxsParserBase(tokenStream);

// error handling strategy
parser.errorHandler = new BailErrorStrategy();
parser.interpreter.predictionMode = PredictionMode.SLL;
// parser.interpreter.predictionMode = PredictionMode.LL;

// AST tree
let tree;

// Two stages parsing strategy
try {
    tree = parser.program();    
} catch (e:any) {
  console.log(e.message);
  /*
    if (e instanceof ParseCancellationException) {
        lexer.reset();
        tokenStream.setTokenSource(lexer);
        parser.reset();
        parser.errorHandler = new DefaultErrorStrategy();
        parser.interpreter.predictionMode = PredictionMode.LL;
        tree = parser.program();
    } else {
        throw e;
    }
        */
}

if (tree && tree.getChildCount() > 0) {
  // console.log(tree.toStringTree(parser));
    
    // console.log(tree);
    let listener = new mxsParserSymbolsListener();
    
    ParseTreeWalker.DEFAULT.walk(listener, tree);
}


/*
//  You can then use the generated parser to walk the parse tree, for example with a visitor to evaluate the expression:

import { ExpressionVisitor } from "./generated/ExpressionVisitor.js";

class MyVisitor extends ExpressionVisitor<number> {
  public visitAdd = (ctx: AddContext): number {
    return this.visit(ctx.expression(0)) + this.visit(ctx.expression(1));
  }

  public visitMultiply = (ctx: MultiplyContext): number {
    return this.visit(ctx.expression(0)) * this.visit(ctx.expression(1));
  }

  public visitNumber = (ctx: NumberContext): number {
    return Number.parseInt(ctx.NUMBER().text);
  }
}

const visitor = new MyVisitor();
const result = visitor.visit(tree);
*/