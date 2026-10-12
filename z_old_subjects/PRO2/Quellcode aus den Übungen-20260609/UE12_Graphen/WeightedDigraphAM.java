public class WeightedDigraphAM extends DigraphAM implements WeightedGraph {
    
    WeightedDigraphAM(int nrOfVertices) {
        super(nrOfVertices);
    }

    public void addEdge(int v, int w, int weight) {
        // check weight positiv!
        validateVertex(v);
        validateVertex(w);
        adjacencyMatrix[v][w] = weight;
        incNrOfEdges();
    }

    public int getWeight(int v, int w) {
        validateVertex(v);
        validateVertex(w);
        return adjacencyMatrix[v][w];
    }
}