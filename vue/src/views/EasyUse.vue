<template>
  <div style="position: relative">
    <!-- 搜索框和任务选择框 -->
    <div v-show="isShow" style="width: 300px;height: 670px;">
      <!-- 左上方搜索框 -->
      <div style="padding-top: 10px; margin-left: 10px">
        <el-input style="width: 280px; margin-right: 10px" v-model="search" @input="getTaskData" clearable>
          <!--搜索icon 3行-->
          <template #prefix>
            <el-icon style="margin-top: 8px"><search /></el-icon>
          </template>
        </el-input>
<!--        <el-button style="width: 80px">搜索</el-button>-->
      </div>
      <!-- 左侧任务展示列表 -->
      <el-card style="max-width: 280px; height: 610px; margin-left: 10px; margin-top: 10px;">
        <el-scrollbar height="570px">
          <el-button v-for="item in taskData" @click="handleFocus(item)" style="width: 229px;height: 60px;font-size: 20px;margin-left: 0;margin-bottom: 10px">
            <div style="width: 200px; text-align: left;text-overflow:ellipsis;overflow: hidden;"> {{item.tname}} </div>
          </el-button>
        </el-scrollbar>
      </el-card>
    </div>
    <!-- 收起任务显示面板 -->
    <el-button style="position: absolute;left: 300px;top: 20px" @click="showSelectTask" v-show="isHideSelectTask" type="primary" id="one">
      <el-icon><arrow-left-bold /></el-icon>
    </el-button>
    <!-- 展示任务显示面板 -->
    <el-button style="position: absolute;left: 10px;top: 20px" @click="showSelectTask" v-show="isShowSelectTask" type="primary">
      <el-icon><arrow-right-bold /></el-icon>
    </el-button>
    <!-- 专注计时界面 注意这里不能用%来确定位置,否则当左侧div隐藏时,位置会发生偏移-->
    <el-card style="width: 900px; height: 450px;position: absolute; left: 60px; top: 110px; z-index: -1; ">
      <!-- 名言 -->
      <div style="text-align: center;font-size: 30px;font-family: Georgia, serif;">
        " {{currentUserInfo.usaying}} "
      </div>
      <!-- 任务名 -->
      <div style="margin-top: 30px;font-size: 20px;text-align: center;">
        -- {{ selectedTaskInfo.tname }} --
      </div>
      <!-- 时间显示 -->
      <div style="width: 280px;height: 250px;position: absolute; left: 50%;top: 65%; transform: translate(-50%, -50%);">
        <!-- 待定页面 -->
        <div style="border: dashed #409eff;border-radius: 20px;width: 280px;height: 250px;text-align: center;line-height: 250px;position: absolute;top: -30px;font-size: 35px;color: #409eff" v-show="isShowLoad">
          待定
        </div>
        <!-- 正计时 -->
        <div v-show="isShowAddTime">
          <!-- 小时 -->
          <div style="width: 80px; height: 150px;text-align: center;position: absolute;left: 0;top: 0px;">
            <div style="height: 90px;line-height: 90px;font-size: 60px;background-color: #303030;color: white;border-radius: 10px;">
              {{ addHour }} </div>
            <div style="font-size: 18px;margin-top: 10px;">小时</div>
          </div>
          <!-- 冒号 -->
          <div style="width: 20px;height: 90px;line-height: 90px;text-align: center;font-size: 60px;position: absolute;left: 80px;top: -5px;color: #303030;">:</div>
          <!-- 分钟 -->
          <div style="width: 80px; height: 150px;text-align: center;position: absolute;left: 100px;top: 0px;">
            <div style="height: 90px;line-height: 90px;font-size: 60px;background-color: #303030;color: white;border-radius: 10px;">
              {{ addMinute }} </div>
            <div style="font-size: 18px;margin-top: 10px;">分钟</div>
          </div>
          <!-- 冒号 -->
          <div style="width: 20px;height: 90px;line-height: 90px;text-align: center;font-size: 60px;position: absolute;left: 180px;top: -5px;color: #303030;">:</div>
          <!-- 秒 -->
          <div style="width: 80px; height: 150px;text-align: center;position: absolute;left: 200px;top: 0px;">
            <div style="height: 90px;line-height: 90px;font-size: 60px;background-color: #303030;color: white;border-radius: 10px;">
              {{ addSecond }} </div>
            <div style="font-size: 18px;margin-top: 10px;">秒</div>
          </div>
          <el-button v-show="isShowAddStartTime" color="#409eff" plain style="width: 120px;height: 60px;font-size: 20px;position: absolute;left: 80px;top: 170px" @click="startAddTime">开始计时</el-button>
          <!-- 按钮 -->
          <div style="position: absolute;left: 54px;top: 170px;">
            <el-button type="primary" v-show="isShowAddPauseTime" @click="addPauseTime" color="#409eff" plain style="margin-left: 0px;width: 80px;height: 40px;">暂停</el-button>
            <el-button type="primary" v-show="isShowAddContinueTime" @click="addStartTime" color="#409eff" plain style="margin-left: 0px;width: 80px;height: 40px;">继续</el-button>
            <el-popconfirm title="确定完成吗?" @confirm="endAddTime">
              <template #reference>
                <el-button type="primary" v-show="isShowAddEndTime" color="#409eff" plain style="width: 80px;height: 40px;">结束</el-button>
              </template>
            </el-popconfirm>
          </div>
        </div>
        <!-- 倒计时 -->
        <div v-show="isShowSubTime">
          <!-- 小时 -->
          <div style="width: 80px; height: 150px;text-align: center;position: absolute;left: 0;top: 0px;">
            <div style="height: 90px;line-height: 90px;font-size: 60px;background-color: #303030;color: white;border-radius: 10px;">
              {{ subHour }} </div>
            <div style="font-size: 18px;margin-top: 10px;">小时</div>
          </div>
          <!-- 冒号 -->
          <div style="width: 20px;height: 90px;line-height: 90px;text-align: center;font-size: 60px;position: absolute;left: 80px;top: -5px;color: #303030;">:</div>
          <!-- 分钟 -->
          <div style="width: 80px; height: 150px;text-align: center;position: absolute;left: 100px;top: 0px;">
            <div style="height: 90px;line-height: 90px;font-size: 60px;background-color: #303030;color: white;border-radius: 10px;">
              {{ subMinute }} </div>
            <div style="font-size: 18px;margin-top: 10px;">分钟</div>
          </div>
          <!-- 冒号 -->
          <div style="width: 20px;height: 90px;line-height: 90px;text-align: center;font-size: 60px;position: absolute;left: 180px;top: -5px;color: #303030;">:</div>
          <!-- 秒 -->
          <div style="width: 80px; height: 150px;text-align: center;position: absolute;left: 200px;top: 0px;">
            <div style="height: 90px;line-height: 90px;font-size: 60px;background-color: #303030;color: white;border-radius: 10px;">
              {{ subSecond }} </div>
            <div style="font-size: 18px;margin-top: 10px;">秒</div>
          </div>
          <el-button v-show="isShowSubStartTime" color="#409eff" plain style="width: 120px;height: 60px;font-size: 20px;position: absolute;left: 80px;top: 170px;" @click="startSubTime">开始计时</el-button>
          <!-- 按钮 -->
          <div style="position: absolute;left: 54px;top: 170px;">
            <el-button type="primary" v-show="isShowSubPauseTime" color="#409eff" plain @click="subPauseTime" style="width: 80px;height: 40px;">暂停</el-button>
            <el-button type="primary" v-show="isShowSubContinueTime" color="#409eff" plain @click="subStartTime" style="width: 80px;height: 40px;;margin-left: 0px">继续</el-button>
            <el-popconfirm title="确定完成吗?" @confirm="endSubTimeReal">
              <template #reference>
                <el-button type="primary" color="#409eff" plain v-show="isShowSubEndTime" style="width: 80px;height: 40px;">结束</el-button>
              </template>
            </el-popconfirm>
            <el-switch
                v-model="isCycleTime" v-show="isShowCycleTime"
                style="position: absolute;top: 50px;left: 32px;"
                active-text="循环时间"
            />
          </div>
        </div>
      </div>
    </el-card>
    <!-- 白噪音 -->
    <div style="position: absolute;left: 0;top: 570px;width: 1020px;height: 100px;z-index: -1;">
      <el-select v-model="chosenWhiteNoise" placeholder="请选择白噪音" style="position: absolute;left: 700px;top: 30px;" @change="changeWhiteNoise">
        <el-option
            v-for="item in whiteNoiseOption"
            :key="item.value"
            :label="item.label"
            :value="item.value"
        />
      </el-select>
      <audio controls id="beach" style="position: absolute;left: 50%;top: 45%;transform: translate(-50%, -50%);z-index: 1;" v-show="isShowBeach" loop>
        <source src="../assets/Beach.mp3">
      </audio>
      <audio controls id="rain" style="position: absolute;left: 50%;top: 45%;transform: translate(-50%, -50%);z-index: 1;" v-show="isShowRain" loop>
        <source src="../assets/Rain.mp3">
      </audio>
      <audio controls id="office" style="position: absolute;left: 50%;top: 45%;transform: translate(-50%, -50%);z-index: 1;" v-show="isShowOffice" loop>
        <source src="../assets/Office.mp3">
      </audio>
    </div>
  </div>
