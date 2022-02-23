<template>
  <div>
    <router-view />
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
html {
  /* 比例是1.6:1 */
  width: 1200px;
  height: 750px;
  /*border: #888888 2px solid;*/
  /*以下五行将整个项目设为居中*/
  position: absolute;
  top: 0;
  /*bottom: 0;*/
  left: 0;
  right: 0;
  margin: auto;
  box-shadow: 10px 10px 5px #888888; /* 分别表示水平阴影的位置,垂直阴影的位置,模糊距离和阴影的颜色 */
}
</style>
