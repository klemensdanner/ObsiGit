void main() {

    String[] names = {"HANNAH", "TIM", "CHIARA", "CHRISTOPH", "SEVERIN", 
                      "MIKHAIL", "MARIO", "TOM"};

    int htSize = 17;                      
    for (String key : names) {
        int h = HashFunction.hashCode4(key);
        IO.println("hashcode for " + key + " is " 
        + h + " for ht of size htsize index is " + h % htSize);
    }

}