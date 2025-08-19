<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%

String userid=request.getParameter("userid");

// System.out.println("userid=="+userid);

ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0,j=0;
String value="",drvid="";

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	String stst="select driverid from an_userregister where doc_no='"+userid+"'";
	System.out.println("driverfetch::"+stst);
	
	ResultSet rsk=stmt.executeQuery(stst);
	
	while(rsk.next())
	{
	  drvid=rsk.getString("driverid");
	}
String str="select rowno,brhid,jobdoc,jobtype,tarifdoc,tarifdetdoc,jobno, userid, regno, vehname, drivername, location, endlocation, startkm, endkm, date_format(startdate,'%d.%m.%Y')startdate, enddate, starttime, endtime  from an_starttripdet where jobno!='' and endkm is null and enddate is null and endtime is null and driverid="+drvid;
	
System.out.println("startjobs::"+str);
	
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("jobno")+"::"+rs.getString("drivername")+"::"+rs.getString("location").replace(',',' ')+"::"+rs.getString("endlocation").replace(',',' ')+"::"+rs.getString("startkm")+"::"+rs.getString("startdate")+"::"+rs.getString("starttime")+"::"+rs.getString("regno")+"::"+rs.getString("vehname")+"::"+rs.getString("brhid")+"::"+rs.getString("jobdoc")+"::"+rs.getString("jobtype")+"::"+rs.getString("tarifdoc")+"::"+rs.getString("tarifdetdoc")+"::"+rs.getString("rowno")+",";	
		}
		else{
			value+=rs.getString("jobno")+"::"+rs.getString("drivername")+"::"+rs.getString("location").replace(',',' ')+"::"+rs.getString("endlocation").replace(',',' ')+"::"+rs.getString("startkm")+"::"+rs.getString("startdate")+"::"+rs.getString("starttime")+"::"+rs.getString("regno")+"::"+rs.getString("vehname")+"::"+rs.getString("brhid")+"::"+rs.getString("jobdoc")+"::"+rs.getString("jobtype")+"::"+rs.getString("tarifdoc")+"::"+rs.getString("tarifdetdoc")+"::"+rs.getString("rowno")+",";	
			}
		i++;
		
	}
	
/* 	String str1="select * from (select tran.doc_no,book.brhid,'Transfer' type,tran.tarifdocno,tran.tarifdetaildocno,concat(book.doc_no ,'-',tran.docname) jobname "
			+ "from gl_limobookm book inner join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno)where book.status=3 and tran.masterstatus=3 and tran.assigneddriver='"+drvid+"' union all "
			+ "select hours.doc_no,book.brhid,'Limo' type,hours.tarifdocno,hours.tarifdetaildocno,concat(book.doc_no ,'-',hours.docname) jobname "
			+ "from gl_limobookm book inner join gl_limobookhours hours on (book.doc_no=hours.bookdocno)where book.status=3 and hours.masterstatus=3 and hours.assigneddriver='"+drvid+"')b ";
	
	System.out.println("detjobs::"+str1);
	
	ResultSet rs1=stmt.executeQuery(str1);
	
	while(rs1.next())
	{
		if(j==0){
			value+=rs1.getString("doc_no")+"::"+rs1.getString("brhid")+"::"+rs1.getString("type")+"::"+rs1.getString("tarifdocno")+"::"+rs1.getString("tarifdetaildocno")+",";	
		}
		else{
			value+=rs1.getString("doc_no")+"::"+rs1.getString("brhid")+"::"+rs1.getString("type")+"::"+rs1.getString("tarifdocno")+"::"+rs1.getString("tarifdetaildocno")+",";	
			}
		i++;
		
	} */
	
	
 

	//System.out.println("create---:"+value);

}
catch(Exception e)
{
	e.printStackTrace();

}
finally
{
	conn.close();
}

response.getWriter().write(value);
%>