<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Magmise's Notice Board Page</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해야 게시글을 작성할 수 있습니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} 
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("<alert('유효하지 않은 글입니다.')>");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("<alert('권한이 없습니다.')>");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		} else {
			if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null || request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('제목 또는 내용을 작성해야 합니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
					if (result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('알 수 없는 이유로 게시글 수정에 실패했습니다. 관리자에게 문의하세요.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'bbs.jsp'");
						script.println("</script>");
					}				
				}
		}
	%>
</body>
</html>