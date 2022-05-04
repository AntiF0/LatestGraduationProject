<template>
  <div class="daily-record">
    <!-- 每天的日记,包含日期选择 -->
    <div class="record">
      <!-- 功能区域 -->
      <div>
        <el-button type="primary" @click="isShowTable=true;load()">文章详情</el-button>
<!--        <span class="demonstration" style="font-size: 15px;margin-left: 20px;">请选择日期:</span>&nbsp;&nbsp;-->
        <el-date-picker
            v-model="form.ddate"
            type="date"
            placeholder="请选择日期"
            :shortcuts="shortcuts"
            format="YYYY/MM/DD"
            value-format="YYYY-MM-DD"
            style="width: 180px;margin-left: 20px"
            @change="confirmDate"></el-date-picker>
<!--        <el-button type="primary" @click="confirmDate" style="margin-left: 20px">确定</el-button>-->
      </div>
      <!-- 记录 -->
      <div style="margin-top: 20px;margin-bottom: 6px;text-align: left" id="div1"></div>
      <!-- 更新或保存按钮 -->
      <el-button type="primary" @click="saveEditor1" style="float: right;margin-top: 20px;width: 90px">更新</el-button>
    </div>

    <!-- 当天的图表展示 -->
    <div class="chart">
      <div class="chart-show" id="main" style="width: 480px; height: 608px"></div>
    </div>

    <!-- 弹窗 显示文章表格 -->
    <el-dialog v-model="isShowTable" width="40%">
      <!-- 功能区域 -->
      <div style="margin-bottom: 20px">
        <!-- 新增 此处如果保留需要重写save函数,删除不影响操作-->
<!--        <el-button type="primary" @click="add">-->
<!--          <el-icon><plus /></el-icon>&nbsp;-->
<!--          新增-->
<!--        </el-button>-->
        <!-- 搜索 -->
        <el-input v-model="search" placeholder="请输入关键字" style="width: 100%;" clearable @input="load">
          <!--搜索icon 3行-->
          <template #prefix>
            <el-icon style="margin-top: 8px"><search /></el-icon>
          </template>
        </el-input>
<!--        <el-button type="primary" style="margin-left: 10px" @click="load">-->
<!--          <el-icon><search /></el-icon>&nbsp;-->
<!--          查询-->
<!--        </el-button>-->
      </div>
      <!-- 表格 -->
      <div>
        <el-table :data="tableData" border stripe class="setting-table">
          <!-- 数据展示 -->
          <el-table-column sortable prop="dDate" label="时间"/>
          <!-- 表格功能 -->
          <el-table-column fixed="right" label="操作" width="200px">
            <template #default="scope">
              <!-- 编辑 -->
              <el-button type="primary" @click="handleEdit(scope.row)">编辑</el-button>
              <!-- 二次确认+删除 -->
              <el-popconfirm title="确定删除吗?" @confirm="handleDelete(scope.row.did)">
                <template #reference>
                  <el-button type="danger">删除</el-button>
                </template>
              </el-popconfirm>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <!-- 分页区域 -->
      <div>
        <el-pagination
            v-model:currentPage="currentPage"
            :page-sizes="[5, 10, 20]"
            :page-size="pageSize"
            layout="total, prev, pager, next, jumper"
            :total="total"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange">
        </el-pagination>
      </div>
      <!-- 右下方关闭按钮 -->
      <template #footer>
        <span>
          <el-button @click="isShowTable = false">关闭</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 弹窗 显示文章细节 -->
    <el-dialog v-model="isShowContent" width="80%" :before-close="handleClose">
      <el-form :model="form" label-width="120px">
        <div id="div2"></div>
      </el-form>
<!--      <template #footer>-->
        <div style="text-align: right;margin-top: 10px">
          <el-button @click="isShowContent = false">取消</el-button>
          <el-button type="primary" @click="saveEditor2">确定</el-button>
        </div>
<!--      </template>-->
    </el-dialog>
  </div>
</template>

<script>
// 下两行用于表格展示
import * as echarts from 'echarts'
import { onMounted } from 'vue'
import { Search, Plus } from '@element-plus/icons'
import request from "@/utils/request";
import E from 'wangeditor';

let editor1 // 主页面里的editor
let editor2 // 点击新增里的editor
// let editor3 // 点击编辑里的editor
let myChart

