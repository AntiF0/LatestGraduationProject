<template>
  <div style="width: 1020px;height: 670px;position: relative;text-align: center">

    <!-- 上方功能区域 -->
    <div style="padding: 20px 20px 0 0;">
      <!-- 新增按钮 -->
      <el-button type="primary" @click="isShowAdd=true;form={}" v-show="isShowAddButton" style="height: 40px;margin-left: 20px">新增</el-button>
      <!-- 搜索 -->
      <!--输入框-->
      <el-input size="large" v-model="search1" clearable style="width: 30%;margin-left: 20px" v-show="showUnFinishedUnDeleted" @input="selectLoad">
        <!--搜索icon 3行-->
        <template #prefix>
          <el-icon class="el-input__icon"><search /></el-icon>
        </template>
      </el-input>
      <el-input size="large" v-model="search2" clearable style="width: 30%;margin-left: 20px" v-show="showFinished" @input="selectLoad">
        <!--搜索icon 3行-->
        <template #prefix>
          <el-icon class="el-input__icon"><search /></el-icon>
        </template>
      </el-input>
      <el-input size="large" v-model="search3" clearable style="width: 30%;margin-left: 20px" v-show="showDeleted" @input="selectLoad">
        <!--搜索icon 3行-->
        <template #prefix>
          <el-icon class="el-input__icon"><search /></el-icon>
        </template>
      </el-input>
<!--      &lt;!&ndash;搜索按钮&ndash;&gt;-->
<!--      <el-button type="primary" @click="selectLoad" style="height: 40px;margin: 0 0 0 20px;">搜索</el-button>-->
<!--      &lt;!&ndash; 重置按钮 &ndash;&gt;-->
<!--      <el-button type="primary" @click="reset" style="height: 40px;margin: 0 10px 0 20px;">重置</el-button>-->
      <!-- 筛选框 点击显示未完成未删除/已删除/已完成的任务-->
      <el-radio v-focus v-model="radioSelect" label="1" @click="showAllTask" style="margin-left: 20px">全部任务</el-radio>
      <el-radio v-model="radioSelect" label="2" @click="showFinishedTask">已完成任务</el-radio>
      <el-radio v-model="radioSelect" label="3" @click="showDeletedTask">已删除任务</el-radio>
    </div>

    <!-- 展示未被删除或未完成的任务 -->
    <div v-show="showUnFinishedUnDeleted">
      <!-- 卡片展示区域1 展示未被删除或未完成的任务 -->
      <div style="margin: 30px 10px 10px 10px;width: 1020px;height: 500px;">
        <el-row :gutter="10">
          <el-col :span="8" v-for="item in taskData">
            <el-card shadow="hover" style="width: 300px;margin: 10px;">
              <template #header>
                <div class="card-header">
                  <span>{{ item.tname }}</span>
                  <el-button class="button" type="text" @click="handleFocus(item)">开始专注</el-button>
                </div>
              </template>
              <!-- 展示任务细节 -->
              <div style="text-align: left;">
                <a style="font-weight:normal;width: 60px;line-height: 32px;"> {{ item.ttaskMode }} </a>
                <el-button type="primary" style="float: right" @click="handleEdit(item)">任务详情</el-button>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </div>
      <!-- 分页区域 1 -->
      <div style="margin: 20px;text-align: center;width: 980px;">
        <el-pagination
            v-model:currentPage="currentPage1"
            v-model:page-size="pageSize1"
            :page-sizes="[3, 6, 9]"
            layout="total, prev, pager, next, jumper"
            :total="total1"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            style="position: absolute;left: 50%;transform: translate(-50%)"
        >
        </el-pagination>
      </div>
    </div>

    <!-- 展示完成的任务 -->
    <div v-show="showFinished">
      <!-- 卡片展示区域2 展示完成的任务 -->
      <div style="margin: 30px 10px 10px 10px;width: 1020px;height: 500px;">
        <el-row :gutter="10">
          <el-col :span="8" v-for="item in taskDataFinished">
            <el-card shadow="hover" style="width: 300px;margin: 10px;">
              <template #header>
                <div class="card-header">
                  <span>{{ item.tname }}</span>
