package com.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@TableName("focusinfo")
@Data
public class FocusInfo {
    @TableId(value = "fId", type = IdType.AUTO) // 将id设置为自增
    private Integer fId;
    private Integer fUserId;
    private Integer fTaskId;
    private String fTaskName;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date fDate;
    @JsonFormat(pattern = "HH:mm:ss", timezone = "GMT+8")
    private Date fStartTime;
    @JsonFormat(pattern = "HH:mm:ss", timezone = "GMT+8")
    private Date fEndTime;
    private Integer fLastedTime;
    private String fDetail;
}
