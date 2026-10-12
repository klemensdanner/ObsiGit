public enum Symbol {
    ERROR, EOF,               // error and end of file
    PLUS, MINUS, TIMES, DIV,  // operators
    OPEN_PAR, CLOSE_PAR,      // open and close parenthesis 
    OPEN_BRACE, CLOSE_BRACE,  // open '{' and close '}' braces 
    COMMA, SEMICOLON, ASSIGN, 
    INT, MAIN, PRINT, READ, VOID, // keywords
    NUMBER,                   // terminal class for (positive incl. zero) integer numbers
    IDENT                     // terminal class for identifiers
}