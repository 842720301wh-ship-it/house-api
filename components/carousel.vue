<template>
  <view class="swiper-box">
    <swiper
      class="swiper"
      :current="current"
      next-margin="50rpx"
      previous-margin="50rpx"
      circular
      autoplay
      @change="e => current = e.detail.current"
    >
      <swiper-item v-if="props.list && props.list.length" v-for="(item, index) in props.list" :key="index">
        <view class="swiper-item"  @click="previewPictures(item.file)">
			<image v-if="isImage(item.file)" :src="item.file" mode="aspectFill" class="banner-img" />
			<video v-else :src="item.file " class="banner-img" objectFit="cover"  />
        </view>
      </swiper-item>
	  <swiper-item v-else>
	    <view class="swiper-item" >
	  		<image :src="'/static/none.png'" mode="aspectFill" class="banner-img" />
	    </view>
	  </swiper-item>
    </swiper>
  </view>
</template>

<script setup>
	import { ref } from 'vue'

	const current = ref(0)
	const props = defineProps({
	  list: {
		type: Array,
		default: () => []
	  }
	})
	//判断类型
	const isImage = (src) => /\.(jpe?g|png|gif|webp|bmp)$/i.test(src)
	//预览
	function previewPictures(file) {
	  const mediaList = props.list.map(item => {
	    const src = item.file
	    if (isImage(src)) {
	      return { type: 'image', url: src }
	    } else {
	      return { type: 'video', url: src }
	    }
	  })
	  const currentIndex = mediaList.findIndex(m => m.url === file)
	  uni.previewMedia({
	    sources: mediaList,
	    current: currentIndex
	  })
	}



</script>

<style scoped>
.swiper-box {
  width: 100%;
  height: 400rpx;
}
.swiper {
  width: 100%;
  height: 400rpx;
}
.swiper-item {
  width: 90%;
  height: 100%;
  margin: 0 auto;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 12rpx;
  overflow: hidden;
}
.banner-img {
  width: 100%;
  height: 100%;
  border-radius: 12rpx;
}
</style>
