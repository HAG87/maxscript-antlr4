import { BufferedTokenStream, TokenSource, Token, CommonTokenStream } from "antlr4ng";

export default class MultiChannelTokenStream extends BufferedTokenStream
// export default class MultiChannelTokenStream extends CommonTokenStream
{
    private channels: number[] = [Token.DEFAULT_CHANNEL];

    constructor(tokenSource: TokenSource)
    {
        super(tokenSource);
    }

    /*
    private boolean matches(int channel, int[] channels) {
        for (int matchChannel : channels) {
            if (matchChannel == channel) {
                return true;
            }
        }
        return false;
    }
    */
    private matches(channel: number, channels: number[]): boolean
    {
        return channels.includes(channel);
    }
    /*
    public void enable(int channel) {
		for (int existingChannel : channels) {
			if (channel == existingChannel) {
				return;
			}
		}
		int len = channels.length;
		channels = copyOf(channels, len + 1);
		channels[len] = channel;

		int i = p - 1;
		while (i >= 0) {
			Token token = tokens.get(i);
			if (token.getChannel() == channel || !matches(token.getChannel(), channels)) {
				i--;
			} else {
				break;
			}
		}
		p = i + 1;
	}
    */
    public enable(channel: number): void
    {
        // /*
        if (this.channels.includes(channel)) {
            return;
        }
        this.channels = [...this.channels, channel];
        // console.log('CURRENT: ' + JSON.stringify(this.tokens[this.p].text));
        // */
        // console.log('ENABLE CHANNELS: ' + this.channels.toString());
        // backtracks.... why?
        // /*
        // console.log(this.tokens[this.index].text);
        
        let i = this.p - 1;

        while (i >= 0) {
            // const token = this.tokens.get(i);
            const token = this.tokens[i];
            // console.log(token.channel);
            if (token.channel === channel || !this.matches(token.channel, this.channels)) {
                i--;
            } else {
                break;
            }
        }
        if (this.matches(this.tokens[i + 1].channel, this.channels)) {this.p = i + 1;}
        
        // this.p = i;
        // console.log('START: ' + JSON.stringify(this.tokens[this.p].text));
        // console.log('START: ' + JSON.stringify(this.tokens[i+1].text));
        // this.p--
        // */
        // console.log(this.tokens[this.p]);
        // this.p--
        // console.log('START: ' + JSON.stringify(this.tokens[this.p].text));
    }
    public startAhead(channel: number): void
    {
        if (this.channels.includes(channel)) {
            return;
        }
        this.channels = [...this.channels, channel];
    }
    public disable(channel: number): void
    {
        // console.log('-- END --');
        // /*
        this.channels = this.channels.filter(c => c !== channel);

        // console.log(JSON.stringify('End at: ' + this.tokens[this.p-2].text));
        // */
        // console.log('DISABLE CHANNEL: ' + channel);
        let tok = this.tokens[this.p];
        console.log(`END token: ${JSON.stringify(tok.text)} ${tok.line}:${tok.column}`);

        // rewind so I can call this at the end of the rule
        // will not work if rule needs to end in NL

        
        /*
        let i = this.p - 1;

        while (i >= 0) {
            // console.log(JSON.stringify(this.tokens[i].text));
            // const token = this.tokens.get(i);
            const token = this.tokens[i];
            // console.log(JSON.stringify('End should be at: ' + this.tokens[i].text));
            // console.log(token.channel);
            if (token.channel === channel || !this.matches(token.channel, this.channels)) {
                i--;
            } else {
                break;
            }
        }
        this.p = i;
        // this.p = i + 1;
        // console.log(JSON.stringify('End should be at: ' + this.tokens[i].text));

        // console.log(JSON.stringify(this.tokens[i].text));
        // */
        // console.log('END: ' + JSON.stringify(this.tokens[this.p].text));
    }

    /*
    @Override
    protected int adjustSeekIndex(int i) {
        return nextTokenOnChannel(i, channels);
    }
    */
    public override adjustSeekIndex(i: number): number
    {
        return this.nextTokenOnChannel(i, this.channels);
    }

    
    /*
    protected int nextTokenOnChannel(int i, int[] channels) {
        sync(i);
        if (i >= size()) {
            return size() - 1;
        }

        Token token = tokens.get(i);
        while (!matches(token.getChannel(), channels)) {
            if (token.getType() == Token.EOF) {
                return i;
            }
            i++;
            sync(i);
            token = tokens.get(i);
        }
        return i;
    }
    */
    public override nextTokenOnChannel(i: number, channels: number | number[]): number
    {
        this.sync(i);
        if (i >= this.size) {
            return this.size - 1;
        }

        let token = this.tokens[i];
        while (!this.matches(token.channel, <number[]>channels)) {
            // console.log(`${i.toString()} : ${token.text} | ${token.channel.toString()}`);

            if (token.type === Token.EOF) {
                return i;
            }
            i++;
            this.sync(i);
            token = this.tokens[i];
        }
        return i;
    }

    /*
    protected int previousTokenOnChannel(int i, int[] channels) {
        sync(i);
        if (i >= size()) {
            return size() - 1;
        }

        while (i >= 0) {
            Token token = tokens.get(i);
            if (token.getType() == Token.EOF || matches(token.getChannel(), channels)) {
                return i;
            }
            i--;
        }
        return i;
    }
    */
    public override previousTokenOnChannel(i: number, channels: number | number[]): number
    {
        this.sync(i);
        if (i >= this.size) {
            return this.size - 1;
        }

        while (i >= 0) {
            const token = this.tokens[i];
            if (token.type === Token.EOF || this.matches(token.channel, <number[]>channels)) {
                return i;
            }
            i--;
        }
        return i;
    }

    /*
    @Override
    protected Token LB(int k) {
        if (k == 0 || (p - k) < 0) {
            return null;
        }
        int i = p;
        for (int  n = 1; n <= k; n++) {
            i = previousTokenOnChannel(i - 1, channels);
        }
        if (i < 0) {
            return null;
        } else {
            return tokens.get(i);
        }
    }
    */
    public override LB(k: number): Token | null
    {
        /*
        if (k===0 || this.index-k<0) {
            return null;
        }
        let i = this.index;
        let n = 1;
        // find k good tokens looking backwards
        while (n <= k) {
            // skip off-channel tokens
            i = this.previousTokenOnChannel(i - 1, this.channels);
            n += 1;
        }
        // */
        // /*
        if (k === 0 || (this.p - k) < 0) {
            return null;
        }
        let i = this.p;        
        
        for (let n = 1; n <= k; n++) {
            i = this.previousTokenOnChannel(i - 1, this.channels);
        }
        // */
        return i < 0 ? null : this.tokens[i];
    }

    /*
    @Override
    public Token LT(int k) {
        lazyInit();
        if (k == 0) {
            return null;
        }
        if (k < 0) {
            return LB(-k);
        }

        int i = p;
        for (int n = 1;n < k; n++) {
            if (sync(i + 1)) {
                i = nextTokenOnChannel(i + 1, channels);
            }
        }
        return tokens.get(i);
    }
    */
    public override LT(k: number): Token | null
    {
        this.lazyInit();
        if (k === 0) {
            return null;
        }
        if (k < 0) {
            return this.LB(-k);
        }
        /*
        let i = this.index;
        let n = 1; // we know tokens[pos] is a good one
        // find k good tokens
        while (n < k) {
            // skip off-channel tokens, but make sure to not look past EOF
            if (this.sync(i + 1)) {
                i = this.nextTokenOnChannel(i + 1, this.channels);
            }
            n += 1;
        }
        // */
        //    /*
        let i = this.p;
        for (let n = 1; n < k; n++) {
            if (this.sync(i + 1)) {
                i = this.nextTokenOnChannel(i + 1, this.channels);
            }
        }
        // */
        // console.log (JSON.stringify(this.tokens[i].text));

        return this.tokens[i];
    }

    /*
    public int getNumberOfOnChannelTokens() {
        int n = 0;
        fill();
        for (int i = 0; i < tokens.size(); i++) {
            Token t = tokens.get(i);
            for (int channel : channels) {
                if (t.getChannel() == channel) {
                    n++;
                }
            }
            if (t.getType() == Token.EOF) {
                break;
            }
        }
        return n;
    }
    */

    // Count EOF just once.
    public /* override */ getNumberOfOnChannelTokens(): number
    {
        let n = 0;
        this.fill();
        for (let i = 0; i < this.tokens.length; i++) {
            const t = this.tokens[i];

            if (this.channels.includes(t.channel)) {
                n++;
            }
            if (t.type === Token.EOF) {
                break;
            }
        }
        return n;
    }
}