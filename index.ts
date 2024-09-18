import
  {
    BailErrorStrategy, CharStream, CommonTokenStream, DefaultErrorStrategy,
    ParseCancellationException, ParseTree, PredictionMode,
  } from 'antlr4ng';
import * as fs from 'fs';

// import { mxsParserBase } from "./parser/mxsParserBase";
import { ContextErrorListener } from './parser/contextErrorListener';
import { mxsLexer } from './parser/mxsLexer';
import { mxsParser } from './parser/mxsParser';
import { mxsParserSymbolsListener } from './parser/mxsParserSymbolsListener';
import
  {
    codeBlock, mxsParserVisitorFormatter, prettyOptions,
  } from './parser/mxsParserVisitorFormatter';
import { IDiagnosticEntry } from './types';

// import { mxsParserListener } from "./parser/mxsParserListener";

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

let str: string = fs.readFileSync('./test/input.ms', 'utf-8')
// let str:string = fs.readFileSync(test_files[9], 'utf-8');

// imput stream
// const inputStream = CharStream.fromString('for t in 0f to 100f by 5f do sliderTime=t');
const inputStream = CharStream.fromString(str)

// Create the lexer and parser
const lexer = new mxsLexer(CharStream.fromString(''))
// const lexer       = new mxsLexerBase(inputStream);
const tokenStream = new CommonTokenStream(lexer)
// const tokenStream = new MultiChannelTokenStream(lexer);
const parser = new mxsParser(tokenStream)

let diagnostics: IDiagnosticEntry[] = []
let errorListener: ContextErrorListener = new ContextErrorListener(diagnostics)
parser.removeErrorListeners()
parser.addErrorListener(errorListener)

lexer.inputStream = inputStream
lexer.reset()
tokenStream.setTokenSource(lexer)
parser.reset()

// tokenStream.fill();
// /*



// parser.setTrace(true);

// error handling strategy
parser.errorHandler = new BailErrorStrategy()
// parser.addErrorListener(new DiagnosticErrorListener());
// parser.interpreter.predictionMode = PredictionMode.LL_EXACT_AMBIG_DETECTION;
parser.interpreter.predictionMode = PredictionMode.SLL
// parser.interpreter.predictionMode = PredictionMode.LL;


const listener = new mxsParserSymbolsListener();

// parser.addParseListener(listener); // ----> some method like listener.get()

// AST tree
let tree: ParseTree

// Two stages parsing strategy
try {
  tree = parser.program()
  // tree = parser.program().enterRule(listener);    
} catch (e: any) {
  // console.log(`ERROR: ${e.message}`);
  console.log(`ERROR: use LL -----`)

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
// console.log(diagnostics);

if (tree && tree.getChildCount() > 0) {
  /*
  let vocab: string[] = parser.vocabulary.getSymbolicNames().filter(n => n !== null)

  let treestring = tree.toStringTree(vocab, parser)
  // console.log(treestring);

  let resultString = ''
  let indent = 0
  const indentChars = '  '

  for (let i = 0; i < treestring.length; i++) {
    let curr = treestring[i]

    if (curr !== '(' && curr !== ')') {
      resultString = resultString + curr
    }

    if (curr === '(') {
      indent++
      resultString = resultString + '\n\r' + indentChars.repeat(indent)

    } else if (curr === ')') {
      indent--
      // resultString = resultString + '\n\r' + indentChars.repeat(indent);
    }
    // resultString = resultString + indentChars.repeat(indent);
  }
  // */

  // ParseTreeWalker.DEFAULT.walk(listener, tree);
  // let treeWalker = new ParseTreeWalker();
  // treeWalker.walk(listener, tree);

  // /*
  const activeOptions = prettyOptions
  // minifier using visitor pattern
  const visitor = new mxsParserVisitorFormatter(activeOptions);
  const result = visitor.visit(tree);
  // console.log('--------------------------------');
  // console.log(util.inspect(result, false, null, true /* enable colors */))
  console.log('--------------------------------');
  if (!Array.isArray(result) && result instanceof codeBlock) {
    result.toString(activeOptions)
    // console.log(result.toString())
  }

  // console.log(result);
  // console.log(JSON.stringify(result));
  // console.log(JSON.stringify(result, null, 1));
  // */
}

/*
MyProgramListener listener = new MyProgramListener();   // your custom extension from BaseListener
        parser.addParseListener(listener);
        parser.myProgramStart().enterRule(listener);    // myProgramStart is your grammar rule to parse

        // what we had built?
        MyProgram myProgramInstance = listener.getMyProgram();    // in your listener implementation populate a MyProgram instance
        System.out.println(myProgramInstance.toString());
*/

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
/*
CommonTokenStream cts = new CommonTokenStream(tokenSource, 2);
List<Token> tokens = new ArrayList<Token>();
while (cts.LA(1) != EOF) {
    tokens.add(cts.LT(1));
    cts.consume();
}
*/