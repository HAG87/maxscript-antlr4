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
// THE ORDER OF FUNCTION CALLS IS BROKEN, IT NEEDS TO PRECEEDE OPERAND. MAYBE THIS WILL FIX WITH THE WS MANAGMENT???
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
    | struct_def  #StructDef
    | try_expr    #TryExpr
    | fn_def      #FnDef
    | fn_return   #FnRet
    | context_expr #ContextExpr
    // | max_command
    | attributes_def  #AttributesDef
    | utility_def     #UtilityDef
    | rollout_def     #RolloutDef
    | tool_def        #ToolDef
    | rcmenu_def      #RcmenuDef
    | macroscript_def #MacroscriptDef
    | plugin_def      #PluginDef
    | change_handler  #ChangeHandler
    ;

simple_expr
    : fn_call
    // : operand
    | operand
    | math_expr
    | compare_expr
    | logic_expr
    // | fn_call
    // | expr_seq
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
    : GROUP STRING? LPAREN rollout_control* RPAREN #RolloutGroup;
rollout_control
    : RolloutControl var_name STRING? param* #RolloutControl;

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
    : WHEN var_name (var_name | KW_OVERIDE | path | expr_seq) (CHANGE | DELETED) param* operand? DO expr;

//CONTEXT_EXPR
context_expr
    : ctx_predicate (COMMA ctx_predicate)* expr;

ctx_predicate
    : (SET | AT) (LEVEL | TIME) operand
    | SET? IN operand
    | SET? ABOUT (COORDSYS | operand)
    | (SET | IN)? COORDSYS (LOCAL | operand)
    | (SET | WITH)? CONTEXT (logic_expr | BOOL)
    | (SET | WITH)? UNDO (STRING | param | var_name) (logic_expr | BOOL)
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

//EVENT HANDLER
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
//while loop
while_loop: WHILE expr DO expr ;

//do loop
do_loop: DO expr WHILE expr ;

//for loop
//for <var_name> [, <index_name>[, <filtered_index_name>]] ( in | = )<sequence> ( do | collect ) <expr>
for_loop
    : FOR var_name (COMMA var_name (COMMA var_name)?)? (IN | EQ) for_sequence (DO | COLLECT) expr ;
// for-sequence
//<expr> to <expr> [ by <expr> ] [while <expr>] [where <expr> ]
//<expr> to <expr> [ by <expr> ] [where <expr> ]
//<expr> [while <expr>] [ where<expr> ]
//<expr> [where <expr>]
for_sequence
    : expr for_while? for_where?
    | expr TO expr (BY expr)? for_while? for_where?
    ;
for_while: WHILE expr ;
for_where: WHERE expr ;
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
    | accessor
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
    | fn_call
    /*| operand
    | math_expr*/
    ;

//MATH EXPRESSIONS
math_expr
    : <assoc=right> math_expr {noNewLines()}? AS math_expr  #Typecast
    | <assoc=right> math_expr {noNewLines()}? POW math_expr #Exponent
    | math_expr {noNewLines()}? (DIV | PROD) math_expr      #Product
    | math_expr {noNewLines()}? (PLUS | MINUS) math_expr    #Addition
    | operand                               #MathOperand
    | fn_call                               #FnCall
    ;

math_operand
    : operand
    | fn_call
    ;
//FUNCTION CALL --- HOW TO MANAGE PROHIBITED / OPTIONAL / MANDATORY linebreaks????
// Until an EOL or lower precedence rule...
fn_call
    :  id=caller 
        ({noNewLines()}? arg+=operand)+
        ({noNewLines()}? params+=param)*
    | id=caller
        ({noNewLines()}? param)+
    | caller {noSpaces()}? EMPTYPARENS
    ;
// /*
caller
    : var_name
    | accessor
    | path
    | expr_seq
    ;
// */
//PARAMETER
param :  param_name operand ;
param_name : (ID | KW_OVERIDE) {noSpaces()}? ':' ;

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
property : DOT {noSpaces()}? (var_name | KW_OVERIDE) ;

//Index accessor
index : '[' expr ']' ;

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

unary_minus 
: MINUS operand
// | MINUS expr_seq
;

expr_seq
    : LPAREN
        expr*
      RPAREN
    ;
//------------------------------------------------------------------------//
//TYPES
box2:   '[' expr COMMA expr COMMA expr COMMA expr ']' ;
point3: '[' expr COMMA expr COMMA expr ']' ;
point2: '[' expr COMMA expr ']' ;

//BitArray
bitArray : SHARP {noNewLines()}? '{' bitList? '}' ;
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
    | DEREF #DeRef
    ;

//Path names
path: DOLLAR {noSpaces()}? levels?;
levels : level_name ( {noSpaces()}? '/' {noSpaces()}? level_name)* ;
level_name
    : ID | '*' | '?' | '\\'
    | SINGLEQUOT
    ;