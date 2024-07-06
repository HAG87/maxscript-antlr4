parser grammar mxsParser;

@header {
import { mxsParserBase } from "./mxsParserBase"
}

options {
    tokenVocab = mxsLexer;
    superClass = mxsParserBase;
    //language = TypeScript;
    //output = AST;
}

/*GRAMMAR RULES*/
program
    // : expr* EOF
    : expr (eos expr)* EOF
    ;
// THE ORDER OF FUNCTION CALLS IS BROKEN, IT NEEDS TO PRECEEDE OPERAND. MAYBE THIS WILL FIX WITH THE WS MANAGMENT???

//expr_iter: (expr EOL);

expr
    : simple_expr      #SimpleExpr
    | var_decl         #VarDecl
    | assignment       #Assign
    | assignment_expr  #AssignOp
    | if_expr          #IfExpr
    | while_loop       #WhileExpr
    | do_loop          #DoExpr
    | for_loop         #ForExpr
    | loop_exit        #ExitExpr
    | case_expr        #CaseExpr
    | struct_def       #StructDef
    | try_expr         #TryExpr
    | fn_def           #FnDef
    | fn_return        #FnRet
    // | context_expr #ContextExpr
    // | attributes_def  #AttributesDef
    // | utility_def     #UtilityDef
    | rollout_def     #RolloutDef
    // | tool_def        #ToolDef
    // | rcmenu_def      #RcmenuDef
    // | macroscript_def #MacroscriptDef
    // | plugin_def      #PluginDef
    // | change_handler  #ChangeHandler
    ;

//------------------------------------------------------------------------//
//MACROSCRIPT_DEF
macroscript_def
    : MACROSCRIPT var_name (param_name (operand | RESOURCE))*
        LPAREN
            (expr | event_handler)*
        RPAREN
    ;

//UTILITY_DEF
utility_def
    : UTILITY var_name operand param*
        LPAREN
            rollout_clause*
        RPAREN
    ;

//ROLLOUT_DEF
rollout_def
    : ROLLOUT var_name operand param*
        LPAREN
            rollout_clause*
        RPAREN
    ;

//ROLLOUT CLAUSE
rollout_clause
    : var_decl
    | rollout_control
    | rollout_group
    | fn_def
    | struct_def
    | event_handler
    | tool_def
    | rollout_def
    ;

rollout_group
    : GROUP STRING? LPAREN rollout_control* RPAREN #RolloutGroup
    ;

rollout_control
    : RolloutControl var_name STRING? param* #RolloutControl
    ;

//TOOL_DEF
tool_def
    : TOOL var_name param*
        LPAREN
        (
            var_decl
            | fn_def
            | struct_def
            | event_handler
        )+
        RPAREN
    ;

//RCMENU_DEF
rcmenu_def
    : RCMENU var_name
        LPAREN
            rc_clause*
        RPAREN
    ;
rc_submenu
    : SUBMENU STRING param*
        LPAREN
            rc_clause*
        RPAREN
    ;
rc_separator: SEPARATOR var_name param*;
rc_menuitem: MENUITEM var_name STRING param*;
rc_clause
    : var_decl
    | fn_def
    | struct_def
    | event_handler
    | rc_submenu
    | rc_menuitem
    | rc_separator
    ;

//PLUGIN_DEF
plugin_def
    :PLUGIN var_name var_name param*
        LPAREN
            plugin_clause+
        RPAREN
    ;

plugin_clause
    : var_decl
    | fn_def
    | struct_def
    | tool_def
    | rollout_def
    | event_handler
    | param_def
    ;

//CHANGE_HANDLER
// when <attribute> <objects> change[s] [ id:<name> ] [handleAt:#redrawViews|#timeChange] [ <object_parameter> ] do <expr>
// when             <objects> deleted   [ id:<name> ] [handleAt:#redrawViews|#timeChange] [ <object_parameter> ] do <expr> 
change_handler
    : WHEN var_name (var_name | KW_OVERRIDE | path | expr_seq) (CHANGE | DELETED) param* operand? DO expr
    ;

//CONTEXT_EXPR
context_expr
    : ctx_predicate (COMMA ctx_predicate)* expr
    ;

ctx_predicate
    : (SET | AT) (LEVEL | TIME) operand
    | SET? IN operand
    | SET? ABOUT (COORDSYS | operand)
    | (SET | IN)? COORDSYS (LOCAL | operand)
    | (SET | WITH)? CONTEXT (simple_expr | BOOL)
    | (SET | WITH)? UNDO (STRING | param | var_name) (simple_expr | BOOL)
    | WITH? DEFAULTACTION NAME
    ;

