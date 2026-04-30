<template>
	<nartab
	title="地点检索"
	:back = "true"
	/>
	<scroll-view  lower-threshold="150rpx" scroll-y direction="vertical" style="height: 100vh;background-color: #fff;">
		<view class="select">
			<input class="input" v-model="query" placeholder="请填写小区或道路号"/>
			<view style="color: #009c9c;" @click="getRegion()">
				搜索
			</view>
		</view>
		<view class="list" v-if="areas" v-for="item in areas.results" :key="item.uid" @click="set(item)">
			<view style="margin-bottom: 30rpx;font-weight: bold;">
				{{ item.name}}
			</view>
			<view style="color: #b3b3b3;">
				{{ item.address}}
			</view>
		</view>
	</scroll-view>
</template>

<script setup>
	import nartab from '@/components/nartab.vue'
	import { baiduApi } from '@/utils/api.js'
	import { ref, onMounted, watch } from 'vue'
	import { safeNavigateBack } from '@/utils/navigation.js'
	import { Region } from '@/store/counter.js'
	import { onPageShow } from '@dcloudio/uni-app'
	
	const areas = ref({})
	const query = ref('')
	const Regionstore = Region()
	
	async function getRegion(){
		if(!region.value){
			uni.showToast({ title: '城市不能为空', icon: 'none' })
			return
		}
		const res = await baiduApi.region({
			query:  query.value,
			region: region.value,
		})
			
		if(res.statusCode === 200){
			areas.value = res.data
			
		}else{
			uni.showToast({ title: res.msg, icon: 'none' })
		}
	}
	
	function set(item){
		Regionstore.setArea(item.name)
		Regionstore.setAddress(item.address)
		Regionstore.setLat(item.location.lat)
		Regionstore.setLng(item.location.lng)
		safeNavigateBack()
	}
	const region = ref('')
	onPageShow(() => {
	  setTimeout(async () => {
		region.value =  uni.getStorageSync('city')
	  }, 500)
	})
</script>

<style>
	.select{
		display: flex;
		justify-content: space-between;
		align-items: center;
		background-color: #fff;
		padding: 30rpx;
		position: sticky;
		top: 0;
	}
	.input{
		padding: 20rpx 20rpx;
		background-color: #ebebeb;
		width: 550rpx;
	}
	.list{
		padding: 30rpx;
		border-bottom: 1rpx solid #ebebeb;
	}
</style>
