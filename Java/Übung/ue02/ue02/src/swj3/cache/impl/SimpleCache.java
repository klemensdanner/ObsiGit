package swj3.cache.impl;
import swj3.cache.Cache;

import java.time.*;
import java.time.temporal.ChronoUnit;
import java.util.*;

public class SimpleCache implements Cache {
    private static final Duration FOREVER = ChronoUnit.FOREVER.getDuration();
    private record Entry(Object value, Instant expireTime) { }



    private final Map<String, Entry> dataStore = new HashMap<>();
    private final SortedMap<Instant, Set<String>> expireTimes = new TreeMap<>();
    private final Clock clock;

    public SimpleCache() {
        this(Clock.systemUTC());
    }

    public SimpleCache(Clock clock) {
        this.clock = clock;
    }

    @Override
    public Object get(String key) {
        Entry entry = dataStore.get(key);
        return  entry != null ? entry.value() : null;
    }

    @Override
    public void set(String key, Object value) {
        dataStore.put(key, new Entry(value, Instant.MAX));
    }

    @Override
    public void del(String key) {
        // dataStore.remove(key);
        Entry entry = dataStore.remove(key);
        if (entry == null) {
            return;
        }

        Set<String> keySet = expireTimes.get(entry.expireTime());
        if (keySet != null) {
            keySet.remove(key);
            if (keySet.isEmpty()) {
                expireTimes.remove(entry.expireTime());
            }
        }
    }

    public void set(String key, Object value, Duration ttl) {
        if (key == null) {
            throw new IllegalArgumentException("Key must not be null");
        }

        // cap at MAX if adding ttl would overflow
        Instant now = Instant.now(clock);
        Duration maxTtl = Duration.between(now, Instant.MAX);
        Instant expireTime = ttl.compareTo(maxTtl) >= 0 ? Instant.MAX : now.plus(ttl);

        // remove previous expiration if exists
        Entry existingEntry = dataStore.get(key);
        if (existingEntry != null) {
            Set<String> oldSet = expireTimes.get(existingEntry.expireTime());
            if (oldSet != null) {
                oldSet.remove(key);
                if (oldSet.isEmpty()) {
                    expireTimes.remove(existingEntry.expireTime);
                }
            }
        }

        // add the key to the expireTimes
        Set<String> keySet = expireTimes.get(expireTime);
        if (keySet == null) {
            keySet = new HashSet<>();
            expireTimes.put(expireTime, keySet);
        }
        keySet.add(key);

        dataStore.put(key, new Entry(value, expireTime));
    }

    // Complexity: O(t + e + e * log(t))
    // t = timestamps
    // e = expired entries
    private void evictExpiredEntries1() {
        Instant now = Instant.now(clock);
        List<Instant> expiredTimestamps = new ArrayList<>();
        List<String> toEvict = new ArrayList<>();

        // Determine expired entries and associated timestamps
        for (Map.Entry<Instant, Set<String>> entry : expireTimes.entrySet()) {
            if (entry.getKey().isAfter(now)) {
                break;
            }

            expiredTimestamps.add(entry.getKey());
            toEvict.addAll(entry.getValue());
        }

        for (String key : toEvict) {
            expireTimes.remove(key);
        }


        for (Instant ts : expiredTimestamps) {
            expiredTimestamps.remove(ts);
        }
    }

}
