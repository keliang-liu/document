package com.keliangliu.test;

import com.keliangliu.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext-spring-data-redis.xml")
public class RedisSpringDataTest {


    private RedisTemplate<String,User> redisTemplate;

    @Autowired
    public void setRedisTemplate(RedisTemplate<String, User> redisTemplate) {

        this.redisTemplate = redisTemplate;

        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setValueSerializer(new Jackson2JsonRedisSerializer<User>(User.class));


    }



    @Test
    public void set(){

        User user = new User();
        user.setName("小明");
        user.setAge(11);
        user.setAddress("中国");

        redisTemplate.opsForValue().set("user : 1",user);


    }


    @Test
    public void get() {
        User user = redisTemplate.opsForValue().get("user : 1");

        System.out.println(user.getAddress() + user.getName() + user.getAddress());
    }
}
