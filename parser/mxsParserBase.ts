import
{
    Parser,
    Lexer,
    Token,
    TokenStream,
    // BufferedTokenStream,
    // CommonTokenStream,
} from 'antlr4ng';
import { mxsParser } from './mxsParser';
import MultiChannelTokenStream from './multiChannelTokenStream';
import { mxsLexer } from './mxsLexer';

export abstract class mxsParserBase extends Parser
{
    constructor(input: TokenStream)
    {
        super(input);
    }

    public enable(channel: number): void
    {
        console.log('ENABLE CHANNEL: ' + channel);
        if (this.inputStream instanceof MultiChannelTokenStream) {
            (this.inputStream as MultiChannelTokenStream).enable(channel);
        }
    }

    public disable(channel: number): void
    {
        console.log('DISABLE CHANNEL: ' + channel);
        if (this.inputStream instanceof MultiChannelTokenStream) {
            (this.inputStream as MultiChannelTokenStream).disable(channel);
        }
    }

    private validatorState: boolean = true;

    protected test(): void
    {
        let idx = this.getCurrentToken().tokenIndex;
        // if (idx < 0) return false;
        let token = this.inputStream.get(idx);
        console.log(`${JSON.stringify(token?.text)}`);
        // console.log(this.inputStream.get(idx));
    }

    protected colonBeNext(offset: number = 1): boolean
    {
        let idx = this.getCurrentToken().tokenIndex + offset;
        let token = this.inputStream.get(idx);
        return (token?.type === mxsLexer.COLON);
    }

    protected noNewLines(): boolean
    {
        return !this.lineTerminatorAhead();
        //return false;
    }

    protected flagNewLine(): void
    {

        console.log('set flag!: ' + this.lineTerminatorAhead());
        if (this.lineTerminatorAhead()) this.validatorState = false;
    }

    protected useFlag(): boolean
    {
        console.log('use flag!: ' + this.validatorState);
        let flag = this.validatorState;
        // reset state
        this.validatorState = true;
        return flag;
    }

    protected noSpaces(): boolean
    {
        // this.getCurrentToken().tokenIndex is the current token (next token to consume)

        let idx = this.getCurrentToken().tokenIndex - 1;
        if (idx < 0) return false;
        let token = this.inputStream.get(idx);

        if (token.channel !== Lexer.DEFAULT_TOKEN_CHANNEL) { return false; }

        return true;
    }

    protected SimpleExprAhead(): boolean
    {
        let possibleIndexToken = this.getCurrentToken().tokenIndex - 1;
        let ahead: Token = this.inputStream.get(possibleIndexToken);
        console.log('--- ' + ahead.text);

        // mxsParser.RULE_simple_expr
        return false;
    }
    /**
     * Returns {@code true} iff on the current index of the parser's
     * token stream a token exists on the {@code HIDDEN} channel which
     * either is a line terminator, or is a multi line comment that
     * contains a line terminator.
     *
     * @return {@code true} iff on the current index of the parser's
     * token stream a token exists on the {@code HIDDEN} channel which
     * either is a line terminator, or is a multi line comment that
     * contains a line terminator.
     */
    protected lineTerminatorAhead(/* channel: number = mxsLexer.NEWLINE_CHANNEL */): boolean
    {

        // Get the token ahead of the current index.
        // let currentToken = this.getCurrentToken().tokenIndex;
        // let token = this.inputStream.get(currentToken);

        let idx: number = this.getCurrentToken().tokenIndex - 1;
        if (idx < 0) return false;
        let ahead: Token = this.inputStream.get(idx);

        // console.log('token: ' + ahead.text + ' | ' + JSON.stringify(ahead.text) + '|');
        // console.log(`${ahead.channel} -- ${channel} -- ${ahead.channel === channel}`);
        ///*
        // if (ahead.channel === Lexer.DEFAULT_TOKEN_CHANNEL) {
        // if (ahead.channel === Lexer.HIDDEN) {
        //     // We're only interested in tokens on the CHANNEL.
        //     return false;
        // }

        if (ahead.type === mxsParser.NL) {
            // There is definitely a line terminator ahead.
            return true;
        }
        // */
        // console.log(JSON.stringify(this.inputStream.get(idx).text));
        //check previous token
        // console.log('aheadws: '+ (ahead.type === mxsParser.WS));


        // look one token back
        idx = this.getCurrentToken().tokenIndex - 2;
        if (idx < 0) return false;
        ahead = this.inputStream.get(idx);

        // console.log('token: ' + ahead.text + ' | ' + JSON.stringify(ahead.text) + '|');

        // Get the token's text and type.
        const text = ahead.text;
        const type = ahead.type;

        return (type === mxsParser.BLOCK_COMMENT && (text?.includes("\r") || text?.includes("\n"))) ||
            (type === mxsParser.NL);

        // return false;
    }

}