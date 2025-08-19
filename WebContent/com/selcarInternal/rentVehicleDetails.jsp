<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
System.out.println("gvfcteyutwa");
ClsConnection  ClsConnection=new ClsConnection();
String fleetno=request.getParameter("fleetno");
String regno=request.getParameter("regno");
String clientid=request.getParameter("userid");
String driver=request.getParameter("drvid");
String tst=request.getParameter("chk");
System.out.println(fleetno);

Connection conn=null;
int i=0;
String value="",sqltst="",sqltst2="",sqltst3="",tstype="";
String str="";
if(tst.equalsIgnoreCase("collection")){
	sqltst="and VR.clstatus=0";
	sqltst2="VR.rfleetno";
	sqltst3="if(coalesce(VR.doc_no,0)>0,VR.rdocno,v.rdocno)rdocno,if(coalesce(VR.doc_no,0)>0,VR.rtype,v.rdtype)rdtype,concat(if(coalesce(VR.doc_no,0)>0,VR.rtype,v.rdtype),'-',coalesce(r.voc_no,l.voc_no),'-',ac.refname,'-',if(coalesce(VR.doc_no,0)>0,floor(VR.rkm),floor(v.kmout))) details,replace(if(coalesce(VR.doc_no,0)>0,VR.rdate,v.dout),'-','.')dout,if(coalesce(VR.doc_no,0)>0,VR.rtime,v.tout)tout,if(coalesce(VR.doc_no,0)>0,floor(VR.rkm),floor(v.kmout))kmout,if(coalesce(VR.doc_no,0)>0,VR.rfuel,v.fout)fout,if(coalesce(VR.doc_no,0)>0,VR.rbrhid,v.obrhid)obrhid,if(coalesce(VR.doc_no,0)>0,VR.rlocid,v.olocid)olocid,";
}
if(tst.equalsIgnoreCase("delivery")){
	sqltst="and VR.clstatus=1 and VR.delstatus=0";
	sqltst2="VR.ofleetno";
	sqltst3="if(coalesce(VR.doc_no,0)>0,VR.rdocno,v.rdocno)rdocno,if(coalesce(VR.doc_no,0)>0,VR.rtype,v.rdtype)rdtype,concat(if(coalesce(VR.doc_no,0)>0,VR.rtype,v.rdtype),'-',coalesce(r.voc_no,l.voc_no),'-',ac.refname,'-',if(coalesce(VR.doc_no,0)>0,floor(VR.okm),floor(v.kmout))) details,replace(if(coalesce(VR.doc_no,0)>0,VR.rdate,v.dout),'-','.')dout,if(coalesce(VR.doc_no,0)>0,VR.otime,v.tout)tout,if(coalesce(VR.doc_no,0)>0,floor(VR.okm),floor(v.kmout))kmout,if(coalesce(VR.doc_no,0)>0,VR.ofuel,v.fout)fout,if(coalesce(VR.doc_no,0)>0,VR.obrhid,v.obrhid)obrhid,if(coalesce(VR.doc_no,0)>0,VR.olocid,v.olocid)olocid,";
}
if(tst.equalsIgnoreCase("branchclose")){
	sqltst="and VR.clstatus=1 and VR.delstatus=1";
	sqltst2="VR.rfleetno";
	sqltst3="if(coalesce(VR.doc_no,0)>0,VR.rdocno,v.rdocno)rdocno,if(coalesce(VR.doc_no,0)>0,VR.rtype,v.rdtype)rdtype,concat(if(coalesce(VR.doc_no,0)>0,VR.rtype,v.rdtype),'-',coalesce(r.voc_no,l.voc_no),'-',ac.refname,'-',if(coalesce(VR.doc_no,0)>0,floor(VR.clkm),floor(v.kmout))) details,replace(if(coalesce(VR.doc_no,0)>0,VR.rdate,v.dout),'-','.')dout,if(coalesce(VR.doc_no,0)>0,VR.cltime,v.tout)tout,if(coalesce(VR.doc_no,0)>0,floor(VR.clkm),floor(v.kmout))kmout,if(coalesce(VR.doc_no,0)>0,VR.clfuel,v.fout)fout,if(coalesce(VR.doc_no,0)>0,VR.rbrhid,v.obrhid)obrhid,if(coalesce(VR.doc_no,0)>0,VR.rlocid,v.olocid)olocid,";
}
//select v.rdocno,v.rdtype,concat(v.rdtype,'-',r.voc_no,'-',ac.refname,'-',round(v.kmout,2)) details,convert(varchar,v.dout,105) dout,v.tout,round(v.kmout,2)kmout,v.fout,v.obrhid,v.olocid,VR.doc_no repno from gl_vmove v	left join gl_ragmt r on v.rdocno=r.doc_no and v.rdtype='rag' left join gl_lagmt l on v.rdocno=l.doc_no and v.rdtype='lag'	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM' LEFT JOIN gl_vehreplace VR ON (V.fleet_no=VR.rfleetno and VR.status=3 and reptype='collection' and closestatus=0)	where v.fleet_no='1002' and v.doc_no in (select max(doc_no) from gl_vmove where fleet_no='1002')
try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	 if(!fleetno.equalsIgnoreCase(""))
	{ 
		 Statement stmtnw = conn.createStatement(); 
		 String strtst="select * from(select case when coalesce(VR.doc_no,0)>0 then 'RPL' when coalesce(vh.doc_no,0)>0 then 'PKUP' else 'DEL' end as typechk from gl_vmove v"
					+"	left join gl_ragmt r on v.rdocno=r.doc_no and v.rdtype='rag' left join gl_lagmt l on v.rdocno=l.doc_no and v.rdtype='lag'"
					+"	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
					+"	LEFT JOIN gl_vehreplace VR ON (V.fleet_no="+sqltst2+" and VR.status=3 and reptype='collection' and closestatus=0 "+sqltst+") left join gl_vehpickup vh on (v.fleet_no=vh.fleet_no and v.rdocno=vh.agmtno) where v.fleet_no='"+fleetno+"' and v.doc_no in (select max(doc_no) from gl_vmove where fleet_no='"+fleetno+"')) g ";
		 System.out.println("startfetch===="+strtst);
		 ResultSet rss2=stmtnw.executeQuery(strtst);
		 if(rss2.next())
			{
						 tstype=rss2.getString("typechk");
						 
						 if((tstype.equalsIgnoreCase("DEL"))) {
							  str="select * from(select "+sqltst3+" 0 repno,0 pkupno,'DEL' typechk,coalesce(r.drid,l.drid)drid,coalesce(if(R.DELIVERY=1,r.delstatus,1),if(L.DELIVERY=1,l.delstatus,1))delstatus from gl_vmove v"
										+"	left join gl_ragmt r on v.rdocno=r.doc_no and v.rdtype='rag' left join gl_lagmt l on v.rdocno=l.doc_no and v.rdtype='lag'"
										+"	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
										+"	LEFT JOIN gl_vehreplace VR ON (V.fleet_no="+sqltst2+" and VR.status=3 and reptype='collection' and closestatus=0 "+sqltst+") left join gl_vehpickup vh on (v.fleet_no=vh.fleet_no and v.rdocno=vh.agmtno) where v.fleet_no='"+fleetno+"' and v.doc_no in (select max(doc_no) from gl_vmove where fleet_no='"+fleetno+"')) g "; 
							 
							 
						 }
						 
						 
						 if((tstype.equalsIgnoreCase("RPL")) ){
							 str="select * from(select "+sqltst3+"coalesce(VR.doc_no,0) repno,0 pkupno, 'RPL' typechk,coalesce(r.drid,l.drid)drid,coalesce(if(R.DELIVERY=1,r.delstatus,1),if(L.DELIVERY=1,l.delstatus,1))delstatus from gl_vmove v"
										+"	 LEFT JOIN gl_vehreplace VR ON (V.fleet_no="+sqltst2+" and VR.status=3 and reptype='collection' and closestatus=0 "+sqltst+")	left join gl_ragmt r on ((VR.rdocno=r.doc_no and VR.rtype='rag')) left join gl_lagmt l on ((VR.rdocno=l.doc_no and VR.rtype='lag'))"
										+"	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
										+"	  where v.fleet_no='"+fleetno+"' and v.doc_no in (select max(doc_no) from gl_vmove where fleet_no='"+fleetno+"')) g ";
				 
						 }
						 if(tstype.equalsIgnoreCase("PKUP")){
							 if((tst.equalsIgnoreCase("collection")) || (tst.equalsIgnoreCase("delivery"))){
						 
							 str="select * from(select case when coalesce(VH.doc_no,0)>0 then VH.agmtno else v.rdocno end as rdocno,case when coalesce(VH.doc_no,0)>0 then VH.agmttype else v.rdtype end as rdtype,concat(case when coalesce(VH.doc_no,0)>0 then VH.agmttype else v.rdtype end,'-',coalesce(r.voc_no,l.voc_no),'-',ac.refname,'-',if(coalesce(VH.doc_no,0)>0,floor(VH.pkm),floor(v.kmout))) details,replace(if(coalesce(VH.doc_no,0)>0,VH.pdate,v.dout),'-','.')dout,if(coalesce(VH.doc_no,0)>0,VH.ptime,v.tout)tout,"
				                        +" if(coalesce(VH.doc_no,0)>0,floor(VH.pkm),floor(v.kmout))kmout,if(coalesce(VH.doc_no,0)>0,VH.pfuel,v.fout)fout,if(coalesce(VH.doc_no,0)>0,VH.brhid,v.obrhid)obrhid,if(coalesce(VH.doc_no,0)>0,1,v.olocid)olocid,0 repno,coalesce(vh.doc_no,0) pkupno, 'PKUP' typechk,coalesce(r.drid,l.drid)drid,coalesce(if(R.DELIVERY=1,r.delstatus,1),if(L.DELIVERY=1,l.delstatus,1))delstatus from gl_vmove v"
										+"	left join gl_vehpickup vh on (v.fleet_no=vh.fleet_no and v.rdocno=vh.agmtno) left join gl_ragmt r on ((vh.agmtno=r.doc_no and vh.agmttype='rag')) left join gl_lagmt l on ((vh.agmtno=l.doc_no and vh.agmttype='lag'))"
										+"	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
										+"	  where v.fleet_no='"+fleetno+"' and v.doc_no in (select max(doc_no) from gl_vmove where fleet_no='"+fleetno+"')) g ";
							 }
							 if((tst.equalsIgnoreCase("branchclose")) ){
								 
								 str="select * from(select case when coalesce(c.doc_no,0)>0 then c.agmtno else v.rdocno end as rdocno,case when coalesce(c.doc_no,0)>0 then c.agmttype else v.rdtype end as rdtype,concat(case when coalesce(c.doc_no,0)>0 then c.agmttype else v.rdtype end,'-',coalesce(r.voc_no,l.voc_no),'-',ac.refname,'-',if(coalesce(c.doc_no,0)>0,floor(c.km),floor(v.kmout))) details,replace(if(coalesce(c.doc_no,0)>0,c.datee,v.dout),'-','.')dout,if(coalesce(c.doc_no,0)>0,c.times,v.tout)tout,"
					                        +" if(coalesce(c.doc_no,0)>0,floor(c.km),floor(v.kmout))kmout,if(coalesce(c.doc_no,0)>0,c.fuel,v.fout)fout,if(coalesce(c.doc_no,0)>0,VH.brhid,v.obrhid)obrhid,if(coalesce(c.doc_no,0)>0,1,v.olocid)olocid,0 repno,coalesce(vh.doc_no,0) pkupno, 'PKUP' typechk,coalesce(r.drid,l.drid)drid,coalesce(if(R.DELIVERY=1,r.delstatus,1),if(L.DELIVERY=1,l.delstatus,1))delstatus from gl_vmove v"
											+"	left join gl_vehpickup vh on (v.fleet_no=vh.fleet_no and v.rdocno=vh.agmtno) left join an_acollection c on (vh.agmtno=c.agmtno and vh.agmttype=c.agmttype and vh.doc_no=c.pkupno and binkm is null) left join gl_ragmt r on ((c.agmtno=r.doc_no and c.agmttype='rag')) left join gl_lagmt l on ((c.agmtno=l.doc_no and c.agmttype='lag'))"
											+"	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
											+"	  where v.fleet_no='"+fleetno+"' and v.doc_no in (select max(doc_no) from gl_vmove where fleet_no='"+fleetno+"')) g ";
							 }
						}
			}
		 
		
		 
						 
	}
 	if(!regno.equalsIgnoreCase(""))
	{
 		 Statement stmtnw2 = conn.createStatement(); 
 		String strtst2="select * from(select case when coalesce(VR.doc_no,0)>0 then 'RPL' when coalesce(vh.doc_no,0)>0 then 'PKUP' else 'DEL' end as typechk from gl_vmove v"
 				+"	inner join (select max(g.doc_no) doc_no,fleet_no from gl_vmove g group by fleet_no) v1 on v.fleet_no=v1.fleet_no  and v.doc_no=v1.doc_no"
 				+"	left join gl_ragmt r on v.rdocno=r.doc_no and v.rdtype='rag' left join gl_lagmt l on v.rdocno=l.doc_no and v.rdtype='lag'"
 				+"	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
 				+"	left join gl_vehmaster m on v.fleet_no=m.fleet_no LEFT JOIN gl_vehreplace VR ON (V.fleet_no="+sqltst2+" and VR.status=3 and reptype='collection' and closestatus=0 "+sqltst+") left join gl_vehpickup vh on (v.fleet_no=vh.fleet_no and v.rdocno=vh.agmtno) where m.reg_no='"+regno+"')g ";
 		 ResultSet rss3=stmtnw2.executeQuery(strtst2);
		 while(rss3.next())
			{
			 tstype=rss3.getString("typechk");
			}
		 if((tstype.equalsIgnoreCase("DEL"))) {
			 
			  str="select * from(select "+sqltst3+"'DEL' typechk,0 repno,0 pkupno,coalesce(r.drid,l.drid)drid,coalesce(if(R.DELIVERY=1,r.delstatus,1),if(L.DELIVERY=1,l.delstatus,1))delstatus from gl_vmove v"
		 				+"	inner join (select max(g.doc_no) doc_no,fleet_no from gl_vmove g group by fleet_no) v1 on v.fleet_no=v1.fleet_no  and v.doc_no=v1.doc_no"
		 				+"	left join gl_ragmt r on v.rdocno=r.doc_no and v.rdtype='rag' left join gl_lagmt l on v.rdocno=l.doc_no and v.rdtype='lag'"
		 				+"	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
		 				+"	left join gl_vehmaster m on v.fleet_no=m.fleet_no LEFT JOIN gl_vehreplace VR ON (V.fleet_no="+sqltst2+" and VR.status=3 and reptype='collection' and closestatus=0 "+sqltst+") left join gl_vehpickup vh on (v.fleet_no=vh.fleet_no and v.rdocno=vh.agmtno) where m.reg_no='"+regno+"')g ";
			 
			 
			 
		 }
		 
		 
		 
		 
		 if((tstype.equalsIgnoreCase("RPL"))){
							str="select * from(select "+sqltst3+"coalesce(VR.doc_no,0) repno,0 pkupno,'RPL' typechk,coalesce(r.drid,l.drid)drid,coalesce(if(R.DELIVERY=1,r.delstatus,1),if(L.DELIVERY=1,l.delstatus,1))delstatus from gl_vmove v"
								+"	inner join (select max(g.doc_no) doc_no,fleet_no from gl_vmove g group by fleet_no) v1 on v.fleet_no=v1.fleet_no  and v.doc_no=v1.doc_no"
								+"	 LEFT JOIN gl_vehreplace VR ON (V.fleet_no="+sqltst2+" and VR.status=3 and reptype='collection' and closestatus=0 "+sqltst+")	left join gl_ragmt r on ((VR.rdocno=r.doc_no and VR.rtype='rag')) left join gl_lagmt l on ((VR.rdocno=l.doc_no and VR.rtype='lag'))"
								+"	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
								+"	left join gl_vehmaster m on v.fleet_no=m.fleet_no  where m.reg_no='"+regno+"')g ";
							 }
							 
							 if(tstype.equalsIgnoreCase("PKUP")){
								 if((tst.equalsIgnoreCase("collection")) || (tst.equalsIgnoreCase("delivery"))){
								 str="select * from(select  case when coalesce(VH.doc_no,0)>0 then VH.agmtno else v.rdocno end as rdocno,case when coalesce(VH.doc_no,0)>0 then VH.agmttype else v.rdtype end as rdtype,concat(case when coalesce(VH.doc_no,0)>0 then VH.agmttype else v.rdtype end,'-',coalesce(r.voc_no,l.voc_no),'-',ac.refname,'-',"
										 +" if(coalesce(VH.doc_no,0)>0,floor(VR.pkm),floor(v.kmout))) details,replace(if(coalesce(VH.doc_no,0)>0,VH.pdate,v.dout),'-','.')dout,if(coalesce(VH.doc_no,0)>0,VH.ptime,v.tout)tout,if(coalesce(VH.doc_no,0)>0,floor(VH.pkm),floor(v.kmout))kmout,if(coalesce(VH.doc_no,0)>0,VH.pfuel,v.fout)fout,if(coalesce(VH.doc_no,0)>0,"
								         +" VH.brhid,v.obrhid)obrhid,if(coalesce(VH.doc_no,0)>0,1,v.olocid)olocid,0 repno,coalesce(vh.doc_no,0) pkupno,'PKUP' typechk,coalesce(r.drid,l.drid)drid,coalesce(if(R.DELIVERY=1,r.delstatus,1),if(L.DELIVERY=1,l.delstatus,1))delstatus from gl_vmove v"
											+"	inner join (select max(g.doc_no) doc_no,fleet_no from gl_vmove g group by fleet_no) v1 on v.fleet_no=v1.fleet_no  and v.doc_no=v1.doc_no"
											+"	left join gl_vehpickup vh on (v.fleet_no=vh.fleet_no and v.rdocno=vh.agmtno) left join gl_ragmt r on ((vh.agmtno=r.doc_no and vh.agmttype='rag')) left join gl_lagmt l on ((vh.agmtno=l.doc_no and vh.agmttype='lag'))"
											+"	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
											+"	left join gl_vehmaster m on v.fleet_no=m.fleet_no where m.reg_no='"+regno+"')g ";
								 }
								 if((tst.equalsIgnoreCase("branchclose")) ){
									 
									 str="select * from(select case when coalesce(c.doc_no,0)>0 then c.agmtno else v.rdocno end as rdocno,case when coalesce(c.doc_no,0)>0 then c.agmttype else v.rdtype end as rdtype,concat(case when coalesce(c.doc_no,0)>0 then c.agmttype else v.rdtype end,'-',coalesce(r.voc_no,l.voc_no),'-',ac.refname,'-',if(coalesce(c.doc_no,0)>0,floor(c.km),floor(v.kmout))) details,replace(if(coalesce(c.doc_no,0)>0,c.datee,v.dout),'-','.')dout,if(coalesce(c.doc_no,0)>0,c.times,v.tout)tout,"
						                        +" if(coalesce(c.doc_no,0)>0,floor(c.km),floor(v.kmout))kmout,if(coalesce(c.doc_no,0)>0,c.fuel,v.fout)fout,if(coalesce(c.doc_no,0)>0,VH.brhid,v.obrhid)obrhid,if(coalesce(c.doc_no,0)>0,1,v.olocid)olocid,0 repno,coalesce(vh.doc_no,0) pkupno,'PKUP' typechk,coalesce(r.drid,l.drid)drid,coalesce(if(R.DELIVERY=1,r.delstatus,1),if(L.DELIVERY=1,l.delstatus,1))delstatus from gl_vmove v"
												+"	inner join (select max(g.doc_no) doc_no,fleet_no from gl_vmove g group by fleet_no) v1 on v.fleet_no=v1.fleet_no  and v.doc_no=v1.doc_no"
												+"	left join gl_vehpickup vh on (v.fleet_no=vh.fleet_no and v.rdocno=vh.agmtno) left join an_acollection c on (vh.agmtno=c.agmtno and vh.agmttype=c.agmttype and vh.doc_no=c.pkupno and binkm is null) left join gl_ragmt r on ((c.agmtno=r.doc_no and c.agmttype='rag')) left join gl_lagmt l on ((c.agmtno=l.doc_no and c.agmttype='lag'))"
												+"	left join my_acbook ac on (r.cldocno=ac.cldocno or l.cldocno=ac.cldocno ) and ac.dtype='CRM'"
												+"	left join gl_vehmaster m on v.fleet_no=m.fleet_no  where m.reg_no='"+regno+"')g ";
					 
									 
									 
								 }
								 
								 
							}
			 
			 
			 
			 
			 
	}
		 
		 
		 
		 
		 
		 
	System.out.println("det:"+str);
	ResultSet rs=stmt.executeQuery(str);
	
	 while(rs.next())
	{
		if(i==0){
			value+=rs.getString("rdocno")+"::"+rs.getString("rdtype")+"::"+rs.getString("details")+"::"+rs.getString("dout")+"::"+rs.getString("tout")+"::"+rs.getString("kmout")+"::"+rs.getString("fout")+"::"+rs.getString("obrhid")+"::"+rs.getString("olocid")+"::"+rs.getString("repno")+"::"+rs.getString("pkupno")+"::"+rs.getString("typechk");	
		}
		else{
			value+=","+rs.getString("rdocno")+"::"+rs.getString("rdtype")+"::"+rs.getString("details")+"::"+rs.getString("dout")+"::"+rs.getString("tout")+"::"+rs.getString("kmout")+"::"+rs.getString("fout")+"::"+rs.getString("obrhid")+"::"+rs.getString("olocid")+"::"+rs.getString("repno")+"::"+rs.getString("pkupno")+"::"+rs.getString("typechk");
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