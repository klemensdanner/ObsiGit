import swj3.collections.BSTMultiSet;
import swj3.collections.SortedMultiSet;

public class SetMain {
    public void main() {
        SortedMultiSet<String> stringSet = new BSTMultiSet<>(); // type erasure: zu compilezeiten weiß die jvm nicht dass es ein String ist (nur comparable)
        var intSet = new BSTMultiSet<Integer>();



                stringSet.add("Hello World");
        stringSet.add("a");
        stringSet.add("b");

        System.out.printf("stringSet.get(\"A\") --> %s%n", stringSet.get("a"));

        System.out.printf("stringSet.get(\"B\") --> %s%n", stringSet.get("b"));

        intSet.add(42);
        intSet.add(50);

        System.out.printf("intSet.get(\"42\") --> %s%n", intSet.get(42));
        System.out.printf("intSet.get(\"42\") --> %s%n", intSet.get(55));


    }
}
