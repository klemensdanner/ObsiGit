/* Symbol:                                                   HDO, 2025-03-11
   ------
  Definition of terminal symbols (tokens) for MiniJava
============================================================================*/

public enum Symbol {
  ERROR, EOF,                                   // error and end of file
  PLUS, MINUS, TIMES, DIV,                      // operators
  OPEN_PAR, CLOSE_PAR, OPEN_BRACE, CLOSE_BRACE, // parenthesis and braces
  COMMA, SEMICOLON, ASSIGN,                     // other symbols
  INT, MAIN, PRINT, READ, VOID,                 // keywords
  NUMBER, IDENT                                 // terminal classes
} // Symbol
