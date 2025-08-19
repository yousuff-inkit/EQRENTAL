
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>


<%

System.out.println("Take");
	
	
	ClsConnection  ClsConnection=new ClsConnection();
	ClsEncrypt objencrypt=new ClsEncrypt();
	Connection conn=null;
	
	String str1="";
	
	String user="";
	
	int j=0;
	int k=0;
	String doc="";
	String rdoc="";
	String msg="";
	//String rdoc=request.getParameter("doc");
	String arrayobj=request.getParameter("arrayobj");
	String type=request.getParameter("take");
	String userid=request.getParameter("userid");
	String fleet=request.getParameter("fleet");
	String reg=request.getParameter("regfleet");
	String details=request.getParameter("details");
	String inspectid=request.getParameter("selectdoc");
	System.out.println(reg+":"+arrayobj+":"+type+":"+userid+":"+details+":"+inspectid);
	conn=ClsConnection.getMyConnection();
	Statement st=conn.createStatement();
			
	String[] str =arrayobj.split(",");
	/* System.out.println("__"+str[0]); */
	try
	{
		
			CallableStatement stmt=conn.prepareCall("{call an_takehandDML(?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(7, java.sql.Types.INTEGER);
			stmt.setString(1,fleet);
			stmt.setString(2,reg);
			stmt.setString(3,details);
			stmt.setString(4,inspectid);
			stmt.setString(5,type);
			stmt.setString(6,userid);
			stmt.executeUpdate();
			k=stmt.getInt("docno");
			if(k>0)
			{
				rdoc=Integer.toString(k);
				msg="1";
				 
				
			}
			
	
			else
			{
				
				msg="0";
				//System.out.println("Incorrectusername...........");
			}

		
		
		System.out.println(rdoc);
		
		
		
		for (int i = 0; i < str.length; i++)
		{
			System.out.println("ll:"+str.length);
			String[] temp=str[i].split("::");
			String cnt=temp[0];
			String classname=temp[1];
			String pos=temp[2];
			//String posy=temp[3];
			String col=temp[3];
			
			
				
				System.out.println("inside...........");
					CallableStatement stmtt=conn.prepareCall("{call an_imgdetailsDML(?,?,?,?,?,?,?,?,?,?)}");
					stmtt.registerOutParameter(10, java.sql.Types.INTEGER);
					stmtt.setString(1,rdoc);
					stmtt.setString(2,fleet);
					stmtt.setString(3,reg);
					stmtt.setString(4,cnt);
					stmtt.setString(5,classname);
					stmtt.setString(6,pos);
					//stmt.setString(7,posy);
					stmtt.setString(7,col);
					stmtt.setString(8,type);
					stmtt.setString(9,userid);
					stmtt.executeUpdate();
					j=stmtt.getInt("docno");
					if(j>0)
					{
						doc=Integer.toString(i);
						msg="1";
						 
						
					}
					
			
				else
				{
					
					msg="0";
					//System.out.println("Incorrectusername...........");
				}
	 
		
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
	
	
	
	
    
	response.getWriter().write(msg+"::"+j);  
%>