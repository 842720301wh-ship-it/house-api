<template>
	<nartab
	:back="true"
	backtext="动态详情"
	/>
	<view>
	  <view style="background-color: #fff;padding: 20rpx;border-radius: 15rpx;margin: 20rpx 0;" v-if="item">
		  <view style="display: flex;align-items: center;">
			  <view class="user_image" @click.stop="userPage(item)">
			  	<image :src="item.account && item.account.avatar ? item.account.avatar : '/static/none.png'" 
				style="object-fit: cover;width: 100%;height: 100%;"></image>
			  </view>
			  <view style="display: flex; flex-direction: column;margin-left: 20rpx;justify-content: space-between;">
			  	<text style="font-size: 32rpx;">{{ item.account.nickname }}</text>
				<view style="display: flex;font-size: 25rpx;color: #cacaca;">
					<text>{{ formatCreateTime(item.create_time) }}</text>
					<view @click.stop="openMap(item)">
						<tui-icon name="gps" :size="25" unit="rpx" style="margin-left: 20rpx;margin-right: 10rpx;"></tui-icon>{{ item.area }}
					</view>
				</view>
			  </view>
		  </view>
		  <view class="text-content">
			  {{ item.text}}
		  </view>
		  <view style="display: flex; flex-wrap: wrap; gap: 20rpx; margin: 30rpx 0;">
			  <view v-for="(img, index) in item.images" :key="index" style="width: 180rpx; height: 180rpx; position: relative;margin-right: 20rpx;">
			  	<image :src="img.file" mode="aspectFill" @click="previewImage(item.images, index)" style="width: 100%; height: 100%; border-radius: 10rpx;" />
			  </view>
			  <view v-for="(img, index) in item.videos" :key="index" style="width: 180rpx; height: 180rpx; position: relative;margin-right: 20rpx;">
			  	<video :src="img.file" @click="previewVideo(item.videos, index)" style="width: 100%; height: 100%; border-radius: 10rpx;" />
			  </view>
		  </view>
		  <view style="display: flex;align-items: center;justify-content: space-around;border-top: 1rpx solid #dcdcdc;padding-top: 20rpx;">
				<tui-icon name="voipphone" :size="35" unit="rpx"  @click.stop="showModal(item.telephone)"></tui-icon>
				<tui-icon name="community" :size="35" unit="rpx"></tui-icon>
				<button open-type="share" class="no-style-btn">
					<tui-icon name="share" :size="35" unit="rpx" style=""></tui-icon>
				</button>
		  </view>
		  <tui-modal :show="modal" custom padding="0rpx">
		  	<view>
		  		<view class="text" style="display: flex;justify-content: center;font-weight: bold;margin-top: 50rpx;">联系方式</view>
		  			<view class="text" style="display: flex;justify-content: center;margin-bottom: 40rpx;">{{ item.telephone }}</view>
		  			<view style="display: flex;justify-content: space-around;align-items: center;border-top: 1rpx solid #cacaca;">
		  			<view class="modal" style="font-weight: bold;" @click="hideModal()">取消</view>
		  			<view class="modal" style="font-weight: bold;color: #009c9c;border-left: 1rpx solid #cacaca;" @click="clipboard(item.telephone)">
		  				点击复制
		  			</view>
		  		</view>
		  	</view>
		  </tui-modal>
	  </view>
	</view>
</template>

<script setup>
	import { ref, watch } from 'vue'
	import { messageApi } from '@/utils/api.js'
	import { onPullDownRefresh, onLoad, onPageShow } from '@dcloudio/uni-app'
	import nartab from '@/components/nartab.vue'
	import {  formatCreateTime } from '@/common/util.js'
	
	const item = ref(null)
	
	// 打开联系方式
	const modal = ref(false)
	function showModal(telephone) {
	  modal.value = true
	}
	//隐藏
	function hideModal() {
	  modal.value = false
	}
	//点击复制
	function clipboard(item){
		if (!item) return
		uni.setClipboardData({
		  data: item,
		  success: () => {
		    uni.showToast({
		      title: '复制成功',
		      icon: 'success'
		    })
		  },
		  fail: () => {
		    uni.showToast({
		      title: '复制失败',
		      icon: 'error'
		    })
		  }
		})
	}
	onLoad(() => {
	  const list = uni.getStorageSync('dynamic')
	  item.value = list 
	  // console.log(item)
	  uni.removeStorageSync('dynamic')
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
	

	//图片预览
	function previewImage(images, index) {
	  const urls = images.map(img => img.file)
	  uni.previewImage({
	    current: index,
	    urls: urls,
	    indicator: 'number',
	  })
	}
	function previewVideo(videos, index) {
	  if (!Array.isArray(videos) || videos.length === 0) return
	  const urls = videos.map(v => ({
	    url: v.file,  
	    type: 'video'  
	  }))
	  uni.previewMedia({
	    current: index,
	    sources: urls,   
	  })
	}
	
	const openMap = (item) => {
	  // 优先使用经纬度
	  if (item.lat && item.lng) {	
	    uni.openLocation({
	      latitude: Number(item.lat),
	      longitude: Number(item.lng),
	      name: item.area || '查看位置',
	      address: item.address || '',
	      scale: 15
	    })
	    return
	  } else {
	    uni.showToast({
	      title: '暂无位置信息',
	      icon: 'none'
	    })
	  }
	}



</script>

<style>
	.user_image{
		width: 100rpx;
		height:100rpx;
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
		padding: 20rpx 30rpx;
		font-size: 32rpx;
	}
	.modal{
		width: 50%;
		display: flex;
		justify-content: center;
		padding: 30rpx;
		font-size: 30rpx;
	}
	.no-style-btn {
	  background: none;
	  border: none;
	  padding: 0;
	  margin: 0;
	  color: inherit;
	  font-size: inherit;
	  line-height: inherit;
	  text-align: inherit;
	  border-radius: 0;
	}
</style>
