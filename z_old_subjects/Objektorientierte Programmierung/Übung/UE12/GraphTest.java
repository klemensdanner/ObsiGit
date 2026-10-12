/* GraphTest:                                                 DA, 2026-05-29 */
/* ------                                                                    */
/* Contains all tests incl. import of test data for our different kind       */
/* of graphs.                                                                */
/* Special test methods are provided for the distinct graph types:           */
/* e.g. testGraph1() for simple undirected graphs.                           */
/* However, all test methods can be used with any graph type - only the      */
/* parameter for the method newSimpleGraph or newGraphFromFile needs to be   */
/* adapted accordingly.                                                      */
/* ========================================================================= */

import java.io.IOException;

void main() {

    IO.println("New Graph");
    IO.println("---------");
    Graph g;

    /* Alternative test scenarios */
    // 1. undirected graph with simple edges implemented with an adjacency matrix
    //g = newGraphFromFile(GraphKind.GRAPH_AM);

    // 2. undirected graph with simple edges implemented with adjacency lists
    //g = newGraphFromFile(GraphKind.GRAPH_AL); L
    
    // 3. directed graph with simple edges implemented with adjacency lists
    //g = newGraphFromFile(GraphKind.DIGRAPH_AM);    

    // 4. directed weighted graph implemented with an adjacency matrix
    //g = newGraphFromFile(GraphKind.DIGRAPH_AL);

    // 5. directed weighted graph implemented with an adjacency matrix
    g = newGraphFromFile(GraphKind.WEIGHTED_DIGRAPH_AM);    

    printBasicGraphInfo(g);

 
    IO.println();
    IO.println("Testing graph algorithms");
    IO.println("------------------------");
    int v = 0;
    IO.println("\nDepth-first Search starting at vertex " + v);
    GraphAlgorithms.depthFirstSearch(g, v);
    printMarked(GraphAlgorithms.getMarked());
    IO.println();

    // IO.println("\nIs the graph connected? " + GraphProcessing.isConnected(g)); // optional
    // IO.println();

    IO.println("Breadth-first search starting at vertex " + v);
    GraphAlgorithms.breadthFirstSearch(g, v);            // if ((vertWeight.length >= 2) && !(g instanceof WeightedGraph)) {
            //     v = Integer.parseInt(vertWeight[0]);
            //     w = Integer.parseInt(vertWeight[1]);  
            //     g.addEdge(v, w);                 
            // } else if ((vertWeight.length == 3) && (g instanceof WeightedGraph)) {
            //     v = Integer.parseInt(vertWeight[0]);
            //     w = Integer.parseInt(vertWeight[1]);      
            //     weight = Integer.parseInt(vertWeight[2]);      
            //     ((WeightedGraph)g).addEdge(v, w, weight);                          
            // }
    printMarked(GraphAlgorithms.getMarked());
    IO.println();

    // IO.println();
    // IO.println("Shortest Path (Dijkstra) between start and destination vertex");
    // IO.println("-------------------------------------------------------------");
    // if (g instanceof WeightedDigraphAM) {  
    //     int start = 0;
    //     int destination = 3;  
    //     IO.println("Shortest path in g from " + start + " to " + destination + " is of length " + GraphAlgorithms.shortestPath(
    //         (WeightedDigraphAM)g, start, destination));
    // } else {
    //     IO.println("Only weighted digraphs are considered for the shortest path algorithm.");
    // }
                
}

/* ---------------------------------------------------------------            // if ((vertWeight.length >= 2) && !(g instanceof WeightedGraph)) {
            //     v = Integer.parseInt(vertWeight[0]);
            //     w = Integer.parseInt(vertWeight[1]);  
            //     g.addEdge(v, w);                 
            // } else if ((vertWeight.length == 3) && (g instanceof WeightedGraph)) {
            //     v = Integer.parseInt(vertWeight[0]);
            //     w = Integer.parseInt(vertWeight[1]);      
            //     weight = Integer.parseInt(vertWeight[2]);      
            //     ((WeightedGraph)g).addEdge(v, w, weight);                          
            // }----------- */
