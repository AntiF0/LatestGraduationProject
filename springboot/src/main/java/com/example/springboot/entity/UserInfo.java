package com.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("userinfo")
@Data
public class UserInfo {
    @TableId(value = "uId", type = IdType.AUTO) // 将id设置为自增
    private Integer uId;
    private String uName;
    private String uPassword;
    private String uSaying;
    private Integer uSuper;
    private Integer uFocusedNum;
    private Integer uFocusedTime;
    private String uHead;
}
