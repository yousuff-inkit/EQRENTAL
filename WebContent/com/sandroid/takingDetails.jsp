<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
System.out.println("gvfcteyutwa");
ClsConnection  ClsConnection=new ClsConnection();
String fleetno=request.getParameter("fleet");
String regno=request.getParameter("reg");
System.out.println(fleetno);

Connection conn=null;
int i=0;
String value="";
String str="";

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	 if(!fleetno.equalsIgnoreCase(""))
	{ 
		str="select v.rdocno,concat(v.rdtype,' - ',coalesce(r.voc_no,coalesce(l.voc_no,coalesce(n.doc_no,''))),' - ',coalesce(ac.refname,coalesce(s.sal_name,coalesce(d.sal_name,' ')))) details,v.dout,v.tout,v.kmout,v.fout,v.obrhid,v.olocid from gl_vmove v"
			+"	left join gl_ragmt r on v.rdocno=r.doc_no and v.rdtype='rag' left join gl_lagmt l on v.rdocno=l.doc_no and v.rdtype='lag'"
			+"	left join gl_nrm n on v.rdocno=n.doc_no and v.rdtype='MOV' left join my_salesman s on s.doc_no=n.drid and s.sal_type='DRV'"
			+"	left join my_salesman d on d.doc_no=n.staffid and d.sal_type='STF' left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
			+"	where v.fleet_no='"+fleetno+"' and v.doc_no in (select max(doc_no) from gl_vmove where fleet_no='"+fleetno+"');";
	}
 	if(!regno.equalsIgnoreCase(""))
	{
		str="select v.rdocno,concat(v.rdtype,' - ',coalesce(r.voc_no, coalesce(l.voc_no,coalesce(n.doc_no,''))),' - ',coalesce(ac.refname,coalesce(s.sal_name,coalesce(d.sal_name,' ')))) details,"
			+"	v.dout,v.tout,v.kmout,v.fout,v.obrhid,v.olocid from gl_vmove v"
			+"	inner join (select max(g.doc_no) doc_no,fleet_no from gl_vmove g group by fleet_no) v1 on v.fleet_no=v1.fleet_no  and v.doc_no=v1.doc_no"
			+"	left join gl_ragmt r on v.rdocno=r.doc_no and v.rdtype='rag'"
			+"	left join gl_lagmt l on v.rdocno=l.doc_no and v.rdtype='lag'"
			+"	left join gl_nrm n on v.rdocno=n.doc_no and v.rdtype='MOV'"
			+"	left join my_salesman s on s.doc_no=n.drid and s.sal_type='DRV'"
			+"	left join my_salesman d on d.doc_no=n.staffid and d.sal_type='STF'"
			+"	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
			+"	left join gl_vehmaster m on v.fleet_no=m.fleet_no where m.reg_no='"+regno+"'";
	} 
	System.out.println("det:"+str);
	ResultSet rs=stmt.executeQuery(str);
	
	 while(rs.next())
	{
		if(i==0){
			value+=rs.getString("rdocno")+"::"+rs.getString("details")+"::"+rs.getString("dout")+"::"+rs.getString("tout")+"::"+rs.getString("kmout")+"::"+rs.getString("fout")+"::"+rs.getString("obrhid")+"::"+rs.getString("olocid");	
		}
		else{
			value+=","+rs.getString("rdocno")+"::"+rs.getString("details")+"::"+rs.getString("dout")+"::"+rs.getString("tout")+"::"+rs.getString("kmout")+"::"+rs.getString("fout")+"::"+rs.getString("obrhid")+"::"+rs.getString("olocid");
		}
		i++;
		
	}
	System.out.println("mode:"+value);

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