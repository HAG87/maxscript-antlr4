/*$antlr-format alignColons hanging, alignSemicolons hanging, alignFirstTokens true */
lexer grammar mxsLexer;
@members{ 
public static readonly NEWLINE_CHANNEL = 2;
}
/*
options {
	caseInsensitive = true;
}
//*/
// /*
channels {
	NEWLINE_CHANNEL
	// WHITESPACE_CHANNEL,
	// COMMENTS_CHANNEL
}
// */

//COMMENTS
BLOCK_COMMENT
	: '/*' .*? ('*/' | EOF) -> channel(HIDDEN)
	;

LINE_COMMENT
	: '--' ~[\r\n]* -> channel(HIDDEN)
	;

//STRING
STRING
	: String_regular
	| String_verbatim
	;

//KEYWORDS
AND:    A N D;
AS:     A S;
AT:     A T;
BY:     B Y;
CASE:   C A S E;
CATCH:  C A T C H;
COLLECT:C O L L E C T;
DO:     D O;
ELSE:   E L S E;
EXIT:   E X I T;
FOR:    F O R;
FROM:   F R O M;
IF:     I F;
IN:     I N;
OF:     O F;
ON:     O N;
OR:     O R;
RETURN: R E T U R N;
SET:    S E T;
THEN:   T H E N;
// THROW:   [tT] [hH] [rR] [oO] [wW];
TO:      T O;
TRY:     T R Y;
WHEN:    W H E N;
WHERE:   W H E R E;
WHILE:   W H I L E;
WITH:    W I T H;
NOT:     N O T;
PUBLIC:  P U B L I C;
PRIVATE: P R I V A T E;

//RESERVED KEYWORDS
ABOUT:    A B O U T;
COORDSYS: C O O R D S Y S;
LEVEL:    L E V E L;
TIME:     T I M E;
UNDO:     U N D O;
CHANGE:   C H A N G E S?; 
DELETED:  D E L E T E D;
DEFAULTACTION : D E F A U L T A C T I O N;
CONTEXT
	: ANIMATE
	| DONTREPEATMESSAGES
	| MACRORECORDEREMITTERENABLED
	| MXSCALLSTACKCAPTUREENABLED
	| PRINTALLELEMENTS
	| QUIET
	| REDRAW
	;

fragment ANIMATE:                     A N I M A T E;
fragment DONTREPEATMESSAGES:          D O N T R E P E A T M E S S A G E S;
fragment MACRORECORDEREMITTERENABLED: M A C R O R E C O R D E R E M I T T E R E N A B L E D;
fragment MXSCALLSTACKCAPTUREENABLED:  M X S C A L L S T A C K C A P T U R E E N A B L E D;
fragment PRINTALLELEMENTS:            P R I N T A L L E L E M E N T S;
fragment QUIET:                       Q U I E T;
fragment REDRAW:                      R E D R A W;

//BLOCKS
GROUP:       G R O U P;
MACROSCRIPT: M A C R O S C R I P T;
ROLLOUT:     R O L L O U T;
TOOL:        T O O L;
UTILITY:     U T I L I T Y;
RCMENU:      R C M E N U;
PARAMETERS:  P A R A M E T E R S;
PLUGIN:      P L U G I N;
ATTRIBUTES:  A T T R I B U T E S;

//CONTROLS
RolloutControl
	: A N G L E 
	| B I T M A P 
	| B U T T O N 
	| C H E C K B O X
	| C H E C K B U T T O N
	| C O L O R P I C K E R
	| C O M B O B O X
	| C U R V E C O N T R O L
	| D R O P D O W N L I S T
	| E D I T T E X T
	| G R O U P B O X
	| H Y P E R L I N K
	| I M G T A G 
	| L A B E L 
	| L I S T B O X
	| M A P B U T T O N
	| M A T E R I A L B U T T O N
	| M U L T I L I S T B O X
	| P I C K B U T T O N
	| P O P U P M E N U
	| P R O G R E S S B A R
	| R A D I O B U T T O N S
	| S L I D E R 
	| S P I N N E R
	| S U B R O L L O U T
	| T I M E R 
	;
SEPARATOR: S E P A R A T O R;
MENUITEM:  M E N U I T E M;
SUBMENU:   S U B M E N U;

// OVERRIDABLE KEYWORDS
// CONTEXTUAL KEYWORDS...can be used as identifiers outside the context...
KW_RESERVED
	: RolloutControl
	| GROUP
	| LEVEL
	| MENUITEM
	| SEPARATOR
	| SUBMENU
	| TIME
	| SET
	| CHANGE
	| DELETED
	;

KW_OVERRIDE
	: ATTRIBUTES
	| PARAMETERS
	| ROLLOUT
	| PLUGIN
	| RCMENU
	// | TOOL
	| TO
	| RETURN
	// | THROW
	;

//DEFINTITIONS
MAPPED: M A P P E D;
FN:     F U N C T I O N | F N;
STRUCT: S T R U C T;

//DECLARATIONS

LOCAL:      L O C A L;
GLOBAL:     G L O B A L;
PERSISTENT: P E R S I S T E N T  WS GLOBAL;

//VALUES
VOID
	: U N D E F I N E D
	| U N S U P P L I E D
	| S I L E N T V A L U E
	| O K
	;

BOOL
	: T R U E
	| F A L S E
	| O F F
	| ON
	;

//OPERATORS
COMPARE
	: '==' Nls?
	| '<'  Nls?
	| '>'  Nls?
	| '<=' Nls?
	| '>=' Nls?
	| '!=' Nls?
	;

EQ: '=' Nls?;

ASSIGN
	: '+=' Nls?
	| '-=' Nls?
	| '*=' Nls?
	| '/=' Nls?
	;

