<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%><%-- 导入java.sql.ResultSet类 --%>
<%@ page import="java.util.Vector"%><%-- 导入Java的向量类 --%>
<%@ page import="java.text.DecimalFormat"%><%-- 导入格式化数字的类 --%>
<%@ page import="com.model.Goodselement"%><%-- 导入购物车商品的模型类 --%>
<%-- 创建com.tools.ConnDB类的对象 --%>
<jsp:useBean id="conn" scope="page" class="com.tools.ConnDB" />
<%
	String username = (String) session.getAttribute("username");//获取会员账号
	//如果没有登录，将跳转到登录页面
	if (username == "" || username == null) {
		response.sendRedirect("login.jsp");//重定向页面到会员登录页面
		return;//返回
	} else {	
		Vector cart = (Vector) session.getAttribute("cart");//获取购物车对象
		if (cart == null || cart.size() == 0) {//如果购物车为空
			response.sendRedirect("cart_null.jsp");//重定向页面到购物车为空页面
		} else {
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>我的购物车</title>
<link rel="stylesheet" href="css/mr-01.css" type="text/css">

<script src="js/jsArr01.js" type="text/javascript"></script>
<script src="js/module.js" type="text/javascript"></script>
<script src="js/jsArr02.js" type="text/javascript"></script>
<script src="js/tab.js" type="text/javascript"></script>
<script src="js/beauty.js" type="text/javascript"></script>

</head>

<body>
	<jsp:include page="index-loginCon.jsp" />
	<!-- 网站头部 -->
	<%@ include file="common-header.jsp"%>
	<!-- //网站头部 -->
	<div id="mr-mainbody" class="container mr-mainbody">
		<div class="row">
			<!-- 页面主体内容 -->
			<div id="mr-content" class="mr-content col-xs-12">
				<div id="mrshop" class="mrshop common-home">
					<div class="container_oc">
						<div class="row">
							<div id="content_oc" class="col-sm-12">
								<h1>我的购物车</h1>
								<!-- 显示购物车中的商品 -->
								<div class="table-responsive cart-info">
									<table class="table table-bordered">
										<thead>
											<tr>
												<td class="text-center image">商品图片</td>
												<td class="text-left name">商品名称</td>
												<td class="text-left quantity">数量</td>
												<td class="text-right price">单价</td>
												<td class="text-right total">总计</td>
											</tr>
										</thead>
										<tbody>
										<!-- 遍历购物车中的商品并显示 -->
											<%
												float sum = 0;
												DecimalFormat fnum = new DecimalFormat("#,##0.0");//定义显示金额的格式
												int ID = -1;//保存商品ID的变量
												String goodsname = "";//保存商品名称的变量
												String picture = "";//保存商品图片的变量
												//遍历购物车中的商品
												for (int i = 0; i < cart.size(); i++) {
													Goodselement goodsitem = (Goodselement) cart.elementAt(i);//获取一个商品
													sum = sum + goodsitem.number * goodsitem.nowprice;//计算总计金额
													ID = goodsitem.ID;//获取商品ID
													if (ID > 0) {
														ResultSet rs_goods = conn.executeQuery("select * from tb_goods where ID=" + ID);
														if (rs_goods.next()) {
															goodsname = rs_goods.getString("goodsname");//获取商品名称
															picture = rs_goods.getString("picture");//获取商品图片
														}
														conn.close();//关闭数据库的连接
													}
											%>
											<!-- 显示一条商品信息 -->
											<tr>
												<td class="text-center image" width="20%"><a href="goodsDetail.jsp?ID=<%=goodsitem.ID%>">
													<img width="80px" src="../images/goods/<%=picture%>"> </a></td>
												<td class="text-left name"><a
													href="goodsDetail.jsp?ID=<%=goodsitem.ID%>"> <%=goodsname%></a>
												</td>
												<td class="text-left quantity"><%=goodsitem.number%>件</td>
												<td class="text-right price"><%=goodsitem.nowprice%>元</td>
												<td class="text-right total"><%=(goodsitem.nowprice * goodsitem.number)%>元
												</td>
											</tr>
											<%
												}
												String sumString = fnum.format(sum);//格式化总计金额
											%>
										</tbody>
									</table>
								</div>
								<div class="row cart-total">
									<div class="col-sm-4 col-sm-offset-8">
										<table class="table table-bordered">
											<tbody>
												<tr >
												<span>
													<strong>总计:</strong>
													<p><%=sumString%>元</p>
												</span>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<!-- //显示总计金额  -->
							</div>
						</div>

						<!-- 填写物流信息 -->
						<div class="row">
							<div id="content_oc" class="col-sm-12">																
						<br />
						<!-- 显示支付方式 -->
						<div class="row">
							<div id="content_oc" class="col-sm-12">				
								<br /> <br />
								<div class="buttons">
									<div class="pull-left">
										<a href="index.jsp" class="btn btn-primary btn-default">继续购物</a>
									</div>
									<div class="pull-left">
										<a href="cart_clear.jsp" class="btn btn-primary btn-default">清空购物车</a>
									</div>
									<div class="pull-right">
										<a href="javascript:zhifu();" class="tigger btn btn-primary btn-primary">结账</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- 使用jBox插件实现一个支付对话框 -->
	<script type="text/javascript" src="js/jBox/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="js/jBox/jquery.jBox-2.3.min.js"></script>
	<link type="text/css" rel="stylesheet" href="js/jBox/Skins2/Green/jbox.css" />
	<script type="text/javascript">
		function zhifu() {		
			var html_success =	'<div class="popup_cont">'+'<p><h1>支付成功</h1></p>';	
			var html_failed =	'<div class="popup_cont">'+'<p>支付失败，用户余额不足</p>';	
			var content = {
				state1 : {
					content : html_success				
				}
			};
			$.jBox.open(content, '支付信息', 500, 500);//打开支付窗口
		}
	</script>
</body>
</html>
<%	}
		}
%>