<!--                  <el-button class="button" type="text">开始专注</el-button>-->
                </div>
              </template>
              <!-- 展示任务细节 -->
              <div style="text-align: left;">
                <a style="font-weight:normal;width: 60px;line-height: 32px"> {{ item.ttaskMode }} </a>
                <el-button type="primary" style="float: right" @click="handleEdit(item)">任务详情</el-button>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </div>
      <!-- 分页区域 2 -->
      <div style="margin: 20px;text-align: center;width: 1020px">
        <el-pagination
            v-model:currentPage="currentPage2"
            v-model:page-size="pageSize2"
            :page-sizes="[3, 6, 9]"
            layout="total, prev, pager, next, jumper"
            :total="total2"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            style="position: absolute;left: 50%;transform: translate(-50%)"
        >
        </el-pagination>
      </div>
    </div>

    <!-- 展示被删除的任务 -->
    <div v-show="showDeleted">
      <!-- 卡片展示区域3 展示被删除的任务 -->
      <div style="margin: 30px 10px 10px 10px;width: 1020px;height: 500px;">
        <el-row :gutter="10">
          <el-col :span="8" v-for="item in taskDataDeleted">
            <el-card shadow="hover" style="width: 300px;margin: 10px;">
              <template #header>
                <div class="card-header">
                  <span>{{ item.tname }}</span>
<!--                  <el-button class="button" type="text">开始专注</el-button>-->
                </div>
              </template>
              <!-- 展示任务细节 -->
              <div style="text-align: left;">
                <a style="font-weight:normal;width: 60px;line-height: 32px"> {{ item.ttaskMode }} </a>
                <el-button type="primary" style="float: right" @click="handleEdit(item)">任务详情</el-button>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </div>
      <!-- 分页区域 3 -->
      <div style="margin: 20px;text-align: center;width: 1020px">
        <el-pagination
            v-model:currentPage="currentPage3"
            v-model:page-size="pageSize3"
            :page-sizes="[3, 6, 9]"
            layout="total, prev, pager, next, jumper"
            :total="total3"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            style="position: absolute;left: 50%;transform: translate(-50%)"
        >
        </el-pagination>
      </div>
    </div>

    <!-- 弹窗 功能:新增/修改任务 -->
    <el-dialog v-model="isShowAdd" title="任务" width="400px">
      <el-form :model="form" label-width="100px" :rules="addTaskRules">
        <!-- 填写任务名 -->
        <el-form-item label="名称" label-width="60px" prop="tname">
          <el-input v-model="form.tname" style="width: 70%;"></el-input>
        </el-form-item>
        <!-- 填写任务描述 -->
        <el-form-item label="描述" label-width="40px" style="padding-left: 20px">
          <el-input autosize type="textarea" v-model="form.tdescribe" style="width: 70%;"></el-input>
        </el-form-item>
        <!-- 选择任务类型 -->
        <el-form-item label="类型" label-width="40px" style="padding-left: 20px">
            <el-radio v-model="form.ttaskMode" label="正计时" @click="isShowPositive" style="width: 40px;">正计时</el-radio>
            <el-radio v-model="form.ttaskMode" label="定目标" @click="isShowNegative" style="width: 40px">定目标</el-radio>
            <el-radio v-model="form.ttaskMode" label="番茄计时" @click="isShowTomato" style="width: 40px">番茄计时</el-radio>
        </el-form-item>
        <!-- 当点击定目标时显示 -->
        <div v-show="isNegative" style="text-align: left;padding-left: 20px">
          想在<el-date-picker v-model="form.tplanEndDate" type="date" placeholder="日期" style="width: 150px;margin: 0 20px 20px 20px">
          </el-date-picker>之前 <br>
          一共完成 <el-input style="width: 60px;margin: 0 20px 20px 20px" v-model="form.tplanTime"></el-input> 小时
        </div>
        <!-- 当点击番茄计时时显示 -->
        <div v-show="isTomato" style="text-align: left;padding-left: 20px" >
          一次番茄钟:<el-input style="width: 60px;margin: 0 20px 0 20px" v-model="form.ttomatoClock"></el-input>分钟
        </div>
      </el-form>
      <template #footer>
        <span >
          <el-button @click="isShowAdd = false">取消</el-button>
          <el-button type="primary" @click="save">确定</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 弹窗 功能:查看/编辑任务 -->
    <el-dialog v-model="isShowDetail" width="60%">
      <!-- 任务细节展示 -->
      <el-descriptions title="任务详情" border :column="2">
        <el-descriptions-item label="任务名" :span="2"> {{ form.tname }}</el-descriptions-item>
