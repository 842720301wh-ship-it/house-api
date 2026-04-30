<template>
	<nartab
	:back = "true"
	/>
	<view v-if="item" >
		<carousel
		:list="[...item.videos,...item.images]"
		 />
		 <view style="border-top-left-radius: 10rpx;margin-top: 20rpx;border-top-right-radius: 10rpx;background-color: #ffffff;height: 100vh;">
			<view style="display: flex; justify-content: space-between; align-items: center; padding: 20rpx;">
			  <view class="text" style="color: #009c9c; display: inline-flex; align-items: baseline;">
				<view style="font-size: 70rpx; font-weight: bold;">{{ item.money }}</view>
				<view style="font-size: 40rpx; margin-left: 20rpx;">元</view>
			  </view>
			  <view style="width: 150rpx; height: 150rpx; border-radius: 50%; overflow: hidden;">
			    <map
			      :latitude="item.lat"
			      :longitude="item.lng"
			      :markers="[{ id: 1, latitude: item.lat, longitude: item.lng, width: 20, height: 30 }]"
			      show-location
			      :scale="20"
			      style="width: 100%; height: 100%; margin: 0; padding: 0;"
			      @tap="openMap(item)"
			    />
			  </view>

			</view>
			 <view class="text" style="display: flex;align-items: center;justify-content: start;color: #cacaca">
			 	<view style="display: flex;align-items: center;margin-right: 50rpx;">
			 		<tui-icon name="wealth" :size="40" unit="rpx" style="margin-right: 10rpx;"></tui-icon>
			 		{{ item.visitor_count }}人浏览
			 	</view>
			 	<view style="display: flex;align-items: center;">
			 		<tui-icon name="clock"  :size="40" unit="rpx" style="margin-right: 10rpx;"></tui-icon>
			 		{{ formatCreateTime(item.latestOrder.create_time) }}上架
			 	</view>
			 </view>
			 <view class="text" style="font-size: 40rpx;font-weight: bold;">
			 	{{ item.address }} - {{ item.rentType }}{{ item.house }} {{ item.area }}㎡
			 </view>
			 <view class="text">
			 	{{ item.introduction }}
			 </view>
			 <!-- 底部中间的悬浮按钮 -->
			 <view class="select">
				<button open-type="share" class="no-style-btn">分享</button>
			 	<view @click="updatefavorites(item)" :style="{ color: item._favorites_cache ? '#009c9c' : ''}">
					{{ item._favorites_cache ? '已收藏' : '收藏'}}
				</view>
			 	<view @click="showModal(item.telephone)">联系</view>
			 	<view>私信</view>
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
	import nartab from '@/components/nartab.vue'
	import carousel from '@/components/carousel.vue'
	import { ref, onMounted, watch } from 'vue'
	import { safeNavigateBack } from '@/utils/navigation.js'
	import {  formatCreateTime } from '@/common/util.js'
	import { homeApi } from '@/utils/api.js'
	
	const item = ref('')
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
	//收藏
	async function updatefavorites(item){
		try {
		  const result = await homeApi.favorites({
					property_listing_id: item.id,
				})
		  if (result.statusCode === 200) {
			item._favorites_cache = !item._favorites_cache
		  } else {
			uni.showToast({ title: result.msg, icon: 'none' })
		  }
		} catch (error) {
		  console.error('网络超时:', error)
		} 
	}
	onMounted(async () => {
		  const message = uni.getStorageSync('message')
		  if (message && Object.keys(message).length) {
		    item.value = message
			// console.log(item.value)
		  } else {
		    uni.showToast({ title: '网络异常', icon: 'none' })
			setTimeout(() => {
			  safeNavigateBack()
			}, 2000) 
		  }
		
		const pages = getCurrentPages()
		const currentPage = pages[pages.length - 1] 
		currentPage.onShareAppMessage = () => {
		    return {
				title: `${item.value.address} - ${item.value.rentType} ${item.value.house} ${item.value.area}㎡`,
				path: '/' + currentPage.route
		    }
		}
	})
	
	const openMap = (item) => {
	  // 优先使用经纬度
	  if (item.lat && item.lng) {	
	    uni.openLocation({
	      latitude: Number(item.lat),
	      longitude: Number(item.lng),
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
	.text{
		padding: 20rpx 30rpx;
		font-size: 32rpx;
	}
	.select{
		position: fixed;
		bottom: 100rpx;
		left: 50%;
		transform: translateX(-50%);
		width: 90%;
		height: 100rpx;
		font-size: 40rpx;
		color: #000000;
		background-color: #d0d0d0;
		display: flex;
		align-items: center;
		justify-content: space-around;
		z-index: 10;
		border-radius: 10rpx;
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
	
	/* 去掉微信小程序默认点击灰色背景 */
	.no-style-btn::after {
	  border: none;
	  background: none;
	}

</style>
