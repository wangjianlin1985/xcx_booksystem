﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!--footer-->
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
            	<a href="http://www.shuangyulin.com" target=_blank>© 大神开发网 from 2020</a> | 
				<a href="http://www.shuangyulin.com">本站招聘</a> | 
				<a href="http://www.shuangyulin.com">联系站长</a> | 
				<a href="http://www.shuangyulin.com">意见与建议</a> | 
				<a href="http://www.shuangyulin.com" target=_blank>湘ICP备0703346号</a> | 
				<a href="<%=basePath%>login.jsp">后台登录</a>
            </div>
        </div>
    </div>
</footer>
<!--footer--> 

 


 