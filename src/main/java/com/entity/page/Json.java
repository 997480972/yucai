package com.entity.page;

/**
 * 页面消息模型
 * 添加，修改，删除操作后返回到页面的一个消息模型
 * JSON 格式返回到客户端
 * @author Administrator
 */
public class Json {
	//操作状态,成功: true, 失败: false
	private boolean success;
	//操作完成返回的提示信息
	private String content;
	//操作完成返回的对象
	private Object object;
	
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Object getObject() {
		return object;
	}
	public void setObject(Object object) {
		this.object = object;
	}	
}
