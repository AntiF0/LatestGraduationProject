<template>
  <div style="width: 1020px; height: 750px;overflow: hidden">
    <div style="width: 400px; margin: 150px auto;">

      <div style="color: black; font-size: 40px; text-align: center; padding: 30px">欢迎注册</div>

      <el-form ref="form" :model="form" :rules="rules">
        <!-- 输入用户名 -->
        <el-form-item prop="uname">
          <el-input v-model="form.uname">
            <template #prefix>
              <el-icon class="el-input__icon"><user /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <!-- 输入密码 -->
        <el-form-item prop="upassword">
          <el-input v-model="form.upassword" show-password>
            <template #prefix>
              <el-icon class="el-input__icon"><lock /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <!-- 确认密码 -->
        <el-form-item prop="confirm">
          <el-input v-model="form.confirm" show-password>
            <template #prefix>
              <el-icon class="el-input__icon"><lock /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <!-- 登录按钮 -->
        <el-form-item>
          <el-button style="width: 100%; font-size: 20px;" type="primary" @click="register">注 册</el-button>
        </el-form-item>
        <!-- 注册按钮 -->
        <el-form-item>
          <el-button style="width: 100%; font-size: 20px;" type="primary" @click="goToLogin">返 回</el-button>
        </el-form-item>
      </el-form>

    </div>
  </div>
</template>

<script>
import { User, Lock } from "@element-plus/icons";
import request from "@/utils/request";

export default {
  name: "Register",
  data() {
    return {
      form: {},
      rules: {
        uname: [
          { required: true, message: '请输入用户名', trigger: 'blur' }
        ],
        upassword: [
          { required: true, message: '请输入密码', trigger: 'blur' }
        ],
        confirm: [
          { required: true, message: '请确认密码', trigger: 'blur' }
        ]
      }
    }
  },
  components: {
    User,
    Lock,
  },
  methods: {
    register() {
      if (this.form.upassword != this.form.confirm) {
        this.$message({
          type: "error",
          message: '两次密码输入不一致'
        })
        return //返回,不继续执行
      }
      this.form.uhead = "https://s1.ax1x.com/2022/04/16/LtBCTI.jpg";
      this.form.ufocusedTime = 0;
      this.form.ufocusedNum = 0;
      this.form.usuper = 0;
      this.$refs['form'].validate((valid) => {
        if (valid) {
          request.post("/userinfo/register", this.form).then(res => {
            if (res.code === '0') {
              this.$message({
                type: "success",
                message: "注册成功"
              })
              // 登录成功之后进行页面跳转,跳转到主页
              this.$router.push("/login")
            }
            else {
              this.$message({
                type: "error",
                message: res.msg
              })
            }
          })
        }
      })
    },
    goToLogin() {
      this.$router.push("/login");
    }
  }
}
</script>

<style scoped>

</style>