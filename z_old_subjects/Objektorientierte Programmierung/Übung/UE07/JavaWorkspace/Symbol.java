/* Symbol:                                                    DA, 2026-04-29 */
/* ------                                                                    */
/* A terminal symbol of simple arithmetic expressions                        */
/* ========================================================================= */

public enum Symbol {
    ERROR, EOL, // wenn irgendein Zeichen nichts verloren hat, z.B. #, @, $ etc.; EOL, damit nachher nichts mehr kommt
    PULS, MINUS, TIMES, DIV, 
    OPEN_PAR, CLOSE_PAR, // "(", ")"
    NUMBER // Terminalklasse, steht für alle Nummern
}



