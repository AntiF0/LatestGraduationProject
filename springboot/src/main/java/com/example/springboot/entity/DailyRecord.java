package com.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@TableName("dailyrecord")
@Data
public class DailyRecord {
    @TableId(value = "dId", type = IdType.AUTO) // 将id设置为自增
    private Integer dId;
    private Integer dUserId;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date dDate;
    private String dContent;
}
