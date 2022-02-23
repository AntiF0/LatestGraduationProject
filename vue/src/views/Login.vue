<template>
  <div class="login">
    <div class="login-all">

      <div class="login-text">欢迎登录</div>

      <el-form ref="form" :model="form" :rules="rules" class="login-form">
<!--        输入用户名-->
        <el-form-item prop="uname">
          <el-input v-model="form.uname">
            <template #prefix>
              <el-icon class="el-input__icon"><user /></el-icon>
            </template>
          </el-input>
        </el-form-item>
<!--        输入密码-->
        <el-form-item prop="upassword">
          <el-input v-model="form.upassword" show-password>
            <template #prefix>
              <el-icon class="el-input__icon"><lock /></el-icon>
            </template>
          </el-input>
        </el-form-item>
<!--        登录按钮-->
        <el-form-item>
          <el-button style="width: 100%; font-size: 20px;" type="primary" @click="login">登 录</el-button>
        </el-form-item>
      </el-form>

    </div>
  </div>
</template>

<script>
import { User, Lock } from "@element-plus/icons";
import request from "@/utils/request";

export default {
  name: "Login",
  data() {
    return {
      form: {},
      rules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' }
        ]
      }
    }
  },
  components: {
    User,
    Lock,
  },
  methods: {
    login() {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          request.post("/userinfo/login", this.form).then(res => {
            if (res.code === '0') {
              this.$message({
                type: "success",
                message: "登录成功"
              })
              sessionStorage.setItem("userinfo", JSON.stringify(res.data)) // 缓存用户信息
              // 登录成功之后进行页面跳转,跳转到主页
              this.$router.push("/")
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
    }
  }
}
</script>

<style scoped>
.login {
  width: 1200px;
  height: 750px;
  overflow: hidden;
}
.login-all {
  width: 400px;
  margin: 250px auto;
}
.login-text {
  color: black;
  font-size: 40px;
  text-align: center;
  line-height: 30px;
  padding: 30px;
}
.login-form {
}
</style>