<template>
  <div>
    <!-- 总的数据展示 -->
    <el-card style="position: relative;width: 680px;margin-top: 10px;margin-left: 170px;height: 70px">
      <div style="position: absolute;top: 5px;width: 200px;text-align: center;line-height: 30px;">
        <span style="font-size: 14px">总专注次数</span><br>
        {{ userInfo.ufocusedNum }} 次
      </div>
      <div style="position: absolute;left: 240px;top: 5px;width: 200px;text-align: center;line-height: 30px">
        <span style="font-size: 14px">总专注时长</span><br>
        {{ userInfo.ufocusedTime }} 分钟
      </div>
      <div style="position: absolute;left: 460px;top: 5px;width: 200px;text-align: center;line-height: 30px">
        <span style="font-size: 14px">平均专注时长</span><br>
        {{ Math.floor(userInfo.ufocusedTime / userInfo.ufocusedNum) }} 分钟
      </div>
    </el-card>
    <!-- 图表类型选择区域 -->
    <el-card style="position: relative;margin-top: 10px;width: 800px;margin-left: 110px;height: 50px">
      <!-- 选择年月日 -->
      <div style="position: absolute;left: 50px;top: 5px" >
        <el-radio v-model="timeRangeOfChart" label="1" size="large" @click="clickRadioYear">年</el-radio>
        <el-radio v-model="timeRangeOfChart" label="2" size="large" @click="clickRadioMonth">月</el-radio>
        <el-radio v-model="timeRangeOfChart" label="3" size="large" @click="clickRadioDay">日</el-radio>
      </div>
      <!-- 3个时间选择器 -->
      <div style="position: absolute;left: 290px;top: 10px">
        <!-- 年选择器 -->
        <el-date-picker
            v-if="isShowYearPicker"
            v-model="selectYear"
            type="year"
            placeholder="选择某年"
            value-format="YYYY"
        />
        <!-- 月选择器 -->
        <el-date-picker
            v-if="isShowMonthPicker"
            v-model="selectMonth"
            type="month"
            placeholder="选择某月"
            value-format="MM"
        />
        <!-- 日选择器 -->
        <el-date-picker
            v-if="isShowDayPicker"
            v-model="selectDay"
            type="date"
            placeholder="选择某天"
            value-format="YYYY-MM-DD"
        />
      </div>
      <!-- 选择图表类型 -->
      <div style="position: absolute;left: 570px;top: 10px;">
        <el-button type="primary" @click="drawChartPie">饼图</el-button>
        <el-button type="primary" @click="drawChartColumn">曲线图</el-button>
      </div>
    </el-card>

    <el-card style="position: relative;margin-top: 20px;margin-left: 35px;width: 950px;">
      <div v-show="isShowColumn" id="chartColumn" style="width: 700px;height: 450px;margin-left: 105px"></div>
      <div v-show="isShowPie" id="chartPie" style="width: 700px;height: 450px;margin-left: 105px"></div>
    </el-card>
  </div>
</template>

<script>
import * as echarts from 'echarts'
import { onMounted } from 'vue'
import request from "@/utils/request";

let pie
let column

