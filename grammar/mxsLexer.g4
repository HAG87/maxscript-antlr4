/*$antlr-format alignColons hanging, alignSemicolons hanging, alignFirstTokens true */
lexer grammar mxsLexer;

channels {
	WHITESPACE_CHANNEL,
	COMMENTS_CHANNEL
}
//(\w)
//[\U$1$1] 
//KEYWORDS
AND:     [aA] [nN] [dD];
AS:      [aA] [sS];
AT:      [aA] [tT];
BY:      [bB] [yY];
CASE:    [cC] [aA] [sS] [eE];
CATCH:   [cC] [aA] [tT] [cC] [hH];
COLLECT: [cC] [oO] [lL] [lL] [eE] [cC] [tT];
DO:      [dD] [oO];
ELSE:    [eE] [lL] [sS] [eE];
EXIT:    [eE] [xX] [iI] [tT];
FOR:     [fF] [oO] [rR];
FROM:    [fF] [rR] [oO] [mM];
IF:      [iI] [fF];
IN:      [iI] [nN];
OF:      [oO] [fF];
ON:      [oO] [nN];
OR:      [oO] [rR];
RETURN:  [rR] [eE] [tT] [uU] [rR] [nN];
SET:     [sS] [eE] [tT];
THEN:    [tT] [hH] [eE] [nN];
THROW:   [tT] [hH] [rR] [oO] [wW];
TO:      [tT] [oO];
TRY:     [tT] [rR] [yY];
WHEN:    [wW] [hH] [eE] [nN];
WHERE:   [wW] [hH] [eE] [rR] [eE];
WHILE:   [wW] [hH] [iI] [lL] [eE];
WITH:    [wW] [iI] [tT] [hH];
NOT:     [nN] [oO] [tT];
PUBLIC:  [pP] [uU] [bB] [lL] [iI] [cC];
PRIVATE: [pP] [rR] [iI] [vV] [aA] [tT] [eE];
//RESERVED KEYWORDS
ABOUT:    [aA] [bB] [oO] [u] [tT];
COORDSYS: [cC] [oO] [oO] [r] [dD] [sS] [yY] [sS];
DEFAULTACTION : [Dd][Ee] [Ff] [Aa] [Uu] [Ll] [Tt] [Aa] [Cc] [Tt] [Ii] [Oo] [Nn];
LEVEL: [lL] [eE] [vV] [e] [lL];
TIME:  [tT] [iI] [mM] [e];
UNDO:  [Uu]  [Nn]  [Dd]  [Oo];
CHANGE: [Cc] [Hh] [Aa] [Nn] [Gg] [Ee] [Ss]?; 
DELETED: [Dd] [Ee] [Ll] [Ee] [Tt] [Ee] [Dd];
CONTEXT
	: ANIMATE
	| DONTREPEATMESSAGES
	| MACRORECORDEREMITTERENABLED
	| MXSCALLSTACKCAPTUREENABLED
	| PRINTALLELEMENTS
	| QUIET
	| REDRAW
	;
