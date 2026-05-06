/* Symbol:                                                   SWa, 2026-04-29 */
/* -------                                                                   */
/*                     */
/* ========================================================================= */
public enum Symbol {
    ERROR, EOF,               // error and end of file
    PLUS, MINUS, TIMES, DIV,  // arithmetic operators
    OPEN_PAR, CLOSE_PAR, OPEN_BRACE, CLOSE_BRACE,      // opening and closing parenthesis
    INT, MAIN, VOID, READ, PRINT, // Key words
    COMMA, SEMICOLON, ASSIGN, // ASSIGN: = (Zuweisung)
    NUMBER, IDENT             // terminal classES number
}
