package com.esen.netschool.zuul.repository;

import org.springframework.stereotype.Repository;

import com.esen.netschool.zuul.bean.PermissionRole;
import com.esen.netschool.zuul.bean.User;
import com.esen.netschool.zuul.bean.UserPermission;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

/**
 * @author xuyaohui
 * @date 2018/7/31 0031 上午 10:08
 */

@Repository
public interface UserDao {

    /**
     * 通过用户名获取用户基本信息
     * @param userAccount
     * @return
     */
    User getUserByName(String userAccount);

    /**
     * 通过用户ID获取该用户具有的权限
     * @param userAccount
     * @return
     */
    Set<String> getUserPermissions(String userAccount);

    /**
     * 获取所有权限及对
     * @return
     */
    List<PermissionRole> getAllRolesByPermission();

    /**
     * 获取用户访问菜单权限
     * @param userAccount
     * @return
     */
    Set<String> getMenuListByName(String userAccount);

}
