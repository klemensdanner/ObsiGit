import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;

public class GraphAlgorithms {

    private static boolean[] marked;

    public static boolean[] getMarked() { return marked; }
    
    /* ------------------------------------------------
       Depth First Search for completely connected graph
       ------------------------------------------------ */
    public static void depthFirstSearch(Graph g, int s) {
        marked = new boolean[g.getNrOfVertices()];
        dfs(g, s);
    } // depthFirstSearch

    // uses a stack --> recursion
    private static void dfs(Graph g, int v) {
        marked[v] = true;
        for (int w : g.getAdj(v)) {
            if (!marked[w]) dfs(g, w);
        }
    } // dfs


    /* ------------------------------------------------
    Breadth First Search for completely connected Graph
    ------------------------------------------------ */
    public static void breadthFirstSearch(Graph g, int s) {
        marked = new boolean[g.getNrOfVertices()];
        bfs(g, s);
    }

    // uses a queue
    private static void bfs(Graph g, int v) {
        List<Integer> queue = new ArrayList<>();
        marked[v] = true;
        queue.addLast(v);
        while (!queue.isEmpty()) {
            int w = queue.removeFirst();
            for (int a : g.getAdj(w)) {
                if (!marked[a]) {
                    marked[a] = true;
                    queue.addLast(a);                    
                } // if
            } // for
        } // while
    } // bfs

    /* ----------------------------- */
    /* Shortest Path nach Dijkstra   */
    /* ----------------------------- */
    public static int shortestPath(WeightedDigraphAM g, int start, int destination) {
        final int INFINITY = Integer.MAX_VALUE;
        int noVert = g.getNrOfVertices();

        marked = new boolean[noVert];
        int[] distance = new int[noVert];

        for (int i = 0; i < distance.length; i++) {
            distance[i] = INFINITY;
        }

        distance[start] = 0;
        marked[start] = true;

        Iterable<Integer> adjacencies = g.getAdj(start);
        for (int v : adjacencies) {
            distance[v] = g.getWeight(start, v);
        }

        int selectedVertex = start;
        while (!allMarked(marked)) {
            int minDistance = INFINITY;
            for (int v = 0; v < distance.length; v++) {
                if (!marked[v] && distance[v] < minDistance) {
                    minDistance = distance[v];
                    selectedVertex = v;
                }
            }

            marked[selectedVertex] = true;
            for (int v = 0; v < distance.length; v++) {
                if (!marked[v] && g.hasEdge(selectedVertex, v)) {
                    int altDist = g.getWeight(selectedVertex, v) + distance[selectedVertex];
                    if (altDist < distance[v]) { // statt <=
                        distance[v] = altDist;
                    }
                }
            }
        }

        return distance[destination];
    }
    
    private static boolean allMarked(boolean[] m) {
        for (boolean b : m) {
            if (!b) { return false; }
        }
        return true;
    }

}
