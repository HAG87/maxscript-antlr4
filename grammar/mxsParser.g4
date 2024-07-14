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
/*
expr
    : simple_expr
    | var_decl
    | assignment_expr
    | assignmentOp_expr
    | while_loop
    | do_loop
    | for_loop
    | loop_exit
    | if_statement
    | case_expr
    | struct_def
    | try_expr   
    | fn_def
    | fn_return
    | context_expr
    | attributes_def
    | when_construct
    | utility_def
    | rollout_def
    | tool_def
    | rcmenu_def
    | macroscript_def
    | plugin_def
    ;
*/
// /*
expr
    : non_if_expr
    | if_statement
    ;

non_if_expr
    : simple_expr
    | var_decl
    | assignment_expr
    | assignmentOp_expr
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
    | when_construct
    | utility_def
    | rollout_def
    | tool_def
    | rcmenu_def
    | macroscript_def
    | plugin_def
    ;
// */

//-------------------------------------- MACROSCRIPT_DEF
macroscript_def
    : MACROSCRIPT nl? var_name ( nl? param_name nl? (operand | RESOURCE) )* nl?
    lp
        (
            macroscript_clause
            (nl? macroscript_clause)*
        )?
    rp
    ;
macroscript_clause
    : expr
    | event_handler
    ;

//-------------------------------------- UTILITY_DEF
utility_def
    : UTILITY nl? var_name nl? operand (nl? param)* nl?
    lp
        (
            rollout_clause
            (nl? rollout_clause)*
        )?
    rp
    ;

//-------------------------------------- ROLLOUT_DEF
rollout_def
    : ROLLOUT nl? var_name nl? operand (nl? param)* nl?
    lp
        (
            rollout_clause
            (nl? rollout_clause)*
        )?
    rp
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
    lp
        (
            rollout_control
            (nl? rollout_control)*
        )?
    rp
    ;

rollout_control
    : RolloutControl (nl? operand)+ (nl? param)*
    ;

//-------------------------------------- TOOL_DEF
tool_def
    : TOOL nl? var_name (nl? param)* nl?
    lp
        tool_clause
        (nl? tool_clause)+
    rp
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
    lp
        (
            rc_clause
            (nl? rc_clause)*
        )?
    rp
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
    : SUBMENU nl? STRING (nl? param)* nl?
    lp
        (
            rc_clause
            (nl? rc_clause)*
        )?
    rp
    ;

rc_separator: SEPARATOR nl? var_name (nl? param)*
    ;
rc_menuitem: MENUITEM nl? var_name nl? STRING (nl? param)*
    ;

//-------------------------------------- PLUGIN_DEF
plugin_def
    :PLUGIN nl? var_name nl? var_name (nl? param)* nl?
    lp
        plugin_clause
        (nl? plugin_clause)*
    rp
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
// objects var_name | path | array

when_construct
    :  when_decl nl? DO nl? expr
    ;

when_decl
    : WHEN nl? var_name nl? //attribute
        (var_name | path | expr_seq | array) nl? //objects
        CHANGE nl? //change
        (nl? param)* //parameters
        (nl? var_name)? //object_parameter
    | WHEN (var_name | path | expr_seq | array) nl? //objects
        DELETED nl? //change
        (nl? param)* //parameters
        (nl? operand)? //object_parameter
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
[ with ] macroRecorderEmitterEnabled <boolean>

set <context>      
Where, <context> is one of the MAXScript context prefixes: 
animate,
time,
in,
coordsys,
about,
level,
undo
*/

context_expr : ctx_cascading | ctx_set;

ctx_cascading
    : ctx_predicate (comma ctx_predicate)* nl? expr
    ;

ctx_set
    : SET (ANIMATE | TIME | IN | LEVEL ) nl? operand
    | SET COORDSYS  nl? (LOCAL | operand)
    | SET ABOUT     nl? (COORDSYS | operand)
    | SET UNDO      nl? (STRING | param | var_name)? nl? simple_expr
    ;

ctx_predicate
    : AT nl? (LEVEL | TIME) nl? operand
    | IN nl? operand
    | ABOUT nl? (COORDSYS | operand)
    | IN?   nl? COORDSYS      nl? (LOCAL | operand)
    | WITH? nl? UNDO          nl? (STRING | param | var_name)? nl? simple_expr        
    | WITH? nl? DEFAULTACTION nl? NAME
    | WITH? nl? ctx_keyword   nl? simple_expr
    ;

ctx_keyword
	: ANIMATE
	| DONTREPEATMESSAGES
	| MACRORECORDEREMITERENABLED
	| MXSCALLSTACKCAPTUREENABLED
	| PRINTALLELEMENTS
	| QUIET
	| REDRAW
	;
