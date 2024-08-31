/* $antlr-format
 alignColons hanging,
 alignSemicolons hanging,
 allowShortBlocksOnASingleLine
 true,
 allowShortRulesOnASingleLine false,
 alignFirstTokens true,
 minEmptyLines 1
 */
parser grammar mxsParser;

@header {
    import { mxsParserBase } from "./mxsParserBase"
    import { mxsLexer } from "./mxsLexer"
}

options {
	tokenVocab = mxsLexer;
	superClass = mxsParserBase;
	//language = TypeScript; output = AST;
}

/*GRAMMAR RULES*/

program:  expr (NL+ expr)*  EOF
	;

expr: non_if_expr | if_statement
	;

non_if_expr
	: simple_expr
	| var_decl
	| assignment_expr
	| assignmentOp_expr
	| if_statement
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
	| when_expr
	| utility_def
	| rollout_def
	| tool_def
	| rcmenu_def
	| macroscript_def
	| plugin_def
	;

//-------------------------------------- MACROSCRIPT_DEF
macroscript_def
	: MACROSCRIPT  var_name (  param_name  (operand | RESOURCE) )* 
    lp
        (macroscript_clause ( macroscript_clause)*)?
    rp
	;

macroscript_clause: expr | event_handler
	;

//-------------------------------------- UTILITY_DEF
utility_def
	: UTILITY  var_name  operand ( param)* 
    lp
        ( rollout_clause ( rollout_clause)* )?
    rp
	;

//-------------------------------------- ROLLOUT_DEF
rollout_def
	: ROLLOUT  var_name  operand ( param)* 
    lp
        ( rollout_clause ( rollout_clause)* )?
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
	: GROUP  STRING? 
    lp
        ( rollout_control ( rollout_control)* )?
    rp
	;

rollout_control: RolloutControl ( operand)+ ( param)*
	;

//-------------------------------------- TOOL_DEF
tool_def
	: TOOL  var_name ( param)* 
    lp
        tool_clause ( tool_clause)+
    rp
	;

tool_clause: var_decl | fn_def | struct_def | event_handler
	;

//-------------------------------------- RCMENU_DEF
rcmenu_def
	: RCMENU  var_name  lp (rc_clause ( rc_clause)*)? rp
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
	: SUBMENU  STRING ( param)* 
    lp
        ( rc_clause ( rc_clause)* )?
    rp
	;

rc_separator: SEPARATOR  var_name ( param)*
	;

rc_menuitem: MENUITEM ( operand)+ ( param)*
	;

//-------------------------------------- PLUGIN_DEF
plugin_def
	: PLUGIN  var_name  var_name ( param)* 
    lp
        plugin_clause ( plugin_clause)*
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

//-------------------------------------- CHANGE_HANDLER when <attribute> <objects> change[s] [
// id:<name> ] [handleAt:#redrawViews|#timeChange] [ <object_parameter> ] do <expr> when <objects>
// deleted [ id:<name> ] [handleAt:#redrawViews|#timeChange] [ <object_parameter> ] do <expr>
// objects var_name | PATH | array

when_expr: when_predicate  DO  expr
	;

when_predicate
	: WHEN  (var_name )? (var_name | PATH | expr_seq | array)  (CHANGE | DELETED)    ( param)* ( operand)?
	;

//-------------------------------------- CONTEXT_EXPR
/*The full syntax for <context_expr> is:
 
 <context> { , <context> } <expr>
 where <context> is
 one
 of:
 
 at level <node>
 at time <time>
 about <center_spec>
 in <node>
 [ in ] coordsys
 <coordsys>
 [ with ] animate <boolean>
 [ with ] undo <boolean>
 [ with ] redraw <boolean>
 [ with
 ] quiet
 <boolean>
 [ with ] redraw <boolean>
 [ with ] printAllElements <boolean>
 [ with ]
 defaultAction
 <action>
 [ with ] MXSCallstackCaptureEnabled <boolean>
 [ with ]
 dontRepeatMessages
 <boolean>
 [
 with ] macroRecorderEmitterEnabled <boolean>
 
 set <context> 
 Where, <context> is
 one of the
 MAXScript context prefixes: 
 animate,
 time,
 in,
 coordsys,
 about,
 level,
 undo
 */

