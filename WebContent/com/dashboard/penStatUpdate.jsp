<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.File"%>
<%@page import="com.common.ClsEncrypt"%> 
<%@page import="com.emailnew.EmailUtility"%>    
<%              
String remark = request.getParameter("remarks")==null?"":request.getParameter("remarks");   
String crtuser = request.getParameter("crtuser")==null?"0":request.getParameter("crtuser");
String userid = request.getParameter("userid")==null?"0":request.getParameter("userid");
String status = request.getParameter("status")==null?"0":request.getParameter("status");
String oldstatus = request.getParameter("oldstatus")==null?"0":request.getParameter("oldstatus");
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); 
String asgnuser = request.getParameter("asgnuser")==null?"":request.getParameter("asgnuser");  
String oldassuser = request.getParameter("oldassuser")==null?"0":request.getParameter("oldassuser");
int val=0;   
Connection conn=null;
try{          
	ClsConnection objconn=new ClsConnection();  
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	EmailUtility utl = new EmailUtility();
	ClsEncrypt crypt = new ClsEncrypt();
	String strsql="";
	if(!(status.equalsIgnoreCase("Confirmed") || status.equalsIgnoreCase("Completed"))){                  
		if(!asgnuser.equalsIgnoreCase("")){              
			strsql="update an_taskcreation set ass_user='"+asgnuser+"',act_status='"+status+"' where doc_no='"+docno+"' and utype!='app'";	
			val=stmt.executeUpdate(strsql);
		}else{  
			strsql="update an_taskcreation set ass_user='"+oldassuser+"',act_status='"+status+"' where doc_no='"+docno+"' and utype!='app'";
			val=stmt.executeUpdate(strsql);
		}      
	}else if(status.equalsIgnoreCase("Completed")){          
			strsql="update an_taskcreation set ass_user='"+crtuser+"',act_status='"+status+"' where doc_no='"+docno+"' and utype!='app'";	
			val=stmt.executeUpdate(strsql);
	}else{
		  strsql="update an_taskcreation set act_status='"+status+"',close_status=1 where doc_no='"+docno+"' and utype!='app'";  
		  val=stmt.executeUpdate(strsql);
	}
	int val2=0;
	if(val>0){    
		String flwsql="insert into an_taskcreationdets(rdocno,ass_date,userid,assnfrom_user,action_status,remarks) values('"+docno+"',now(),'"+asgnuser+"','"+session.getAttribute("USERID")+"','"+status+"','"+remark+"')";
		val2=stmt.executeUpdate(flwsql);          
	}
	if(val2>0){
		String host = "", port = "", userName = "", password = "", recipient = "", subject = "", message = "";  
		File saveFile = null;  
		
		String sqlstr = "SELECT mail, mailpass, smtpserver, smtphostport FROM my_user WHERE status=3 AND user_id='super'";	
		ResultSet rs = stmt.executeQuery(sqlstr);
		while(rs.next()){   
			host = rs.getString("smtpserver");
			port = rs.getString("smtphostport");
			userName = rs.getString("mail");
			password = crypt.decrypt(rs.getString("mailpass").trim());    
		}   
		
		String sqlstr1 = "SELECT email FROM my_user WHERE doc_no='"+asgnuser+"'";  	  
		ResultSet rs1 = stmt.executeQuery(sqlstr1);
		while(rs1.next()){
			recipient = rs1.getString("email");    
		}
		
		String msgsql="";
		String sqlstr2 = "select msg, subject from gl_emailmsg where dtype='TMT' and description='"+status+"'";	     
		ResultSet rs2 = stmt.executeQuery(sqlstr2);
		while(rs2.next()){
			msgsql = rs2.getString("msg").replaceAll("document", docno+"");      
			subject = rs2.getString("subject");      
		}
		
		if(!msgsql.equals("")){  
			ResultSet rs3 = stmt.executeQuery(msgsql);
			while(rs3.next()){
				message = rs3.getString("content");        
			}  
		}
		
		if(!message.equals("") && !recipient.equals("")){     
			String successtatus = utl.sendEmailpdf(host,  port, userName,  password,  recipient,  "" , subject,  message, "", "", saveFile);  
			System.out.println("====successtatus===="+successtatus); 
		}
	}
	//System.out.println(val+"---->>>"+strsql);  
}   
catch(Exception e){  
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(val+"");   

%>