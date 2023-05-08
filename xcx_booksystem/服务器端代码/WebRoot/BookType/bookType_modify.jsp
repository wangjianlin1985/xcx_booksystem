<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookType.css" />
<div id="bookType_editDiv">
	<form id="bookTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">图书类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookType_bookTypeId_edit" name="bookType.bookTypeId" value="<%=request.getParameter("bookTypeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookType_bookTypeName_edit" name="bookType.bookTypeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">可借阅天数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookType_days_edit" name="bookType.days" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="bookTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/BookType/js/bookType_modify.js"></script> 
