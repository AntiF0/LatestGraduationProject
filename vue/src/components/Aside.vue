<template>
  <div>
    <el-menu class="all-menu" router>

<!--      <el-menu-item index="easyUse">-->
        <el-button type="primary" style="margin: 20px 0 10px 20px" @click="turnToEasyUse">
          简洁模式
        </el-button>
<!--      </el-menu-item>-->

      <div v-show="isShowMore">
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

      <el-menu-item index="user" v-show="isSuper">
        <el-icon><user /></el-icon>
        <template #title>用户管理</template>
      </el-menu-item>
      </div>

    </el-menu>
  </div>
</template>

<script>
import { User,Search,MessageBox,DataAnalysis,Setting,Notebook,Clock } from '@element-plus/icons'

export default {
  name: "Aside",
  components: {
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
      userinfo: [],
      isShowMore: true,
    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      // 读取session用户信息中的usuper属性,如果为1,表示为管理员,可以查看更多的界面
      this.userinfo = JSON.parse(window.sessionStorage.getItem('userinfo'));
      if (this.userinfo.usuper === 1)
      {
        this.isSuper = true;
      }
    },
    turnToEasyUse() {
      this.$router.push('easyUse');
    }
  }
}
</script>

<style scoped>
.all-menu {
  width: 180px;
  height: 670px;
  margin-left: 0;
  border: 0;
}
</style>