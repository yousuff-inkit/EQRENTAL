<%@page import="com.dashboard.integration.airlineticketing.ClsAirlineTicketingDAO"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsAirlineTicketingDAO dao=new ClsAirlineTicketingDAO();
int value=0;
try{
	value=dao.downloadData(session);
}
catch(Exception e){
	e.printStackTrace();
}
response.getWriter().write(value+"");
%>
