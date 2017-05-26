<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div align="center">
<h3>个人资料</h3>
<table class="dialog-table">
	<tr>
		<th>账号</th>
		<td>${sessionScope.user.account }</td>
	</tr>
	<tr>
		<th>姓名</th>
		<td>${sessionScope.user.name }</td>
	</tr>
	<tr>
		<th>性别</th>
		<td>${sessionScope.user.gender eq 'M' ? '男' : '女' }</td>
	</tr>
	<tr>
		<th>出生日期</th>
		<td><fmt:formatDate value="${sessionScope.user.birthday }" pattern="yyyy-MM-dd"/> </td>
	</tr>
	<tr>
		<th>电子邮箱</th>
		<td>${sessionScope.user.email }</td>
	</tr>
	<tr>
		<th>创建日期</th>
		<td><fmt:formatDate value="${sessionScope.user.create_datetime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	</tr>
</table>
</div>