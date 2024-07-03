import { TokenStream } from 'antlr4ng';
import { Parser } from "antlr4ng";
import {mxsParser} from './mxsParser';

export abstract class mxsParserBase extends Parser {
    constructor(input: TokenStream) {
        super(input);
    }
    protected noNewLines():boolean {
        /*
        // Get the token ahead of the current index.
        const possibleIndexEosToken: number = this.currentToken.tokenIndex - 1;
        const ahead: Token = this._input.get(possibleIndexEosToken);

        // Check if the token resides on the HIDDEN channel and if it's of the
        // provided type.
        return (ahead.channel == Lexer.HIDDEN) && (ahead.type == type);
        */

        return this.inputStream.LA(1) != mxsParser.EOL;
        // return this._input.LA(-1) != mxsParser.EOL || this._input.LA(1) != mxsParser.EOL;
        //return false; }
    }
    protected noSpaces(): boolean {
        return this.inputStream.LA(1) != mxsParser.WS;
    }

}