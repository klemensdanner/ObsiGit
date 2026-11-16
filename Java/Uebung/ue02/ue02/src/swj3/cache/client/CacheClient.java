package swj3.cache.client;

import swj3.cache.Cache;
import swj3.cache.impl.SimpleCache;
import swj3.util.AdjustableClock;

public class CacheClient {
    public static void main(String[] args) {
        Cache cache = new SimpleCache();

        AdjustableClock clock = new AdjustableClock();
        Cache cache = new SimpleCache(clock);






      /*  cache.set("Linz", 200_000);
        cache.set("Wien", 2_000_000);
        cache.set("Hagenberg", 3000);
        cache.set("Linz", 220_000);


        System.out.printf("Hagenberg: %s%n", cache.get("Hagenberg"));
        System.out.printf("Linz: %s%n", cache.get("Linz"));
        System.out.printf("Wien: %s%n", cache.get("Wien"));

        cache.del("Wien");
        System.out.printf("Wien: %s%n", cache.get("Wien")); */





    }
}
