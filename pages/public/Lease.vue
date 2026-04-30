<template>
	<nartab
	:title="`发布${type}房源`"
	:back = "true"
	/>
	<view style="background-color: #fff;padding: 30rpx;">
		<view class="box" v-if="updatehome && Object.keys(updatehome).length > 0">
			<view class="font">基础信息（不可修改）:</view>
			<view class="input" >{{ city }}-{{ address }}-{{ house }}</view>
		</view>
		<view v-else>
			<view class="box" @click="setcity()">
				<view class="font">所在地区:</view>
				<view class="input" >{{ city }}</view>
			</view>
			<view class="box">
				<view class="font">详细地址:</view>
				<view class="input" @click="goRegion()">{{ address }}</view>
			</view>
			<view class="box" v-if="type === '租赁'">
				<view class="font">出租方式:</view>
				<view class="flex" style="flex-wrap: wrap;justify-content: flex-start;">
					<view v-for="item in rentTypeList" :key="item" @click="setrentType(item)" :class="['', rentType === item ? 'active' : '']"
					style="padding: 20rpx 30rpx;border-radius: 10rpx;background-color: #eaeaea;color: #0c0c0c;width: 200rpx;margin: 10rpx 30rpx 10rpx 0;
					">
						<view class="flex" style="justify-content: space-between;">
							{{ item }}
							<view v-if="rentType === item">
								<tui-icon name="circle-selected" :size="35" unit="rpx" color="#009c9c"></tui-icon>
							</view>
						</view>
					</view>
				</view>
			</view>
			<view class="box">
				<view class="font">户型:</view>
				<tui-dropdown-list :show="dropdownShow" :top="94" :height="400" backgroundColor="#fff" unit="rpx">
					<template v-slot:selectionbox>
						<view class="input"  @click="showPopup()">
							{{ house }}
						<tui-icon :name="dropdownShow  ? 'arrowdown' : 'arrowright'" :size="35" unit="rpx" color="#000"></tui-icon>
						</view>
					</template>
					<template v-slot:dropdownbox>
						<scroll-view lower-threshold="20"  scroll-y style="margin: 10rpx 0;height: 100vh;"> 
							<view style="margin: 30rpx 0;text-align: center;font-size: 35rpx;" v-for="item in houseTypeList" :key="item" @click="setHouse(item)">
								{{ item}}
							</view>
						</scroll-view>
					</template>
				</tui-dropdown-list>
			</view>
		</view>
		<view class="box">
			<view class="font">面积:(m)</view>
			<input class="input" v-model="area" placeholder="请填写面积" />
		</view>
		<view class="box">
			<view class="font">{{ type === '租赁' ? '租金(元)' : '价格(万元)' }}</view>
			<input class="input" v-model="money" placeholder="请填写价格" />
		</view>
		<view class="box" >
			<view class="font">图片补充:</view>
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
				<view @click="choosePicture" style="border: 1rpx solid #000000;border-radius: 10rpx;width: 180rpx;height: 180rpx;display: flex;align-items: center;justify-content: center;">
					<tui-icon name="plus" :size="50" unit="rpx"></tui-icon>
				</view>
			</view>
		</view>
		<view class="box" >
			<view class="font">视频补充:</view>
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
				<view @click="chooseVideo" style="border: 1rpx solid #000000;border-radius: 10rpx;width: 180rpx;height: 180rpx;display: flex;align-items: center;justify-content: center;">
					<tui-icon name="plus" :size="50" unit="rpx"></tui-icon>
				</view>
			</view>
		</view>
		<view class="box">
			<view class="font">详细介绍:</view>
			<textarea class="textarea" placeholder="介绍你的身份和房源优势~"  maxlength="200" v-model="introduction">
			</textarea>
		</view>
		<view class="box">
			<view class="font">联系方式:</view>
			<input class="input" v-model="telephone" placeholder="填写联系方式"/>
		</view>
	</view>
	<view
	style="padding: 30rpx 20rpx;border-bottom: 1rpx solid #cccccc;display: flex;justify-content: space-between;align-items: center;
	position: sticky;bottom: 0;background-color: #fff;z-index: 1000;" @click="submit()"
	>
		<view style="padding: 20rpx 10rpx;color: #fff;background-color: #009c9c;width: 100%;text-align: center;">
			保存
		</view>
	</view>
</template>

