/* Mean:                                                      DA, 2026-03-11 */
/* ------                                                                    */
/* Read values from console and calc arith. mean                             */
/* ========================================================================= */


void main() {
    int sum = 0;
    int count = 0;
    

    int value = readInt();


    while (value != 0) {
        sum += value;
        count++;
        value = readInt();
    }

    double result = count > 0 ? (double)sum / count : 0;
    
    if (count > 0) {
        IO.println("mean = " + result);
    } else {
        IO.println("ERRPOR: No values entered.");
    }

}

int readInt() {
    return Integer.parseInt(IO.readln("value > "));
}