import java.util.ArrayList;
import java.util.List;

public class GraphAlgorithms {
    
    private static boolean[] marked; // mark visited nodes
    
    public static boolean[] getMarked() { return marked; }

    public static void depthFirstSearch(Graph g, int s) { // s -- startknoten
        marked = new boolean[g.getNrOfVertices()];
        dfs(g, s); // auslagern damit marked[] nur einmal angelegt wird
    }

    private static void dfs(Graph g, int v) {
        marked[v] = true;
        for (int w : g.getAdj(v)) {
            if (!marked[w]) {
                dfs(g, w);
            }
        }
    }



    public static void breadthFirstSearch(Graph g, int s) { // s -- startknoten
        marked = new boolean[g.getNrOfVertices()];
        bfs(g, s); // auslagern damit marked[] nur einmal angelegt wird
    }


    private static void bfs(Graph g, int s) {
        List<Integer> queue = new ArrayList<Integer>();
        marked[s] = true;
        queue.addLast(s);
        while (!queue.isEmpty()) {
            int v = queue.removeFirst();

            for (int w : g.getAdj(v)) {
                if (!marked[w]) {
                    marked[w] = true;
                    queue.addLast(w);
                }
            }
        
        }
    }


    public static int shortestPath(WeightedDigraphAM g, int start, int destination) {
        int nrOfVertices = g.getNrOfVertices();

        marked = new boolean[nrOfVertices];
        int[] shortestDistance = new int[nrOfVertices];

        for (int i = 0; i < shortestDistance.length; i++) {
            shortestDistance[i] = Integer.MAX_VALUE;
        }

        shortestDistance[start] = 0;
        marked[start] = true;


        for (int v : g.getAdj(start)) {
            shortestDistance[v] = g.getWeight(start, v);
        }

        int selected = start;

        while (!allMarked(marked)) {
            int minDistance = Integer.MAX_VALUE;
            for (int i = 0; i < shortestDistance.length; i++) {
                if (!marked[i] && shortestDistance[i] < minDistance) {
                    minDistance = shortestDistance[i];
                    selected = i;
                }

            }

            marked[selected] = true;
            for (int next : g.getAdj(selected)) {
                if (!marked[next]) {
                    int newDistance = g.getWeight(selected, next) + shortestDistance[selected];
                    if (newDistance < shortestDistance[next]) {
                        shortestDistance[next] = newDistance;
                    }
                }
            }
        }

        return shortestDistance[destination];
    }

    private static boolean allMarked(boolean[] marked) {
        for (boolean b : marked) {
            if (!b) return false;
        }
        return true;
    }
}
