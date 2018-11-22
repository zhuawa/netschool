package com.esen.netschool.zuul.filter;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.esen.eacl.Login;
import com.esen.eacl.WebUtils;
import com.esen.netschool.zuul.bean.ResponseBean;
import com.esen.netschool.zuul.service.RedisService;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;

/**
 * @author xuyaohui
 * @date 2018-8-6
 */

@Component
public class FirstFilter extends ZuulFilter {
	
	@Autowired
	RedisService redisService;

    @Override
    public String filterType() {
        return "pre";
    }

    @Override
    public int filterOrder() {
        return 0;
    }

    @Override
    public boolean shouldFilter() {
        return true;
    }

    @Override
    public Object run() {
        System.out.println("初始登录，进行权限验证...");
        RequestContext ctx = RequestContext.getCurrentContext();
        ResponseBean rb = new ResponseBean(200, "msg", "data");
        HttpServletRequest request = ctx.getRequest();
        WebApplicationContext wc = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
//        Login login = wc.getBean("aclLogin", Login.class);
        if(!redisService.exists("rb3")){
        	redisService.set("rb3", rb);
        }
        ResponseBean r = (ResponseBean)(redisService.get("rb3"));
//        String accessToken = String.valueOf(request.getParameter("Token"));
//        if(!"xuyaohui".equals(accessToken)) {
//            ctx.setSendZuulResponse(false);
//            ctx.setResponseStatusCode(401);
//            return null;
//        }
        return null;
    }
}
