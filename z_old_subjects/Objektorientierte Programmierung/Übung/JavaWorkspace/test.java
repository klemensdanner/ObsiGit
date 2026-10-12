




public class test2 {
        void main() {
        int testVar = 8;
        IO.println(testVar);
        test.test1 test_test1 = new test.test1();

    }

}

void main() {
    test test = new test();
    test.test1 test_test1 = new test.test1();
    IO.println(test.getTestVar());
    IO.println(test_test1.getTestVar());
}

public int getTestVar() {
    return 5;
}


public class test {
    int testVar = 1;

    public int getTestVar() {
        return testVar;
    }

    public static class test1 {
        int testVar = 2;
        public int getTestVar() {
            return testVar;
        }
    }

    void main() {
      IO.print(0);
    }

}