//-------------------------------------- PARAMETER DEF
param_def
    : PARAMETERS nl? var_name (nl? param)* nl?
    lp
        (
            param_clause
            (nl? param_clause)*
        )?
    rp
    ;

param_clause
    : param_expr
    | event_handler
    ;

param_expr: var_name (nl? param)*
    ;

//-------------------------------------- ATTRIBUTES DEFINITION
// attributes <name> [version:n] [silentErrors:t/f] [initialRollupState:0xnnnnn] [remap:#(<old_param_names_array>, <new_param_names_array>)]
attributes_def
    : ATTRIBUTES nl?
    var_name
    (nl? param)* nl?
    lp
        attributes_clause
        (nl? attributes_clause)*
    rp
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
    : STRUCT nl? str_name = var_name nl?
    lp
       struct_members
    rp
    ;

struct_members: struct_member (comma struct_member)* 
    ;

struct_member
    : (scope = struct_scope nl?)? assignment_expr
    | (scope = struct_scope nl?)? var_name
    | (scope = struct_scope nl?)? fn_def
    | (scope = struct_scope nl?)? event_handler
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
    EQ nl?
    fn_body = expr
    ;

fn_args
    : var_name
    // | de_ref
    ;

fn_params
    : param
    | param_name
    ;

//FN_RETURN
fn_return: RETURN nl? expr
    ;

//---------------------------------------- LOOPS
// While loop
while_loop:
    WHILE nl? expr nl?   
    DO nl? expr
    ;

// Do loop
do_loop:
    DO nl? expr nl?   
    WHILE nl? expr
    ;

// For loop
//for <var_name> [, <index_name>[, <filtered_index_name>]] ( in | = )<sequence> ( do | collect ) <expr>
for_loop
    : FOR nl? var = var_name (comma index_name = var_name (comma filtered_index_name = var_name)?)?
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
    | expr nl?
        for_while? nl?
        for_where?
    ;

for_by:    BY    nl? expr;
for_to:    TO    nl? expr;
for_while: WHILE nl? expr;
for_where: WHERE nl? expr;
loop_exit: EXIT  ( nl? WITH nl? expr)?
    ;

//----------------------------------------TRY EXPR
try_expr
    : TRY nl? expr nl?   
    CATCH nl? expr
    ;

//---------------------------------------- CASE-EXPR
case_expr
    : CASE nl? expr? nl? OF nl?       
        lp
            case_item
            (nl case_item)*
        rp
        ;


// This will prodice errors at compile time...
case_item
    : factor COLON nl? expr
    ;
/*
// this is not correct, because if should work for 5:(a), buuuut.....
case_item
    : case_factor COLON nl? expr
    | (NUMBER | TIMEVAL) COLON (nl | {!this.noSpaces()}?) expr
    ;

case_factor
    : accessor
    | var_name
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
    ;

case_option
    : {this.colonBeNext()}? factor COLON
    ;
*/
//---------------------------------------- IF-CLAUSE
/*
('else' e | {_input.LA(1) != ELSE}?)
ifStatement
  : 'if' expression 'then' (statement | block) 'else' (statement | block)
  | 'if' expression 'then' (statementNoIf | block)
  ;
*/

/*
statement
    : non_if_statement
    | if_statement
;

if_statement
    : 'if' parExpression 
         ifBody= ( non_if_statement 'else' elseBody=statement
                   | if_statement )
;  
*/
/*
stmt
    : matched_stmt
    ∣ open_stmt
    ;
matched_stmt
    : if expr then matched_stmt else matched_stmt
    ∣ other
    ;
open_stmt
    : if expr then stmt
    ∣ if expr then matched_stmt else open_stmt
    ;
*/

// /* // this does work but it is slooow
if_statement
    : IF nl? expr nl? 
         ( THEN nl? non_if_expr nl? ELSE nl? expr
            | (THEN | DO) nl? expr
            | if_statement )
    ;
/*
    : IF nl? expr nl? THEN nl? expr     
    | IF nl? expr nl? 
         ( THEN nl? non_if_expr nl? ELSE nl? expr
            // | THEN nl? expr
            | if_statement )
*/
// */
/* // this fails for whatever reason with SLL
if_statement
    : IF nl? ifClause = expr nl? THEN nl? ifBody = expr nl? (ELSE nl? elseBody = expr | {this.itsNot(mxsLexer.ELSE)}? )
    | IF nl? ifClause = expr nl? DO nl? ifBody = expr
    ;
*/
//---------------------------------------- DECLARATIONS
var_decl
    : decl_scope nl? declaration (comma declaration)*
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
    : left = destination EQ nl? right = expr
    ;

assignmentOp_expr
    : left = destination ASSIGN nl? right = expr
    ;

