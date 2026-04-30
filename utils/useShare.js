export function useShare(title = '我的小程序') {
  // 获取当前页面路径
  const pages = getCurrentPages()
  const currentPage = pages[pages.length - 1] 
  const path = `/${currentPage.route}`

  
  if (currentPage && typeof currentPage.onShareAppMessage === 'undefined') {
    currentPage.onShareAppMessage = () => {
      return {
        title,
        path
      }
    }
  }
}
