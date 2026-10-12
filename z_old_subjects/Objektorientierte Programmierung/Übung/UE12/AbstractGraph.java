/* AbstractGraph:                                             DA, 2026-06-02 */
/* ------                                                                    */
/* Abstract base class for graphs                                            */
/* ========================================================================= */


public abstract class AbstractGraph implements Graph {
    private final int nrOfVertices;
    private int nrOfEdges;


    protected AbstractGraph(int nrOfVertices) {
        assert nrOfVertices >= 0;
        this.nrOfVertices = nrOfVertices;
        this.nrOfEdges = 0;
    }

    protected void incNrOfEdges() {
        nrOfEdges++;
    }

    protected void decNrOfEdges() {
        nrOfEdges--;
    }


    public int getNrOfVertices() {
        return nrOfVertices;
    }

    public int getNrOfEdges() {
        return nrOfEdges;
    }

    protected void validateVertex(int v) {
        if ((v < 0) || (v >= nrOfVertices)) {
            throw new IllegalArgumentException();
        }
    }


    public abstract void addEdge(int v, int w);
    public abstract void removeEdge(int v, int w);
    public abstract boolean hasEdge(int v, int w);
    public abstract Iterable<Integer> getAdj(int v);
    public abstract String toGraphviz();

    protected String graphvizFooter() {
        return "// Draw your graph e.g. with https://magjac.com/graphviz-visual-editor or https://graph.flyte.org";
    }

}