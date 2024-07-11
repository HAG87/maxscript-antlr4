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

        if (this.channel === mxsLexer.DEFAULT_TOKEN_CHANNEL && this.type === mxsLexer.NL) console.log(`--> ${JSON.stringify(this.text)}`);
        if (this.channel === mxsLexer.DEFAULT_TOKEN_CHANNEL && this.type !== mxsLexer.NL)
        {
            // sanitize token text
            this.text = this.text.trim();
            console.log(JSON.stringify(this.text));
        }
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