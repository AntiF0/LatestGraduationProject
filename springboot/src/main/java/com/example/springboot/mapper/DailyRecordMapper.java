package com.example.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.springboot.entity.DailyRecord;

//继承BaseMapper，传输泛型是UserInfo
public interface DailyRecordMapper extends BaseMapper<DailyRecord> {
}
