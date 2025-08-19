<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="java.sql.Connection"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="com.common.*"%>

<%
Connection conn=null ;
try{
	String acno = request.getParameter("accountno").toString();
	int trno = 0;
	ArrayList<Integer> arrTrno=new ArrayList<Integer>();

	ClsConnection connection = new ClsConnection();
	conn = connection.getMyConnection();
	Statement stmt = conn.createStatement();

	String sql = "select * from my_jvtran where status=7 and acno=" + acno;
	ResultSet rs = stmt.executeQuery(sql);
	while (rs.next()) {
		arrTrno.add(rs.getInt("tr_no"));
	}

	ClsApplyDelete appDel = new ClsApplyDelete();
	for(int i=0;i<=arrTrno.size()-1;i++){
		System.out.println("=== trno ==== "+arrTrno.get(i));
		appDel.getFinanceApplyDelete(conn, arrTrno.get(i));
	}
	conn.close();
}
catch(Exception e){
	conn.close();
	e.printStackTrace();
}
%>
