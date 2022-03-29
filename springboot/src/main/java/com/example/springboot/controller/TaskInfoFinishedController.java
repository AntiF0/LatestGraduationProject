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

@RestController
@RequestMapping("/taskinfofinished")
public class TaskInfoFinishedController {
    // 通常是controller中引入service,service中引入mapper
    // 此处为了简化
    @Resource
    TaskInfoMapper taskInfoMapper;

    // 新增数据
    @PostMapping
    public Result<?> save(@RequestBody TaskInfo taskInfo) {
        taskInfo.setTCreateDate(new Date());
        taskInfoMapper.insert(taskInfo);
        return Result.success();
    }

    //更新数据
    @PutMapping
    public Result<?> update(@RequestBody TaskInfo taskInfo) {
        taskInfoMapper.updateById(taskInfo);
        return Result.success();
    }

    //删除数据
    //使用@PathVariable来实现数据的获取
    @DeleteMapping("/{tid}")
    public Result<?> update(@PathVariable Long tid) {
        taskInfoMapper.deleteById(tid);
        return Result.success();
    }

    // 查找数据
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "0") Integer userId) {
        LambdaQueryWrapper<TaskInfo> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(TaskInfo::getTIsPigeonholed, 1).eq(TaskInfo::getTUserId, userId);
        // 暂时只根据任务名和任务描述搜索
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(TaskInfo::getTName, search).or().
                    like(TaskInfo::getTDescribe, search);
        }
        Page<TaskInfo> taskInfoPage = taskInfoMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(taskInfoPage);
    }
}