fragment ANIMATE:                     [Aa] [Nn] [Ii] [Mm] [Aa] [Tt] [Ee];
fragment DONTREPEATMESSAGES:          [Dd] [Oo] [Nn] [Tt] [Rr] [Ee] [Pp] [Ee] [Aa] [Tt] [Mm] [Ee] [Ss] [Ss] [Aa] [Gg] [Ee] [Ss];
fragment MACRORECORDEREMITTERENABLED: [Mm] [Aa] [Cc] [Rr] [Oo] [Rr] [Ee] [Cc] [Oo] [Rr] [Dd] [Ee] [Rr] [Ee] [Mm] [Ii] [Tt] [Tt] [Ee] [Rr] [Ee] [Nn] [Aa] [Bb] [Ll] [Ee] [Dd];
fragment MXSCALLSTACKCAPTUREENABLED:  [Mm] [Xx] [Ss] [Cc] [Aa] [Ll] [Ll] [Ss] [Tt] [Aa] [Cc] [Kk] [Cc] [Aa] [Pp] [Tt] [Uu] [Rr] [Ee] [Ee] [Nn] [Aa] [Bb] [Ll] [Ee] [Dd];
fragment PRINTALLELEMENTS:            [Pp] [Rr] [Ii] [Nn] [Tt] [Aa] [Ll] [Ll] [Ee] [Ll] [Ee] [Mm] [Ee] [Nn] [Tt] [Ss];
fragment QUIET:                       [Qq] [Uu] [Ii] [Ee] [Tt];
fragment REDRAW:                      [Rr] [Ee] [Dd] [Rr] [Aa] [Ww];
//BLOCKS
GROUP:       [gG] [rR] [oO] [uU] [pP];
MACROSCRIPT: [mM] [aA] [cC] [rR] [oO] [sS] [cC] [rR] [iI] [pP] [tT];
ROLLOUT:     [rR] [oO] [lL] [lL] [oO] [uU] [tT];
TOOL:        [tT] [oO] [oO] [lL];
UTILITY:     [uU] [tT] [iI] [lL] [iI] [tT] [yY];
RCMENU:      [rR] [cC] [mM] [eE] [nN] [uU];
PARAMETERS:  [Pp] [Aa] [Rr] [Aa] [Mm] [Ee] [Tt] [Ee] [Rr] [Ss];
PLUGIN:      [Pp] [Ll] [Uu] [Gg] [Ii] [Nn];
ATTRIBUTES:  [Aa] [Tt] [Tt] [Rr] [Ii] [Bb] [Uu] [Tt] [Ee] [Ss];
//CONTROLS
RolloutControl
	: [aA] [nN] [gG] [lL] [eE]
	| [cC] [hH] [eE] [cC] [kK] [bB] [oO] [xX]
	| [cC] [hH] [eE] [cC] [kK] [bB] [uU] [tT] [tT] [oO] [nN]
	| [cC] [oO] [lL] [oO] [rR] [pP] [iI] [cC] [kK] [eE] [rR]
	| [cC] [oO] [mM] [bB] [oO] [bB] [oO] [xX]
	| [cC] [uU] [rR] [vV] [eE] [cC] [oO] [nN] [tT] [rR] [oO] [lL]
	| [dD] [oO] [tT] [nN] [eE] [tT] [cC] [oO] [nN] [tT] [rR] [oO] [lL]
	| [dD] [rR] [oO] [pP] [dD] [oO] [wW] [nN] [lL] [iI] [sS] [tT]
	| [eE] [dD] [iI] [tT] [tT] [eE] [xX] [tT]
	| [gG] [rR] [oO] [uU] [pP] [bB] [oO] [xX]
	| [hH] [yY] [pP] [eE] [rR] [lL] [iI] [nN] [kK]
	| [iI] [mM] [gG] [tT] [aA] [gG]
	| [lL] [aA] [bB] [eE] [lL]
	| [lL] [iI] [sS] [tT] [bB] [oO] [xX]
	| [mM] [aA] [pP] [bB] [uU] [tT] [tT] [oO] [nN]
	| [mM] [aA] [tT] [eE] [rR] [iI] [aA] [lL] [bB] [uU] [tT] [tT] [oO] [nN]
	| [mM] [uU] [lL] [tT] [iI] [lL] [iI] [sS] [tT] [bB] [oO] [xX]
	| [pP] [iI] [cC] [kK] [bB] [uU] [tT] [tT] [oO] [nN]
	| [pP] [rR] [oO] [gG] [rR] [eE] [sS] [sS] [bB] [aA] [rR]
	| [rR] [aA] [dD] [iI] [oO] [bB] [uU] [tT] [tT] [oO] [nN] [sS]
	| [sS] [eE] [pP] [aA] [rR] [aA] [tT] [oO] [rR]
	| [sS] [lL] [iI] [dD] [eE] [rR]
	| [sS] [pP] [iI] [nN] [nN] [eE] [rR]
	| [tT] [iI] [mM] [eE] [rR]
	;
SEPARATOR: [sS] [eE] [pP] [aA] [rR] [aA] [tT] [oO] [rR];
MENUITEM:  [mM] [eE] [nN] [uU] [iI] [tT] [eE] [mM];
SUBMENU:   [sS] [uU] [bB] [mM] [eE] [nN] [uU];
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
KW_OVERIDE
	: ATTRIBUTES
	| PARAMETERS
	| ROLLOUT
	| PLUGIN
	| RCMENU
	| TOOL
	| TO
	| RETURN
	| THROW
	;
//DEFINTITIONS
MAPPED: [mM] [aA] [pP] [pP] [eE] [dD];
FN:     [fF] [uU] [nN] [cC] [tT] [iI] [oO] [nN] | [fF] [nN];
STRUCT: [sS] [tT] [rR] [uU] [cC] [tT];
//DECLARATIONS
DECL: LOCAL
	| GLOBAL
	| PERSISTENT WS GLOBAL
	;
LOCAL:      [lL] [oO] [cC] [aA] [lL];
GLOBAL:     [gG] [lL] [oO] [bB] [aA] [lL];
PERSISTENT: [pP] [eE] [rR] [sS] [iI] [sS] [tT] [eE] [nN] [tT];
//VALUES
VOID
	: [uU] [nN] [dD] [eE] [fF] [iI] [nN] [eE] [dD]
	| [uU] [nN] [sS] [uU] [pP] [pP] [lL] [iI] [eE] [dD]
	| [sS] [iI] [lL] [eE] [nN] [tT] [vV] [aA] [lL] [uU] [eE]
	| [oO] [kK]
	;
BOOL
	: [tT] [rR] [uU] [eE]
	| [fF] [aA] [lL] [sS] [eE]
	| [oO] [fF] [fF]
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
REF: BITAND ID;
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
	| GLOB? SINGLEQUOT
	| GLOB? KW_RESERVED
	;
SINGLEQUOT: GLOB? '\'' (~'\'' | '\'\'')* '\'';
RESOURCE: TILDE [a-zA-Z_0-9]+ TILDE;
fragment DIG: [0-9];
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