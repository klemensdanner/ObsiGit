/* MiniJava:                                                  DA, 2026-05-06 */
/* ------                                                                    */
/* MiniJava interpreter                                                      */
/* ========================================================================= */

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

void main() {
    String sourceFileName = null;
    BufferedReader sourceFileReader = null;

    do {
        IO.println("source file name");
        sourceFileName = IO.readln();
        try {
            sourceFileReader = new BufferedReader(new FileReader(sourceFileName));
        }
        catch (IOException e) {
            IO.println("ERROR: cannot open source file");
        }
    } while (sourceFileReader == null);

    Scanner scanner = new Scanner(sourceFileReader);
    Parser parser = new Parser(scanner);
    try {
        parser.parse();
    }
    catch (SyntaxError e) {
        IO.println("ERROR: syntax error in line " + scanner.syLnr + ", colomn" + scanner.syCnr);
    }
    









/*     while ((scanner.sy != Symbol.EOF) && (scanner.sy != Symbol.ERROR)) {
        if (scanner.sy == Symbol.NUMBER) {
            IO.println(scanner.sy + " (" + scanner.numberVal + " )");
        } else if (scanner.sy == Symbol.IDENT) {
            IO.println(scanner.sy + " (" + scanner.identStr + " )");
        } else {
            IO.println(scanner.sy);
        }
        scanner.nextSy();
    } */


}