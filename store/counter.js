import { defineStore } from 'pinia'
/**
 * （位置）
 * 所属区
 * 区域
 */
export const useRegionStore = defineStore('region', {
  state: () => ({
    Area: '' ,
	Type: '区域'
  }),
  actions: {
    setArea(name) {
      this.Area = name
    },
    clearArea() {
      this.Area = ''
    },
	setType(name) {
	  this.Type = name
	},
	clearType() {
	  this.Type = '区域'
	},
  }
})
/**
 * （排序）
 * 类型
 */
export const useHistogramStore = defineStore('histogram', {
  state: () => ({
	Type: ''
  }),
  actions: {
	setType(name) {
	  this.Type = name
	},
	clearType() {
	  this.Type = ''
	},
  }
})
/**
 * （筛选）
 * 价格
 * 出租方式
 * 户型
 * 最低价格
 * 最高价格
 * 类型
 * 面积
 * 最大面积
 * 最小面积
 */
export const useScreenStore = defineStore('screen', {
  state: () => ({
	Money: '',
	Rent: '',
	House: '',
	Max: '',
	Min: '',
	Type:'租房',
	Area:'',
	MaxArea:'',
	MixArea:'',
  }),
  actions: {
	setMoney(name) {
	  this.Money = name
	},
	setRent(name) {
	  this.Rent = name
	},
	setHouse(name) {
	  this.House = name
	},
	setMax(name) {
	  this.Max = name
	},
	setMin(name) {
	  this.Min = name
	},
	setType(name) {
	  this.Type = name
	},
	setArea(name) {
	  this.Area = name
	},
	setMaxArea(name) {
	  this.MaxArea = name
	},
	setMixArea(name) {
	  this.MixArea = name
	},
	clear() {
	  this.Money = ''
	  this.Rent = ''
	  this.House = ''
	  this.Max = ''
	  this.Min = ''
	  this.Area = ''
	  this.MaxArea = ''
	  this.MixArea = ''
	},
  }
})
/**
 * （地点检索）
 * 地址
 * 详细地址
 * 纬度
 * 经度
 */
export const Region = defineStore('areas', {
  state: () => ({
	Area: '',
	Address:'',
	Lat:'',
	Lng:''
  }),
  actions: {
	setArea(name) {
	  this.Area = name
	},
	setAddress(name) {
	  this.Address = name
	},
	setLat(name) {
	  this.Lat = name
	},
	setLng(name) {
	  this.Lng = name
	},
	clearArea() {
	  this.Area = ''
	},
	clearAddress() {
	  this.Address = ''
	},
	clear() {
	  this.Area = ''
	  this.Address = ''
	  this.Lat = ''
	  this.Lng = ''
	},
  }
})
/**
 * （订单）
 * 订单号
 * 商品名
 */
export const deletePost = defineStore('deletepost', {
  state: () => ({
	Trade: '',
	Type: ''
  }),
  actions: {
	setTrade(name) {
	  this.Trade = name
	},
	clearTrade() {
	  this.Trade = ''
	},
	setType(name) {
	  this.Type = name
	},
	clearType() {
	  this.Type = ''
	},
  }
})
/**
 * （搜索）
 * 关键词
 */
export const Search = defineStore('search', {
  state: () => ({
	Key: '',
  }),
  actions: {
	setKey(name) {
	  this.Key = name
	},
	clearKey() {
	  this.Key = ''
	},
  }
})