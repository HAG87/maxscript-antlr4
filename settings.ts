import
    {
        ICodeFormatSettings, IMinifierSettings, IPrettifierSettings,
    } from './types';

export const minOptions: ICodeFormatSettings & IMinifierSettings & IPrettifierSettings = {
    whitespaceChar: ' ',
    newLineChar: ';',
    indentChar: '',
    exprEndChar: ';',
    lineContinuationChar: '\\',
    codeblock: {
        newlineAllways: false, //ok
        parensInNewLine: false, //ok
        spaced: false, //ok
    },
    list: {
        useLineBreaks: false //ok
    },
    statements: {
        useLineBreaks: false, //TODO:
        optionalWhitespace: false //TODO:
    },
    removeUnnecessaryScopes: false, //TODO:
    condenseWhitespace: true, //ok
    expressionsToBlock: false, //TODO:
}

export const prettyOptions: ICodeFormatSettings & IMinifierSettings & IPrettifierSettings = {
    whitespaceChar: ' ',
    newLineChar: '\n\r',
    indentChar: '  ',
    exprEndChar: '\n\r',
    lineContinuationChar: '\\',
    codeblock: {
        newlineAllways: true, //ok
        parensInNewLine: true, //ok
        spaced: true, //ok
    },
    list: {
        useLineBreaks: false //ok
    },
    statements: {
        useLineBreaks: false, //TODO:
        optionalWhitespace: false //TODO:
    },
    removeUnnecessaryScopes: false, //TODO:
    condenseWhitespace: false, //ok
    expressionsToBlock: false, //TODO:
}