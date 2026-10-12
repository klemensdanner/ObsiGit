/* Mean:                                                      DA, 2026-03-11 */
/* ------                                                                    */
/* Read values from user as long as value > 0. Build overall sum and         */
/* count the number of valid values. Dived overall sum by number of valid    */
/* values. Print the result.                                                 */
/* ========================================================================= */

void main() {
    int sum = 0;
    int noOfValues = 0;

    IO.print("value (int) > ");
    int value = readInt();

    while (value > 0) {
        //sum = sum + value;
        sum += value;
        //noOfValues = noOfValues + 1;
        noOfValues++;

        IO.print("value (int) > ");
        value = readInt();
    }

    double result = noOfValues > 0 ? (double) sum / noOfValues : 0;

    if (noOfValues > 0) {
        IO.println("Mean = " + result);
    } else {
        IO.println("ERROR: No values entered to calculate the mean");
    }

}

int readInt() {
    String line = IO.readln();
    return Integer.parseInt(line);
}