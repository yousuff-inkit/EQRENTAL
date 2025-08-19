<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="com.dashboard.*"%>
<%
	String basedate=request.getParameter("basedate")==null?"":request.getParameter("basedate");
	String detailtype=request.getParameter("detailtype")==null?"":request.getParameter("detailtype");
	//System.out.println("Passed Date:"+basedate);
	ClsDashBoardNewDAO dao=new ClsDashBoardNewDAO();
	JSONObject data=new JSONObject();
	if(detailtype.equalsIgnoreCase("Brand")){
		data=dao.getBrandwiseFleetSales(basedate);
	}
	else{
		data=dao.getModelwiseFleetSales(basedate);
	}
	response.getWriter().write(data+"");
%>