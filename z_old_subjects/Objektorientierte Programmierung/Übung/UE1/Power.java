/* Power:                                                 DA, 2026-03-11 */
/* ------                                                                    */
/* calc power                                                               */
/* ========================================================================= */

//calc 
void main() {
    int n = readInt("n > ");
    int exp = readInt("exp > ");
    long p = 1;
    for (int i = 0; i < exp; i++) {
        p *= n;
    }
    IO.println(n + " ^ " + exp + " = " + p);
    
}


int readInt(String prompt) {
    return Integer.parseInt(IO.readln(prompt));
}