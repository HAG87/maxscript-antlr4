/* $antlr-format
 * alignColons hanging,
 * alignSemicolons hanging,
 * allowShortBlocksOnASingleLine true,
 * allowShortRulesOnASingleLine true,
 * alignFirstTokens true,
 * minEmptyLines 1
 */
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
// THE ORDER OF FUNCTION CALLS IS BROKEN, IT NEEDS TO PRECEEDE OPERAND. MAYBE THIS WILL FIX WITH THE NL? MANAGMENT???
program
    : nl* expr (nl+ expr)* nl* EOF
    // : expr (NL expr)* EOF
    ;

//<program> ::= { <expr> }+

expr
    : simple_expr
    | var_decl
    | assignment_expr
    | assignmentOp_expr
    | if_clause
    | while_loop
    | do_loop
    | for_loop
    | loop_exit
    | case_expr
    | struct_def
    | try_expr   
    | fn_def
    | fn_return
    | context_expr
    | attributes_def
    | change_handler
    | utility_def
    | rollout_def
    | tool_def
    | rcmenu_def
    | macroscript_def
    | plugin_def
    ;

//-------------------------------------- MACROSCRIPT_DEF
macroscript_def
    : MACROSCRIPT nl? var_name ( nl? param_name nl? (operand | RESOURCE) )* nl?
    LPAREN
        (
            macroscript_clause
            (nl? macroscript_clause)*
        )?
    RPAREN
    ;
macroscript_clause
    : expr
    | event_handler
    ;

//-------------------------------------- UTILITY_DEF
utility_def
    : UTILITY nl? var_name nl? operand (nl? param)* nl?
    LPAREN
        (
            rollout_clause
            (nl? rollout_clause)*
        )?
    RPAREN
    ;

//-------------------------------------- ROLLOUT_DEF
rollout_def
    : ROLLOUT nl? var_name nl? operand (nl? param)* nl?
    LPAREN
        (
            rollout_clause
            (nl? rollout_clause)*
        )?
    RPAREN
    ;

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
    : GROUP nl? STRING? nl?
    LPAREN
        (
            rollout_control
            (nl? rollout_control)*
        )?
    RPAREN
    ;

rollout_control
    : RolloutControl nl? var_name nl? STRING? (nl? param)*
    ;

//-------------------------------------- TOOL_DEF
tool_def
    : TOOL nl? var_name (nl? param)* nl?
    LPAREN
        tool_clause
        (nl? tool_clause)+
    RPAREN
;

tool_clause
    : var_decl
    | fn_def
    | struct_def
    | event_handler
    ;

//-------------------------------------- RCMENU_DEF
rcmenu_def
    : RCMENU nl? var_name nl?
    LPAREN
        (
            rc_clause
            (nl? rc_clause)*
        )?
    RPAREN
    ;

rc_clause
    : var_decl
    | fn_def
    | struct_def
    | event_handler
    | rc_submenu
    | rc_menuitem
    | rc_separator
    ;

rc_submenu
    : SUBMENU nl? STRING (nl? param)*
    LPAREN
        (
            rc_clause
            (nl? rc_clause)*
        )?
    RPAREN
    ;

rc_separator: SEPARATOR nl? var_name (nl? param)*
    ;
rc_menuitem: MENUITEM nl? var_name nl? STRING (nl? param)*
    ;

//-------------------------------------- PLUGIN_DEF
plugin_def
    :PLUGIN nl? var_name nl? var_name (nl? param)* nl?
    LPAREN
        plugin_clause
        (nl? plugin_clause)+
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

//--------------------------------------  CHANGE_HANDLER
// when <attribute> <objects> change[s] [ id:<name> ] [handleAt:#redrawViews|#timeChange] [ <object_parameter> ] do <expr>
// when             <objects> deleted   [ id:<name> ] [handleAt:#redrawViews|#timeChange] [ <object_parameter> ] do <expr> 
change_handler
    : WHEN var_name (var_name | kw_override | path | expr_seq) (CHANGE | DELETED) param* operand? DO expr
    ;

