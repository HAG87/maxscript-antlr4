import
	{
		BailErrorStrategy, CharStream, CommonTokenStream, DefaultErrorStrategy,
		ParseCancellationException, ParseTree, PredictionMode,
	} from 'antlr4ng';
import * as fs from 'fs';
import * as util from 'util';

import { ContextErrorListener } from './parser/contextErrorListener';
import { mxsLexer } from './parser/mxsLexer';
import { mxsParser } from './parser/mxsParser';
import { mxsParserListener } from './parser/mxsParserListener';
import
	{
		codeBlock, mxsParserVisitorFormatter,
	} from './parser/mxsParserVisitorFormatter';
import { minOptions, prettyOptions } from './settings';
import { IDiagnosticEntry } from './types';

// import { mxsParserBase } from "./parser/mxsParserBase";
// import { mxsParserListener } from "./parser/mxsParserListener";

//----------------------------------------------------------
function prettyFormat(tree: ParseTree, parser: mxsParser): string
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
//---------------------------------------------------------- parser
function parse(source: string, listener?: mxsParserListener): { tree: ParseTree, diagnostics: IDiagnosticEntry[] }
{
	// Imput stream
	const inputStream = CharStream.fromString(source)
	// Create the lexer and parser
	const lexer = new mxsLexer(inputStream); // new mxsLexer(CharStream.fromString(''))
	// token stream
	const tokenStream = new CommonTokenStream(lexer); // new MultiChannelTokenStream(lexer);
	// parser
	const parser = new mxsParser(tokenStream)
	// parser options
	// parser.setTrace(true);
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
	// this sets the listener to work in parallel with the parsing. this could get results earlier...
	if (listener) {
		parser.addParseListener(listener); // ----> some method like listener.get()
		/*
			parser.myProgramStart().enterRule(listener);    // myProgramStart is your grammar rule to parse
			// what we had built?
			MyProgram myProgramInstance = listener.getMyProgram();    // in your listener implementation populate a MyProgram instance
			System.out.println(myProgramInstance.toString());
		*/
	}
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
	return { tree, diagnostics }
}
//----------------------------------------------------------
function minify(tree: ParseTree): string | undefined
{
	const visitor = new mxsParserVisitorFormatter(minOptions);
	const result = visitor.visit(tree);
	if (!Array.isArray(result) && result instanceof codeBlock) {
		return result.toString(minOptions)
	}
	return;
}
function prettify(tree: ParseTree)
{
	const visitor = new mxsParserVisitorFormatter(prettyOptions);
	const result = visitor.visit(tree);
	if (!Array.isArray(result) && result instanceof codeBlock) {
		return result.toString(prettyOptions)
	}
	return;
}
//----------------------------------------------------------Test source
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
function test(source: string)
{
	const { tree, diagnostics } = parse(source); //parse(str, listener)
	if (diagnostics.length > 0) {
		console.log(diagnostics);
		console.log('--------------------------------');
	}
	//---------------------------------------------------------- results
	if (tree && tree.getChildCount() > 0) {
		// console.log(util.inspect(tree, {showHidden: false, depth: null, colors: true}))
		console.log('--------------------------------');
		// console.log(minify(tree));
		console.log(prettify(tree))
	}
}
//----------------------------------------------------------
test(fs.readFileSync('./test/input.ms', 'utf-8'))
//----------------------------------------------------------listener
// const listener = new mxsParserSymbolsListener();
// ParseTreeWalker.DEFAULT.walk(listener, tree);
// let treeWalker = new ParseTreeWalker();  treeWalker.walk(listener, tree);
//----------------------------------------------------------
function testGroup()
{
	for (let file of test_files) {
		// console.log(file)
		// /*
		console.log('--------------------------------');
		let str = fs.readFileSync(file, 'utf-8')
		const { tree, diagnostics } = parse(str);
		if (diagnostics.length > 0) {
			console.log(diagnostics);
			console.log('--------------------------------');
		}
		if (tree && tree.getChildCount() > 0) {
			console.log(minify(tree))
			// console.log(prettify(tree))
		}
		// */
	}
}
// testGroup();
//----------------------------------------------------------
