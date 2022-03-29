<template>
  <div class="setting">

    <div style="margin: 15px auto 15px auto;">
      <!-- 新增按钮 -->
      <el-button type="primary" @click="add">
        <el-icon><plus /></el-icon>&nbsp;
        新增
      </el-button>
      <!-- 搜索区域 -->
      <el-input v-model="search" placeholder="请输入关键字" style="width: 20%;margin-left: 10px" clearable/>
      <el-button type="primary" style="margin-left: 10px" @click="load">
        <el-icon><search /></el-icon>&nbsp;
        查询
      </el-button>
      <!-- 重置按钮 -->
      <el-button type="primary" @click="reset">重置</el-button>
    </div>

    <!-- 数据展示区域 -->
    <div>
      <el-table :data="tableData" border stripe class="setting-table">
        <!-- 数据展示 -->
        <el-table-column prop="uid" label="Id" sortable/>
        <el-table-column prop="uname" label="用户名" />
        <el-table-column prop="upassword" label="密码" />
        <el-table-column prop="usaying" label="名言" />
        <el-table-column prop="usuper" label="管理员" />
        <!-- 表格功能 -->
        <el-table-column fixed="right" label="操作" width="200px">
          <template #default="scope">
            <!-- 编辑 -->
            <el-button type="primary" @click="handleEdit(scope.row)">编辑</el-button>
            <!-- 二次确认+删除 -->
            <el-popconfirm title="确定删除吗?" @confirm="handleDelete(scope.row.uid)">
              <template #reference>
                <el-button type="danger">删除</el-button>
              </template>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 分页区域 -->
    <div style="margin: 15px 0">
      <el-pagination
          v-model:currentPage="currentPage"
          :page-sizes="[5, 10, 20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange">
      </el-pagination>
    </div>

    <!-- 弹窗区域 -->
    <el-dialog v-model="dialogVisible" title="提示" width="30%">
      <el-form :model="form" label-width="120px">
        <el-form-item label="用户名">
          <el-input v-model="form.uname" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="form.upassword" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="名言">
          <el-input
              autosize
              type="textarea"
              v-model="form.usaying"
              style="width: 80%"
          >
          </el-input>
        </el-form-item>
        <el-form-item label="管理员">
          <el-input v-model="form.usuper" style="width: 80%"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="save">确定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import request from "@/utils/request";
import { Plus,Search } from '@element-plus/icons'
export default {
  name: "User",
  components: {
    Plus,
    Search
  },
  data() {
    return {
      form: {},
      dialogVisible: false,
      search: '',
      currentPage: 1,
      pageSize: 10,
      total: 0, // 从后台获取
      tableData: [

      ]
    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      request.get("/userinfo",{
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
        console.log(this.tableData)
      })
    },
    add() {
      this.dialogVisible = true; // 显示表单
      this.form = {}; // 清空表单
    },
    save() {
      //如果有id,那么更新
      if (this.form.uid) {
        request.put("/userinfo", this.form).then(res => {
          console.log(res)
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
          this.dialogVisible = false //关闭弹窗
        })
      }
      //如果没有,那么新增
      else {
        //引入request对象,this.form作为请求参数
        request.post("/userinfo", this.form).then(res => {
          console.log(res)
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
          this.dialogVisible = false //关闭弹窗
        })
      }
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row)) //深拷贝,使得此时form对象与表格里的数据隔离开
      this.dialogVisible = true
    },
    handleDelete(uid) {
      // console.log(uid)
      request.delete("/userinfo/" + uid).then(res => {
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
    handleSizeChange(pageSize) { //改变当前每页个数触发
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) { //改变当前页码触发
      this.currentPage = pageNum
      this.load()
    },
    reset() {
      this.search = '';
      this.load();
    }
  }
}
</script>

<style scoped>
.setting {
  width: 1020px;
  height: 670px;
}
.setting-table {
  width: 900px;
}
</style>