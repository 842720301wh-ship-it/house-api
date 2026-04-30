<template>
	<view style="background-color: #fff;height: 70vh;"
	 >
		<view 
		style="padding: 30rpx 20rpx;border-bottom: 1rpx solid #cccccc;display: flex;justify-content: space-between;align-items: center;
		position: sticky;top: 0;background-color: #fff;z-index: 1000;"
		>
			按照位置搜索:
			<view style="color: #00c3c3;"  @click="reset()">
				默认排序
			</view>
		</view>
		<view class="content">
			<scroll-view class="font left" scroll-y>
				<view style="padding: 20rpx;display: flex;justify-content: space-between;" v-for="item in type" :key="item"
				 @click="setorderType(item)" :class="['', orderType === item ? 'active' : '']">
					{{ item }}
					<tui-icon v-if="orderType === item" name="arrowright" :size="35" unit="rpx"></tui-icon>
				</view>
			</scroll-view>
			<scroll-view v-if="orderType === '区域'" class="font right" lower-threshold="50" scroll-y>
				<view style="padding: 20rpx;display: flex;justify-content: space-between;"
					v-for="item in props.areas" :key="item.id"
					@click="setareaType(item.name)" :class="['', areaType === item.name ? 'active' : '']">
					{{ item.name }}
					<view v-if="areaType === item.name">
						<tui-icon name="circle-selected" :size="35" unit="rpx" color="#009c9c"></tui-icon>
					</view>
				</view>
			</scroll-view>
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
	import { ref, onMounted, watch } from 'vue'
	import { useRegionStore } from '@/store/counter.js'
	import { onShow } from '@dcloudio/uni-app'
	
	const Explorestore = useRegionStore()
	
	const type = ["区域","地铁"]
	const orderType = ref("区域")
	function setorderType(item){
		orderType.value = item
		areaType.value = ''
		Explorestore.clearArea()
	}
	const areaType = ref('')
	function setareaType(item){
		areaType.value = item
	}
	function reset(){
		areaType.value = ''
		orderType.value = '区域'
		Explorestore.clearArea()
		Explorestore.clearType()
	}
	const emit = defineEmits(['confirm'])
	function submit(){
		Explorestore.setArea(areaType.value) 
		Explorestore.setType(orderType.value)
		 emit('confirm') 
	}
	const props = defineProps({
	    areas: {
	      type: Array,
	      default: ''
	    },
	})	
	const areas = ref([])		
	onMounted(async () => { 
		areaType.value = Explorestore.Area 
		orderType.value = Explorestore.Type
	})
	
	
	
	
	

</script>

<style>
	.font{
		font-size: 35rpx;
		padding: 20rpx;
	}
	.content{
		display: flex;
		height: calc(70vh - 160rpx);
	}
	.left{
		width: 30%;
		border-right: 1rpx solid #eaeaea;
		flex-shrink: 0;
		height: 100%;
	}
	.right{
		width: 70%;
		height: 100%;
	}
	.active{
		background-color: #eaeaea;
	}
	.flex{
		display: flex;
		justify-content: center;
		align-items: center;
	}
</style>