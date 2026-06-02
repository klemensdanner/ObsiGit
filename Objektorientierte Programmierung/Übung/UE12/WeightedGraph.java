/* WeightedGraph:                                             DA, 2026-06-02 */
/* ------                                                                    */
/* basic interface for weighted graphs                                       */
/* ========================================================================= */



public interface WeightedGraph extends Graph {
    void addEdge(int v, int w, int weight);
    int getWeight(int v, int w);
}