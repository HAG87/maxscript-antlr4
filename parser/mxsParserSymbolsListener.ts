import ParseTreeListener from "antlr4/tree/ParseTreeListener.js";
import
{
    ProgramContext,

    Struct_defContext,
    // Struct_memberContext, Struct_scopeContext,
    Fn_defContext,

    // Plugin_defContext,
    // Plugin_clauseContext,
    // Change_handlerContext,
    // Context_exprContext,
    // Ctx_predicateContext,
    // Macroscript_defContext,
    // Utility_defContext,
    // Rollout_defContext,
    // Rollout_clauseContext,
    // RolloutGroupContext,
    // RolloutControlContext,
    // Tool_defContext,
    // Rcmenu_defContext,
    // Rc_submenuContext,
    // Rc_separatorContext,
    // Rc_menuitemContext,
    // Rc_clauseContext,
    // VarDeclContext, AssignContext, IfExprContext,
    Case_exprContext,
    // WhileExprContext, DoExprContext, ForExprContext, ExitExprContext,
    // TryExprContext,  FnRetContext,
    // ContextExprContext, AttributesDefContext, UtilityDefContext, RolloutDefContext, ToolDefContext, RcmenuDefContext, MacroscriptDefContext, PluginDefContext, ChangeHandlerContext,
    // Param_exprContext, Param_defContext, Attributes_defContext, Attributes_clauseContext, Struct_defContext,
    // Event_handlerContext, Event_argsContext,
    // , Fn_argsContext, Fn_paramsContext, Fn_returnContext, Try_exprContext, While_loopContext,
    // Do_loopContext, For_loopContext, For_sequenceContext, For_whileContext, For_whereContext, Loop_exitContext,
    // Case_exprContext, Case_itemContext, If_exprContext, Var_declContext, DeclarationContext, AssignmentContext, AssigmentOperationExpressionContext, DestinationContext,
    Fn_callContext,
    TypecastExprContext,
    ExponentExprContext,
    ProductExprContext,
    AdditionExprContext,
    LogicExprContext,
    LogicNOTExprContext,
    ComparisonExprContext,
    // FnCallExprContext,
    OperandExprContext,
    AccessorContext,
    // AccIndexContext,
    // OperandContext,
    // CallerContext,
    // ParamContext, Param_nameContext, AccPropertyContext, AccIndexContext, PropertyContext, IndexContext, FactorContext,
    // Unary_minusContext, Box2Context, Point3Context, Point2Context, BitArrayContext, BitListContext, BitexprContext, ArrayContext,
    // ElementListContext, IdContext, QuotedIdContext, KeywordOverwriteContext, RefContext, DeRefContext, PathContext,
    // Expr_seqContext
} from "./mxsParser.js";

import { mxsParserListener } from "./mxsParserListener";
import { TerminalNode } from "antlr4ng";

/*
class CustomVisitor
  extends ParseTreeVisitor<T>
  implements MyGrammarVisitor<T> {
  */
export class mxsParserSymbolsListener extends mxsParserListener
{
    /*
    // These are methods like enterEveryRule or visitTerminal. The first one is called at the entry of every node, while the second one is called when a terminal node (i.e., a Token) is found.
    public override enterEveryRule = (ctx: ParserRuleContext ctx): void => { }
    public override exitEveryRule = (ctx: ParserRuleContext ctx): void => { }
    public override visitErrorNode = (ctx: ErrorNode node): void => { }
    */
    public override visitTerminal = (ctx: TerminalNode): void =>
    {
        // console.log(ctx.getSymbol().type);
        console.log(JSON.stringify(ctx.getText()));

    };

    public override enterProgram = (ctx: ProgramContext): void =>
    {
        // console.log(ctx);

    };

