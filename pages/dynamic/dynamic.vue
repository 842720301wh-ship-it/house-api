<template>
	<nartab
	:gps = "true"
	:gpscity="city"
	title="动态"
	/>
	<view style="display: flex;align-items: center;justify-content: space-around;padding: 40rpx 30rpx;
	position: sticky;background-color: #fff;">
		<view style="display: flex;" @click="Tosearch()">
			<tui-icon name="category" :size="35" unit="rpx" style="margin-right: 10rpx;"></tui-icon>搜索
		</view>
		<view style="display: flex;color: #009c9c;"  @click="Toadd()">
			<tui-icon name="plus" :size="35" unit="rpx" color="#009c9c" style="margin-right: 10rpx;"></tui-icon>发布动态
		</view>
	</view>
	<scroll-view style="height: 100vh;"
	 lower-threshold="50" scroll-y direction="vertical" @scrolltolower="onScrollToLower" >
		<messageList
		ref="message"
		/>
	</scroll-view>
</template>

<script setup>
	import { ref, onMounted, watchEffect, watch, computed } from 'vue'
	import nartab from '@/components/nartab.vue'
	import messageList from '@/pages/dynamic/components/messageList.vue'
	import { onPageShow,onPullDownRefresh } from '@dcloudio/uni-app'
	
	function Tosearch(){
		uni.navigateTo({
			url: `/pages/dynamic/page/Search`
		})
	}
	//发布动态
	function Toadd(){
		uni.navigateTo({
			url: `/pages/dynamic/page/addDynamic`
		})
	}
	const city = ref('')

	//获取动态信息
	const message = ref(null)
	function onScrollToLower() {
		message.value.loadMore(city.value,null)
	}
	//下拉刷新
	onPullDownRefresh(() => {
	  message.value.resetAndFetch(city.value,null)
	})
	onPageShow(() => {
	  setTimeout(async () => {
		city.value =  uni.getStorageSync('city') 
		message.value.fetchMessageList(city.value,null)
	  }, 50)
	})
	
	onMounted(() => {
	  setTimeout(async () => {
		const pages = getCurrentPages()
		const currentPage = pages[pages.length - 1] 
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
