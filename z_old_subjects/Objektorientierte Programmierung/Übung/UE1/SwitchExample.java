/* SwitchExample:                                                 DA, 2026-03-11 */
/* ------                                                                    */
/* demonstrate Switch statement                                              */
/* ========================================================================= */



void main() {
    int day = 17;

    switch (day) {
        case 1:
            IO.println("Montag");
            break;
        case 2:
            IO.println("Di");
            break;
        case 3:
            IO.println("Mi");
            break;
        case 4:
            IO.println("Do");
            break;
        case 5:
            IO.println("Fr");
            break;
        case 6:
            IO.println("Sa");
            break;
        case 7:
            IO.println("Sonn");
            break;
        default:
            IO.println("enter a valid number");
            break;
    }
}