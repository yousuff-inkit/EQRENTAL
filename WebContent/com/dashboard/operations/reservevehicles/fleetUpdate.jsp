<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<% 

ClsConnection connDAO = new ClsConnection();
ClsCommon commonDAO= new ClsCommon();
Connection conn=null;
String masterrefno=request.getParameter("masterrefno")==null?"":request.getParameter("masterrefno");
String detailrefno=request.getParameter("detailrefno")==null?"":request.getParameter("detailrefno");
String fleetid=request.getParameter("fleets")==null?"":request.getParameter("fleets");
Integer userid=(Integer) session.getAttribute("USERID");
int errorstatus=0; 
String[] fleet=fleetid.split(",");
int outqty=fleet.length;
int xoutqty=outqty;

try{
	 conn=connDAO.getMyConnection();
	 conn.setAutoCommit(false);
	 	
		Statement stmt = conn.createStatement ();
		Statement stmt1 = conn.createStatement ();
		
		String outsql="select outqty+"+outqty+" as outqty,qty from gl_masterlagd where doc_no="+detailrefno+"";
		System.out.println("QRY-0- :"+outsql);
		ResultSet rs=stmt1.executeQuery(outsql);
		while(rs.next()){
			outqty=rs.getInt("outqty");
		}
		
		String vehupSql = "update gl_vehmaster set tran_code='BL',fstatus='L' where fleet_no in("+fleetid+")";
		System.out.println("QRY-1- :"+vehupSql);
		int val=stmt.executeUpdate(vehupSql);
		if(val>0){
			String mldSql = "update gl_masterlagd set outqty="+outqty+" where doc_no="+detailrefno+"";
			System.out.println("QRY-2- :"+mldSql);
			int val1=stmt.executeUpdate(mldSql);
			if(val1<1){
				errorstatus=1;
			}
		}
		stmt.close();
		
		Statement insstmt = conn.createStatement ();
		String insSql="insert into  gl_rsrveh(date, rdocno, fleetnos, outqty) values(curdate(),"+detailrefno+",'"+fleetid+"',"+xoutqty+")";
		System.out.println("QRY-3- :"+insSql);
		int val2=insstmt.executeUpdate(insSql);
		if(val2<1){
			errorstatus=1;
		}
		if(errorstatus!=1){
			conn.commit();
		}
}catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>