package com.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Goods {// 定义一个实体对象

	private Integer ID = Integer.getInteger("-1");// 定义一个数字型变量
	private int typeID = -1;// 定义一个数字型变量，下同
	private String goodsName = "";// 定义一个字符型变量，下同
	private String introduce = "";
	private float price = 0f;// 定义一个浮点型变量，下同
	private float nowPrice = 0f;
	private String picture = "";
	private int newGoods = -1;
	private int sale = -1;

	public void goods() {
	}
}
