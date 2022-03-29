<template>
  <div>
    <el-card style="width: 550px; height: 280px; margin-left: 200px; margin-top: 20px">
      <template #header>
        <div class="card-header">
          <span style="font-size: 25px">用户信息</span>
        </div>
      </template>
      <div>
        <div>
          <span style="">姓名:</span>
          <el-input style="width: 350px;margin-left: 120px" v-model="userInfo.uname" clearable/>
        </div>
        <div style="margin-top: 10px">
          <span style="">密码:</span>
          <el-input style="width: 350px;margin-left: 120px" v-model="userInfo.upassword" clearable show-password/>
        </div>
        <div style="margin-top: 10px">
          <span style="">名言:</span>
          <el-input style="width: 350px;margin-left: 120px" v-model="userInfo.usaying" clearable/>
        </div>
        <el-button style="margin-top: 20px;float: right" type="primary" @click="updateUserInfo">更新</el-button>
      </div>
    </el-card>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Setting",
  data() {
    return {
      userInfo: { },
    }
  },
  created() {
    this.userInfo = JSON.parse(window.sessionStorage.getItem('userinfo'))
    console.log(this.userInfo)
  },
  methods: {
    updateUserInfo() {
      if (this.userInfo.uid) {
        request.put("/userinfo", this.userInfo).then(res => {
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "更新成功"
            })
          }
          else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
        })
      }
      sessionStorage.clear()
      sessionStorage.setItem("userinfo", JSON.stringify(this.userInfo))
    }
  }
}
</script>

<style scoped>

</style>