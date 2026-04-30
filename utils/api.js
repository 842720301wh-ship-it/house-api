// API服务工具文件
import { getApiConfig, isDevelopment, isTest } from './config.js'

// 获取API配置
const apiConfig = getApiConfig()

// 构建完整的API URL
const buildApiUrl = (endpoint) => {
  const baseUrl = apiConfig.baseUrl
  const viteConfig = apiConfig.vite || {}
  
  // 微信开发者工具测试环境
  if (process.env.UNI_PLATFORM === 'mp-weixin' && (isDevelopment() || isTest())) {
    // 微信开发者工具中直接使用本地地址
    return `http://192.168.93.112/house-api/public${endpoint}`
  }
  
  // 如果是开发环境或测试环境，使用Vite代理
  if ((isDevelopment() || isTest()) && viteConfig.apiUrl) {
    return `${viteConfig.apiUrl}${endpoint}`
  }
  
  // 生产环境使用完整URL
  return `${baseUrl}${endpoint}`
}

// 请求拦截器
const requestInterceptor = (config) => {
  // 添加请求头
  config.header = {
    'Content-Type': 'application/json',
    ...config.header
  }
  
  // 添加token和openid
  const token = uni.getStorageSync('token')
  const account = uni.getStorageSync('user')
  
  if (token) {
    config.header.token = token
  }
  if (account) {
    config.header.openid = account.openid || ''
  }
  
  // 添加时间戳防止缓存
  if (config.method === 'GET') {
    config.url += (config.url.includes('?') ? '&' : '?') + `_t=${Date.now()}`
  }
  
  return config
}

// 响应拦截器
const responseInterceptor = (response) => {
  const { statusCode, data } = response
  
  // 请求成功
  if (statusCode >= 200 && statusCode < 300) {
    return data
  }
  
  // 处理错误状态码
  switch (statusCode) {
    case 401:
      // 未授权，跳转到登录页
      uni.showToast({
        title: '请先登录',
        icon: 'none'
      })
      // 清除token
      uni.removeStorageSync('token')
      // 跳转到登录页
      uni.navigateTo({
        url: '/pages/login/login'
      })
      break
    case 403:
      uni.showToast({
        title: '没有权限访问',
        icon: 'none'
      })
      break
    case 404:
      uni.showToast({
        title: '接口不存在',
        icon: 'none'
      })
      break
    case 500:
      uni.showToast({
        title: '服务器错误',
        icon: 'none'
      })
      break
    default:
      uni.showToast({
        title: `请求失败: ${statusCode}`,
        icon: 'none'
      })
  }
  
  return Promise.reject(response)
}

// 通用请求方法
const request = (options) => {
  return new Promise((resolve, reject) => {
    // 应用请求拦截器
    const config = requestInterceptor(options)
    
    uni.request({
      ...config,
      success: (response) => {
        try {
          const result = responseInterceptor(response)
          resolve(result)
        } catch (error) {
          reject(error)
        }
      },
      fail: (error) => {
        uni.showToast({
          title: '网络请求失败',
          icon: 'none'
        })
        reject(error)
      }
    })
  })
}
//文件上传方法
const filerequest = (options) => {
  return new Promise((resolve, reject) => {
    // 应用请求拦截器
    const config = requestInterceptor(options)
    
    uni.uploadFile({
	...config,
      success: (response) => {
        try {
          const result = responseInterceptor(response)
          resolve(result)
        } catch (error) {
          reject(error)
        }
      },
      fail: (error) => {
        uni.showToast({
          title: '网络请求失败',
          icon: 'none'
        })
        reject(error)
      }
    })
  })
}

