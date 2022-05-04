<template>
  <div style="height: 80px; line-height: 80px; border-bottom: 1px solid #ccc; display: flex">
    <!-- 项目介绍 -->
    <div style="width: 100px;margin-top: 15px;font-weight: bold; color: dodgerblue; font-size: 20px;text-align: center">
      <el-tooltip content="基于时间统计的待办事项管理系统 制作人:陈嘉欢" effect="customized">
<!--        <el-button type="text" style="font-size: 20px">-->
<!--          毕业设计-->
<!--        </el-button>-->
        <el-icon size="40px"><alarm-clock /></el-icon>
      </el-tooltip>
    </div>
    <!-- 链接 -->
    <div style="flex: 1;">
      <el-menu
        mode="horizontal"
        router
        style="height: 80px;width: 830px;"
      >
        <el-menu-item index="task">
          <el-icon><message-box /></el-icon>
          <template #title>待办事项</template>
        </el-menu-item>
        <el-menu-item index="daily-record">
          <el-icon><notebook /></el-icon>
          <template #title>每日记录</template>
        </el-menu-item>
        <el-menu-item index="data-analysis">
          <el-icon><data-analysis /></el-icon>
          <template #title>数据分析</template>
        </el-menu-item>
        <el-menu-item index="setting">
          <el-icon><setting /></el-icon>
          <template #title>用户设置</template>
        </el-menu-item>
        <el-sub-menu index="" v-show="isSuper">
          <template #title>
            <el-icon><user /></el-icon>管理员
          </template>
          <el-menu-item index="user">用户管理</el-menu-item>
          <el-menu-item index="taskInfo">任务管理</el-menu-item>
        </el-sub-menu>
        <el-menu-item index="easyUse">
          <el-button type="primary">简洁模式</el-button>
        </el-menu-item>
      </el-menu>
    </div>
<!--    &lt;!&ndash; 简约模式 &ndash;&gt;-->
<!--    <div style="position: absolute;left: 750px;background-color: #b2e68d">-->
<!--      <el-button @click="pushToEasyUse" style="position: absolute;top: 23px;">-->
<!--        简洁模式-->
<!--      </el-button>-->
<!--    </div>-->
    <!-- 右侧个人信息 -->
    <div style="width: 120px;text-align: center;position: relative;">
      <el-dropdown style="position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);">
<!--        <div style="width: 100px;text-overflow:ellipsis;overflow: hidden;">-->
<!--          {{ userinfo.uname }} ,您好!-->
<!--          <el-icon><arrow-down /></el-icon>-->
<!--        </div>-->
        <el-avatar shape="circle" :size="40" :fit="fits" :src="userinfo.uhead" />
        <template #dropdown>
          <el-dropdown-menu style="width: 90px">
            <el-button type="text" style="margin: 0 15px 0 15px; " @click.native="pushSetting">个人信息</el-button>
            <el-button type="text" style="margin: 0 15px 0 15px; " @click.native="loginout">退出系统</el-button>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
    </div>
  </div>
</template>

<script>
import { AlarmClock,ArrowDown,User,Search,MessageBox,DataAnalysis,Setting,Notebook,Clock } from '@element-plus/icons'
import request from "@/utils/request";

export default {
  name: "Header",
  components: {
    AlarmClock,
    ArrowDown,
    User,
    Search,
    MessageBox,
    DataAnalysis,
    Setting,
    Notebook,
    Clock
  },
  data() {
    return {
      isSuper: false,
      userId: 0,
      userinfo: { },
      fits: "fill",
      url: "https://files.catbox.moe/0r42rd.png",
    }
  },
  created() {
    // 没有就跳转到login
    if (!JSON.parse(window.sessionStorage.getItem('userinfo'))) {
      this.$router.push('/login');
    }
    this.userId = JSON.parse(window.sessionStorage.getItem('userinfo')).uid;
    if (this.userId !== 0) {
      request.get("/userinfo",{
        params: {
          userId: this.userId
        }
      }).then(res => {
        this.userinfo = res.data.records[0]
        console.log(this.userinfo)
      })
    }
    // 判断是否是管理员
    this.isSuper = JSON.parse(window.sessionStorage.getItem('userinfo')).usuper;
    // console.log("usuper是:"+ this.isSuper);
    if (this.isSuper === 1) {
      this.isSuper = true;
    }
  },
  mounted() {
  },
  methods: {
    // load() {
    //   // 读取session中的值,将其转化为userinfo对象
    //   // this.userinfo = JSON.parse(window.sessionStorage.getItem('userinfo'));
    //   if (!this.userinfo) {
    //     // this.$router.push({
    //     //   path: "/login",
    //     //   name: "Login"
    //     // })
    //     this.$router.push('/login');
    //   }
    //   if (this.userinfo.usuper === 1)
    //   {
    //     this.isSuper = true;
    //   }
    // },
    loginout() {
      sessionStorage.clear(); // 退出登录后,删除session
      this.$router.push('/login');
    },
    pushSetting() {
      this.$router.push('/setting');
    },
    // 跳到简洁界面
    pushToEasyUse() {
      this.$router.push('easyUse');
    }
  }
}
</script>

<style scoped>

</style>