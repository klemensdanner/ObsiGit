/* HashStatistic:                                             DA, 2025-02-08 */
/* ------                                                                    */
/* Helper to count the collisions in the hash table and provide the number   */
/* of collisions as String.                                                  */
/* ========================================================================= */
public class HashStatistic {
    private int nrOfcollisions;

    public HashStatistic() {
        nrOfcollisions = 0;
    }

    public void incCollisions() {
        nrOfcollisions++;
    }

    public String toString() {
        return "Number of collisions: " + nrOfcollisions;
    } 

}