//-------------------------------------- CONTEXT_EXPR
/*The full syntax for <context_expr> is:

<context> { , <context> } <expr>
where <context> is one of:

at level <node>
at time <time>
about <center_spec>
in <node>
[ in ] coordsys <coordsys>
[ with ] animate                     <boolean>
[ with ] undo                        <boolean>
[ with ] redraw                      <boolean>
[ with ] quiet                       <boolean>
[ with ] redraw                      <boolean>
[ with ] printAllElements            <boolean>
[ with ] defaultAction               <action>
[ with ] MXSCallstackCaptureEnabled  <boolean>
[ with ] dontRepeatMessages          <boolean>
[ with ] macroRecorderEmitterEnabled <boolean> */

context_expr
    : ctx_predicate (COMMA ctx_predicate)* expr
    ;

ctx_predicate
    : SET? nl?
        ( AT nl? LEVEL nl? operand
        | AT nl? TIME operand
        | IN nl? operand
        | ABOUT nl? (COORDSYS | operand)
        | IN?   nl? COORDSYS nl? (LOCAL | operand)
        | WITH? nl? CONTEXT  nl? (simple_expr | bool)
        | WITH? nl? UNDO     nl? (STRING | param | var_name) nl? (simple_expr | bool)
        )
    | WITH? nl? DEFAULTACTION nl? NAME
    ;

//-------------------------------------- PARAMETER DEF
param_expr
    : PARAMETERS var_name param*
    LPAREN
        (
            param_clause
            (nl? param_clause)*
        )?
    RPAREN
    ;

param_clause
    : param_def
    | event_handler
    ;

param_def: var_name nl? param*
    ;

//-------------------------------------- ATTRIBUTES DEFINITION
// attributes <name> [version:n] [silentErrors:t/f] [initialRollupState:0xnnnnn] [remap:#(<old_param_names_array>, <new_param_names_array>)]
attributes_def
    : ATTRIBUTES nl?
    var_name
    (nl? param)* nl?
    LPAREN
        attributes_clause
        (nl? attributes_clause)+
    RPAREN
    ;

attributes_clause
    : var_decl
    | event_handler
    | param_def
    | rollout_def
    ;

//-------------------------------------- EVENT HANDLER
event_handler
    : ON nl?
    en_args = event_args nl?
    (DO | RETURN) nl?
    ev_body = expr
    ;

event_args
    : ev_type = var_name
    | ev_target = var_name nl? ev_type = var_name
    | ev_target = var_name nl? ev_type = var_name (nl? ev_args += var_name)+
    ;

//---------------------------------------- STRUCT DEF
struct_def
    : STRUCT nl? str_name = var_name
    nl?
    LPAREN
        struct_members
    RPAREN
    ;

struct_members: struct_member (COMMA struct_member)* 
    ;

struct_member
    : scope = struct_scope? nl? assignment_expr
    | scope = struct_scope? nl? var_name
    | scope = struct_scope? nl? fn_def
    | scope = struct_scope? nl? event_handler
    ;

struct_scope: PUBLIC | PRIVATE
    ;

//---------------------------------------- FUNCTION DEF
fn_def
    : fn_mod = MAPPED? nl?
    fn_decl = FN nl?
    fn_name = var_name nl?
    (nl? fn_args)*
    (nl? fn_params)* nl?
    EQ
    fn_body = expr
    ;

fn_args
    : var_name
    | by_ref
    ;

fn_params
    : param_name
    | param
    ;

//FN_RETURN
fn_return: RETURN nl? expr
    ;

//---------------------------------------- LOOPS
// While loop
while_loop:
    WHILE nl? expr
    nl?
    DO nl ?expr
    ;

// Do loop
do_loop:
    DO nl? expr
    nl?
    WHILE nl? expr
    ;

