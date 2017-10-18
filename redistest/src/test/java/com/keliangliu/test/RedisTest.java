package com.keliangliu.test;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext-redis.xml")
public class RedisTest {

    @Autowired
    JedisPool jedisPool;



    @Test
    public void set(){

        Jedis jedis = jedisPool.getResource();

        jedis.set("bb","aa");

        jedis.close();

    }


    @Test
    public void get() {

        Jedis jedis = jedisPool.getResource();
        String bb = jedis.get("bb");

        System.out.println(bb);
        jedis.close();

    }

    @Test
    public void flushAll() {

        Jedis jedis = jedisPool.getResource();

        jedis.flushAll();
        jedis.close();

    }



}
