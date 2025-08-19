<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="java.sql.Connection"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="com.common.*"%>

<%
Connection conn=null ;
try{
	//String acno = request.getParameter("accountno").toString();
	int trno = 0;
	ArrayList<Integer> arrTrno=new ArrayList<Integer>();

	ClsConnection connection = new ClsConnection();
	conn = connection.getMyConnection();
	System.out.println("=== trno ==== "+conn);
	int[] arraytrno= new int[]{4680,4695,4725,4969,4988,4996,4997,5004,5005,5008,5012,5013,5015,5016,5017,5019,5020,5022,5023,5024,5026,5027,5029,5030,5033,5035,5040,5042,5044,5045,5046,5048,5050,5051,5053,5055,5056,5058,5059,5060,5065,5066,5067};
	for (int i = 0; i < arraytrno.length; i++)
		arrTrno.add(arraytrno[i]);
	
	System.out.println("=== trno ==== "+arrTrno);
	ClsApplyDelete appDel = new ClsApplyDelete();
	for(int i=0;i<=arrTrno.size()-1;i++){
		System.out.println("=== trno ==== "+arrTrno.get(i));
		appDel.getFinanceApplyDelete(conn, arrTrno.get(i));
	}
	conn.close();
}
catch(Exception e){

	e.printStackTrace();
	conn.close();
}
%>
