<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		
		String paytype=request.getParameter("paytype");
		String type=paytype.equalsIgnoreCase("1")?"rcash":paytype.equalsIgnoreCase("2")?"rcard":"rcheque";
		
		String strSql = "select t.doc_no,t.account,t.description from my_account a inner JOIN MY_HEAD t on a.acno=t.doc_no where codeno='"+type+"'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String acc="",accId="",docno="";
		while(rs.next()) {
					acc=rs.getString("description");
					accId=rs.getString("account");
					docno=rs.getString("doc_no");
				} 
		if(paytype.equalsIgnoreCase("4")){
			acc="";
			accId="";
			docno="";
		}
		response.getWriter().write(accId+"####"+acc+"####"+docno);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  