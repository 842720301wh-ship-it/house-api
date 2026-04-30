<template>
  <view class="custom-navbar" :style="{ paddingTop: statusBarHeight + 'px' }">
    <view class="nav-bar-content" :style="{ height: navContentHeight + 'px' }">
      <!-- 左侧返回按钮 -->
      <view class="nav-left" @click="selectpages" v-if="props.search">
        <tui-icon name="search-2" :size="40" unit="rpx"></tui-icon>
      </view>
	  <view class="nav-left" @click="goBack" v-if="back" style="display: flex;align-items: center;">
	    <tui-icon name="arrowleft" :size="40" unit="rpx"></tui-icon>
		<view style="font-size: 40rpx;">{{ props.backtext }}</view>
	  </view>
	  <view class="nav-left" @click="setcity" v-if="gps">
	    <tui-icon name="gps" color="#009c9c" :size="40" unit="rpx"></tui-icon>
		{{ props.gpscity }}
	  </view>

      <!-- 中间标题 -->
	  <view class="nav-title" v-if="select" >
	     <view style="display: flex;align-items: center;background-color: #dfdfdf;width: 200rpx;font-size: 32rpx;
		 justify-content: space-around;padding: 6rpx;border-radius: 10rpx;" :style="{ marginLeft: props.gpscity ? '45%' : '65%' }">
			 <view @click="selectType('租房')" :class="{ select: type === '租房'}" style="flex: 1;">
				 租房
			 </view>
			 <view @click="selectType('买房')" :class="{ select: type === '买房' }" style="flex: 1;">
				 买房
			 </view>
		 </view>
	  </view>
	  <view class="nav-title" v-if="props.title" :style="{ textAlign: props.gpscity ? 'left' : '',marginLeft: props.gpscity? '180rpx' : '' }">
	    {{ props.title }}
	  </view>
	  <view class="nav-title" v-else>
	    
	  </view>

      <!-- 右侧胶囊预留空间（如果需要右侧图标可以放这里） -->
      <view class="nav-right">
        <!-- 右侧内容（可选） -->
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import tuiIcon from "thorui-uni/lib/thorui/tui-icon/tui-icon.vue"
import { safeNavigateBack } from '@/utils/navigation.js'
import { useScreenStore } from '@/store/counter.js'

const emit = defineEmits(['height-change'])
const props = defineProps({
    title: {
      type: String,
      default: ''
    },
    search: {
      type: Boolean,
      default: false
    },
	back: {
	  type: Boolean,
	  default: false
	},
	backtext: {
	  type: String,
	  default: ''
	},
	gps: {
	  type: Boolean,
	  default: false
	},
    gpscity: {
      type: String,
      default: ''
    },
	page: {
	  type: String,
	  default: ''
	},
	tab: {
	  type: Boolean,
	  default: false
	},
	select:{
	  type: Boolean,
	  default: false	
	}
})
//类型选择
const Screenstore = useScreenStore()
const type = ref('租房')
function selectType(item){
	type.value = item
	Screenstore.setType(type.value)
}

//自定义导航栏高度
const statusBarHeight = ref(0)
const navContentHeight = ref(44) // 默认

function goBack() {
  if (props.page) {
    if (props.tab) {
      uni.switchTab({
        url: props.page
      })
    } else {
      uni.navigateTo({
        url: props.page
      })
    }
  } else {
    safeNavigateBack()
  }
}

//选择城市
function setcity(){
	uni.navigateTo({
	  url: '/pages/public/setCIty'
	})
}

onMounted(() => {
  const sysInfo = uni.getSystemInfoSync()
  statusBarHeight.value = sysInfo.statusBarHeight

  const rect = uni.getMenuButtonBoundingClientRect()
  const extraPadding = 15 // 控制胶囊按钮底部与导航栏底部的距离
  navContentHeight.value = rect.bottom - sysInfo.statusBarHeight + extraPadding
  
  emit('height-change', statusBarHeight.value + navContentHeight.value)
})

//搜索界面
const selectpages = () => {
  uni.navigateTo({
    url: '/pages/select/select'
  })
}
</script>

<style scoped>
.custom-navbar {
  width: 100%;
  background-color: #ffffff;
  box-shadow: 0 2rpx 6rpx rgba(0, 0, 0, 0.1);
  border-bottom: 1rpx solid #e1e1e1;
  position: sticky;
  z-index: 100000;
  top: 0;
}

.nav-bar-content {
  display: flex;
  align-items: center;
  justify-content: space-around;
  padding: 0 30rpx;
  box-sizing: border-box;
}

/* 左边返回图标 */
.nav-left .back-icon {
  width: 40rpx;
  height: 40rpx;
}

/* 中间标题 */
.nav-title {
  flex: 1;
  text-align: center;
  font-size: 34rpx;
  font-weight: bold;
  color: #333;
}

/* 右边预留区 */
.nav-right {
  width: 40rpx;
  height: 40rpx;
}
.select{
	background-color: #009c9c;
	padding: 5rpx;
	border-radius: 10rpx;
	transition: all 1s ease;
	color: #ffffff;
}
</style>
