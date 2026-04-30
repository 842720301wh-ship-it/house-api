export function isDef(value) {
    return value !== undefined && value !== null;
}
export function isObj(x) {
    const type = typeof x;
    return x !== null && (type === 'object' || type === 'function');
}
export function isNumber(value) {
    return /^\d+(\.\d+)?$/.test(value);
}
export function range(num, min, max) {
    return Math.min(Math.max(num, min), max);
}
export function nextTick(fn) {
    setTimeout(() => {
        fn();
    }, 1000 / 30);
}
let systemInfo = null;

export function getSystemInfoSync() {
  if (systemInfo == null) {
    systemInfo = {
      ...wx.getDeviceInfo(),       // 设备型号、系统、平台等
      ...wx.getWindowInfo(),       // 屏幕宽高、像素密度等
      ...wx.getAppBaseInfo()       // 基础库版本等
    }
  }
  return systemInfo;
}

export function addUnit(value) {
    if (!isDef(value)) {
        return undefined;
    }
    value = String(value);
    return isNumber(value) ? `${value}px` : value;
}
