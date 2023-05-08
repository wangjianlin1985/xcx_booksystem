var utils = require("../../utils/common.js");
var config = require("../../utils/config.js");

Page({
  /**
   * 页面的初始数据
   */
  data: {
    queryViewHidden: true, //是否隐藏查询条件界面
    bookTypeObj_Index:"0",
    bookTypes: [{"bookTypeId":0,"bookTypeName":"不限制"}],
    bookTypeObj_bookTypeId: 0,
    barcode: "", //图书条形码查询关键字
    bookName: "",
    publishDate: "",
    books: [], //界面显示的图片列表数据
    page_size: 4, //每页显示几条数据
    page: 1,  //当前要显示第几页
    totalPage: null, //总的页码数
    loading_hide: true, //是否隐藏加载动画
    nodata_hide: true, //是否隐藏没有数据记录提示
  },


  // 加载图书列表
  listBook: function () {
    var self = this
    var url = config.basePath + "api/book/list"
    //如果要显示的页码超过总页码不操作
    if(self.data.totalPage != null && self.data.page > self.data.totalPage) return
    self.setData({
      loading_hide: false,  //显示加载动画
    })
    //提交查询参数到服务器查询数据列表
    utils.sendRequest(url, {
      "barcode": self.data.barcode,
      "bookName": self.data.bookName,
      "bookTypeObj.bookTypeId": self.data.bookTypes[self.data.bookTypeObj_Index].bookTypeId,
      "publishDate": self.data.publishDate,
      "page": self.data.page,
      "rows": self.data.page_size,
    }, function (res) { 
      wx.stopPullDownRefresh();
      setTimeout(function () {
        self.setData({
          books: self.data.books.concat(res.data.list),
          totalPage: res.data.totalPage,
          loading_hide: true
        })
      }, 500)
      
      //如果当前显示的是最后一页，则显示没数据提示
      if(self.data.page == self.data.totalPage) {
        self.setData({
          nodata_hide: false,
        });
      }
    });
  },
 
  //显示或隐藏查询视图切换
  toggleQueryViewHide: function () {
    this.setData({
      queryViewHidden: !this.data.queryViewHidden,
    });
  },

  //点击查询按钮的事件
  queryBook: function(e) {
    var self = this; 
    self.setData({
      page: 1,
      totalPage: null,
      books: [],
      loading_hide: true, //隐藏加载动画
      nodata_hide: true, //隐藏没有数据记录提示 
      queryViewHidden: true, //隐藏查询视图
    });

    self.listBook()
  },

  //查询参数图书日期选择事件
  bind_publishDate_change: function (e) {
    this.setData({
      publishDate: e.detail.value
    })
  },
  //清空查询参数图书日期
  clear_pubishDate: function (e) {
    this.setData({
      publishDate: "",
    });
  },

  //绑定查询参数输入事件
  searchValueInput: function (e) {
    var id = e.target.dataset.id
    if (id == "barcode") {
      this.setData({
        "barcode": e.detail.value,
      })
    }
    if (id == "bookName") {
      this.setData({
        "bookName": e.detail.value,
      })
    }
  },

  //查询参数图书类别选择事件
  bind_bookTypeObj_change: function(e) {
    this.setData({
      bookTypeObj_Index: e.detail.value
    })
  },

  init_query_params: function() {
    var self = this; 
    var url = null;
    //初始化图书类别下拉框
    url = config.basePath + "api/bookType/listAll";
    utils.sendRequest(url,null,function(res){
      wx.stopPullDownRefresh();
      self.setData({
        bookTypes: self.data.bookTypes.concat(res.data),
      })
    })
  },

  //删除图书记录
  removeBook: function (e) {
    var self = this
    var barcode = e.currentTarget.dataset.barcode;
    wx.showModal({
      title: '提示',
      content: '确定要删除barcode=' + barcode + '的记录吗？',
      success: function (sm) {
        if (sm.confirm) {
          // 用户点击了确定 可以调用删除方法了
          var url = config.basePath + "api/book/delete/" + barcode;
          utils.sendRequest(url, null, function (res) {
            wx.stopPullDownRefresh();
            wx.showToast({
              title: '删除成功',
              icon: 'success',
              duration: 500
            })
            //删除图书后客户端同步删除数据
            var books = self.data.books;
            for (var i = 0; i < books.length; i++) {
              if (books[i].barcode == barcode) {
                books.splice(i, 1);
                break;
              }
            }
            self.setData({ books: books })

          })
        } else if (sm.cancel) {
          console.log('用户点击取消')
        }
      }
    })

  },


  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.listBook()
    this.init_query_params()
  },


  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
    var self = this
    self.setData({
      page: 1,  //显示最新的第1页结果
      books: [], //清空图书数据
      nodata_hide: true, //隐藏没数据提示
    });
    self.listBook()
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
    var self = this;
    if (self.data.page < self.data.totalPage) {
      self.setData({
        page: self.data.page + 1, 
      });
      self.listBook();
    }

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
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})