<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
System.out.println("gvfcteyutwa");
ClsConnection  ClsConnection=new ClsConnection();
String fleetno=request.getParameter("fleet");
String regno=request.getParameter("reg");
String typechk=request.getParameter("typechk");
String tst=request.getParameter("chk");
System.out.println(fleetno);

Connection conn=null;
int i=0;
String value="";
String sqltst="",sqltst2="",sqltst3="",tstype="";
String str="";
if(tst.equalsIgnoreCase("collection")){
	sqltst="and VR.clstatus=0";
	sqltst2="VR.rfleetno";
	sqltst3="if(coalesce(VR.doc_no,0)>0,VR.rdocno,v.rdocno)rdocno,if(coalesce(VR.doc_no,0)>0,VR.rtype,v.rdtype)rdtype,concat(if(coalesce(VR.doc_no,0)>0,VR.rtype,v.rdtype),'-',coalesce(r.voc_no,l.voc_no),'-',ac.refname,'-',if(coalesce(VR.doc_no,0)>0,floor(VR.rkm),floor(v.kmout))) details,replace(convert(varchar,if(coalesce(VR.doc_no,0)>0,VR.rdate,v.dout),23),'-','.')dout,if(coalesce(VR.doc_no,0)>0,VR.rtime,v.tout)tout,if(coalesce(VR.doc_no,0)>0,floor(VR.rkm),floor(v.kmout))kmout,if(coalesce(VR.doc_no,0)>0,VR.rfuel,v.fout)fout,if(coalesce(VR.doc_no,0)>0,VR.rbrhid,v.obrhid)obrhid,if(coalesce(VR.doc_no,0)>0,VR.rlocid,v.olocid)olocid,";
}
if(tst.equalsIgnoreCase("delivery")){
	sqltst="and VR.clstatus=1 and VR.delstatus=1";
	sqltst2="VR.ofleetno";
	sqltst3="if(coalesce(VR.doc_no,0)>0,VR.rdocno,v.rdocno)rdocno,if(coalesce(VR.doc_no,0)>0,VR.rtype,v.rdtype)rdtype,concat(if(coalesce(VR.doc_no,0)>0,VR.rtype,v.rdtype),'-',coalesce(r.voc_no,l.voc_no),'-',ac.refname,'-',if(coalesce(VR.doc_no,0)>0,floor(VR.okm),floor(v.kmout))) details,replace(convert(varchar,if(coalesce(VR.doc_no,0)>0,VR.rdate,v.dout),23),'-','.')dout,if(coalesce(VR.doc_no,0)>0,VR.otime,v.tout)tout,if(coalesce(VR.doc_no,0)>0,floor(VR.okm),floor(v.kmout))kmout,if(coalesce(VR.doc_no,0)>0,VR.ofuel,v.fout)fout,if(coalesce(VR.doc_no,0)>0,VR.obrhid,v.obrhid)obrhid,if(coalesce(VR.doc_no,0)>0,VR.olocid,v.olocid)olocid,";
}
try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	 if(!fleetno.equalsIgnoreCase(""))
	{ 
		
         if((typechk.equalsIgnoreCase("RPL")) && (tst.equalsIgnoreCase("delivery"))){
        		str="select a.*,concat(a.fleet_no,' - ',a.reg_no,' - ',a.rdtype,' - ',if(a.repno>0,a.repno,coalesce(a.voc_no,coalesce(a.voc,coalesce(a.doc_no,'')))),' - ',"
        				+"	coalesce(a.refname,coalesce(a.sal_name,coalesce(a.sal,' '))),' - ','OUTKM : ',floor(a.kmout)) details from ("
        				+"  select VR.doc_no repno,r.voc_no,l.voc_no voc,n.doc_no,ac.refname,"
        				+"  s.sal_name,d.sal_name sal,m.fleet_no,m.reg_no,if(VR.doc_no>0,'RPL',v.rdtype)rdtype,case when v.rdtype='LAG' then 1 when v.rdtype='RAG' then 1 end as chk,"
        				+"  if(VR.doc_no>0,VR.doc_no,v.rdocno)rdocno,VR.cldate as dout,VR.cltime as tout,VR.clkm as kmout,VR.clfuel as fout,v.obrhid,v.olocid from gl_vmove v "
        				+"  LEFT JOIN gl_vehreplace VR ON (V.fleet_no="+sqltst2+" and VR.status=3 and reptype='collection' and closestatus=0 "+sqltst+") "
        				+"	left join gl_ragmt r on ((VR.rdocno=r.doc_no and VR.rtype='rag')) left join gl_lagmt l on ((VR.rdocno=l.doc_no and VR.rtype='lag'))"
        				+"	left join gl_nrm n on VR.rdocno=n.doc_no and VR.rtype='MOV' left join my_salesman s on s.doc_no=n.drid and s.sal_type='DRV'"
        				+"	left join my_salesman d on d.doc_no=n.staffid and d.sal_type='STF' left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM' left join gl_vehmaster m on v.fleet_no=m.fleet_no"
        				+"	where v.rdtype!='VSC' and v.fleet_no='"+fleetno+"' and v.doc_no in (select max(doc_no) from gl_vmove where fleet_no='"+fleetno+"'))a"; 
		 }
         else{
        	 str="select a.*,concat(a.fleet_no,' - ',a.reg_no,' - ',a.rdtype,' - ',if(a.repno>0,a.repno,coalesce(a.voc_no,coalesce(a.voc,coalesce(a.doc_no,'')))),' - ',"
						+"	coalesce(a.refname,coalesce(a.sal_name,coalesce(a.sal,' '))),' - ','OUTKM : ',floor(a.kmout)) details from (select v.repno,r.voc_no,l.voc_no voc,n.doc_no,ac.refname,"
						+"  s.sal_name,d.sal_name sal,m.fleet_no,m.reg_no,if(v.repno>0,'RPL',v.rdtype)rdtype,case when v.rdtype='LAG' then 1 when v.rdtype='RAG' then 1 end as chk,"
						+"  if(v.repno>0,v.repno,v.rdocno)rdocno,v.dout,v.tout,v.kmout,v.fout,v.obrhid,v.olocid from gl_vmove v "
						+"	left join gl_ragmt r on v.rdocno=r.doc_no and v.rdtype='rag' left join gl_lagmt l on v.rdocno=l.doc_no and v.rdtype='lag'"
						+"	left join gl_nrm n on v.rdocno=n.doc_no and v.rdtype='MOV' left join my_salesman s on s.doc_no=n.drid and s.sal_type='DRV'"
						+"	left join my_salesman d on d.doc_no=n.staffid and d.sal_type='STF' left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM' left join gl_vehmaster m on v.fleet_no=m.fleet_no"
						+"	where v.rdtype!='VSC' and v.fleet_no='"+fleetno+"' and v.doc_no in (select max(doc_no) from gl_vmove where fleet_no='"+fleetno+"'))a";
         }
      
		
	}
 	if(!regno.equalsIgnoreCase(""))
	{
       
         if((typechk.equalsIgnoreCase("RPL")) && (tst.equalsIgnoreCase("delivery"))){
        		str="select a.*,concat(a.fleet_no,' - ',a.reg_no,' - ',a.rdtype,' - ',if(a.repno>0,a.repno,coalesce(a.voc_no,coalesce(a.voc,coalesce(a.doc_no,'')))),' - ',coalesce(a.refname,coalesce(a.sal_name,coalesce(a.sal,' '))),' - ','OUTKM : ',floor(a.clkm)) details from ("
        				+"  select VR.doc_no repno,r.voc_no,l.voc_no voc,n.doc_no,ac.refname,s.sal_name,d.sal_name sal,m.fleet_no,m.reg_no,if(VR.doc_no>0,'RPL',v.rdtype)rdtype,case when v.rdtype='LAG' then 1 when v.rdtype='RAG' then 1 end as chk,if(VR.doc_no>0,VR.doc_no,v.rdocno)rdocno,"
        				+"	VR.cldate as dout,VR.cltime as tout,VR.clkm as kmout,VR.clfuel as fout,v.obrhid,v.olocid from gl_vmove v"
        				+"	inner join (select max(g.doc_no) doc_no,fleet_no from gl_vmove g group by fleet_no) v1 on v.fleet_no=v1.fleet_no  and v.doc_no=v1.doc_no"
        				+"  LEFT JOIN gl_vehreplace VR ON (V.fleet_no="+sqltst2+" and VR.status=3 and reptype='collection' and closestatus=0 "+sqltst+") "
        				+"	left join gl_ragmt r on ((VR.rdocno=r.doc_no and VR.rtype='rag')) left join gl_lagmt l on ((VR.rdocno=l.doc_no and VR.rtype='lag'))"
        				+"	left join gl_nrm n on VR.rdocno=n.doc_no and VR.rtype='MOV'"
        				+"	left join my_salesman s on s.doc_no=n.drid and s.sal_type='DRV'"
        				+"	left join my_salesman d on d.doc_no=n.staffid and d.sal_type='STF'"
        				+"	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
        				+"	left join gl_vehmaster m on v.fleet_no=m.fleet_no where v.rdtype!='VSC' and m.reg_no='"+regno+"')a";
		 }
         else{
        		str="select a.*,concat(a.fleet_no,' - ',a.reg_no,' - ',a.rdtype,' - ',if(a.repno>0,a.repno,coalesce(a.voc_no,coalesce(a.voc,coalesce(a.doc_no,'')))),' - ',coalesce(a.refname,coalesce(a.sal_name,coalesce(a.sal,' '))),' - ','OUTKM : ',floor(a.kmout)) details from (select v.repno,r.voc_no,l.voc_no voc,n.doc_no,ac.refname,s.sal_name,d.sal_name sal,m.fleet_no,m.reg_no,if(v.repno>0,'RPL',v.rdtype)rdtype,case when v.rdtype='LAG' then 1 when v.rdtype='RAG' then 1 end as chk,if(v.repno>0,v.repno,v.rdocno)rdocno,"
        				+"	v.dout,v.tout,v.kmout,v.fout,v.obrhid,v.olocid from gl_vmove v"
        				+"	inner join (select max(g.doc_no) doc_no,fleet_no from gl_vmove g group by fleet_no) v1 on v.fleet_no=v1.fleet_no  and v.doc_no=v1.doc_no"
        				+"	left join gl_ragmt r on v.rdocno=r.doc_no and v.rdtype='rag'"
        				+"	left join gl_lagmt l on v.rdocno=l.doc_no and v.rdtype='lag'"
        				+"	left join gl_nrm n on v.rdocno=n.doc_no and v.rdtype='MOV'"
        				+"	left join my_salesman s on s.doc_no=n.drid and s.sal_type='DRV'"
        				+"	left join my_salesman d on d.doc_no=n.staffid and d.sal_type='STF'"
        				+"	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
        				+"	left join gl_vehmaster m on v.fleet_no=m.fleet_no where v.rdtype!='VSC' and m.reg_no='"+regno+"')a";
		 }
	
	} 
	System.out.println("det:"+str);
	ResultSet rs=stmt.executeQuery(str);
	
	 while(rs.next())
	{
		
			 if(i==0){
					value+=rs.getString("rdocno")+"::"+rs.getString("details")+"::"+rs.getString("dout")+"::"+rs.getString("tout")+"::"+rs.getString("kmout")+"::"+rs.getString("fout")+"::"+rs.getString("obrhid")+"::"+rs.getString("olocid")+"::"+rs.getString("chk")+"::"+rs.getString("rdtype")+"::"+rs.getString("reg_no")+"::"+rs.getString("fleet_no");	
				}
				else{
					value+=","+rs.getString("rdocno")+"::"+rs.getString("details")+"::"+rs.getString("dout")+"::"+rs.getString("tout")+"::"+rs.getString("kmout")+"::"+rs.getString("fout")+"::"+rs.getString("obrhid")+"::"+rs.getString("olocid")+"::"+rs.getString("chk")+"::"+rs.getString("rdtype")+"::"+rs.getString("reg_no")+"::"+rs.getString("fleet_no");
				}
				i++;
		 
	}
	//System.out.println("mode:"+value);

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