// API方法封装
export const api = {
  // GET请求
  get: (url, params = {}, config = {}) => {
    const queryString = Object.keys(params)
      .map(key => `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`)
      .join('&')
    
    const fullUrl = queryString ? `${buildApiUrl(url)}?${queryString}` : buildApiUrl(url)
    
    return request({
      url: fullUrl,
      method: 'GET',
      ...config
    })
  },
  
  // POST请求
  post: (url, data = {}, config = {}) => {
    return request({
      url: buildApiUrl(url),
      method: 'POST',
      data,
      ...config
    })
  },
  
  // PUT请求
  put: (url, data = {}, config = {}) => {
    return request({
      url: buildApiUrl(url),
      method: 'PUT',
      data,
      ...config
    })
  },
  
  // DELETE请求
  delete: (url, config = {}) => {
    return request({
      url: buildApiUrl(url),
      method: 'DELETE',
      ...config
    })
  },
  
  // 文件上传
upload: (url, filePath, config = {}) => {
	return filerequest({
	  url: buildApiUrl(url),
	  method: 'POST',
	  filePath,
	  name: 'file',
	  ...config
	})
  },
}

export const userApi = {
  // 用户登录
  login: (data) => api.post('/Account/wxLogin', data),
  // 登录信息校验
  checkToken: (data) => api.post('/Account/checkToken',data),
  // 退出登录
  loginout: (data) => api.post('/Account/logout', data),
  // 账号信息修改
  update: (data) => api.post('/Account/update', data),
}

export const baiduApi = {
  // 行政区域
  getRegion: (data) => api.post('/Baidu/getRegion', data),
  
  // 地点检索
  region: (data) => api.post('/Baidu/region', data),
  
}

export const homeApi = {
  // 获取房源信息
  get: (data) => api.post('/PropertyListing/getHome', data),
  // 房源访客记录
  visitor: (data) => api.post('/PropertyListing/visitor', data),
  // 房源访客记录
  getvisitor: (data) => api.post('/PropertyListing/getVisitor', data),
  // 房源收藏记录
  favorites: (data) => api.post('/PropertyListing/favorites', data),
  // 获取房源收藏
  getfavorites: (data) => api.post('/PropertyListing/getFavorites', data),
}

export const dynamicApi = {
  // 发布动态
  add: (data) => api.post('/Dynamic/add', data),
  // 修改动态
  update: (data) => api.post('/Dynamic/update', data),
  // 动态获取
  get: (data) => api.post('/Dynamic/get', data),
  // 删除动态
  delete: (data) => api.post('/Dynamic/delete', data),
}

export const propertyListingApi = {
  // 房源信息提交
  add: (data) => api.post('/PropertyListing/add', data),
  // 房源信息提交
  update: (data) => api.post('/PropertyListing/update', data),
  // 获取订单
  getorder: (data) => api.post('/PropertyListing/getorder', data),
  // 获取房源信息
  get: (data) => api.post('/PropertyListing/get', data),
  //延期
  postpone: (data) => api.post('/PropertyListing/Postpone', data),
  //删除订单
  delete: (data) => api.post('/PropertyListing/deletePost', data),
}

export const payApi = {
  // 码支付
  xpay: (data) => api.post('/Pay/xPay', data),
  // 码支付验证
  checkxpay: (data) => api.post('/Pay/check', data),
}

export const messageApi = {
  // 公告信息提交
  addMessage: (data) => api.post('/group/Message/addMessage', data),     
  
  //公告信息获取
  getMessage: (data) => api.post('/group/Message/getMessage', data),    
}

export const fileApi = {
  // 上传头像文件
  uploadAccount: (filePath) => api.upload('/Account/image', filePath),
  
  //上传房源图片
  housePicture: (filePath) => api.upload('/PropertyListing/image', filePath),
  
  //上传房源视频
  houseVideo: (filePath) => api.upload('/PropertyListing/video', filePath),
  
  //上传动态图片
  dynamicPicture: (filePath) => api.upload('/Dynamic/image', filePath),
  
  //上传动态视频
  dynamicVideo: (filePath) => api.upload('/Dynamic/video', filePath),
  
  // 删除文件
  delete: (id) => api.delete(`/file/delete/${id}`)
}

export default api 