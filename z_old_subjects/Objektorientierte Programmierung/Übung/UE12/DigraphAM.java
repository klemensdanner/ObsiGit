/* GraphAM:                                                   DA, 2026-06-02 */
/* ------                                                                    */
/*                                                                           */
/* ========================================================================= */

import java.util.ArrayList;
import java.util.List;

public class DigraphAM extends GraphAM {



    public DigraphAM(int nrOfVertices) {
        super(nrOfVertices);
    }

    

    public void addEdge(int v, int w) {
        validateVertex(v);
        validateVertex(w);
        adjacencyMatrix[v][w] = 1;
        incNrOfEdges();
    }



    public void removeEdge(int v, int w) {
        validateVertex(v);
        validateVertex(w);
        adjacencyMatrix[v][w] = 0;
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




    // write graph in Graphviz format
    public String toGraphviz() {
        StringBuilder sb = new StringBuilder();
        sb.append("digraph { \n  rankdir = LR; \n");
        for (int v = 0; v < getNrOfVertices(); v++) {
            for (int w = 0; w < getNrOfVertices(); w++) {
                if (adjacencyMatrix[v][w] > 0) {
                    sb.append(String.format("  %d -> %d\n", v, w));
                }
            }    
        }
        sb.append("}\n");    
        sb.append(graphvizFooter());    
        return sb.toString();
    } // toGraphviz



    












}