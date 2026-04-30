<template>
	<nartab
	title="我的"
	/>
	<view>
		<view class="flex" style="justify-content: flex-start;" v-if="loginstatus">
			<view class="user_image">
				<image :src="account.avatar" style="object-fit: cover;width: 100%;height: 100%;"></image>
			</view>
			<view style="margin-left: 30rpx;" @click="update()">
				<text >
					{{ account.nickname }}
				</text>
			</view>
			<view style="margin-left: auto;display: flex;align-items: center;"  @click="loginout()">
				<text>切换账号</text>
				<tui-icon name="arrowright" color="#333" />
			</view>
		</view>
		<tui-loading v-if="isloading"></tui-loading>
		<view  class="flex" style="justify-content: flex-start;" v-if="!loginstatus">
			<view class="user_image">
				<image :src="account.avatar" style="object-fit: cover;width: 100%;height: 100%;"></image>
			</view>
			<!-- <tui-loading v-if="isloading"></tui-loading> -->
			<view @click="login()" style="margin: 0 30rpx;">
				点击登录
			</view>
		</view>
	</view>
	<view class="flex" v-for="(item,index) in listCell" style="padding: 50rpx 30rpx;font-size: 32rpx;" @click="toPage(index)" :key="index">
		{{ item }}
		<tui-icon name="arrowright" ></tui-icon>
	</view>
	<view class="flex" style="padding: 50rpx 30rpx;font-size: 32rpx;" @click="resetStorageSync()">
		清除缓存 
		<tui-icon name="arrowright" ></tui-icon>
	</view>
	
</template>

<script setup>
	import nartab from '@/components/nartab.vue'
	import { ref,onMounted } from 'vue'
	import { userApi } from '@/utils/api.js'
	import { onPageShow } from '@dcloudio/uni-app'
	
	function update(){
		uni.navigateTo({
			url: '/pages/user/pages/Dynamic'
		})
	}
	//
	const listCell = ["我的动态","访客记录","我的收藏","我的房源"]
	function toPage(index) {
		const pages = [
			'/pages/user/pages/Dynamic',   					
			'/pages/user/pages/Visitor',  					
			'/pages/user/pages/Favorite',					
			'/pages/user/pages/Propertylisting'				
		]
		if (index >= 0 && index < pages.length) {
			uni.navigateTo({
				url: pages[index]
			})
		} else {
			console.warn('未找到对应页面')
		}
	}
	const visible = ref(false)
	function closeDrawer(){
		visible.value = false
	}
	// 
	const account = ref({})
	const loginstatus = ref(false)
	const isloading = ref(false)
	let lastLoginTime = 0
	async function login(){
		isloading.value = true
		const now = Date.now()
		if (now - lastLoginTime < 3000) {
		  uni.showToast({ title: '点击太频繁，请稍后重试', icon: 'none' })
		  return
		}
		lastLoginTime = now
		try {
		  const loginRes = await wx.login()
		  const code = loginRes.code
		  if (!code) {
		    return uni.showToast({ title: '获取code失败', icon: 'none' })
		  }
		  const res = await userApi.login({
		    code,
		  })
		  if (res.statusCode === 200) {
		    uni.setStorageSync('token', res.data.token)
		    uni.setStorageSync('user', res.data)
		    account.value = res.data
		    loginstatus.value = true
		    uni.showToast({ title: '登录成功' })
		  } else {
		    uni.showToast({ title: res.msg || '登录失败', icon: 'none' })
		  }
		} catch (err) {
		  if (err && err.errMsg && err.errMsg.includes('fail auth deny')) {
		    uni.showToast({ title: '用户拒绝授权', icon: 'none' })
		  } else {
		    uni.showToast({ title: '登录异常', icon: 'none' })
		  }
		}finally{
			isloading.value = false
		}
	}
	//
	async function loginout(){
		isloading.value = true
		const res = await userApi.loginout({})
		try{
			if(res.statusCode === 200){
				uni.removeStorageSync('token')
				uni.removeStorageSync('user')
				uni.showToast({ title: res.msg })
				loginstatus.value = false
				
			}else{
				uni.showToast({ title: res.msg, icon: 'none' })
			}
		}finally{
			isloading.value = false
		}
	}
	//
	function resetStorageSync(){
		loginstatus.value = false
		uni.clearStorageSync()
		uni.showToast({ title: '已删除所有缓存!'})
	}
	//
	onPageShow(async () => {
	  account.value = uni.getStorageSync('user') 
	  if (account.value && Object.keys(account.value).length) {
		loginstatus.value = true
	  }
	  // console.log(account.value)
	  const pages = getCurrentPages()
	  const currentPage = pages[pages.length - 1]
	  
	  currentPage.onShareAppMessage = () => {
		return {
		  title: '首页分享标题',
		}
	  }
	  currentPage.onShareTimeline  = () => {
	  	return {
	  	  title: '首页分享标题',
	  	}
	  }
	})


</script>

<style>
	.user_image{
		width: 120rpx;
		height:120rpx;
		border-radius: 50%;
		flex-shrink: 0; 
		overflow: hidden;
		border: 1rpx solid #000;
	}
	.d-container {
		display: flex;
		flex-direction: column;
		align-items: center;
		margin-top: 50rpx;
		margin-bottom: 50rpx;
		justify-content: center;
	}
	.flex{
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 30rpx;
		background-color: #fff;
		margin: 20rpx;
	}


</style>
