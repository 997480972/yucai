<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/common/common.jsp"></jsp:include> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login</title>
</head>
	<body style="margin:0px;background:#E7F0FF;">

	<div style="text-align: center; margin-top: 20px">
		<div style="width: 400px; margin: 0 auto;">
			<div class="easyui-panel"
				data-options="title:'登录系统',iconCls:'system_login'"
				style="width: 400px; padding: 30px 70px 20px 70px">
				<form id="sys_login_loginForm" method="post">
					<div style="margin-bottom: 10px">
						<input class="easyui-textbox" type="text" id="name" name="name"
							style="width: 100%; height: 40px; padding: 12px"
							data-options="prompt:'请输入账号',iconCls:'icon-man',iconWidth:38,required:true">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" type="password" id="password" name="password"
							style="width: 100%; height: 40px; padding: 12px"
							data-options="prompt:'请输入密码',iconCls:'icon-lock',iconWidth:38,required:true">
					</div>
					<div style="margin-bottom: 20px">
						<input id="captcha" class="easyui-textbox" type="text"
							name="captcha" style="width: 50%; height: 40px; padding: 12px;"
							data-options="prompt:'请输入验证码',required:true"> 
							<img id="verifyImg" title="看不清,换一张" style="width:40%; height:40px;"
							src="${pageContext.request.contextPath}/verify" border="1"
							align="right">
					</div>
					<div>
						<a href="##" id="sys_login_loginForm_loginBtn"
							class="easyui-linkbutton" style="padding: 5px 0px; width: 100%;"
							data-options="iconCls:'icon-ok'"> <span
							style="font-size: 14px;">登 录</span>
						</a>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>
<script type="text/javascript">
	console.log("${sessionScope.user}");
	/* 如果session中有用户,就跳转到主页  */
	if("${sessionScope.user}"){
		alert("${sessionScope.user}");
		window.location.href="/toindex";
	}
	/* 防止登录页面内嵌在其他页面 */
	if (window != top){
		// top 代表最顶级窗口
		top.location.reload();
	} 
	/*给验证码上加一个小手,并绑定点击事件,点击后换一张  */
	$("#verifyImg").mouseover(function(){
		/*鼠标停留在上面时,添加一个css样式 */
		$(this).css("cursor","pointer");
	}).click(function(){
		/* 由于上面那个事件的返回值也是一个JQuery对象,因此可以采用链式编程,在其后面在绑定一个事件  */
		/*点击事件,点完后修改验证码,即修改src属性的值  */
		$(this).attr("src","${pageContext.request.contextPath }/verify" + "?time=" + new Date().getTime())
	});
	
	$('#sys_login_loginForm_loginBtn').click(function(){
		var username = $("#name");
		var password = $("#password");
		var captcha = $("#captcha");
		var msg = "";
		var obj = null;//用于等下光标定位
		if($.trim(username.val()).length===0){
			msg = "账号不能为空" ;
			/*先清空,再将光标定位到该输入框处  */
			username.val("");
			obj = username;
		}else if (!/^\w{1,20}$/.test(username.val())){
			msg = "账号格式不正确" ;
			/*将光标加在定位为该输入框的最后面  */
			obj = username;
		}else if($.trim(password.val()).length===0){
			msg = "密码不能为空" ;
			/*先清空,再将光标定位到该输入框处  */
			password.val("");
			obj = password;
		}else if (!/^\w{3,20}$/.test(password.val())){
			msg = "密码格式不正确" ;
			/*将光标加在定位为该输入框的最后面  */
			obj = password;
		}else if($.trim(captcha.val()).length===0){
			msg = "验证码不能为空" ;
			/*先清空,再将光标定位到该输入框处  */
			captcha.val("");
			obj = captcha;
		}else if (!/^[A-Za-z0-9]{4}$/.test(captcha.val())){
			msg = "验证码格式不正确" ;
			obj = captcha;
		}
		/* 如果警告信息msg不为空,则弹出对应的警告信息  */
		if(msg.length!=0){
			setTimeout($.messager.alert('警告消息',msg,'warning').window({
				/* 提示窗口关闭事件  */
				onClose:function(){
					/* 光标定位 */
					obj.focus();
					/* 标志位变为true */
					window.isFlag = true;
				}
			}),1);
		}else{
			if($('#sys_login_loginForm').form('validate')){
				/*异步提交请求  */
				//通过serialize()方法把所有表达数据转换格式
				//如:userId=11122223&password=111111&vcode=1234&key=1
				$.post('${pageContext.request.contextPath}/login',
						$('#sys_login_loginForm').serialize(),
						function(r){
							if(r.success){
								location.replace('${pageContext.request.contextPath}/toindex');
								return;
							}else{
								$.messager.alert('系统消息',r.content,'info');
							}	
				});
			}
		}
	});
	
	//回车提交
	/*
	$('#sys_login_loginForm input').bind('keyup', function(event){
		if(event.keyCode == '13'){
			loginFun();
		}
	});
	*/
	/** 定义一个全局的标志位  */
	window.isFlag = true ; // window.xxx 的变量为全局变量
	/** 监听回车键  onkeydown */
	$(document).keydown(function(event){
		// event：事件对象
		// keyCode : 按键对应的代号 13 回车键
		if(event.keyCode === 13 && window.isFlag){//加了标志位后,防止有人狂敲回车键
			window.isFlag = false;  //标志位置为false,敲完一次就敲不动了
			/** 事件主动触发 */
			$("#sys_login_loginForm_loginBtn").trigger("click");
		}
	});
</script>