context_expr: ctx_cascading | ctx_set
	;

ctx_cascading: ctx_predicate (comma ctx_predicate)*  expr
	;

ctx_set
	: SET (ANIMATE | TIME | IN | LEVEL)  operand
	| SET COORDSYS  (LOCAL | operand)
	| SET ABOUT  (COORDSYS | operand)
	| SET UNDO  (STRING | param | var_name)?  simple_expr
	;

ctx_predicate
	: AT  (LEVEL | TIME)  operand
	| IN  operand
	| ABOUT  (COORDSYS | operand)
	| IN?  COORDSYS  (LOCAL | operand)
	| WITH?  UNDO  (STRING | param | var_name)?  simple_expr
	| WITH?  DEFAULTACTION  NAME
	| WITH?  ctx_keyword  simple_expr
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
	: PARAMETERS  var_name ( param)* 
    lp
        ( param_clause (NL+ param_clause)* )?
    rp
	;

param_clause: param_expr | event_handler
	;

param_expr: var_name ( param)*
	;

//-------------------------------------- ATTRIBUTES DEFINITION attributes <name> [version:n]
// [silentErrors:t/f] [initialRollupState:0xnnnnn] [remap:#(<old_param_names_array>,
// <new_param_names_array>)]
attributes_def
	: ATTRIBUTES  var_name ( param)* 
    lp
        attributes_clause ( NL+ attributes_clause )*
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
	: ON  ev_args = event_args  ev_action = (DO | RETURN)  ev_body = expr
	;

event_args
	: ev_target = var_name  ev_type = var_name (  ev_args += var_name )+
	| ev_target = var_name  ev_type = var_name
	| ev_type = var_name
	;

//---------------------------------------- STRUCT DEF
struct_def
	: STRUCT  str_name = var_name 
    lp
        struct_member ( comma struct_member )*
    rp
	;

// struct_members: struct_member (comma struct_member)* ;
/*
 struct_member
 : (scope = struct_scope )? 
 (
 assignment_expr
 | var_name
 | fn_def
 |
 event_handler
 )
 ;
 */
// /* 
struct_member
	: (scope = struct_scope )? (
		assignment_expr
		| var_name
		| fn_def
		| event_handler
	)
	;

struct_scope: PUBLIC | PRIVATE
	;

// */

//---------------------------------------- FUNCTION DEF
fn_def
	: fn_mod = MAPPED?  fn_decl = FN  fn_name = var_name 
		(  fn_args )*
		( fn_params)*
		 EQ 
		fn_body = expr
	;

fn_args
	: var_name
	// | de_ref
	;

fn_params: param | param_name
	;

//FN_RETURN
fn_return: RETURN  expr
	;

//---------------------------------------- LOOPS While loop
while_loop: WHILE  expr  DO  expr
	;

// Do loop
do_loop: DO  expr  WHILE  expr
	;

/* For loop
 * for <var_name> [, <index_name>[, <filtered_index_name>]] ( in | = )<sequence> ( do |
 * collect ) <expr>
 * for-sequence
 * <expr> to <expr> [ by <expr> ] [while <expr>] [where <expr> ]
 * <expr> to <expr> [ by <expr> ] [where <expr> ]
 * <expr> [while <expr>] [ where<expr> ]
 * <expr>
 * [where <expr>]
 */

for_loop
	: FOR  var = var_name (
		comma index_name = var_name (
			comma filtered_index_name = var_name
		)?
	)?  for_operator = (IN | EQ)  for_sequence  for_action = (
		DO
		| COLLECT
	)  expr
	;

for_sequence
	: expr  (
		for_to  for_by?  for_while?  for_where?
		| for_while?  for_where?
	)
	;

for_to: TO  expr
	;

for_by: BY  expr
	;

for_while: WHILE  expr
	;

