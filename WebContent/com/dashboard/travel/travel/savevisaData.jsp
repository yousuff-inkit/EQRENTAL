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
String gridarray=request.getParameter("gridarray");   
int type=request.getParameter("type") ==null || request.getParameter("type")==""?0:Integer.parseInt(request.getParameter("type").trim().toString());
String locid=request.getParameter("locid")==null || request.getParameter("locid")==""?"0":request.getParameter("locid").trim().toString();
int rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?0:Integer.parseInt(request.getParameter("rdocno").trim().toString());
String edate=request.getParameter("edate") ==null || request.getParameter("edate")==""?"0":request.getParameter("edate");
String mobno=request.getParameter("mob") ==null || request.getParameter("mob")==""?"":request.getParameter("mob");
String email=request.getParameter("mail") ==null || request.getParameter("mail")==""?"":request.getParameter("mail");  
String client=request.getParameter("client") ==null || request.getParameter("client")==""?"":request.getParameter("client"); 
String clientid=request.getParameter("clientid")==null || request.getParameter("clientid")==""?"0":request.getParameter("clientid");  
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");
String userid=session.getAttribute("USERID").toString();      
java.sql.Date sqldate=null;
java.sql.Date vsqldate=null;


ClsConnection objconn=new ClsConnection();  
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;  
String msg="";


try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();

	if(!(edate.equalsIgnoreCase("undefined"))&&!(edate.equalsIgnoreCase(""))&&!(edate.equalsIgnoreCase("0"))){
		 sqldate=ClsCommon.changeStringtoSqlDate(edate);
	}
	int docno=0,val=0;
	int vocno=0;           
	if(rdocno==0){
		String sqlvoc="select coalesce((max(voc_no)+1),1) voc_no from tr_servicereqm where brhid='"+brhid+"'";    
		ResultSet rs7=stmt.executeQuery(sqlvoc);
		if(rs7.next()){
			vocno=rs7.getInt("voc_no");    
		}
		String strsql="insert into tr_servicereqm(voc_no, date, Cldocno, userid, status, brhid, refname, mob, mail, locid, type) values('"+vocno+"','"+sqldate+"',"+clientid+","+userid+",3,"+brhid+",'"+client+"','"+mobno+"','"+email+"','"+locid+"',"+type+")";
		//System.out.println(strsql);  
		int insertval=stmt.executeUpdate(strsql);
		if(insertval>0){ 
			String sql1="select max(doc_no) docno from tr_servicereqm";
			ResultSet rs=stmt.executeQuery(sql1);        
			if(rs.next()){
				docno=rs.getInt("docno");
			}
		}
	}else{
		docno=rdocno;
	}   
		ArrayList<String> newarray=new ArrayList();
		
		String temparray[]=gridarray.split(",");
		for(int i=0;i<temparray.length;i++){
			newarray.add(temparray[i]);
		}
		
		for(int i=0;i<newarray.size();i++){
			
			String temp[]=newarray.get(i).split("::");
			
			if(!temp[0].trim().equalsIgnoreCase("undefined") && !temp[0].trim().equalsIgnoreCase("NaN") && !temp[0].trim().equalsIgnoreCase("")){
				
			String givenname = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"0":temp[0].trim()).toString();
			String surname = (temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?"0":temp[1].trim()).toString();
			String vdocno = temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().equalsIgnoreCase("NaN") || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().isEmpty()?"0":temp[2].trim().toString();
			String natid = temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().equalsIgnoreCase("NaN") || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().isEmpty()?"0":temp[3].trim().toString();
			String passno = temp[4].trim().equalsIgnoreCase("undefined") || temp[4].trim().equalsIgnoreCase("NaN") || temp[4].trim().equalsIgnoreCase("") || temp[4].trim().isEmpty()?"0":temp[4].trim().toString();
			String issuedfrom = temp[5].trim().equalsIgnoreCase("undefined") || temp[5].trim().equalsIgnoreCase("NaN") || temp[5].trim().equalsIgnoreCase("") || temp[5].trim().isEmpty()?"0":temp[5].trim().toString();
			String vupto = temp[6].trim().equalsIgnoreCase("undefined") || temp[6].trim().equalsIgnoreCase("NaN") || temp[6].trim().equalsIgnoreCase("") || temp[6].trim().isEmpty()?"":temp[6].trim().toString();
			String remarks = temp[7].trim().equalsIgnoreCase("undefined") || temp[7].trim().equalsIgnoreCase("NaN") || temp[7].trim().equalsIgnoreCase("") || temp[7].trim().isEmpty()?"":temp[7].trim().toString();
			int rowsno= temp[8].trim().equalsIgnoreCase("undefined") || temp[8].trim().equalsIgnoreCase("NaN") || temp[8].trim().equalsIgnoreCase("") || temp[8].trim().isEmpty()?0:Integer.parseInt(temp[8].trim().toString());
			
			 if(!(vupto.equalsIgnoreCase("undefined"))&&!(vupto.equalsIgnoreCase(""))&&!(vupto.equalsIgnoreCase("0")))
				{
					 vsqldate=ClsCommon.changeStringtoSqlDate(vupto);
					
				} 
			 
			 //System.out.println("rowsno=="+rowsno);   
				if(rowsno>0){ 
					String sql="update TR_srvisa set srno="+(i+1)+", name='"+givenname+"', surname='"+surname+"', visaid="+vdocno+", natid="+natid+", passportno='"+passno+"', issuefrom='"+issuedfrom+"', validupto='"+vsqldate+"', remarks='"+remarks+"' where rowno="+rowsno+"";   
					//System.out.println(sql);
					 val=stmt.executeUpdate(sql);  
				}else{
					String sql="insert into TR_srvisa(rdocno, srno, name, surname, visaid, natid, passportno, issuefrom, validupto, remarks) values("+docno+","+(i+1)+",'"+givenname+"','"+surname+"',"+vdocno+","+natid+",'"+passno+"','"+issuedfrom+"','"+vsqldate+"','"+remarks+"')";
					//System.out.println(sql);
					 val=stmt.executeUpdate(sql);
				}
			if(val>0){
				msg="0";
				conn.commit();
			}
			
		  
		}
		
		
		/* conn.commit(); */
	} 
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(msg);
%>