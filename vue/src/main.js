import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
// ElementPlus 下面三行
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import zhCn from 'element-plus/es/locale/lang/zh-cn'
import Vue3Autocounter from 'vue3-autocounter';
import Countdown from 'vue3-flip-countdown'

createApp(App).use(store).use(router).use(Countdown).use(ElementPlus, { locale: zhCn}).component('vue3-autocounter', Vue3Autocounter).mount('#app')