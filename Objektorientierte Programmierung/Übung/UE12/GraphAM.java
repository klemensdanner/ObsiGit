/* GraphAM:                                                   DA, 2026-06-02 */
/* ------                                                                    */
/*                                                                           */
/* ========================================================================= */

import java.util.ArrayList;
import java.util.List;

public class GraphAM extends AbstractGraph {

    protected int[][] adjacencyMatrix;


    public GraphAM(int nrOfVertices) {
        super(nrOfVertices);
        adjacencyMatrix = new int[nrOfVertices][nrOfVertices];
    }

    

    public void addEdge(int v, int w) {
        validateVertex(v);
        validateVertex(w);
        adjacencyMatrix[v][w] = 1;
        adjacencyMatrix[w][v] = 1;
        incNrOfEdges();
    }



    public void removeEdge(int v, int w) {
        validateVertex(v);
        validateVertex(w);
        adjacencyMatrix[v][w] = 0;
        adjacencyMatrix[w][v] = 0;
        decNrOfEdges();


    }

    public boolean hasEdge(int v, int w) {
        return adjacencyMatrix[v][w] != 0;
    }

    public Iterable<Integer> getAdj(int v) {
        validateVertex(v);

        List<Integer> adjList = new ArrayList<Integer>();
        
        for (int i = 0; i < adjacencyMatrix[v].length; i++) {
            if (adjacencyMatrix[v][i] > 0) {
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

    // write graph in Graphviz format
    public String toGraphviz() {
        StringBuilder sb = new StringBuilder();
        sb.append("graph { \n  rankdir = LR; \n");
        for (int v = 0; v < getNrOfVertices(); v++) {
            for (int w = v; w < getNrOfVertices(); w++) {
                if (adjacencyMatrix[v][w] > 0) {
                    sb.append(String.format("  %d - %d\n", v, w));
                }
            }    
        }
        sb.append("}\n");    
        sb.append(graphvizFooter());    
        return sb.toString();
    } // toGraphviz















}