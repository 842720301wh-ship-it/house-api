<template>
	<view style="background-color: #fff;height: 70vh;">
		<view 
		style="padding: 30rpx 10rpx;border-bottom: 1rpx solid #cccccc;display: flex;justify-content: space-between;
		align-items: center;position: sticky;top: 0;background-color: #fff;z-index: 1000;">
			筛选条件:
			<view style="color: #00c3c3;" @click="reset()">
				清除条件
			</view>
		</view>
		<view style="padding: 20rpx 10rpx;color: #b4b4b4;" v-if="Type == '租房'">
			租金（元/月） （1k=1000元）
		</view>
		<view style="padding: 20rpx 10rpx;color: #b4b4b4;" v-if="Type == '买房'">
			价格（万元)
		</view>
		<view class="flex" style="flex-wrap: wrap;padding: 0 10rpx;justify-content: start;">
			<view v-for="(item, index) in moneyTypeList" :key="item"  @click="setmoneyType(item)" :class="['', moneyType === item ? 'active' : '']"
			style="padding: 20rpx 30rpx;border-radius: 10rpx;background-color: #eaeaea;margin: 10rpx 10rpx;color: #0c0c0c;width: 200rpx;
			;
			">
				<view class="flex" style="justify-content: space-between;">
					<view>
						{{ item }}
					</view>
					<view v-if="moneyType === item">
						<tui-icon name="circle-selected" :size="35" unit="rpx" color="#009c9c"></tui-icon>
					</view>
				</view>
			</view>
		</view>
		<view class="flex" style="padding: 20rpx 10rpx;color: #b4b4b4;">
			<view>
				<view>最低</view>
				<view class="input" style="margin-right: 10rpx;">
					<input v-model="inputMin"
					/>
				</view>
			</view>
			<view>
				<view>最高</view>
				<view class="input">
					<input v-model="inputMax"
					/>
				</view>
			</view>
		</view>
		<view style="padding: 20rpx 10rpx;color: #b4b4b4;" v-if="Type == '租房'">
			<view>
				出租方式
			</view>
			<view class="flex" style="flex-wrap: wrap;justify-content: start;">
				<view v-for="item in rentTypeList" :key="item" @click="setrentType(item)" :class="['', rentType === item ? 'active' : '']"
				style="padding: 20rpx 30rpx;border-radius: 10rpx;background-color: #eaeaea;margin: 5rpx 10rpx;color: #0c0c0c;width: 145rpx;
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
		<view style="padding: 20rpx 10rpx;color: #b4b4b4;" v-if="Type == '买房'">
			<view>
				面积
			</view>
			<view class="flex" style="flex-wrap: wrap;justify-content: start;">
				<view v-for="item in areaTypeList" :key="item"  @click="setareaType(item)" :class="['', areaType === item ? 'active' : '']"
				style="padding: 20rpx 30rpx;border-radius: 10rpx;background-color: #eaeaea;margin: 10rpx 10rpx;color: #0c0c0c;width: 200rpx;
				">
					<view class="flex" style="justify-content: space-between;">
						{{ item }}
						<view v-if="areaType === item">
							<tui-icon name="circle-selected" :size="35" unit="rpx" color="#009c9c"></tui-icon>
						</view>
					</view>
				</view>
			</view>
		</view>
		<view style="padding: 20rpx 10rpx;color: #b4b4b4;margin-bottom: 50rpx;">
			<view>
				户型
			</view>
			<view class="flex" style="flex-wrap: wrap;justify-content: start;">
				<view v-for="item in houseTypeList" :key="item"  @click="sethouseType(item)" :class="['', houseType === item ? 'active' : '']"
				style="padding: 20rpx 30rpx;border-radius: 10rpx;background-color: #eaeaea;margin: 10rpx 10rpx;color: #0c0c0c;width: 145rpx;
				">
					<view class="flex" style="justify-content: space-between;">
						{{ item }}
						<view v-if="houseType === item">
							<tui-icon name="circle-selected" :size="35" unit="rpx" color="#009c9c"></tui-icon>
						</view>
					</view>
				</view>
			</view>
		</view>
		<view
		style="padding: 30rpx 10rpx;border-bottom: 1rpx solid #cccccc;display: flex;justify-content: space-between;align-items: center;
		position: sticky;bottom: 0;background-color: #fff;z-index: 1000;" @click="submit()"
		>
			<view style="padding: 20rpx 10rpx;color: #fff;background-color: #009c9c;width: 100%;text-align: center;">
				确定
			</view>
		</view>
	</view>
