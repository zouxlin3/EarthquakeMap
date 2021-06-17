import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import 'element-plus/lib/theme-chalk/index.css'
import locale from 'element-plus/lib/locale/lang/zh-cn'
import 'dayjs/locale/zh-cn'
import App from './App.vue'

const app = createApp(App)
app.use(ElementPlus, { locale })
app.mount('#app')
