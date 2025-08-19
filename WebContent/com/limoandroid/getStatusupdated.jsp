
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>


<%

System.out.println("in status update");
	
	
	ClsConnection  ClsConnection=new ClsConnection();
		
	String stat=request.getParameter("stat");
	String jobno=request.getParameter("jobno")==""?"0":request.getParameter("jobno").trim();
	String bookdocno=jobno.split("-")[0];
	String jobname=jobno.split("-")[1];
	
	
	
	System.out.println(stat+"::"+jobno);
	
	Connection conn=null;
	
	int i=0;
	String doc="";
	String msg="";
	
	try
	{
		conn=ClsConnection.getMyConnection();
		Statement st=conn.createStatement();
		conn.setAutoCommit(false);
		
		String sql="update gl_limomanagement set bstatus="+stat+" where docno="+bookdocno+" and job='"+jobname+"'";
		int val=st.executeUpdate(sql);
			
			if(val>0)
			{
				
				msg="1";
				 conn.commit();
				System.out.println("msg:"+msg);
				 
			}
			else
			{
				msg="0";
			}

	}
	catch(Exception e)
	{
		e.printStackTrace();
		
	}
	
	finally
	{
		conn.close();
	}
	response.getWriter().write(msg);
%>