<template>
  <web-view :src="url"></web-view>
</template>

<script setup>
	import { ref, onMounted } from 'vue';
	import { onLoad, } from '@dcloudio/uni-app'
	import { deletePost } from '@/store/counter.js'
	import { propertyListingApi, payApi} from '@/utils/api.js'
	import { onUnload, onHide } from '@dcloudio/uni-app'
	
	const store = deletePost()
	const url = ref('');
	const trade = ref('')
	const type = ref('')
	
	async function del(){
		try{
			const res = await propertyListingApi.delete({
				trade_no: trade.value,
			})
			if(res.statusCode === 200){
				uni.showToast({ title: res.msg, icon: 'none' })
				getorder()
			}
			}catch (error) {
				uni.showToast({ title: res.msg, icon: 'none' })
			}
	}
	
	async function check(){
		const res = await payApi.checkxpay({})
		if(res.statusCode === 200){
			
		}else{
			uni.showToast({ title: res.msg, icon: 'none' })
		}
	}

	onLoad((options) => {
	  url.value = decodeURIComponent(options.url);
	});
	
	onUnload(() => {
	  if(type.value == '延期'){
		  del()
		  check()
	  }
	  store.clearType()
	})
	
	onHide(() => {
	  if(type.value == '延期'){
		  del()
		  check()
	  }
	  store.clearType()
	})
	
	onMounted(async () => {
		trade.value = store.Trade
		type.value = store.Type
	})
</script>
