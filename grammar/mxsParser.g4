parser grammar mxsParser;
options {
    tokenVocab = mxsLexer;
    //output = AST;
}

/*GRAMMAR RULES*/
program
    : expr (EOL expr)* EOF
    ;

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
    : operand
    | fn_call
    | math_expr
    | compare_expr
    | logic_expr
    ;
//CONTEXT
//PARAMETER DEF
//STRUCT DEF
struct_def
    : STRUCT var_name
    LPAREN
        struct_member (COMMA struct_member)*
    RPAREN ;
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
    : FN var_name EOL?
        (args)*
        ((param_name | param))*
        EQ expr
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
    : FOR var_name(COMMA var_name (COMMA var_name)?)? (IN | EQ) for_sequence DO expr
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
    LPAREN
        (case_item EOL)+
    RPAREN;
case_item : factor DOUBLEDOT expr ;
//IF-EXPR
if_expr
    : IF expr THEN  expr (ELSE expr)?
    | IF expr DO expr
    ;

//DECLARATIONS
var_decl: DECLARATION decl (COMMA decl)* ;
decl: var_name WS? (EQ WS? expr)? ;

//ASSIGNMENT EXPRESSION
assignment: destination (ASSIGN | EQ) expr ;
destination
    : var_name
    | propertyOrIndex
    //| propertyExpr
    //| indexExpr
    ;
 //-----------------------------------------------------------------------------//
 // LOGIC EXPRESSION
logic_expr
    : NOT logical_operand
    | logic_expr WS? ( AND | OR ) WS? logic_expr
    | logical_operand
    ;
logical_operand
    : operand
    | compare_expr
    | fn_call
    ;
//COMPARE EXPRESSION
compare_expr
    : compare_expr WS? COMPARE WS? compare_expr
    | math_expr
    ;
compare_operand
    : math_expr
    /*: fn_call
    | operand
    | math_expr*/
    ;
//MATH EXPRESSIONS
math_expr
    : <assoc=right> math_expr WS? POW math_expr #Exponent
    | math_expr WS? (DIV | PROD) math_expr      #Product
    | math_expr WS? (PLUS | MINUS) math_expr    #Addition
    | operand                                   #MathOperand
    ;
math_operand
    : fn_call
    | operand
    ;
//FUNCTION CALL --- HOW TO MANAGE PROHIBITED / OPTIONAL / MANDATORY linebreaks????
fn_call
    :  caller 
        (WS? /*{_input.LA(-1).getType() != EOL}?*/ operand)+
        (WS? /*{_input.LA(-1).getType() != EOL}?*/ param)*
    | caller
        (WS? /*{_input.LA(-1).getType() != EOL}?*/ param)+
    ;
caller
    : var_name
    | propertyOrIndex
    | path
    | expr_seq
    ;
//PARAMETER
param :  param_name operand ;
param_name : ALPHANUM DOUBLEDOT ;
//------------------------------------------------------------------------//
operand
    : factor
    | propertyOrIndex
    ;
propertyOrIndex
    : <assoc=right> propertyOrIndex property #PropertyExprIt
    | <assoc=right> propertyOrIndex index    #IndexExprIt
    | factor property                        #PropertyExpr
    | factor index                           #IndexExpr
    ;
//Property accessor
property : DOT var_name ;
//Index accessor
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
    | expr_seq //EXPRESSION SEQUENCE
    | QUESTION
    ;
unary_minus : MINUS expr ;
expr_seq
    : LPAREN
        (
            expr (EOL expr)*
        )?
      RPAREN
    ;
//------------------------------------------------------------------------//
//TYPES
box2:   LBRACE expr COMMA expr COMMA expr COMMA expr RBRACE;
point3: LBRACE expr COMMA expr COMMA expr RBRACE;
point2: LBRACE expr COMMA expr RBRACE;
//BitArray
bitArray : SHARP LCURLY bitList? RCURLY ;

bitList : bitexpr ( COMMA bitexpr)* ;
bitexpr
    : expr DOTDOT expr
    | expr
    ;

//Array
array : SHARP LPAREN elementList? RPAREN ;
elementList : expr ( COMMA expr)+ ;

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