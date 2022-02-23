<template>
  <div style="height: 80px; line-height: 80px; border-bottom: 1px solid #ccc; display: flex">
    <div style="width: 500px; padding-left: 30px; font-weight: bold; color: dodgerblue; font-size: 25px">基于时间统计的待办事项管理系统</div>
    <div style="flex: 1"></div>
    <div style="width: 100px">
      <el-dropdown>
        <span class="el-dropdown-link">
          张三
        <el-icon class="el-icon--right">
          <arrow-down />
        </el-icon>
        </span>
        <template #dropdown>
          <el-dropdown-menu>
            <el-dropdown-item>个人信息</el-dropdown-item>
            <el-button type="text" style="margin: 0 15px 0 15px; " @click.native="$router.push('/login')">退出系统</el-button>
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
  }
}
</script>

<style scoped>

</style>