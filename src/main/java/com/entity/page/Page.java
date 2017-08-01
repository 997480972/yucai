package com.entity.page;

/**
 * 页面模型
 * <br>封装了DataGrid 所需要的一些参数
 * <br>page 页码
 * <br>rows 页记录数
 * <br>sort 排序字段
 * <br>order 升序(asc)/降序(desc)
 * @author Administrator
 *
 */
public class Page {

	private int page = 1;
	private int rows = 10;
	private String sort = "id";
	private String order = "asc";
	
	public int getPage() {
		//
		return (page - 1) * rows;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
}
