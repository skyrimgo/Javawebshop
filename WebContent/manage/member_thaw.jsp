<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="conn" scope="page" class="com.tools.ConnDB"/>
<jsp:include page="safe.jsp"/>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
<%
if(request.getParameter("ID")!=""){
	int ID=Integer.parseInt(request.getParameter("ID"));
	String sql="update tb_member set freeze=0 where ID="+ID;
	int ret=0;
	ret=conn.executeUpdate(sql);
	if (ret!=0){
		out.println("<script language='javascript'>alert('该会员信息已经被成功解冻！');window.location.href='membermanage.jsp';</script>");
		}else{
		out.println("<script language='javascript'>alert('操作失败！');window.location.href='membermanage.jsp';</script>");
	}
}
%>
</body>
</html>
