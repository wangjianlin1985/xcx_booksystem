var utils = require("../../utils/common.js");
var config = require("../../utils/config.js");

Page({
  /**
   * 页面的初始数据
   */
  data: {
    barcode: "",
    bookName: "",
    bookTypeObj_Index: "0",
    bookTypes: [],
    price: "",
    count: "",
    publishDate: "",
    publish: "",
    bookPhoto: "upload/NoImage.jpg",
    bookPhotoList: [],
    bookDesc: "",
    bookFile: "",
    bookFileBtnText: "点我选文件",
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  //初始化下拉框的信息
  init_select_params: function () { 
    var self = this;
    var url = null;
    url = config.basePath + "api/bookType/listAll";
    utils.sendRequest(url, null, function (res) {
      wx.stopPullDownRefresh();
      self.setData({
        bookTypes: res.data,
      });
    });
  },

  //图书类别改变事件
  bind_bookTypeObj_change: function (e) {
    this.setData({
      bookTypeObj_Index: e.detail.value
    })
  },

  //选择出版日期
  bind_publishDate_change: function (e) {
    this.setData({
      publishDate: e.detail.value
    })
  },
  //清空出版日期
  clear_pubishDate: function (e) {
    this.setData({
      publishDate: "",
    });
  },

  /*提交添加图书到服务器 */
  formSubmit: function (e) {
    var self = this;
    var formData = e.detail.value;
    var url = config.basePath + "api/book/add";
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '发布成功',
        icon: 'success',
        duration: 500
      })

      //提交成功后重置表单数据
      self.setData({
        barcode: "",
        bookName: "",
        bookTypeObj_Index: "0",
        price: "",
        count: "",
        publishDate: "",
        publish: "",
        bookPhoto: "upload/NoImage.jpg",
        bookPhotoList: [],
        bookDesc: "",
        bookFile: "",
        bookFileBtnText: "点我选文件",
        loadingHide: true,
        loadingText: "网络操作中。。",
      })
    });
  },

  //选择图书文件上传
  select_bookFile: function (e) {
    var self = this;
    wx.chooseVideo({
      count: 1,   //可以上传一个文件
      sourceType: ['album', 'camera'],
      camera: 'back', //后置摄像头
      success: function (res) {
        var tempFilePath = res.tempFilePath
        var btnText = tempFilePath
        if (btnText.length > 15) btnText = "..." + btnText.substring(btnText.length - 15);
        self.setData({
          bookFileBtnText: btnText,
          loadingHide: false
        })

        utils.sendUploadFile(config.basePath + "upload/file", tempFilePath, function (res) {
          wx.stopPullDownRefresh()
          setTimeout(function () {
            self.setData({
              bookFile: res.data,
              loadingHide: true
            });
          }, 200);
        });
      }
    })
  },

  //选择图书图片上传
  select_bookPhoto: function (e) {
    var self = this
    wx.chooseImage({
      count: 1,   //可以上传一张图片
      sizeType: ['original', 'compressed'],
      sourceType: ['album', 'camera'],
      success: function (res) {
        var tempFilePaths = res.tempFilePaths
        self.setData({
          bookPhotoList: tempFilePaths,
          loadingHide: false
        });

       
        utils.sendUploadImage(config.basePath + "upload/image", tempFilePaths[0], function (res) {
          wx.stopPullDownRefresh()
          setTimeout(function () {
            self.setData({
              bookPhoto: res.data,
              loadingHide: true
            });
          }, 200);
        });
      }
    })
  },




  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.init_select_params();
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
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})