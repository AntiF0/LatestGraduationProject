package com.example.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.springboot.entity.TaskInfo;

//继承BaseMapper，传输泛型是UserInfo
public interface TaskInfoMapper extends BaseMapper<TaskInfo> {
}
