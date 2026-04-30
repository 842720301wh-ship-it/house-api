<template>
	<view :key="item.id" v-for="item in datalist" style="background-color: #fff;margin: 20rpx;border-radius: 15rpx;">
		<view class="flex" @click="open(item)">
			<view>
				<image
					class="image"
					:src="item.images && item.images.length > 0 ? item.images.at(-1).file : '/static/none.png'"
					mode="aspectFill"
				/>
	
			</view>
			<view class="info">
				<view class="title">
					{{ item.address }} - {{ item.rentType }}{{ item.house }} {{ item.area }}㎡
				</view>
				<view class="price">
					￥{{ item.money }}
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
</template>

<script setup>
	import { ref, onMounted ,watch} from 'vue'
	import { homeApi } from '@/utils/api.js'
	import { onPullDownRefresh } from '@dcloudio/uni-app'
	
	const props = defineProps({
	    type: {
	      type: String,
	      default: ''
	    },
	})
	
	//打开帖子
	async function open(item){
		uni.setStorageSync('message', item);
		uni.navigateTo({
			url: `/pages/public/propertylisting/Message`
		})
	}
	
	const loading = ref(false)
	const noMore = ref(false)
	
	const datalist = ref([])

	//获取房源
	const page = ref(1)
	const pageSize = 10
	async function get(type){
		if (loading.value || noMore.value) return
		loading.value = true
		try{
			const res = await homeApi.getfavorites({
				type: type,
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
	watch(() => props.type, (newVal) => {
	  if (newVal) {
	    resetAndFetch(newVal)
	  }
	}, { immediate: true })
	//顶部刷新
	async function resetAndFetchReply() {
	  await resetAndFetch(props.type)
	  // console.log('刷新了')
	  uni.stopPullDownRefresh() 
	}

	
	async function resetAndFetch(type) {
		page.value = 1
		datalist.value = '' 
		noMore.value = false
		Promise.all([
		  get(type),
		])
	}
	
	function loadMore() {
	  if (!loading.value && !noMore.value) {
	    get(props.type)
	  }
	}

	defineExpose({
	  get,
	  loadMore,
	  resetAndFetchReply
	})
	
</script>

<style>
	.flex {
		display: flex;
		justify-content: flex-start;
		background-color: #fff;
		align-items: flex-start;
		border-bottom: 1rpx solid #eaeaea;
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
	
	.status-circle {
		width: 100rpx;
		height: 100rpx;
		border-radius: 50%;
		display: flex;
		justify-content: center;
		align-items: center;
		font-size: 26rpx;
		font-weight: 600;
		color: #fff;
		text-shadow: 0 0 6rpx rgba(255,255,255,0.6);
		position: relative;
		animation: glow 2s infinite alternate;
		margin-bottom: 10rpx;
	}
</style>