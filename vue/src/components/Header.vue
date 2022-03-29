<template>
  <div style="height: 80px; line-height: 80px; border-bottom: 1px solid #ccc; display: flex">
    <div style="width: 500px; padding-left: 30px; font-weight: bold; color: dodgerblue; font-size: 25px">基于时间统计的待办事项管理系统</div>
    <div style="flex: 1"></div>
    <div style="width: 120px;text-align: center;">
      <el-dropdown style="margin-top: 30px;font-size: 15px">
        <span>
          {{ userinfo.uname }} ,您好!
        <el-icon class="el-icon--right">
          <arrow-down />
        </el-icon>
        </span>
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
import { ArrowDown } from '@element-plus/icons'

export default {
  name: "Header",
  components: {
    ArrowDown
  },
  data() {
    return {
      username: "张三",
      userinfo: [ ]
    }
  },
  created() {
    this.load();
  },
  methods: {
    load() {
      // 读取session中的值,将其转化为userinfo对象
      this.userinfo = JSON.parse(window.sessionStorage.getItem('userinfo'));
      if (!this.userinfo) {
        this.$router.push({
          path: "/login",
          name: "Login"
        })
      }
    },
    loginout() {
      sessionStorage.clear(); // 退出登录后,删除session
      this.$router.push('/login');
    },
    pushSetting() {
      this.$router.push('/setting');
    }
  }
}
</script>

<style scoped>

</style>