export default {
  name: "Daily-record",
  components: {
    Search,
    Plus
  },
  data() {
    return {
      form: { },
      textarea: { },
      isShowTable: false,
      tableData: [ ],
      search: '', // 搜索
      currentPage: 1, // 当前页
      pageSize: 5, // 页面大小
      total: 0, // 总共的数据个数
      isShowContent: false, // 点击后展示文章内容
      currentUserInfo: [ ],
      currentUserID: 0,
      currentUserName: '',
      // 时间管理器里的内容
      shortcuts: [
        {
          text: 'Today',
          value: new Date(),
        },
        {
          text: 'Yesterday',
          value: () => {
            const date = new Date()
            date.setTime(date.getTime() - 3600 * 1000 * 24)
            return date
          },
        },
        {
          text: 'A week ago',
          value: () => {
            const date = new Date()
            date.setTime(date.getTime() - 3600 * 1000 * 24 * 7)
            return date
          },
        },
      ],
      selectDate: '', // 日期选择框当前选中的日期
      selectData: '', // 点击日期选择框旁的'确定'后出现的数据,应该只有一个
      // 保存表格里的数据
      chartData: [ ],
      processedChartData: [ ]
    }
  },
  created() {
    // 读取session中的用户信息并将 用户id 赋予currentUserID
    this.currentUserInfo = JSON.parse(window.sessionStorage.getItem('userinfo'));
    this.currentUserID = this.currentUserInfo.uid;
    this.currentUserName = this.currentUserInfo.uname;
    // console.log('当前的用户id是'+this.currentUserID)

    // 对未来元素有一个缓冲的时机
    this.$nextTick(() => {
      // 关联弹窗里的div,new一个editor对象
      editor1 = new E('#div1')
      editor1.config.height = 380
      editor1.create()
    })

    this.load() // 先读数据再运行
  },
  // 当所有元素加载完之后,才会执行mounted代码
  watch: {
    // 使得processedChartData可以根据chartData改变而改变
    chartData() {
      this.getProcessedChartData(this.chartData)
      this.drawCharts()
    }
  },
  // 原来的图表展示
  setup() {

  },
  methods: {
    // 可以把time型的字符串转化为数字分钟,如"01:00:10"->60
    convertStringToMin() {
      let certainTime = "03:10:50"
      let certainMin =parseInt(certainTime.substr(0, 2))*60 + parseInt(certainTime.substr(3, 2))
      console.log(certainMin)
    },
    // 这个load是点击文章详情后才运行的
    load() {
      request.get("/dailyrecord",{
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search,
          userId: this.currentUserID
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
        console.log(this.tableData)
      })
    },
    // 保存在editor1里的文章
    saveEditor1() {
      if (editor1) {
        this.form.dcontent = editor1.txt.html()
        console.log("使用了editor1的数据")
      }
      //如果有id,那么更新
      if (this.form.did) {
        console.log("saveEditor1-此时有did,更新")
        console.log("saveEditor1-当前form数组里有:")
        console.log(this.form)
        request.put("/dailyrecord", this.form).then(res => {
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
          this.load() //更新后刷新表格数据
          this.form = {}
          this.isShowContent = false //关闭弹窗
        })
      }
      //如果没有,那么新增
      else {
        console.log("saveEditor1-此时没有did,新增")
        this.form.duserId = this.currentUserID
        this.form.ddate = this.selectDate
        //引入request对象,this.form作为请求参数
        request.post("/dailyrecord", this.form).then(res => {
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
          this.load() //更新后刷新表格数据
          this.form = {}
          this.isShowContent = false //关闭弹窗
        })
      }
    },
    // 保存在editor2里的文章
    saveEditor2() {
      if (editor2) {
        this.form.dcontent = editor2.txt.html() // 获取编辑器里的值,然后赋予到实体
        console.log("使用了editor2的数据")
      }
      //如果有id,那么更新
      if (this.form.did) {
        console.log("saveEditor2-此时有did,更新")
        console.log("saveEditor2-当前form数组里有:")
        console.log(this.form)
        request.put("/dailyrecord", this.form).then(res => {
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
          this.load() //更新后刷新表格数据
          this.form = {}
          this.isShowContent = false //关闭弹窗
        })
      }
      //如果没有,那么新增
      else {
        console.log("saveEditor2-此时没有did,新增")
        this.form.duserId = this.currentUserID
        this.form.ddate = this.selectDate
        //引入request对象,this.form作为请求参数
        request.post("/dailyrecord", this.form).then(res => {
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
          this.load() //更新后刷新表格数据
          this.form = {}
          this.isShowContent = false //关闭弹窗
        })
      }
    },
    // 添加文章
    add() {
      this.isShowContent = true;
      this.form = {}; // 清空表单

      // 对未来元素有一个缓冲的时机
      this.$nextTick(() => {
        // 关联弹窗里的div,new一个editor对象
        editor2 = new E('#div2')
        editor2.create()
      })
      // editor2.txt.html('') // 点击新增后,editor2内的内容清空
    },
    // 编辑某天的文章
    handleEdit(row) {
      console.log(this.form)
      this.form = JSON.parse(JSON.stringify(row)) //深拷贝,使得此时form对象与表格里的数据隔离开
      this.isShowContent = true

      // 对未来元素有一个缓冲的时机
      this.$nextTick(() => {
        // if (!editor2) {
          // 关联弹窗里的div,new一个editor对象
          editor2 = new E('#div2')
          editor2.create()
          editor2.txt.html(row.dcontent) // 将后端传来的数据放入editor2中
        // }
      })

      console.log(this.form.duserId)
    },
    // 删除某天的文章
    handleDelete(did) {
      // console.log(uid)
      request.delete("/dailyrecord/" + did).then(res => {
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "删除成功"
          })
        }
        else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.load() //删除后刷新表格数据
      })
    },
    // 主要是为了不管是新增还是编辑,关闭弹窗后editor2也销毁
    handleClose() {
      editor2.destroy();
      console.log("editor2已删除")
      this.isShowContent = false //关闭弹窗
    },
    handleSizeChange(pageSize) {
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) {
      this.currentPage = pageNum
      this.load()
    },
    // 选择日期后更新editor1->获取对应的专注记录->转化为适合图表的数组
    confirmDate() {
      // 1. 选择日期后更新editor1
      // 恢复初始现场
      this.form.did = undefined
      editor1.txt.html('')
      this.selectDate = this.form.ddate
      // console.log("选择的日期是: "+this.selectDate) // 返回当前日期选择器的值,格式为YYYY-MM-DD
      request.get("/dailyrecord",{
        params: {
          // pageNum: this.currentPage,
          // pageSize: this.pageSize,
          // search: this.search,
          userId: this.currentUserID,
          date: this.selectDate
        }
      }).then(res => {
        this.selectData = res.data.records
        if (res.data.records[0].dcontent) {
          editor1.txt.html(res.data.records[0].dcontent) // 将后端传来的数据放入editor1中
        } else {
          this.$message({
            type: "success",
            message: "需要填写记录"
          })
        }
        this.form.did = res.data.records[0].did
      }). catch(error => {
        console.log("出错了,没有数据!")
      })

      // 2. 获取对应的专注记录
      this.getFocusData() // 点击确定后得到所属当前日期和用户的专注记录

      // 3. 转化为适合图表的数组
      // this.getProcessedChartData(this.chartData)

      // 4. 画图
      // this.drawCharts()
    },
    // 从后台得到选定日期的专注信息
    getFocusData() {
      if (this.selectDate) {
        console.log("getFocusData函数\n当前时间是:"+this.selectDate)
        request.get("/allfocusinfo",{
          params: {
            date: this.selectDate,
            userId: this.currentUserID
          }
        }).then(res => {
          this.chartData = res.data
          console.log("getFocusData函数\n下面显示从后端获取的chartData")
          console.log(this.chartData)
        })
      } else {
        console.log("还没有选择日期")
      }
    },
    // 将从后端得到的数据对象转化为适合图表展示的对象
    getProcessedChartData(s) {
      this.processedChartData = [ ]
      let i = 0;
      this.chartData.forEach((item) => {
        this.processedChartData.push({ })
        this.processedChartData[i]= {value:item.flastedTime, name:item.ftaskName}
        i++;
      })
      console.log("getProcessedChartData函数\n下面显示转换后的processedChartData")
      console.log(this.processedChartData)
    },
    // 画图表
    drawCharts() {
      console.log("下面开始画图")
      if (myChart != null && myChart != "" && myChart != undefined) {
        myChart.dispose()
      }
      myChart = echarts.init(document.getElementById('main'));
      // 创建图标
      myChart.setOption({
        title: {
          text: '专注记录',
          // subtext: '测试',
          left: 'center',
          padding: 40,
          textStyle: {
            fontSize: 30
          }
        },
        tooltip: {
          trigger: 'item'
        },
        legend: {
          orient: 'vertical',
          top: 'bottom'
        },
        toolbox: {
          show: true,
          feature: {
            mark: { show: true },
            dataView: { show: true, readOnly: false },
            restore: { show: true },
            saveAsImage: { show: true }
          }
        },
        series: [{
          name: '任务时长(分钟)',
          type: 'pie',
          radius: '50%',
          data: this.processedChartData,
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          }
        }]
      })
    },
  },
  computed: {
  }
}

</script>

<style scoped>
/*总页面*/
.daily-record {
  position: relative;
  width: 1020px;
  height: 670px;
  background-color: rgb(246, 247, 246);
}
/*左侧记录框*/
.record {
  float: left;
  height: 630px;
  width: 480px;
  margin: 20px 10px 20px 20px;
  text-align: center;
  /*background-color: cadetblue;*/
}
/*左侧记录框*/
.record-content {
  margin-top: 20px;
  box-shadow: 5px 5px 2px rgb(234,235,235);
}
/*右侧图表展示框*/
.chart {
  float: left;
  height: 630px;
  width: 480px;
  margin: 20px 20px 20px 10px;
  /*background-color: gainsboro;*/
}
/*右侧图表显示框*/
.chart-show {
  margin-top: 4px;
  background-color: white;
  box-shadow: 5px 5px 2px rgb(234,235,235);
}
</style>