</template>

<script>
import { ArrowLeftBold, ArrowRightBold,Search } from '@element-plus/icons'
import request from "@/utils/request";

export default {
  name: "EasyUse",
  components: {
    ArrowLeftBold,
    ArrowRightBold,
    Search
  },
  data() {
    return {
      isShow: true,
      isHideSelectTask: true,
      isShowSelectTask: false,
      taskData: [ ], // 后端获取的任务信息
      currentUserId: 0, // 当前用户id
      currentUserInfo: [ ], // 当前用户信息
      search: "",
      selectedTaskInfo: [], // 左侧选择框选中的任务信息
      whiteNoiseOption: [ // 白噪音选项
        {
          value: 'beach',
          label: '沙滩'
        },
        {
          value: 'rain',
          label: '雨声'
        },
        {
          value: 'office',
          label: '办公室'
        },
      ],
      chosenWhiteNoise: 'beach', // 选择框选择的白噪音
      isShowBeach: true, // 是否显示沙滩白噪音
      isShowRain: false, // 是否显示雨声白噪音
      isShowOffice: false, // 是否显示办公室白噪音
      // 下面五个变量是有关正计时的
      addTime: null, // 正计时的setInterval变量
      addTransferTime: 0, // 返回给后端的变量 单位为分钟
      addHour: 0,
      addMinute: 0,
      addSecond: 0,
      // 下面六个变量是有关倒计时的
      subTime: null,
      subTransferTime: 0, // 从后端来的变量 单位为分钟,自动转化为秒
      subSpentTime: 0, // 返回给后端的变量,暂时单位为秒
      subHour: 0,
      subMinute: 0,
      subSecond: 0,
      isShowAddStartTime: true, // 开始正计时按钮的显示
      isShowSubStartTime: true, // 开始倒计时按钮的显示
      isShowAddTime: false, // 专注页面是否显示正计时
      isShowSubTime: false, // 专注页面是否显示倒计时
      isShowPlanTime: false, // 专注页面如果是定目标,显示时间计划
      isShowAddPauseTime: false, // 正计时是否出现暂停按钮
      isShowSubPauseTime: false, // 倒计时是否出现暂停按钮
      isShowAddContinueTime: false, // 正计时点击暂停后出现继续按钮
      isShowSubContinueTime: false, // 倒计时点击暂停后出现继续按钮
      isShowAddEndTime: false, // 正计时结束计时
      isShowSubEndTime: false, // 倒计时结束计时
      isShowLoad: true,
      focusForm: { }, // 新增专注记录时使用的对象
      isCycleTime: false, // 倒计时是否循环时间
      isShowCycleTime: false, // 是否显示循环时间
    }
  },
  created() {
    this.load();
    this.getUserInfo();
    this.getTaskData();
  },
  methods: {
    // 获取用户信息
    getUserInfo() {
      this.currentUserId = JSON.parse(window.sessionStorage.getItem('userinfo')).uid;
      if (this.currentUserId !== 0) {
        request.get("/userinfo",{
          params: {
            userId: this.currentUserID
          }
        }).then(res => {
          this.currentUserInfo = res.data.records[0]
          console.log(this.currentUserInfo)
        })
      }
    },
    // 初始化
    load() {
      this.isShow = true;
      this.isHideSelectTask = true;
      this.isShowSelectTask = false;
      // this.showSelectTask();
    },
    // 展示左侧栏
    showSelectTask() {
      if (this.isShow === false)
        this.isShow = true;
      else
        this.isShow = false;

      if (this.isHideSelectTask === true) {
        this.isHideSelectTask = false;
        this.isShowSelectTask = true;
      } else if (this.isHideSelectTask === false) {
        this.isHideSelectTask = true;
        this.isShowSelectTask = false;
      }
    },
    // 获取全部的任务信息
    getTaskData() {
      request.get("/alltaskinfo",{
        params: {
          userId: this.currentUserId,
          search: this.search
        }
      }).then(res => {
        this.taskData = res.data
        console.log(this.taskData)
      })
    },
    // 选择框选中后修改显示的白噪音
    changeWhiteNoise() {
      // 初始化
      this.isShowBeach = false;
      this.isShowRain = false;
      this.isShowOffice = false;
      let beach = document.getElementById('beach');
      let rain = document.getElementById('rain');
      let office = document.getElementById('office');
      // 判断
      if (this.chosenWhiteNoise === 'beach') {
        this.isShowBeach = true;
        beach.pause();
        rain.pause();
        office.pause();
      } else if (this.chosenWhiteNoise === 'rain') {
        this.isShowRain = true;
        beach.pause();
        rain.pause();
        office.pause();
      } else if (this.chosenWhiteNoise === 'office') {
        this.isShowOffice = true;
        beach.pause();
        rain.pause();
        office.pause();
      }
    },
    // 点击某个任务,在专注框显示
    handleFocus(item) {
      this.selectedTaskInfo = JSON.parse(JSON.stringify(item));
      console.log(this.selectedTaskInfo);
      // (待写) 判断专注框是否有专注
      if (this.addTime !== null || this.subTime !== null) {
        this.$message({
          type: "warning",
          message: "有任务正在计时！"
        })
      } else {
        // 初始化
        this.initTime();
        console.log("下面是当前专注的任务信息");
        console.log(this.selectedTaskInfo);
        // 计时方法-正向计时
        if (this.selectedTaskInfo.ttaskMode === "正计时" || this.selectedTaskInfo.ttaskMode === "定目标") {
          this.isShowAddTime = true;
          if (this.selectedTaskInfo.ttaskMode === "定目标") {
            this.isShowPlanTime = true;
          }
        }
        // 计时方式-倒计时
        else if (this.selectedTaskInfo.ttaskMode === "番茄计时") {
          this.isShowSubTime = true;
          this.subTransferTime = this.selectedTaskInfo.ttomatoClock * 60; // 根据任务情况设置倒计时间
        }
        this.focusForm.fStartTime = this.getCurrentTime() // 获取当前时间
        this.isShowLoad = false;
        this.showSelectTask();
      }
    },
    // 开始正计时
    startAddTime() {
      this.addStartTime();
      this.isShowAddStartTime = false; // 隐藏开始按钮
      this.isShowAddPauseTime = true; // 显示暂停按钮
      this.isShowAddEndTime = true; // 显示结束按钮
    },
    // 开始倒计时
    startSubTime() {
      this.subStartTime();
      this.isShowSubStartTime = false; // 隐藏开始按钮
      this.isShowSubPauseTime = true; // 显示暂停按钮
      this.isShowSubEndTime = true; // 显示结束按钮
      this.isShowCycleTime = true;
    },
    // 返回当前时间 格式为 时:分:秒
    getCurrentTime() {
      let hours = new Date().getHours()
      let minutes = new Date().getMinutes()
      let seconds = new Date().getSeconds()
      return (hours + ":" + minutes + ":" + seconds)
    },
    // 正计时-开始计时
    addStartTime() {
      this.addTime = setInterval(() => {
        this.addSecond++
        if (this.addSecond >= 60) {
          this.addSecond -= 60
          this.addMinute++
        }
        if (this.addMinute >= 60) {
          this.addMinute -= 60
          this.addHour++;
        }
      }, 1000)
      if (this.isShowAddPauseTime === false) {
        this.isShowAddPauseTime = true
        this.isShowAddContinueTime = false
      }
    },
    // 正计时-暂停计时
    addPauseTime() {
      clearInterval(this.addTime)
      this.isShowAddPauseTime = false
      this.isShowAddContinueTime = true
    },
    // 正计时-结束计时
    endAddTime() {
      this.addTransferTime = this.addHour * 3600 + this.addMinute * 60 + this.addSecond
      this.focusForm.fEndTime = this.getCurrentTime()
      this.focusForm.fuserId = this.currentUserInfo.uid
      this.focusForm.ftaskId = this.selectedTaskInfo.tid
      this.focusForm.tname = this.selectedTaskInfo.tname
      this.focusForm.flastedTime = Math.floor(this.addTransferTime / 60)
      request.post("/focusinfo", this.focusForm).then(res => {
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "专注结束"
          })
        }
        else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.initTime() // 有关专注的变量初始化
      })
      this.isShowLoad = true;
      this.selectedTaskInfo = { };
    },
    // 倒计时-开始计时
    subStartTime() {
      this.subTime = setInterval(() => {
        this.subSpentTime++
        this.subTransferTime--
        this.subSecond = this.subTransferTime % 60
        this.subMinute = Math.floor(this.subTransferTime / 60 % 60)
        this.subHour = Math.floor(this.subTransferTime / 3600)
        if (this.subTransferTime === 0) {
          this.endSubTime()
        }
        console.log(this.subSpentTime);
      },1000)
      if (this.isShowSubPauseTime === false) {
        this.isShowSubPauseTime = true
        this.isShowSubContinueTime = false
      }
    },
    // 倒计时-暂停计时
    subPauseTime() {
      clearInterval(this.subTime)
      this.isShowSubPauseTime = false
      this.isShowSubContinueTime = true
    },
    // 倒计时-根据开关结束计时
    endSubTime() {
      if (this.isCycleTime === false) {
        console.log("已专注了 "+this.subSpentTime+" s")
        this.focusForm.fEndTime = this.getCurrentTime()
        this.focusForm.fuserId = this.currentUserInfo.uid
        this.focusForm.ftaskId = this.selectedTaskInfo.tid
        this.focusForm.flastedTime = Math.floor(this.subSpentTime / 60)
        this.focusForm.tname = this.selectedTaskInfo.tname;
        request.post("/focusinfo", this.focusForm).then(res => {
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "专注结束"
            })
          }
          else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
          this.initTime() // 有关专注的变量初始化
        })
        this.isShowLoad = true;
        this.selectedTaskInfo = { };
      } else {
        // 再次倒计时的准备工作
        this.subTransferTime = this.selectedTaskInfo.ttomatoClock * 60; // 根据任务情况设置倒计时间
        this.subHour = 0;
        this.subMinute = 0;
        this.subSecond = 0;
        clearInterval(this.subTime);
        this.subTime = null;
        this.subStartTime();
      }
    },
    endSubTimeReal() {
      console.log("已专注了 "+this.subSpentTime+" s")
      this.focusForm.fEndTime = this.getCurrentTime()
      this.focusForm.fuserId = this.currentUserInfo.uid
      this.focusForm.ftaskId = this.selectedTaskInfo.tid
      this.focusForm.flastedTime = Math.floor(this.subSpentTime / 60)
      this.focusForm.tname = this.selectedTaskInfo.tname;
      request.post("/focusinfo", this.focusForm).then(res => {
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "专注结束"
          })
        }
        else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.initTime() // 有关专注的变量初始化
      })
      this.isShowLoad = true;
      this.selectedTaskInfo = { };
    },
    // 每次关闭专注时都需要初始化
    initTime() {
      this.focusForm = { }
      this.addTransferTime = 0
      this.addHour = 0
      this.addMinute = 0
      this.addSecond = 0
      this.subTransferTime = 0
      this.subSpentTime = 0
      this.subHour = 0
      this.subMinute = 0
      this.subSecond = 0
      this.isShowAddTime = false;
      this.isShowSubTime = false;
      this.isShowAddPauseTime = false; // 正计时是否出现暂停按钮
      this.isShowSubPauseTime = false; // 倒计时是否出现暂停按钮
      this.isShowAddContinueTime = false; // 正计时点击暂停后出现继续按钮
      this.isShowSubContinueTime = false; // 倒计时点击暂停后出现继续按钮
      this.isShowAddEndTime = false;
      this.isShowSubEndTime = false;
      this.isShowCycleTime = false;
      this.isCycleTime = false;
      this.isShowAddStartTime = true; // 结束后显示开始正计时按钮
      this.isShowSubStartTime = true; // 结束后显示开始倒计时按钮
      if (this.addTime) {
        clearInterval(this.addTime)
        this.addTime = null
      }
      if (this.subTime) {
        clearInterval(this.subTime)
        this.subTime = null
      }
    }
  }
}
</script>

<style scoped>
</style>