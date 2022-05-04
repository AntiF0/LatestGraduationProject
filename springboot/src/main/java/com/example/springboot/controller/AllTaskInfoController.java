// 简洁模式 返回所有的任务(既未删除也未完成)
package com.example.springboot.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.common.Result;
import com.example.springboot.entity.TaskInfo;
import com.example.springboot.mapper.TaskInfoMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/alltaskinfo")
public class AllTaskInfoController {
    // 通常是controller中引入service,service中引入mapper
    // 此处为了简化
    @Resource
    TaskInfoMapper taskInfoMapper;

    // 查找数据
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "0") Integer userId) {
        LambdaQueryWrapper<TaskInfo> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(TaskInfo::getTIsDeleted, 0).eq(TaskInfo::getTIsPigeonholed, 0).eq(TaskInfo::getTUserId, userId);
        // 根据任务名搜索
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(TaskInfo::getTName, search);
        }
        List<TaskInfo> allTaskInfo = taskInfoMapper.selectList(wrapper);
        return Result.success(allTaskInfo);
    }
}
