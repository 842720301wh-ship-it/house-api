<template>
	<nartab
	:back="true"
	backtext="发布动态"
	/>
	<view style="background-color: #fff;padding: 30rpx;height: 100vh;">
		<view class="box" style="margin-top: 20rpx;">
			<textarea class="textarea" placeholder="写点什么吧:"  maxlength="200" v-model="text">
			</textarea>
		</view>
		<view class="box">
			<input class="input" v-model="telephone" placeholder="留下你的联系方式"/>
		</view>
		<view v-if="area" style="background-color:#ebebeb; padding:15rpx 20rpx; border-radius:15rpx; display:inline-flex;color: #009c9c;align-items: center;">
		  <tui-icon name="gps" :size="30" unit="rpx" style="margin-right:10rpx;" color="#009c9c"></tui-icon>
		  {{ area }}
		  <tui-icon name="close" :size="30" unit="rpx" style="margin-left:10rpx;" @click="clear()"></tui-icon>
		</view>
		<view class="box" >
			<view style="display: flex; flex-wrap: wrap; gap: 20rpx; margin-top: 20rpx;">
				<view v-for="(item, index) in oldPictureslist" :key="item" style="width: 180rpx; height: 180rpx; position: relative;margin-right: 20rpx;">
					<image :src="item" mode="aspectFill" @click="previewoldPictures(index)" style="width: 100%; height: 100%; border-radius: 10rpx;" />
					<view @click="removeoldPictures(index)" style="position: absolute; top: -10rpx; right: -10rpx;width:50rpx;height: 50rpx;">
						<tui-icon name="close" :size="50" unit="rpx"></tui-icon>
					</view>
				</view>
				<view v-for="(item, index) in pictureList" :key="item" style="width: 180rpx; height: 180rpx; position: relative;margin-right: 20rpx;">
					<image :src="item" mode="aspectFill" @click="previewImage(index)" style="width: 100%; height: 100%; border-radius: 10rpx;" />
					<view @click="removePicture(index)" style="position: absolute; top: -10rpx; right: -10rpx;width:50rpx;height: 50rpx;">
						<tui-icon name="close" :size="50" unit="rpx"></tui-icon>
					</view>
				</view>
			</view>
		</view>
		<view class="box" >
			<view style="display: flex; flex-wrap: wrap; gap: 20rpx; margin-top: 20rpx;">
				<view v-for="(item, index) in oldVideoList" :key="item" style="width: 180rpx; height: 180rpx; position: relative;margin-right: 20rpx;">
					<video :src="item" mode="aspectFill" @click="previewoldVideo(index)" style="width: 100%; height: 100%; border-radius: 10rpx;" />
					<view @click="removeoldVideo(index)" style="position: absolute; top: -10rpx; right: -10rpx;width:50rpx;height: 50rpx;">
						<tui-icon name="close" :size="50" unit="rpx"></tui-icon>
					</view>
				</view>
				<view v-for="(item, index) in videoList" :key="item" style="width: 180rpx; height: 180rpx; position: relative;margin-right: 20rpx;">
					<video :src="item" mode="aspectFill" @click="previewVideo(index)" style="width: 100%; height: 100%; border-radius: 10rpx;" />
					<view @click="removeVideo(index)" style="position: absolute; top: -10rpx; right: -10rpx;width:50rpx;height: 50rpx;">
						<tui-icon name="close" :size="50" unit="rpx"></tui-icon>
					</view>
				</view>
			</view>
		</view>
		<view class="text" @click="goRegion()">
			<tui-icon name="gps" :size="50" unit="rpx" style="margin-right: 30rpx;"></tui-icon>所在位置
		</view>
		<view class="text" @click="choosePicture">
			<tui-icon name="picture" :size="50" unit="rpx" style="margin-right: 30rpx;"></tui-icon>图片
		</view>
		<view class="text" @click="chooseVideo">
			<tui-icon name="video" :size="50" unit="rpx" style="margin-right: 30rpx;"></tui-icon>视频
		</view>
	</view>
	<view>
	  <view @click="submit()" style="position: fixed;bottom: 100rpx;left: 50%;transform: translateX(-50%);width: 90%;height: 100rpx;
		background-color: #009c9c;color: #fff;display: flex;align-items: center;justify-content: center;z-index: 10;font-size: 32rpx;
		border-radius: 15rpx;">
	    保存
	  </view>
	</view>