for_where: WHERE  expr
	;

loop_exit: EXIT (  WITH  expr)?
	;

//----------------------------------------TRY EXPR
try_expr: TRY  expr  CATCH  expr
	;

//---------------------------------------- CASE-EXPR
case_expr
	: CASE  expr?  OF  lp case_item (NL+ case_item)* rp
	;

// This will produce errors at compile time...
case_item: factor COLON  expr
	;

/*
 // this is not correct, because if should work for 5:(a), buuuut.....
case_item
    :{!this.colonBeNext()}? (NUMBER | TIMEVAL) COLON  expr;
    | (NUMBER | TIMEVAL) COLON (NL+ | {!this.noSpaces()}?) expr
    | factor  COLON  expr
    ;

 case_factor
 : accessor
 | var_name
 | PATH
 | by_ref
 | bool
 | STRING
 | NAME
 | array
 | bitArray
 | point3
 | point2
 | box2
 | unary_minus
 | expr_seq
 ;
 */
//---------------------------------------- IF-CLAUSE
/*
 //('else' e | {_input.LA(1) != ELSE}?)
 ifStatement
    : 'if' expression 'then' (statement | block) 'else' (statement | block)
    | 'if' expression 'then' (statementNoIf | block)
    ;
*/

/*
 statement : non_if_statement | if_statement ;
 if_statement
    : 'if' parExpression 
        ifBody= ( non_if_statement 'else' elseBody=statement | if_statement )
    ;   
*/

/*
 stmt : matched_stmt ∣ open_stmt ;

 matched_stmt
    : if expr then matched_stmt else matched_stmt
    ∣ other
 ;
 open_stmt
    : if expr then stmt
    ∣ if expr then matched_stmt else open_stmt
 ;
 */

// /*
// this does work but it is slooow
if_statement
	: IF  expr  (
		THEN  non_if_expr  ELSE  expr
		| (THEN | DO)  expr
		| if_statement
	)
	;

/* // this fails for whatever reason with SLL
 if_statement
 : IF  expr  THEN expr (ELSE  elseBody = expr | {this.itsNot(mxsLexer.ELSE)}? )
    | IF  ifClause = expr  DO  ifBody = expr
    ;
*/

//---------------------------------------- DECLARATIONS
var_decl
	: scope = decl_scope 
        decl += declaration ( comma decl += declaration )*
	;

declaration: assignment_expr | var_name
	;

decl_scope: ( LOCAL | GLOBAL | PERSISTENT  GLOBAL)
	;

//---------------------------------------- ASSIGNMENT EXPRESSION
assignment_expr: left = destination EQ  right = expr
	;

assignmentOp_expr: left = destination ASSIGN  right = expr
	;

destination: accessor | de_ref | var_name | PATH
	;

//---------------------------------------- SIMPLE_EXPR

// /*
simple_expr
	// : (fn_call | de_ref | operand) AS  classname #TypecastExpr | fn_call #FnCallExpr | de_ref
	// #DeRef | operand #OperandExpr

	: left = simple_expr {this.noNewLines()}? AS classname	                                    # TypecastExpr								
	| (MINUS | UNARY_MINUS) right = simple_expr								                    # UnaryExpr
	| <assoc = right> left = simple_expr {this.noNewLines()}? POW  right = simple_expr			# ExponentExpr
	| left = simple_expr {this.noNewLines()}? (PROD | DIV)  right = simple_expr					# ProductExpr
	| left = simple_expr {this.noNewLines()}? (PLUS | MINUS | UNARY_MINUS)  right = simple_expr	# AdditionExpr
	| left = simple_expr {this.noNewLines()}? COMPARE  right = simple_expr						# ComparisonExpr
	| <assoc = right> NOT  right = simple_expr								                    # LogicNOTExpr
	| left = simple_expr {this.noNewLines()}? (OR | AND)  right = simple_expr				    # LogicExpr
	| fn_call #fnCall
	| operand #ExprOperand
	| de_ref  #derefOperand
	;
// */

