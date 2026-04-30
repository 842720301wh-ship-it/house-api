<template>
	<view v-if="order?.order " style="background-color: #fff;margin: 20rpx;border-radius: 15rpx;">
		<view style="display: flex;padding: 20rpx;border-bottom: 1rpx solid #eaeaea;justify-content: space-between;align-items: center;">
			<view style="font-size: 45rpx;font-weight: bold">{{ order.order.city}}</view>
				<tui-countdown
					v-if="order.expire > 0"
					:time="order.expire"
					borderColor="#ff6f91"
					color="#ff6f91"
				/>
			<view v-if="order.expire < 0 || order.expire == 0" style="font-size: 25rpx;color: #888;">已过期！</view>
		</view>
		<view class="flex" >
			<view>
				<image
					class="image"
					:src="order.order.pictureUrl && order.order.pictureUrl.length > 0 ? order.order.pictureUrl.at(-1) : '/static/none.png'"
					mode="aspectFill"
				/>
	
			</view>
			<view class="info">
				<view class="title">
					{{ order.order.address }} - {{ order.order.rentType }}{{ order.order.house }} {{ order.order.area }}㎡
				</view>
				<view class="price">
					￥{{ order.order.money }}
				</view>
			</view>
		</view>
		<view style="display: flex;align-items: center;padding: 20rpx;font-size: 30rpx;color: #888;">
			<view style="font-size: 20rpx;">
				订单号：{{ order.order.trade_no }}
			</view>
			<view style="margin-left: auto;color: #009c9c;"  @click="gourlPay()">
				上架
			</view>
			<view style="margin-left: 20rpx;color: #ff4d4f;" @click="showModal(order.order.trade_no)">
				删除
			</view>
		</view>
	</view>
	<tui-modal :show="modal" @click="handleClick"  @cancel="hideModal" title="提示" content="确定删除订单吗？"></tui-modal>
	<view :key="item.id" v-for="item in datalist" style="background-color: #fff;margin: 20rpx;border-radius: 15rpx;">
		<view style="display: flex;padding: 20rpx;border-bottom: 1rpx solid #eaeaea;justify-content: space-between;align-items: center;">
			<view style="font-size: 45rpx;font-weight: bold">{{ item.city}}</view>
				<tui-countdown
					v-if="item.expire_seconds > 0"
					:time="item.expire_seconds"
					borderColor="#00ba00"
					color="#00ba00"
				/>
			<view v-if="item.expire_seconds < 0 || item.expire_seconds == 0" style="font-size: 25rpx;color: #888;">已下架！</view>
		</view>
		<view class="flex" >
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
		<view style="display: flex;align-items: center;padding: 20rpx;font-size: 30rpx;color: #888;">
			<view style="font-size: 20rpx;">
				订单号：{{ item.trade_no }}
			</view>
			<view style="margin-left: auto;color: #009c9c;" @click="Postpone(item.id)">
				延期
			</view>
			<view style="margin: 0 20rpx;" @click="update(item)">
				编辑
			</view>
			<view>
				分享
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
	import { propertyListingApi ,payApi} from '@/utils/api.js'
	import { onPullDownRefresh } from '@dcloudio/uni-app'
	import { deletePost } from '@/store/counter.js'
	
	const store = deletePost()
	
	const props = defineProps({
	    type: {
	      type: String,
	      default: ''
	    },
	})
	
	const loading = ref(false)
	const noMore = ref(false)
	
	const datalist = ref([])
	const order = ref({})
	//获取订单
	async function getorder(){
		const res = await propertyListingApi.getorder({})
		if(res.statusCode === 200){
			order.value = res.data
		}else{
			uni.showToast({ title: res.msg, icon: 'none' })
		}
	}
	
	function gourlPay(){
		uni.navigateTo({
		  url: '/pages/public/webview/webview?url=' + encodeURIComponent(order.value.order.payurl)
		});
	}
	function Postpone(item){
		store.setType("延期")
		uni.navigateTo({
		  url: '/pages/user/pages/Pay',
		  events: {
		    paySuccess: async (data) => {
		      await addPost(item,data)
		    }
		  }
		});
	}
	
	async function addPost(item,data){
		const res = await propertyListingApi.postpone({
			id: item,
			trade_no: data.trade_no,
		})
		if(res.statusCode === 200){
		}else{
			uni.showToast({ title: res.msg, icon: 'none' })
		}
	}
	//获取房源
	const page = ref(1)
	const pageSize = 10
	async function get(type){
		if (loading.value || noMore.value) return
		loading.value = true
		try{
			const res = await propertyListingApi.get({
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
		order.value = ''
		noMore.value = false
		Promise.all([
		  getorder(),
		  get(type),
		])
	}
	
	async function check(){
		const res = await payApi.checkxpay({})
		if(res.statusCode === 200){
			
		}else{
			uni.showToast({ title: res.msg, icon: 'none' })
		}
	}
	
	function update(item){
		uni.setStorageSync('updatehome',item)
		uni.navigateTo({
		  url: '/pages/public/Lease'
		});
	}
	
	const modal = ref(false)
	const deleteTradeNo = ref('')
	
	// 打开弹窗并存储要删除的 trade_no
	function showModal(tradeNo) {
	  deleteTradeNo.value = tradeNo
	  modal.value = true
	}
	
	// 关闭弹窗
	function hideModal() {
	  modal.value = false
	}
	
	// 点击确认按钮
	function handleClick(e) {
		let index = e.index;
		 	if (index === 0) {
		 		 
		 	} else {
		 		 del(deleteTradeNo.value)	
		 	}
	  hideModal()
	  
	}
	async function del(item){
		try{
			const res = await propertyListingApi.delete({
				trade_no: item,
			})
			if(res.statusCode === 200){
				uni.showToast({ title: res.msg, icon: 'none' })
				getorder()
			}
			}catch (error) {
				uni.showToast({ title: res.msg, icon: 'none' })
			}
	}
	
	function loadMore() {
	  if (!loading.value && !noMore.value) {
	    get(props.type)
	  }
	}

	defineExpose({
	  getorder,
	  get,
	  check,
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
		height: 260rpx;
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