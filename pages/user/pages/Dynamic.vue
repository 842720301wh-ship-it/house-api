<template>
	<nartab
	title="我的动态"
	:back = "true"
	/>
	<scroll-view style="height: 100vh;"
	 lower-threshold="50" scroll-y direction="vertical" @scrolltolower="onScrollToLower" >
		<messageList
		ref="message"
		/>
	</scroll-view>
	<view>
	  <view @click="refresh()" style="position: fixed;bottom: 200rpx;left: 90%;transform: translateX(-50%);width: 100rpx;height: 100rpx;
		background-color: #009c9c;color: #fff;display: flex;align-items: center;justify-content: center;z-index: 10;font-size: 32rpx;
		border-radius: 50%;">
			<tui-icon name="refresh" :size="50" unit="rpx" color="#fff"></tui-icon>
	  </view>
	</view>
</template>

<script setup>
	import { ref, onMounted, watchEffect, watch, computed } from 'vue'
	import nartab from '@/components/nartab.vue'
	import messageList from '@/pages/dynamic/components/messageList.vue'
	import { onPageShow,onPullDownRefresh,onShow } from '@dcloudio/uni-app'
	
	const city = ref('')
	const openid = ref('')
	//获取动态信息
	const message = ref(null)
	function onScrollToLower() {
		message.value.loadMore(city.value,openid.value)
	}
	//下拉刷新
	onPullDownRefresh(() => {
	  message.value.resetAndFetch(city.value,openid.value)
	})
	function refresh(){
		message.value.resetAndFetch(city.value,openid.value)
	}
	onPageShow(() => {
	  city.value = uni.getStorageSync('city') || ''
	  const account = uni.getStorageSync('user')
	  openid.value = account?.openid || ''
	  if (message.value?.fetchMessageList) {
	    message.value.fetchMessageList(city.value, openid.value)
	  }
	})
	
	onMounted(() => {
	  setTimeout(async () => {
		const pages = getCurrentPages()
		const currentPage = pages[pages.length - 1] 
		message.value.fetchMessageList(city.value,openid.value)
		  currentPage.onShareAppMessage = () => {
		    return {
		      title: '首页分享标题',
			  path: '/' + currentPage.route
		    }
		  }
		  currentPage.onShareTimeline  = () => {
		  	return {
		  	  title: '首页分享标题',
		  	}
		  }
	  }, 500)
	})
</script>

<style>
	       
</style>
