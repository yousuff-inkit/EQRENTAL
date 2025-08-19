
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>


<%

System.out.println("Registration");
	
	
	ClsConnection  ClsConnection=new ClsConnection();
		
	String r=request.getParameter("rdocno");
	System.out.println(r);
	int rdocno=Integer.parseInt(request.getParameter("rdocno"));
	String hiduser=request.getParameter("hiduser");
	String userid=request.getParameter("userid");
	String remarks=request.getParameter("remarks");
	
	System.out.println(rdocno+"::"+hiduser+"::"+remarks);
	
	Connection conn=null;
	
	int i=0;
	String doc="";
	String msg="";
	
	try
	{
		conn=ClsConnection.getMyConnection();
		Statement st=conn.createStatement();
		conn.setAutoCommit(false);
		
			System.out.println("inside...........");
			CallableStatement stmt=conn.prepareCall("{call an_taskcreationdetsDML(?,?,?,?,?)}");
			stmt.registerOutParameter(5, java.sql.Types.INTEGER);
			stmt.setInt(1,rdocno);
			stmt.setString(2,hiduser);
			stmt.setString(3,remarks);
			stmt.setString(4,userid);
			stmt.executeUpdate();
			i=stmt.getInt("docno");
			if(i>0)
			{
				doc=Integer.toString(i);
				/* String str="update an_taskcreation set act_status='Assigned' where doc_no='"+rdocno+"' and act_status='Accepted'";
				int j=stmt.executeUpdate(str);
				 */
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