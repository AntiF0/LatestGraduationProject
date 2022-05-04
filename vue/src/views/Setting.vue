<template>
  <div>
    <el-card style="width: 550px; height: 400px; margin-left: 235px; margin-top: 20px">
      <template #header>
        <div class="card-header">
          <span style="font-size: 25px">用户信息</span>
        </div>
      </template>
      <div>
        <div style="position: relative;text-align: center;margin-bottom: 10px">
          <div style="position: absolute;left: 0;top: 30px">头像:</div>
          <el-avatar shape="circle" :size="80" :fit="fits" :src="userInfo.uhead" style=""/>
          <el-button type="primary" @click="isShowChangeHead = true" style="position: absolute;left: 448px;top: 50px;">修改</el-button>
        </div>
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

    <el-dialog v-model="isShowChangeHead" width="50%" >
      <div style="text-align: center">
          <el-avatar shape="circle" :size="100" :fit="fits" :src="userInfo.uhead"/><br>
          <div style="text-align: left;margin-top: 20px;margin-bottom: 5px">当前头像url:</div>
          <el-input v-model="userInfo.uhead" disabled ></el-input>
        <div style="text-align: left;margin-top: 20px;margin-bottom: 5px">请输入想修改的头像url:</div>
        <el-input v-model="headInInput"></el-input>
      </div>
      <template #footer>
        <el-button @click="confirmChangeHead" type="primary">确定</el-button>
      </template>
    </el-dialog>

  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Setting",
  data() {
    return {
      userId: 0,
      userInfo: { },
      fits: "fill",
      url: "https://files.catbox.moe/0r42rd.png",
      isShowChangeHead: false,
      headInInput: "",
    }
  },
  created() {
    this.userId = JSON.parse(window.sessionStorage.getItem('userinfo')).uid;
    if (this.userId !== 0) {
      request.get("/userinfo",{
        params: {
          userId: this.userId
        }
      }).then(res => {
        this.userInfo = res.data.records[0]
        console.log(this.userInfo.uhead)
      })
    }
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
    },
    confirmChangeHead() {
      this.userInfo.uhead = this.headInInput;
      this.isShowChangeHead = false;
      this.updateUserInfo();
      this.$router.go(0)
    }
  }
}
</script>

<style scoped>

</style>