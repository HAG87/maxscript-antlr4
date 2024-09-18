import
  {
    BailErrorStrategy, CharStream, CommonTokenStream, DefaultErrorStrategy,
    ParseCancellationException, ParseTree, PredictionMode,
  } from 'antlr4ng';
import * as fs from 'fs';

import { ContextErrorListener } from './parser/contextErrorListener';
import { mxsLexer } from './parser/mxsLexer';
import { mxsParser } from './parser/mxsParser';
import { mxsParserSymbolsListener } from './parser/mxsParserSymbolsListener';
import
  {
    codeBlock, mxsParserVisitorFormatter,
  } from './parser/mxsParserVisitorFormatter';
import { minOptions } from './settings';
import { IDiagnosticEntry } from './types';

// import { mxsParserBase } from "./parser/mxsParserBase";
// import { mxsParserListener } from "./parser/mxsParserListener";

//----------------------------------------------------------
function prettyFormat(tree: ParseTree): string
{
  let vocab: string[] = parser.vocabulary.getSymbolicNames().filter(n => n !== null)

  let treestring = tree.toStringTree(vocab, parser)
  let resultString = ''
  let indent = 0
  const indentChars = '  '

  for (let i = 0; i < treestring.length; i++) {
    let curr = treestring[i]

    if (curr !== '(' && curr !== ')') {
      resultString += curr
    }

    if (curr === '(') {
      indent++
      resultString += '\n\r' + indentChars.repeat(indent)

    } else if (curr === ')') {
      indent--
      // resultString += '\n\r' + indentChars.repeat(indent);
    }
    // resultString += indentChars.repeat(indent);
  }
  return resultString
}
//----------------------------------------------------------
const test_files = [
  './test/samples/attributes-def.ms', //ok
  './test/samples/change-handler.ms', //ok
  './test/samples/context-expr.ms', //ok
  './test/samples/macroscript-def.ms', //ok
  './test/samples/plugin-def.ms', //ok
  './test/samples/rollout-util-def.ms', //ok
  './test/samples/simple-expr.ms', //ok
  './test/samples/structure-def.ms', //ok
  './test/samples/tool-def.ms', //ok
  './test/samples/fn-def.ms', //ok
]
//----------------------------------------------------------Test source
let str: string = fs.readFileSync('./test/input.ms', 'utf-8')
// let str:string = fs.readFileSync(test_files[9], 'utf-8');
//---------------------------------------------------------- parser
// Imput stream
const inputStream = CharStream.fromString(str)
// Create the lexer and parser
const lexer = new mxsLexer(inputStream); // new mxsLexer(CharStream.fromString(''))
// token stream
const tokenStream = new CommonTokenStream(lexer); // new MultiChannelTokenStream(lexer);
// parser
const parser = new mxsParser(tokenStream)
// error handling strategy
parser.errorHandler = new BailErrorStrategy()
// set initial prediction mode
parser.interpreter.predictionMode = PredictionMode.SLL
// diagnostics
let diagnostics: IDiagnosticEntry[] = []
let errorListener: ContextErrorListener = new ContextErrorListener(diagnostics)
parser.removeErrorListeners()
parser.addErrorListener(errorListener)
/*
// re-feed the parser
lexer.inputStream = inputStream
lexer.reset()
tokenStream.setTokenSource(lexer)
parser.reset()
// */

//---------------------------------------------------------- parser options
// parser.setTrace(true);
//----------------------------------------------------------listeners
const listener = new mxsParserSymbolsListener();
// this sets the listener to work in parallel with the parsing. this could get results earlier...
// parser.addParseListener(listener); // ----> some method like listener.get()
/*
  MyProgramListener listener = new MyProgramListener();   // your custom extension from BaseListener
  parser.addParseListener(listener);
  parser.myProgramStart().enterRule(listener);    // myProgramStart is your grammar rule to parse

  // what we had built?
  MyProgram myProgramInstance = listener.getMyProgram();    // in your listener implementation populate a MyProgram instance
  System.out.println(myProgramInstance.toString());
*/
//----------------------------------------------------------AST tree
let tree: ParseTree
//----------------------------------------------------------two-stages parsing strategy
try {
  tree = parser.program(); //parser.program().enterRule(listener);    
} catch (e: any) {
  console.log(`----- ERROR: use LL -----`)
  if (e instanceof ParseCancellationException) {
    lexer.reset()
    tokenStream.setTokenSource(lexer)
    parser.reset()
    parser.errorHandler = new DefaultErrorStrategy()
    parser.interpreter.predictionMode = PredictionMode.LL
    tree = parser.program()
  } else {
    throw e
  }
}
//----------------------------------------------------------
if (diagnostics.length > 0) {
  console.log(diagnostics);
}
//---------------------------------------------------------- results
if (tree && tree.getChildCount() > 0) {
  // console.log(prettyFormat(tree));
  //---------------------------------------------------------- tree walker
  // ParseTreeWalker.DEFAULT.walk(listener, tree);
  // let treeWalker = new ParseTreeWalker();
  // treeWalker.walk(listener, tree);
  //---------------------------------------------------------- formatter
  // /*
  // const activeOptions = prettyOptions
  const activeOptions = minOptions
  // minifier using visitor pattern
  const visitor = new mxsParserVisitorFormatter(activeOptions);
  const result = visitor.visit(tree);
  // console.log(util.inspect(result, false, null, true /* enable colors */))
  if (!Array.isArray(result) && result instanceof codeBlock) {
    console.log('--------------------------------');
    // result.toString(activeOptions)
    console.log(result.toString(activeOptions))
    console.log('--------------------------------');
  }
  // */
}