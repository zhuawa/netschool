package com.esen.netschool.zuul;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.netflix.feign.EnableFeignClients;
import org.springframework.cloud.netflix.zuul.EnableZuulProxy;

import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * 路由转发, 权限验证
 *
 */
@SpringBootApplication(exclude={DataSourceAutoConfiguration.class,HibernateJpaAutoConfiguration.class
		})
@EnableZuulProxy
@EnableEurekaClient
@EnableFeignClients
@EnableSwagger2
public class NetschoolZuulApplication 
{
    public static void main( String[] args )
    {
    	SpringApplication.run(NetschoolZuulApplication.class, args);
    }
}