destination
    : accessor
    | de_ref
    | var_name
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
    : <assoc=right> left = simple_expr AS  nl? classname #TypecastExpr
    | <assoc=right> left = simple_expr POW nl? right = simple_expr #ExponentExpr
    | left = simple_expr (PROD | DIV) nl? right = simple_expr #ProductExpr
    | left = simple_expr (PLUS | MINUS | UNARY_MINUS) nl? right = simple_expr #AdditionExpr
    | left = simple_expr (OR | AND) nl? right = simple_expr #LogicExpr
    | right = simple_expr COMPARE nl? left = simple_expr #ComparisonExpr  
    | NOT nl? right = simple_expr #LogicNOTExpr
    | (MINUS | UNARY_MINUS) simple_expr #UnaryExpr    //passthrough
    | fn_call #FnCallExpr    //passthrough
    | de_ref #byRef
    | operand #OperandExpr   //passthrough
    ;

classname : var_name | expr_seq;
//---------------------------------------- FUNCTION CALL
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
    : caller = fn_caller (
        // PAREN_PAIR //nullary call operator
        paren_pair //nullary call operator
        | (args += operand_arg)+ (params += param)*
        // | (args += operand_arg)+
        | (params += param)+
    )
    // | operand
    ;

paren_pair
        : {this.closedParens()}? LPAREN RPAREN
        ;

fn_caller
    : var_name
    | path
    | de_ref
    | accessor
    // | unary_minus //UNARY MINUS
    | expr_seq //EXPRESSION SEQUENCE
    | QUESTION
    ;

//---------------------------------------- PARAMETER
param
    : param_name nl? operand_arg
    ;

param_name
    : {this.colonBeNext()}? (var_name | kw_override) COLON
    ;

operand_arg
    : UNARY_MINUS? accessor
    | UNARY_MINUS? factor
    ;

// unary_arg
//     : UNARY_MINUS operand_arg
//     ;

//------------------------------------------------------------------------//
operand
    : accessor
    // : (MINUS | UNARY_MINUS) unaryMinus = operand // unary minus
    // | accessor
    | factor
    ;
//------------------------------------------------------------------------//
accessor
    : <assoc=right> accessor nl? property //#AccProperty
    | <assoc=right> accessor index        //#AccIndex
    | factor nl? property                 //#AccProperty
    | factor index                        //#AccIndex
    ;
//------------------------------------------------------------------------//
//Property accessor
property
    : DOT nl? (var_name | kw_override)
    ;

//Index accessor
index
    : lb expr rb
    ;

//---------------------------------------- FACTORS
factor
    : var_name
    | path
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

//---------------------------------------- UNARY_MINUS
// unary_minus 
//     : (MINUS nl?| UNARY_MINUS) expr
//     ;

//---------------------------------------- EXPR_SEQ
//<expr_seq> ::= ( <expr> { ( ; | <eol>) <expr> } )
expr_seq
    : lp
        expr (nl+ expr)*
      rp
    | LPAREN nl? RPAREN
    ;
//---------------------------------------- TYPES
box2:
    lb
        expr comma
        expr comma
        expr comma
        expr
    rb
    ;

point3:
    lb
        expr comma
        expr comma
        expr
    rb
    ;

point2:
    lb
        expr comma
        expr
    rb
    ;

// BitArray
bitArray :
    SHARP nl? lc
        bitList?
    rc
    ;

bitList
    : bitexpr ( comma bitexpr)*
    ;
bitexpr
    : expr nl? DOTDOT nl? expr
    | expr
    ;

// Array
array :
    SHARP nl? lp
        elementList?
    rp
    // | SHARP nl? PAREN_PAIR
    ;

elementList : expr ( comma expr )*
    ;

// Identifiers
var_name
    : ids       #Id
    | GLOB ids  #GlobId
    ;

ids
    : ID
    | QUOTED
    | kw_reserved
    | by_ref
    ;

// Path names
path: PATH ;
/*
ref_prefix
    : {this.noWSBeNext()}? AMP #ref
    | {this.noWSBeNext()}? PROD #deref
    ;
*/
by_ref
    : {this.noWSBeNext()}? AMP (var_name | path)
    ;
de_ref
    : {this.noWSBeNext()}? PROD (accessor | var_name | path)
    ;

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
	| PRINTALLELEMENTS
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
lp: LPAREN nl?
    ;
rp: nl? RPAREN
    ;
lb: LBRACK nl?
    ;
rb: RBRACK
    ;
lc: LBRACE nl?
    ;
rc: nl? RBRACE
    ;
comma: nl? COMMA nl?;
//----------------------------------------
nl : NL+ ;
/*
eos
    : {this.lineTerminatorAhead()}?
    | EOF
    ;
*/