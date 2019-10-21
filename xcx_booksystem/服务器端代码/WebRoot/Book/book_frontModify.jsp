<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Book" %>
<%@ page import="com.chengxusheji.po.BookType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的bookTypeObj信息
    List<BookType> bookTypeList = (List<BookType>)request.getAttribute("bookTypeList");
    Book book = (Book)request.getAttribute("book");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改图书信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">图书信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="bookEditForm" id="bookEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="book_barcode_edit" class="col-md-3 text-right">图书条形码:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="book_barcode_edit" name="book.barcode" class="form-control" placeholder="请输入图书条形码" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="book_bookName_edit" class="col-md-3 text-right">图书名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="book_bookName_edit" name="book.bookName" class="form-control" placeholder="请输入图书名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="book_bookTypeObj_bookTypeId_edit" class="col-md-3 text-right">图书所在类别:</label>
		  	 <div class="col-md-9">
			    <select id="book_bookTypeObj_bookTypeId_edit" name="book.bookTypeObj.bookTypeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="book_price_edit" class="col-md-3 text-right">图书价格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="book_price_edit" name="book.price" class="form-control" placeholder="请输入图书价格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="book_count_edit" class="col-md-3 text-right">库存:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="book_count_edit" name="book.count" class="form-control" placeholder="请输入库存">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="book_publishDate_edit" class="col-md-3 text-right">出版日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date book_publishDate_edit col-md-12" data-link-field="book_publishDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="book_publishDate_edit" name="book.publishDate" size="16" type="text" value="" placeholder="请选择出版日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="book_publish_edit" class="col-md-3 text-right">出版社:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="book_publish_edit" name="book.publish" class="form-control" placeholder="请输入出版社">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="book_bookPhoto_edit" class="col-md-3 text-right">图书图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="book_bookPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="book_bookPhoto" name="book.bookPhoto"/>
			    <input id="bookPhotoFile" name="bookPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="book_bookDesc_edit" class="col-md-3 text-right">图书简介:</label>
		  	 <div class="col-md-9">
			    <textarea id="book_bookDesc_edit" name="book.bookDesc" rows="8" class="form-control" placeholder="请输入图书简介"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="book_bookFile_edit" class="col-md-3 text-right">图书文件:</label>
		  	 <div class="col-md-9">
			    <a id="book_bookFileImg" width="200px" border="0px"></a><br/>
			    <input type="hidden" id="book_bookFile" name="book.bookFile"/>
			    <input id="bookFileFile" name="bookFileFile" type="file" size="50" />
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxBookModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#bookEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改图书界面并初始化数据*/
function bookEdit(barcode) {
	$.ajax({
		url :  basePath + "Book/" + barcode + "/update",
		type : "get",
		dataType: "json",
		success : function (book, response, status) {
			if (book) {
				$("#book_barcode_edit").val(book.barcode);
				$("#book_bookName_edit").val(book.bookName);
				$.ajax({
					url: basePath + "BookType/listAll",
					type: "get",
					success: function(bookTypes,response,status) { 
						$("#book_bookTypeObj_bookTypeId_edit").empty();
						var html="";
		        		$(bookTypes).each(function(i,bookType){
		        			html += "<option value='" + bookType.bookTypeId + "'>" + bookType.bookTypeName + "</option>";
		        		});
		        		$("#book_bookTypeObj_bookTypeId_edit").html(html);
		        		$("#book_bookTypeObj_bookTypeId_edit").val(book.bookTypeObjPri);
					}
				});
				$("#book_price_edit").val(book.price);
				$("#book_count_edit").val(book.count);
				$("#book_publishDate_edit").val(book.publishDate);
				$("#book_publish_edit").val(book.publish);
				$("#book_bookPhoto").val(book.bookPhoto);
				$("#book_bookPhotoImg").attr("src", basePath +　book.bookPhoto);
				$("#book_bookDesc_edit").val(book.bookDesc);
				$("#book_bookFileA").val(book.bookFile);
				$("#book_bookFileA").attr("href", basePath +　book.bookFile);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交图书信息表单给服务器端修改*/
function ajaxBookModify() {
	$.ajax({
		url :  basePath + "Book/" + $("#book_barcode_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#bookEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#bookQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*出版日期组件*/
    $('.book_publishDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    bookEdit("<%=request.getParameter("barcode")%>");
 })
 </script> 
</body>
</html>

