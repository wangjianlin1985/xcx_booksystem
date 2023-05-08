<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/book.css" />
<div id="bookAddDiv">
	<form id="bookAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">图书条形码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="book_barcode" name="book.barcode" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">图书名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="book_bookName" name="book.bookName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">图书所在类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="book_bookTypeObj_bookTypeId" name="book.bookTypeObj.bookTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">图书价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="book_price" name="book.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">库存:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="book_count" name="book.count" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">出版日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="book_publishDate" name="book.publishDate" />

			</span>

		</div>
		<div>
			<span class="label">出版社:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="book_publish" name="book.publish" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">图书图片:</span>
			<span class="inputControl">
				<input id="bookPhotoFile" name="bookPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">图书简介:</span>
			<span class="inputControl">
				<textarea id="book_bookDesc" name="book.bookDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">图书文件:</span>
			<span class="inputControl">
				<input id="bookFileFile" name="bookFileFile" type="file" size="50" />
			</span>
		</div>
		<div class="operation">
			<a id="bookAddButton" class="easyui-linkbutton">添加</a>
			<a id="bookClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Book/js/book_add.js"></script> 
