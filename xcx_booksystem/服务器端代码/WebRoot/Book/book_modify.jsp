<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/book.css" />
<div id="book_editDiv">
	<form id="bookEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">图书条形码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="book_barcode_edit" name="book.barcode" value="<%=request.getParameter("barcode") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">图书名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="book_bookName_edit" name="book.bookName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">图书所在类别:</span>
			<span class="inputControl">
				<input class="textbox"  id="book_bookTypeObj_bookTypeId_edit" name="book.bookTypeObj.bookTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">图书价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="book_price_edit" name="book.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">库存:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="book_count_edit" name="book.count" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">出版日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="book_publishDate_edit" name="book.publishDate" />

			</span>

		</div>
		<div>
			<span class="label">出版社:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="book_publish_edit" name="book.publish" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">图书图片:</span>
			<span class="inputControl">
				<img id="book_bookPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="book_bookPhoto" name="book.bookPhoto"/>
				<input id="bookPhotoFile" name="bookPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">图书简介:</span>
			<span class="inputControl">
				<textarea id="book_bookDesc_edit" name="book.bookDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">图书文件:</span>
			<span class="inputControl">
				<a id="book_bookFileA" style="color:red;margin-bottom:5px;">查看</a>&nbsp;&nbsp;
    			<input type="hidden" id="book_bookFile" name="book.bookFile"/>
				<input id="bookFileFile" name="bookFileFile" value="重新选择文件" type="file" size="50" />
			</span>
		</div>
		<div class="operation">
			<a id="bookModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Book/js/book_modify.js"></script> 