</template>

<script setup>
	import { ref, onMounted, watchEffect, watch, computed } from 'vue'
	import nartab from '@/components/nartab.vue'
	import { onPageShow,onLoad, onHide, onUnload } from '@dcloudio/uni-app'
	import { safeNavigateBack } from '@/utils/navigation.js'
	import { dynamicApi, fileApi } from '@/utils/api.js'
	import { Region } from '@/store/counter.js'
	
	const Regionstore = Region()
	
	const text = ref('')
	const telephone = ref('')
	const address = computed({
	  get: () => Regionstore.Address,
	  set: (val) => Regionstore.Address = val
	})
	
	const lat = computed({
	  get: () => Regionstore.Lat,
	  set: (val) => Regionstore.Lat = val
	})
	
	const lng = computed({
	  get: () => Regionstore.Lng,
	  set: (val) => Regionstore.Lng = val
	})
	
	const area = computed({
	  get: () => Regionstore.Area,
	  set: (val) => Regionstore.Area = val
	})

	//地点检索
	function goRegion(){
		uni.navigateTo({
		  url: '/pages/public/map/Region'
		})
	}
	//选择图片
	const pictureList = ref([])
	const choosePicture = () => {
	  uni.chooseImage({
		count: pictureList.value.length,
		sizeType: ['compressed'],
		sourceType: ['album', 'camera'],
		success: (res) => {
		  pictureList.value.push(...res.tempFilePaths)
		}
	  })
	}
	
	const removePicture = (index) => {
		pictureList.value.splice(index, 1)  //清除
	}
	const removeoldPictures = (index) => {
		oldPictureslist.value.splice(index, 1)  //清除旧图片	
	}
	const previewImage = (index) => {
		uni.previewImage({
			urls: pictureList.value,             //预览
			current: pictureList.value[index]
		})
	}
	const previewoldPictures = (index) => {
		uni.previewImage({
			urls: oldPictureslist.value,             //预览旧图片
			current: oldPictureslist.value[index]
		})
	}
	//选择视频
	const videoList = ref([])
	const chooseVideo = () => {
	    uni.chooseVideo({
			sourceType: ['album', 'camera'],
			success: (res) => {
				videoList.value.push(res.tempFilePath)
			},
			fail: (err) => {
				console.error('选择视频失败', err)
			}
	    })
	}
	const removeVideo = (index) => {
		videoList.value.splice(index, 1)  //清除
	}
	const removeoldVideo = (index) => {
		oldVideoList.value.splice(index, 1)  //清除旧视频
	}
	const previewVideo = (index) => {
		uni.previewMedia({
				sources: videoList.value.map(v => ({ url: v, type: 'video' })),
				current: index
			})
	}
	const previewoldVideo = (index) => {
		uni.previewMedia({
				sources: oldVideoList.value.map(v => ({ url: v, type: 'video' })),  //预览旧视频
				current: index
			})
	}
	function clear(){
		area.value = ''
		address.value = ''
		Regionstore.clear()	
	}
	//提交
	 async function submit(){
			if (!address.value) {
			  uni.showToast({ title: '地址不能为空', icon: 'none' })
			  return
			}
			if (!area.value) {
			  uni.showToast({ title: '地址不能为空', icon: 'none' })
			  return
			}
			if (!text.value) {
			  uni.showToast({ title: '详细介绍不能为空', icon: 'none' })
			  return
			}
			if (!telephone.value) {
			  uni.showToast({ title: '联系方式不能为空', icon: 'none' })
			  return
			}
			
			await uploadMediaAndSubmit()
			
		}
	
	async function uploadMediaAndSubmit(data) {
	  const videourls = []
	  const pictureurls = []
	  // 上传图片
	for (const filePath of pictureList.value) {
	  try {
		const res = await fileApi.dynamicPicture(filePath)
		const parsed = JSON.parse(res)
	
		if (parsed.statusCode === 200) {
		  pictureurls.push(parsed.data)
		} else {
		  uni.showToast({ title: parsed.msg || '上传失败', icon: 'none' })
		  return
		}
	  } catch (e) {
		uni.showToast({ title: e.message || '上传异常', icon: 'none' })
		return
	  }
	}
	  // 上传视频
	  for (const filePath of videoList.value) {
	    try {
	      const res = await fileApi.dynamicVideo(filePath)
	      const parsed = JSON.parse(res)
	      if (parsed.statusCode === 200) {
	        videourls.push(parsed.data)
	      } else {
	        uni.showToast({ title: parsed.msg, icon: 'none' })
	        return
	      }
	    } catch (e) {
	      uni.showToast({ title: e.message || '上传异常', icon: 'none' })
	      return
	    }
	  }
	  const finalPictures = [...pictureurls,...oldPictureslist.value]
	  const finalVideourls = [...videourls,...oldVideoList.value]
	  let result;
	  if(update.value && Object.keys(update.value).length > 0){
		  // 保存
		   result = await dynamicApi.update({
			id:update.value.id,
			area:area.value,
		    address: address.value,
		    text: text.value,
		    telephone: telephone.value,
		    videoUrl: finalVideourls,
		    pictureUrl: finalPictures,
			lat:lat.value,
			lng:lng.value
		  })
	  }else{
		  // 保存
		   result = await dynamicApi.add({
			area:area.value,
		    address: address.value,
		    text: text.value,
		    telephone: telephone.value,
		    videoUrl: finalVideourls,
		    pictureUrl: finalPictures,
			lat:lat.value,
			lng:lng.value
		  })
	  }
	
	  if (result.statusCode === 200) {
	    uni.showToast({ title: result.msg, icon: 'success' })
		Regionstore.clear()
		setTimeout(()=>{
			safeNavigateBack()
		},1000)

	  } else {
	    uni.showToast({ title: result.msg || '提交失败', icon: 'none' })
	  }
	}
	
	const update = ref('')
	onPageShow(() => {
	  setTimeout(async () => {
		update.value = uni.getStorageSync('update') || ''
		if (update.value && Object.keys(update.value).length > 0) {
			
		} else {

		}
	  }, 500)
	})
	const oldPictureslist = ref([])
	const oldVideoList = ref([])
	onMounted(() => {
	  setTimeout(async () => {
		update.value = uni.getStorageSync('update') || ''
		if (update.value && Object.keys(update.value).length > 0) {
		  address.value = update.value.address
		  area.value = update.value.area
		  text.value = update.value.text
		  telephone.value = update.value.telephone
		  lat.value = update.value.lat
		  lng.value = update.value.lng
		  oldPictureslist.value = Array.isArray(update.value.images)
		  ? update.value.images.map(item => item.file)
		  : []
		  oldVideoList.value = Array.isArray(update.value.videos)
		  ? update.value.videos.map(item => item.file)
		  : []
		  // console.log(oldPictureslist.value)
		} 
	  }, 500)
	})
	
	onUnload(() => {
	  uni.removeStorageSync('update')
	})
</script>

<style>
	.input{
		margin: 10rpx 0;
		padding: 30rpx;
		background-color: #ebebeb;
		border-radius: 10rpx;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	.font{
		font-weight: bold;
	}
	.box{
		width: 100%;
		margin: 50rpx 0;
	}
	.flex{
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.textarea{
		background-color: #ebebeb;
		margin-bottom: 20rpx;
		width: 100%;
		padding: 20rpx;
		box-sizing: border-box;
		margin: 10rpx 0;
	}
	.text{
		display: flex;
		align-items: center;
		font-size: 30rpx;
		padding: 20rpx;
		border-bottom: 1rpx solid #ebebeb;
	}
</style>
