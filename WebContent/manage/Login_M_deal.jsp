<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="chStr" scope="page" class="com.tools.ChStr"/>
<jsp:useBean id="conn" scope="page" class="com.tools.ConnDB"/>
<%
String manager=chStr.chStr(request.getParameter("manager"));//此处必须进行编码转换，否则输入中文用户名时将出现乱码
try{
	ResultSet rs=conn.executeQuery("select * from tb_manager where manager='"+manager+"'");
	if(rs.next()){
		String PWD=request.getParameter("PWD");
		if(PWD.equals(rs.getString("PWD"))){
			session.setAttribute("manager",manager);
			response.sendRedirect("index.jsp");
		}else{
			out.println("<script language='javascript'>alert('您输入的管理员或密码错误!');window.location.href='../index.jsp';</script>");
		}
	}else{
			out.println("<script language='javascript'>alert('您输入的管理员或密码错误!');window.location.href='../index.jsp';</script>");
	}
}catch(Exception e){
	out.println("<script language='javascript'>alert('您的操作有误!');window.location.href='../index.jsp';</script>");
}
%>
