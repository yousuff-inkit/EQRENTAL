<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
	 	conn.setAutoCommit(false); 	
	 	Statement stmt = conn.createStatement();
		Statement stmtbatch = conn.createStatement();
 		String dbname=request.getParameter("dbname");
 		String reqtable=request.getParameter("reqtable");
 
 		
		String sql=null,truncatesql="" ;
		int val=0;
	
		 /*Privilage Approval */
    	 sql="SELECT table_name  FROM information_schema.`TABLES` t where t.table_name not in ("+reqtable+") and table_schema ='"+dbname+"' ";
     	System.out.println(sql);
		 ResultSet rstable=stmt.executeQuery(sql);
     	 while(rstable.next()){
     		stmtbatch.addBatch("truncate table "+dbname+"."+rstable.getString("table_name")+" ;") 	  ;
     	 }
     	int[] res=stmtbatch.executeBatch();
     	stmtbatch.executeUpdate(" delete from "+dbname+".my_head where den=340 and m_s=0; ");
     	stmtbatch.executeUpdate(" delete from "+dbname+".my_head where den=255 and m_s=0; ");
     	stmtbatch.executeUpdate(" delete from "+dbname+".my_head where den=301 and m_s=0; "); 
     	stmtbatch.executeUpdate(" delete from "+dbname+".my_user where user_id not in ('super','admin')");
     	stmtbatch.executeUpdate(" update "+dbname+".my_user set pass='bJxMVRHdshnTOwtc1s5PYA=='");
		System.out.println(stmtbatch);
     	int data= 0;
     	
     	  
		
		/*     	 
		stmtbatch.executeUpdate("update "+dbname+".my_head set olddocno=doc_no") ;
		stmtbatch.executeUpdate("ALTER TABLE "+dbname+".my_head DROP INDEX `Index_2`") ;
		stmtbatch.executeUpdate("update "+dbname+".my_head b,(select  @i:=1000) a set b.doc_no=@i:=@i+1,b.account=@i:=@i where b.doc_no!=@i;;") ;
		stmtbatch.executeUpdate("ALTER TABLE "+dbname+".`my_head` ADD UNIQUE INDEX `Index_2`(`atype`, `Account`);") ;
		stmtbatch.executeUpdate("update "+dbname+".my_head h set h.grpno=0,h.alevel=concat('.',h.doc_no)  where h.m_s =1");
		stmtbatch.executeUpdate("update "+dbname+".my_head h inner join "+dbname+".my_head h1 on h.grpno=h1.olddocno set h.grpno=h1.doc_no,h.alevel=concat('.',h1.doc_no,'.',h.doc_no) where h.m_s =0") ;
		stmtbatch.executeUpdate("update  "+dbname+".my_account a inner join  "+dbname+".my_head h on a.acno=h.olddocno set a.acno=h.doc_no ;");
		stmtbatch.executeUpdate("update  "+dbname+".my_cardm a inner join  "+dbname+".my_head h on a.acno=h.olddocno set a.acno=h.doc_no ;");
		stmtbatch.executeUpdate("update  "+dbname+".gl_invmode a inner join  "+dbname+".my_head h on a.acno=h.olddocno set a.acno=h.doc_no ;");
		//stmtbatch.executeUpdate("update  "+dbname+".my_issuetype a inner join  "+dbname+".my_head h on a.acno=h.olddocno set a.acno=h.doc_no ;");
		System.out.println(stmtbatch);
		// int[] res=stmtbatch.executeBatch();	
		*/
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select * from "+dbname+".my_head");
		ResultSetMetaData rsmd = rs.getMetaData();
		int columnsNumber = rsmd.getColumnCount();                     
		while (rs.next()) {
		for(int i = 1 ; i <= columnsNumber; i++){
		 //     System.out.print(rs.getString(i) + " "); //Print one element of a row
		}

  System.out.println();//Move to the next line to print the next row.           

    }

		
	
     response.getWriter().print(data);
		conn.commit();
	 	stmt.close();
	 	stmtbatch.close();
	 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	response.getWriter().print(0);
	 	conn.close();
   }finally{
	   conn.close();
   }
	
%>
