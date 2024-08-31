import { TerminalNode } from "antlr4ng";
import { mxsParserVisitor } from "./mxsParserVisitor";


/*
    class mxsParserVisitorBase extends ParseTreeVisitor<T> implements mxsParserVisitor<T> { }
*/
export class mxsParserVisitorAdapter extends mxsParserVisitor<String>
{
    /* options:
    * - to return null to stop the visit,
    * - to return children to continue,
    * - to return something to perform an action ordered at a higher level of the tree.
    */

    visitTerminal(_node: TerminalNode): String | null {
        console.log("visitTerminal");
        // return _node.getText();
        return "caca";
    }
    // visitFn_def = (ctx: Fn_defContext): String  => {
    //     console.log("visitFn_def");
    //     console.log(ctx.getText());
    //     // this.visitChildren()
    //     // this.visit()
    //     return '';
    // }

}