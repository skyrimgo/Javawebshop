<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%><%-- 导入java.sql.ResultSet类 --%>
<%-- 创建com.tools.ConnDB类的对象 --%>
<jsp:useBean id="conn" scope="page" class="com.tools.ConnDB" />
<%
	String type = request.getParameter("type");
	String typeName = "";
	if (type.equals("14")) {
		typeName = "图书类";
	}
	if (type.equals("15")) {
		typeName = "家电类";
	}
	if (type.equals("16")) {
		typeName = "服装类";
	}
	if (type.equals("17")) {
		typeName = "电子类";
	}

	ResultSet rs = conn
			.executeQuery("select * from tb_goods t1,tb_subType t2 where t1.typeID=t2.ID and t2.superType="
					+ Integer.parseInt(type) + " order by INTime Desc");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>图书列表-51商城</title>
<link rel="stylesheet" href="css/mr-01.css" type="text/css">

<script src="js/jsArr01.js" type="text/javascript"></script>
<script src="js/module.js" type="text/javascript"></script>
<script src="js/jsArr02.js" type="text/javascript"></script>
<script src="js/tab.js" type="text/javascript"></script>
</head>

<body>
	<jsp:include page="index-loginCon.jsp" />
	<!-- 网站头部 -->
	<%@ include file="common-header.jsp"%>
	<!-- //网站头部 -->
	<div id="mr-mainbody" class="container mr-mainbody">
		<div class="row">
			<!-- //分页显示图书列表 -->
			<div id="mr-content"
				class="mr-content col-xs-12 col-sm-12 col-md-9 col-md-push-3">

				<div id="system-message-container" style="display: none;"></div>

				<div id="mrshop" class="mrshop common-home">
					<div class="container_oc">
						<ul class="breadcrumb">
						</ul>
						<div class="row">
							<div id="content_oc" class="col-sm-12">
								<div class="box_oc">
									<div class="box-heading">
										<h1 class="mrshop_heading_h1"><%=typeName%></h1>
									</div>
									<div class="box-content">
										<hr>
										<div class="row">
											<%
												String str = (String) request.getParameter("Page");
												if (str == null) {
													str = "0";
												}
												int pagesize = 12;
												rs.last();
												int RecordCount = rs.getRow();
												int maxPage = 0;
												maxPage = (RecordCount % pagesize == 0) ? (RecordCount / pagesize) : (RecordCount / pagesize + 1);

												int Page = Integer.parseInt(str);
												if (Page < 1) {
													Page = 1;
												} else {
													if (Page > maxPage) {
														Page = maxPage;
													}
												}
												rs.absolute((Page - 1) * pagesize + 1);
												for (int i = 1; i <= pagesize; i++) {
													int ID = rs.getInt("ID");
													String goodsName = rs.getString("goodsName");
													String introduce = rs.getString("introduce");
													String picture = rs.getString("picture");
													String TypeName = rs.getString("TypeName");
													float nowPrice = rs.getFloat("nowPrice");
													String newgoods = rs.getInt("newgoods") == 0 ? "否" : "是";
													String sale = rs.getInt("sale") == 0 ? "否" : "是";
											%>

											<div
												class="product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-12">
												<div class="product-thumb">
													<div class="actions">
														<div class="image">
															<a style="width: 95%" href="goodsDetail.jsp?ID=<%=ID%> "><img
																src="../images/goods/<%=picture%>"
																class="img-responsive"> </a>
														</div>
														<div class="button-group btn-grid">
															<div class="cart">
																<button class="btn btn-primary btn-primary"
																	type="button" data-toggle="tooltip"
																	onclick='javascript:window.location.href="cart_add.jsp?goodsID=<%=ID%>&num=1"; '
																	style="display: none; width: 33.3333%;"
																	data-original-title="添加到购物车">
																	<i class="fa fa-shopping-cart"></i>
																</button>
															</div>
															<div class="wishlist">
																<button class="btn" type="button" data-toggle="tooltip"
																	title="收藏">
																	<i class="fa fa-heart"></i>
																</button>
															</div>
														</div>
													</div>
													<div>
														<div class="caption">
															<div class="name">
																<a href="goodsDetail.jsp?ID=<%=ID%>" style="width: 95%">
																	<span style="color: #0885B1">名称：</span><%=goodsName%></a>
															</div>

															<p class="price">
																<span class="price-new">分类：</span> <span><%=TypeName%></span>
																<span class="price-tax">价格: <%=nowPrice%>元
																</span>
															</p>
														</div>

													</div>
												</div>
											</div>
											<%
												try {
														if (!rs.next()) {
															break;
														}
													} catch (Exception e) {
													}
												}
											%>
										</div>
										<div class="row pagination">
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td height="30" align="right">当前页数：[<%=Page%>/<%=maxPage%>]&nbsp;
														<%
															if (Page > 1) {
														%> <a href="goodsList.jsp?Page=1&type=<%=type%>">第一页</a> <a
														href="goodsList.jsp?Page=<%=Page - 1%>&type=<%=type%>">上一页</a>
														<%
															}
															if (Page < maxPage) {
														%> <a
														href="goodsList.jsp?Page=<%=Page + 1%>&type=<%=type%>">下一页</a>
														<a href="goodsList.jsp?Page=<%=maxPage%>&type=<%=type%>">最后一页&nbsp;</a>
														<%
															}
														%>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- //分页显示图书列表 -->
		</div>
	</div>

</body>
</html>