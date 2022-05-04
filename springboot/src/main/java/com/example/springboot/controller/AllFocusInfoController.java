package com.example.springboot.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.common.Result;
import com.example.springboot.entity.FocusInfo;
import com.example.springboot.mapper.FocusInfoMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/allfocusinfo")
public class AllFocusInfoController {
    // 通常是controller中引入service,service中引入mapper
    // 此处为了简化
    @Resource
    FocusInfoMapper focusInfoMapper;

    // 查找数据
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "") String search,
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
        List<FocusInfo> allFocusInfo = focusInfoMapper.selectList(wrapper);
        return Result.success(allFocusInfo);
    }
}
