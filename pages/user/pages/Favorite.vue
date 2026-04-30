<template>
	<nartab
	title="我的收藏"
	:back = "true"
	/>
	<scroll-view style="height: 100vh;" lower-threshold="150" scroll-y direction="vertical" @scrolltolower="onScrollToLower">
		<view style="padding: 0 30rpx;background-color: #fff;position: sticky;top: 0%;z-index: 1000;">
			<view class="flex">
				<view class="type" v-for="item in list" :key="item" :class="['', Type === item ? 'active' : '']" @click="setType(item)">
					{{ item }}
				</view>
			</view>
		</view>
		<Favorite
		:type = "Type"
		ref="propertyRef"
		/>
	</scroll-view>	
</template>

<script setup>
	import nartab from '@/components/nartab.vue'
	import Favorite from '@/pages/user/components/Favorite.vue'
	import { onPageShow ,onPullDownRefresh} from '@dcloudio/uni-app'
	import { ref, onMounted,  } from 'vue'
	
	const list = ["租赁","买卖"]
	const Type = ref("租赁")
	function setType(type){
		Type.value = type
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
		  propertyRef.value.get(),
		]).catch(() => {
		  uni.showToast({ title: '网络异常', icon: 'none' })
		})
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

</style>
