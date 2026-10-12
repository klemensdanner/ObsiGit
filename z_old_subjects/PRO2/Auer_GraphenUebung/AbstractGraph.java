public abstract class AbstractGraph implements Graph {
    private final int nrOfVertices;
    private int nrOfEdges;

    AbstractGraph(int nrOfVertices) {
        this.nrOfVertices = nrOfVertices;
        this.nrOfEdges = 0;
    }

    protected void validateVertex(int v) {
        if (v < 0 || v >= nrOfVertices) {
            throw new IllegalArgumentException(
                v + " is not a correct vertex identifier.");
        }
    }

    public int getNrOfVertices() { return nrOfVertices; }
    public int getNrOfEdges() {return nrOfEdges; }

    protected void incNrOfEdges() { nrOfEdges++; }
    protected void decNrOfEdges() { nrOfEdges--; }

}