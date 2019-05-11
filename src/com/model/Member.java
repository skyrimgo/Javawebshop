package com.model;

import lombok.Getter;
import lombok.Setter;

/**
 * 会员对应的模型类，包括会员的各种属性
 */
@Setter
@Getter
public class Member {
	private Integer ID = Integer.valueOf("-1"); // 会员ID属性
	private String userName = ""; // 账户属性
	private String trueName = ""; // 真实姓名属性
	private String pwd = ""; 					// 密码属性
	private String city = ""; 					// 所在城市属性
	private String address = ""; 				// 地址属性
	private String postcode = ""; 				// 邮编属性
	private String cardNO = ""; // 证件号码属性
	private String cardType = ""; // 证件类型属性
	private String tel = ""; 					// 联系电话属性
	private String email = ""; 					// 邮箱属性
	private String newPwd = "";					// 新密码
	
}
