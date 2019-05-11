<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%> <%-- 导入java.sql.ResultSet类 --%>	
<%@ page import="java.util.Vector"%> <%-- 导入Java的向量类 --%>
<%@ page import="com.model.Goodselement"%> <%-- 导入购物车商品模型类 --%>
<jsp:useBean id="conn" scope="page" class="com.tools.ConnDB"/> <%-- 创建ConnDB类的对象 --%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String username=(String)session.getAttribute("username");//获取会员账号
	String num = (String) request.getParameter("num");//获取商品数量
	//如果没有登录，将跳转到登录页面
	if (username == null || username == "") {
		response.sendRedirect("login.jsp");//重定向页面到会员登录页面
		return;//返回
	}

	int ID = Integer.parseInt(request.getParameter("goodsID"));//获取商品ID
	String sql = "select * from tb_goods where ID=" + ID;//定义根据商品ID查询商品信息的SQL语句
	ResultSet rs = conn.executeQuery(sql);//根据商品ID查询商品
	float nowprice = 0;//定义保存商品价格的变量
	if (rs.next()) {//如果查询到指定商品
		nowprice = rs.getFloat("nowprice");//获取该商品的价格
	}
	Goodselement mygoodselement = new Goodselement();//创建保存购物车内商品信息的模型类的对象mygoodselement
	mygoodselement.ID = ID;//将商品ID保存到mygoodselement对象中
	mygoodselement.nowprice = nowprice;//将商品价格保存到mygoodselement对象中
	mygoodselement.number = Integer.parseInt(num);//将购买数量保存到mygoodselement对象中
	boolean Flag = true;//记录购物车内是否已经存在所要添加的商品
	Vector cart = (Vector) session.getAttribute("cart");//获取购物车对象
	if (cart == null) {//如果购物车对象为空
		cart = new Vector();//创建一个购物车对象
	} else {
		//判断购物车内是否已经存在所购买的商品
		for (int i = 0; i < cart.size(); i++) {
			Goodselement goodsitem = (Goodselement) cart.elementAt(i);//获取购物车内的一个商品
			if (goodsitem.ID == mygoodselement.ID) {//如果当前要添加的商品已经在购物车中
				goodsitem.number = goodsitem.number + mygoodselement.number;//直接改变购物数量
				cart.setElementAt(goodsitem, i);//重新保存到购物车中
				Flag = false;//设置标记变量Flag为false，代表购物车中存在该商品
			}
		}
	}
	if (Flag)//如果购物车内不存在该商品
		cart.addElement(mygoodselement);//将要购买的商品保存到购物车中
	session.setAttribute("cart", cart);//将购物车对象添加到Session中
	conn.close();//关闭数据库的连接
	response.sendRedirect("cart_see.jsp");//重定向页面到查看购物车页面
%>
</body>
</html>