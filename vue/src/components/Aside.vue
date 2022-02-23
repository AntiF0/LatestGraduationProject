<template>
  <div>
    <el-menu class="all-menu" default-active="task" router>

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

      <el-menu-item index="time">
        <el-icon><clock /></el-icon>
        <template #title>专注模块</template>
      </el-menu-item>

      <el-menu-item index="user">
        <el-icon><user /></el-icon>
        <template #title>用户管理</template>
      </el-menu-item>

      <el-menu-item index="cardtest">
        <el-icon><clock /></el-icon>
        <template #title>卡片测试</template>
      </el-menu-item>

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