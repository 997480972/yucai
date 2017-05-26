<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jQuery EasyUI Demo</title>
<jsp:include page="/common/common.jsp"></jsp:include>
</head>
<body>
<div class="easyui-layout" data-options="collapsed:true, fit:true ,border:false">
	<!-- 头部 -->
	<jsp:include page="north.jsp"/> 
	<!-- 底部 -->
    <jsp:include page="south.jsp"/>
    <!-- 左侧:功能导航 --> 
    <jsp:include page="west.jsp"/>
    <!-- 右侧 -->
    <jsp:include page="east.jsp"/>
    <!-- 中部:主体内容 -->
    <div data-options="region:'center'">
    	<div id="layout_main_centerTabs" class="easyui-tabs" data-options="fit:true,border:false">   
		    <div title="首页" data-options="iconCls:'house'">
		    	<iframe src="${pageContext.request.contextPath}/portal/index" frameborder="0" style="border: 0; width: 100%; height: 98%;"></iframe>
		    </div>  
		</div>
    </div>
</div>
</body>
</html>