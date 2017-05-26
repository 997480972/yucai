<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var sys_sysUser_datagrid;
	$(function(){
		//初始化datagrid
		sys_sysUser_datagrid = $('#sys_sysUser_datagrid').datagrid({
			title: '用户列表',
			iconCls: 'icon-man',
			url: '${pageContext.request.contextPath }/sys/user',
			//默认是POST请求方式
			method: 'get',
			idField: 'id',
			fit: true,
			fitColumns:true,
			border:false,
			striped: true,
			/*
			 * pagination, 显示分页栏
			 * pageSize, 页记录数, 默认值 10
			 * pageList, 页记录数选择值, 默认值 [10, 20, 30, 40, 50]
			 */
			pagination: true,
			//pageSize: 10,
			//pageList: [10, 20, 30, 40, 50],
			
			/*
			 * 排序；
			 * sortName, 指定排序字段
			 * sortOrder, 指定升序(asc)或降序(desc), 默认升序.
			 */
			sortName: 'account',
			sortOrder: 'asc',
			checkOnSelect: false,
			selectOnCheck: true,
			columns: [[
			    /*
			     * field, 与JavaBean的属性对应
			     * checkbox, 每行前面显示复选框, 一般在主键字段的列上设置
			     * sortable, 指定该列可以排序
			     * formatter, 对列进行格式化
			     */
			    {field:'id',title:'编号',width:30,checkbox:true},
			    {field:'account',title:'账号',width:100,sortable:true},
			    {field:'name',title:'姓名',width:60,sortable:true},
			    {field:'gender',title:'性别',width:30,sortable:true,
			    	formatter: function(value,row,index){
			    		return value == 'M' ? '男' : '女';
			    	}},
			    {field:'birthday',title:'出生日期',width:60,sortable:true},
			    {field:'email',title:'电子邮箱',width:100},
			    {field:'create_datetime',title:'创建时间',width:100,sortable:true},
			    {field:'modify_datetime',title:'最后修改时间',width:100,sortable:true,
			    	//title提示
			    	formatter: function(value,row,index){
			    		return '<span title="'+value+'">'+value+'</span>';
			    	}},
			]],
			//操作工具栏
			toolbar: [{
				text: '增加',
				iconCls: 'icon-add',
				handler: function(){
					addSysUser();
				}
			}, {
				text: '编辑',
				iconCls: 'icon-edit',
				handler: function(){
					editSysUser();
				}
			}, '-', {
				text: '删除',
				iconCls: 'icon-remove',
				handler: function(){
					removeSysUser();
				}
			}]
		});
		
		//条件查询
		$('#sys_sysUser_datagrid_searchBtn').click(function(){
			//serializeObject, 将form表单内容序列化为一个Object.
			sys_sysUser_datagrid.datagrid('load', $.serializeObject($('#sys_sysUser_searchForm')));
		});
		
		//清空查询条件, 重新加载datagrid
		$('#sys_sysUser_datagrid_clearBtn').click(function(){
			$('#sys_sysUser_searchForm input').val('');
			sys_sysUser_datagrid.datagrid('load', {});
		});
	});
	
	//新增用户
	function addSysUser(){
		/*
		 * 弹出 dialog 方式
		 * 1. Javascript动态创建 (推荐)
		 * 2. DOM节点元素标签创建, 缺点就是在页面加载就创建好了, 在IE下有闪烁的情况.
		 */
		//动态创建dialog
		var d = $('<div>').dialog({
			width: 600,
			height: 200,
			href: '${pageContext.request.contextPath }/sys/toAddUser',
			modal: true,
			title: '添加用户',
			iconCls: 'icon-edit',
			buttons: [{
				text: ' 保 存 ',
				iconCls: 'icon-save',
				handler: function(){
					//验证通过则提交表单
					if($('#sys_sysUser_add_dialog_form').form('validate')){
						//开启进度条
						parent.$.messager.progress({
							title : '提示',
							text : '数据处理中,请稍后......'
						});
						/*
						 * jQuery EasyUI 提交表单方式
						 * 1. 自带 form 提交方式
						 * 2. jQuery方式提交表单
						 */
						//jQuery方式提交表单
						$.ajax({
							type: 'POST',
							url: '${pageContext.request.contextPath}/sys/user',
							data: $('#sys_sysUser_add_dialog_form').serialize(),
							success: function(data){
								if(data.success){
									//添加成功, 刷新datagrid. 数据量不大可以使用.
									//$('#sys_sysUser_datagrid').datagrid('load');
									//在datagrid的第1行插入新增的数据, 比load 方式少查询一次数据库.
									$('#sys_sysUser_datagrid').datagrid('insertRow',{
										index: 0,
										row: data.object
									});
									
									//关闭dialog
									d.dialog('destroy');
									//弹出提示信息
									$.messager.show({
										title: '系统提示',
										msg: data.content
									});
									//关闭进度条
									parent.$.messager.progress('close');
								}
							}
						});
					}
				}
			}],
			//动态创建dialog, 必须要调用onClose事件来销毁, 否则页面会一直增加DOM元素, 可能导致页面崩溃.
			onClose: function(){
				$(this).dialog('destroy');
			}
		});
	}
	
	//编辑用户
	function editSysUser(){
		var rows = $('#sys_sysUser_datagrid').datagrid('getChecked');
		if(rows.length == 1){
			var d = $('<div>').dialog({
				width: 600,
				height: 200,
				href: '${pageContext.request.contextPath }/sys/toEditUser',
				modal: true,
				title: '编辑用户',
				iconCls: 'icon-edit',
				buttons: [{
					text: '保 存',
					iconCls: 'icon-save',
					handler: function(){
						if($('#sys_sysUser_edit_dialog_form').form('validate')){
							parent.$.messager.progress({
								title : '系统提示',
								text : '数据处理中,请稍后......'
							});
							$.post('${pageContext.request.contextPath }/sys/user',
								    $('#sys_sysUser_edit_dialog_form').serialize() + '&_method=PUT',
									function(r){
										if(r.success){
											d.dialog('close');
											$('#sys_sysUser_datagrid').datagrid('reload');
										}
										$.messager.show({
											title: '系统提示',
											msg: r.content
										});
										parent.$.messager.progress('close');
									}
							);
						}
					}
				}],
				onLoad: function(){
					$('#sys_sysUser_edit_dialog_form').form('load', rows[0]);
				},
				onClose: function(){
					$(this).dialog('destroy');
				}
			});
		}else{
			$.messager.alert('系统提示','请勾选一项进行操作!','info');
		}
	}
	
	//删除用户
	function removeSysUser(){
		var ids = [];
		var rows = $('#sys_sysUser_datagrid').datagrid('getChecked');
		if(rows.length > 0){
			$.messager.confirm('系统提示', '您确认要删除选中的数据?', function(r){
				if (r){
					for(var i = 0; i < rows.length; i++){
						ids.push(rows[i].id);
					}
					$.post('${pageContext.request.contextPath }/sys/user/' + ids.join(','),
							{_method: 'DELETE'},
							function(data){
								if(data.success){
									$('#sys_sysUser_datagrid').datagrid('load');
									$('#sys_sysUser_datagrid').datagrid('unselectAll');
									$.messager.show({
										title: '系统提示',
										msg: data.content
									});
								}
							}
					);
				}
			});
		}else{
			$.messager.alert('系统提示','至少要勾选一项进行操作!','info');
		}
	}
