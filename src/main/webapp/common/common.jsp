<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- EasyUI -->
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/script/jquery-easyui-1.4.5/themes/default/easyui.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/script/jquery-easyui-1.4.5/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-easyui-1.4.5/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-easyui-1.4.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-easyui-1.4.5/locale/easyui-lang-zh_CN.js"></script>

<!-- EasyUI 扩展插件 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-easyui-portal/jquery.portal.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery.easyui.ext.js"></script>

<!-- cookie -->
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery.cookie.js"></script>
<link id="easyuiTheme" rel="stylesheet" href="${pageContext.request.contextPath}/script/jquery-easyui-1.4.5/themes/<c:out value="${cookie.easyuiThemeName.value}" default="default"/>/easyui.css" type="text/css">

<!-- 日期控件 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/script/My97DatePicker/WdatePicker.js"></script>

<!--  
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/images/extEasyUIIcon.css">-->

<!-- 系统样式文件
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/rsy.css"> -->
