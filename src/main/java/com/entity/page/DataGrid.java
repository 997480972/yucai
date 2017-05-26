package com.entity.page;

import java.util.List;

/**
 * DataGrid 组件
 * @author Administrator
 *
 * @param <T>
 */
public class DataGrid<T> {

	private Integer total = 0;
	private List<T> rows;
	
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public List<T> getRows() {
		return rows;
	}
	public void setRows(List<T> rows) {
		this.rows = rows;
	}
}
