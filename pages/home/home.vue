<template>
	<nartab
	:gps = "true"
	:gpscity="city"
	:select="true"
	/>
	<view style="display: flex;align-items: center;justify-content: space-around;padding: 40rpx 30rpx;
	position: sticky;background-color: #fff;">
		<view style="margin-right: 50rpx;display: flex;" @click="setOrderType('explore')">
			位置<tui-icon name="explore" :size="35" unit="rpx"></tui-icon>
		</view>
		<view style="margin-right: 50rpx;display: flex;"  @click="setOrderType('histogram')">
			排序<tui-icon name="histogram" :size="35" unit="rpx"></tui-icon>
		</view>
		<view style="margin-right: 50rpx;display: flex;"  @click="setOrderType('screen')">
			筛选<tui-icon name="screen" :size="35" unit="rpx"></tui-icon>
		</view>
	</view>
	<scroll-view style="height: 100vh;"
	 lower-threshold="50" scroll-y direction="vertical" @scrolltolower="onScrollToLower" >
		<messageList
		ref="message"
		/>
	</scroll-view>
	<tui-drawer mode="bottom" :visible="visible" @close="closeDrawer">
		<view class="d-container" v-if="orderType === 'explore'">
		  <explore
		  :areas = areas
		  @confirm="onScreenConfirm"
		  />
		</view>
		<view class="d-container" v-if="orderType === 'histogram'">
		  <histogram
		  @confirm="onScreenConfirm"
		  />
		</view>
		<view class="d-container" v-if="orderType === 'screen'">
		  <screen
		  @confirm="onScreenConfirm"
		  />
		</view>
	</tui-drawer>
</template>

<script setup>
	import { ref, onMounted, watchEffect, watch, computed } from 'vue'
	import nartab from '@/components/nartab.vue'
	import messageList from '@/pages/home/components/messageList.vue'
	import explore from '@/pages/home/components/explore.vue'
	import histogram from '@/pages/home/components/histogram.vue'
	import screen from '@/pages/home/components/screen.vue'
	import { onPageShow,onPullDownRefresh } from '@dcloudio/uni-app'
	import { userApi } from '@/utils/api.js'
	import { useScreenStore } from '@/store/counter.js'
	
	//抽屉
	const orderType = ref('')
	const visible = ref(false)
	function setOrderType(val) {
	    orderType.value = val
		visible.value = true
	}
	function closeDrawer(){
		visible.value = false
	}
	
	const city = ref('')
	const areas = ref([])
	//登录验证
	async function checktoken(){
		const res = await userApi.checkToken({})
		if(res.statusCode === 200){
			uni.setStorageSync('token', res.data.token)
			uni.setStorageSync('user', res.data)
		}else if(res.statusCode === 500 || res.statusCode === 401){
			uni.removeStorageSync('token')
			uni.removeStorageSync('user')
		}else{
			uni.showToast({ title: '网络异常', icon: 'none' })
		}
	}
	//获取房源信息
	const message = ref(null)
	function onScrollToLower() {
		message.value.loadMore()
	}
	//下拉刷新
	onPullDownRefresh(() => {
	  message.value.resetAndFetch(city.value)
	})
	//切换
	const Screenstore = useScreenStore()
	const Type = computed(() => Screenstore.Type)
	watch(Type, (newVal, oldVal) => {
	  message.value.resetAndFetch(city.value)
	}, { immediate: false }) 
	//子组件刷新
	function onScreenConfirm() {
	  message.value.resetAndFetch(city.value)
	  visible.value = false
	}
	
	onPageShow(() => {
	  setTimeout(async () => {
		city.value =  uni.getStorageSync('city') 
		areas.value = uni.getStorageSync('areas')
		message.value.fetchMessageList(city.value)
	  }, 50)
	})
	
	onMounted(() => {
	  setTimeout(async () => {
		checktoken()
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
	.order-active{
		border-bottom: 1px solid #ff0000;
		color: #000;
		font-weight: bold;
		padding: 20rpx 0;
		font-size: 35rpx;
	}
	.order{
		color: #b1b1b1;
		padding: 20rpx 20rpx;
		font-size: 35rpx;
	}
	.d-container{
		padding: 0 30rpx;
	}
</style>
