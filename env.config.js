// 环境配置文件
const env = process.env.NODE_ENV || 'development'

// 基础配置
const baseConfig = {
  // 应用信息
  appInfo: {
    name: '一嘉人',
    version: '1.0.0',
    description: '应用描述'
  },
  
  // 平台配置
  platform: {
    h5: {
      template: 'template.h5.html',
      router: {
        mode: 'history',
        base: ''
      },
      sdkConfigs: {
        maps: {
          qqmap: {
            key: 'TKUBZ-D24AF-GJ4JY-JDVM2-IBYKK-KEBCU'
          }
        }
      },
      async: {
        timeout: 20000
      }
    },
    'mp-weixin': {
      appid: 'wxdea358b2ddf62f0b',
      setting: {
        urlCheck: false  // 测试阶段关闭域名校验
      },
      permission: {
        'scope.userLocation': {
          desc: '演示定位能力'
        }
      }
    }
  }
}

// 开发环境配置
const developmentConfig = {
  ...baseConfig,
  api: {
    baseUrl: 'http://localhost:3000/api',
    timeout: 10000,
    // Vite开发环境配置
    vite: {
      apiUrl: '/api',
      proxyUrl: 'http://192.168.188.69/study/public'
    }
  },
  cloud: {
    env: 'development',
    spaceId: 'dev-space-id'
  },
  debug: true,
  logLevel: 'debug'
}

// 生产环境配置
const productionConfig = {
  ...baseConfig,
  api: {
    baseUrl: 'https://yijiaren.chat/study/public',  // 需要备案的域名
    timeout: 15000,
    vite: {
      apiUrl: '/api',
      proxyUrl: ''
    }
  },
  cloud: {
    env: 'production',
    spaceId: 'prod-space-id'
  },
  debug: false,
  logLevel: 'error'
}

// 测试环境配置
const testConfig = {
  ...baseConfig,
  api: {
    // 测试阶段可以使用本地后端或云开发
    baseUrl: 'https://yijiaren.chat/study/public',  // 本地后端（仅H5）
    timeout: 12000,
    // 测试环境Vite配置
    vite: {
      apiUrl: '/api',
      proxyUrl: 'https://yijiaren.chat/study/public'
    }
  },
  cloud: {
    env: 'test',
    spaceId: 'test-space-id'
  },
  debug: true,
  logLevel: 'warn'
}

// 根据环境导出配置
const configs = {
  development: developmentConfig,
  production: productionConfig,
  test: testConfig
}

export default  configs[env] || developmentConfig 