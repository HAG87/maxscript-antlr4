// Generated from e:\repos\maxscript-antlr4\grammar\mxsParser.g4 by ANTLR 4.9.2
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class mxsParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.9.2", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		AND=1, AS=2, AT=3, BY=4, CASE=5, CATCH=6, COLLECT=7, CONTINUE=8, DO=9, 
		DONTCOLLECT=10, ELSE=11, EXIT=12, FOR=13, FROM=14, GLOBAL=15, IF=16, IN=17, 
		LOCAL=18, OF=19, ON=20, OR=21, RETURN=22, SET=23, THEN=24, THROW=25, TO=26, 
		TRY=27, WHEN=28, WHERE=29, WHILE=30, WITH=31, NOT=32, RoloutControl=33, 
		FN=34, MAPPED=35, STRUCT=36, VOID=37, BOOL=38, OBJECTSET=39, ASSIGN=40, 
		PLUS=41, MINUS=42, PROD=43, DIV=44, POW=45, COMPARE=46, SHARP=47, COMMA=48, 
		SEMI=49, DOT=50, LPAREN=51, RPAREN=52, LCURLY=53, RCURLY=54, LBRACE=55, 
		RBRACE=56, DOLLAR=57, UNDERSCORE=58, QUESTION=59, BACKSLASH=60, INT=61, 
		DEG=62, HEX=63, NAME=64, ALPHANUM=65, EOL=66, WS=67, COMMENT=68, LINE_COMMENT=69;
	public static final int
		RULE_program = 0, RULE_stat = 1, RULE_def = 2, RULE_expr = 3, RULE_simple_expr = 4, 
		RULE_assignment = 5, RULE_destination = 6, RULE_mathExpr = 7, RULE_logicExpr = 8, 
		RULE_logical_operand = 9, RULE_compareExpr = 10, RULE_compare_operand = 11, 
		RULE_operand = 12, RULE_propertyOrIndex = 13, RULE_property = 14, RULE_index = 15, 
		RULE_factor = 16, RULE_expr_seq = 17, RULE_box2 = 18, RULE_point3 = 19, 
		RULE_point2 = 20, RULE_bitArray = 21, RULE_bitList = 22, RULE_array = 23, 
		RULE_elementList = 24, RULE_var_name = 25, RULE_name_value = 26, RULE_path = 27, 
		RULE_path_name = 28, RULE_levels = 29, RULE_level_name = 30, RULE_bool = 31, 
		RULE_number = 32;
	private static String[] makeRuleNames() {
		return new String[] {
			"program", "stat", "def", "expr", "simple_expr", "assignment", "destination", 
			"mathExpr", "logicExpr", "logical_operand", "compareExpr", "compare_operand", 
			"operand", "propertyOrIndex", "property", "index", "factor", "expr_seq", 
			"box2", "point3", "point2", "bitArray", "bitList", "array", "elementList", 
			"var_name", "name_value", "path", "path_name", "levels", "level_name", 
			"bool", "number"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'and'", "'as'", "'at'", "'by'", "'case'", "'catch'", "'collect'", 
			"'continue'", "'do'", "'dontcollect'", "'else'", "'exit'", "'for'", "'from'", 
			"'global'", "'if'", "'in'", "'local'", "'of'", "'on'", "'or'", "'return'", 
			"'set'", "'then'", "'throw'", "'to'", "'try'", "'when'", "'where'", "'while'", 
			"'with'", "'not'", null, null, "'mapped'", "'struct'", null, null, null, 
			null, "'+'", "'-'", "'*'", "'/'", "'^'", null, "'#'", "','", "';'", "'.'", 
			"'('", "')'", "'{'", "'}'", "'['", "']'", "'$'", "'_'", "'?'", "'\\'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "AND", "AS", "AT", "BY", "CASE", "CATCH", "COLLECT", "CONTINUE", 
			"DO", "DONTCOLLECT", "ELSE", "EXIT", "FOR", "FROM", "GLOBAL", "IF", "IN", 
			"LOCAL", "OF", "ON", "OR", "RETURN", "SET", "THEN", "THROW", "TO", "TRY", 
			"WHEN", "WHERE", "WHILE", "WITH", "NOT", "RoloutControl", "FN", "MAPPED", 
			"STRUCT", "VOID", "BOOL", "OBJECTSET", "ASSIGN", "PLUS", "MINUS", "PROD", 
			"DIV", "POW", "COMPARE", "SHARP", "COMMA", "SEMI", "DOT", "LPAREN", "RPAREN", 
			"LCURLY", "RCURLY", "LBRACE", "RBRACE", "DOLLAR", "UNDERSCORE", "QUESTION", 
			"BACKSLASH", "INT", "DEG", "HEX", "NAME", "ALPHANUM", "EOL", "WS", "COMMENT", 
			"LINE_COMMENT"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "mxsParser.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public mxsParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class ProgramContext extends ParserRuleContext {
		public TerminalNode EOF() { return getToken(mxsParser.EOF, 0); }
		public List<StatContext> stat() {
			return getRuleContexts(StatContext.class);
		}
		public StatContext stat(int i) {
			return getRuleContext(StatContext.class,i);
		}
		public ProgramContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_program; }
	}

	public final ProgramContext program() throws RecognitionException {
		ProgramContext _localctx = new ProgramContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_program);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(67); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(66);
				stat();
				}
				}
				setState(69); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( ((((_la - 20)) & ~0x3f) == 0 && ((1L << (_la - 20)) & ((1L << (ON - 20)) | (1L << (NOT - 20)) | (1L << (BOOL - 20)) | (1L << (MINUS - 20)) | (1L << (SHARP - 20)) | (1L << (LPAREN - 20)) | (1L << (LBRACE - 20)) | (1L << (DOLLAR - 20)) | (1L << (QUESTION - 20)) | (1L << (INT - 20)) | (1L << (DEG - 20)) | (1L << (HEX - 20)) | (1L << (NAME - 20)) | (1L << (ALPHANUM - 20)))) != 0) );
			setState(71);
			match(EOF);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatContext extends ParserRuleContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public TerminalNode EOL() { return getToken(mxsParser.EOL, 0); }
		public StatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_stat; }
	}

	public final StatContext stat() throws RecognitionException {
		StatContext _localctx = new StatContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_stat);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(73);
			expr();
			setState(74);
			match(EOL);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class DefContext extends ParserRuleContext {
		public List<TerminalNode> ALPHANUM() { return getTokens(mxsParser.ALPHANUM); }
		public TerminalNode ALPHANUM(int i) {
			return getToken(mxsParser.ALPHANUM, i);
		}
		public TerminalNode LPAREN() { return getToken(mxsParser.LPAREN, 0); }
		public TerminalNode RPAREN() { return getToken(mxsParser.RPAREN, 0); }
		public TerminalNode LCURLY() { return getToken(mxsParser.LCURLY, 0); }
		public TerminalNode RCURLY() { return getToken(mxsParser.RCURLY, 0); }
		public List<TerminalNode> COMMA() { return getTokens(mxsParser.COMMA); }
		public TerminalNode COMMA(int i) {
			return getToken(mxsParser.COMMA, i);
		}
		public List<StatContext> stat() {
			return getRuleContexts(StatContext.class);
		}
		public StatContext stat(int i) {
			return getRuleContext(StatContext.class,i);
		}
		public DefContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_def; }
	}

	public final DefContext def() throws RecognitionException {
		DefContext _localctx = new DefContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_def);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(76);
			match(ALPHANUM);
			setState(77);
			match(LPAREN);
			setState(78);
			match(ALPHANUM);
			setState(83);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==COMMA) {
				{
				{
				setState(79);
				match(COMMA);
				setState(80);
				match(ALPHANUM);
				}
				}
				setState(85);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(86);
			match(RPAREN);
			setState(87);
			match(LCURLY);
			setState(91);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (((((_la - 20)) & ~0x3f) == 0 && ((1L << (_la - 20)) & ((1L << (ON - 20)) | (1L << (NOT - 20)) | (1L << (BOOL - 20)) | (1L << (MINUS - 20)) | (1L << (SHARP - 20)) | (1L << (LPAREN - 20)) | (1L << (LBRACE - 20)) | (1L << (DOLLAR - 20)) | (1L << (QUESTION - 20)) | (1L << (INT - 20)) | (1L << (DEG - 20)) | (1L << (HEX - 20)) | (1L << (NAME - 20)) | (1L << (ALPHANUM - 20)))) != 0)) {
				{
				{
				setState(88);
				stat();
				}
				}
				setState(93);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(94);
			match(RCURLY);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExprContext extends ParserRuleContext {
		public Simple_exprContext simple_expr() {
			return getRuleContext(Simple_exprContext.class,0);
		}
		public AssignmentContext assignment() {
			return getRuleContext(AssignmentContext.class,0);
		}
		public ExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr; }
	}

	public final ExprContext expr() throws RecognitionException {
		ExprContext _localctx = new ExprContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_expr);
		try {
			setState(98);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,3,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(96);
				simple_expr();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(97);
				assignment();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Simple_exprContext extends ParserRuleContext {
		public OperandContext operand() {
			return getRuleContext(OperandContext.class,0);
		}
		public MathExprContext mathExpr() {
			return getRuleContext(MathExprContext.class,0);
		}
		public CompareExprContext compareExpr() {
			return getRuleContext(CompareExprContext.class,0);
		}
		public LogicExprContext logicExpr() {
			return getRuleContext(LogicExprContext.class,0);
		}
		public Simple_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_simple_expr; }
	}

	public final Simple_exprContext simple_expr() throws RecognitionException {
		Simple_exprContext _localctx = new Simple_exprContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_simple_expr);
		try {
			setState(104);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,4,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(100);
				operand();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(101);
				mathExpr(0);
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(102);
				compareExpr();
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(103);
				logicExpr(0);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssignmentContext extends ParserRuleContext {
		public DestinationContext destination() {
			return getRuleContext(DestinationContext.class,0);
		}
		public TerminalNode ASSIGN() { return getToken(mxsParser.ASSIGN, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public AssignmentContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assignment; }
	}

	public final AssignmentContext assignment() throws RecognitionException {
		AssignmentContext _localctx = new AssignmentContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_assignment);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(106);
			destination();
			setState(107);
			match(ASSIGN);
			setState(108);
			expr();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class DestinationContext extends ParserRuleContext {
		public Var_nameContext var_name() {
			return getRuleContext(Var_nameContext.class,0);
		}
		public PropertyOrIndexContext propertyOrIndex() {
			return getRuleContext(PropertyOrIndexContext.class,0);
		}
		public DestinationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_destination; }
	}

	public final DestinationContext destination() throws RecognitionException {
		DestinationContext _localctx = new DestinationContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_destination);
		try {
			setState(112);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,5,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(110);
				var_name();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(111);
				propertyOrIndex(0);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class MathExprContext extends ParserRuleContext {
		public OperandContext operand() {
			return getRuleContext(OperandContext.class,0);
		}
		public List<MathExprContext> mathExpr() {
			return getRuleContexts(MathExprContext.class);
		}
		public MathExprContext mathExpr(int i) {
			return getRuleContext(MathExprContext.class,i);
		}
		public TerminalNode POW() { return getToken(mxsParser.POW, 0); }
		public TerminalNode PROD() { return getToken(mxsParser.PROD, 0); }
		public TerminalNode DIV() { return getToken(mxsParser.DIV, 0); }
		public TerminalNode PLUS() { return getToken(mxsParser.PLUS, 0); }
		public TerminalNode MINUS() { return getToken(mxsParser.MINUS, 0); }
		public MathExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_mathExpr; }
	}

	public final MathExprContext mathExpr() throws RecognitionException {
		return mathExpr(0);
	}

	private MathExprContext mathExpr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		MathExprContext _localctx = new MathExprContext(_ctx, _parentState);
		MathExprContext _prevctx = _localctx;
		int _startState = 14;
		enterRecursionRule(_localctx, 14, RULE_mathExpr, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(115);
			operand();
			}
			_ctx.stop = _input.LT(-1);
			setState(134);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,7,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(132);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,6,_ctx) ) {
					case 1:
						{
						_localctx = new MathExprContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_mathExpr);
						setState(117);
						if (!(precpred(_ctx, 5))) throw new FailedPredicateException(this, "precpred(_ctx, 5)");
						setState(118);
						match(POW);
						setState(119);
						mathExpr(5);
						}
						break;
					case 2:
						{
						_localctx = new MathExprContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_mathExpr);
						setState(120);
						if (!(precpred(_ctx, 4))) throw new FailedPredicateException(this, "precpred(_ctx, 4)");
						setState(121);
						match(PROD);
						setState(122);
						mathExpr(5);
						}
						break;
					case 3:
						{
						_localctx = new MathExprContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_mathExpr);
						setState(123);
						if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
						setState(124);
						match(DIV);
						setState(125);
						mathExpr(4);
						}
						break;
					case 4:
						{
						_localctx = new MathExprContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_mathExpr);
						setState(126);
						if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
						setState(127);
						match(PLUS);
						setState(128);
						mathExpr(3);
						}
						break;
					case 5:
						{
						_localctx = new MathExprContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_mathExpr);
						setState(129);
						if (!(precpred(_ctx, 1))) throw new FailedPredicateException(this, "precpred(_ctx, 1)");
						setState(130);
						match(MINUS);
						setState(131);
						mathExpr(2);
						}
						break;
					}
					} 
				}
				setState(136);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,7,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class LogicExprContext extends ParserRuleContext {
		public TerminalNode NOT() { return getToken(mxsParser.NOT, 0); }
		public Logical_operandContext logical_operand() {
			return getRuleContext(Logical_operandContext.class,0);
		}
		public List<LogicExprContext> logicExpr() {
			return getRuleContexts(LogicExprContext.class);
		}
		public LogicExprContext logicExpr(int i) {
			return getRuleContext(LogicExprContext.class,i);
		}
		public TerminalNode AND() { return getToken(mxsParser.AND, 0); }
		public TerminalNode OR() { return getToken(mxsParser.OR, 0); }
		public LogicExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_logicExpr; }
	}

	public final LogicExprContext logicExpr() throws RecognitionException {
		return logicExpr(0);
	}

	private LogicExprContext logicExpr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		LogicExprContext _localctx = new LogicExprContext(_ctx, _parentState);
		LogicExprContext _prevctx = _localctx;
		int _startState = 16;
		enterRecursionRule(_localctx, 16, RULE_logicExpr, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(141);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case NOT:
				{
				setState(138);
				match(NOT);
				setState(139);
				logical_operand();
				}
				break;
			case ON:
			case BOOL:
			case MINUS:
			case SHARP:
			case LPAREN:
			case LBRACE:
			case DOLLAR:
			case QUESTION:
			case INT:
			case DEG:
			case HEX:
			case NAME:
			case ALPHANUM:
				{
				setState(140);
				logical_operand();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			_ctx.stop = _input.LT(-1);
			setState(148);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,9,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new LogicExprContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_logicExpr);
					setState(143);
					if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
					setState(144);
					_la = _input.LA(1);
					if ( !(_la==AND || _la==OR) ) {
					_errHandler.recoverInline(this);
					}
					else {
						if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
						_errHandler.reportMatch(this);
						consume();
					}
					setState(145);
					logicExpr(4);
					}
					} 
				}
				setState(150);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,9,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Logical_operandContext extends ParserRuleContext {
		public OperandContext operand() {
			return getRuleContext(OperandContext.class,0);
		}
		public CompareExprContext compareExpr() {
			return getRuleContext(CompareExprContext.class,0);
		}
		public Logical_operandContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_logical_operand; }
	}

	public final Logical_operandContext logical_operand() throws RecognitionException {
		Logical_operandContext _localctx = new Logical_operandContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_logical_operand);
		try {
			setState(153);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,10,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(151);
				operand();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(152);
				compareExpr();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class CompareExprContext extends ParserRuleContext {
		public List<Compare_operandContext> compare_operand() {
			return getRuleContexts(Compare_operandContext.class);
		}
		public Compare_operandContext compare_operand(int i) {
			return getRuleContext(Compare_operandContext.class,i);
		}
		public TerminalNode COMPARE() { return getToken(mxsParser.COMPARE, 0); }
		public CompareExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_compareExpr; }
	}

	public final CompareExprContext compareExpr() throws RecognitionException {
		CompareExprContext _localctx = new CompareExprContext(_ctx, getState());
		enterRule(_localctx, 20, RULE_compareExpr);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(155);
			compare_operand();
			setState(156);
			match(COMPARE);
			setState(157);
			compare_operand();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Compare_operandContext extends ParserRuleContext {
		public OperandContext operand() {
			return getRuleContext(OperandContext.class,0);
		}
		public MathExprContext mathExpr() {
			return getRuleContext(MathExprContext.class,0);
		}
		public Compare_operandContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_compare_operand; }
	}

	public final Compare_operandContext compare_operand() throws RecognitionException {
		Compare_operandContext _localctx = new Compare_operandContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_compare_operand);
		try {
			setState(161);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,11,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(159);
				operand();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(160);
				mathExpr(0);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class OperandContext extends ParserRuleContext {
		public FactorContext factor() {
			return getRuleContext(FactorContext.class,0);
		}
		public PropertyOrIndexContext propertyOrIndex() {
			return getRuleContext(PropertyOrIndexContext.class,0);
		}
		public OperandContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_operand; }
	}

	public final OperandContext operand() throws RecognitionException {
		OperandContext _localctx = new OperandContext(_ctx, getState());
		enterRule(_localctx, 24, RULE_operand);
		try {
			setState(165);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,12,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(163);
				factor();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(164);
				propertyOrIndex(0);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PropertyOrIndexContext extends ParserRuleContext {
		public PropertyOrIndexContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_propertyOrIndex; }
	 
		public PropertyOrIndexContext() { }
		public void copyFrom(PropertyOrIndexContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class IndexExprContext extends PropertyOrIndexContext {
		public FactorContext factor() {
			return getRuleContext(FactorContext.class,0);
		}
		public IndexContext index() {
			return getRuleContext(IndexContext.class,0);
		}
		public PropertyOrIndexContext propertyOrIndex() {
			return getRuleContext(PropertyOrIndexContext.class,0);
		}
		public IndexExprContext(PropertyOrIndexContext ctx) { copyFrom(ctx); }
	}
	public static class PropertyExprContext extends PropertyOrIndexContext {
		public FactorContext factor() {
			return getRuleContext(FactorContext.class,0);
		}
		public PropertyContext property() {
			return getRuleContext(PropertyContext.class,0);
		}
		public PropertyOrIndexContext propertyOrIndex() {
			return getRuleContext(PropertyOrIndexContext.class,0);
		}
		public PropertyExprContext(PropertyOrIndexContext ctx) { copyFrom(ctx); }
	}

	public final PropertyOrIndexContext propertyOrIndex() throws RecognitionException {
		return propertyOrIndex(0);
	}

	private PropertyOrIndexContext propertyOrIndex(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		PropertyOrIndexContext _localctx = new PropertyOrIndexContext(_ctx, _parentState);
		PropertyOrIndexContext _prevctx = _localctx;
		int _startState = 26;
		enterRecursionRule(_localctx, 26, RULE_propertyOrIndex, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(174);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,13,_ctx) ) {
			case 1:
				{
				_localctx = new PropertyExprContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;

				setState(168);
				factor();
				setState(169);
				property();
				}
				break;
			case 2:
				{
				_localctx = new IndexExprContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(171);
				factor();
				setState(172);
				index();
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(182);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,15,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(180);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,14,_ctx) ) {
					case 1:
						{
						_localctx = new PropertyExprContext(new PropertyOrIndexContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_propertyOrIndex);
						setState(176);
						if (!(precpred(_ctx, 4))) throw new FailedPredicateException(this, "precpred(_ctx, 4)");
						setState(177);
						property();
						}
						break;
					case 2:
						{
						_localctx = new IndexExprContext(new PropertyOrIndexContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_propertyOrIndex);
						setState(178);
						if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
						setState(179);
						index();
						}
						break;
					}
					} 
				}
				setState(184);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,15,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class PropertyContext extends ParserRuleContext {
		public TerminalNode DOT() { return getToken(mxsParser.DOT, 0); }
		public Var_nameContext var_name() {
			return getRuleContext(Var_nameContext.class,0);
		}
		public PropertyContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_property; }
	}

	public final PropertyContext property() throws RecognitionException {
		PropertyContext _localctx = new PropertyContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_property);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(185);
			match(DOT);
			setState(186);
			var_name();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class IndexContext extends ParserRuleContext {
		public TerminalNode LBRACE() { return getToken(mxsParser.LBRACE, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public TerminalNode RBRACE() { return getToken(mxsParser.RBRACE, 0); }
		public IndexContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_index; }
	}

	public final IndexContext index() throws RecognitionException {
		IndexContext _localctx = new IndexContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_index);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(188);
			match(LBRACE);
			setState(189);
			expr();
			setState(190);
			match(RBRACE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FactorContext extends ParserRuleContext {
		public Var_nameContext var_name() {
			return getRuleContext(Var_nameContext.class,0);
		}
		public Name_valueContext name_value() {
			return getRuleContext(Name_valueContext.class,0);
		}
		public PathContext path() {
			return getRuleContext(PathContext.class,0);
		}
		public NumberContext number() {
			return getRuleContext(NumberContext.class,0);
		}
		public BoolContext bool() {
			return getRuleContext(BoolContext.class,0);
		}
		public ArrayContext array() {
			return getRuleContext(ArrayContext.class,0);
		}
		public BitArrayContext bitArray() {
			return getRuleContext(BitArrayContext.class,0);
		}
		public Point3Context point3() {
			return getRuleContext(Point3Context.class,0);
		}
		public Point2Context point2() {
			return getRuleContext(Point2Context.class,0);
		}
		public Box2Context box2() {
			return getRuleContext(Box2Context.class,0);
		}
		public TerminalNode MINUS() { return getToken(mxsParser.MINUS, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public Expr_seqContext expr_seq() {
			return getRuleContext(Expr_seqContext.class,0);
		}
		public TerminalNode QUESTION() { return getToken(mxsParser.QUESTION, 0); }
		public FactorContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_factor; }
	}

	public final FactorContext factor() throws RecognitionException {
		FactorContext _localctx = new FactorContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_factor);
		try {
			setState(206);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,16,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(192);
				var_name();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(193);
				name_value();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(194);
				path();
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(195);
				number();
				}
				break;
			case 5:
				enterOuterAlt(_localctx, 5);
				{
				setState(196);
				bool();
				}
				break;
			case 6:
				enterOuterAlt(_localctx, 6);
				{
				setState(197);
				array();
				}
				break;
			case 7:
				enterOuterAlt(_localctx, 7);
				{
				setState(198);
				bitArray();
				}
				break;
			case 8:
				enterOuterAlt(_localctx, 8);
				{
				setState(199);
				point3();
				}
				break;
			case 9:
				enterOuterAlt(_localctx, 9);
				{
				setState(200);
				point2();
				}
				break;
			case 10:
				enterOuterAlt(_localctx, 10);
				{
				setState(201);
				box2();
				}
				break;
			case 11:
				enterOuterAlt(_localctx, 11);
				{
				setState(202);
				match(MINUS);
				setState(203);
				expr();
				}
				break;
			case 12:
				enterOuterAlt(_localctx, 12);
				{
				setState(204);
				expr_seq();
				}
				break;
			case 13:
				enterOuterAlt(_localctx, 13);
				{
				setState(205);
				match(QUESTION);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Expr_seqContext extends ParserRuleContext {
		public TerminalNode LPAREN() { return getToken(mxsParser.LPAREN, 0); }
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public TerminalNode RPAREN() { return getToken(mxsParser.RPAREN, 0); }
		public List<TerminalNode> SEMI() { return getTokens(mxsParser.SEMI); }
		public TerminalNode SEMI(int i) {
			return getToken(mxsParser.SEMI, i);
		}
		public List<TerminalNode> EOL() { return getTokens(mxsParser.EOL); }
		public TerminalNode EOL(int i) {
			return getToken(mxsParser.EOL, i);
		}
		public Expr_seqContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr_seq; }
	}

	public final Expr_seqContext expr_seq() throws RecognitionException {
		Expr_seqContext _localctx = new Expr_seqContext(_ctx, getState());
		enterRule(_localctx, 34, RULE_expr_seq);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(208);
			match(LPAREN);
			setState(209);
			expr();
			setState(214);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEMI || _la==EOL) {
				{
				{
				setState(210);
				_la = _input.LA(1);
				if ( !(_la==SEMI || _la==EOL) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(211);
				expr();
				}
				}
				setState(216);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(217);
			match(RPAREN);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Box2Context extends ParserRuleContext {
		public TerminalNode LBRACE() { return getToken(mxsParser.LBRACE, 0); }
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public List<TerminalNode> COMMA() { return getTokens(mxsParser.COMMA); }
		public TerminalNode COMMA(int i) {
			return getToken(mxsParser.COMMA, i);
		}
		public TerminalNode RBRACE() { return getToken(mxsParser.RBRACE, 0); }
		public Box2Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_box2; }
	}

	public final Box2Context box2() throws RecognitionException {
		Box2Context _localctx = new Box2Context(_ctx, getState());
		enterRule(_localctx, 36, RULE_box2);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(219);
			match(LBRACE);
			setState(220);
			expr();
			setState(221);
			match(COMMA);
			setState(222);
			expr();
			setState(223);
			match(COMMA);
			setState(224);
			expr();
			setState(225);
			match(COMMA);
			setState(226);
			expr();
			setState(227);
			match(RBRACE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Point3Context extends ParserRuleContext {
		public TerminalNode LBRACE() { return getToken(mxsParser.LBRACE, 0); }
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public List<TerminalNode> COMMA() { return getTokens(mxsParser.COMMA); }
		public TerminalNode COMMA(int i) {
			return getToken(mxsParser.COMMA, i);
		}
		public TerminalNode RBRACE() { return getToken(mxsParser.RBRACE, 0); }
		public Point3Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_point3; }
	}

	public final Point3Context point3() throws RecognitionException {
		Point3Context _localctx = new Point3Context(_ctx, getState());
		enterRule(_localctx, 38, RULE_point3);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(229);
			match(LBRACE);
			setState(230);
			expr();
			setState(231);
			match(COMMA);
			setState(232);
			expr();
			setState(233);
			match(COMMA);
			setState(234);
			expr();
			setState(235);
			match(RBRACE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Point2Context extends ParserRuleContext {
		public TerminalNode LBRACE() { return getToken(mxsParser.LBRACE, 0); }
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public TerminalNode COMMA() { return getToken(mxsParser.COMMA, 0); }
		public TerminalNode RBRACE() { return getToken(mxsParser.RBRACE, 0); }
		public Point2Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_point2; }
	}

	public final Point2Context point2() throws RecognitionException {
		Point2Context _localctx = new Point2Context(_ctx, getState());
		enterRule(_localctx, 40, RULE_point2);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(237);
			match(LBRACE);
			setState(238);
			expr();
			setState(239);
			match(COMMA);
			setState(240);
			expr();
			setState(241);
			match(RBRACE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BitArrayContext extends ParserRuleContext {
		public TerminalNode SHARP() { return getToken(mxsParser.SHARP, 0); }
		public TerminalNode LCURLY() { return getToken(mxsParser.LCURLY, 0); }
		public TerminalNode RCURLY() { return getToken(mxsParser.RCURLY, 0); }
		public BitListContext bitList() {
			return getRuleContext(BitListContext.class,0);
		}
		public BitArrayContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_bitArray; }
	}

	public final BitArrayContext bitArray() throws RecognitionException {
		BitArrayContext _localctx = new BitArrayContext(_ctx, getState());
		enterRule(_localctx, 42, RULE_bitArray);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(243);
			match(SHARP);
			setState(244);
			match(LCURLY);
			setState(246);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (((((_la - 20)) & ~0x3f) == 0 && ((1L << (_la - 20)) & ((1L << (ON - 20)) | (1L << (NOT - 20)) | (1L << (BOOL - 20)) | (1L << (MINUS - 20)) | (1L << (SHARP - 20)) | (1L << (LPAREN - 20)) | (1L << (LBRACE - 20)) | (1L << (DOLLAR - 20)) | (1L << (QUESTION - 20)) | (1L << (INT - 20)) | (1L << (DEG - 20)) | (1L << (HEX - 20)) | (1L << (NAME - 20)) | (1L << (ALPHANUM - 20)))) != 0)) {
				{
				setState(245);
				bitList(0);
				}
			}

			setState(248);
			match(RCURLY);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BitListContext extends ParserRuleContext {
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public List<TerminalNode> DOT() { return getTokens(mxsParser.DOT); }
		public TerminalNode DOT(int i) {
			return getToken(mxsParser.DOT, i);
		}
		public List<BitListContext> bitList() {
			return getRuleContexts(BitListContext.class);
		}
		public BitListContext bitList(int i) {
			return getRuleContext(BitListContext.class,i);
		}
		public List<TerminalNode> COMMA() { return getTokens(mxsParser.COMMA); }
		public TerminalNode COMMA(int i) {
			return getToken(mxsParser.COMMA, i);
		}
		public BitListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_bitList; }
	}

	public final BitListContext bitList() throws RecognitionException {
		return bitList(0);
	}

	private BitListContext bitList(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		BitListContext _localctx = new BitListContext(_ctx, _parentState);
		BitListContext _prevctx = _localctx;
		int _startState = 44;
		enterRecursionRule(_localctx, 44, RULE_bitList, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(257);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,19,_ctx) ) {
			case 1:
				{
				setState(251);
				expr();
				setState(252);
				match(DOT);
				setState(253);
				match(DOT);
				setState(254);
				expr();
				}
				break;
			case 2:
				{
				setState(256);
				expr();
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(268);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,21,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new BitListContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_bitList);
					setState(259);
					if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
					setState(262); 
					_errHandler.sync(this);
					_alt = 1;
					do {
						switch (_alt) {
						case 1:
							{
							{
							setState(260);
							match(COMMA);
							setState(261);
							bitList(0);
							}
							}
							break;
						default:
							throw new NoViableAltException(this);
						}
						setState(264); 
						_errHandler.sync(this);
						_alt = getInterpreter().adaptivePredict(_input,20,_ctx);
					} while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER );
					}
					} 
				}
				setState(270);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,21,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class ArrayContext extends ParserRuleContext {
		public TerminalNode SHARP() { return getToken(mxsParser.SHARP, 0); }
		public TerminalNode LPAREN() { return getToken(mxsParser.LPAREN, 0); }
		public TerminalNode RPAREN() { return getToken(mxsParser.RPAREN, 0); }
		public ElementListContext elementList() {
			return getRuleContext(ElementListContext.class,0);
		}
		public ArrayContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_array; }
	}

	public final ArrayContext array() throws RecognitionException {
		ArrayContext _localctx = new ArrayContext(_ctx, getState());
		enterRule(_localctx, 46, RULE_array);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(271);
			match(SHARP);
			setState(272);
			match(LPAREN);
			setState(274);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (((((_la - 20)) & ~0x3f) == 0 && ((1L << (_la - 20)) & ((1L << (ON - 20)) | (1L << (NOT - 20)) | (1L << (BOOL - 20)) | (1L << (MINUS - 20)) | (1L << (SHARP - 20)) | (1L << (LPAREN - 20)) | (1L << (LBRACE - 20)) | (1L << (DOLLAR - 20)) | (1L << (QUESTION - 20)) | (1L << (INT - 20)) | (1L << (DEG - 20)) | (1L << (HEX - 20)) | (1L << (NAME - 20)) | (1L << (ALPHANUM - 20)))) != 0)) {
				{
				setState(273);
				elementList();
				}
			}

			setState(276);
			match(RPAREN);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ElementListContext extends ParserRuleContext {
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public List<TerminalNode> COMMA() { return getTokens(mxsParser.COMMA); }
		public TerminalNode COMMA(int i) {
			return getToken(mxsParser.COMMA, i);
		}
		public ElementListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_elementList; }
	}

	public final ElementListContext elementList() throws RecognitionException {
		ElementListContext _localctx = new ElementListContext(_ctx, getState());
		enterRule(_localctx, 48, RULE_elementList);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(278);
			expr();
			setState(283);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==COMMA) {
				{
				{
				setState(279);
				match(COMMA);
				setState(280);
				expr();
				}
				}
				setState(285);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Var_nameContext extends ParserRuleContext {
		public TerminalNode ALPHANUM() { return getToken(mxsParser.ALPHANUM, 0); }
		public Var_nameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_var_name; }
	}

	public final Var_nameContext var_name() throws RecognitionException {
		Var_nameContext _localctx = new Var_nameContext(_ctx, getState());
		enterRule(_localctx, 50, RULE_var_name);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(286);
			match(ALPHANUM);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Name_valueContext extends ParserRuleContext {
		public TerminalNode NAME() { return getToken(mxsParser.NAME, 0); }
		public Name_valueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_name_value; }
	}

	public final Name_valueContext name_value() throws RecognitionException {
		Name_valueContext _localctx = new Name_valueContext(_ctx, getState());
		enterRule(_localctx, 52, RULE_name_value);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(288);
			match(NAME);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PathContext extends ParserRuleContext {
		public TerminalNode DOLLAR() { return getToken(mxsParser.DOLLAR, 0); }
		public Path_nameContext path_name() {
			return getRuleContext(Path_nameContext.class,0);
		}
		public PathContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_path; }
	}

	public final PathContext path() throws RecognitionException {
		PathContext _localctx = new PathContext(_ctx, getState());
		enterRule(_localctx, 54, RULE_path);
		try {
			setState(293);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,24,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(290);
				match(DOLLAR);
				setState(291);
				path_name();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(292);
				match(DOLLAR);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Path_nameContext extends ParserRuleContext {
		public LevelsContext levels() {
			return getRuleContext(LevelsContext.class,0);
		}
		public TerminalNode OBJECTSET() { return getToken(mxsParser.OBJECTSET, 0); }
		public TerminalNode DIV() { return getToken(mxsParser.DIV, 0); }
		public Path_nameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_path_name; }
	}

	public final Path_nameContext path_name() throws RecognitionException {
		Path_nameContext _localctx = new Path_nameContext(_ctx, getState());
		enterRule(_localctx, 56, RULE_path_name);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(297);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==OBJECTSET) {
				{
				setState(295);
				match(OBJECTSET);
				setState(296);
				match(DIV);
				}
			}

			setState(299);
			levels();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class LevelsContext extends ParserRuleContext {
		public List<Level_nameContext> level_name() {
			return getRuleContexts(Level_nameContext.class);
		}
		public Level_nameContext level_name(int i) {
			return getRuleContext(Level_nameContext.class,i);
		}
		public List<TerminalNode> DIV() { return getTokens(mxsParser.DIV); }
		public TerminalNode DIV(int i) {
			return getToken(mxsParser.DIV, i);
		}
		public LevelsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_levels; }
	}

	public final LevelsContext levels() throws RecognitionException {
		LevelsContext _localctx = new LevelsContext(_ctx, getState());
		enterRule(_localctx, 58, RULE_levels);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(301);
			level_name();
			setState(306);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,26,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(302);
					match(DIV);
					setState(303);
					level_name();
					}
					} 
				}
				setState(308);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,26,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Level_nameContext extends ParserRuleContext {
		public TerminalNode ALPHANUM() { return getToken(mxsParser.ALPHANUM, 0); }
		public TerminalNode UNDERSCORE() { return getToken(mxsParser.UNDERSCORE, 0); }
		public TerminalNode PROD() { return getToken(mxsParser.PROD, 0); }
		public TerminalNode QUESTION() { return getToken(mxsParser.QUESTION, 0); }
		public TerminalNode BACKSLASH() { return getToken(mxsParser.BACKSLASH, 0); }
		public Level_nameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_level_name; }
	}

	public final Level_nameContext level_name() throws RecognitionException {
		Level_nameContext _localctx = new Level_nameContext(_ctx, getState());
		enterRule(_localctx, 60, RULE_level_name);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(309);
			_la = _input.LA(1);
			if ( !(((((_la - 43)) & ~0x3f) == 0 && ((1L << (_la - 43)) & ((1L << (PROD - 43)) | (1L << (UNDERSCORE - 43)) | (1L << (QUESTION - 43)) | (1L << (BACKSLASH - 43)) | (1L << (ALPHANUM - 43)))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BoolContext extends ParserRuleContext {
		public TerminalNode BOOL() { return getToken(mxsParser.BOOL, 0); }
		public TerminalNode ON() { return getToken(mxsParser.ON, 0); }
		public BoolContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_bool; }
	}

	public final BoolContext bool() throws RecognitionException {
		BoolContext _localctx = new BoolContext(_ctx, getState());
		enterRule(_localctx, 62, RULE_bool);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(311);
			_la = _input.LA(1);
			if ( !(_la==ON || _la==BOOL) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class NumberContext extends ParserRuleContext {
		public TerminalNode INT() { return getToken(mxsParser.INT, 0); }
		public TerminalNode DEG() { return getToken(mxsParser.DEG, 0); }
		public TerminalNode HEX() { return getToken(mxsParser.HEX, 0); }
		public NumberContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_number; }
	}

	public final NumberContext number() throws RecognitionException {
		NumberContext _localctx = new NumberContext(_ctx, getState());
		enterRule(_localctx, 64, RULE_number);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(313);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << INT) | (1L << DEG) | (1L << HEX))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 7:
			return mathExpr_sempred((MathExprContext)_localctx, predIndex);
		case 8:
			return logicExpr_sempred((LogicExprContext)_localctx, predIndex);
		case 13:
			return propertyOrIndex_sempred((PropertyOrIndexContext)_localctx, predIndex);
		case 22:
			return bitList_sempred((BitListContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean mathExpr_sempred(MathExprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 5);
		case 1:
			return precpred(_ctx, 4);
		case 2:
			return precpred(_ctx, 3);
		case 3:
			return precpred(_ctx, 2);
		case 4:
			return precpred(_ctx, 1);
		}
		return true;
	}
	private boolean logicExpr_sempred(LogicExprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 5:
			return precpred(_ctx, 3);
		}
		return true;
	}
	private boolean propertyOrIndex_sempred(PropertyOrIndexContext _localctx, int predIndex) {
		switch (predIndex) {
		case 6:
			return precpred(_ctx, 4);
		case 7:
			return precpred(_ctx, 3);
		}
		return true;
	}
	private boolean bitList_sempred(BitListContext _localctx, int predIndex) {
		switch (predIndex) {
		case 8:
			return precpred(_ctx, 3);
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3G\u013e\4\2\t\2\4"+
		"\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t"+
		"\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\4\36\t\36\4\37\t\37\4 \t \4!"+
		"\t!\4\"\t\"\3\2\6\2F\n\2\r\2\16\2G\3\2\3\2\3\3\3\3\3\3\3\4\3\4\3\4\3\4"+
		"\3\4\7\4T\n\4\f\4\16\4W\13\4\3\4\3\4\3\4\7\4\\\n\4\f\4\16\4_\13\4\3\4"+
		"\3\4\3\5\3\5\5\5e\n\5\3\6\3\6\3\6\3\6\5\6k\n\6\3\7\3\7\3\7\3\7\3\b\3\b"+
		"\5\bs\n\b\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t"+
		"\3\t\3\t\3\t\7\t\u0087\n\t\f\t\16\t\u008a\13\t\3\n\3\n\3\n\3\n\5\n\u0090"+
		"\n\n\3\n\3\n\3\n\7\n\u0095\n\n\f\n\16\n\u0098\13\n\3\13\3\13\5\13\u009c"+
		"\n\13\3\f\3\f\3\f\3\f\3\r\3\r\5\r\u00a4\n\r\3\16\3\16\5\16\u00a8\n\16"+
		"\3\17\3\17\3\17\3\17\3\17\3\17\3\17\5\17\u00b1\n\17\3\17\3\17\3\17\3\17"+
		"\7\17\u00b7\n\17\f\17\16\17\u00ba\13\17\3\20\3\20\3\20\3\21\3\21\3\21"+
		"\3\21\3\22\3\22\3\22\3\22\3\22\3\22\3\22\3\22\3\22\3\22\3\22\3\22\3\22"+
		"\3\22\5\22\u00d1\n\22\3\23\3\23\3\23\3\23\7\23\u00d7\n\23\f\23\16\23\u00da"+
		"\13\23\3\23\3\23\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\25"+
		"\3\25\3\25\3\25\3\25\3\25\3\25\3\25\3\26\3\26\3\26\3\26\3\26\3\26\3\27"+
		"\3\27\3\27\5\27\u00f9\n\27\3\27\3\27\3\30\3\30\3\30\3\30\3\30\3\30\3\30"+
		"\5\30\u0104\n\30\3\30\3\30\3\30\6\30\u0109\n\30\r\30\16\30\u010a\7\30"+
		"\u010d\n\30\f\30\16\30\u0110\13\30\3\31\3\31\3\31\5\31\u0115\n\31\3\31"+
		"\3\31\3\32\3\32\3\32\7\32\u011c\n\32\f\32\16\32\u011f\13\32\3\33\3\33"+
		"\3\34\3\34\3\35\3\35\3\35\5\35\u0128\n\35\3\36\3\36\5\36\u012c\n\36\3"+
		"\36\3\36\3\37\3\37\3\37\7\37\u0133\n\37\f\37\16\37\u0136\13\37\3 \3 \3"+
		"!\3!\3\"\3\"\3\"\2\6\20\22\34.#\2\4\6\b\n\f\16\20\22\24\26\30\32\34\36"+
		" \"$&(*,.\60\62\64\668:<>@B\2\7\4\2\3\3\27\27\4\2\63\63DD\5\2--<>CC\4"+
		"\2\26\26((\3\2?A\2\u0147\2E\3\2\2\2\4K\3\2\2\2\6N\3\2\2\2\bd\3\2\2\2\n"+
		"j\3\2\2\2\fl\3\2\2\2\16r\3\2\2\2\20t\3\2\2\2\22\u008f\3\2\2\2\24\u009b"+
		"\3\2\2\2\26\u009d\3\2\2\2\30\u00a3\3\2\2\2\32\u00a7\3\2\2\2\34\u00b0\3"+
		"\2\2\2\36\u00bb\3\2\2\2 \u00be\3\2\2\2\"\u00d0\3\2\2\2$\u00d2\3\2\2\2"+
		"&\u00dd\3\2\2\2(\u00e7\3\2\2\2*\u00ef\3\2\2\2,\u00f5\3\2\2\2.\u0103\3"+
		"\2\2\2\60\u0111\3\2\2\2\62\u0118\3\2\2\2\64\u0120\3\2\2\2\66\u0122\3\2"+
		"\2\28\u0127\3\2\2\2:\u012b\3\2\2\2<\u012f\3\2\2\2>\u0137\3\2\2\2@\u0139"+
		"\3\2\2\2B\u013b\3\2\2\2DF\5\4\3\2ED\3\2\2\2FG\3\2\2\2GE\3\2\2\2GH\3\2"+
		"\2\2HI\3\2\2\2IJ\7\2\2\3J\3\3\2\2\2KL\5\b\5\2LM\7D\2\2M\5\3\2\2\2NO\7"+
		"C\2\2OP\7\65\2\2PU\7C\2\2QR\7\62\2\2RT\7C\2\2SQ\3\2\2\2TW\3\2\2\2US\3"+
		"\2\2\2UV\3\2\2\2VX\3\2\2\2WU\3\2\2\2XY\7\66\2\2Y]\7\67\2\2Z\\\5\4\3\2"+
		"[Z\3\2\2\2\\_\3\2\2\2][\3\2\2\2]^\3\2\2\2^`\3\2\2\2_]\3\2\2\2`a\78\2\2"+
		"a\7\3\2\2\2be\5\n\6\2ce\5\f\7\2db\3\2\2\2dc\3\2\2\2e\t\3\2\2\2fk\5\32"+
		"\16\2gk\5\20\t\2hk\5\26\f\2ik\5\22\n\2jf\3\2\2\2jg\3\2\2\2jh\3\2\2\2j"+
		"i\3\2\2\2k\13\3\2\2\2lm\5\16\b\2mn\7*\2\2no\5\b\5\2o\r\3\2\2\2ps\5\64"+
		"\33\2qs\5\34\17\2rp\3\2\2\2rq\3\2\2\2s\17\3\2\2\2tu\b\t\1\2uv\5\32\16"+
		"\2v\u0088\3\2\2\2wx\f\7\2\2xy\7/\2\2y\u0087\5\20\t\7z{\f\6\2\2{|\7-\2"+
		"\2|\u0087\5\20\t\7}~\f\5\2\2~\177\7.\2\2\177\u0087\5\20\t\6\u0080\u0081"+
		"\f\4\2\2\u0081\u0082\7+\2\2\u0082\u0087\5\20\t\5\u0083\u0084\f\3\2\2\u0084"+
		"\u0085\7,\2\2\u0085\u0087\5\20\t\4\u0086w\3\2\2\2\u0086z\3\2\2\2\u0086"+
		"}\3\2\2\2\u0086\u0080\3\2\2\2\u0086\u0083\3\2\2\2\u0087\u008a\3\2\2\2"+
		"\u0088\u0086\3\2\2\2\u0088\u0089\3\2\2\2\u0089\21\3\2\2\2\u008a\u0088"+
		"\3\2\2\2\u008b\u008c\b\n\1\2\u008c\u008d\7\"\2\2\u008d\u0090\5\24\13\2"+
		"\u008e\u0090\5\24\13\2\u008f\u008b\3\2\2\2\u008f\u008e\3\2\2\2\u0090\u0096"+
		"\3\2\2\2\u0091\u0092\f\5\2\2\u0092\u0093\t\2\2\2\u0093\u0095\5\22\n\6"+
		"\u0094\u0091\3\2\2\2\u0095\u0098\3\2\2\2\u0096\u0094\3\2\2\2\u0096\u0097"+
		"\3\2\2\2\u0097\23\3\2\2\2\u0098\u0096\3\2\2\2\u0099\u009c\5\32\16\2\u009a"+
		"\u009c\5\26\f\2\u009b\u0099\3\2\2\2\u009b\u009a\3\2\2\2\u009c\25\3\2\2"+
		"\2\u009d\u009e\5\30\r\2\u009e\u009f\7\60\2\2\u009f\u00a0\5\30\r\2\u00a0"+
		"\27\3\2\2\2\u00a1\u00a4\5\32\16\2\u00a2\u00a4\5\20\t\2\u00a3\u00a1\3\2"+
		"\2\2\u00a3\u00a2\3\2\2\2\u00a4\31\3\2\2\2\u00a5\u00a8\5\"\22\2\u00a6\u00a8"+
		"\5\34\17\2\u00a7\u00a5\3\2\2\2\u00a7\u00a6\3\2\2\2\u00a8\33\3\2\2\2\u00a9"+
		"\u00aa\b\17\1\2\u00aa\u00ab\5\"\22\2\u00ab\u00ac\5\36\20\2\u00ac\u00b1"+
		"\3\2\2\2\u00ad\u00ae\5\"\22\2\u00ae\u00af\5 \21\2\u00af\u00b1\3\2\2\2"+
		"\u00b0\u00a9\3\2\2\2\u00b0\u00ad\3\2\2\2\u00b1\u00b8\3\2\2\2\u00b2\u00b3"+
		"\f\6\2\2\u00b3\u00b7\5\36\20\2\u00b4\u00b5\f\5\2\2\u00b5\u00b7\5 \21\2"+
		"\u00b6\u00b2\3\2\2\2\u00b6\u00b4\3\2\2\2\u00b7\u00ba\3\2\2\2\u00b8\u00b6"+
		"\3\2\2\2\u00b8\u00b9\3\2\2\2\u00b9\35\3\2\2\2\u00ba\u00b8\3\2\2\2\u00bb"+
		"\u00bc\7\64\2\2\u00bc\u00bd\5\64\33\2\u00bd\37\3\2\2\2\u00be\u00bf\79"+
		"\2\2\u00bf\u00c0\5\b\5\2\u00c0\u00c1\7:\2\2\u00c1!\3\2\2\2\u00c2\u00d1"+
		"\5\64\33\2\u00c3\u00d1\5\66\34\2\u00c4\u00d1\58\35\2\u00c5\u00d1\5B\""+
		"\2\u00c6\u00d1\5@!\2\u00c7\u00d1\5\60\31\2\u00c8\u00d1\5,\27\2\u00c9\u00d1"+
		"\5(\25\2\u00ca\u00d1\5*\26\2\u00cb\u00d1\5&\24\2\u00cc\u00cd\7,\2\2\u00cd"+
		"\u00d1\5\b\5\2\u00ce\u00d1\5$\23\2\u00cf\u00d1\7=\2\2\u00d0\u00c2\3\2"+
		"\2\2\u00d0\u00c3\3\2\2\2\u00d0\u00c4\3\2\2\2\u00d0\u00c5\3\2\2\2\u00d0"+
		"\u00c6\3\2\2\2\u00d0\u00c7\3\2\2\2\u00d0\u00c8\3\2\2\2\u00d0\u00c9\3\2"+
		"\2\2\u00d0\u00ca\3\2\2\2\u00d0\u00cb\3\2\2\2\u00d0\u00cc\3\2\2\2\u00d0"+
		"\u00ce\3\2\2\2\u00d0\u00cf\3\2\2\2\u00d1#\3\2\2\2\u00d2\u00d3\7\65\2\2"+
		"\u00d3\u00d8\5\b\5\2\u00d4\u00d5\t\3\2\2\u00d5\u00d7\5\b\5\2\u00d6\u00d4"+
		"\3\2\2\2\u00d7\u00da\3\2\2\2\u00d8\u00d6\3\2\2\2\u00d8\u00d9\3\2\2\2\u00d9"+
		"\u00db\3\2\2\2\u00da\u00d8\3\2\2\2\u00db\u00dc\7\66\2\2\u00dc%\3\2\2\2"+
		"\u00dd\u00de\79\2\2\u00de\u00df\5\b\5\2\u00df\u00e0\7\62\2\2\u00e0\u00e1"+
		"\5\b\5\2\u00e1\u00e2\7\62\2\2\u00e2\u00e3\5\b\5\2\u00e3\u00e4\7\62\2\2"+
		"\u00e4\u00e5\5\b\5\2\u00e5\u00e6\7:\2\2\u00e6\'\3\2\2\2\u00e7\u00e8\7"+
		"9\2\2\u00e8\u00e9\5\b\5\2\u00e9\u00ea\7\62\2\2\u00ea\u00eb\5\b\5\2\u00eb"+
		"\u00ec\7\62\2\2\u00ec\u00ed\5\b\5\2\u00ed\u00ee\7:\2\2\u00ee)\3\2\2\2"+
		"\u00ef\u00f0\79\2\2\u00f0\u00f1\5\b\5\2\u00f1\u00f2\7\62\2\2\u00f2\u00f3"+
		"\5\b\5\2\u00f3\u00f4\7:\2\2\u00f4+\3\2\2\2\u00f5\u00f6\7\61\2\2\u00f6"+
		"\u00f8\7\67\2\2\u00f7\u00f9\5.\30\2\u00f8\u00f7\3\2\2\2\u00f8\u00f9\3"+
		"\2\2\2\u00f9\u00fa\3\2\2\2\u00fa\u00fb\78\2\2\u00fb-\3\2\2\2\u00fc\u00fd"+
		"\b\30\1\2\u00fd\u00fe\5\b\5\2\u00fe\u00ff\7\64\2\2\u00ff\u0100\7\64\2"+
		"\2\u0100\u0101\5\b\5\2\u0101\u0104\3\2\2\2\u0102\u0104\5\b\5\2\u0103\u00fc"+
		"\3\2\2\2\u0103\u0102\3\2\2\2\u0104\u010e\3\2\2\2\u0105\u0108\f\5\2\2\u0106"+
		"\u0107\7\62\2\2\u0107\u0109\5.\30\2\u0108\u0106\3\2\2\2\u0109\u010a\3"+
		"\2\2\2\u010a\u0108\3\2\2\2\u010a\u010b\3\2\2\2\u010b\u010d\3\2\2\2\u010c"+
		"\u0105\3\2\2\2\u010d\u0110\3\2\2\2\u010e\u010c\3\2\2\2\u010e\u010f\3\2"+
		"\2\2\u010f/\3\2\2\2\u0110\u010e\3\2\2\2\u0111\u0112\7\61\2\2\u0112\u0114"+
		"\7\65\2\2\u0113\u0115\5\62\32\2\u0114\u0113\3\2\2\2\u0114\u0115\3\2\2"+
		"\2\u0115\u0116\3\2\2\2\u0116\u0117\7\66\2\2\u0117\61\3\2\2\2\u0118\u011d"+
		"\5\b\5\2\u0119\u011a\7\62\2\2\u011a\u011c\5\b\5\2\u011b\u0119\3\2\2\2"+
		"\u011c\u011f\3\2\2\2\u011d\u011b\3\2\2\2\u011d\u011e\3\2\2\2\u011e\63"+
		"\3\2\2\2\u011f\u011d\3\2\2\2\u0120\u0121\7C\2\2\u0121\65\3\2\2\2\u0122"+
		"\u0123\7B\2\2\u0123\67\3\2\2\2\u0124\u0125\7;\2\2\u0125\u0128\5:\36\2"+
		"\u0126\u0128\7;\2\2\u0127\u0124\3\2\2\2\u0127\u0126\3\2\2\2\u01289\3\2"+
		"\2\2\u0129\u012a\7)\2\2\u012a\u012c\7.\2\2\u012b\u0129\3\2\2\2\u012b\u012c"+
		"\3\2\2\2\u012c\u012d\3\2\2\2\u012d\u012e\5<\37\2\u012e;\3\2\2\2\u012f"+
		"\u0134\5> \2\u0130\u0131\7.\2\2\u0131\u0133\5> \2\u0132\u0130\3\2\2\2"+
		"\u0133\u0136\3\2\2\2\u0134\u0132\3\2\2\2\u0134\u0135\3\2\2\2\u0135=\3"+
		"\2\2\2\u0136\u0134\3\2\2\2\u0137\u0138\t\4\2\2\u0138?\3\2\2\2\u0139\u013a"+
		"\t\5\2\2\u013aA\3\2\2\2\u013b\u013c\t\6\2\2\u013cC\3\2\2\2\35GU]djr\u0086"+
		"\u0088\u008f\u0096\u009b\u00a3\u00a7\u00b0\u00b6\u00b8\u00d0\u00d8\u00f8"+
		"\u0103\u010a\u010e\u0114\u011d\u0127\u012b\u0134";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}