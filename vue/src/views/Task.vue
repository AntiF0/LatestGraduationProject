<template>
  <div class="w">

    <!--  搜索框-->
    <div class="search">
      <!--单选器-->
      <!--还没添加数据-->
      <div class="search-cascader">
        <el-select size="large" placeholder="选择属性" v-model="value" :popper-append-to-body="false">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.label"
            :value="item.value"

          ></el-option>
        </el-select>
      </div>

      <!--输入框-->
      <el-input size="large" class="search-input" v-model="form.anything">
        <!--搜索icon 3行-->
        <template #prefix>
          <el-icon class="el-input__icon"><search /></el-icon>
        </template>
      </el-input>

      <!--搜索按钮-->
      <el-button class="search-button" type="primary">搜索</el-button>
    </div>

    <!--  用卡片展示数据-->
    <div class="card">
      <!--    gutter表示列之间的距离-->
      <el-row :gutter="20">
        <!--      span="8"表示一共展示3列-->
        <el-col :span="8">
          <el-card class="box-card" shadow="always">
            <template #header>
              <div class="card-header">
                <span>任务名</span>
                <el-button type="primary">开始专注</el-button>
              </div>
            </template>
            <!--      <div v-for="a in 4" :key="a" class="text item">{{ 'List item ' + a }}</div>-->
            <el-button type="text" disabled>添加和任务有关的信息</el-button>
          </el-card>
        </el-col>
      </el-row>
    </div>

    <!--下方的筛选框-->
    <div class="select">
      筛选框
    </div>
  </div>
</template>

<script>
import { Search } from "@element-plus/icons";
import { ref } from 'vue'
const input = ref('')


export default {
  name: "Task",
  data() {
    return {
      form:{},
    }
  },
  components: {
    Search
  }
}
</script>

<style scoped>

/*搜索框模块*/
.search {
  padding: 20px 20px 0 20px;
  text-align: center;
}
.search-cascader {
  width: 150px;
  display: inline-block;
  /*float: left;*/
  margin: 0 20px 0 0;
}
.search-input {
  width: 50%;
  margin: 0 auto;
}
.search-button {
  height: 40px;
  margin: 0 0 0 20px;
}

/*卡片数据展示模块*/
.card {
  /*padding: 10px;*/
  word-wrap: break-word;
}
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.box-card {
  width: 980px;
  margin: 20px;
  font-size: 20px;
}

/*最下方筛选模块*/
.select {
  width: 1020px;
  height: 100px;
  position: absolute;
  bottom: 0;
  background-color: #F2F6FC;
}
</style>