// For loop
//for <var_name> [, <index_name>[, <filtered_index_name>]] ( in | = )<sequence> ( do | collect ) <expr>
for_loop
    : FOR nl? var = var_name (COMMA index_name = var_name (COMMA filtered_index_name = var_name)?)?
    for_operator  = (IN | EQ) nl? for_sequence
    for_action    = (DO | COLLECT) nl? expr
    ;

// for-sequence
//<expr> to <expr> [ by <expr> ] [while <expr>] [where <expr> ]
//<expr> to <expr> [ by <expr> ] [where <expr> ]
//<expr> [while <expr>] [ where<expr> ]
//<expr> [where <expr>]

for_sequence
    : expr nl?
        for_to nl?
        for_by? nl?
        for_while? nl?
        for_where?
    | expr NL?
        for_while? nl?
        for_where?
    ;

for_by:    BY    nl? expr;
for_to:    TO    nl? expr;
for_while: WHILE nl? expr;
for_where: WHERE nl? expr;
loop_exit: EXIT  nl? (WITH nl? expr)?;

//----------------------------------------TRY EXPR
try_expr
    : TRY nl? expr
    nl?
    CATCH nl? expr
    ;

//---------------------------------------- CASE-EXPR
case_expr
    : CASE nl? expr? nl? OF
        nl?
        LPAREN
            case_item
            (nl case_item)*
        RPAREN
        ;

// this is not correct, because if should work for 5:(a), buuuut.....
case_item
    : case_factor {this.noSpaces()}? COLON nl? expr
    | (NUMBER | TIMEVAL) {this.noSpaces()}? COLON ({!this.noSpaces()}? | nl) expr
    ;

case_factor
    : var_name
    | path
    | by_ref
    | bool
    | STRING
    | NAME
    // | NUMBER
    // | TIMEVAL
    | array
    | bitArray
    | point3
    | point2
    | box2
    | unary_minus
    | expr_seq
    | accessor
    ;

case_option
    : factor {this.noSpaces()}? COLON
    ;

//---------------------------------------- IF-CLAUSE
if_clause
    : IF nl? expr nl?
        THEN nl? expr nl?
        (ELSE nl? expr)?
    | IF nl? expr nl?
        DO nl? expr
    ;

//---------------------------------------- DECLARATIONS
var_decl
    : decl_scope nl? declaration (COMMA declaration)*
    ;

declaration
    : assignment_expr
    | var_name
    ;

decl_scope
    : LOCAL
    | GLOBAL
    | PERSISTENT nl? GLOBAL
    ;

//---------------------------------------- ASSIGNMENT EXPRESSION
assignment_expr
    : left = destination EQ right = expr
    ;

assignmentOp_expr
    : left = destination ASSIGN right = expr
    ;

destination
    : var_name
    | accessor
    ;

//---------------------------------------- SIMPLE_EXPR
/*
<simple_expr> ::=
    <operand>
    <math_expr>
    <compare_expr>
    <logical_expr>
    <function_call>
    <expr_seq>
 */
simple_expr
    : <assoc=right> left = simple_expr AS  right = simple_expr #TypecastExpr
    | <assoc=right> left = simple_expr POW right = simple_expr #ExponentExpr
    | left = simple_expr (DIV | PROD)                 right = simple_expr #ProductExpr
    | left = simple_expr (PLUS | MINUS | UNARY_MINUS) right = simple_expr #AdditionExpr
    | left = simple_expr (OR | AND) right = simple_expr #LogicExpr
    | NOT nl? right = simple_expr #LogicNOTExpr
    | right = simple_expr COMPARE left = simple_expr #ComparisonExpr   
    | fn_call #FnCallExpr    //passthrough
    | operand #OperandExpr   //passthrough
    ;

//---------------------------------------- FUNCTION CALL
//HOW TO SOLVE PROHIBITED / OPTIONAL / MANDATORY linebreaks????
// Until an EOL or lower precedence rule...????
// Positional Arguments
// Keyword Arguments
/*
A <function_call> has a lower precedence than an <operand>,
but it has a higher precedence than all the math,
comparison, and logical operations.
This means you have to be careful 
about correctly parenthesizing function arguments */

