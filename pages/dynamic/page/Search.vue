<template>
	<nartab
	:back = "true"
	backtext="搜索动态"
	/>
	<view class="select">
		<input class="input" v-model="search" :placeholder="`在${city}搜索`"/>
		<view style="color: #009c9c;" @click="getmessage()">
			搜索
		</view>
	</view>
	<scroll-view style="height: 100vh;"
	 lower-threshold="50" scroll-y direction="vertical" @scrolltolower="onScrollToLower" >
		<messageList
		ref="message"
		:search="search"
		/>
	</scroll-view>
</template>

<script setup>
	import { ref, onMounted, watch, computed } from 'vue'
	import nartab from '@/components/nartab.vue'
	import messageList from '@/pages/dynamic/components/messageList.vue'
	import { onPageShow, onPullDownRefresh } from '@dcloudio/uni-app'
	
	const search = ref('')
	//获取动态信息
	const message = ref(null)
	function onScrollToLower() {
		message.value.loadMore(city.value,null)
	}
	//下拉刷新
	onPullDownRefresh(() => {
	  message.value.resetAndFetch(city.value,null)
	})
	
	function getmessage(){
		message.value.resetAndFetch(city.value,null)
	}
	
	
	const city = ref('')

	onPageShow(() => {
	  setTimeout(async () => {
		city.value =  uni.getStorageSync('city') || ''
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
	.select{
		display: flex;
		justify-content: space-around;
		align-items: center;
		background-color: #fff;
		padding: 20rpx;
		position: sticky;
		top: 0;
	}
	.input{
		padding: 20rpx 20rpx;
		background-color: #ebebeb;
		width: 550rpx;
	}
</style>
