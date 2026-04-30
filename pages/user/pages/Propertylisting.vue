<template>
	<nartab
	title="我的房源"
	:back = "true"
	:page = "to"
	:tab = "true"
	/>
	
	<scroll-view style="height: 100vh;" lower-threshold="150" scroll-y direction="vertical" @scrolltolower="onScrollToLower">
		<view style="padding: 0 30rpx;background-color: #fff;position: sticky;top: 0%;z-index: 1000;">
			<view class="flex">
				<view class="type" v-for="item in list" :key="item" :class="['', Type === item ? 'active' : '']" @click="setType(item)">
					{{ item }}
				</view>
			</view>
		</view>
		<Propertylisting
		:type = "Type"
		ref="propertyRef"
		/>
		
	</scroll-view>
		  <view>
		    <!-- 底部中间的悬浮按钮 -->
		    <view
		      @click="openDrawer()"
		      v-if="visible === false"
		      style="position: fixed;bottom: 50rpx;left: 50%;transform: translateX(-50%);width: 100rpx;height: 100rpx;
			  background-color: #009c9c;color: #fff;display: flex;align-items: center;justify-content: center;z-index: 10;"
		    >
		      <tui-icon name="plus" color="#fff"></tui-icon>
		    </view>
		  </view>
	
	
	<tui-drawer mode="bottom" :visible="visible" @close="closeDrawer">
		<view class="visible">
			<view style="color: #c2c2c2;">发布房源</view>
			<view v-for="(item, index) in list" :key="item" style="color: #009c9c;" @click="toPage(index)">
				{{ item }}房源
			</view>
			<view>取消</view>
		</view>
	</tui-drawer>


</template>

<script setup>
	import nartab from '@/components/nartab.vue'
	import Propertylisting from '@/pages/user/components/Propertylisting.vue'
	import { onPageShow ,onPullDownRefresh} from '@dcloudio/uni-app'
	import { ref, onMounted, watchEffect } from 'vue'
	
	const to = '/pages/user/user'
	
	const list = ["租赁","买卖"]
	const Type = ref("租赁")
	function setType(type){
		Type.value = type
	}
	
	const visible = ref(false)
	function openDrawer(){
		visible.value = true
	}
	function closeDrawer(){
		visible.value = false
	}
	
	function toPage(index) {
	  const basePath = '/pages/public/Lease' 
	  const type = list[index]  
	
	  uni.navigateTo({
	    url: `${basePath}?type=${encodeURIComponent(type)}`
	  })
	  visible.value = false
	}
	
	const propertyRef = ref(null)
	
	function onScrollToLower() {
		propertyRef.value.loadMore()
	}
	
	onPullDownRefresh(() => {
	  propertyRef.value.resetAndFetchReply()
	})
	
	onPageShow(() => {
	  setTimeout(async () => {
		Promise.all([
		  propertyRef.value.getorder(),
		  propertyRef.value.get(),
		]).catch(() => {
		  uni.showToast({ title: '网络异常', icon: 'none' })
		})
		propertyRef.value.check()
	  }, 5)
	})

</script>

<style>
	.flex{
		display: flex;
		align-items: center;
		justify-content: space-around;
		font-size: 35rpx;
	}
	.type{
		padding: 30rpx;
	}
	.active{
		color: #009c9c;
		border-bottom: 1rpx solid #009c9c;
		font-weight: bold;
	}
	.visible{
		background-color: #fff;
		height: 30vh;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: space-around;
		font-size: 40rpx;
	}
</style>
