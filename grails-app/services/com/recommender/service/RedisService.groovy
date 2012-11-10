package com.recommender.service

import redis.clients.jedis.JedisPool
import redis.clients.jedis.JedisPoolConfig
import redis.clients.jedis.Jedis

class RedisService {

    static transactional = false

    private static JedisPool pool

    private boolean withJedisConnection(Closure closure) {
        if (!pool) {
            pool = new JedisPool(new JedisPoolConfig(), "localhost")
        }
        closure.delegate = pool.getResource()
        boolean status = false
        try {
            closure.call()
            status = true
        } catch (Exception e) {
            e.printStackTrace()
            log.error "${e.message}"
            log.error e.getStackTrace().toString()
        } finally {
            pool.returnResource((Jedis) closure.delegate);
        }
        status
    }

    public boolean set(String key, String value) {
        withJedisConnection {
            set(key, value)
        }
    }

    public String get(String key) {
        withJedisConnection {
            get(key)
        }
    }

    public void withSingleConnection(Closure closure) {
        withJedisConnection closure
    }
}