</script>
<div class="easyui-layout" data-options="fit : true,border : false,collapsed:true">
	<div data-options="region:'north',title:'查询条件',iconCls:'icon-filter',border:false" style="height: 145px;overflow: hidden;">
		<form id="sys_sysUser_searchForm" method="post">
			<div align="center">
			<table class="dialog-table" style="width:95%">
				<tr>
					<th>用户名</th>
					<td><input class="easyui-textbox" name="name" data-options="height:24,width:160"/></td>
					<th>创建时间</th>
					<td>
						<input class="easyui-datetimebox" name="minCreateDateTime" data-options="height:24,width:160,editable:false"/>
						<input class="easyui-datetimebox" name="maxCreateDateTime" data-options="height:24,width:160,editable:false"/>
					</td>
				</tr>
				<tr>
					<th>性别</th>
					<td>
						<select class="easyui-combobox" data-options="height:24,width:160"  name="gender">
						    <option value=""></option>
						    <option value="M">男</option>   
						    <option value="F">女</option>  
						</select>
					</td>
					<th>最后修改间</th>
					<td>
						<input class="easyui-datetimebox" name="minModifyDateTime" data-options="height:24,width:160,editable:false"/>
						<input class="easyui-datetimebox" name="maxModifyDateTime" data-options="height:24,width:160,editable:false"/>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<a id="sys_sysUser_datagrid_searchBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"> 查 询 </a>&nbsp;&nbsp;  
						<a id="sys_sysUser_datagrid_clearBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear',plain:true"> 清 空 </a> 
					</td>
				</tr>
			</table>
			</div>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table id="sys_sysUser_datagrid"></table>
	</div>
</div>


