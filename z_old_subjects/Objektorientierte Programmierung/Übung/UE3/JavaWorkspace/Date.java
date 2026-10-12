/* Date:                                                      DA, 2026-03-25 */
/* ------                                                                    */
/* Date class                                                                */
/* ========================================================================= */

public class Date {
    public final static Date INVALID_DATE = new Date(0,0,0); //final: konstante; static: auf Sichtbarkeit der ganzen Klasse (nicht nur Objekte)

    private int day;
    private int month;
    private int year;

    public Date(int day, int month, int year) {
        this.day = day;
        this.month = month;
        this.year = year;
    }

    public String toString() {
        return day + "." + month + "." + year;
    }
    
}