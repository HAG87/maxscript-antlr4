
lexer grammar mxsLexer;

//options {caseInsensitive = true;}

channels {
	WHITESPACE_CHANNEL,
	COMMENTS_CHANNEL
}
//Multi-meaning keywords
//KEYWORDS
AND    : 'and';
AS     : 'as';
AT     : 'at';
BY     : 'by';
CASE   : 'case';
CATCH  : 'catch';
COLLECT: 'collect';
DO     : 'do';
ELSE   : 'else';
EXIT   : 'exit';
FOR    : 'for';
FROM   : 'from';
IF     : 'if';
IN     : 'in';
OF     : 'of';
ON     : 'on';
OR     : 'or';
RETURN : 'return';
SET    : 'set';
THEN   : 'then';
THROW  : 'throw';
TO     : 'to';
TRY    : 'try';
WHEN   : 'when';
WHERE  : 'where';
WHILE  : 'while';
WITH   : 'with';
NOT    : 'not';
PUBLIC : 'public';
PRIVATE: 'private';
//CONTROLS
RoloutControl:
	'angle'
	| 'checkbox'
	| 'checkbutton'
	| 'colorpicker'
	| 'combobox'
	| 'curvecontrol'
	| 'dotnetcontrol'
	| 'dropdownlist'
	| 'edittext'
	| 'groupbox'
	| 'hyperlink'
	| 'imgtag'
	| 'label'
	| 'listbox'
	| 'mapbutton'
	| 'materialbutton'
	| 'multilistbox'
	| 'pickbutton'
	| 'progressbar'
	| 'radiobuttons'
	| 'separator'
	| 'slider'
	| 'spinner'
	| 'timer';
ROLLOUT: 'rollout';
//DEFINTITIONS
MAPPED: 'mapped';
FN: MAPPED? ('function' | 'fn');
STRUCT: 'struct';

//VALUES
VOID: 'undefined' | 'unsupplied' | 'ok' | 'silentvalue';
BOOL: 'true' | 'false' | 'off' | ON;
TIME: ((([0-9]* [.])? [0-9]+ | [0-9]+ [.]) [msft])+
	| [0-9]+ [:][0-9]* [.][0-9]+
	| [0-9]+ [n];

DECLARATION: ('local' | 'persistent'? 'global');

SIMPLECALL: ALPHANUM EMPTYPARENS;

GLOBAL_ID: '::';
DOTDOT: '..';
//OBJECTSET
OBJECTSET:
	'cameras'
	| 'geometry'
	| 'helpers'
	| 'lights'
	| 'objects'
	| 'selection'
	| 'shapes'
	| 'spacewarps'
	| 'systems';

//OPERATORS
COMPARE: '==' | '<' | '>' | '<=' | '>=' | '!=';
EQ: '=';
ASSIGN:  '-=' | '+=' | '*=' | '/=' ;

//ASTRX: '*'; DSH: '-'; SLSH: '/';

PLUS: '+';
MINUS: '-';
PROD: '*';
DIV: '/';
POW: '^';

//SETVAR: '='; //whaat is happening here??

//SYMBOLS
SHARP: '#';
COMMA: ',';
//SEMI : ';' ;
DOUBLEDOT: ':';
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

//BASE
INT: [0-9]+;
DEG: [0-9]* ([.][0-9]+) (([ed][+-][0-9]+) | 'L' | 'P')?;
HEX: '0x' [0-9a-f]+;

//Taken from https://github.com/antlr/grammars-v4/blob/master/csharp/CSharpLexer.g4
STRING: String_regular | String_verbatim;

fragment String_regular:
	'"' (~["\\\r\n\u0085\u2028\u2029] | SimpleEscapeSequence)* '"';
fragment String_verbatim: '@"' (~'"' | '""')* '"';
fragment SimpleEscapeSequence:
	'\\\''
	| '\\"'
	| '\\\\'
	| '\\0'
	| '\\a'
	| '\\b'
	| '\\f'
	| '\\n'
	| '\\r'
	| '\\t'
	| '\\v';

REF: BITAND ALPHANUM | BITAND SINGLEQUOT;
DEREF: '*' ALPHANUM | '*' SINGLEQUOT;
NAME: '#' ALPHANUM | '#' SINGLEQUOT;

SINGLEQUOT: '\'' (~'\'' | '\'\'')* '\'';
ALPHANUM: [a-z_][a-z_0-9]*;

//WHITESPACE
EOL: ([ \t]* [;\r\n]+ [ \t]*)+ -> channel(HIDDEN);
WS: [ \t]+ -> channel(HIDDEN);

//COMMENTS
COMMENT: '/*' .*? '*/' -> channel(COMMENTS_CHANNEL);
LINE_COMMENT: '--' ~[\r\n]* -> channel(COMMENTS_CHANNEL);