import { ParserRuleContext, TerminalNode, Token } from "antlr4ng"
import { mxsLexer } from "./mxsLexer"
import
    {
        AccessorContext, ArrayContext, ArrayListContext, AssignmentContext, Attributes_predicateContext, AttributesDefinitionContext, BitArrayContext, BitListContext, Case_itemContext,
        Case_predicateContext,
        CaseExpressionContext,
        CommaContext, ContextExpressionContext, DeclarationExpressionContext, DoLoopExpressionContext, EventHandlerClauseContext, Expr_operandContext, Expr_seqContext,
        ExprContext, FactorContext, FnDefinitionContext, FnReturnStatementContext, ForLoopExpressionContext, FunctionCallContext,
        Group_predicateContext,
        IdentifierContext, IfExpressionContext, IndexContext, LbContext, LbkContext, LcContext, LpContext,
        Macroscript_predicateContext,
        MacroscriptDefinitionContext, mxsParser, Operand_argContext, OperandContext, Param_nameContext,
        ParamContext, Params_predicateContext, ParamsDefinitionContext, Paren_pairContext, PathContext, Plugin_predicateContext, PluginDefinitionContext, ProgramContext,
        PropertyContext, RbContext, Rc_submenuContext, RcContext, Rcmenu_predicateContext, RcmenuControlContext, RcmenuDefinitionContext,
        Rollout_predicateContext,
        RolloutControlContext, RolloutDefinitionContext, RolloutGroupContext, RpContext, SimpleExpressionContext,
        Struct_bodyContext, StructDefinitionContext, Submenu_predicateContext, Tool_predicateContext, ToolDefinitionContext, TryExpressionContext, Utility_predicateContext, UtilityDefinitionContext,
        WhenStatementContext, WhileLoopExpressionContext
    } from "./mxsParser"
import { mxsParserVisitor } from "./mxsParserVisitor"

type R = codeToken | codeBlock


const options = {

    whitespaceChar: ' ',
    newLineChar: ';',
    indentChar: '\t',
    lineEndChar: ';',
    lineContinuationChar: '\\',
    codeblock: {
        parensInNewLine: false,
        newlineAllways: false,
        spaced: false,
    },
    list: {
        useLineBreaks: false
    },
    statements: {
        useLineBreaks: true,
        optionalWhitespace: false
    },
    removeUnnecessaryScopes: false,
    condenseWhitespace: true,
}

enum codeTypes
{
    ASSIGN,
    COMMA,
    DOT,
    COLON,
    ID,
    KEYWORD,
    LINE_BREAK,
    NUMBER,
    OPERATOR,
    SHARP,
    SYMBOL,
    UNARY,
    VALUE,
    WHITESPACE,
    LPAREN,
    RPAREN,
    LBRACE,
    RBRACE,
    LINE_COMMENT,
    BLOCK_COMMENT,
    LINE_CONTINUATION,
    VOID
}

enum blockTypes
{
    EXPR,
    SEQUENCE,
    LIST,
    DECL
}

