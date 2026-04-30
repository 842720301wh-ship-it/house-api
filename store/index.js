// #ifndef VUE3
import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)
const store = new Vuex.Store({
// #endif

// #ifdef VUE3
import { createStore } from 'vuex'
const store = createStore({
// #endif
	state: {
		accountInfo: {},
	},
	mutations: {
		setAccountInfo(state, data) {
		  state.accountInfo = data
		  uni.setStorageSync('account_info', data)
		},
		loadAccountInfo(state) {
		  state.accountInfo = uni.getStorageSync('account_info') || {}
		},
		clearAccountInfo(state) {
		  state.accountInfo = {}
		  uni.removeStorageSync('account_info')
		}
	},
	getters: {
		currentColor(state) {
			return state.colorList[state.colorIndex]
		},
		// vuex测试例使用
		doubleAge(state) {
		  return state.age * 2;
		}
	},
	actions: {
		// vuex测试例使用
		incrementAsync(context , payload) {
		  context.commit('incrementTen',payload)
		},
		// lazy loading openid
		getUserOpenId: async function({
			commit,
			state
		}) {
			return await new Promise((resolve, reject) => {
				if (state.openid) {
					resolve(state.openid)
				} else {
					uni.login({
						success: (data) => {
							commit('login')
							setTimeout(function() { //模拟异步请求服务器获取 openid
								const openid = '123456789'
								console.log('uni.request mock openid[' + openid + ']');
								commit('setOpenid', openid)
								resolve(openid)
							}, 1000)
						},
						fail: (err) => {
							console.log('uni.login 接口调用失败，将无法正常使用开放接口等服务', err)
							reject(err)
						}
					})
				}
			})
		},
		getPhoneNumber: function({
			commit
		}, univerifyInfo) {
			return new Promise((resolve, reject) => {
				uni.request({
					url: 'https://97fca9f2-41f6-449f-a35e-3f135d4c3875.bspapp.com/http/univerify-login',
					method: 'POST',
					data: univerifyInfo,
					success: (res) => {
						const data = res.data
						if (data.success) {
							resolve(data.phoneNumber)
						} else {
							reject(res)
						}

					},
					fail: (err) => {
						reject(res)
					}
				})
			})
		}
	}
})

export default store
