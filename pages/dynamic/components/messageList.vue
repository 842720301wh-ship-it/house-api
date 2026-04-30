<template>
<view >
  <view v-for="item in messageData" :key="item.id" style="background-color: #fff;padding: 20rpx;border-radius: 15rpx;margin: 20rpx 0;">
	  <view style="display: flex;align-items: center;">
		  <view class="user_image" @click.stop="userPage(item)">
		  	<image :src="item.account && item.account.avatar ? item.account.avatar : '/static/none.png'" 
			style="object-fit: cover;width: 100%;height: 100%;"></image>
		  </view>
		  <view style="display: flex; flex-direction: column;margin-left: 20rpx;justify-content: space-between;">
		  	<text style="font-size: 32rpx;">{{ item.account.nickname }}</text>
			<view style="display: flex;font-size: 25rpx;color: #cacaca;">
				<text>{{ formatCreateTime(item.create_time) }}</text>
				<view @click.stop="openMap(item)">
					<tui-icon name="gps" :size="25" unit="rpx" style="margin-left: 20rpx;margin-right: 10rpx;"></tui-icon>{{ item.area }}
				</view>
			</view>
		  </view>
	  </view>
	  <view class="text-content"  @click="open(item)">
		  {{ item.text}}
	  </view>
	  <view style="display: flex; flex-wrap: wrap; gap: 20rpx; margin: 30rpx 0;">
		  <view v-for="(img, index) in item.images" :key="index" style="width: 180rpx; height: 180rpx; position: relative;margin-right: 20rpx;">
		  	<image :src="img.file" mode="aspectFill" @click="previewImage(item.images, index)" style="width: 100%; height: 100%; border-radius: 10rpx;" />
		  </view>
	  </view>
	  <view v-if="account" style="display: flex;align-items: center;justify-content: space-around;border-top: 1rpx solid #dcdcdc;padding-top: 20rpx;">
	  		  <tui-icon name="evaluate" :size="35" unit="rpx" @click.stop="edit(item)"></tui-icon>
			  <button open-type="share" class="no-style-btn">
	  		  	<tui-icon name="share" :size="35" unit="rpx" style=""></tui-icon>
	  		  </button>
			  <tui-icon name="delete" :size="35" unit="rpx"  @click.stop="showModal_1(item)"></tui-icon>
	  </view>
	  <view v-else style="display: flex;align-items: center;justify-content: space-around;border-top: 1rpx solid #dcdcdc;padding-top: 20rpx;">
		  <tui-icon name="voipphone" :size="35" unit="rpx"  @click="showModal(item.telephone)"></tui-icon>
		  <tui-icon name="community" :size="35" unit="rpx"></tui-icon>
		  <button open-type="share" class="no-style-btn">
		  	<tui-icon name="share" :size="35" unit="rpx" style=""></tui-icon>
		  </button>
	  </view>
	  <tui-modal :show="modal_1" @click="handleClick_1"  @cancel="hideModal_1" title="提示" content="确定删除这条动态吗？"></tui-modal>
	  <tui-modal :show="modal" custom padding="0rpx">
	  	<view>
	  		<view class="text" style="display: flex;justify-content: center;font-weight: bold;margin-top: 50rpx;">联系方式</view>
	  			<view class="text" style="display: flex;justify-content: center;margin-bottom: 40rpx;">{{ item.telephone }}</view>
	  			<view style="display: flex;justify-content: space-around;align-items: center;border-top: 1rpx solid #cacaca;">
	  			<view class="modal" style="font-weight: bold;" @click="hideModal()">取消</view>
	  			<view class="modal" style="font-weight: bold;color: #009c9c;border-left: 1rpx solid #cacaca;" @click="clipboard(item.telephone)">
	  				点击复制
	  			</view>
	  		</view>
	  	</view>
	  </tui-modal>
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
	import { dynamicApi } from '@/utils/api.js'
	import { onPullDownRefresh } from '@dcloudio/uni-app'
	import { ref, onMounted, watchEffect, computed } from 'vue'
	import {  formatCreateTime } from '@/common/util.js'
	
	const emit = defineEmits([''])
	const props = defineProps({
	    search: {
	      type: String,
	      default: ''
	    },
	})
	
	//打开帖子
	async function open(item){
		uni.setStorageSync('dynamic', item);
		uni.navigateTo({
			url: `/pages/dynamic/page/Message`
		})
	}
	// 打开联系方式
	const modal = ref(false)
	function showModal(telephone) {
	  modal.value = true
	}
	//隐藏
	function hideModal() {
	  modal.value = false
	}
	//点击复制
	function clipboard(item){
		if (!item) return
		uni.setClipboardData({
		  data: item,
		  success: () => {
		    uni.showToast({
		      title: '复制成功',
		      icon: 'success'
		    })
		  },
		  fail: () => {
		    uni.showToast({
		      title: '复制失败',
		      icon: 'error'
		    })
		  }
		})
	}
	//顶部刷新
	async function resetAndFetchReply() {
	  // console.log('刷新了')
	  uni.stopPullDownRefresh() // 停止下拉动画
	}
	
	onPullDownRefresh(() => {
	  resetAndFetchReply()
	})
	
	//图片预览
	function previewImage(images, index) {
	  const urls = images.map(img => img.file)
	  uni.previewImage({
	    current: index,
	    urls: urls,
	    indicator: 'number',
	  })
	}
	
	const messageData = ref([])
	const page = ref(1)
	const pageSize = ref(10)
	const loading = ref(false)
	const noMore = ref(false)
	const account = ref('')

	async function resetAndFetch(city,openid) {
		page.value = 1
		messageData.value = []  
		noMore.value = false
		await fetchMessageList(city,openid)
	}

	//数据加载
	async function fetchMessageList(city,openid) {
	  if (loading.value || noMore.value) return
	  loading.value = true
	  try {
		account.value = openid  
	    const result = await dynamicApi.get({
			page: page.value,
			pageSize: pageSize.value,
			city: city ,
			openid:openid,
			search:props.search,
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
	
	function edit(item){
		uni.setStorageSync('update',item)
		uni.navigateTo({
		  url: '/pages/dynamic/page/addDynamic'
		});
	}
	const modal_1 = ref(false)
	const id = ref('')
	
	// 打开弹窗
	function showModal_1(item) {
	  id.value = item.id
	  modal_1.value = true
	}
	
	// 关闭弹窗
	function hideModal_1() {
	  modal_1.value = false
	}
	// 点击确认按钮
	function handleClick_1(e) {
		let index = e.index;
		 	if (index === 0) {
		 		 
		 	} else {
		 		 del(id.value)	
		 	}
	  hideModal_1()
	  
	}
	async function del(item){
		try{
			const res = await dynamicApi.delete({
				id: item,
			})
			if(res.statusCode === 200){
				uni.showToast({ title: res.msg, icon: 'none' })
				getorder()
			}
			}catch (error) {
				uni.showToast({ title: res.msg, icon: 'none' })
			}
	}
	
	const openMap = (item) => {
	  // 优先使用经纬度
	  if (item.lat && item.lng) {	
	    uni.openLocation({
	      latitude: Number(item.lat),
	      longitude: Number(item.lng),
	      name: item.area || '查看位置',
	      address: item.address || '',
	      scale: 15
	    })
	    return
	  } else {
	    uni.showToast({
	      title: '暂无位置信息',
	      icon: 'none'
	    })
	  }
	}
</script>

<style>
	.user_image{
		width: 100rpx;
		height:100rpx;
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
		margin-top:30rpx;
		margin-bottom: 30rpx;
		flex-shrink: 0; 
		overflow: hidden;
	}
	.text-content {
	  display: -webkit-box;
	  -webkit-line-clamp: 3; /* 限制显示三行 */
	  -webkit-box-orient: vertical;
	  overflow: hidden;
	  text-overflow: ellipsis;
	  word-break: break-all;
	  color: #333;
	  font-size: 28rpx;
	  line-height: 1.5;
	  padding-bottom: 50rpx;
	}
	.text{
		padding: 20rpx 30rpx;
		font-size: 32rpx;
	}
	.modal{
		width: 50%;
		display: flex;
		justify-content: center;
		padding: 30rpx;
		font-size: 30rpx;
	}
	.no-style-btn {
	  background: none;
	  border: none;
	  padding: 0;
	  margin: 0;
	  color: inherit;
	  font-size: inherit;
	  line-height: inherit;
	  text-align: inherit;
	  border-radius: 0;
	}
</style>