classname: var_name | expr_seq
	;

//---------------------------------------- FUNCTION CALL Positional Arguments Keyword Arguments
/*
 A <function_call> has a lower precedence than an <operand>,
 but it has a higher precedence than
 all the math,
 comparison, and logical operations.
 This means you have to be careful 
 about
 correctly parenthesizing function arguments
 */

fn_call
	: caller = operand (args += operand_arg)+ (params += operand_param)+
	| caller = operand (args += operand_arg)+
	| caller = operand (params += operand_param)+
	| caller = operand paren_pair
	// | caller = operand //# OperandExpr
	;

paren_pair: {this.closedParens() && this.noNewLines()}? LPAREN RPAREN
	;

fn_caller
	: var_name
	| PATH
	| de_ref
	| accessor
	// | unary_minus //UNARY MINUS
	| expr_seq //EXPRESSION SEQUENCE
	| QUESTION
	;

//---------------------------------------- PARAMETER
operand_param: {this.noNewLines()}? param
	;

operand_arg
	: {this.noNewLines()}? ( UNARY_MINUS operand | operand)
	;

param: param_name  operand_arg
	;

param_name: {this.colonBeNext()}? (var_name | kw_override) COLON
	;
// ------------------------------------------------------------------------//
operand
	// : (MINUS | UNARY_MINUS) unaryMinus = operand
	: accessor
	| factor
	;

//------------------------------------------------------------------------//
accessor
    : accessor (index | property)
    | factor (index | property)
	;

//------------------------------------------------------------------------//
// Property accessor
property: DOT  (var_name | kw_override)
	;

//Index accessor
index: lb expr rb
	;

//---------------------------------------- FACTORS
factor
	: var_name
	| bool
	| STRING
	| PATH
	| NAME
	| NUMBER
	| TIMEVAL
	| QUESTION
	| array
	| bitArray
	| point3
	| point2
	| box2
	// | unary_minus //UNARY MINUS
	| expr_seq //EXPRESSION SEQUENCE
	;

//---------------------------------------- UNARY_MINUS unary_minus : (MINUS | UNARY_MINUS) expr ;

//---------------------------------------- EXPR_SEQ <expr_seq> ::= ( <expr> { ( ; | <eol>) <expr> }
// )
expr_seq
	: lp (expr ({this.lineTerminatorAhead()}? expr)*)? rp //| LPAREN  RPAREN
	;

//---------------------------------------- TYPES
box2:
    lb
        expr comma expr comma expr comma expr
    rb
	;

point3:
    lb
        expr comma expr comma expr
    rb
	;

point2:
    lb
        expr comma expr
    rb
	;

// BitArray
bitArray: SHARP  lc bitList? rc
	;

bitList: bitexpr ( comma bitexpr)*
	;

// */
bitexpr: expr  DOTDOT  expr | expr
	;

// Array
array: SHARP  lp arrayList? rp
	;

arrayList: expr ( comma expr)*
	;

// */ Identifiers
var_name: ids | by_ref
	;

ids: GLOB? (ID | QUOTED | kw_reserved)
	;

by_ref: {this.noWSBeNext()}? AMP (ids | PATH)
	;

de_ref: {this.noWSBeNext()}? PROD (accessor | ids | PATH)
	;

// Boolean
bool: (BOOL | OFF | ON)
	;

//---------------------------------------- OVERRIDABLE KEYWORDS CONTEXTUAL KEYWORDS...can be used as
// identifiers outside the context...
kw_reserved
	: (
		RolloutControl
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
	)
	;

kw_override
	: (
		ATTRIBUTES
		| PARAMETERS
		| PLUGIN
		| RCMENU
		| RETURN
		| ROLLOUT
		| TO
		| TOOL
		| ON
	)
	;

//---------------------------------------- NEWLINE RESOLVING
lp: LPAREN 
	;

rp:  RPAREN
	;

lb: LBRACK 
	;

rb: RBRACK
	;

lc: LBRACE 
	;

rc:  RBRACE
	;

comma:  COMMA 
	;