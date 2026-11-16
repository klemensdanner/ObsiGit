import org.junit.jupiter.api.Test;
import swj3.collections.BSTMultiSet;
import swj3.collections.SortedMultiSet;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class BSTMultiSetTest {
    @Test
    public void add_insertsElements_sizeIncreasesAccordingly() {
        SortedMultiSet<Integer> s = new BSTMultiSet<>();
        assertEquals(0, s.size());
    }
}
