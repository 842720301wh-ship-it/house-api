<template>
	<nartab
	title="城市选择"
	:back = "true"
	/>
	<scroll-view  lower-threshold="50" scroll-y direction="vertical" style="background-color: #fff;height: 100vh;">
		<view v-if="region?.districts?.[0]?.districts" style="background-color: #fff;">
		  <view v-for="province in region.districts[0].districts" :key="province.name" class="province" @click="open(province.name)" >
			  
		    <view class="flex" style="margin: 20rpx 0;">
				<view style="font-size: 35rpx;">
					{{ province.name }}
				</view>
				<view>
					<tui-icon :name="openProvince === province.name ? 'arrowdown' : 'arrowright'" :size="35" unit="rpx"></tui-icon>
				</view>
			</view>
			
		    <view v-if="openProvince === province.name" v-for="city in province.districts" :key="city.name" class="city" @click="selectcity(city.name,city.districts)">
				<text>{{ city.name }}</text>
		    </view>
			
		  </view>
		</view>
	</scroll-view>
	
</template>

<script setup>
	import nartab from '@/components/nartab.vue'
	import { baiduApi } from '@/utils/api.js'
	import { ref, onMounted, watch } from 'vue'
	import { safeNavigateBack } from '@/utils/navigation.js'
	import { onPageShow,onPullDownRefresh } from '@dcloudio/uni-app'
	
	const openProvince = ref('')
	function open(provinceName) {
		if (openProvince.value === provinceName) {
			openProvince.value = '' 
		} else {
			openProvince.value = provinceName 
		}
	}
	
	function selectcity(name,areas) {
	  uni.setStorageSync('city', name)
	  uni.setStorageSync('areas', areas)
	  safeNavigateBack()
	}
	
	const region = ref({})
	async function getRegion(){
		const res = await baiduApi.getRegion({
			keyword: "全国",
			sub_admin: "3",
		})
			
		if(res.statusCode === 200){
			region.value = res.data
			uni.setStorageSync('gps', res.data)
		}else{
			uni.showToast({ title: res.msg, icon: 'none' })
		}
	}
	
	//下拉刷新
	onPullDownRefresh(() => {
	  getRegion()
	})

	onMounted(async () => {
		  const cachedRegion = uni.getStorageSync('gps')
		  if (cachedRegion && Object.keys(cachedRegion).length) {
		    region.value = cachedRegion
		  } else {
		    await getRegion() 
		  }
		
		const pages = getCurrentPages()
		const currentPage = pages[pages.length - 1] 
		currentPage.onShareAppMessage = () => {
		    return {
		      title: '首页分享标题',
		      path: '/' + currentPage.route
		    }
		}
	})
</script>

<style>
	.province{
		padding: 10rpx 30rpx;
		border-bottom: 1rpx solid #ebebeb;
	}
	.flex{
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	.city{
		padding: 30rpx 30rpx;
		font-size: 35rpx;
	}
</style>
