import './index.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import axiosConfig from './lib/api/axiosConfig'

const app = createApp(App)

app.use(router)
app.use(axiosConfig)

app.mount('#app')
