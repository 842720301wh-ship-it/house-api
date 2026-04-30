<template>
	<nartab
	title="访客记录"
	:back = "true"
	/>
	<scroll-view style="height: 100vh;" lower-threshold="150" scroll-y direction="vertical" @scrolltolower="onScrollToLower">
		<view :key="item.id" v-for="item in datalist" style="background-color: #fff;margin: 20rpx 0;border-radius: 15rpx;padding: 20rpx;">
			<view style="padding: 20rpx;display: flex;align-items: center;">
				<view class="user_image">
					<image :src="item.avatar ? item.avatar : '/static/none.png'" style="object-fit: cover;width: 100%;height: 100%;"></image>
				</view>
				<view style="margin-left: 30rpx;">
					<view >
						{{ item.nickname }}
					</view>
					<view>{{ formatCreateTime(item.visit_time) }}</view>
				</view>
			</view>
			<view class="flex" @click="open(item.property)" v-if="item && item.property" >
				<view>
					<image
						class="image"
						:src="item.property && item.property.images && item.property.images.length > 0 ? item.property.images[item.property.images.length - 1].file : '/static/none.png'"
						mode="aspectFill"
					/>
				</view>
				<view class="info">
					<view class="title">
						{{ item.property.address }} - {{ item.property.rentType }}{{ item.property.house }} {{ item.property.area }}㎡
					</view>
					<view class="price">
						￥{{ item.property.money }}
					</view>
				</view>
			</view>
		</view>
		<view v-if="loading" style="text-align: center; padding: 20rpx;">
		  <tui-loadmore text="加载中..."></tui-loadmore>
		</view>
			
		<view v-if="noMore && datalist.length > 0" style="text-align: center; padding: 20rpx; color: #888;">
				没有更多数据
		</view>
			
		<view v-if="!loading && datalist.length === 0" style="text-align: center; padding: 20rpx;">
			暂无数据
		</view>
	</scroll-view>	
</template>

<script setup>
	import nartab from '@/components/nartab.vue'
	import { onPageShow ,onPullDownRefresh} from '@dcloudio/uni-app'
	import { ref, onMounted,  } from 'vue'
	import { homeApi } from '@/utils/api.js'
	import {  formatCreateTime } from '@/common/util.js'
	
	//打开帖子
	async function open(item){
		uni.setStorageSync('message', item);
		uni.navigateTo({
			url: `/pages/public/propertylisting/Message`
		})
	}
	
	
	function onScrollToLower() {
		get()
	}
	
	onPullDownRefresh(() => {
	  page.value = 1
	  datalist.value = [] 
	  noMore.value = false
	  Promise.all([
	    get(),
	  ])
	})
	const loading = ref(false)
	const noMore = ref(false)
	
	const datalist = ref([])
	
	//获取房源
	const page = ref(1)
	const pageSize = 10
	async function get(){
		if (loading.value || noMore.value) return
		loading.value = true
		try{
			const res = await homeApi.getvisitor({
				page: page.value,
				pageSize ,
			})
			if(res.statusCode === 200){
				if (res.data.length < pageSize) {
				  noMore.value = true
				}
				datalist.value = page.value === 1 ? res.data : datalist.value.concat(res.data)
				page.value++
			}else{
				noMore.value = true
			}
			}catch (error) {
				uni.showToast({ title: res.msg, icon: 'none' })
				}finally {
				loading.value = false
			}
	}
	
	onPageShow(() => {
	  setTimeout(async () => {
		Promise.all([
		  get()
		]).catch(() => {
		  uni.showToast({ title: '网络异常', icon: 'none' })
		})
	  }, 5)
	})
</script>

<style>
	.flex {
		display: flex;
		justify-content: flex-start;
		background-color: #ebebeb;
		align-items: flex-start;
		border-bottom: 1rpx solid #eaeaea;
		margin: 20rpx;
		
	}
	
	.image {
		width: 250rpx;
		height: 250rpx;
		flex-shrink: 0;
		overflow: hidden;
		border-radius: 10rpx;
	}
	
	.info {
		padding: 20rpx;
		font-size: 30rpx;
		display: flex;
		flex-direction: column;
		justify-content: space-between; 
		height: 270rpx;
		box-sizing: border-box;
		flex: 1;

	}
	
	.title {
		color: #333;
		line-height: 1.5;
	}
	
	.price {
		color: #ff4d4f;
		font-weight: bold;
		align-self: flex-end; 
	}
	.user_image{
		width: 120rpx;
		height:120rpx;
		border-radius: 50%;
		flex-shrink: 0; 
		overflow: hidden;
		border: 1rpx solid #000;
	}
</style>
