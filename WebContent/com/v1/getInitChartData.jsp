<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="com.dashboard.*"%>
<%
	ClsDashBoardNewDAO dao=new ClsDashBoardNewDAO();
	JSONObject data=dao.getFleetSalesChartData();
	JSONObject fleetdistdata=dao.getFleetDistChartData();
	System.out.println(data+"***"+fleetdistdata);
	response.getWriter().write(data+"***"+fleetdistdata);
%>