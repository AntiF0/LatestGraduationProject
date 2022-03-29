package com.example.springboot.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.common.Result;
import com.example.springboot.entity.DailyRecord;
import com.example.springboot.mapper.DailyRecordMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;

@RestController
@RequestMapping("/dailyrecord")
public class DailyRecordController {
    // 通常是controller中引入service,service中引入mapper
    // 此处为了简化
    @Resource
    DailyRecordMapper dailyRecordMapper;

    // 新增数据
    @PostMapping
    public Result<?> save(@RequestBody DailyRecord dailyRecord) {
        // 下面这行浪费了我一上午...
//        dailyRecord.setDDate(new Date());
        dailyRecordMapper.insert(dailyRecord);
        return Result.success();
    }

    //更新数据
    @PutMapping
    public Result<?> update(@RequestBody DailyRecord dailyRecord) {
        dailyRecordMapper.updateById(dailyRecord);
        return Result.success();
    }

    //删除数据
    //使用@PathVariable来实现数据的获取
    @DeleteMapping("/{did}")
    public Result<?> update(@PathVariable Long did) {
        dailyRecordMapper.deleteById(did);
        return Result.success();
    }

    // 查找数据
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "5") Integer pageSize,
                              @RequestParam(defaultValue = "") String search,
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
        Page<DailyRecord> dailyRecordPage = dailyRecordMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(dailyRecordPage);
    }
}
