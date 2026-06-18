void main() {
    Random random = new Random(1234);
    Knapsack ks = Knapsack.createRandomKnapsack(10, random);
    ks.solve();
}