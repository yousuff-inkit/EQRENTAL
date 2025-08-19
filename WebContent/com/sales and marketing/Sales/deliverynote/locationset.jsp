 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>

<%        
//System.out.println("Location innnnnnnnn====");
      

	 String pass_wordss=request.getParameter("pass_wordss")==null?"0":request.getParameter("pass_wordss");
 
	   
		String location="",docno="";


 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	String brhid = session.getAttribute("BRANCHID").toString(); 
	//System.out.println("brnch===="+brhid);
	
	
	String strSql = "select m.doc_no,loc_name as location,branchname as branch from my_locm m left join my_brch b on(b.doc_no=m.brhid) where m.status=3 and brhid="+brhid+"  group by m.brhid order by m.doc_no asc";
	
	System.out.println("--locatioset--"+strSql);
	
	ResultSet rs = stmt.executeQuery(strSql);
	int userid=0;
	while(rs.next ()) {
		docno=rs.getString("doc_no");
		location=rs.getString("location");
		 
	}
	
	
	
	
	
	stmt.close();
	conn.close();

	response.getWriter().print(docno+"::"+location);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>