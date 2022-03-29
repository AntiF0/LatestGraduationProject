package com.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@TableName("taskinfo")
@Data
public class TaskInfo {
    @TableId(value = "tId", type = IdType.AUTO) // 将id设置为自增
    private Integer tId;
    private Integer tUserId;
    private String tName;
    private String tDescribe;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date tCreateDate;
    private Integer tFocusedNum;
    private Integer tFocusedTime;
    private Integer tIsDeleted;
    private Integer tIsPigeonholed;
    private String tTaskMode;
    private Integer tPlanTime;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date tPlanEndDate;
    private Integer tTomatoClock;
}
