public interface Graph {
    int getNrOfVertices();
    int getNrOfEdges();
    void addEdge(int v, int w);
    void removeEdge(int v, int w);
    boolean hasEdge(int v, int w);
    Iterable<Integer> getAdj(int v);
}