// DELETE THIS CONTENT IF YOU PUT COMBINED GRAMMAR IN Parser TAB
lexer grammar mxsLexer;

//options {caseInsensitive = true;}

channels {
  WHITESPACE_CHANNEL,
  COMMENTS_CHANNEL
}

//KEYWORDS
AND:         'and';
AS:          'as';
AT:          'at';
BY:          'by';
CASE:        'case';
CATCH:       'catch';
COLLECT:     'collect';
//CONTINUE:    'continue';
DO:          'do';
//DONTCOLLECT: 'dontcollect';
ELSE:        'else';
EXIT:        'exit';
FOR:         'for';
FROM:        'from';
IF:          'if';
IN:          'in';
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
PUBLIC:      'public';
PRIVATE:     'private';
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
TIME
    : ((([0-9]*[.])?[0-9]+|[0-9]+[.])[msft])+
    | [0-9]+[:][0-9]*[.][0-9]+
    | [0-9]+[n]
    ;

DECLARATION
    : 'local'
    | 'persistent'? 'global'
    ;

GLOBAL_ID: '::' ;
DOTDOT: '..' ;
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
EQ: '=';
ASSIGN
    : EQ
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
DOUBLEDOT : ':';
DOT: '.' ;
AMP: '\'' ;
LPAREN : '(' ;
RPAREN : ')' ;
LCURLY : '{' ;
RCURLY : '}' ;
LBRACE: '[' ;
RBRACE: ']' ;

BITAND : '&';
DOLLAR: '$' ;
UNDERSCORE : '_' ;
QUESTION : '?' ;
BACKSLASH : '\\' ;

//BASE
INT : [0-9]+ ;
DEG : [0-9]*([.][0-9]+)(([ed][+-][0-9]+) | 'L' | 'P')? ;
HEX: '0x'[0-9a-f]+ ;

//Taken from https://github.com/antlr/grammars-v4/blob/master/csharp/CSharpLexer.g4
STRING: String_regular | String_verbatim ;

fragment String_regular:  '"'  (~["\\\r\n\u0085\u2028\u2029] | SimpleEscapeSequence)* '"';
fragment String_verbatim: '@"' (~'"' | '""')* '"';
fragment SimpleEscapeSequence
	: '\\\''
	| '\\"'
	| '\\\\'
	| '\\0'
	| '\\a'
	| '\\b'
	| '\\f'
	| '\\n'
	| '\\r'
	| '\\t'
	| '\\v'
	;

REF
    : BITAND ALPHANUM
    | BITAND SINGLEQUOT
    ;
DEREF
    : '*' ALPHANUM
    | '*' SINGLEQUOT
    ;
NAME
    : '#' ALPHANUM
    | '#' SINGLEQUOT
    ;

SINGLEQUOT: '\'' (~'\'' | '\'\'')* '\'' ;
ALPHANUM: [a-z_][a-z_0-9]* ;
EOL
    : (
      SEMI [ \t\n\r\u000C]*
      | [ \t\n\r\u000C]* [\r\n]+
      ) //-> skip
    ;

//DISCARDED
//WS: [ \t\n\r\u000C]+ -> skip ;
//NL: [\r\n]+ -> skip;
NL: [\r\n]+ ;
// WS: [ \r\n\t\u000C]+ -> skip;
WS: [ \t\u000C]+ -> skip;
COMMENT : '/*' .*? '*/' -> channel(COMMENTS_CHANNEL) ;
LINE_COMMENT: '--' ~[\r\n]*  -> channel(COMMENTS_CHANNEL) ;