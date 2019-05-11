﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%><%-- 导入java.sql.ResultSet类 --%>
<%-- 创建com.tools.ConnDB类的对象 --%>
<jsp:useBean id="conn" scope="page" class="com.tools.ConnDB" />	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>51商城</title>
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
			<div id="mr-content"
				class="mr-content col-xs-12 col-sm-12 col-md-9 col-md-push-3">
				<div id="mrshop" class="mrshop common-home">
					<div class="container_oc">
						<div class="row">
							<div id="content_oc" class="col-sm-12 view-product">
								<!-- 根据商品ID获取并显示商品信息 -->
								<%
									int typeSystem = 0;//保存商品类型ID的变量
									int ID = Integer.parseInt(request.getParameter("ID"));//获取商品ID
									if (ID > 0) {
										ResultSet rs = conn.executeQuery("select ID,GoodsName,Introduce,nowprice,picture,price,typeID "
												+ "from tb_goods where ID=" + ID);//根据ID查询商品信息
										String goodsName = "";//保存商品名称的变量
										float nowprice = (float) 0.0;//保存商品现价的变量
										float price = (float) 0.0;//保存商品原价的变量
										String picture = "";//保存商品图片的变量
										String introduce = "";//保存商品描述的变量								
										if (rs.next()) {//如果找到对应的商品信息
											goodsName = rs.getString(2);//获取商品名称
											introduce = rs.getString(3);//获取商品描述
											nowprice = rs.getFloat(4);//获取商品现价
											picture = rs.getString(5);//获取商品图片
											price = rs.getFloat(6);//获取商品原价
											typeSystem = rs.getInt(7);//获取商品类别ID
										}
										conn.close();//关闭数据库连接
								%>
								<!-- 显示商品详细信息 -->
								<div class="row">
									<div class="col-xs-12 col-md-4 col-sm-4">
										<ul class="thumbnails" style="list-style: none">
											<li><a class="thumbnail" href="#"> <img src="../images/goods/<%=picture%>"></a></li>
										</ul>
									</div>
									<div class="col-xs-12 col-md-8 col-sm-8">
										<div style="margin-left: 30px; margin-top: 20px">
											<h1 class="product-title"><%=goodsName%></h1>
											<ul class="list-unstyled price"><li><h2><%=nowprice%>元</h2></li></ul>
											<ul class="list-unstyled price"><li>原价: <%=price%>元</li></ul>
											<div class="rating"><p>商城活动：全场满99包邮</p></div>
											<div id="product"><hr>
												<div class="form-group">
													<label class="control-label" for="shuliang"> 数量 </label>
													<input type="number" name="quantity" value="1" size="2"
														id="shuliang" class="form-control"> <br>
													<div class="btn-group">
														<button type="button" onclick="addCart()" class="btn btn-primary btn-primary">
															<i class="fa fa-shopping-cart"></i> 添加到购物车</button>
														<button type="button" id="button-wishlist" data-toggle="tooltip" class="btn"
														 title="收藏" data-original-title="收藏"> <i class="fa fa-heart"></i></button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<%
									} else {//获取到的ID不合法
										out.println("<script language='javascript'>alert('您的操作有误');window.location.href='index.jsp';</script>");
									}
								%>
								<!-- //显示商品详细信息 -->
								<!-- //根据商品ID获取并显示商品信息 -->
							</div>
						</div>
					</div>

				</div>
			</div>
			<!-- //页面主体内容 -->
		</div>
	</div>
	<script src="js/jquery.1.3.2.js" type="text/javascript"></script>
	<script type="text/javascript">
	function addCart() {
		var num = $('#shuliang').val();//获取输入的商品数量
		//验证输入的数量是否合法
		if (num < 1) {//如果输入的数量不合法
			alert('数量不能小于1！');
			return;
		}
		window.location.href = "cart_add.jsp?goodsID=<%=ID%>&num=" + num;//调用添加购物车页面，实现将该商品添加到购物车
		}
	</script>
</body>
</html>