    public override exitProgram = (ctx: ProgramContext): void =>
    {
        // console.log(ctx.getText());
    };
    public override enterStruct_def = (ctx: Struct_defContext): void =>
    {
        /*
        ctx.children.forEach( c => {
            console.log(c.getText());
        });
        // console.log(ctx);
        console.log(ctx.children[0]);
        // console.log(JSON.stringify(ctx.getText()));
        */
    }
    // /*
    public override enterFn_def = (ctx: Fn_defContext): void =>
    {
        // console.log(ctx.fn_def()._fn_mod?.text);
        // console.log(ctx.fn_def()._fn_decl?.text);
        // console.log(ctx.fn_def()._fn_name?.getText());

        // console.log(ctx.fn_def().fn_args().forEach(a => a.getText()));
        // console.log(ctx.fn_def().fn_params().forEach(p => p.getText()));
        // console.log(ctx.fn_def()._fn_body?.getText());
        // console.log(ctx.fn_def()._fn_body?.getText());
        // console.log(JSON.stringify(ctx.getText()));

    };
    // */
    // public override enterExpr_seq = (ctx: Expr_seqContext): void => {
    // console.log(ctx.getText());
    // }; 
    // public override exitExpr_seq = (ctx: Expr_seqContext): void => {}; 

    // public override exitFnDef = (ctx: FnDefContext): void => {}; 
    /*
    public override enterFactor = (ctx: FactorContext): void => {
        console.log(ctx.getText());
    };
    */
    // public override exitFactor = (ctx: FactorContext): void => {}; 


    // /*
    // */
    // public override exitFn_call = (ctx: Fn_callContext): void => {};
    // /*
    public override enterCase_expr = (ctx: Case_exprContext): void =>
    {
        console.log('case expression: ' + ctx.getText());
    };
    // */

    // public override enterTypecastExpr = (ctx: TypecastExprContext): void =>{}
    // public override enterExponentExpr = (ctx: ExponentExprContext): void =>{}
    // public override enterProductExpr = (ctx: ProductExprContext): void =>{}
    // public override enterAdditionExpr = (ctx: AdditionExprContext): void =>{}
    // public override enterLogicExpr = (ctx: LogicExprContext): void =>{}
    // public override enterLogicNOTExpr = (ctx: LogicNOTExprContext): void =>{}
    // public override enterComparisonExpr = (ctx: ComparisonExprContext): void =>{}

    // public override enterFnCallExpr = (ctx: FnCallExprContext): void =>{
    //     console.log('function call: ' + ctx.getText() + '| caller1: ' + ctx._caller?.getText());
    // }

