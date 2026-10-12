/* Scanner:                                                   DA, 2026-04-29 */
/* ------                                                                    */
/* Builds symbols from continuous characters.                                */
/* ========================================================================= */

import java.io.BufferedReader;

public class Scanner {
    
    private static final char  EOF = 0; // special char to indicate end of file
    public static final char ERROR = 1; // special char to indicate error

    private final BufferedReader reader;  // source file reader

    private String line;       // current source line
    private char ch;           // current char in line
    private int chCnr, chLnr;  // column nr of char in line chLnr (starting with 1)

    public Symbol sy;         // current symbol
    public int syCnr, syLnr;  // start position of sy in line syLnr 

    public int numberVal;     // only valid when sy is Symbol.NUMBER
    public String identStr;   // only valid when sy is Symbol.IDENT

    public Scanner(BufferedReader reader) {
        this.reader = reader;
        this.line = "";
        chLnr = 0;
        chCnr = 1; // so newCh will read first line
        nextCh();  // ch holds first char, chCnr is 1
        nextSy();  // sy holds first sy and syCnr starting of first symbol
    }

    private void nextCh() {
        try {
            if (line == null) {
                ch = EOF;
            } else {
                if (chCnr >= line.length()) { // end of line
                    line = reader.readLine();
                    chLnr++;
                    chCnr = 0;
                    ch = ' '; // insert a blank to separate 2 lines
                } else { // within line
                    ch = line.charAt(chCnr);
                    chCnr++;
                }            
            }
        } catch (Exception e) {
            ch = ERROR;
        }            
    } // nextCh()

    public void nextSy() {
        while ((ch == ' ') || (ch == '\t')) { // skip whitespaces
            nextCh();
        }
        syCnr = chCnr;
        syLnr = chLnr;
        switch (ch) {
            case EOF: sy = Symbol.EOF;                   break;
            case ERROR: sy = Symbol.ERROR;               break;
            case '+': sy = Symbol.PLUS;        nextCh(); break;
            case '-': sy = Symbol.MINUS;       nextCh(); break;
            case '*': sy = Symbol.TIMES;       nextCh(); break;
            case '/': sy = Symbol.DIV;         nextCh(); break;
            case '(': sy = Symbol.OPEN_PAR;    nextCh(); break;
            case ')': sy = Symbol.CLOSE_PAR;   nextCh(); break;
            case '{': sy = Symbol.OPEN_BRACE;  nextCh(); break;
            case '}': sy = Symbol.CLOSE_BRACE; nextCh(); break;
            case ',': sy = Symbol.COMMA;       nextCh(); break;
            case ';': sy = Symbol.SEMICOLON;   nextCh(); break;
            case '=': sy = Symbol.ASSIGN;      nextCh(); break;
            default:
                if (Character.isLetter(ch)) {
                    StringBuilder sb = new StringBuilder();
                    do {
                        sb.append(ch);
                        nextCh();
                    } while (Character.isLetterOrDigit(ch));
                    identStr = sb.toString();
                    switch (identStr) {
                        case "int":   sy = Symbol.INT; break;
                        case "main":  sy = Symbol.MAIN; break;
                        case "print": sy = Symbol.PRINT; break;
                        case "read":  sy = Symbol.READ; break;
                        case "void":  sy = Symbol.VOID; break;
                        default:      sy = Symbol.IDENT;
                    }
                } else if (Character.isDigit(ch)) { // start of int value
                    sy = Symbol.NUMBER;
                    numberVal = 0;
                    do {
                        numberVal = numberVal * 10 + (ch - '0');
                        nextCh();
                    } while (Character.isDigit(ch));
                } else { // invalid character
                    sy = Symbol.ERROR;
                }
        }
    }
}
