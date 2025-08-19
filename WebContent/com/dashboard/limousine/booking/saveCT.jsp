<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%
String time=request.getParameter("cgtime")==null?"":request.getParameter("cgtime");   
String driver=request.getParameter("cgdriver")==null?"0":request.getParameter("cgdriver");
String remarks=request.getParameter("cgdesc")==null?"":request.getParameter("cgdesc");   
String date=request.getParameter("cgdate")==null?"0":request.getParameter("cgdate");
String detdocno=request.getParameter("detaildocno")==null?"0":request.getParameter("detaildocno"); 
String bkdocno=request.getParameter("bookdocno")==null?"0":request.getParameter("bookdocno");
String rowss=request.getParameter("rowss")==null?"0":request.getParameter("rowss");
String typess=request.getParameter("type")==null?"0":request.getParameter("type"); 
int val=0;        
int sqlupdate=0;      
String strsql="",strsql2="",strsql3="",strsql4="",strsql5="";            
Connection conn=null;
Statement stmt=null;
int errorstatus=0;
try{  
	ClsConnection objconn=new ClsConnection();    
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	stmt=conn.createStatement(); 
	String brhid=session.getAttribute("BRANCHID")==null?"0":session.getAttribute("BRANCHID").toString();
    String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
    String username=session.getAttribute("USERNAME")==null?"0":session.getAttribute("USERNAME").toString();
	java.sql.Date sqldate=null;  
	if(!date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);                
	}
    String[] typearray = typess.split(",");
    String[] bnoarray = bkdocno.split(",");  
    String[] rownoarray = rowss.split(",");      
    String[] detarray = detdocno.split(","); 
    for (int i = 0; i < rownoarray.length; i++) {
		String detaildocno=detarray[i];	
		String bookdocno=bnoarray[i]; 
		String type=typearray[i]; 
		String rowno=rownoarray[i];	
		System.out.println(detaildocno+"::"+bookdocno+"::"+type+"::"+rowno);
		if(!(detaildocno.equalsIgnoreCase(""))){    
			if(type.equalsIgnoreCase("Transfer")){      
				strsql="update gl_limobooktransfer set pickupdate='"+sqldate+"',pickuptime='"+time+"',assigneddriver="+driver+" where doc_no='"+detaildocno+"'";	
				System.out.println(strsql);
				sqlupdate=stmt.executeUpdate(strsql); 
				if(sqlupdate<=0){
					errorstatus=1;
					System.out.println("Limo Book Transfer Update Error"); 	
				}
			 	//bstatus=6
				strsql2="update gl_limomanagement set pickupdate='"+sqldate+"',pickuptime='"+time+"',bstatus=4,remarks='"+remarks+"' where tdocno='"+detaildocno+"'";	
			 	System.out.println(strsql2);
			 	sqlupdate=stmt.executeUpdate(strsql2);
			 	if(sqlupdate<=0){
					errorstatus=1;
				 	System.out.println("Limo Book Transfer Update Error");
			 	}
			}else if(type.equalsIgnoreCase("Limo")){
				strsql4="update gl_limobookhours set pickupdate='"+sqldate+"',pickuptime='"+time+"' where doc_no='"+detaildocno+"'";	
				System.out.println(strsql4);
				sqlupdate=stmt.executeUpdate(strsql4);    
			 	strsql5="update gl_limomanagement set pickupdate='"+sqldate+"',pickuptime='"+time+"',remarks='"+remarks+"' where tdocno='"+detaildocno+"'";	
			 	System.out.println(strsql5);
			 	sqlupdate=stmt.executeUpdate(strsql5);
			}
			if(sqlupdate>0){        
				/* String strsqlss="update gl_limomanagement set  where rowno='"+rowno+"'";	
				System.out.println(strsqlss);
				stmt.executeUpdate(strsqlss); */
				strsql3="insert into gl_cgtime(type, detaildocno, bookdocno, pdate, ptime, driver, remarks) values('"+type+"','"+detaildocno+"','"+bookdocno+"','"+sqldate+"','"+time+"','"+driver+"','"+remarks+"')";	
				System.out.println(strsql3);
				sqlupdate=stmt.executeUpdate(strsql3);  
				if(sqlupdate<=0){
					errorstatus=1;
					System.out.println("Insert Change In Time Error");
				}
				String strgetdetail="select docno,job from gl_limomanagement where tdocno='"+detaildocno+"'";	
				int bookingdocno=0;
				String jobname="";
				ResultSet rs=stmt.executeQuery(strgetdetail);
				while(rs.next()){
					bookingdocno=rs.getInt("docno");
					jobname=rs.getString("job");
				}
				String systemnote="Change In Time of "+bookingdocno+" - "+jobname+" by "+username;
				String strinsertlog="insert into gl_limomgmtlog(bookdocno, jobname, brhid, userid, logdate,remarks,systemremarks)values("+
				""+bookingdocno+",'"+jobname+"',"+brhid+","+userid+",now(),'"+remarks+"','"+systemnote+"')";
				int insertlog=stmt.executeUpdate(strinsertlog);
				if(insertlog<=0){
					errorstatus=1;
				}
			}
			                 
		}  
    }      
	if(errorstatus!=1){
		val=1;  
		conn.commit();
	}
	  response.getWriter().print(val);
		  conn.close();
}
catch(Exception e){  
	e.printStackTrace();
}finally {
    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
}
%>