    public override enterOperandExpr = (ctx: OperandExprContext): void =>
    {
        console.log('operand: ' + ctx.getText());
    };
    public override enterAccessor = (ctx: AccessorContext): void => {
        console.log('property: ' + ctx.getText());
    }
    // public override enterAccIndex = (ctx: AccIndexContext): void =>
    // {
    //     console.log(ctx.getText());
    // }
    // public override exitOperand = (ctx: OperandContext): void => {};
    // public override exitCaseExpr = (ctx: CaseExprContext): void => {}; 
    /*
    public override exitSimpleExpr = (ctx: SimpleExprContext): void => {}; 

    public override enterVarDecl = (ctx: VarDeclContext): void => {}; 
    public override exitVarDecl = (ctx: VarDeclContext): void => {}; 

    public override enterAssign = (ctx: AssignContext): void => {}; 
    public override exitAssign = (ctx: AssignContext): void => {}; 

    public override enterIfExpr = (ctx: IfExprContext): void => {}; 
    public override exitIfExpr = (ctx: IfExprContext): void => {}; 

    public override enterWhileExpr = (ctx: WhileExprContext): void => {}; 
    public override exitWhileExpr = (ctx: WhileExprContext): void => {}; 

    public override enterDoExpr = (ctx: DoExprContext): void => {}; 
    public override exitDoExpr = (ctx: DoExprContext): void => {}; 

    public override enterForExpr = (ctx: ForExprContext): void => {}; 
    public override exitForExpr = (ctx: ForExprContext): void => {}; 

    public override enterExitExpr = (ctx: ExitExprContext): void => {}; 
    public override exitExitExpr = (ctx: ExitExprContext): void => {}; 



    public override enterStructDef = (ctx: StructDefContext): void => {}; 
    public override exitStructDef = (ctx: StructDefContext): void => {}; 

    public override enterTryExpr = (ctx: TryExprContext): void => {}; 
    public override exitTryExpr = (ctx: TryExprContext): void => {}; 



    public override enterFnRet = (ctx: FnRetContext): void => {}; 
    public override exitFnRet = (ctx: FnRetContext): void => {}; 

    public override enterContextExpr = (ctx: ContextExprContext): void => {}; 
    public override exitContextExpr = (ctx: ContextExprContext): void => {}; 

    public override enterAttributesDef = (ctx: AttributesDefContext): void => {}; 
    public override exitAttributesDef = (ctx: AttributesDefContext): void => {}; 

    public override enterUtilityDef = (ctx: UtilityDefContext): void => {}; 
    public override exitUtilityDef = (ctx: UtilityDefContext): void => {}; 

    public override enterRolloutDef = (ctx: RolloutDefContext): void => {}; 
    public override exitRolloutDef = (ctx: RolloutDefContext): void => {}; 

    public override enterToolDef = (ctx: ToolDefContext): void => {}; 
    public override exitToolDef = (ctx: ToolDefContext): void => {}; 

    public override enterRcmenuDef = (ctx: RcmenuDefContext): void => {}; 
    public override exitRcmenuDef = (ctx: RcmenuDefContext): void => {}; 

    public override enterMacroscriptDef = (ctx: MacroscriptDefContext): void => {}; 
    public override exitMacroscriptDef = (ctx: MacroscriptDefContext): void => {}; 

    public override enterPluginDef = (ctx: PluginDefContext): void => {}; 
    public override exitPluginDef = (ctx: PluginDefContext): void => {}; 

    public override enterChangeHandler = (ctx: ChangeHandlerContext): void => {}; 
    public override exitChangeHandler = (ctx: ChangeHandlerContext): void => {}; 

    public override enterSimple_expr = (ctx: Simple_exprContext): void => {}; 
    public override exitSimple_expr = (ctx: Simple_exprContext): void => {}; 

    public override enterMacroscript_def = (ctx: Macroscript_defContext): void => {}; 
    public override exitMacroscript_def = (ctx: Macroscript_defContext): void => {}; 

    public override enterUtility_def = (ctx: Utility_defContext): void => {}; 
    public override exitUtility_def = (ctx: Utility_defContext): void => {}; 

    public override enterRollout_def = (ctx: Rollout_defContext): void => {}; 
    public override exitRollout_def = (ctx: Rollout_defContext): void => {}; 

    public override enterRollout_clause = (ctx: Rollout_clauseContext): void => {}; 
    public override exitRollout_clause = (ctx: Rollout_clauseContext): void => {}; 

    public override enterRolloutGroup = (ctx: RolloutGroupContext): void => {}; 
    public override exitRolloutGroup = (ctx: RolloutGroupContext): void => {}; 

    public override enterRolloutControl = (ctx: RolloutControlContext): void => {}; 
    public override exitRolloutControl = (ctx: RolloutControlContext): void => {}; 

    public override enterTool_def = (ctx: Tool_defContext): void => {}; 
    public override exitTool_def = (ctx: Tool_defContext): void => {}; 

    public override enterRcmenu_def = (ctx: Rcmenu_defContext): void => {}; 
    public override exitRcmenu_def = (ctx: Rcmenu_defContext): void => {}; 

    public override enterRc_submenu = (ctx: Rc_submenuContext): void => {}; 
    public override exitRc_submenu = (ctx: Rc_submenuContext): void => {}; 

    public override enterRc_separator = (ctx: Rc_separatorContext): void => {}; 
    public override exitRc_separator = (ctx: Rc_separatorContext): void => {}; 

    public override enterRc_menuitem = (ctx: Rc_menuitemContext): void => {}; 
    public override exitRc_menuitem = (ctx: Rc_menuitemContext): void => {}; 

    public override enterRc_clause = (ctx: Rc_clauseContext): void => {}; 
    public override exitRc_clause = (ctx: Rc_clauseContext): void => {}; 

    public override enterPlugin_def = (ctx: Plugin_defContext): void => {}; 
    public override exitPlugin_def = (ctx: Plugin_defContext): void => {}; 

    public override enterPlugin_clause = (ctx: Plugin_clauseContext): void => {}; 
    public override exitPlugin_clause = (ctx: Plugin_clauseContext): void => {}; 

    public override enterChange_handler = (ctx: Change_handlerContext): void => {}; 
    public override exitChange_handler = (ctx: Change_handlerContext): void => {}; 

    public override enterContext_expr = (ctx: Context_exprContext): void => {}; 
    public override exitContext_expr = (ctx: Context_exprContext): void => {}; 

    public override enterCtx_predicate = (ctx: Ctx_predicateContext): void => {}; 
    public override exitCtx_predicate = (ctx: Ctx_predicateContext): void => {}; 

    public override enterParam_expr = (ctx: Param_exprContext): void => {}; 
    public override exitParam_expr = (ctx: Param_exprContext): void => {}; 

    public override enterParam_def = (ctx: Param_defContext): void => {}; 
    public override exitParam_def = (ctx: Param_defContext): void => {}; 

    public override enterAttributes_def = (ctx: Attributes_defContext): void => {}; 
    public override exitAttributes_def = (ctx: Attributes_defContext): void => {}; 

    public override enterAttributes_clause = (ctx: Attributes_clauseContext): void => {}; 
    public override exitAttributes_clause = (ctx: Attributes_clauseContext): void => {}; 

    public override enterStruct_def = (ctx: Struct_defContext): void => {}; 
    public override exitStruct_def = (ctx: Struct_defContext): void => {}; 

    public override enterStruct_member = (ctx: Struct_memberContext): void => {}; 
    public override exitStruct_member = (ctx: Struct_memberContext): void => {}; 

    public override enterStruct_scope = (ctx: Struct_scopeContext): void => {}; 
    public override exitStruct_scope = (ctx: Struct_scopeContext): void => {}; 

    public override enterEvent_handler = (ctx: Event_handlerContext): void => {}; 
    public override exitEvent_handler = (ctx: Event_handlerContext): void => {}; 

    public override enterEvent_type = (ctx: Event_typeContext): void => {}; 
    public override exitEvent_type = (ctx: Event_typeContext): void => {}; 

    public override enterEvent_target_type = (ctx: Event_target_typeContext): void => {}; 
    public override exitEvent_target_type = (ctx: Event_target_typeContext): void => {}; 

    public override enterEvent_target_type_args = (ctx: Event_target_type_argsContext): void => {}; 
    public override exitEvent_target_type_args = (ctx: Event_target_type_argsContext): void => {}; 

    public override enterFn_def = (ctx: Fn_defContext): void => {}; 
    public override exitFn_def = (ctx: Fn_defContext): void => {}; 

    public override enterArgs = (ctx: ArgsContext): void => {}; 
    public override exitArgs = (ctx: ArgsContext): void => {}; 

    public override enterFn_return = (ctx: Fn_returnContext): void => {}; 
    public override exitFn_return = (ctx: Fn_returnContext): void => {}; 

    public override enterTry_expr = (ctx: Try_exprContext): void => {}; 
    public override exitTry_expr = (ctx: Try_exprContext): void => {}; 

    public override enterWhile_loop = (ctx: While_loopContext): void => {}; 
    public override exitWhile_loop = (ctx: While_loopContext): void => {}; 

    public override enterDo_loop = (ctx: Do_loopContext): void => {}; 
    public override exitDo_loop = (ctx: Do_loopContext): void => {}; 

    public override enterFor_loop = (ctx: For_loopContext): void => {}; 
    public override exitFor_loop = (ctx: For_loopContext): void => {}; 

    public override enterFor_sequence = (ctx: For_sequenceContext): void => {}; 
    public override exitFor_sequence = (ctx: For_sequenceContext): void => {}; 

    public override enterFor_while = (ctx: For_whileContext): void => {}; 
    public override exitFor_while = (ctx: For_whileContext): void => {}; 

    public override enterFor_where = (ctx: For_whereContext): void => {}; 
    public override exitFor_where = (ctx: For_whereContext): void => {}; 

    public override enterLoop_exit = (ctx: Loop_exitContext): void => {}; 
    public override exitLoop_exit = (ctx: Loop_exitContext): void => {}; 

    public override enterCase_expr = (ctx: Case_exprContext): void => {}; 
    public override exitCase_expr = (ctx: Case_exprContext): void => {}; 

    public override enterCase_item = (ctx: Case_itemContext): void => {}; 
    public override exitCase_item = (ctx: Case_itemContext): void => {}; 

    public override enterIf_expr = (ctx: If_exprContext): void => {}; 
    public override exitIf_expr = (ctx: If_exprContext): void => {}; 

    public override enterVar_decl = (ctx: Var_declContext): void => {}; 
    public override exitVar_decl = (ctx: Var_declContext): void => {}; 

    public override enterDecl = (ctx: DeclContext): void => {}; 
    public override exitDecl = (ctx: DeclContext): void => {}; 

    public override enterAssignment = (ctx: AssignmentContext): void => {}; 
    public override exitAssignment = (ctx: AssignmentContext): void => {}; 

    public override enterDestination = (ctx: DestinationContext): void => {}; 
    public override exitDestination = (ctx: DestinationContext): void => {}; 

    public override enterLogicNOT = (ctx: LogicNOTContext): void => {}; 
    public override exitLogicNOT = (ctx: LogicNOTContext): void => {}; 

    public override enterLogicOR = (ctx: LogicORContext): void => {}; 
    public override exitLogicOR = (ctx: LogicORContext): void => {}; 

    public override enterLogicOperand = (ctx: LogicOperandContext): void => {}; 
    public override exitLogicOperand = (ctx: LogicOperandContext): void => {}; 

    public override enterLogicAND = (ctx: LogicANDContext): void => {}; 
    public override exitLogicAND = (ctx: LogicANDContext): void => {}; 

    public override enterLogical_operand = (ctx: Logical_operandContext): void => {}; 
    public override exitLogical_operand = (ctx: Logical_operandContext): void => {}; 

    public override enterComparison = (ctx: ComparisonContext): void => {}; 
    public override exitComparison = (ctx: ComparisonContext): void => {}; 

    public override enterMathExpr = (ctx: MathExprContext): void => {}; 
    public override exitMathExpr = (ctx: MathExprContext): void => {}; 

    public override enterAddition = (ctx: AdditionContext): void => {}; 
    public override exitAddition = (ctx: AdditionContext): void => {}; 

    public override enterExponent = (ctx: ExponentContext): void => {}; 
    public override exitExponent = (ctx: ExponentContext): void => {}; 

    public override enterFnCall = (ctx: FnCallContext): void => {}; 
    public override exitFnCall = (ctx: FnCallContext): void => {}; 

    public override enterMathOperand = (ctx: MathOperandContext): void => {}; 
    public override exitMathOperand = (ctx: MathOperandContext): void => {}; 

    public override enterTypecast = (ctx: TypecastContext): void => {}; 
    public override exitTypecast = (ctx: TypecastContext): void => {}; 

    public override enterProduct = (ctx: ProductContext): void => {}; 
    public override exitProduct = (ctx: ProductContext): void => {}; 

    public override enterMath_operand = (ctx: Math_operandContext): void => {}; 
    public override exitMath_operand = (ctx: Math_operandContext): void => {}; 



    public override enterCaller = (ctx: CallerContext): void => {}; 
    public override exitCaller = (ctx: CallerContext): void => {}; 

    public override enterParam = (ctx: ParamContext): void => {}; 
    public override exitParam = (ctx: ParamContext): void => {}; 

    public override enterParam_name = (ctx: Param_nameContext): void => {}; 
    public override exitParam_name = (ctx: Param_nameContext): void => {}; 



    public override enterAccProperty = (ctx: AccPropertyContext): void => {}; 
    public override exitAccProperty = (ctx: AccPropertyContext): void => {}; 

    public override enterAccIndex = (ctx: AccIndexContext): void => {}; 
    public override exitAccIndex = (ctx: AccIndexContext): void => {}; 

    public override enterProperty = (ctx: PropertyContext): void => {}; 
    public override exitProperty = (ctx: PropertyContext): void => {}; 

    public override enterIndex = (ctx: IndexContext): void => {}; 
    public override exitIndex = (ctx: IndexContext): void => {}; 

    public override enterFactor = (ctx: FactorContext): void => {}; 
    public override exitFactor = (ctx: FactorContext): void => {}; 

    public override enterUnary_minus = (ctx: Unary_minusContext): void => {}; 
    public override exitUnary_minus = (ctx: Unary_minusContext): void => {}; 



    public override enterBox2 = (ctx: Box2Context): void => {}; 
    public override exitBox2 = (ctx: Box2Context): void => {}; 

    public override enterPoint3 = (ctx: Point3Context): void => {}; 
    public override exitPoint3 = (ctx: Point3Context): void => {}; 

    public override enterPoint2 = (ctx: Point2Context): void => {}; 
    public override exitPoint2 = (ctx: Point2Context): void => {}; 

    public override enterBitArray = (ctx: BitArrayContext): void => {}; 
    public override exitBitArray = (ctx: BitArrayContext): void => {}; 

    public override enterBitList = (ctx: BitListContext): void => {}; 
    public override exitBitList = (ctx: BitListContext): void => {}; 

    public override enterBitexpr = (ctx: BitexprContext): void => {}; 
    public override exitBitexpr = (ctx: BitexprContext): void => {}; 

    public override enterArray = (ctx: ArrayContext): void => {}; 
    public override exitArray = (ctx: ArrayContext): void => {}; 

    public override enterElementList = (ctx: ElementListContext): void => {}; 
    public override exitElementList = (ctx: ElementListContext): void => {}; 

    public override enterId = (ctx: IdContext): void => {}; 
    public override exitId = (ctx: IdContext): void => {}; 

    public override enterQuotedId = (ctx: QuotedIdContext): void => {}; 
    public override exitQuotedId = (ctx: QuotedIdContext): void => {}; 

    public override enterKeywordOverwrite = (ctx: KeywordOverwriteContext): void => {}; 
    public override exitKeywordOverwrite = (ctx: KeywordOverwriteContext): void => {}; 

    public override enterRef = (ctx: RefContext): void => {}; 
    public override exitRef = (ctx: RefContext): void => {}; 

    public override enterDeRef = (ctx: DeRefContext): void => {}; 
    public override exitDeRef = (ctx: DeRefContext): void => {}; 

    public override enterPath = (ctx: PathContext): void => {}; 
    public override exitPath = (ctx: PathContext): void => {}; 

    public override enterLevels = (ctx: LevelsContext): void => {}; 
    public override exitLevels = (ctx: LevelsContext): void => {};

    public override enterLevel_name = (ctx: Level_nameContext): void => {};
    public override exitLevel_name = (ctx: Level_nameContext): void => {}; 
*/

}