<!--        <el-descriptions-item label="所属用户"> {{ currentUserName }} </el-descriptions-item>-->
        <el-descriptions-item label="计时方法">
          <el-tag >{{ form.ttaskMode }}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="创建时间"> {{form.tcreateDate}} </el-descriptions-item>
        <el-descriptions-item label="专注次数">共 {{ form.tfocusedNum }} 次</el-descriptions-item>
        <el-descriptions-item label="专注时长">共 {{ form.tfocusedTime }} 分钟</el-descriptions-item>
        <el-descriptions-item label="任务描述" :span="2"> {{ form.tdescribe }} </el-descriptions-item>
      </el-descriptions>
      <!-- 功能按键 -->
      <div style="margin-top: 20px">
        <el-button type="primary" @click="showTaskDetail(form)">数据统计</el-button>
        <el-button type="primary" @click="editTask(form)" v-show="isShowSelection">修改任务</el-button>
        <el-popconfirm title="确定删除吗?" @confirm="handleDelete(form.tid)">
          <template #reference>
            <el-button type="danger" v-show="isShowSelection">删除</el-button>
          </template>
        </el-popconfirm>
        <el-popconfirm title="确定完成吗?" @confirm="handleFinish(form.tid)">
          <template #reference>
            <el-button type="success" v-show="isShowSelection">完成</el-button>
          </template>
        </el-popconfirm>
      </div>
      <template #footer>
        <span>
          <el-button @click="isShowDetail = false">关闭</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 弹窗 功能:显示专注页面-->
    <el-dialog
        v-model="isShowFocus"
        :close-on-click-modal="false"
        :close-on-press-escape="false"
        :show-close="false"
        width="60%"
    >
      <div style="text-align: center">
        <!-- 显示名言 -->
        <div>
          <span style="font-size: 40px">"</span>
          <span style="font-size: 25px;font-style:italic;"> {{ currentUserInfo.usaying }} </span>
          <span style="font-size: 40px">"</span>
        </div>
        <!-- 显示任务名 -->
        <div style="margin-top: 10px; font-size: 30px">
          <span style="font-size: 15px">任务名:</span>
          {{ form.tname}}
        </div>
        <el-divider /> <!-- 分割线 -->
        <!-- 显示时间 -->
        <div>
          <!-- 正计时 -->
          <div v-show="isShowAddTime" style="margin-top: 20px;">
            <div v-show="isShowPlanTime">计划在 {{form.tplanEndDate}} 完成 {{form.tplanTime}} 小时</div>
            <div style="font-size: 50px">
              <span style="font-size: 15px">已专注</span>
              {{ addHour }} : {{ addMinute}} : {{ addSecond }}
            </div>
            <el-divider /> <!-- 分割线 -->
            <el-button type="primary" v-show="isShowAddPauseTime" @click="addPauseTime">暂停</el-button>
            <el-button type="primary" v-show="isShowAddContinueTime" @click="addStartTime" style="margin-left: 0px">继续</el-button>
            <el-popconfirm title="确定完成吗?" @confirm="endAddTime">
              <template #reference>
                <el-button type="primary">结束</el-button>
              </template>
            </el-popconfirm>
          </div>
          <!-- 倒计时 -->
          <div v-show="isShowSubTime" style="margin-top: 20px;">
            <div style="font-size: 50px">
              <span style="font-size: 15px">剩余</span>
              {{ subHour }} : {{ subMinute}} : {{ subSecond }}
            </div>
            <el-divider /> <!-- 分割线 -->
            <el-button type="primary" v-show="isShowSubPauseTime" @click="subPauseTime">暂停</el-button>
            <el-button type="primary" v-show="isShowSubContinueTime" @click="subStartTime" style="margin-left: 0px">继续</el-button>
            <el-popconfirm title="确定完成吗?" @confirm="endSubTime">
              <template #reference>
                <el-button type="primary">结束</el-button>
              </template>
            </el-popconfirm>
          </div>
        </div>
      </div>
    </el-dialog>

    <!-- 任务细节 -->
    <el-dialog v-model="isShowTaskDetail" width="50%">
      <el-scrollbar height="430px">
