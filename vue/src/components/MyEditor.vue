<template>
  <div style="border: 1px solid #ccc">
    <!-- 工具栏 -->
    <Toolbar
        :editorId="editorId"
        style="border-bottom: 1px solid #ccc"
    />
    <!-- 编辑器 -->
    <Editor
        :editorId="editorId"
        :defaultConfig="editorConfig"
        @onChange="handleChange"
        style="height: 500px; overflow-y: hidden;"
    />
  </div>
</template>

<script>
import { onBeforeUnmount } from 'vue'
import { Editor, Toolbar, getEditor, removeEditor } from '@wangeditor/editor-for-vue'

// 定义一个编辑器 id ，要求：全局唯一且不变！！！
const editorId = 'wangeEditor-1'

// 编辑器配置
const editorConfig = {
  placeholder: '请输入内容...',
  MENU_CONF: { /* 菜单配置，下文解释 */ }
}

// 回调函数
const handleChange = (editor) => {
  console.log('change:', JSON.stringify(editor.children))
}

// 组件销毁时，及时销毁编辑器
onBeforeUnmount(() => {
  const editor = getEditor(editorId)
  if (editor == null) return

  // 销毁，并移除 editor
  editor.destroy()
  removeEditor(editorId)
})
export default {
  name: "MyEditor"
}
</script>

<style src="@wangeditor/editor/dist/css/style.css" scoped>

</style>