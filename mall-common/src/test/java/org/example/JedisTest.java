package org.example;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import redis.clients.jedis.Jedis;

public class JedisTest {
    private static Jedis jedis;

    @Test
    public void t0() {
        String msg = jedis.ping();
        System.out.println(msg);
    }

    @BeforeAll
    public static void init() {
        jedis = new Jedis("127.0.0.1", 6379);
//        jedis.auth("root");
    }
}
