<!--一个整体框架的描述-->
<template>
  <div>
    <!--    头部-->
    <Header />
    <!--    主体-->
<!--    <div style="display: flex">-->
<!--      &lt;!&ndash;      侧边栏&ndash;&gt;-->
<!--&lt;!&ndash;      <Aside />&ndash;&gt;-->
<!--      &lt;!&ndash;      内容区域&ndash;&gt;-->
<!--      <router-view style="flex: 1"/>-->
<!--    </div>-->
    <router-view />
  </div>
</template>

<script>
// 从App.vue拷贝而来
import Header from "@/components/Header";
import Aside from "@/components/Aside";

export default {
  name: "Layout",
  components: {
    Header,
    Aside
  }
}
</script>

<style scoped>

</style>