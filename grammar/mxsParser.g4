parser grammar mxsParser;
options { tokenVocab=mxsLexer; }

program
    : stat+ EOF
    ;

stat
    : expr EOL
    ;

def : ALPHANUM '(' ALPHANUM (',' ALPHANUM)* ')' '{' stat* '}' ;

expr
    : simple_expr
    | assignment
    ;

simple_expr
    : operand
    | mathExpr
    | compareExpr
    | logicExpr
    ;

//ASSIGNMENT EXPRESSION
assignment : destination ASSIGN expr ;
destination
    : var_name
    | propertyOrIndex
    //| propertyExpr
    //| indexExpr
    ;
//MATH EXPRESSIONS
mathExpr
    : operand
    | <assoc=right> mathExpr POW mathExpr
    | mathExpr PROD mathExpr
    | mathExpr DIV mathExpr
    | mathExpr PLUS mathExpr
    | mathExpr MINUS mathExpr
    ;

// LOGIC EXPRESSION
logicExpr
    : logicExpr (AND|OR) logicExpr
    | NOT logical_operand
    | logical_operand
    //| logical_operand (AND|OR) NOT? logical_operand
    ;
logical_operand
    : operand
    | compareExpr
    ;

//COMPARE EXPRESSION
compareExpr
    : compare_operand COMPARE compare_operand
    ;
compare_operand
    : operand
    | mathExpr
    ;

//ADHERE TO MAXSCRIPT GRAMMAR STANDARD
operand
    : factor
    | propertyOrIndex
    //| operand property
    //| operand index
    //: operand property
    //| operand index
    //| factor
    ;
propertyOrIndex
    : propertyOrIndex property # propertyExpr
    | propertyOrIndex index    # indexExpr
    | factor property          # propertyExpr
    | factor index             # indexExpr
    ;
//Property accessor
/*propertyExpr
    : factor
    | indexExpr
    | propertyExpr property
    ;*/
property : DOT var_name ;
//Index accessor
/*indexExpr
    : factor
    | propertyExpr
    | indexExpr index
    ;*/
index : LBRACE expr RBRACE ; 
//FACTORS
factor
    : var_name
    | name_value
    | path
    | number
    //| string
    //| time
    | bool
    //| special
    | array
    | bitArray
    | point3
    | point2
    | box2
    | MINUS expr //UNARY MINUS
    | expr_seq //mmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    | QUESTION
    ;

expr_seq
    : '(' expr ((';'| EOL) expr)* ')'
    ;
//TYPES
box2: LBRACE expr ',' expr ',' expr ',' expr RBRACE ; 
point3: LBRACE expr ',' expr ',' expr RBRACE ;
point2 : LBRACE expr ',' expr RBRACE ;
//BitArray
bitArray : SHARP LCURLY bitList? RCURLY ;
bitList
    : bitList (',' bitList)+
    | expr DOT DOT expr
    | expr
    ;
//Array
array : SHARP LPAREN elementList? RPAREN ;
elementList : expr (',' expr)* ;
//IDENTIFIERS
var_name : ALPHANUM ;
name_value: NAME ;
//Path names
path
    : DOLLAR path_name
    | DOLLAR
    ;
path_name : (OBJECTSET '/')? levels ;

levels
    : level_name ('/' level_name)*
    ;
/*
levels
    : level_name
    | levels '/' level_name
    ;
    */
level_name : ALPHANUM | '_' | '*' | '?' | '\\' ;
bool
    : BOOL
    | ON
    ;
number
    : INT
    | DEG
    | HEX
    ;