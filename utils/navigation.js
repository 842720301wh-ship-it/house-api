export function safeNavigateBack(defaultUrl = '/pages/home/home') {
  const pages = getCurrentPages()
  if (pages.length > 1) {
    uni.navigateBack()
  } else {
    uni.switchTab({
      url: defaultUrl
    })
  }
}
