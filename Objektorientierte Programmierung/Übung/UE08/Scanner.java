/* Scanner:                                                  SWa, 2026-04-29 */
/* --------                                                                  */
/* A scanner for MiniJava Programs.                                          */
/* ========================================================================= */

import java.io.BufferedReader;
import java.io.IOException;



public class Scanner {
    private static final char EOF_CH = 0;    // special character to indicate end of line
    private static final char ERROR_CH = 1;  // to indicate an error


    private final BufferedReader reader; // source file reader
    private String line; // current source line
    private char ch;            // current character
    private int chLnr, chCnr;          // position of current character

    public Symbol sy;
    public int syLnr, syCnr;  // start position of current symbol
    public String identStr;
    public int numberVal;  // value if sy = NUMBER

    public Scanner(BufferedReader reader) {
        this.reader = reader;
        chLnr = 0;
        chCnr = 0;
        line = "";
        nextCh();
        nextSy();
    }

    private void nextCh() {
        try { // alles in den try block, weil nach dem block die ausführung weitergeht.
            if (line == null) {
                ch = EOF_CH;
            } else {
                if (chCnr == line.length()) {
                    line = reader.readLine();
                    chLnr++;
                    chCnr = 0;
                    ch = ' '; // to seperate two lines
                } else {
                    ch = line.charAt(chCnr);
                    chCnr++;
                }
            }
        }
        catch (IOException e) {
            ch = ERROR_CH;
        }
        
    }

    public void nextSy() {
        while ((ch == ' ') || (ch == '\t')) nextCh();  // skip white spaces
        syLnr = chLnr;
        syCnr = chCnr;
        switch (ch) {
            case EOF_CH:   sy = Symbol.EOF;                 break;
            case ERROR_CH: sy = Symbol.ERROR;               break;
            case '+':      sy = Symbol.PLUS;      nextCh(); break;
            case '*':      sy = Symbol.TIMES;     nextCh(); break;
            case '-':      sy = Symbol.MINUS;     nextCh(); break;
            case '/':      sy = Symbol.DIV;       nextCh(); break;
            case '(':      sy = Symbol.OPEN_PAR;  nextCh(); break;
            case ')':      sy = Symbol.CLOSE_PAR; nextCh(); break;

            case '{':      sy = Symbol.OPEN_BRACE; nextCh(); break;
            case '}':      sy = Symbol.CLOSE_BRACE; nextCh(); break;
            case '=':      sy = Symbol.ASSIGN; nextCh(); break;
            case ',':      sy = Symbol.COMMA; nextCh(); break;
            case ';':      sy = Symbol.SEMICOLON; nextCh(); break;



            // String s = "hallo";

            
            default:
               // if (ch == '-' | ch == '')




                if (Character.isLetter(ch)) {
                    StringBuilder sb = new StringBuilder();
                    do {
                        sb.append(ch);
                        nextCh();
                    } while (Character.isLetterOrDigit(ch));
                    identStr = sb.toString();
                    switch (identStr) {
                        case "int": sy = Symbol.INT; break;
                        case "void": sy = Symbol.VOID; break;
                        case "main": sy = Symbol.MAIN; break;
                        case "read": sy = Symbol.READ; break;
                        case "print": sy = Symbol.PRINT; break;
                        default: sy = Symbol.IDENT;
                    }

                } else if (Character.isDigit(ch)) {
                    sy = Symbol.NUMBER;
                    numberVal = 0;
                    do {
                        numberVal = numberVal * 10 + (ch - '0');
                        nextCh();
                    } while (Character.isDigit(ch));

                } else {
                    sy = Symbol.ERROR;
                }
        }
    }
}
