package com.example.springboot.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.common.Result;
import com.example.springboot.entity.DailyRecord;
import com.example.springboot.entity.FocusInfo;
import com.example.springboot.entity.TaskInfo;
import com.example.springboot.mapper.FocusInfoMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;

@RestController
@RequestMapping("/focusinfo")
public class FocusInfoController {
    // 通常是controller中引入service,service中引入mapper
    // 此处为了简化
    @Resource
    FocusInfoMapper focusInfoMapper;

    // 新增数据
    @PostMapping
    public Result<?> save(@RequestBody FocusInfo focusInfo) {
        focusInfo.setFDate(new Date());
        focusInfoMapper.insert(focusInfo);
        return Result.success();
    }

    //更新数据
    @PutMapping
    public Result<?> update(@RequestBody FocusInfo focusInfo) {
        focusInfoMapper.updateById(focusInfo);
        return Result.success();
    }

    //删除数据
    //使用@PathVariable来实现数据的获取
    @DeleteMapping("/{fid}")
    public Result<?> update(@PathVariable Long fid) {
        focusInfoMapper.deleteById(fid);
        return Result.success();
    }

    // 查找数据
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "0") Integer userId,
                              @RequestParam(defaultValue = "0") Integer taskId,
                              @RequestParam(defaultValue = "") String date) {
        LambdaQueryWrapper<FocusInfo> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(FocusInfo::getFUserId, userId);
        if (taskId != 0) {
            wrapper.eq(FocusInfo::getFTaskId, taskId);
        }
        // 暂时只根据专注描述搜索
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(FocusInfo::getFDetail, search);
        }
        // 每日记录主页面 根据选择的日期展示
        if (StrUtil.isNotBlank(date)) {
            wrapper.eq(FocusInfo::getFDate, date);
        }
        Page<FocusInfo> focusInfoPage = focusInfoMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(focusInfoPage);
    }
}
