package com.example.springboot.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.common.Result;
import com.example.springboot.entity.DailyRecord;
import com.example.springboot.entity.TaskInfo;
import com.example.springboot.mapper.DailyRecordMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/alldailyrecord")
public class AllDailyRecordController {
    // 通常是controller中引入service,service中引入mapper
    // 此处为了简化
    @Resource
    DailyRecordMapper dailyRecordMapper;

    // 查找数据
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "") Integer userId,
                              @RequestParam(defaultValue = "") String date) {
        LambdaQueryWrapper<DailyRecord> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(DailyRecord::getDUserId, userId);
        // 根据文章内容搜索搜索
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(DailyRecord::getDContent, search);
        }
        // 每日记录主页面 根据选择的日期展示
        if (StrUtil.isNotBlank(date)) {
            wrapper.eq(DailyRecord::getDDate, date);
        }
        List<DailyRecord> allDailyRecord = dailyRecordMapper.selectList(wrapper);
        return Result.success(allDailyRecord);
    }
}
