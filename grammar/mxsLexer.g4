lexer grammar mxsLexer;

//options { caseInsensitive = true; }

//KEYWORDS
AND:         'and';
AS:          'as';
AT:          'at';
BY:          'by';
CASE:        'case';
CATCH:       'catch';
COLLECT:     'collect';
CONTINUE:    'continue';
DO:          'do';
DONTCOLLECT: 'dontcollect';
ELSE:        'else';
EXIT:        'exit';
FOR:         'for';
FROM:        'from';
GLOBAL:      'global';
IF:          'if';
IN:          'in';
LOCAL:       'local';
OF:          'of';
ON:          'on';
OR:          'or';
RETURN:      'return';
SET:         'set';
THEN:        'then';
THROW:       'throw';
TO:          'to';
TRY:         'try';
WHEN:        'when';
WHERE:       'where';
WHILE:       'while';
WITH:        'with';
NOT :        'not' ;

//CONTROLS
RoloutControl
	: 'angle'
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
	| 'timer'
	;

//DEFINTITIONS
FN: 'function' | 'fn' ;
MAPPED: 'mapped' ;
STRUCT: 'struct' ;

//VALUES
VOID
	: 'undefined'
	| 'unsupplied'
	| 'ok'
	| 'silentvalue'
	;
BOOL
    : 'true'
    | 'false'
    | 'off'
    ;

//OBJECTSET
OBJECTSET
    : 'cameras'
    | 'geometry'
    | 'helpers'
    | 'lights'
    | 'objects'
    | 'selection'
    | 'shapes'
    | 'spacewarps'
    | 'systems'
    ;

//OPERATORS
ASSIGN
    : '='
    | '-='
    | '+='
    | '*='
    | '/='
    ;

PLUS: '+';
MINUS: '-';
PROD: '*';
DIV: '/';
POW: '^';

COMPARE
    : '=='
    | '<'
    | '>'
    | '<='
    | '>='
    | '!='
    ;

//SYMBOLS
SHARP: '#';
COMMA : ',' ;
SEMI : ';' ;
DOT: '.' ;
LPAREN : '(' ;
RPAREN : ')' ;
LCURLY : '{' ;
RCURLY : '}' ;
LBRACE: '[' ;
RBRACE: ']' ;

DOLLAR: '$' ;
UNDERSCORE: '_' ;
QUESTION: '?' ;
BACKSLASH: '\\' ;

//BASE
INT : [0-9]+ ;
DEG: [0-9]*([.][0-9]+)(([ed][+-][0-9]+) | 'L' | 'P')? ;
HEX: '0x'[0-9a-f]+ ;
NAME: [#][a-z_][a-z_0-9]* ;
ALPHANUM: [a-z_][a-z_0-9]* ;

EOL
    :   (';'+ WS? [\r\n]
        | '\n'
        ) //-> channel(HIDDEN)
    ;

//DISCARDED
//WS: [ \t\n\r\f]+ -> skip ;
WS: [ \t\r\n\u000C]+ -> skip;
COMMENT : '/*' .*? '*/' -> skip ;
LINE_COMMENT: '--' ~[\r\n]* -> skip ;