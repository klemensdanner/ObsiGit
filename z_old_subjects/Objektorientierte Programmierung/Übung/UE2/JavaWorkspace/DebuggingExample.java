/* example:                                                   da, 2026-03-19 */
/* ------                                                                    */
/* trying                                                                    */
/* ========================================================================= */

void main() {
    IO.println("Gib positive Ganzzahlen ein (beendet mit 0).");

    int capacity = 5;
    int[] values = new int[capacity];

    int count = 0;
    int sum = 0;

    IO.print("wert > ");
    int v = readInt();

    while (v > 0) {
        if (count < values.length) {
            values[count] = v;
        }

        sum += v;
        count++;

        if (count == values.length) {
            int[] bigger = new int[values.length * 2];
           
            for (int i = 0; i < values.length; i++) { 
                bigger[i] = values[i];
            }
            values = bigger;
        }
    IO.print("wert > ");
    v = readInt();
    }

    assert count > 0 : "keine Werte eingegeben!";

    double mean = sum / (double)count;

    int max = 0;

    for (int i = 0; i < count; i++) { 
        if (values[i] > max) max = values[i];
    }

    IO.println("Count: " + count);
    IO.println("Sum:   " + sum);
    IO.println("Mean:  " + mean);
    IO.println("Max:   " + max);
}

// Helper Methode
int readInt() {
    String line = IO.readln();
    return Integer.parseInt(line);
}