const tokenToCodeType = new Map<number, codeTypes>([
    [mxsLexer.BLOCK_COMMENT, codeTypes.BLOCK_COMMENT],
    [mxsLexer.LINE_COMMENT, codeTypes.LINE_COMMENT],
    [mxsLexer.STRING, codeTypes.VALUE],
    [mxsLexer.NUMBER, codeTypes.NUMBER],
    [mxsLexer.TIMEVAL, codeTypes.NUMBER],
    [mxsLexer.TRUE, codeTypes.VALUE],
    [mxsLexer.FALSE, codeTypes.VALUE],
    [mxsLexer.AND, codeTypes.KEYWORD],
    [mxsLexer.AS, codeTypes.KEYWORD],
    [mxsLexer.AT, codeTypes.KEYWORD],
    [mxsLexer.BY, codeTypes.KEYWORD],
    [mxsLexer.CASE, codeTypes.KEYWORD],
    [mxsLexer.CATCH, codeTypes.KEYWORD],
    [mxsLexer.COLLECT, codeTypes.KEYWORD],
    [mxsLexer.DO, codeTypes.KEYWORD],
    [mxsLexer.ELSE, codeTypes.KEYWORD],
    [mxsLexer.EXIT, codeTypes.KEYWORD],
    [mxsLexer.FOR, codeTypes.KEYWORD],
    [mxsLexer.FROM, codeTypes.KEYWORD],
    [mxsLexer.IF, codeTypes.KEYWORD],
    [mxsLexer.IN, codeTypes.KEYWORD],
    [mxsLexer.OF, codeTypes.KEYWORD],
    [mxsLexer.ON, codeTypes.KEYWORD],
    [mxsLexer.OFF, codeTypes.KEYWORD],
    [mxsLexer.OR, codeTypes.KEYWORD],
    [mxsLexer.RETURN, codeTypes.KEYWORD],
    [mxsLexer.SET, codeTypes.KEYWORD],
    [mxsLexer.THEN, codeTypes.KEYWORD],
    [mxsLexer.TO, codeTypes.KEYWORD],
    [mxsLexer.TRY, codeTypes.KEYWORD],
    [mxsLexer.WHEN, codeTypes.KEYWORD],
    [mxsLexer.WHERE, codeTypes.KEYWORD],
    [mxsLexer.WHILE, codeTypes.KEYWORD],
    [mxsLexer.WITH, codeTypes.KEYWORD],
    [mxsLexer.NOT, codeTypes.KEYWORD],
    [mxsLexer.PUBLIC, codeTypes.KEYWORD],
    [mxsLexer.PRIVATE, codeTypes.KEYWORD],
    [mxsLexer.ABOUT, codeTypes.KEYWORD],
    [mxsLexer.COORDSYS, codeTypes.KEYWORD],
    [mxsLexer.LEVEL, codeTypes.KEYWORD],
    [mxsLexer.TIME, codeTypes.KEYWORD],
    [mxsLexer.UNDO, codeTypes.KEYWORD],
    [mxsLexer.CHANGE, codeTypes.KEYWORD],
    [mxsLexer.DELETED, codeTypes.KEYWORD],
    [mxsLexer.DefaultAction, codeTypes.KEYWORD],
    [mxsLexer.ANIMATE, codeTypes.KEYWORD],
    [mxsLexer.DontRepeatMessages, codeTypes.KEYWORD],
    [mxsLexer.MacroRecorderEmitterEnabled, codeTypes.KEYWORD],
    [mxsLexer.MXScallstackCaptureEnabled, codeTypes.KEYWORD],
    [mxsLexer.PrintAllElements, codeTypes.KEYWORD],
    [mxsLexer.QUIET, codeTypes.KEYWORD],
    [mxsLexer.REDRAW, codeTypes.KEYWORD],
    [mxsLexer.Group, codeTypes.KEYWORD],
    [mxsLexer.MacroScript, codeTypes.KEYWORD],
    [mxsLexer.Rollout, codeTypes.KEYWORD],
    [mxsLexer.Tool, codeTypes.KEYWORD],
    [mxsLexer.Utility, codeTypes.KEYWORD],
    [mxsLexer.RCmenu, codeTypes.KEYWORD],
    [mxsLexer.Parameters, codeTypes.KEYWORD],
    [mxsLexer.Plugin, codeTypes.KEYWORD],
    [mxsLexer.Attributes, codeTypes.KEYWORD],
    [mxsLexer.Angle, codeTypes.ID],
    [mxsLexer.Bitmap, codeTypes.ID],
    [mxsLexer.Button, codeTypes.ID],
    [mxsLexer.CheckBox, codeTypes.ID],
    [mxsLexer.CheckButton, codeTypes.ID],
    [mxsLexer.ColorPicker, codeTypes.ID],
    [mxsLexer.ComboBox, codeTypes.ID],
    [mxsLexer.CurveControl, codeTypes.ID],
    [mxsLexer.DotnetControl, codeTypes.ID],
    [mxsLexer.DropdownList, codeTypes.ID],
    [mxsLexer.EditText, codeTypes.ID],
    [mxsLexer.GroupBox, codeTypes.ID],
    [mxsLexer.Hyperlink, codeTypes.ID],
    [mxsLexer.ImgTag, codeTypes.ID],
    [mxsLexer.Label, codeTypes.ID],
    [mxsLexer.ListBox, codeTypes.ID],
    [mxsLexer.MapButton, codeTypes.ID],
    [mxsLexer.MaterialButton, codeTypes.ID],
    [mxsLexer.MultilistBox, codeTypes.ID],
    [mxsLexer.PickButton, codeTypes.ID],
    [mxsLexer.PopupBenu, codeTypes.ID],
    [mxsLexer.Progressbar, codeTypes.ID],
    [mxsLexer.RadioButtons, codeTypes.ID],
    [mxsLexer.Slider, codeTypes.ID],
    [mxsLexer.Spinner, codeTypes.ID],
    [mxsLexer.Subrollout, codeTypes.ID],
    [mxsLexer.Timer, codeTypes.ID],
    [mxsLexer.Separator, codeTypes.ID],
    [mxsLexer.MenuItem, codeTypes.ID],
    [mxsLexer.SubMenu, codeTypes.ID],
    [mxsLexer.MAPPED, codeTypes.KEYWORD],
    [mxsLexer.FN, codeTypes.KEYWORD],
    [mxsLexer.STRUCT, codeTypes.KEYWORD],
    [mxsLexer.LOCAL, codeTypes.KEYWORD],
    [mxsLexer.GLOBAL, codeTypes.KEYWORD],
    [mxsLexer.PERSISTENT, codeTypes.KEYWORD],
    [mxsLexer.NAME, codeTypes.VALUE],
    [mxsLexer.PATH, codeTypes.VALUE],
    [mxsLexer.ID, codeTypes.ID],
    [mxsLexer.QUOTED_ID, codeTypes.ID],
    [mxsLexer.RESOURCE, codeTypes.VALUE],
    [mxsLexer.EQ, codeTypes.ASSIGN],
    [mxsLexer.COMPARE, codeTypes.OPERATOR],
    [mxsLexer.ASSIGN, codeTypes.ASSIGN],
    [mxsLexer.UNARY_MINUS, codeTypes.OPERATOR],
    [mxsLexer.MINUS, codeTypes.OPERATOR],
    [mxsLexer.PLUS, codeTypes.OPERATOR],
    [mxsLexer.PROD, codeTypes.OPERATOR],
    [mxsLexer.DIV, codeTypes.OPERATOR],
    [mxsLexer.POW, codeTypes.OPERATOR],
    [mxsLexer.SHARP, codeTypes.SHARP],
    [mxsLexer.COMMA, codeTypes.COMMA],
    [mxsLexer.GLOB, codeTypes.KEYWORD],
    [mxsLexer.COLON, codeTypes.COLON],
    [mxsLexer.DOTDOT, codeTypes.OPERATOR],
    [mxsLexer.DOT, codeTypes.DOT],
    [mxsLexer.AMP, codeTypes.SYMBOL],
    [mxsLexer.QUESTION, codeTypes.SYMBOL],
    [mxsLexer.LPAREN, codeTypes.LPAREN],
    [mxsLexer.RPAREN, codeTypes.RPAREN],
    [mxsLexer.LBRACE, codeTypes.LBRACE],
    [mxsLexer.RBRACE, codeTypes.RBRACE],
    [mxsLexer.LBRACK, codeTypes.SYMBOL],
    [mxsLexer.RBRACK, codeTypes.SYMBOL],
    [mxsLexer.WS, codeTypes.WHITESPACE],
    [mxsLexer.NL, codeTypes.LINE_BREAK],

])

