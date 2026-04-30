<template>
	<nartab
	title="上架房源"
	:back = "true"
	:page = "to"
	/>
	<view style="background-color: #fff;padding: 30rpx;height: 100vh;">
		<view style="padding: 30rpx;border: 1rpx solid #009c9c;display: flex;align-items: center;justify-content: space-between;border-radius: 10rpx;">
			<view>
				<view>
					房源上架30天
				</view>
				<view style="margin-top: 20rpx;">
					<text style="color: #009c9c;">10</text>元
				</view>
			</view>
			<tui-icon name="circle-selected" :size="35" unit="rpx" color="#009c9c"></tui-icon>
		</view>
		<view style="margin-top: 50rpx;">支付后不支持退款操作，到期后自动下架</view>
		<view style="margin-top: 20rpx;">如果你不愿支付此费用，可以将房源发布在动态路面供其他人查看，这是免费的。</view>
	</view>
	<view
	style="padding: 30rpx 20rpx;border-bottom: 1rpx solid #cccccc;display: flex;justify-content: space-between;align-items: center;
	position: sticky;bottom: 5%;background-color: #fff;z-index: 1000;" @click="submit()"
	>
		<view style="padding: 20rpx 10rpx;color: #fff;background-color: #009c9c;width: 100%;text-align: center;">
			点击购买
		</view>
	</view>
</template>

<script setup>
	import nartab from '@/components/nartab.vue'
	import { ref, onMounted, watchEffect } from 'vue'
	import { onLoad } from '@dcloudio/uni-app'
	import { payApi } from '@/utils/api.js'
	import { onPageShow } from '@dcloudio/uni-app'
	import { deletePost } from '@/store/counter.js'
	
	const store = deletePost()
	
	const to = '/pages/user/pages/Propertylisting'

	const money = ref('0.1')
	const name = ref('上架')
	const data = ref({})
	
	let eventChannel = null

	async function submit(){
		const res = await payApi.xpay({
			money: money.value,
			name:name.value
		})
		try{
			if(res.statusCode === 200){
				data.value = res.data
				store.setTrade(res.data.trade_no)
				uni.navigateTo({
				  url: '/pages/public/webview/webview?url=' + encodeURIComponent(res.data.payurl)
				});

				uni.showToast({ title: res.msg})
				const pages = getCurrentPages();
				const currentPage = pages[pages.length - 1];
				const eventChannel = currentPage.getOpenerEventChannel();
												
				if (eventChannel) {
				  eventChannel.emit('paySuccess', data.value);
				}
								  
			}else{
				uni.showToast({ title: res.msg, icon: 'none' })
			}
		}finally{}
	}
	
	async function check(){
		const res = await payApi.checkxpay({})
		if(res.statusCode === 200){
			
		}else{
			uni.showToast({ title: '网络异常', icon: 'none' })
		}
	}
	
	onPageShow(() => {
	  setTimeout(async () => {
		check()
	  }, 500)
	})
	
	
	
</script>

<style>
	       
</style>
