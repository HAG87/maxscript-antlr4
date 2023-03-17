parser grammar mxsParser;
options {
    tokenVocab = mxsLexer;
    superClass = mxsParserBase;
    //output = AST;
}

/*GRAMMAR RULES*/
program
    : expr* EOF
    ;

expr
    : simple_expr #SimpleExpr
    | var_decl    #VarDecl
    | assignment  #Assign
    | if_expr     #IfExpr
    | while_loop  #WhileExpr
    | do_loop     #DoExpr
    | for_loop    #ForExpr
    | loop_exit   #ExitExpr
    | case_expr   #CaseExpr
    | try_expr    #TryExpr
    | fn_def      #FnDef
    | fn_return   #FnRet
    | struct_def  #StructDef
    ;

simple_expr
    : fn_call
    | operand
    | math_expr
    | logic_expr
    | compare_expr
    ;
//CONTEXT
//PARAMETER DEF
//STRUCT DEF
struct_def
    : STRUCT {noNewLines()}? var_name
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
    : MAPPED? FN var_name EOL?
        args*
        (param_name | param)*
        EQ expr
    ;
args
    : var_name
    | by_ref
    ;
//FN_RETURN
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
        case_item+
    RPAREN;
case_item : factor {noSpaces()}? ':' expr ;
//IF-EXPR
if_expr
    : IF expr THEN expr (ELSE expr)?
    | IF expr DO expr
    ;

//DECLARATIONS
var_decl: DECL? decl (COMMA decl)* ;
decl: var_name ({noNewLines()}? EQ expr)? ;

//ASSIGNMENT EXPRESSION
assignment: destination {noNewLines()}? (ASSIGN | EQ) expr ;
destination
    : var_name
    | propertyOrIndex
    ;
 //-----------------------------------------------------------------------------//
 // LOGIC EXPRESSION
logic_expr
    : NOT logical_operand
    | logic_expr {noNewLines()}? ( AND | OR ) logic_expr
    | logical_operand
    ;
logical_operand
    : operand
    | compare_expr
    | fn_call
    ;
//COMPARE EXPRESSION
compare_expr
    : compare_expr {noNewLines()}? COMPARE compare_expr
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
    : <assoc=right> math_expr {noNewLines()}? POW math_expr #Exponent
    | math_expr {noNewLines()}? (DIV | PROD) math_expr      #Product
    | math_expr {noNewLines()}? (PLUS | MINUS) math_expr    #Addition
    | operand                               #MathOperand
    ;
math_operand
    : fn_call
    | operand
    ;
//FUNCTION CALL --- HOW TO MANAGE PROHIBITED / OPTIONAL / MANDATORY linebreaks????
fn_call
    :  id=caller 
        ({noNewLines()}? arg+=operand)+
        ({noNewLines()}? params+=param)*
    | id=caller
        ({noNewLines()}? param)+
    ;
caller
    : var_name
    | propertyOrIndex
    | path
    | expr_seq
    ;
//PARAMETER
param :  param_name operand ;
param_name : ID {noSpaces()}? ':' ;
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
property : DOT {noSpaces()}? var_name ;
//Index accessor
index : LBRACE expr RBRACE;
//FACTORS
factor
    : var_name
    | NAME
    | path
    | by_ref
    | NUMBER
    | STRING
    | TIMEVAL
    | BOOL
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
        expr*
      RPAREN
    ;
//------------------------------------------------------------------------//
//TYPES
box2:   LBRACE expr COMMA expr COMMA expr COMMA expr RBRACE;
point3: LBRACE expr COMMA expr COMMA expr RBRACE;
point2: LBRACE expr COMMA expr RBRACE;
//BitArray
bitArray : SHARP {noNewLines()}? LCURLY bitList? RCURLY ;

bitList : bitexpr ( COMMA bitexpr)* ;
bitexpr
    : expr DOTDOT expr
    | expr
    ;

//Array
array : SHARP {noNewLines()}? LPAREN elementList? RPAREN ;
elementList : expr ( COMMA expr)* ;

//IDENTIFIERS
var_name : ID | SINGLEQUOT ;
by_ref
    : REF #Ref
    | DEREF #DeRef;

//Path names
path: DOLLAR {noSpaces()}? levels?;
levels : level_name ( {noSpaces()}? '/' {noSpaces()}? level_name)* ;
level_name
    : ID | '*' | '?' | '\\'
    | SINGLEQUOT
    ;