
import java.util.Random;

public class Knapsack {
    public static final int MAX_WEIGHT = 100;
    public static final int MAX_VALUE = 100;

    public static class Item {
        public int id;
        public int weight;
        public int value;

        public Item(int id, int weight, int value) {
            this.id = id;
            this.weight = weight;
            this.value = value;
        }
    }

    public Item[] items;
    public int capacity;

    public static Knapsack createRandomKnapsack(int n, Random random) {
        if (n <= 0) throw new IllegalArgumentException("invalid n");
        if (random == null) throw new IllegalArgumentException("random is null");

        Knapsack ks = new Knapsack();
        ks.items = new Item[n];

        int weightSum = 0;
        for (int i = 0; i < n; i++) {
            ks.items[i] = new Item(i + 1, random.nextInt(MAX_WEIGHT), random.nextInt(MAX_VALUE));
            weightSum += ks.items[i].weight;
        }

        ks.capacity = weightSum / 2;
        return ks;
    }

    private boolean[] solution;
    private int solutionWeight;
    private int solutionValue;
    private long nSolutions;
    private long nInvalidBranches;


    public void solve() {
        boolean[] itemIsPacked = new boolean[items.length];
        solutionWeight = 0;
        solutionValue = 0;
        nSolutions = 0;
        nInvalidBranches = 0;

        long now = System.nanoTime();
        packItem(0,0,0, itemIsPacked);
        long elapsed = System.nanoTime() - now;


        IO.println("Total weight: " + solutionWeight);
        IO.println("Total value: " + solutionValue);
        IO.print("Items: ");

        for (int i = 0; i < solution.length; i++) {
            if (solution[i]) IO.print(items[i].id + " ");
        }

        IO.println("Solutions: " + nSolutions);
        IO.println("Solutions: " + nSolutions);
        IO.println("Solutions: " + nSolutions);
        IO.println("Solutions: " + nSolutions);

        IO.println();

    }


    private void packItem(int itemIndex,
                          int totalWeight,
                          int totalValue,
                          boolean[] itemIsPacked) {

        if (totalWeight > capacity) {
            return;
        }


        if (itemIndex == itemIsPacked.length) { // packing completed
            if ((totalWeight <= capacity) && (totalValue > solutionValue)) {
                solution = itemIsPacked.clone();
                solutionWeight = totalWeight;
                solutionValue = totalValue;
            }
            return;
        }

        itemIsPacked[itemIndex] = false;
        packItem(itemIndex + 1, totalWeight, totalValue, itemIsPacked);
        itemIsPacked[itemIndex] = true;
        packItem(itemIndex + 1, totalWeight + items[itemIndex].weight, totalValue + items[itemIndex].value, itemIsPacked);
    
    }  
}