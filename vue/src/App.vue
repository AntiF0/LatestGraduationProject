<template>
  <div class="extra-all">
    <router-view class="all"/>
  </div>
</template>

<style>
*{
  margin:0;
  padding:0;
  border:0;
  box-sizing: border-box;
  font-weight: bold;
}
.all {
  /* 比例是1.6:1 */
  width: 1020px;
  height: 750px;
  /*border: #888888 2px solid;*/
  /*以下五行将整个项目设为居中*/
  position: absolute;
  top: 0;
  /*bottom: 0;*/
  left: 0;
  right: 0;
  margin: auto;
  box-shadow: 10px 10px 30px #888888; /* 分别表示水平阴影的位置,垂直阴影的位置,模糊距离和阴影的颜色 */
  border-radius: 10px;
  backdrop-filter: blur(10px);
}
html:not(.extra-all) {
  /*background-image: url("https://images.unsplash.com/photo-1440688807730-73e4e2169fb8?dpr=1&auto=format&fit=crop&w=1500&h=1001&q=80&cs=tinysrgb&crop=");*/
}
.extra-all:not(.all) {
  /*background-color: #888888;*/
}
/* 修改wangeditor层级 */
/* 工具栏 */
.w-e-menu {
  z-index: auto !important;
}
.w-e-droplist {
  z-index: 2 !important;
}
.w-e-toolbar {
  z-index: 2 !important;
  flex-wrap: wrap;
}
.w-e-text-container {
  z-index: 1 !important;
}
.el-popper.is-customized {
  /* Set padding to ensure the height is 32px */
  padding: 6px 12px;
  background: linear-gradient(90deg, rgb(159, 229, 151), rgb(204, 229, 129));
}

.el-popper.is-customized .el-popper__arrow::before {
  background: linear-gradient(45deg, #b2e68d, #bce689);
  right: 0;
}
/* 菜单宽度 */
/*.el-menu--collapse .el-menu .el-submenu, .el-menu--popup{*/
/*  min-width: 130px!important;*/
/*}*/
/*!* 修改wangeditor编辑器高度 *!*/
/*.w-e-text-container {*/
/*  height: 100px !important; !*!important是重点，因为原div是行内样式设置的高度300px*!*/
/*}*/
</style>