MINUS : '-' Nls? ;
PLUS  : '+' Nls? ;
PROD  : '*' Nls? ;
DIV   : '/' Nls? ;
POW   : '^' Nls? ;

//SYMBOLS
SHARP    : '#';
COMMA    : Nls? ',' Nls?;
COLON    : ':' ;
DOT      : '.' Nls?;
GLOB     : '::';
DOTDOT   : '..';
AMP      : '&';

QUESTION : Question;
// BACKSLASH : Backslash;
// DOLLAR: Dollar;

// CODE STRUCTURE
PAREN_PAIR: '()' ;
LPAREN: '(' Nls?;
RPAREN: Nls? ')';

LBRACE: '{' Nls?;
RBRACE:  Nls? '}';

LBRACK: '[' Nls?;
RBRACK: ']';

//BASIC VALUES
NUMBER
	: INT
	| DEG
	| HEX
	;

TIMEVAL
	: ( ( (INT? [.])? INT | INT [.] ) [mfstMFST] )+
	| INT [:] INT? [.] INT
	| INT [nN]
	;

fragment DEG: INT? [.] INT ([eEdD] [+-] INT | [lLpP])?;
fragment HEX: '0' [xX] (Num | [aAfF])+;
fragment INT: Num+;

//REFERENCING
REF:   '&' ID;
DEREF: '*' ID;
NAME:  '#' ID;



fragment String_regular
	: '"' (~["\r\n] | '\\"')* '"' //-> type(STRING)
	;
fragment String_verbatim
	: '@"' ~["]* '"' //-> type(STRING)
	;



//IDENTIFIERS
PATH: Dollar (Alphanum | [*?\\] | Quoted | '/')* ;

/*
PATH: Dollar Level | Dollar Level ('/' Level)+;
	fragment Level: Level_name | Quoted;
	fragment Level_name: (Alphanum | [*?\\])* ;
*/
/*
PATH: Dollar ->more, mode(PATH_NAME) ;

mode PATH_NAME;
	Levels
		: Level_name ( '/' Level_name)* ->more	 
		;
	
	Level_name : (Alphanum | [*?/\\])*  ->more;
	
	Level_exit: (WSchar | NLchar) -> skip, PopMode;
*/

ID
	: Alphanum
	;

QUOTED
	: Quoted
	;

fragment Quoted: '\'' (~['] | [\]['])* '\'' ;

RESOURCE
	: '~' Alphanum '~'
	;

fragment Nls: (NLchar | WSchar | Backslash NLchar)+ ;

//WHITESPACE
NL
	: NLchar+ //-> channel(NEWLINE_CHANNEL)
	;

WS
	:  ( WSchar | Backslash NLchar )+ -> channel(HIDDEN)
	;

// fragment wss: ( WSchar | Backslash NL )+ ;

fragment WSchar: [ \t];
fragment NLchar: [\r\n] | Semicolon;

// BASIC FRAGMENTS
fragment Num: [0-9];
fragment Alpha: [_\p{L}];

fragment Alphanum: Alpha (Alpha | Num)*;

//LETTERS
fragment A: [aA];
fragment B: [bB];
fragment C: [cC];
fragment D: [dD];
fragment E: [eE];
fragment F: [fF];
fragment G: [gG];
fragment H: [hH];
fragment I: [iI];
fragment J: [jJ];
fragment K: [kK];
fragment L: [lL];
fragment M: [mM];
fragment N: [nN];
fragment O: [oO];
fragment P: [pP];
fragment Q: [qQ];
fragment R: [rR];
fragment S: [sS];
fragment T: [tT];
fragment U: [uU];
fragment V: [vV];
fragment W: [wW];
fragment X: [xX];
fragment Y: [yY];
fragment Z: [zZ];

// Character ranges
/*
fragment NameChar:
    NameStartChar
    | '0' .. '9'
    | '_'
    | '\u00B7'
    | '\u0300' .. '\u036F'
    | '\u203F' .. '\u2040'
;

fragment NameStartChar:
    'A' .. 'Z'
    | 'a' .. 'z'
    | '\u00C0' .. '\u00D6'
    | '\u00D8' .. '\u00F6'
    | '\u00F8' .. '\u02FF'
    | '\u0370' .. '\u037D'
    | '\u037F' .. '\u1FFF'
    | '\u200C' .. '\u200D'
    | '\u2070' .. '\u218F'
    | '\u2C00' .. '\u2FEF'
    | '\u3001' .. '\uD7FF'
    | '\uF900' .. '\uFDCF'
    | '\uFDF0' .. '\uFFFD'
    // ignores | ['\u10000-'\uEFFFF]
;
*/
fragment Backslash : '\\';
fragment Semicolon : ';' ;
fragment Dollar    : '$' ;
fragment Question   : '?';
/*
fragment Slash      : '/';
fragment Excl       : '!';
fragment Colon      : ':';
fragment DColon     : '::';
fragment SQuote     : '\'';
fragment DQuote     : '"';
fragment LParen     : '(';
fragment RParen     : ')';
fragment LBrace     : '{';
fragment RBrace     : '}';
fragment LBrack     : '[';
fragment RBrack     : ']';
fragment RArrow     : '->';
fragment Lt         : '<';
fragment Gt         : '>';
fragment Equal      : '=';
fragment Compare    : '==';

fragment Astr       : '*';
fragment Plus       : '+';
fragment Minus      : '-';
fragment Pipe       : '|';
fragment Comma      : ',';
fragment Dot        : '.';
fragment Range      : '..';
fragment At         : '@';
fragment Amp        : '&';
fragment Sharp      : '#';
fragment Tilde      : '~';
fragment Pow        : '^';
*/
// Comment this rule out to allow the error to be propagated to the parser
ERRCHAR
    : . -> channel (HIDDEN)
    ;