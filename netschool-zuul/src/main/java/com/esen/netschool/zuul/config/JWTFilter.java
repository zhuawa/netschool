package com.esen.netschool.zuul.config;

import java.io.PrintWriter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.web.filter.authc.BasicHttpAuthenticationFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.http.HttpMethod;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.esen.netschool.common.bean.ErrorEnum;
import com.esen.netschool.common.bean.ResponseBean;
import com.esen.netschool.common.util.JWTUtil;
import com.esen.netschool.zuul.service.RedisService;
import com.google.gson.Gson;


public class JWTFilter extends BasicHttpAuthenticationFilter {

    private Logger LOGGER = LoggerFactory.getLogger(this.getClass());


    /**
     * 判断用户是否想要登入。
     * 检测header里面是否包含Authorization字段即可
     */
    @Override
    protected boolean isLoginAttempt(ServletRequest request, ServletResponse response) {
        HttpServletRequest req = (HttpServletRequest) request;
        String authorization = req.getHeader("Authorization");
        return authorization != null;
    }

    /**
     *
     */
    @Override
    protected boolean executeLogin(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        String authorization = httpServletRequest.getHeader("Authorization");

        BeanFactory factory = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext());
        RedisService redisService = (RedisService) factory.getBean("redisService");

        /**
         *  两步校验
         *  (1) token是否正确
         * （2）单点登陆，从缓存中读取该用户对应的token
         */
        boolean flag= false;

        if (authorization == null){
            return flag;
        }

//        if (JWTUtil.verifyToken(authorization)){
//            //校验登陆的token是否与缓存中的token保持一致
//            String userId = JWTUtil.getUsername(authorization);
//            if (((String)redisService.get(userId)).equalsIgnoreCase(authorization)){
//                flag = true;
//            }
//        }


        return JWTUtil.verifyToken(authorization);
    }

//    @Override
//    protected boolean onAccessDenied(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
//
//        PrintWriter out = null;
//        HttpServletResponse res = (HttpServletResponse) response;
//        try {
//            res.setCharacterEncoding("UTF-8");
//            res.setContentType("application/json");
//            out = response.getWriter();
//            out.println(new Gson().toJson(new ResponseBean(ErrorEnum.ERROR_10002.getErrorCode(),ErrorEnum.ERROR_10002.getErrorMsg(),"")));
//        } catch (Exception e) {
//        } finally {
//            if (null != out) {
//                out.flush();
//                out.close();
//            }
//        }
//        return false;
//    }

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        if (isLoginAttempt(request, response)) {
            try {
                return executeLogin(request, response);
            } catch (Exception e) {
                return false;
            }

        }else{
            return false;
        }
    }



    /**
     * 对跨域提供支持
     */
    @Override
    protected boolean preHandle(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest servletRequest = (HttpServletRequest) request;
        HttpServletResponse servletResponse = (HttpServletResponse) response;
        //处理跨域问题，跨域的请求首先会发一个options类型的请求
        if (servletRequest.getMethod().equals(HttpMethod.OPTIONS.name())) {
            return true;
        }

        boolean isAccess = isAccessAllowed(request, response, "");

        if (isAccess){
            return true;
        }
        servletResponse.setCharacterEncoding("UTF-8");
        //Subject subject = getSubject(request, response);
        PrintWriter printWriter = servletResponse.getWriter();
        servletResponse.setContentType("application/json;charset=UTF-8");
        servletResponse.setHeader("Access-Control-Allow-Origin", servletRequest.getHeader("Origin"));
        servletResponse.setHeader("Access-Control-Allow-Credentials", "true");
        servletResponse.setHeader("Vary", "Origin");

        String respStr=new Gson().toJson(new ResponseBean(ErrorEnum.ERROR_10002.getErrorCode(),ErrorEnum.ERROR_10002.getErrorMsg(),""));
        printWriter.write(respStr);
        printWriter.flush();
        servletResponse.setHeader("content-Length", respStr.getBytes().length + "");
//        return super.preHandle(request, response);
        return false;
    }

}