//PARAMETER DEF
param_expr
    : PARAMETERS var_name param*
        LPAREN
            (param_def | event_handler)*
        RPAREN
        ;
// param_clause : param_def | event_handler ;
param_def: var_name param*;

// ATTRIBUTES DEFINITION
// attributes <name> [version:n] [silentErrors:t/f] [initialRollupState:0xnnnnn] [remap:#(<old_param_names_array>, <new_param_names_array>)]
attributes_def
    : ATTRIBUTES var_name var_name param var_name param*
        LPAREN
            attributes_clause+
        RPAREN
        ;
attributes_clause
    : var_decl
    | event_handler
    | param_def
    | rollout_def
    ;
//------------------------------------------------------------------------//
//STRUCT DEF
struct_def
    : STRUCT str_name= var_name
    LPAREN
        struct_members
    RPAREN ;
struct_members: struct_member (COMMA struct_member)* ;
struct_member
    : struct_scope? (assignment | var_name)
    | struct_scope? fn_def
    | struct_scope? event_handler
    //| struct_scope struct_member
    ;
struct_scope: PUBLIC | PRIVATE ;

//EVENT HANDLER
event_handler
    : ON en_args= event_args (DO | RETURN) ev_body= expr ;
event_args
    : ev_type= var_name
    | var_name ev_target_type= var_name
    | var_name var_name ev_target_type_args= var_name+
    ;

//FUNCTION DEF
fn_def
    : fn_mod= MAPPED? fn_decl= FN fn_name= var_name
        fn_args*
        fn_params*
        EQ fn_body= expr
    ;

fn_args: var_name | by_ref ;
fn_params: param_name | param;

//FN_RETURN
fn_return: RETURN expr;

//TRY EXPR
try_expr:
    TRY expr
    CATCH expr
    ;

//LOOPS
//while loop
while_loop:
    WHILE expr
    DO expr
    ;

//do loop
do_loop:
    DO expr
    WHILE expr
    ;

//for loop
//for <var_name> [, <index_name>[, <filtered_index_name>]] ( in | = )<sequence> ( do | collect ) <expr>
for_loop
    : FOR var=var_name (COMMA index_name=var_name (COMMA filtered_index_name=var_name)?)?
    for_operator=(IN | EQ) for_sequence
    for_action=(DO | COLLECT) expr
    ;

// for-sequence
//<expr> to <expr> [ by <expr> ] [while <expr>] [where <expr> ]
//<expr> to <expr> [ by <expr> ] [where <expr> ]
//<expr> [while <expr>] [ where<expr> ]
//<expr> [where <expr>]

for_sequence
    : expr for_to for_by? for_while? for_where?
    | expr for_while? for_where?
    ;

for_by: BY expr ;
for_to: TO expr ;
for_while: WHILE expr ;
for_where: WHERE expr ;
loop_exit: EXIT (WITH expr)? ;

//CASE-EXPR
case_expr
: CASE expr? OF
    LPAREN
        case_item (eos case_item)*
    RPAREN
    ;

case_item : factor {this.noSpaces()}? COLON expr ;

//IF-EXPR
if_expr
    : IF expr
        THEN expr
        (ELSE expr)?
    | IF expr
        DO expr
    ;

//DECLARATIONS
var_decl
    // : decl_scope? declaration (COMMA declaration)*
    : decl_scope declaration (COMMA declaration)*
    ;
// /*
declaration
    : assignment
    | var_name
    ;
//  */
// /*
decl_scope
    : LOCAL
    | GLOBAL
    | PERSISTENT
    ;
// */
//ASSIGNMENT EXPRESSION
assignment
    : assign_target=destination {this.noNewLines()}? EQ assign_expr=expr  #AssigmentExpression
    ;
assignment_expr
    : assign_target=destination {this.noNewLines()}? ASSIGN assign_expr=expr #AssigmentOperationExpression
    ;
destination
    : var_name
    | accessor
    ;
//-----------------------------------------------------------------------------//

// LOGIC EXPRESSION
//COMPARE EXPRESSION
//MATH EXPRESSIONS

