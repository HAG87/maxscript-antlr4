import
    {
        CharStream,
        Lexer,
        Token,
        // Token
    } from "antlr4ng";
import { mxsLexer } from "./mxsLexer";
// import { mxsLexer } from "./mxsLexer";

export abstract class mxsLexerBase extends Lexer
{
    public constructor(input: CharStream)
    {
        super(input);
    }
    // private readonly invalidChars = [9,10,12,13,32];
    /*
    private lastToken: Token;

    protected next(char: number): boolean
    {
        // this.inputStream.LA(1)

        console.log(this.inputStream.LA(1) === char);
        // console.log(mxsLexer.NL);
        console.log(super.nextToken().channel);

        return (this.inputStream.LA(1) === char);
    }

    public override nextToken(): Token
    {
        // Get the next token.
        const next: Token = super.nextToken();

        console.log(`${next.line} : ${next.channel} ${JSON.stringify(next.text)}`);

        if (next.channel == Token.DEFAULT_CHANNEL) {
            // Keep track of the last token on the default channel.
            this.lastToken = next;
        }

        return next;
    }
    // */

    public override emit(): Token {
        /*
        switch (this.type) {
            case mxsLexer.BLOCK_COMMENT:
                // console.log(`cmmB | ${this.line} > ${JSON.stringify(this.text)}`);
                break;
            case mxsLexer.LINE_COMMENT:
                // console.log(`cmmL | ${this.line} > ${JSON.stringify(this.text)}`);
                break;
            case mxsLexer.WS:
                // console.log("\x1b[32m%s\x1b[0m", `ws | ${this.line} > ${JSON.stringify(this.text)}`);
                break;
            case mxsLexer.NL:
                console.log("\x1b[35m%s\x1b[0m", `nl | ${this.line} > ${JSON.stringify(this.text)}`);
                break;
            default:
                console.log('\x1b[36m%s\x1b[0m', `${this.line} > ${JSON.stringify(this.text)}`);
                break;
        }
        // */
        // sanitize tokens
        // if (this.channel === mxsLexer.DEFAULT_TOKEN_CHANNEL && this.type !== mxsLexer.NL)
        // {
        //     this.text = this.text.trim();
        // }
        if (this.type === mxsLexer.NL) this.text = '\r\n';
        return super.emit();
    }

    protected followed(): boolean
    {
        //  console.log(this.text.charCodeAt(0));
        //  console.log(`followed: ${(this.inputStream.LA(1) > 32) && (this.inputStream.LA(1) !== 45)} -> ${JSON.stringify(String.fromCharCode(this.inputStream.LA(1)))}`);
        return (
            this.inputStream.LA(1) > 32 &&
            this.inputStream.LA(1) !== this.text.charCodeAt(0)
        );
        //  return (this.inputStream.LA(1) > 32);
        //  return false;
    }

    protected preceeded(): boolean
    {
        //  console.log(this.text.charCodeAt(0));
        //  console.log(`followed: ${(this.inputStream.LA(1) > 32) && (this.inputStream.LA(1) !== 45)} -> ${JSON.stringify(String.fromCharCode(this.inputStream.LA(1)))}`);
        return (
            this.inputStream.LA(-1) > 32 &&
            this.inputStream.LA(-1) !== this.text.charCodeAt(0)
        );
        //  return (this.inputStream.LA(1) > 32);
        //  return false;
    }
}