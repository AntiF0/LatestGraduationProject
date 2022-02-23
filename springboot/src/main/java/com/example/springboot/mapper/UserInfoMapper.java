package com.example.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.springboot.entity.UserInfo;

//继承BaseMapper，传输泛型是UserInfo
public interface UserInfoMapper extends BaseMapper<UserInfo> {
}