export class codeToken
{
    val: string
    type: codeTypes
    // pos?: number
    indent?: number

    constructor(val: string, type: codeTypes, /* pos?: number */)
    {
        this.val = val
        this.type = type
        // this.pos = pos
    }
    public check(type: codeTypes): boolean
    {
        return this.type === type
    }
    public prepend(val: string)
    {
        this.val = val + this.val
    }
    public append(val: string)
    {
        this.val += val
    }
}

export class codeBlock
{
    vals: R[]
    indent: number
    start?: codeToken
    end?: codeToken
    type: blockTypes
    constructor(vals?: R[], indent?: number, start?: codeToken, end?: codeToken, type?: blockTypes)
    {
        this.vals = vals ?? []
        this.indent = indent ?? 0
        this.start = start
        this.end = end
        this.type = type ?? blockTypes.SEQUENCE
    }
    get first(): codeToken | codeBlock
    {
        return this.vals[0]
    }
    get last(): codeToken | codeBlock
    {
        return this.vals[this.vals.length - 1]
    }
    public hasLineBreaks(): boolean
    {
        let res = false
        for (let val of this.vals) {
            if (val instanceof codeBlock) {
                if (!res) {
                    res = val.hasLineBreaks()
                }
            } else if (val.check(codeTypes.LINE_BREAK)) {
                res = true
            }
        }
        return res
    }

