parser grammar mxsParser;
options {
    tokenVocab = mxsLexer;
    //output = AST;
}

program
    // : (expr | expr EOL )* EOF
    : expr EOF
    | (expr EOL)* EOF
    //: stat+ EOF
    ;

stat: expr | expr EOL ;

expr
    : simple_expr
    | var_decl
    | assignment
    | if_expr
    | while_loop
    | do_loop
    | for_loop
    | loop_exit
    | case_expr
    | try_expr
    | fn_def
    | fn_return
    | struct_def
    ;

simple_expr
    : math_expr //operand and fn_call pass-through mathEx[r
    //| fn_call
    //| operand
    | compare_expr
    | logic_expr
    ;
//CONTEXT


//PARAMETER DEF
//STRUCT DEF
struct_def
    : STRUCT var_name
    '('
        struct_member (',' struct_member)*
    ')' ;
struct_member
    : struct_scope? decl
    | struct_scope? fn_def
    | struct_scope? event_handler
    //| struct_scope struct_member
    ;
struct_scope: PUBLIC | PRIVATE ;
//HANDLERS
event_handler
    : ON event_args (DO | RETURN) expr ;
event_args
    : var_name                     #Event_type
    | var_name var_name            #Event_target_type
    | var_name var_name var_name+  #Event_target_type_args
    ;

//FUNCTION DEF
fn_def
    : (MAPPED)?
        FN var_name
        args*
        (param_name | param)*
        '=' expr
    ;
args
    : var_name
    | by_ref
    ;
fn_return: RETURN expr;
//TRY EXPR
try_expr
    : TRY expr CATCH expr ;
//LOOPS
while_loop: WHILE expr DO expr ;
do_loop: DO expr WHILE expr ;
for_loop
    : FOR var_name(',' var_name (','var_name)?)? (IN | '=') for_sequence DO expr
    ;
for_sequence
    : expr for_while? for_where?
    | expr TO expr (BY expr)? for_while? for_where?
    ;
for_action: DO | COLLECT ;
for_while: WHILE expr ;
for_where : WHERE expr ;
loop_exit: EXIT (WITH expr)? ;
//CASE-EXPR
case_expr
: CASE expr? OF
    '('
        case_item+
    ')';
case_item : factor ':' expr ;
//IF-EXPR
if_expr
    : IF expr THEN expr (ELSE expr)?
    | IF expr DO expr
    ;
//DECLARATIONS
var_decl: DECLARATION decl (',' decl)* ;
decl: var_name ('=' expr)? ;
//ASSIGNMENT EXPRESSION
assignment : destination (EQ | ASSIGN) expr ;
// assignment : destination (EQ | ASSIGN) NL_OPT? expr ;

destination
    : var_name
    | propertyOrIndex
    //| propertyExpr
    //| indexExpr
    ;
// LOGIC EXPRESSION
logic_expr
    : NOT logical_operand
    | logic_expr (AND|OR) logical_operand
    ;
logical_operand
    : operand
    | compare_expr
    | fn_call
    ;
//COMPARE EXPRESSION
compare_expr
    : compare_operand COMPARE compare_operand
    ;
compare_operand
    //: fn_call
    //| operand
    : math_expr
    ;
//MATH EXPRESSIONS
math_expr
    : math_operand
    | <assoc=right> math_expr POW math_expr
    | math_expr PROD math_expr
    | math_expr DIV math_expr
    | math_expr PLUS math_expr
    // | math_expr PLUS NL? math_expr
    | math_expr MINUS math_expr
    // | <assoc=right> math_expr POW NL_OPT? math_expr
    // | math_expr PROD NL_OPT? math_expr
    // | math_expr DIV NL_OPT? math_expr
    // | math_expr PLUS EOL? math_expr
    // | math_expr MINUS NL_OPT? math_expr
    ;
math_operand
    : fn_call
    | operand
    ;
//FUNCTION CALL
fn_call
    : operand '(' ')'
    | operand operand+ //NL
    | operand param+ //NL
    | operand operand+ param+ //NL
    ;
//PARAMETER
param :  param_name operand ;
param_name : ALPHANUM ':' ;
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
    | by_ref
    | number
    | string
    | time
    | bool
    //| special
    | array
    | bitArray
    | point3
    | point2
    | box2
    | unary_minus //UNARY MINUS
    | expr_seq //mmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    | QUESTION
    ;
unary_minus : MINUS expr ;
expr_seq
    : '('
        (
            expr EOL?
            | expr (EOL expr)+
        )
      ')'
    | '(' ')'
    ;
//TYPES
box2: LBRACE expr ',' expr ',' expr ',' expr RBRACE ; 
point3: LBRACE expr ',' expr ',' expr RBRACE ;
point2 : LBRACE expr ',' expr RBRACE ;
//BitArray
bitArray : SHARP LCURLY bitList? RCURLY ;
bitList
    : bitList (',' bitList)+
    | expr DOTDOT expr
    | expr
    ;
//Array
array : SHARP LPAREN elementList? RPAREN ;
elementList : expr (',' expr)* ;
//IDENTIFIERS
var_name : ALPHANUM | SINGLEQUOT ;
by_ref: REF | DEREF ;
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
level_name
    : ALPHANUM | '_' | '*' | '?' | '\\'
    | SINGLEQUOT
    ;
bool
    : BOOL
    | ON
    ;
time: TIME ;
number: INT | DEG | HEX ;
string: STRING ;