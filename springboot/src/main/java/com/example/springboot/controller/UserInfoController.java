package com.example.springboot.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.common.Result;
import com.example.springboot.entity.UserInfo;
import com.example.springboot.mapper.UserInfoMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/userinfo")
public class UserInfoController {
    // 通常是controller中引入service,service中引入mapper
    // 此处为了简化
    @Resource
    UserInfoMapper userInfoMapper;

    //登录
    @PostMapping("/login")
    public Result<?> login(@RequestBody UserInfo userinfo) {
        UserInfo res = userInfoMapper.selectOne(Wrappers.<UserInfo>lambdaQuery().eq(UserInfo::getUName, userinfo.getUName()).eq(UserInfo::getUPassword, userinfo.getUPassword()));
        if (res == null) {
            return Result.error("-1", "用户名或密码错误");
        }
        return Result.success(res);
    }

    //注册
    //不能有重复的用户名
    @PostMapping("/register")
    public Result<?> register(@RequestBody UserInfo userInfo) {
        UserInfo res = userInfoMapper.selectOne(Wrappers.<UserInfo>lambdaQuery().eq(UserInfo::getUName, userInfo.getUName()));
        // 如果用户名重复了,失败
        if (res != null) {
            return Result.error("-1", "用户名重复");
        }
        // 如果密码未设置,自动添加密码:123456
        if (userInfo.getUPassword() == null) {
            userInfo.setUPassword("123456");
        }
        // 用户名不重复,添加数据
        userInfoMapper.insert(userInfo);
        return Result.success();
    }

    // 新增数据
    @PostMapping
    public Result<?> save(@RequestBody UserInfo userInfo) {
        //如果密码没传,直接设置为123456
        if(userInfo.getUPassword() == null) {
            userInfo.setUPassword("123456");
        }
        userInfoMapper.insert(userInfo);
        return Result.success();
    }

    //更新数据
    @PutMapping
    public Result<?> update(@RequestBody UserInfo userInfo) {
        userInfoMapper.updateById(userInfo);
        return Result.success();
    }

    //删除数据
    //使用@PathVariable来实现数据的获取
    @DeleteMapping("/{uid}")
    public Result<?> update(@PathVariable Long uid) {
        userInfoMapper.deleteById(uid);
        return Result.success();
    }

    // 查找数据
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "") Integer userId) {
        LambdaQueryWrapper<UserInfo> wrapper = Wrappers.lambdaQuery();
//        wrapper.eq(UserInfo::getUId, userId);
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(UserInfo::getUId, search).or().
                    like(UserInfo::getUName, search).or().
                    like(UserInfo::getUPassword, search).or().
                    like(UserInfo::getUSaying, search);
        }
        if (userId != null) {
            wrapper.eq(UserInfo::getUId, userId);
        }
        Page<UserInfo> userInfoPage = userInfoMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(userInfoPage);
    }
}