</template>

<script setup>
	import { ref, onMounted, watchEffect, computed } from 'vue'
	import { useScreenStore } from '@/store/counter.js'
	
	const Screenstore = useScreenStore()
	
	const moneyTypeList1 = ["1k以下","1k~2k","2k~4k","4k~6k","6k~8k","8k~10k","10k~15k","15k以上"]
	const moneyTypeList2 = ["200万以下","200~300万","300~400万","400~500万","500~800万","800~1000万","1000万以上"]
	const moneyTypeList = computed(() => {
	  return Screenstore.Type === '租房' ? moneyTypeList1 : moneyTypeList2
	})
	const rentTypeList = ["整租","合租"]
	const houseTypeList = ["1型","2型","3型","4型","其他",]
	const areaTypeList = ["50㎡","50~70㎡","70~90㎡","90~110㎡","110~130㎡","130~150㎡","150㎡以上"]
	
	const moneyType = ref('')
	const rentType = ref('')
	const houseType = ref('')
	const areaType = ref('')
	const Type = computed(() => Screenstore.Type)
	//价格范围
	const inputMin =ref('')
	const inputMax =ref('')
	function setmoneyType(item){
		if(Type.value == '租房'){
			if (item.includes('以下')) {
			  inputMin.value = 0
			  inputMax.value = 1000
			} else if (item.includes('以上')) {
			  inputMin.value = 15000
			  inputMax.value = ''
			} else if (item.includes('~')) {
			  const [min, max] = item.split('~').map(v => parseInt(v) * 1000)
			  inputMin.value = min
			  inputMax.value = max
			} else {
			  inputMin.value = ''
			  inputMax.value = ''
			}
		}
		if(Type.value == '买房'){
			if (item.includes('以下')) {
			  inputMin.value = 0
			  inputMax.value = 200
			} else if (item.includes('以上')) {
			  inputMin.value = 1000
			  inputMax.value = ''
			} else if (item.includes('~')) {
			  const [min, max] = item.split('~').map(v => parseInt(v) )
			  inputMin.value = min
			  inputMax.value = max
			} else {
			  inputMin.value = ''
			  inputMax.value = ''
			}
		}
		moneyType.value = item
	}
	//出租类型
	function setrentType(item){
		rentType.value = item
	}
	//户型
	function sethouseType(item){
		houseType.value = item
	}
	//面积
	const MaxArea = ref('')
	const MixArea = ref('')
	function setareaType(item){
		if (item.includes('以下')) {
		  MixArea.value = 0
		  MaxArea.value = 50
		} else if (item.includes('以上')) {
		  MixArea.value = 150
		  MaxArea.value = ''
		} else if (item.includes('~')) {
		  const [min, max] = item.split('~').map(v => parseInt(v) )
		  MixArea.value = min
		  MaxArea.value = max
		} else {
		  MixArea.value = ''
		  MaxArea.value = ''
		}
		areaType.value = item
	}
	const emit = defineEmits(['confirm'])
	function submit(){
		Screenstore.setMoney(moneyType.value)
		Screenstore.setRent(rentType.value)
		Screenstore.setHouse(houseType.value)
		Screenstore.setMax(inputMax.value)
		Screenstore.setMin(inputMin.value)
		Screenstore.setArea(areaType.value)
		Screenstore.setMaxArea(MaxArea.value)
		Screenstore.setMixArea(MixArea.value)
		emit('confirm') 
	}
	function reset(){
		houseType.value = ''
		rentType.value = ''
		moneyType.value = ''
		inputMax.value = ''
		inputMin.value = ''
		areaType.value = ''
		MaxArea.value = ''
		MixArea.value = ''
		Screenstore.clear()
	}
	onMounted(async () => {
		moneyType.value = Screenstore.Money
		rentType.value = Screenstore.Rent
		houseType.value = Screenstore.House
		inputMax.value = Screenstore.Max
		inputMin.value = Screenstore.Min
		areaType.value = Screenstore.Area
		MaxArea.value = Screenstore.MaxArea
		MixArea.value = Screenstore.MixArea
	})
	
</script>

<style>
	.flex{
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.input{
		padding: 15rpx;
		background-color: #eaeaea;
		color: #000;
		margin-top: 10rpx;
	}
	.active {
	  box-shadow: 0 0 0 2rpx #009c9c;
	  color: #009c9c;
	  background-color: #e0f7f7;
	}

</style>