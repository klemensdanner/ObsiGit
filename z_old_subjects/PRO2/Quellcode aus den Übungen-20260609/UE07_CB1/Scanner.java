/* Scanner:                                                   DA, 2026-04-29 */
/* ------                                                                    */
/* Builds symbols from continuous characters.                                */
/* ========================================================================= */

public class Scanner {
    
    private static final char EOL = 0; // special char to indicate end of line

    private final String line; 
    private char ch;    // current char in line
    private int chCnr;  // column nr of char in line (starting with 1)

    public Symbol sy;   // current symbol
    public int syCnr;   // start position of sy in line 

    public int numberVal;  // only valid when sy is Symbol.NUMBER

    public Scanner(String line) {
        this.line = line;
        chCnr = 0;
        nextCh(); // ch holds first char, chCnr is 1
        nextSy(); // sy holds first sy and syCnr starting of first symbol
    }

    private void nextCh() {
        if (chCnr == line.length()) { // end of line
            ch = EOL;
        } else { // within line
            ch = line.charAt(chCnr);
            chCnr++;
        }
    } // nextCh()

    public void nextSy() {
        while ((ch == ' ') || (ch == '\t')) { // skip whitespaces
            nextCh();
        }
        syCnr = chCnr;
        switch (ch) {
            case EOL: sy = Symbol.EOL;                 break;
            case '+': sy = Symbol.PLUS;      nextCh(); break;
            case '-': sy = Symbol.MINUS;     nextCh(); break;
            case '*': sy = Symbol.TIMES;     nextCh(); break;
            case '/': sy = Symbol.DIV;       nextCh(); break;
            case '(': sy = Symbol.OPEN_PAR;  nextCh(); break;
            case ')': sy = Symbol.CLOSE_PAR; nextCh(); break;
            default:
                if (Character.isDigit(ch)) { // start of int value
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
        //IO.println("scanner: sy = " + sy + ", syCnr = " + syCnr);
    }
}