    public startsWithNL(): boolean
    {
        return (this.first instanceof codeToken && this.first.check(codeTypes.LINE_BREAK))
    }

    public endsWithNL(): boolean
    {
        return (this.last instanceof codeToken && this.last.check(codeTypes.LINE_BREAK))
    }

    public isEmpty(): boolean
    {
        return this.vals.length === 0
    }
    public canBeMultiline(): boolean
    {
        return this.vals.length > 1
    }
    // /*
    }
    // */
}

export class mxsParserVisitorFormatter extends mxsParserVisitor<R | R[]>
{
    private indentLevel = 0;

    constructor()
    {
        super()
    }
    /* options:
    * - to return null to stop the visit,
    * - to return children to continue,
    * - to return something to perform an action ordered at a higher level of the tree.
    */
    //-------------------------------------------------------
    visitProgram = (ctx: ProgramContext): codeBlock =>
        new codeBlock(this.visitChildren(ctx))
    // /*
    visitExpr = (ctx: ExprContext): R[] =>
    {
        return this.visitChildren(ctx)!
    }
    // */
    //-------------------------------------------------------
    visitPluginDefinition = (ctx: PluginDefinitionContext): codeBlock =>
    {
        this.indentLevel++;
        //--------------------------------------------
        const vals = [this.visit(ctx.plugin_predicate())!].flat()
        const clause = new codeBlock(
            ctx.plugin_clause()
                .flatMap(clause => this.visit(clause)!),
            // .filter(i => i !== null),
            this.indentLevel,
            <codeToken>this.visit(ctx.lp()),
            <codeToken>this.visit(ctx.rp()),
            blockTypes.DECL
        )
        //--------------------------------------------
        this.indentLevel--;
        return new codeBlock([...vals, clause])
    }
    visitPlugin_predicate = (ctx: Plugin_predicateContext): R[] => this.visitChildren(ctx)
    //-------------------------------------------------------
    visitParamsDefinition = (ctx: ParamsDefinitionContext): codeBlock =>
    {
        this.indentLevel++;
        //--------------------------------------------
        const vals = [this.visit(ctx.params_predicate())!].flat()
        const clause = new codeBlock(
            ctx.params_clause()
                .flatMap(clause => this.visit(clause)!),
            // .filter(i => i !== null),
            this.indentLevel,
            <codeToken>this.visit(ctx.lp()),
            <codeToken>this.visit(ctx.rp()),
            blockTypes.DECL
        )
        //--------------------------------------------
        this.indentLevel--
        return new codeBlock([...vals, clause])
    }
    visitParams_predicate = (ctx: Params_predicateContext): R[] => this.visitChildren(ctx)
    //-------------------------------------------------------
    visitToolDefinition = (ctx: ToolDefinitionContext): codeBlock =>
    {
        this.indentLevel++;
        //--------------------------------------------
        const vals = [this.visit(ctx.tool_predicate())!].flat()
        const clause = new codeBlock(
            ctx.tool_clause()
                .flatMap(clause => this.visit(clause)!),
            this.indentLevel,
            <codeToken>this.visit(ctx.lp()),
            <codeToken>this.visit(ctx.rp()),
            blockTypes.DECL
        )
        //--------------------------------------------
        this.indentLevel--;
        return new codeBlock([...vals, clause])
    }
    visitTool_predicate = (ctx: Tool_predicateContext): R[] => this.visitChildren(ctx)
    //-------------------------------------------------------
    visitMacroscriptDefinition = (ctx: MacroscriptDefinitionContext): codeBlock =>
    {
        this.indentLevel++;
        //--------------------------------------------
        const vals = [this.visit(ctx.macroscript_predicate())!].flat()
        const clause = new codeBlock(
            ctx.macroscript_clause()
                .flatMap(clause => this.visit(clause)!),
            this.indentLevel,
            <codeToken>this.visit(ctx.lp()),
            <codeToken>this.visit(ctx.rp()),
            blockTypes.DECL
        )
        //--------------------------------------------
        this.indentLevel--;
        return new codeBlock([...vals, clause])
    }
    visitMacroscript_predicate = (ctx: Macroscript_predicateContext): R[] => this.visitChildren(ctx)
    //-------------------------------------------------------
    visitUtilityDefinition = (ctx: UtilityDefinitionContext): codeBlock =>
    {
        this.indentLevel++;
        //--------------------------------------------
        const vals = [this.visit(ctx.utility_predicate())!].flat()
        const clause = new codeBlock(
            ctx.rollout_clause()
                .flatMap(clause => this.visit(clause)!),
            this.indentLevel,
            <codeToken>this.visit(ctx.lp()),
            <codeToken>this.visit(ctx.rp()),
            blockTypes.DECL
        )
        //--------------------------------------------
        this.indentLevel--;
        return new codeBlock([...vals, clause])
    }
    visitUtility_predicate = (ctx: Utility_predicateContext): R[] => this.visitChildren(ctx)
    visitRolloutDefinition = (ctx: RolloutDefinitionContext): codeBlock =>
    {
        this.indentLevel++;
        //--------------------------------------------
        const vals = [this.visit(ctx.rollout_predicate())!].flat()
        const clause = new codeBlock(
            ctx.rollout_clause()
                .flatMap(clause => this.visit(clause)!),
            this.indentLevel,
            <codeToken>this.visit(ctx.lp()),
            <codeToken>this.visit(ctx.rp()),
            blockTypes.DECL
        )
        //--------------------------------------------
        this.indentLevel--;
        return new codeBlock([...vals, clause])
    }
    visitRollout_predicate = (ctx: Rollout_predicateContext): R[] => this.visitChildren(ctx)
    visitRolloutGroup = (ctx: RolloutGroupContext): codeBlock =>
    {
        this.indentLevel++;
        //--------------------------------------------
        const vals = [this.visit(ctx.group_predicate())!].flat()
        const clause = new codeBlock(
            ctx.rolloutControl()
                .flatMap(clause => this.visit(clause)!),
            this.indentLevel,
            <codeToken>this.visit(ctx.lp()),
            <codeToken>this.visit(ctx.rp()),
            blockTypes.DECL
        )
        //--------------------------------------------
        this.indentLevel--;
        return new codeBlock([...vals, clause])
    }
    visitGroup_predicate = (ctx: Group_predicateContext): R[] => this.visitChildren(ctx)
    visitRolloutControl = (ctx: RolloutControlContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx),
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.EXPR
        )
    }
    //-------------------------------------------------------
    visitRcmenuDefinition = (ctx: RcmenuDefinitionContext): codeBlock =>
    {
        this.indentLevel++;
        //--------------------------------------------
        const vals = [this.visit(ctx.rcmenu_predicate())!].flat()
        const clause = new codeBlock(
            ctx.rc_clause()
                .flatMap(clause => this.visit(clause)!),
            this.indentLevel,
            <codeToken>this.visit(ctx.lp()),
            <codeToken>this.visit(ctx.rp()),
            blockTypes.DECL
        )
        //--------------------------------------------
        this.indentLevel--;
        return new codeBlock([...vals, clause])
    }
    visitRcmenu_predicate = (ctx: Rcmenu_predicateContext): R[] => this.visitChildren(ctx)
    visitRcmenuControl = (ctx: RcmenuControlContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx),
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.EXPR
        )
    }
    visitRc_submenu = (ctx: Rc_submenuContext): codeBlock =>
    {
        this.indentLevel++;
        //--------------------------------------------
        const vals = [this.visit(ctx.submenu_predicate())!].flat()
        const clause = new codeBlock(
            ctx.rc_clause()
                .flatMap(clause => this.visit(clause)!),
            this.indentLevel,
            <codeToken>this.visit(ctx.lp()),
            <codeToken>this.visit(ctx.rp()),
            blockTypes.DECL
        )
        //--------------------------------------------
        this.indentLevel--;
        return new codeBlock([...vals, clause])
    }
    visitSubmenu_predicate = (ctx: Submenu_predicateContext): R[] => this.visitChildren(ctx)
    //-------------------------------------------------------
    visitAttributesDefinition = (ctx: AttributesDefinitionContext): codeBlock =>
    {
        this.indentLevel++;
        //--------------------------------------------
        const vals = [this.visit(ctx.attributes_predicate())!].flat()
        const clause = new codeBlock(
            ctx.attributes_clause()
                .flatMap(clause => this.visit(clause)!),
            this.indentLevel,
            <codeToken>this.visit(ctx.lp()),
            <codeToken>this.visit(ctx.rp()),
            blockTypes.DECL
        )
        //--------------------------------------------
        this.indentLevel--;
        return new codeBlock([...vals, clause])
    }
    visitAttributes_predicate = (ctx: Attributes_predicateContext): R[] => this.visitChildren(ctx)
    //-------------------------------------------------------
    visitStructDefinition = (ctx: StructDefinitionContext): codeBlock =>
    {
        const body = <codeBlock>this.visit(ctx.struct_body())
        body.start = <codeToken>this.visit(ctx.lp())
        body.end = <codeToken>this.visit(ctx.rp())
        const vals = [
            this.visit(ctx.STRUCT())!,
            this.visit(ctx._str_name!)!,
            body
        ].flat()
        return new codeBlock(
            vals,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.DECL
        )
    }
    visitStruct_body = (ctx: Struct_bodyContext): codeBlock =>
    {
        this.indentLevel++;

        const block = new codeBlock(
            this.visitChildren(ctx)!,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.SEQUENCE
        )

        this.indentLevel--;
        return block
    }
    visitEventHandlerClause = (ctx: EventHandlerClauseContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx)!,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.EXPR
        )
    }
    //-------------------------------------------------------
    visitFnDefinition = (ctx: FnDefinitionContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx)!,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.DECL
        )
    }
    //-------------------------------------------------------
    visitDeclarationExpression = (ctx: DeclarationExpressionContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx)!,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.DECL
        )
    }
    //-------------------------------------------------------
    visitFnReturnStatement = (ctx: FnReturnStatementContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx)!,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.EXPR
        )
    }
    visitWhenStatement = (ctx: WhenStatementContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx)!,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.EXPR
        )
    }
    // case item
    // /*
    visitCaseExpression = (ctx: CaseExpressionContext): codeBlock =>
    {
        this.indentLevel++;
        //--------------------------------------------
        const vals = [this.visit(ctx.case_predicate())!].flat()
        const clause = new codeBlock(
            ctx.case_item()
                .flatMap(clause => this.visit(clause)!),
            this.indentLevel,
            <codeToken>this.visit(ctx.lp()),
            <codeToken>this.visit(ctx.rp()),
            blockTypes.EXPR
        )
        //--------------------------------------------
        this.indentLevel--;
        return new codeBlock([...vals, clause])
    }
    visitCase_predicate = (ctx: Case_predicateContext): R[] => this.visitChildren(ctx)
    visitCase_item = (ctx: Case_itemContext): codeBlock =>
    {
        // add spaces for numbers to avoid timeval problem
        const right = /[0-9]$/.test(ctx.factor().getText()) ? this.whitespaceResult() : this.defaultResult()
        const left = /^[-+0-9]/.test(ctx.expr().getText()) ? this.whitespaceResult() : this.defaultResult()

        return new codeBlock(
            [
                this.visit(ctx.factor())!,
                right, this.visit(ctx.COLON())!, left,
                this.visit(ctx.expr())!
            ].flat(),
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.EXPR
        )
    }
    // */
    visitIfExpression = (ctx: IfExpressionContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx)!,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.EXPR
        )
    }
    ///*
    visitDoLoopExpression = (ctx: DoLoopExpressionContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx)!,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.EXPR
        )
    }
    visitWhileLoopExpression = (ctx: WhileLoopExpressionContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx)!,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.EXPR
        )
    }
    visitForLoopExpression = (ctx: ForLoopExpressionContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx)!,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.EXPR
        )
    }
    visitTryExpression = (ctx: TryExpressionContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx)!,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.EXPR
        )
    }
    visitContextExpression = (ctx: ContextExpressionContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx)!,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.EXPR
        )
    }
    //*/
    //-------------------------------------------------------
    visitExpr_seq = (ctx: Expr_seqContext): codeBlock =>
    {
        this.indentLevel++;
        //--------------------------------------------
        const
            res = this.visitChildren(ctx),
            start = <codeToken>res.shift(),
            end = <codeToken>res.pop(),
            block = new codeBlock(res, this.indentLevel, start, end)
        //--------------------------------------------
        this.indentLevel--;
        return block
    }
    //-------------------------------------------------------
    // /*
    visitSimpleExpression = (ctx: SimpleExpressionContext): R =>
    {
        const operand = ctx.expr_operand()
        if (operand) {
            return this.visitChildren(operand)?.[0]
        } else {
            return new codeBlock(
                this.visitChildren(ctx)!,
                this.indentLevel,
                undefined,
                undefined,
                blockTypes.EXPR
            )
        }
    }
    // */
    /*
    visitExpr_operand = (ctx: Expr_operandContext): string =>
    {
        return this.visitChildren(ctx, this.aggregateResult)!
    }
    */
    //-------------------------------------------------------    
    /*
    visitAssignment = (ctx: AssignmentContext): string =>
    {
        // return ctx.EQ().symbol.text + this.visit(ctx.expr())!
        return this.visitChildren(ctx, this.aggregateResult)!
    }
    visitOperand = (ctx: OperandContext): string =>
    {
        return this.visitChildren(ctx, this.aggregateResult)!
    }
    //accessor
    visitAccessor = (ctx: AccessorContext): string =>
    {
        return this.visitChildren(ctx, this.aggregateResult)!
    }
    visitProperty = (ctx: PropertyContext): string =>
    {
        return this.visitChildren(ctx, this.aggregateResult)!
    }
    visitIndex = (ctx: IndexContext): string =>
    {
        return this.visitChildren(ctx, this.aggregateResult)!
    }
    // */
    // visitFactor = (ctx: FactorContext): R => this.visitChildren(ctx)?.[0]
    //-------------------------------------------------------
    visitFunctionCall = (ctx: FunctionCallContext): codeBlock =>
    {
        return new codeBlock(
            this.visitChildren(ctx)!,
            this.indentLevel,
            undefined,
            undefined,
            blockTypes.EXPR
        )
    }

    /*    visitParam = (ctx: ParamContext): string =>
       {
           return this.visitChildren(ctx, this.aggregateResult)
       } */
    // visitOperand_arg = (ctx: Operand_argContext): ParseTree => { return ctx.children[0] }
    /* visitParam_name = (ctx: Param_nameContext): string => { return ctx.getText() } */
    //-------------------------------------------------------
    visitIdentifier = (ctx: IdentifierContext): codeToken =>
        new codeToken(ctx.getText(), codeTypes.ID)
    // visitString?: ((ctx: StringContext) => string) | undefined;
    // visitNumber?: ((ctx: NumberContext) => string) | undefined;
    // visitTimeval?: ((ctx: TimevalContext) => string) | undefined;
    // visitBool?: ((ctx: BoolContext) => string) | undefined;
    // visitPath?: ((ctx: PathContext) => string) | undefined;
    // visitName?: ((ctx: NameContext) => string) | undefined;
    //-------------------------------------------------------
    visitArray = (ctx: ArrayContext): codeBlock =>
    {
        this.indentLevel++;

        const list = ctx.arrayList()
        const start = <codeToken>this.visit(ctx.lp())
        start.prepend(ctx.SHARP().getText())
        const end = <codeToken>this.visit(ctx.rp())

        const block = new codeBlock(
            list ? <R[]>this.visit(list)! : [],
            this.indentLevel,
            start,
            end,
            blockTypes.LIST
        )

        this.indentLevel--;
        return block
    }
    visitArrayList = (ctx: ArrayListContext): R[] => this.visitChildren(ctx)

    visitBitArray = (ctx: BitArrayContext): codeBlock =>
    {
        this.indentLevel++;

        const list = ctx.bitList()
        const start = <codeToken>this.visit(ctx.lc())
        start.prepend(ctx.SHARP().getText())
        const end = <codeToken>this.visit(ctx.rc())

        const block = new codeBlock(
            list ? <R[]>this.visit(list)! : [],
            this.indentLevel,
            start,
            end,
            blockTypes.LIST
        )

        this.indentLevel--;
        return block
    }
    visitBitList = (ctx: BitListContext): R[] => this.visitChildren(ctx)
    //..
    //-------------------------------------------------------
    visitParen_pair = (ctx: Paren_pairContext): codeBlock =>
    {
        const block = new codeBlock()
        block.start = <codeToken>this.visit(ctx.LPAREN())
        block.end = <codeToken>this.visit(ctx.RPAREN())
        return block
    }

    visitLp = (ctx: LpContext): codeToken => new codeToken('(', codeTypes.LPAREN)
    visitRp = (ctx: RpContext): codeToken => new codeToken(')', codeTypes.RPAREN)
    visitLc = (ctx: LcContext): codeToken => new codeToken('{', codeTypes.LBRACE)
    visitRc = (ctx: RcContext): codeToken => new codeToken('}', codeTypes.RBRACE)
    visitLb = (ctx: LbContext): codeToken => new codeToken('[', codeTypes.SYMBOL)
    visitRb = (ctx: RbContext): codeToken => new codeToken(']', codeTypes.SYMBOL)
    visitComma = (ctx: CommaContext): codeToken => new codeToken(',', codeTypes.COMMA)
    //-------------------------------------------------------
    // this will emmit a line break token for mandatory linebreaks
    visitLbk = (ctx: LbkContext): codeToken => this.lineBreakResult()
    visitTerminal = (node: TerminalNode): codeToken =>
    {
        switch (node.symbol.type) {
            case mxsLexer.UNARY_MINUS:
                return new codeToken(options.whitespaceChar + node.getText(), codeTypes.UNARY)
            /*
            return [
                new codeToken(options.whitespaceChar, codeTypes.WHITESPACE),
                new codeToken(node.getText(), codeTypes.OPERATOR)
            ]*/
            case mxsLexer.NL:
                return this.defaultResult()
            case mxsLexer.EOF:
                return this.defaultResult()
            default:
                return new codeToken(node.getText(), tokenToCodeType.get(node.symbol.type)!)
        }
    }
    //-------------------------------------------------------
    protected aggregateResult(aggregate: R[], nextResult: codeToken | codeBlock | R[]): R[]
    {
        /*
        if (aggregate) {
            if (nextResult) {
                if (options.condenseWhitespace) {
                    const end = /[$0-9_\p{L}]$/u.test(aggregate)
                    const start = /^[0-9_\p{L}]/u.test(nextResult)

                    const minusEnd = aggregate.endsWith('-')
                    const minusStart = nextResult.startsWith('-')

                    if (start && end || (minusStart && minusEnd)) {
                        aggregate += options.whitespaceChar
                    }
                } else {
                    aggregate += options.whitespaceChar
                }
                return aggregate + nextResult
            }
            return aggregate
        }
        return nextResult
        */
        return Array.isArray(nextResult) ? nextResult : [nextResult];
    }

    protected defaultResult(): codeToken { return new codeToken('', codeTypes.VOID) }
    protected lineBreakResult(): codeToken { return new codeToken(options.newLineChar, codeTypes.LINE_BREAK) }
    protected whitespaceResult(): codeToken { return new codeToken(options.whitespaceChar, codeTypes.WHITESPACE) }
    protected shouldVisitNextChild(_node: ParserRuleContext, _currentResult: codeToken | codeBlock): boolean { return true }


    visitChildren(node: ParserRuleContext, filterTerminal?: number): R[]
    visitChildren(node: ParserRuleContext[], filterTerminal?: number): R[]

    visitChildren(node: ParserRuleContext | ParserRuleContext[], filterTerminal: number = mxsLexer.NL): R[]
    {
        let result: R[] = []
        if (!Array.isArray(node)) {
            const n2 = node.getChildCount()
            for (let i = 0; i < n2; i++) {

                if (!this.shouldVisitNextChild(node, result[result.length - 1])) {
                    break
                }
                const c = node.getChild(i)

                if (c) {
                    if (filterTerminal && c instanceof TerminalNode &&
                        c.symbol.type === filterTerminal) {
                        continue
                    }
                    const childResult = c.accept(this)

                    if (childResult) {
                        result.push(...this.aggregateResult(result, childResult))
                        // eval
                    }
                }
            }
        } else {
            // node.
        }
        return result
    }
}