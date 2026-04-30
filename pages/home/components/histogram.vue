<template>
	<view style="background-color: #fff;height: 70vh;"
	 >
		<view 
		style="padding: 30rpx 20rpx;border-bottom: 1rpx solid #cccccc;display: flex;justify-content: space-between;align-items: center;"
		>
			请选择排序方式:
			<view style="color: #00c3c3;"  @click="reset()">
				默认排序
			</view>
		</view>
		<view v-for="item in orderTypeList" :key="item"  class="flex"  @click="setorderType(item)" :class="['', orderType === item ? 'active' : '']"
		style="padding: 20rpx 20rpx;border-radius: 15rpx;background-color: #eaeaea;margin: 20rpx 0;justify-content: space-between;"
		>
			{{ item }}
			<view v-if="orderType === item">
				<tui-icon name="circle-selected" :size="35" unit="rpx" color="#009c9c"></tui-icon>
			</view>
		</view>
		
		<view
		style="padding: 30rpx 20rpx;border-bottom: 1rpx solid #cccccc;display: flex;justify-content: space-between;align-items: center;
		position: sticky;bottom: 0;background-color: #fff;z-index: 1000;" @click="submit()"
		>
			<view style="padding: 20rpx 10rpx;color: #fff;background-color: #009c9c;width: 100%;text-align: center;">
				确定
			</view>
		</view>
	</view>
</template>

<script setup>
	import { ref, onMounted } from 'vue';
	import { useHistogramStore } from '@/store/counter.js'
	
	const Histogramstore = useHistogramStore()

	const orderTypeList = ["最新上架","最新发布","离我最近"]
	const orderType = ref('')
	function setorderType(item){
		orderType.value = item
	}
	function reset(){
		orderType.value = ''
		Histogramstore.clearType()
	}
	const emit = defineEmits(['confirm'])
	function submit(){
		Histogramstore.setType(orderType.value)
		 emit('confirm') 
	}
	onMounted(async () => {
		orderType.value = Histogramstore.Type
	})
</script>

<style>
	.flex{
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.active {
	  box-shadow: 0 0 0 2rpx #009c9c;
	  color: #009c9c;
	  background-color: #e0f7f7;
	}
</style>