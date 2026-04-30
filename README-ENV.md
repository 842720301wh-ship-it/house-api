# 一嘉人项目环境配置说明

## 概述

本项目包含三个主要的环境配置文件，用于管理不同环境下的应用配置：

1. **manifest.json** - uni-app 应用配置文件
2. **package.json** - 项目脚本和环境配置
3. **env.config.js** - 自定义环境配置文件

## 文件说明

### 1. manifest.json

这是 uni-app 的核心配置文件，包含：

- **应用信息**：名称、版本、描述等
- **平台配置**：各平台（H5、微信小程序、App等）的特定配置
- **权限配置**：Android/iOS 权限声明
- **SDK配置**：地图、支付、分享等第三方服务配置

**主要配置项：**
```json
{
  "name": "一嘉人",
  "appid": "__UNI__22B41FD",
  "mp-weixin": {
    "appid": "wxdea358b2ddf62f0b"
  },
  "h5": {
    "sdkConfigs": {
      "maps": {
        "qqmap": {
          "key": "TKUBZ-D24AF-GJ4JY-JDVM2-IBYKK-KEBCU"
        }
      }
    }
  }
}
```

### 2. package.json

包含项目的脚本配置和环境变量定义：

**环境脚本配置：**
```json
{
  "uni-app": {
    "scripts": {
      "mp-dingtalk": {
        "env": {
          "UNI_PLATFORM": "mp-alipay"
        }
      },
      "hello-uniapp-demo": {
        "env": {
          "UNI_PLATFORM": "h5"
        }
      }
    }
  }
}
```

### 3. env.config.js

自定义的环境配置文件，支持多环境管理：

**环境类型：**
- `development` - 开发环境
- `production` - 生产环境  
- `test` - 测试环境

**配置结构：**
```javascript
{
  appInfo: { name, version, description },
  platform: { h5, mp-weixin },
  api: { baseUrl, timeout },
  cloud: { env, spaceId },
  debug: boolean,
  logLevel: string
}
```

## 使用方法

### 1. 引入配置工具

```javascript
import { 
  getConfig, 
  getApiConfig, 
  getPlatformConfig,
  isDevelopment,
  isH5,
  isWeixin 
} from '@/utils/config.js'
```

### 2. 获取配置

```javascript
// 获取API配置
const apiConfig = getApiConfig()
console.log(apiConfig.baseUrl) // http://localhost:3000/api

// 获取平台配置
const h5Config = getPlatformConfig('h5')
const weixinConfig = getPlatformConfig('mp-weixin')

// 获取特定配置项
const appName = getConfig('appInfo.name')
const mapKey = getConfig('platform.h5.sdkConfigs.maps.qqmap.key')
```

### 3. 环境判断

```javascript
// 环境判断
if (isDevelopment()) {
  console.log('当前是开发环境')
}

// 平台判断
if (isH5()) {
  console.log('当前是H5平台')
}

if (isWeixin()) {
  console.log('当前是微信小程序')
}
```

### 4. 在组件中使用

```vue
<template>
  <view>
    <text>API地址: {{ apiConfig.baseUrl }}</text>
    <text>当前环境: {{ currentEnv }}</text>
  </view>
</template>

<script>
import { getApiConfig, isDevelopment } from '@/utils/config.js'

export default {
  data() {
    return {
      apiConfig: getApiConfig(),
      currentEnv: isDevelopment() ? '开发环境' : '生产环境'
    }
  }
}
</script>
```

## 环境变量

### 系统环境变量

- `NODE_ENV` - 当前环境（development/production/test）
- `UNI_PLATFORM` - 当前平台（h5/mp-weixin/app-plus等）

### 自定义环境变量

可以通过以下方式设置：

1. **命令行设置：**
```bash
NODE_ENV=production npm run build
```

2. **HBuilderX 设置：**
在运行配置中设置环境变量

3. **代码中设置：**
```javascript
process.env.NODE_ENV = 'production'
```

## 配置最佳实践

### 1. 敏感信息处理

- 不要将敏感信息（如API密钥）直接写在代码中
- 使用环境变量或配置文件管理敏感信息
- 生产环境的敏感信息应该通过CI/CD流程注入

### 2. 环境隔离

- 开发、测试、生产环境使用不同的配置
- 数据库、API地址等关键配置要严格隔离
- 使用不同的云环境空间ID

### 3. 配置验证

- 在应用启动时验证关键配置
- 提供配置缺失时的友好提示
- 记录配置加载日志

### 4. 动态配置

- 支持运行时配置更新
- 提供配置热重载功能
- 支持远程配置管理

## 示例页面

项目包含了一个配置示例页面：`pages/example/config-example.vue`

该页面展示了：
- 如何获取和使用各种配置
- 环境判断和平台判断
- API调用和云函数调用示例
- 调试信息显示

## 注意事项

1. **配置文件优先级**：env.config.js > package.json > manifest.json
2. **环境变量覆盖**：环境变量可以覆盖配置文件中的值
3. **平台差异**：不同平台的配置可能不同，注意兼容性
4. **版本控制**：敏感配置文件不要提交到版本控制系统

## 扩展配置

如需添加新的配置项，可以：

1. 在 `env.config.js` 中添加新的配置结构
2. 在 `utils/config.js` 中添加对应的获取函数
3. 更新文档和使用示例

这样可以为项目提供灵活、可维护的环境配置管理方案。 