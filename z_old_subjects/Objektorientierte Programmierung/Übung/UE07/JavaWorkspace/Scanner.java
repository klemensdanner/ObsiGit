/* Scanner:                                                   DA, 2026-04-29 */
/* ------                                                                    */
/* Description                                                               */
/* ========================================================================= */

public class Scanner {
    private static final char EOL_CH = 0;
    private final String line;      // input line .... Konstante oder nicht?
    private char ch;                // current character
    private int chCnr;              // position of current character

    public Symbol sy;
    public int syCnr; //symbol Column number, start position of current symbol
    public int numberVal; // value if sy = NUMBER
    
    public Scanner(String line) {
        this.line = line;
        chCnr = 0;
        nextCh();
        nextSy();
    }

    private void nextCh() {
        if (chCnr == line.length()) {
            ch = EOL_CH;
        } else {
            ch = line.charAt(chCnr);
            chCnr++;
        }
    }

    public void nextSy() { // verarbeitet Zeichen b
        while ((ch == ' ' ) || (ch == '\t')) nextCh(); // skip white spaces
        syCnr = chCnr; // aktuelle Startposition merken
        switch (ch) {
            case EOL_CH: sy = Symbol.EOL; break;
            case '+': sy = Symbol.PULS;      nextCh(); break;
            case '-': sy = Symbol.MINUS;     nextCh(); break;
            case '*': sy = Symbol.TIMES;     nextCh(); break;
            case '/': sy = Symbol.DIV;       nextCh(); break;
            case '(': sy = Symbol.OPEN_PAR;  nextCh(); break;
            case ')': sy = Symbol.CLOSE_PAR; nextCh(); break;
            default:
                if (Character.isDigit(ch)) {
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