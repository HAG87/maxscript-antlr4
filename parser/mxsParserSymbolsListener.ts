import
{
    
    ProgramContext,
    Expr_seqContext,
    PropertyContext
} from "./mxsParser";

import { mxsParserListener } from "./mxsParserListener";
import { ErrorNode, ParserRuleContext, TerminalNode } from "antlr4ng";

export class mxsParserSymbolsListener extends mxsParserListener
{
    /*
     * ANTLR provides two callback functions for each node in the parse tree.
     * One is called by the walker when it is entered into a node, i.e., visit the node,
     * but the children are not visited yet. Another is called when all nodes in the subtree
     * of the visited node have been visited, and the walker is exiting the node.
    */
    // /*
    // These are methods like enterEveryRule or visitTerminal. The first one is called at the entry of every node, while the second one is called when a terminal node (i.e., a Token) is found.
    public override enterEveryRule = (ctx: ParserRuleContext): void => { }
    public override exitEveryRule = (ctx: ParserRuleContext): void => { }
    public override visitErrorNode = (ctx: ErrorNode): void => { }
    // */
    public override visitTerminal = (ctx: TerminalNode): void =>
    {
        // console.log(ctx.getSymbol().type);
        // console.log(JSON.stringify(ctx.getText()));

    };

    public override enterProgram = (ctx: ProgramContext): void =>
    {
        // console.log(ctx);

    };

    public override exitProgram = (ctx: ProgramContext): void =>
    {
        // console.log(ctx.getText());
    };

    // */
    public override enterExpr_seq = (ctx: Expr_seqContext): void => {
    // console.log(ctx.getText());
        // console.log(ctx.expr().length);
    }; 

    public override enterProperty = (ctx: PropertyContext): void => {
        console.log(ctx.getChildCount());
        console.log(ctx.getChild(1)?.getText());
    }

}