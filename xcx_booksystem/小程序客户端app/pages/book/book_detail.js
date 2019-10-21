var utils = require("../../utils/common.js")
var config = require("../../utils/config.js")

Page({
  /**
   * 页面的初始数据
   */
  data: {
    barcode: "", //图书条形码
    bookName: "", //图书名称
    bookTypeObj: "", 
    price: "",
    count: "",
    publishDate: "",
    publish: "",
    bookPhotoUrl: "",
    bookDesc: "",
    bookFile: "",
    bookFileName: "",
    loadingHide: true,
    loadingText: "网络操作中。。",
  },
 
 
  download_bookfile(e) {
    var url = e.currentTarget.dataset.bookfile;
    if (url == "") return;
    //下载文件，生成临时地址
    wx.downloadFile({
      url: config.basePath + url,
      success(res) {
        //保存到本地
        wx.saveFile({
          tempFilePath: res.tempFilePath,
          success: function (res) {
            const savedFilePath = res.savedFilePath;
            // 打开文件
            wx.openDocument({
              filePath: savedFilePath,
              success: function (res) {
                console.log('打开文档成功')
              },
            })
          },
          fail: function (err) {
            console.log('保存失败：', err)
          }
        })
      }
    })
  },
 
 
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (params) {
    var self = this
    var barcode = params.barcode
    var url = config.basePath + "api/book/get/" + barcode
    utils.sendRequest(url, {}, function (bookRes) {
      wx.stopPullDownRefresh()
      self.setData({
        barcode: bookRes.data.barcode,
        bookName: bookRes.data.bookName,
        bookTypeObj: bookRes.data.bookTypeObj.bookTypeName,
        price: bookRes.data.price,
        count: bookRes.data.count,
        publishDate: bookRes.data.publishDate,
        publish: bookRes.data.publish,
        bookPhoto: bookRes.data.bookPhoto,
        bookPhotoUrl: bookRes.data.bookPhotoUrl,
        bookDesc: bookRes.data.bookDesc,
        bookFile: bookRes.data.bookFile,
        bookFileName: bookRes.data.bookFile == "" ? "暂无文件" : bookRes.data.bookFile.substring(7)
      })

    })
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})