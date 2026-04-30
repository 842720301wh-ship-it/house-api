<template>
<view
  style="display: flex;
         flex-wrap: wrap;
         justify-content: space-between;
         padding: 20rpx;
         gap: 10rpx;">
  <view
    v-for="item in messageData"
    :key="item.id"
    @click="open(item)"
    class="card">
    <image class="image" :src="item.images && item.images.length > 0 ? item.images.at(-1).file : '/static/none.png'" mode="aspectFill" />
    <view class="title" style="height: 90rpx;">
      {{ item.address }} - {{ item.rentType }}{{ item.house }} {{ item.area }}㎡
    </view>
    <view class="title" style="font-size: 25rpx;">
      {{ formatCreateTime(item.latestOrder.create_time) }}
    </view>
    <view style="display: flex; align-items: center; justify-content: space-between;">
      <view class="title" style="color: #cacaca; font-size: 25rpx;">
        {{ item.visitor_count }}人浏览
      </view>
      <view class="title" style="color: #009c9c; font-size: 25rpx;">
        {{ item.money }}元
      </view>
    </view>
  </view>
</view>

		
	<view v-if="loading" style="text-align: center; padding: 20rpx;">
	  <tui-loadmore text="加载中..."></tui-loadmore>
	</view>
		
	<view v-if="noMore && messageData.length > 0" style="text-align: center; padding: 20rpx; color: #888;">
		没有更多数据
	</view>
		
	<view v-if="!loading && messageData.length === 0" style="text-align: center; padding: 20rpx;">
		暂无数据
	</view>
	
</template>

<script setup>
	import { homeApi } from '@/utils/api.js'
	import { onPullDownRefresh } from '@dcloudio/uni-app'
	import { ref, onMounted, watchEffect, computed } from 'vue'
	import { useRegionStore, useHistogramStore, useScreenStore } from '@/store/counter.js'
	import {  formatCreateTime } from '@/common/util.js'
	
	const Explorestore = useRegionStore()
	const Histogramstore = useHistogramStore()
	const Screenstore = useScreenStore()
	
	const emit = defineEmits([''])
	const props = defineProps({

	})
	
	//打开帖子
	async function open(item){
		try {
		  const result = await homeApi.visitor({
					property_listing_id: item.id,
				})
		  if (result.statusCode === 200) {
			   uni.setStorageSync('message', item);
			   uni.navigateTo({
				 url: `/pages/public/propertylisting/Message`
			   })
		  } else {
			uni.showToast({ title: result.msg, icon: 'none' })
		  }
		} catch (error) {
		  console.error('搜索请求失败:', error)
		} 
	}
	
	//顶部刷新
	async function resetAndFetchReply() {
	  // console.log('刷新了')
	  uni.stopPullDownRefresh() // 停止下拉动画
	}
	
	onPullDownRefresh(() => {
	  resetAndFetchReply()
	})
	
	
	const messageData = ref([])
	const page = ref(1)
	const pageSize = ref(10)
	const loading = ref(false)
	const noMore = ref(false)

	async function resetAndFetch(item) {
		page.value = 1
		messageData.value = []  
		noMore.value = false
		await fetchMessageList(item)
	}
	const address = computed(() => Explorestore.Area)
	
	const sort = computed(() => Histogramstore.Type)
	
	const Money = computed(() => Screenstore.Money)
	const Rent = computed(() => Screenstore.Rent)
	const House = computed(() => Screenstore.House)
	const Max = computed(() => Screenstore.Max)
	const Min = computed(() => Screenstore.Min)
	const Type = computed(() => Screenstore.Type)
	const Area = computed(() => Screenstore.Area)
	const MaxArea = computed(() => Screenstore.MaxArea)
	const MixArea = computed(() => Screenstore.MixArea)
	//数据加载
	async function fetchMessageList(item) {
	  if (loading.value || noMore.value) return
	  loading.value = true
	  try {
	    const result = await homeApi.get({
			page: page.value,
			pageSize: pageSize.value,
			type: Type.value,
			city: item ,
			address: address.value,
			sort: sort.value,
			Mixmoney: Min.value,
			Maxmoney: Max.value,
			Mixarea: MixArea.value,
			Maxarea: MaxArea.value,
			house: House.value,
			rentType: Rent.value,
		})
	    if (result.statusCode === 200) {
	     if (result.data.length < pageSize.value) {
	       noMore.value = true
	     }
	     // 追加数据
	     messageData.value = page.value === 1 ? result.data : messageData.value.concat(result.data)
	     page.value++
	    } else {
		  uni.showToast({ title: result.msg, icon: 'none' })
	      noMore.value = true
	    }
	  } catch (error) {
	    console.error('搜索请求失败:', error)
	  } finally {
	    loading.value = false
	  }
	}
	
	// 滚动到底部触发加载下一页
	function loadMore() {
	  if (!loading.value && !noMore.value) {
	    fetchMessageList()
	  }
	}
	
	defineExpose({
	  loadMore,
	  resetAndFetch,
	  fetchMessageList
	})
</script>

<style>
	.image{
		width: 100%;
		height: 300rpx;
		flex-shrink: 0;
		overflow: hidden;
		border-radius: 10rpx;
	}
.title {
    color: #000000;
    line-height: 1.5;
    padding: 5rpx 20rpx;
    font-size: 30rpx;
    display: -webkit-box;        
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;      
    overflow: hidden;           
    text-overflow: ellipsis;     
}
.card {
  width: calc(50% - 10rpx); /* ✅ 两个并排 + 间隙 */
  background-color: #ffffff;
  border-radius: 10rpx;
  height: 500rpx;
  box-sizing: border-box;
}

</style>