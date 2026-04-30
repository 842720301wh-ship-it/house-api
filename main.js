import App from './App'
import { createSSRApp } from 'vue'
import { createPinia } from 'pinia'
import store from './store' // 如果你还需要兼容 Vuex 的旧模块

export function createApp() {
  const app = createSSRApp(App)

  
  const pinia = createPinia()
  app.use(pinia)

  
  app.use(store)

  
  app.config.globalProperties.$adpid = "1111111111"
  app.config.globalProperties.$backgroundAudioData = {
    playing: false,
    playTime: 0,
    formatedPlayTime: '00:00:00'
  }


  return {
    app,
    pinia
  }
}
