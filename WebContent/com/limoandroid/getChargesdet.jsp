<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%

String userid=request.getParameter("userid");

// System.out.println("userid=="+userid);

ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0;
String value="";

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	String str="select a.doc_no masterdocno,a.curid doc_no,c.code,round(a.rate,5) c_rate,a.type,c.acno from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb where  coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) inner join my_curr c on a.curid=c.doc_no;";
	
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("code")+"::"+rs.getString("c_rate")+"::"+rs.getString("type")+"::"+rs.getString("masterdocno")+"::"+rs.getString("doc_no")+"::"+rs.getString("acno");	
		}
		else{
			value+=","+rs.getString("code")+"::"+rs.getString("c_rate")+"::"+rs.getString("type")+"::"+rs.getString("masterdocno")+"::"+rs.getString("doc_no")+"::"+rs.getString("acno");
		}
		i++;
		
	}
// 	System.out.println("create---:"+value);

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