<script setup>
	import nartab from '@/components/nartab.vue'
	import { ref, onMounted, watchEffect,computed } from 'vue'
	import { propertyListingApi, fileApi } from '@/utils/api.js'
	import { safeNavigateBack } from '@/utils/navigation.js'
	import { onPageShow,onLoad, onHide, onUnload } from '@dcloudio/uni-app'
	import { Region } from '@/store/counter.js'
	
	const Regionstore = Region()
	
	
	const area = ref('')
	const house = ref('请选择户型')
	const money = ref('')
	const introduction = ref('')
	const telephone = ref('')
	const rentTypeList = ["整租","合租"]
	const houseTypeList = ["1型","2型","3型","4型","其他",]
	const dropdownShow = ref(false)
	const address = computed(() => Regionstore.Area || '请填写小区或道路号')
	const lat = computed(() => Regionstore.Lat )
	const lng = computed(() => Regionstore.Lng )
	//选择城市
	function setcity(){
		uni.navigateTo({
		  url: '/pages/public/setCIty'
		})
	}
	//地点检索
	function goRegion(){
		uni.navigateTo({
		  url: '/pages/public/map/Region'
		})
	}
	//出租方式
	const rentType = ref('整租')
	function setrentType(item){
		rentType.value = item
	}
	//户型
	function setHouse(item){
		house.value = item
		dropdownShow.value = !dropdownShow.value
	}
	function showPopup(){
		dropdownShow.value = !dropdownShow.value
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
	//提交
	 async function submit(){
			if (!address.value  || address.value === '请填写小区或道路号') {
			  uni.showToast({ title: '详细地址不能为空', icon: 'none' })
			  return
			}
			if (!house.value || house.value === '请选择户型') {
			  uni.showToast({ title: '户型不能为空', icon: 'none' })
			  return
			}
			if (!area.value) {
			  uni.showToast({ title: '面积不能为空', icon: 'none' })
			  return
			}
			if (!money.value) {
			  uni.showToast({ title: '价格不能为空', icon: 'none' })
			  return
			}
			if (!introduction.value) {
			  uni.showToast({ title: '详细介绍不能为空', icon: 'none' })
			  return
			}
			if (!telephone.value) {
			  uni.showToast({ title: '联系方式不能为空', icon: 'none' })
			  return
			}
			
			if(updatehome.value && Object.keys(updatehome.value).length > 0){
				await uploadMediaAndSubmit()
			}else{
				uni.navigateTo({
				  url: '/pages/user/pages/Pay',
				  events: {
				    paySuccess: async (data) => {
				      await uploadMediaAndSubmit(data)
				    }
				  }
				})
			}
			
		}
	
	async function uploadMediaAndSubmit(data) {
	  const videourls = []
	  const pictureurls = []
	  // 上传图片
	for (const filePath of pictureList.value) {
	  try {
		const res = await fileApi.housePicture(filePath)
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
	      const res = await fileApi.houseVideo(filePath)
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
	  if(updatehome.value && Object.keys(updatehome.value).length > 0){
		  // 保存房源
		   result = await propertyListingApi.update({
			id:updatehome.value.id,
		    area: area.value,
		    money: money.value,
		    introduction: introduction.value,
		    telephone: telephone.value,
		    videoUrl: finalVideourls,
		    pictureUrl: finalPictures,
		  })
	  }else{
		  // 保存房源
		   result = await propertyListingApi.add({
		    city: city.value,
		    address: address.value,
		    rentType: rentType.value,
		    house: house.value,
		    area: area.value,
		    money: money.value,
		    introduction: introduction.value,
		    telephone: telephone.value,
		    type,
		    videoUrl: videourls,
		    pictureUrl: pictureurls,
		    trade_no: data.trade_no,
		  	payurl:data.payurl,
			lat:lat.value,
			lng:lng.value
		  })
	  }

	  if (result.statusCode === 200) {
	    uni.showToast({ title: result.msg, icon: 'success' })
		Regionstore.clearArea()
	  } else {
	    uni.showToast({ title: result.msg || '提交失败', icon: 'none' })
	  }
	}
	
	const city = ref('')
	const account = ref({})
	const updatehome = ref('')
	onPageShow(() => {
	  setTimeout(async () => {
		updatehome.value = uni.getStorageSync('updatehome') || ''
		if (updatehome.value && Object.keys(updatehome.value).length > 0) {
		} else {
		  city.value = uni.getStorageSync('city') || '请填写城市'

		}
	  }, 500)
	})
	const oldPictureslist = ref([])
	const oldVideoList = ref([])
	onMounted(() => {
	  setTimeout(async () => {
		updatehome.value = uni.getStorageSync('updatehome') || ''
		if (updatehome.value && Object.keys(updatehome.value).length > 0) {
		  city.value = updatehome.value.city
		  address.value = updatehome.value.address
		  rentType.value = updatehome.value.rentType
		  house.value = updatehome.value.house
		  area.value = updatehome.value.area
		  money.value = updatehome.value.money
		  introduction.value = updatehome.value.introduction
		  telephone.value = updatehome.value.telephone
		  oldPictureslist.value = Array.isArray(updatehome.value.images)
		  ? updatehome.value.images.map(item => item.file)
		  : []
		  oldVideoList.value = Array.isArray(updatehome.value.videos)
		  ? updatehome.value.videos.map(item => item.file)
		  : []
		  // console.log(oldPictureslist.value)
		} 
	  }, 500)
	})

	let type = ''
	onLoad((options) => {
	  type = decodeURIComponent(options.type || '')
	})

	
	onUnload(() => {
	  uni.removeStorageSync('updatehome')
	})

</script>

<style>
	.input{
		margin: 10rpx 0;
		padding: 20rpx;
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
	.active {
	  box-shadow: 0 0 0 2rpx #009c9c;
	  color: #009c9c;
	  background-color: #e0f7f7;
	}
	.textarea{
		background-color: #ebebeb;
		margin-bottom: 20rpx;
		width: 100%;
		padding: 20rpx;
		box-sizing: border-box;
		margin: 10rpx 0;
	}
</style>