fn_call
    // : caller = fn_caller ( args += operand)+ ( params += param)*
    : caller = operand (args += operand_arg)+ (params += param)+
    | caller = operand (args += operand_arg)+
    | caller = operand (params += param)+
    | caller = operand PAREN_PAIR //nullary call operator
    // | operand
    ;
/*
fn_caller
    : var_name
    | accessor
    ;
*/
//---------------------------------------- PARAMETER
param
    : param_name nl? operand_arg
    ;

param_name
    : (var_name | kw_override) {this.noSpaces()}? COLON
    ;

operand_arg
    : factor_arg
    | accessor
    | unary_arg
    ;

factor_arg
    : var_name
    // | PATH
    | path
    | by_ref
    | bool
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

unary_arg
    : UNARY_MINUS operand_arg
    ;

//------------------------------------------------------------------------//
operand
    : accessor
    | factor
    ;
//------------------------------------------------------------------------//
accessor
    : <assoc=right> accessor property //#AccProperty
    | <assoc=right> accessor index    //#AccIndex
    | factor property                 //#AccProperty
    | factor index                    //#AccIndex
    ;
//------------------------------------------------------------------------//
//Property accessor
property
    : DOT (var_name | kw_override)
    ;

//Index accessor
index
    : LBRACK expr RBRACK
    ;

//---------------------------------------- FACTORS
factor
    : var_name
    // | PATH
    | path
    | by_ref
    | bool
    | STRING
    | NAME
    | NUMBER
    | TIMEVAL
    | array
    | bitArray
    | point3
    | point2
    | box2
    | unary_minus //UNARY MINUS
    | expr_seq //EXPRESSION SEQUENCE
    | QUESTION
    ;

//---------------------------------------- UNARY_MINUS
unary_minus 
    : (MINUS | UNARY_MINUS) operand
    // | MINUS expr_seq
    ;

//---------------------------------------- EXPR_SEQ
//<expr_seq> ::= ( <expr> { ( ; | <eol>) <expr> } )
expr_seq
    : LPAREN
    nl?
        // expr (expr)*
        //{this.enable(mxsLexer.NEWLINE_CHANNEL);}
        expr (nl+ expr)*
        //{this.disable(mxsLexer.NEWLINE_CHANNEL);}
    nl?
      RPAREN
    | LPAREN RPAREN
    | PAREN_PAIR
    ;

//---------------------------------------- TYPES
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

// BitArray
bitArray :
    SHARP nl? LBRACE
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

// Array
array :
    SHARP nl? LPAREN
        elementList?
    RPAREN
    | SHARP nl? PAREN_PAIR
    ;

elementList : expr ( COMMA expr )*
    ;
// Identifiers
var_name
    : GLOB? ID            #Id
    | GLOB? QUOTED        #QuotedId
    | GLOB? kw_reserved   #KeywordOverwrite
    ;

by_ref
    : REF
    | DEREF
    ;

// Path names
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
// Boolean
bool
    : BOOL
    | OFF
    | ON
    ;
//---------------------------------------- OVERRIDABLE KEYWORDS
// CONTEXTUAL KEYWORDS...can be used as identifiers outside the context...
kw_reserved
	: RolloutControl
	| CHANGE
	| DELETED
	| GROUP
	| LEVEL
	| MENUITEM
	| SEPARATOR
	| SET
	| SUBMENU
	| TIME
	;
kw_override
	: ATTRIBUTES
	| PARAMETERS
	| PLUGIN
	| RCMENU
	| RETURN
	| ROLLOUT
	| TO
	| TOOL
    | ON
	;
//---------------------------------------- NEWLINE RESOLVING
nl : NL+ ;
/*
eos
    : {this.lineTerminatorAhead()}?
    | EOF
    ;
*/