simple_expr
    : NOT right=simple_expr #LogicNOTExpression
    | left=simple_expr {this.noNewLines()}? OR  right=simple_expr #LogicORExpression
    | left=simple_expr {this.noNewLines()}? AND right=simple_expr #LogicANDExpression

    | right=simple_expr {this.noNewLines()}? COMPARE left=simple_expr #ComparisonExpression

    | <assoc=right> left=simple_expr {this.noNewLines()}? AS  right=simple_expr #TypecastExpression
    | <assoc=right> left=simple_expr {this.noNewLines()}? POW right=simple_expr #ExponentExpression

    | left=simple_expr {this.noNewLines()}? (DIV | PROD)      right=simple_expr #ProductExpression
    | left=simple_expr {this.noNewLines()}? (PLUS | MINUS)    right=simple_expr #AdditionExpression
    
    // | <assoc=right> left=simple_expr {this.noNewLines()}? ASSIGN right=simple_expr #AssigmentOperationExpression
    // | <assoc=right> left=simple_expr {this.noNewLines()}? EQ     right=simple_expr #AssigmentExpression

    | operand    #OperandExpression   //passthrough
    | fn_call    #FnCallExpression    //passthrough
    ;

//FUNCTION CALL --- HOW TO MANAGE PROHIBITED / OPTIONAL / MANDATORY linebreaks????
// Until an EOL or lower precedence rule...????
fn_call
    : caller = operand 
        ({this.noNewLines()}? args+=operand)+ //eos //{this.SimpleExprAhead()}?
    | caller = operand 
        ({this.noNewLines()}? args+=operand)+
        ({this.noNewLines()}? params+=param)+
    | caller = operand
        ({this.noNewLines()}? params+=param)+
    | caller = operand {this.noNewLines()}? LPAREN {this.noSpaces()}? RPAREN
    ;

/*
caller
    : var_name
    | accessor
    // | path
    | expr_seq
    ;
// */

//PARAMETER
param
    :  param_name operand
    ;
param_name
    : (ID | KW_OVERRIDE) {this.noSpaces()}? COLON
    ;

//------------------------------------------------------------------------//

operand
    : factor   
    | accessor
    ;

accessor
    : <assoc=right> accessor {this.noNewLines()}? property #AccProperty
    | <assoc=right> accessor {this.noNewLines()}? index    #AccIndex
    | factor {this.noNewLines()}? property                 #AccProperty
    | factor {this.noNewLines()}? index                    #AccIndex
    ;

//Property accessor
property
    : DOT (var_name | KW_OVERRIDE)
    ;

//Index accessor
index
    : LBRACK expr RBRACK
    ;

//FACTORS
factor
    : var_name
    | NAME
    | path
    // | PATH
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

unary_minus 
    : MINUS operand
// | MINUS expr_seq
    ;

//  <expr_seq> ::= ( <expr> { ( ; | <eol>) <expr> } )
expr_seq
    : LPAREN
        // expr (expr)*
        expr (eos expr)*
      RPAREN
    ;
//------------------------------------------------------------------------//
//TYPES
box2:
    LBRACK
        expr COMMA
        expr COMMA
        expr COMMA
        expr
    RBRACK
    ;

point3:
    LBRACK
        expr COMMA
        expr COMMA
        expr
    RBRACK
    ;

point2:
    LBRACK
        expr COMMA
        expr
    RBRACK
    ;

//BitArray
bitArray :
    SHARP {this.noNewLines()}? LBRACE
        bitList?
    LBRACE
    ;

bitList
    : bitexpr ( COMMA bitexpr)*
    ;
bitexpr
    : expr DOTDOT expr
    | expr
    ;

//Array
array :
    SHARP {this.noNewLines()}? LPAREN
        elementList?
    RPAREN
    ;

elementList : expr ( COMMA expr )* ;

//IDENTIFIERS
var_name
    : GLOB? ID            #Id
    | GLOB? QUOTED        #QuotedId
    | GLOB? KW_RESERVED   #KeywordOverwrite
    ;

by_ref
    : REF   #Ref
    | DEREF #DeRef
    ;

//Path names
path: PATH ;
/*
path
    : DOLLAR {this.noSpaces()}? levels?
    ;
levels
    : level_name ( {this.noSpaces()}? '/' {this.noSpaces()}? level_name)*
    ;
level_name
    : ( ID | PROD | QUESTION | BACKSLASH)
    | QUOTED
    ;
*/

eos
    : {this.lineTerminatorAhead()}?
    // | EOF
    ;