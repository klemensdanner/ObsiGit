import java.util.ArrayList;
import java.util.List;

public class DigraphAM extends AbstractGraph {
   
    protected int[][] adjacencyMatrix;

    DigraphAM(int nrOfVertices) {
        super(nrOfVertices);
        adjacencyMatrix = new int[nrOfVertices][nrOfVertices]; // default init with 0
    }

    public void addEdge(int v, int w) {
        if (!hasEdge(v, w)) {
            adjacencyMatrix[v][w] = 1;
            incNrOfEdges();
        }
    }

    public void removeEdge(int v, int w) {
        if (hasEdge(v,w)) {
            adjacencyMatrix[v][w] = 0;
            decNrOfEdges();
        }
    }

    public boolean hasEdge(int v, int w) {
        validateVertex(v);
        validateVertex(w);
        return adjacencyMatrix[v][w] != 0;
    }

    @Override
    public Iterable<Integer> getAdj(int v) {
        validateVertex(v);
        List<Integer> adjList = new ArrayList<Integer>();
        int[] adjs = adjacencyMatrix[v];
        for (int i = 0; i < adjs.length; i++) {
            if (adjs[i] > 0) {
                adjList.add(i);
            }
        }
        return adjList;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        int vert = getNrOfVertices();
        sb.append("Graph with " + vert + " vertices and " + getNrOfEdges() + " edges: \n\n");
        sb.append("    | ");
        for (int i = 0; i < vert; i++) {
            sb.append(String.format("%3d", i));
        }
        sb.append("\n");
        for (int i = 0; i < vert+3; i++) { sb.append(String.format("---")); }        
        sb.append("\n");
        for (int i = 0; i < adjacencyMatrix.length; i++) {
            int[] row = adjacencyMatrix[i];
            sb.append(String.format("%3d | ", i));            
            for (int e : row) { // check for edges
                String mark = e > 0 ? "  x" : "   ";
                sb.append(mark);
            }
            sb.append("\n");
        }
        return sb.toString();
    } // toString    

}
