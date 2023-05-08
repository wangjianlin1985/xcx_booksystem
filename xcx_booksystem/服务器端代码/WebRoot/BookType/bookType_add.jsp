<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookType.css" />
<div id="bookTypeAddDiv">
	<form id="bookTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookType_bookTypeName" name="bookType.bookTypeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">可借阅天数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookType_days" name="bookType.days" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="bookTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="bookTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/BookType/js/bookType_add.js"></script> 
