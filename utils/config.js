// 配置工具文件
import config from '../env.config.js'

// 获取配置的工具函数
export const getConfig = (key) => {
  const keys = key.split('.')
  let value = config
  
  for (const k of keys) {
    if (value && typeof value === 'object' && k in value) {
      value = value[k]
    } else {
      return undefined
    }
  }
  
  return value
}

// 获取API配置
export const getApiConfig = () => {
  return getConfig('api')
}

// 获取平台配置
export const getPlatformConfig = (platform) => {
  return getConfig(`platform.${platform}`)
}

// 获取应用信息
export const getAppInfo = () => {
  return getConfig('appInfo')
}

// 获取云开发配置
export const getCloudConfig = () => {
  return getConfig('cloud')
}

// 获取调试配置
export const getDebugConfig = () => {
  return {
    debug: getConfig('debug'),
    logLevel: getConfig('logLevel')
  }
}

// 环境判断工具
export const isDevelopment = () => {
  return process.env.NODE_ENV === 'development'
}

export const isProduction = () => {
  return process.env.NODE_ENV === 'production'
}

export const isTest = () => {
  return process.env.NODE_ENV === 'test'
}

// 平台判断工具
export const isH5 = () => {
  return process.env.UNI_PLATFORM === 'h5'
}

export const isWeixin = () => {
  return process.env.UNI_PLATFORM === 'mp-weixin'
}

export const isApp = () => {
  return process.env.UNI_PLATFORM === 'app-plus'
}

// 导出默认配置
export default config 