var utils = require("../../utils/common.js")
var config = require("../../utils/config.js")

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
    bookPhotoUrl: "",
    bookPhotoList: [],
    bookDesc: "",
    bookFile: "",
    bookFileName: "",
    bookFileBtnText: "点我选文件",
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  //选择出版日期事件
  bind_publishDate_change: function (e) {
    this.setData({
      publishDate: e.detail.value
    })
  },
  //清空图书日期
  clear_pubishDate: function (e) {
    this.setData({
      publishDate: "",
    });
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
          loadingHide: false, 
        });

        utils.sendUploadImage(config.basePath + "upload/image", tempFilePaths[0], function (res) {
          wx.stopPullDownRefresh()
          setTimeout(function () {
            self.setData({
              bookPhoto: res.data,
              loadingHide: true
            })
          }, 200)
        })
      }
    })
  },

  //选择图书文件上传
  select_bookFile: function (e) {
    var self = this
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
              bookFileName: res.data.substring(7),
              loadingHide: true
            });
          }, 200);
        });
      }
    })
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
            });
          },
          fail: function (err) {
            console.log('保存失败：', err)
          }
        });
      }
    })
  },

  //图书类别修改事件
  bind_bookTypeObj_change: function (e) {
    this.setData({
      bookTypeObj_Index: e.detail.value
    })
  },

  //提交服务器修改图书信息
  formSubmit: function (e) {
    var self = this
    var formData = e.detail.value
    var url = config.basePath + "api/book/update"
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '修改成功',
        icon: 'success',
        duration: 500
      })

      //服务器修改成功返回列表页更新显示为最新的数据
      var pages = getCurrentPages()
      var booklist_page = pages[pages.length - 2];
      var books = booklist_page.data.books
      for(var i=0;i<books.length;i++) {
        if(books[i].barcode == res.data.barcode) {
          books[i] = res.data
          break
        }
      }
      booklist_page.setData({books:books}) 
      setTimeout(function () {
        wx.navigateBack({})
      }, 500) 
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
        bookTypeObj_Index: 1,
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

      var bookTypeUrl = config.basePath + "api/bookType/listAll" 
      utils.sendRequest(bookTypeUrl, null, function (res) {
        wx.stopPullDownRefresh()
        self.setData({
          bookTypes: res.data,
        })
        for (var i = 0; i < self.data.bookTypes.length; i++) { 
          if (bookRes.data.bookTypeObj.bookTypeId == self.data.bookTypes[i].bookTypeId) {
            self.setData({
              bookTypeObj_Index: i,
            });
            break;
          }
        }
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