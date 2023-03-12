/*$antlr-format alignColons hanging, alignSemicolons hanging, alignFirstTokens true */
lexer grammar mxsLexer;

channels {
	WHITESPACE_CHANNEL,
	COMMENTS_CHANNEL
}

//KEYWORDS
AND: A N D;
AS: A S;
AT: A T;
BY: B Y;
CASE: C A S E;
CATCH: C A T C H;
COLLECT: C O L L E C T;
DO: D O;
ELSE: E L S E;
EXIT: E X I T;
FOR: F O R;
FROM: F R O M;
IF: I F;
IN: I N;
OF: O F;
ON: O N;
OR: O R;
RETURN: R E T U R N;
SET: S E T;
THEN: T H E N;
THROW: T H R O W;
TO: T O;
TRY: T R Y;
WHEN: W H E N;
WHERE: W H E R E;
WHILE: W H I L E;
WITH: W I T H;
NOT: N O T;
PUBLIC: P U B L I C;
PRIVATE: P R I V A T E;

//BLOCKS
ROLLOUT: R O L L O U T;

//CONTROLS
RoloutControl
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

//DEFINTITIONS
MAPPED: M A P P E D;
FN: F U N C T I O N | F N;
STRUCT: S T R U C T;
//DECLARATIONS
LOCAL: L O C A L;
GLOBAL: G L O B A L;
PERSISTENT: P E R S I S T E N T;

//VALUES
VOID
	: U N D E F I N E D
	| U N S U P P L I E D
	| S I L E N T V A L U E
	| O K
	;
BOOL: T R U E | F A L S E | O F F | ON;
TIME
	: ((([0-9]* [.])? [0-9]+ | [0-9]+ [.]) (M | F | S | T))+
	| [0-9]+ [:][0-9]* [.][0-9]+
	| [0-9]+ N
	;

//OPERATORS
GLOBAL_ID: '::';
DOTDOT: '..';

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
DOT: '.';
AMP: '\'';
EMPTYPARENS: '()';
LPAREN: '(';
RPAREN: ')';
LCURLY: '{';
RCURLY: '}';
LBRACE: '[';
RBRACE: ']';
BITAND: '&';
DOLLAR: '$';
UNDERSCORE: '_';
QUESTION: '?';
BACKSLASH: '\\';

INT: [0-9]+;
DEG: INT? [.] INT (((E | D) [+-] INT) | L | P)?;
HEX: '0' X ([0-9] | A | F)+;

REF: BITAND (ID | SINGLEQUOT);
DEREF: '*' (ID | SINGLEQUOT);
NAME: '#' (ID | SINGLEQUOT);

STRING: String_regular | String_verbatim;
fragment String_regular: '"' (~["\r\n] | '\\"')* '"';
fragment String_verbatim: '@"' (~'"' | '""')* '"';

//Identifiers
SINGLEQUOT: '\'' (~'\'' | '\'\'')* '\'';
ID: [a-z_][a-zA-Z_0-9]*;

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

//COMMENTS
COMMENT: '/*' .*? '*/' -> channel(COMMENTS_CHANNEL);
LINE_COMMENT: '--' ~[\r\n]* -> channel(COMMENTS_CHANNEL);

//WHITESPACE
EOL: (WS? NLCHAR WS?)+ -> channel(HIDDEN);
WS: (WSCHAR+ (BACKSLASH EOL)+? | (BACKSLASH EOL)+) -> channel(HIDDEN);

fragment WSCHAR: [ \t]+;
fragment NLCHAR: [;\r\n]+;

// INVALID TOKENS
ANY: .+? -> skip;