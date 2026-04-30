<template>
	<nartab
	title="公告详情页"
	:back = "true"
	/>
	<scroll-view style="background-color: #fff;height: 100vh;"
	 lower-threshold="50" scroll-y direction="vertical" @scrolltolower="onScrollToLower" >
		<view style="background-color: #ffffff;padding: 0 30rpx 30rpx 30rpx;border-radius: 10rpx;border-bottom: 1rpx solid #888;" v-if="list">
					<view style="display: flex;align-items: center;">
						<view class="user_image">
							<image :src="list.lender.avatar" style="object-fit: cover;width: 100%;height: 100%;"></image>
						</view>
						<view style="display: flex; flex-direction: column;margin-left: 20rpx;">
							<text>{{ list.lender.nickname }}</text>
							<text>{{ list.create_time }}</text>
						</view>
					</view>
					<view class="text" style="font-size: 36rpx;font-weight: bold;">
						<rich-text :nodes="list.title"></rich-text>
					</view>
					<view class="text" style="">
						<rich-text :nodes="list.text"></rich-text>
					</view>
					<view style="display: flex; flex-wrap: wrap; gap: 20rpx; margin-top: 20rpx;">
					  <view v-for="(img, index) in list.images" :key="img" style="width: 200rpx; height: 200rpx;">
					    <image :src="img.image" mode="aspectFill" @click="previewImage(list.images.map(i => i.image), index)" style="width: 100%; height: 100%; border-radius: 10rpx;" />
					  </view>
					</view>
				</view>

	</scroll-view>
</template>

<script setup>
	import { ref, watch } from 'vue'
	import { messageApi } from '@/utils/api.js'
	import { onPullDownRefresh, onLoad, onPageShow } from '@dcloudio/uni-app'
	import nartab from '@/components/nartab.vue'
	

	const list = ref(null) 
	
	onLoad(() => {
	  const item = uni.getStorageSync('currentItem')
	  list.value = item 
	  // console.log(list)
	  uni.removeStorageSync('currentItem')
	})
	
	onPageShow(() => {
	  setTimeout(async () => {
		const pages = getCurrentPages()
		const currentPage = pages[pages.length - 1]  // 当前页面实例
		
		  // 为右上角胶囊按钮绑定分享
		currentPage.onShareAppMessage = () => {
			return {
		      title: '首页分享标题',
		      path: '/' + currentPage.route
		    }
		  }
	  }, 500)
	})

	
	//打开图片
	function previewImage(images, index) {
	  uni.previewImage({
	    current: index,
	    urls: images
	  });
	}
	
	
</script>

<style>
	.user_image{
		width: 80rpx;
		height:80rpx;
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
		margin-top:30rpx;
		margin-bottom: 30rpx;
		flex-shrink: 0; 
		overflow: hidden;
	}   
	.text{
		 white-space: pre-wrap;
		  display: block;
		  margin-bottom: 20rpx;
		  word-break: break-word;
		  line-height: 50rpx;
	}  
</style>