/* Build test scenarios for different graph types                             */
/* -------------------------------------------------------------------------- */

// only vertices, no edges
private Graph newGraph(GraphKind gk, int nrOfVertices) {
    Graph g; 
    switch (gk) {
        case GRAPH_AM:              g = new GraphAM(nrOfVertices); break;
        // case GRAPH_AL:              g = new GraphAL(nrOfVertices); break;
        case DIGRAPH_AM:            g = new DigraphAM(nrOfVertices); break;
        // case DIGRAPH_AL:            g = new DigraphAL(nrOfVertices); break;
        case WEIGHTED_DIGRAPH_AM:   g = new WeightedDigraphAM(nrOfVertices); break;                       
        default: g = null;            // if ((vertWeight.length >= 2) && !(g instanceof WeightedGraph)) {
            //     v = Integer.parseInt(vertWeight[0]);
            //     w = Integer.parseInt(vertWeight[1]);  
            //     g.addEdge(v, w);                 
            // } else if ((vertWeight.length == 3) && (g instanceof WeightedGraph)) {
            //     v = Integer.parseInt(vertWeight[0]);
            //     w = Integer.parseInt(vertWeight[1]);      
            //     weight = Integer.parseInt(vertWeight[2]);      
            //     ((WeightedGraph)g).addEdge(v, w, weight);                          
            // }
            break;
    }
    return g;
} // newGraph

// print some basic info about the graph
private void printBasicGraphInfo(Graph g) {
    IO.println(g); // textual represention of graph
/*   
    IO.println("number of vertices = " + g.getNrOfVertices());
    IO.println("number of edges = " + g.getNrOfEdges());    

    int v = 0; IO.println("adjacencies of " + v + ": " + g.getAdj(v));
    v = 1;     IO.println("adjacencies of " + v + ": " + g.getAdj(v));
    v = 2;     IO.println("adjacencies of " + v + ": " + g.getAdj(v)); 
*/
    IO.println();
    IO.print(g.toGraphviz());  // code for graphviz
} // printBasicGraphInfo

private void printMarked(boolean[] marked) {
    IO.println("marked vertices in traversal:");
    for (int i = 0; i < marked.length; i++) {
        IO.println(String.format("%3d: %c", i, marked[i] ? 'y' : 'n'));
    }
    IO.println();
}


// init graph from file
public Graph newGraphFromFile(GraphKind gk) {
    Graph g;
    String         fileName = null;
    BufferedReader reader   = null;

    IO.println("Create graph from file\n");
    do {
      IO.print("source file name > ");
      fileName = IO.readln();
      try {
         reader = new BufferedReader(new FileReader(fileName));
      } catch (IOException e) {
        IO.println("error: file not found\n");
      } // catch
    } while (reader == null);

    try { // to handle IOException with readLine()
        // 1st line: number of vertices
        int nrOfVertices = Integer.parseInt(reader.readLine());
        g = newGraph(gk, nrOfVertices);

        // all lines starting with line 2 describe edges v-w and optionally a weight
        String line = reader.readLine();
        while (line != null && !line.isEmpty() && !line.isBlank()) {
            int v, w;       // start and end vertex of the edge
            int weight = 1; // weight of an edge

            String[] vertWeight = line.split(" ");  // vertices and weight in one line
            

            if ((vertWeight.length >= 2) && !(g instanceof WeightedGraph)) {
                v = Integer.parseInt(vertWeight[0]);
                w = Integer.parseInt(vertWeight[1]);
                g.addEdge(v, w);                 
            } else if ((vertWeight.length == 3) && (g instanceof WeightedGraph)) {
                v = Integer.parseInt(vertWeight[0]);
                w = Integer.parseInt(vertWeight[1]);      
                weight = Integer.parseInt(vertWeight[2]);      
                ((WeightedGraph)g).addEdge(v, w, weight);                          
            }
            line = reader.readLine();

        } // while
    } catch (IOException e) {
        IO.println("Exception occured when reading the input file for a new graph: " + e.getMessage());
        g = newGraph(gk, 0);
    }
    return g;
} // newGraphFromFile