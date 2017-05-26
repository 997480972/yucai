<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div align="center">
	<form id="sys_sysUser_add_dialog_form" method="post">
		<table class="dialog-table">
			<tr>
				<th>账号</th>
				<td><input class="easyui-textbox" name="account" data-options="height:24,width:160, required:true,validType:'length[1,20]'"/></td>
				<th>密码</th>
				<td><input class="easyui-textbox" type="password" name="password" data-options="height:24,width:160, required:true,validType:'length[6,16]'"/></td>
			</tr>
			<tr>
				<th>用户名</th>
				<td><input class="easyui-textbox" name="name" data-options="height:24,width:160, required:true,validType:'length[1,20]'"/></td>
				<th>性别</th>
				<td>
					<select class="easyui-combobox" data-options="height:24,width:160"  name="gender">
					    <option value="M">男</option>   
					    <option value="F">女</option>  
					</select>
				</td>
			</tr>
			<tr>
				<th>电子邮箱</th>
				<td><input class="easyui-textbox" name="email" data-options="height:24,width:160, required:true,validType:'email'"/></td>
				<th>出生日期</th>
				<td><input class="easyui-datebox" name="birthday" data-options="height:24,width:160, required:true,editable:false"/></td>
			</tr>
		</table>
	</form>
</div>