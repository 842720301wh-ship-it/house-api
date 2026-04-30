import { defineConfig } from 'vite'
import uni from '@dcloudio/vite-plugin-uni'

// 获取环境变量
const env = process.env.NODE_ENV || 'development'
const isDev = env === 'development'
const isTest = env === 'test'

// 代理配置
const proxyConfig = {
  '/api': {
    target: isDev || isTest ? 'http://192.168.52.69/study/public' : 'https://yijiaren.chat/study/public',
    changeOrigin: true,
    rewrite: (path) => path.replace(/^\/api/, '')
  }
}

export default defineConfig({
  plugins: [uni()],
  
  // 服务器配置
  server: {
    port: 3000,
    host: '0.0.0.0',
    proxy: isDev || isTest ? proxyConfig : {}
  },
  
  // 构建配置
  build: {
    outDir: 'dist',
    assetsDir: 'static',
    sourcemap: isDev,
    minify: !isDev,
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['vue', 'vuex'],
          utils: ['@/utils/api.js', '@/utils/config.js']
        }
      }
    }
  },
  
  // 环境变量配置
  define: {
    'process.env.NODE_ENV': JSON.stringify(env),
    'process.env.VITE_APP_API_URL': JSON.stringify('/api'),
    'process.env.VITE_APP_API_URL_PROXY': JSON.stringify(
      isDev || isTest ? 'http://192.168.52.69/study/public' : 'https://yijiaren.chat/study/public'
    )
  },
  
  // CSS配置
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: `@import "@/uni.scss";`
      }
    }
  },
  
  // 解析配置
  resolve: {
    alias: {
      '@': '/src',
      '@/': '/src/'
    }
  },
  
  // 优化配置
  optimizeDeps: {
    include: ['vue', 'vuex', 'uni-app']
  }
}) 