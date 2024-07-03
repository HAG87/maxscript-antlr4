/*$antlr-format alignColons hanging, alignSemicolons hanging, alignFirstTokens true */
lexer grammar mxsLexer;

channels {
	WHITESPACE_CHANNEL,
	COMMENTS_CHANNEL
}
/*
@members {
	DOTMODE
}
*/

//(\w)
//[\U$1$1] 
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
DEFAULTACTION : D E F A U L T A C T I O N;
LEVEL: L E V E L;
TIME:  T I M E;
UNDO:  U  N  D  O;
CHANGE: C H A N G E S?; 
DELETED: D E L E T E D;
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
	| C H E C K B O X
	| C H E C K B U T T O N
	| C O L O R P I C K E R
	| C O M B O B O X
	| C U R V E C O N T R O L
	| D O T N E T C O N T R O L
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
	| P R O G R E S S B A R
	| R A D I O B U T T O N S
	| S E P A R A T O R
	| S L I D E R
	| S P I N N E R
	| T I M E R
	;
SEPARATOR: S E P A R A T O R;
MENUITEM:  M E N U I T E M;
SUBMENU:   S U B M E N U;
// OVERRIDABLE KEYWORDS
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
	| TOOL
	| TO
	| RETURN
	// | THROW
	;
//DEFINTITIONS
MAPPED: M A P P E D;
FN:     F U N C T I O N | F N;
STRUCT: S T R U C T;
//DECLARATIONS
DECL: LOCAL
	| GLOBAL
	| PERSISTENT WS GLOBAL
	;
LOCAL:      L O C A L;
GLOBAL:     G L O B A L;
PERSISTENT: P E R S I S T E N T;
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
GLOB: '::';
DOTDOT: '..';
//SIMPLE-EXPRESSION
COMPARE: '==' | '<' | '>' | '<=' | '>=' | '!=';
EQ: '=';
ASSIGN: '-=' | '+=' | '*=' | '/=';
MINUS: '-';
PLUS: '+';
PROD: '*';
DIV: '/';
POW: '^';
//SYMBOLS
SHARP: '#';
COMMA: ',';
COL: ':';
SEMI: ';';

DOT: '.' ;

/*
DOT: '.' -> PushMode(DOTMODE);

mode DOTMODE;
	PROPERTY_ID: ALPHANUM -> popMode;
*/

SINGLEQUOT: '\'';
LPAREN: '(';
RPAREN: ')';
LCURLY: '{';
RCURLY: '}';
LBRACE: '[';
RBRACE: ']';
AMP: '&';
DOLLAR: '$';
UNDERSCORE: '_';
QUESTION: '?';
BACKSLASH: '\\';
TILDE: '~';
//BASIC VALUES
NUMBER: INT | DEG | HEX;
TIMEVAL
	: (((INT? [.])? INT | INT [.]) [mfstMFST])+
	| INT [:] INT? [.] INT
	| INT [nN]
	;
fragment INT: DIG+;
fragment DEG: INT? [.] INT ([eEdD] [+-] INT | [lLpP])?;
fragment HEX: '0' [xX] (DIG | [aAfF])+;
//REFERENCING
REF: AMP ID;
DEREF: '*'  ID;
NAME: '#'   ID;
//STRING
STRING
	: String_regular
	| String_verbatim
	;
fragment String_regular: '"' (~["\r\n] | '\\"')* '"';
fragment String_verbatim: '@"' (~'"' | '""')* '"';
//IDENTIFIERS
// ID: GLOB? [a-zA-Z_][a-zA-Z_0-9]*;
ID
	: GLOB? ALPHANUM
	| GLOB? QUOTED
	| GLOB? KW_RESERVED
	;
QUOTED: GLOB? '\'' (~'\'' | '\'\'')* '\'';
RESOURCE: TILDE [a-zA-Z_0-9]+ TILDE;
fragment DIG: [0-9];
//letters
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

fragment ALPHANUM: [a-zA-Z_][a-zA-Z_0-9]*;
//COMMENTS
COMMENT: '/*' .*? '*/' -> channel(COMMENTS_CHANNEL);
LINE_COMMENT: '--' ~[\r\n]* -> channel(COMMENTS_CHANNEL);
//WHITESPACE
EOL: (WS? NLCHAR WS?)+ -> channel(HIDDEN);
WS:  (WSCHAR (BACKSLASH+ EOL)* | (BACKSLASH EOL)+) -> channel(HIDDEN);
fragment WSCHAR: [ \t]+;
fragment NLCHAR: [;\r\n]+;
// INVALID TOKENS
ANY: .+? -> skip;