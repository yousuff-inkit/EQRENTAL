<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>   
<%@page import="com.emailnew.EmailUtility"%>
<%@page import="java.io.File"%>
<%@page import="com.common.ClsEncrypt"%>
<%
		String reftype = request.getParameter("reftype")==null?"":request.getParameter("reftype").trim();  
		String refno = request.getParameter("refno")==null?"":request.getParameter("refno").trim();
		String sdate = request.getParameter("sdate")==null?"":request.getParameter("sdate").trim();
		String stime = request.getParameter("stime")==null?"":request.getParameter("stime").trim();
		String hiduser = request.getParameter("hiduser")==null || request.getParameter("hiduser").equals("")?"0":request.getParameter("hiduser").trim();          
		String desc = request.getParameter("desc")==null?"":request.getParameter("desc").trim();
		String userid = request.getParameter("userid")==null || request.getParameter("userid").equals("")?"0":request.getParameter("userid").trim(); 
		String edcdate = request.getParameter("edcdate")==null?"":request.getParameter("edcdate").trim();     
		
		ClsConnection  ClsConnection=new ClsConnection();
		Connection conn=null;
		ClsCommon cmn = new ClsCommon();    
		int val = 0;
		try
		{
			EmailUtility utl = new EmailUtility();
			ClsEncrypt crypt = new ClsEncrypt();
			conn=ClsConnection.getMyConnection();
			Statement st = conn.createStatement();
			java.sql.Date sqledcdate = null;
			if(!edcdate.equals("") && edcdate!=null){
				sqledcdate = cmn.changeStringtoSqlDate(edcdate);
			}
		
			//System.out.println(hiduser+"====USERID===="+userid);       
			
		    CallableStatement stmt=conn.prepareCall("{call an_taskcreationDML(?,?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(9, java.sql.Types.INTEGER);
			stmt.setString(1,reftype);
			stmt.setString(2,refno);
			stmt.setString(3,sdate);
			stmt.setString(4,stime);
			stmt.setString(5,hiduser);
			stmt.setString(6,desc);
			stmt.setString(7,userid);
			stmt.setString(8,"");
			stmt.setDate(10,sqledcdate);        
			stmt.executeUpdate();
			val = stmt.getInt("docno");
			
			if(val>0){
				
				String sqlinsert = "UPDATE an_schedule SET lastdate = now() WHERE remarks = '"+desc+"'";  
				st.executeUpdate(sqlinsert);
				
				String host = "", port = "", userName = "", password = "", recipient = "", subject = "", message = "";  
				File saveFile = null;  
				
				String sqlstr = "SELECT mail, mailpass, smtpserver, smtphostport FROM my_user WHERE status=3 AND user_id='super'";	
				ResultSet rs = st.executeQuery(sqlstr);
				while(rs.next()){
					host = rs.getString("smtpserver");
					port = rs.getString("smtphostport");
					userName = rs.getString("mail");
					password = crypt.decrypt(rs.getString("mailpass").trim());  
				}  
				
				String sqlstr1 = "SELECT email FROM my_user WHERE doc_no='"+hiduser+"'";	  
				ResultSet rs1 = st.executeQuery(sqlstr1);
				while(rs1.next()){
					recipient = rs1.getString("email");    
				}
				
				String msgsql="";
				String sqlstr2 = "select msg, subject from gl_emailmsg where dtype='TMT' and description='Assigned'";	  
				ResultSet rs2 = st.executeQuery(sqlstr2);
				while(rs2.next()){
					msgsql = rs2.getString("msg").replaceAll("document", val+"");           
					subject = rs2.getString("subject");      
				}
				
				if(!msgsql.equals("")){  
					ResultSet rs3 = st.executeQuery(msgsql);
					while(rs3.next()){
						message = rs3.getString("content");        
					}  
				}
				System.out.println(message+"====+===="+recipient);     
				if(!message.equals("") && !recipient.equals("")){     
					String successtatus = utl.sendEmailpdf(host,  port, userName,  password,  recipient,  "" , subject,  message, "", "", saveFile);  
					System.out.println("====successtatus===="+successtatus);    
				}
			}
			
			stmt.close();  
			conn.close(); 
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		conn.close();
	}
	response.getWriter().print(val);
%>