<%@ page language="java" import="java.util.*"  errorPage="/error/serverError.jsp" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>请求不存在</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
	  <%out.println("你的 IP 地址 " + request.getRemoteAddr());%>
    <h1 align="center">404，Page Not Found!页面没找到！</h1>
    <p align="center">
    <a href=""  style="color: #FF8400">返回</a>
    </p>
  </body>
</html>