<!--      <div style="height: 430px;overflow-y: auto">-->
        <div style="text-align: center;font-size: 20px;text-align: left">{{ form.tname }}</div>
        <div v-for="item in taskDetail" style="position: relative; margin-top: 20px;">
          <el-descriptions :column="2" border>
            <el-descriptions-item label="时间" :span="2">{{ item.fStartTime }} ~ {{ item.fendTime }}</el-descriptions-item>
            <el-descriptions-item label="日期">{{ item.fDate }}</el-descriptions-item>
            <el-descriptions-item label="持续时间">{{ item.flastedTime }} min</el-descriptions-item>
          </el-descriptions>
        </div>
      </el-scrollbar>
<!--      </div>-->
    </el-dialog>
  </div>
</template>

<script>
import { Search } from "@element-plus/icons";
import { ref } from 'vue'
import request from "@/utils/request";
import router from "@/router";
const input = ref('')

export default {
  name: "Task",
  directives: {
    focus: { // 进入页面后自动点击
      mounted(el) {
        el.click()
      }
    }
  },
  components: {
    Search
  },
  data() {
    return {
      form: { },
      // 以下4个表示未完成未删除 分页相关的数据
      search1: '',
      currentPage1: 1,
      pageSize1: 9,
      total1: 0,
      // 以下4个表示已完成 分页相关的数据
      search2: '',
      currentPage2: 1,
      pageSize2: 9,
      total2: 0,
      // 以下4个表示已删除 分页相关的数据
      search3: '',
      currentPage3: 1,
      pageSize3: 9,
      total3: 0,
      currentUserInfo: [ ], // 读取当前用户信息
      currentUserID: 0, // 当前用户ID
      currentUserName: '', // 当前用户名
      taskData: [ ], // 表示未被uid筛选前未删除未完成的任务
      taskDataFinished: [ ],  // 表示未被uid筛选前已完成的任务
      taskDataDeleted: [ ], // 表示未被uid筛选前已删除的任务
      isShowAdd: false,
      isShowDetail: false,
      isNegative: false,
      isTomato: false,
      radioSelect: ref('1'),
      showUnFinishedUnDeleted: true,
      showFinished: false,
      showDeleted: false,
      isShowSelection: true, // 在已完成和已删除的任务详情中,不显示三个按钮,仅显示数据统计
      isShowAddButton: true, // 是否显示左上角的新增按钮,当用户点击显示已删除和已完成任务时,不显示新增按钮
      isShowFocus: false, // 是否显示专注页面
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
      isShowAddTime: false, // 专注页面是否显示正计时
      isShowSubTime: false, // 专注页面是否显示倒计时
      isShowPlanTime: false, // 专注页面如果是定目标,显示时间计划
      isShowAddPauseTime: true, // 正计时是否出现暂停按钮
      isShowSubPauseTime: true, // 倒计时是否出现暂停按钮
      isShowAddContinueTime: false, // 正计时点击暂停后出现继续按钮
      isShowSubContinueTime: false, // 倒计时点击暂停后出现继续按钮
      focusForm: { }, // 新增专注记录时使用的对象
      // 下面是展示某个任务细节的变量
      isShowTaskDetail: false,
      taskDetail: { },
      addTaskRules: {
        tname: [
          { required: true, message: '请输入任务名', trigger: 'blur' }
        ]
      }
    }
  },
  // computed: {
  //   UnFinishedUnDeletedTask() {
  //     let t1 = this.taskData.filter(item => item.tuserId === this.currentUserID)
  //     return t1
  //   },
  //   FinishedTsak() {
  //     let t2 = this.taskDataFinished.filter(item => item.tuserId === this.currentUserID)
  //     return t2
  //   },
  //   DeletedTask() {
  //     let t3 = this.taskDataDeleted.filter(item => item.tuserId === this.currentUserID)
  //     return t3
  //   }
  // },
  created() {
    this.showAllTask(); // 刚开始显示未被完成或删除的任务
    this.getUserINfo();
  },
  methods: {
    // 从后端获取用户信息
    getUserINfo() {
      // 读取session中的用户信息并将 用户id 赋予currentUserID
      this.currentUserID = JSON.parse(window.sessionStorage.getItem('userinfo')).uid;
      if (this.currentUserID !== 0) {
        request.get("/userinfo",{
          params: {
            userId: this.currentUserID
          }
        }).then(res => {
          this.currentUserInfo = res.data.records[0]
          console.log(this.currentUserInfo)
        })
      }
      this.currentUserName = this.currentUserInfo.uname;
    },
    // 主要是为了当右上角三个按钮中某个按钮被选中时,点击重置按钮,可以正确地重置
    selectLoad() {
      if (this.radioSelect === '1') {
        this.showAllTask();
      }
      if (this.radioSelect === '2') {
        this.showFinishedTask();
      }
      if (this.radioSelect === '3') {
        this.showDeletedTask();
      }
    },
    // 点击显示未删除未完成的任务
    showAllTask() {
      request.get("/taskinfo",{
        params: {
          pageNum: this.currentPage1,
          pageSize: this.pageSize1,
          search: this.search1,
          userId: this.currentUserID
        }
      }).then(res => {
        this.taskData = res.data.records
        this.total1 = res.data.total
        console.log(this.taskData)
      })

      this.showUnFinishedUnDeleted=true;
      this.showDeleted=false;
      this.showFinished=false;
      this.isShowSelection=true;
      this.isShowAddButton = true;
    },
    // 点击显示已完成的任务
    showFinishedTask() {
      request.get("/taskinfofinished",{
        params: {
          pageNum: this.currentPage2,
          pageSize: this.pageSize2,
          search: this.search2,
          userId: this.currentUserID
        }
      }).then(res => {
        this.taskDataFinished = res.data.records
        this.total2 = res.data.total
      })

      this.showUnFinishedUnDeleted=false;
      this.showDeleted=false;
      this.showFinished=true;
      this.isShowSelection=false;
      this.isShowAddButton = false;
    },
    // 点击显示已删除的任务
    showDeletedTask() {
      request.get("/taskinfodeleted",{
        params: {
          pageNum: this.currentPage3,
          pageSize: this.pageSize3,
          search: this.search3,
          userId: this.currentUserID
        }
      }).then(res => {
        this.taskDataDeleted = res.data.records
        this.total3 = res.data.total
      })

      this.showUnFinishedUnDeleted=false;
      this.showDeleted=true;
      this.showFinished=false;
      this.isShowSelection=false;
      this.isShowAddButton = false;
    },
    // 新建或修改任务时的保存
    save() {
      //如果有id,那么更新
      if (this.form.tid) {
        request.put("/taskinfo", this.form).then(res => {
          // console.log(res)
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
          this.showAllTask() //更新后刷新表格数据
          this.isShowAdd = false //关闭弹窗
        })
      }
      //如果没有就新增 引入request对象,this.form作为请求参数
      else {
        this.form.tuserId = this.currentUserID;
        this.form.tisDeleted = 0;
        this.form.tisPigeonholed = 0;
        this.form.tfocusedNum = 0;
        this.form.tfocusedTime = 0;
        if (this.form.ttaskMode === "番茄计时" && !this.form.hasOwnProperty("ttomatoClock")) {
          this.form.ttomatoClock = 30; // 如果没有写就默认30
          console.log('使用默认');
        } else {
          console.log('hhh');
        }
        console.log(this.form)
        request.post("/taskinfo", this.form).then(res => {
          // console.log(res)
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "新增成功"
            })
          }
          else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
          this.showAllTask() //更新后刷新表格数据,
          this.isShowAdd = false //关闭弹窗
        })
      }
    },
    // 改变当前每页个数触发 根据单选框选项修改
    handleSizeChange(pageSize) {
      if (this.radioSelect === '1') {
        this.pageSize1 = pageSize
      }
      if (this.radioSelect === '2') {
        this.pageSize2 = pageSize
      }
      if (this.radioSelect === '3') {
        this.pageSize3 = pageSize
      }
      this.selectLoad()
    },
    // 改变当前页码时触发 根据单选框选项修改
    handleCurrentChange(pageNum) {
      if (this.radioSelect === '1') {
        this.currentPage1 = pageNum
      }
      if (this.radioSelect === '2') {
        this.currentPage2 = pageNum
      }
      if (this.radioSelect === '3') {
        this.currentPage3 = pageNum
      }
      this.selectLoad()
    },
    // 以下三个页面用于任务新增或修改时的属性输入框显示
    // 新增时 点击正计时
    isShowPositive() {
      this.isNegative = false;
      this.isTomato = false;
    },
    // 新增时 点击倒计时
    isShowNegative() {
      this.isNegative = true;
      this.isTomato = false;
    },
    // 新增时 点击番茄计时
    isShowTomato() {
      this.isNegative = false;
      this.isTomato = true;
    },
    // 重置按钮 感觉单选框选项重置
    reset() {
      if (this.radioSelect === '1') {
        this.search1 = '';
      }
      if (this.radioSelect === '2') {
        this.search2 = '';
      }
      if (this.radioSelect === '3') {
        this.search3 = '';
      }
      this.selectLoad();
    },
    // 显示任务详情
    handleEdit(item) {
      this.form = JSON.parse(JSON.stringify(item)) //深拷贝,使得此时form对象与表格里的数据隔离开
      this.isShowDetail = true;
      console.log(this.form);
    },
    // 修改任务 显示任务信息
    editTask(form) {
      this.form = form;
      this.isShowAdd = true
    },
    // 放入已删除的任务列表中 这里的删除不是指删除数据库数据
    handleDelete(tid) {
      this.form.tisDeleted = 1;
      request.put("/taskinfo", this.form).then(res => {
        // console.log(res)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "新增成功"
          })
        }
        else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.selectLoad() //更新后刷新表格数据
        this.isShowDetail = false //关闭弹窗
      })
    },
    // 将任务放入已完成的列表中
    handleFinish(tid) {
      this.form.tisPigeonholed = 1;
      request.put("/taskinfo", this.form).then(res => {
        // console.log(res)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "新增成功"
          })
        }
        else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.selectLoad() // 更新后刷新表格数据
        this.isShowDetail = false //关闭弹窗
      })
    },
    // 点击某个任务开始专注
    handleFocus(item) {
      this.form = JSON.parse(JSON.stringify(item)) //深拷贝,使得此时form对象与表格里的数据隔离开
      this.isShowFocus = true
      // 下面三行初始化
      this.isShowAddTime = false
      this.isShowPlanTime = false
      this.isShowSubTime = false
      console.log("下面是当前专注的任务信息")
      console.log(this.form)
      // 计时方法-正向计时
      if (this.form.ttaskMode === "正计时" || this.form.ttaskMode === "定目标") {
        this.isShowAddTime = true
        if (this.form.ttaskMode === "定目标") {
          this.isShowPlanTime = true
        }
        this.addStartTime()
      }
      // 计时方式-倒计时
      else if (this.form.ttaskMode === "番茄计时") {
        this.isShowSubTime = true
        this.subTransferTime = this.form.ttomatoClock * 60 // 根据任务情况设置倒计时间
        this.subStartTime()
      }
      this.focusForm.fStartTime = this.getCurrentTime() // 获取当前时间
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
      this.focusForm.fuserId = this.currentUserID
      this.focusForm.ftaskId = this.form.tid
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
        this.destroyTime() // 有关专注的变量初始化
        this.isShowFocus = false // 关闭专注页面
      })
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
    // 倒计时-结束计时
    endSubTime() {
      console.log("已专注了 "+this.subSpentTime+" s")
      this.focusForm.fEndTime = this.getCurrentTime()
      this.focusForm.fuserId = this.currentUserID
      this.focusForm.ftaskId = this.form.tid
      this.focusForm.flastedTime = Math.floor(this.subSpentTime / 60)
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
        this.destroyTime() // 有关专注的变量初始化
        this.isShowFocus = false // 关闭专注页面
      })
    },
    // 每次关闭专注时都需要初始化
    destroyTime() {
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
      this.isShowAddPauseTime = true // 正计时是否出现暂停按钮
      this.isShowSubPauseTime = true // 倒计时是否出现暂停按钮
      this.isShowAddContinueTime = false // 正计时点击暂停后出现继续按钮
      this.isShowSubContinueTime = false // 倒计时点击暂停后出现继续按钮
      if (this.addTime) {
        clearInterval(this.addTime)
        this.addTime = null
      }
      if (this.subTime) {
        clearInterval(this.subTime)
        this.subTime = null
      }
    },
    showTaskDetail(form) {
      this.form = form
      this.isShowTaskDetail = true
      this.getTaskDetail()
    },
    getTaskDetail() {
      request.get("/allfocusinfo",{
        params: {
          taskId: this.form.tid,
          userId: this.currentUserID
        }
      }).then(res => {
        this.taskDetail = res.data
        console.log("getTaskDetail函数\n下面显示从后端获取的任务细节")
        console.log(this.taskDetail)
      })
    },
  }
}
</script>

<style scoped>
/*卡片数据展示模块*/
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

</style>