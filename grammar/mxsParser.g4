parser grammar mxsParser;

@header {
import { mxsParserBase } from "./mxsParserBase"
import { mxsLexer } from "./mxsLexer"
}

options {
    tokenVocab = mxsLexer;
    superClass = mxsParserBase;
    //language = TypeScript;
    //output = AST;
}

/*GRAMMAR RULES*/
program
    // : expr ({this.lineTerminatorAhead()}? expr)* EOF
    : expr (NL expr)* EOF
    ;
// THE ORDER OF FUNCTION CALLS IS BROKEN, IT NEEDS TO PRECEEDE OPERAND. MAYBE THIS WILL FIX WITH THE WS MANAGMENT???

//expr_iter: (expr EOL);
/*
<program> ::= { <expr> }+
<expr> ::= <simple_expr>
<variable_decls>
<assignment>
<if_expr>
<while_loop>
<do_loop>
<for_loop>
<loop_exit>
<case_expr>
<struct_def>
<try_expr>
<variable_decls>
<function_def>
<function_return>
<context_expr>
<max_command>
<utility_def>
<rollout_def>
<tool_def>
<rcmenu_def>
<macroscript_def>
<plugin_def>
 */
expr
    : simple_expr      #SimpleExpr
    // : {this.enable(mxsLexer.NEWLINE_CHANNEL);} NL {this.disable(mxsLexer.NEWLINE_CHANNEL);}simple_expr     #SimpleExpr
    // | var_decl        #VarDecl
    // | assignment      #Assign
    // | assignment_expr #AssignOp
    // | if_expr         #IfExpr
    // | while_loop      #WhileExpr
    // | do_loop         #DoExpr
    // | for_loop        #ForExpr
    // | loop_exit       #ExitExpr
    | case_expr       #CaseExpr
    // | struct_def      #StructDef
    // | try_expr        #TryExpr    
    | fn_def          #FnDef
    // | fn_return       #FnRet
    // | context_expr    #ContextExpr    
    // | attributes_def  #AttributesDef
    // | change_handler  #ChangeHandler
    // | utility_def     #UtilityDef
    // | rollout_def     #RolloutDef
    // | tool_def        #ToolDef
    // | rcmenu_def      #RcmenuDef
    // | macroscript_def #MacroscriptDef
    // | plugin_def      #PluginDef
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
    // {this.enable(mxsLexer.NEWLINE_CHANNEL);}
        NL?
        case_item       
        // case_item*
        (NL case_item)+
        NL?
    // {this.disable(mxsLexer.NEWLINE_CHANNEL);}
    RPAREN
    ;

case_item : case_option expr;

case_option
    : factor {this.noSpaces()}? COLON
    ;

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
    : assign_target=destination EQ NL? assign_expr=expr  #AssigmentExpression
    ;
assignment_expr
    : assign_target=destination ASSIGN NL? assign_expr=expr #AssigmentOperationExpression
    ;
destination
    : var_name
    | accessor
    ;
//-----------------------------------------------------------------------------//

// LOGIC EXPRESSION
//COMPARE EXPRESSION
//MATH EXPRESSIONS
/*
<simple_expr> ::= <operand>
<math_expr>
<compare_expr>
<logical_expr>
<function_call>
<expr_seq>
 */
simple_expr
    : <assoc=right> left=simple_expr  AS  NL? right=simple_expr #TypecastExpression
    | <assoc=right> left=simple_expr  POW NL? right=simple_expr #ExponentExpression

    | left=simple_expr (DIV | PROD)   NL? right=simple_expr #ProductExpression
    | left=simple_expr (PLUS | MINUS) NL? right=simple_expr #AdditionExpression

    | left=simple_expr (OR | AND) NL? right=simple_expr #LogicExpression
    | NOT NL? right=simple_expr #LogicNOTExpression

    | right=simple_expr COMPARE NL? left=simple_expr #ComparisonExpression

    // | <assoc=right> left=simple_expr ASSIGN right=simple_expr #AssigmentOperationExpression
    // | <assoc=right> left=simple_expr EQ     right=simple_expr #AssigmentExpression

    // : operand #OperandExpression
    | fn_call /* {this.disable(mxsLexer.NEWLINE_CHANNEL);} */ #FnCallExpression    //passthrough
    | operand    #OperandExpression   //passthrough
    ;


//FUNCTION CALL --- HOW TO MANAGE PROHIBITED / OPTIONAL / MANDATORY linebreaks????
// Until an EOL or lower precedence rule...????
fn_call
    // : {this.enable(mxsLexer.NEWLINE_CHANNEL);} caller = fn_caller (args += operand)+ (params += param)+ {this.disable(mxsLexer.NEWLINE_CHANNEL);}
    // | {this.enable(mxsLexer.NEWLINE_CHANNEL);} caller = fn_caller (args += operand)+ {this.disable(mxsLexer.NEWLINE_CHANNEL);}
    // | {this.enable(mxsLexer.NEWLINE_CHANNEL);} caller = fn_caller (params += param)+ {this.disable(mxsLexer.NEWLINE_CHANNEL);}

    // : caller = fn_caller ({this.noNewLines()}? args += operand)+ ({this.noNewLines()}? params += param)+
    // | caller= fn_caller ({this.noNewLines()}? args += operand)+
    // | caller= fn_caller ({this.noNewLines()}? params += param)+
    // | caller= fn_caller PAREN_PAIR
    
    : /* {this.disable(mxsLexer.NEWLINE_CHANNEL);} */ caller = fn_caller (args += operand)+ (params += param)+
    | /* {this.enable(mxsLexer.NEWLINE_CHANNEL);} */  caller = fn_caller /* {this.enable(mxsLexer.NEWLINE_CHANNEL);} */ (args += operand)+ /* {this.disable(mxsLexer.NEWLINE_CHANNEL);} */
    | /* {this.disable(mxsLexer.NEWLINE_CHANNEL);} */ caller = fn_caller (params += param)+
    | /* {this.disable(mxsLexer.NEWLINE_CHANNEL);} */ caller = fn_caller PAREN_PAIR /* {this.disable(mxsLexer.NEWLINE_CHANNEL);} */
    // | operand
    ;
    
fn_caller
    : var_name
    | accessor
    ;

//PARAMETER
param
    :  param_name operand
    ;

param_name
    : (var_name | KW_OVERRIDE) /* {this.noSpaces()}? */ COLON
    ;

//------------------------------------------------------------------------//

operand
    : factor   
    | accessor
    ;

accessor
    : <assoc=right> accessor property #AccProperty
    | <assoc=right> accessor index    #AccIndex
    | factor property                 #AccProperty
    | factor index                    #AccIndex
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
    // | PATH
    | path
    | by_ref
    | BOOL
    | STRING
    | NAME
    | NUMBER
    | TIMEVAL
    | array
    | bitArray
    | point3
    | point2
    | box2
    // | unary_minus //UNARY MINUS
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
        // {this.enable(mxsLexer.NEWLINE_CHANNEL);}
        NL?
        expr (NL expr)*
        NL?
        // {this.disable(mxsLexer.NEWLINE_CHANNEL);}
      RPAREN
    | (RPAREN LPAREN | PAREN_PAIR)
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
    SHARP LBRACE
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
    SHARP LPAREN
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