export default {
  name: "Data-analysis",
  data() {
    return {
      userInfo: [ ],
      timeRangeOfChart: 0, // 1表示年,2表示月,3表示日
      isShowYearPicker: false,
      isShowMonthPicker: false,
      isShowDayPicker: false,
      isShowColumn: false,
      isShowPie: false,
      selectYear: "",
      selectMonth: "",
      selectDay: "",
      focusInfo: { },
      focusColumnYear: [ 0,0,0,0,0,0,0,0,0,0,0,0 ],
      focusColumnMonth: [ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ],
      focusColumnDay: [ 0,0,0,0,0,0,0,0 ],
      focusPieYear: [ ],
      focusPieMonth: [ ],
      focusPieDay: [ ]
    }
  },
  created() {
    this.userInfo = JSON.parse(window.sessionStorage.getItem('userinfo'));
    if (this.userInfo) {
      this.getFocusInfo()
    }
  },
  watch: {
    selectYear() {
      this.initArray()
      // 曲线图-年的数据
      this.focusInfo.forEach((item) => {
        if (this.getStringYear(item.fDate) === parseInt(this.selectYear)) {
          let m = this.getStringMonth(item.fDate)
          this.focusColumnYear[m-1] += item.flastedTime
        }
      })
      // 饼图-年的数据
      let i = 0;
      this.focusInfo.forEach((item) => {
        if (this.getStringYear(item.fDate) === parseInt(this.selectYear)) {
          this.focusPieYear.push({ })
          this.focusPieYear[i]= {value:item.flastedTime, name:item.ftaskName}
          i++;
        }
      })
    },
    selectMonth() {
      this.initArray()
      // 曲线图-月的数据
      this.focusInfo.forEach((item) => {
        if (this.getStringMonth(item.fDate) === parseInt(this.selectMonth)) {
          let d = this.getStringDay(item.fDate)
          this.focusColumnMonth[d-1] += item.flastedTime
        }
      })
      // 饼图-月的数据
      let i = 0;
      this.focusInfo.forEach((item) => {
        if (this.getStringMonth(item.fDate) === parseInt(this.selectMonth)) {
          this.focusPieMonth.push({ })
          this.focusPieMonth[i]= {value:item.flastedTime, name:item.ftaskName}
          i++;
        }
      })
    },
    selectDay() {
      this.initArray()
      // 曲线图-日的数据
      this.focusInfo.forEach((item) => {
        if (item.fDate === this.selectDay) {
          let d = this.getStringHour(item.fStartTime)
          if (d<3) this.focusColumnDay[0] += item.flastedTime
          else if (d>=3 && d<6) this.focusColumnDay[1] += item.flastedTime
          else if (d>=6 && d<9) this.focusColumnDay[2] += item.flastedTime
          else if (d>=9 && d<12) this.focusColumnDay[3] += item.flastedTime
          else if (d>=12 && d<15) this.focusColumnDay[4] += item.flastedTime
          else if (d>=15 && d<18) this.focusColumnDay[5] += item.flastedTime
          else if (d>=18 && d<21) this.focusColumnDay[6] += item.flastedTime
          else if (d>=21 && d<24) this.focusColumnDay[7] += item.flastedTime
        }
      })
      // 饼图-日的数据
      let i = 0;
      this.focusInfo.forEach((item) => {
        if (item.fDate === this.selectDay) {
          this.focusPieDay.push({ })
          this.focusPieDay[i]= {value:item.flastedTime, name:item.ftaskName}
          i++;
        }
      })
    }
  },
  methods: {
    // 初始化保存各个图表数据的数组
    initArray() {
      this.focusColumnYear = [ 0,0,0,0,0,0,0,0,0,0,0,0 ]
      this.focusColumnMonth = [ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ]
      this.focusColumnDay = [ 0,0,0,0,0,0,0,0 ]
      this.focusPieYear = [ ]
      this.focusPieMonth = [ ]
      this.focusPieDay = [ ]
    },
    getFocusInfo() {
      console.log(this.focusInfo)
      request.get("/focusinfo",{
        params: {
          userId: this.userInfo.uid
        }
      }).then(res => {
        this.focusInfo = res.data.records
        console.log(this.focusInfo)
      })
    },
    getStringYear(s) {
      return parseInt(s.substr(0,4))
    },
    getStringMonth(s) {
      return parseInt(s.substr(5,2))
    },
    getStringDay(s) {
      return parseInt(s.substr(8,2))
    },
    getStringHour(s) {
      return parseInt(s.substr(0,2))
    },
    // 下面三个是单选器相关的函数
    clickRadioYear() {
      this.isShowYearPicker = true
      this.isShowMonthPicker =false
      this.isShowDayPicker = false
    },
    clickRadioMonth() {
      this.isShowYearPicker = false
      this.isShowMonthPicker =true
      this.isShowDayPicker = false
    },
    clickRadioDay() {
      this.isShowYearPicker = false
      this.isShowMonthPicker =false
      this.isShowDayPicker = true
    },
    drawChartColumn() {
      this.isShowColumn = true
      this.isShowPie = false
      if (column != null && column !== "" && column !== undefined) {
        column.dispose()
      }
      // 曲线图-年
      if (this.timeRangeOfChart === "1") {
        console.log("画曲线图-年")
        console.log(this.focusColumnYear)
        column = echarts.init(document.getElementById('chartColumn'));
        column.setOption({
          xAxis: {
            type: 'category',
            data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
          },
          yAxis: {
            type: 'value'
          },
          series: [
            {
              data: this.focusColumnYear,
              type: 'line',
              smooth: true
            }
          ]
        })
      }
      // 曲线图-月
      else if (this.timeRangeOfChart === "2") {
        console.log("画曲线图-月")
        column = echarts.init(document.getElementById('chartColumn'));
        column.setOption({
          xAxis: {
            type: 'category',
            data: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
              '11', '12', '13', '14', '15', '16', '17', '18', '19', '20',
              '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31']
          },
          yAxis: {
            type: 'value'
          },
          series: [
            {
              data: this.focusColumnMonth,
              type: 'line',
              smooth: true
            }
          ]
        })
      }
      // 曲线图-日
      else if (this.timeRangeOfChart === "3") {
        console.log("画曲线图-日")
        column = echarts.init(document.getElementById('chartColumn'));
        column.setOption({
          xAxis: {
            type: 'category',
            data: ['0~3', '3~6', '6~9', '9~12', '12~15', '15~18', '18~21', '21~24']
          },
          yAxis: {
            type: 'value'
          },
          series: [
            {
              data: this.focusColumnDay,
              type: 'line',
              smooth: true
            }
          ]
        })
      }
    },
    drawChartPie() {
      this.isShowColumn = false
      this.isShowPie = true
      if (pie != null && pie !== "" && pie !== undefined) {
        pie.dispose()
      }
      // 饼图-年
      if (this.timeRangeOfChart === "1") {
        console.log("画饼图-年")
        console.log(this.focusColumnYear)
        pie = echarts.init(document.getElementById('chartPie'));
        pie.setOption({
          tooltip: {
            trigger: 'item'
          },
          legend: {
            top: '5%',
            left: 'center'
          },
          series: [
            {
              name: 'Access From',
              type: 'pie',
              radius: ['40%', '70%'],
              avoidLabelOverlap: false,
              itemStyle: {
                borderRadius: 10,
                borderColor: '#fff',
                borderWidth: 2
              },
              label: {
                show: false,
                position: 'center'
              },
              emphasis: {
                label: {
                  show: true,
                  fontSize: '20',
                  fontWeight: 'bold'
                }
              },
              labelLine: {
                show: false
              },
              data: this.focusPieYear
            }
          ]
        })
      }
      // 饼图-月
      else if (this.timeRangeOfChart === "2") {
        console.log("画饼图-月")
        pie = echarts.init(document.getElementById('chartPie'));
        pie.setOption({
          tooltip: {
            trigger: 'item'
          },
          legend: {
            top: '5%',
            left: 'center'
          },
          series: [
            {
              name: 'Access From',
              type: 'pie',
              radius: ['40%', '70%'],
              avoidLabelOverlap: false,
              itemStyle: {
                borderRadius: 10,
                borderColor: '#fff',
                borderWidth: 2
              },
              label: {
                show: false,
                position: 'center'
              },
              emphasis: {
                label: {
                  show: true,
                  fontSize: '20',
                  fontWeight: 'bold'
                }
              },
              labelLine: {
                show: false
              },
              data: this.focusPieMonth
            }
          ]
        })
      }
      // 饼图-日
      else if (this.timeRangeOfChart === "3") {
        console.log("画饼图-日")
        pie = echarts.init(document.getElementById('chartPie'));
        pie.setOption({
          tooltip: {
            trigger: 'item'
          },
          legend: {
            top: '5%',
            left: 'center'
          },
          series: [
            {
              name: 'Access From',
              type: 'pie',
              radius: ['40%', '70%'],
              avoidLabelOverlap: false,
              itemStyle: {
                borderRadius: 10,
                borderColor: '#fff',
                borderWidth: 2
              },
              label: {
                show: false,
                position: 'center'
              },
              emphasis: {
                label: {
                  show: true,
                  fontSize: '20',
                  fontWeight: 'bold'
                }
              },
              labelLine: {
                show: false
              },
              data: this.focusPieDay
            }
          ]
        })
      }
    }
  }
}
</script>

<style scoped>
</style>