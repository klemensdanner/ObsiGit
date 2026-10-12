public interface WeightedGraph extends Graph {
    
    void addEdge(int v, int w, int weight);
    int getWeight(int v, int w);
    
}
