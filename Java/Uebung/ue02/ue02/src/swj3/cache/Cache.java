package swj3.cache;

import java.time.Duration;

public interface Cache {
    Object get(String key);
    void set(String key, Object value);
    void del(String key);

    void set(String key, Object value, Duration ttl /*time to live*/);

}
