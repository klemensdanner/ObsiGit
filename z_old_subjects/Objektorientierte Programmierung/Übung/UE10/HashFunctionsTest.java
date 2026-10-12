/* HashFunctionsTest:                                         DA, 2026-05-20 */
/* ------                                                                    */
/* Test program for hash functions                                           */
/* ========================================================================= */


void main() {
    String s = "Muehlviertel";

    IO.println("s.length() = " + s.length());
    int n = s.length();
    IO.println("1 : " + HashFunctions.hashCode1(s) % n);
    IO.println("2 : " + HashFunctions.hashCode2(s) % n);
    IO.println("3 : " + HashFunctions.hashCode3(s) % n);
    IO.println("4 : " + HashFunctions.hashCode4(s) % n);
    IO.println("5 : " + s.hashCode() % n);
}