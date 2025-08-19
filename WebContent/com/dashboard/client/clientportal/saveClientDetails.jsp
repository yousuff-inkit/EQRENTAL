<%@page import="javax.mail.MessagingException"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.mail.internet.AddressException"%>
<%@page import="java.io.File"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.mailwithpdf.SendEmailAction" %>   
<%
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno").toString();
String clientusername=request.getParameter("clientusername")==null?"":request.getParameter("clientusername").toString();
String clientpassword=request.getParameter("clientpassword")==null?"":request.getParameter("clientpassword").toString();
String chksendmail=request.getParameter("chksendmail")==null?"":request.getParameter("chksendmail").toString();
String branchid=session.getAttribute("BRANCHID")==null?"0":session.getAttribute("BRANCHID").toString();
System.out.println(cldocno+"::"+clientusername+"::"+clientpassword+"::"+chksendmail+"::"+branchid);
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String sendermail="",email="",msg="";
	SendEmailAction sendmail=new SendEmailAction();
	String strupdate="update my_acbook ac set clientusername='"+clientusername+"',clientpassword='"+clientpassword+"' where cldocno="+cldocno+" and dtype='CRM' and status=3";
	System.out.println(strupdate);
	int update=stmt.executeUpdate(strupdate);
	if(update<=0){
		errorstatus=1;
	}
	String strlog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+cldocno+",'"+branchid+"','BICP',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	System.out.println(strupdate);
	int log= stmt.executeUpdate(strlog);
	if(log<=0){
		errorstatus=1;
	}
	if(chksendmail.equalsIgnoreCase("1")){
		String strSql4 = "select coalesce(mail,'') mail from my_user where doc_no='"+session.getAttribute("USERID")+"'";           
		//System.out.println("sql=="+strSql2);
		ResultSet rs3 = stmt.executeQuery(strSql4);               
		while(rs3.next()) {
			  sendermail=rs3.getString("mail");   
		}
		String strSql2 = "select mail1 from my_acbook where cldocno="+cldocno+" and dtype='CRM' and status=3";
		//System.out.println("sql=="+strSql2);
		ResultSet rs2 = stmt.executeQuery(strSql2);
		while(rs2.next ()) {
			email=rs2.getString("mail1");
		}
		if(email.equalsIgnoreCase("") || email==null){
			errorstatus=1;
			System.out.println("Mail Empty");
		}
		//String receiptdate=request.getParameter("receiptdate");   
		//String docno=request.getParameter("docno");
		
		String sub="Client Portal Credentials Notification",invno="";
		msg="<html><body><table><tr><td>Dear Customer,</td></tr><tr><td> Please be informed, your Client Portal Credentials has been updated as below:</td></tr> ";
		String emailTraffic ="select coalesce(comp.company,'') compname,coalesce(comp.tel,'') tel,coalesce(comp.fax,'') fax,a.refname,a.mail1,concat('<tr><td>Username: ',coalesce(a.clientusername,''),'</td></tr><tr><td>Password: ',\r\n" + 
		" coalesce(a.clientpassword,''),'</td></tr><tr><td>If you have any questions or concerns, please dont hesitate to contact our office.</td></tr>"+
		" <tr><td>Yours Sincerely<br>Team EuroStar<br></td></tr>') msg from my_acbook a left join my_brch br on a.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no where a.dtype='CRM' and a.cldocno="+cldocno;
		System.out.println(emailTraffic);
		ResultSet rstrf=conn.createStatement().executeQuery(emailTraffic);
		String compname="",comptel="",compfax="";
		while(rstrf.next()) {
			msg=msg.replace("Customer",rstrf.getString("refname") );
			email=rstrf.getString("mail1");
			//invno=rstrf.getString("inv_no");
			compname=rstrf.getString("compname");
			comptel=rstrf.getString("tel");
			compfax=rstrf.getString("fax");
			msg+=rstrf.getString("msg");
			System.out.println(" inside "+email+"==="+invno+"===="+msg);
		}
		msg+="<tr><td><h2>"+compname+"</h2><br><address>Tel: "+comptel+"<br>Fax: "+compfax+"</address><br><p>Please dont print e-mails unless you really need</p></td></tr>";
		msg+="<tr><td> Thank you</tr></td></table></body></html>";
		System.out.println(email+"==="+invno+"===="+msg);
		if(!email.trim().equalsIgnoreCase("")) {
			File saveFile=null;
			/*
			* HttpServletRequest request=ServletActionContext.getRequest(); HttpSession
			* session=request.getSession();
			*/ 
			try {
				String mailstatus=sendmail.SendTomailINT( saveFile,"CRM",email,cldocno+"",session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),invno,sub,msg);
				if(!mailstatus.trim().equalsIgnoreCase("success")){
					errorstatus=1;
				}
			} catch (AddressException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (MessagingException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
	conn.close();
	
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>