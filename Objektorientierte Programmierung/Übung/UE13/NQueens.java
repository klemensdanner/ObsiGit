/* NQueens:                                                   DA, 2026-06-10 */
/* ------                                                                    */
/* Solve the n-queens problem                                                */
/* ========================================================================= */


int nrOfSolutions;


void solveNQueens(int n) {
    nrOfSolutions = 0;
    int[] columns = new int[n];
    placeQueen(columns, 0);
    IO.println("Found solutions: " + nrOfSolutions);
}

void placeQueen(int[] columns, int index) {
    if (index == columns.length) {
        nrOfSolutions++;
        //printSolution(columns); // das returned nicht, es werden also alle lösungen ausgegeben
    } else {
        for (int i = 0; i < columns.length; i++) { // alle Belegungen in einem Index des column arrays durchprobieren
            columns[index] = i;
            if (queenFits(columns, index)) { // nur wenn die Dame passt macht man weiter
                placeQueen(columns, index + 1);
            }
            

        }
    }
}


boolean queenFits(int[] columns, int index) {

    for (int i = 0; i < index; i++) {
        if ((columns[i] == columns[index]) ||
            (Math.abs(columns[i] - columns[index]) == index - i) // i immer kleiner als index
            ) {
            return false;
        }
    }

    return true;
}


void printSolution(int[] columns) {
    for (int i = 0; i < columns.length; i++) {
        for (int j = 0; j < columns.length; j++) {
            IO.print(columns[i] == j ? "Q " : ". ");
        }
        IO.println();
    }
    IO.println();
}



void main() {
    solveNQueens(16);
}