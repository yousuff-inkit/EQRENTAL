<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="com.sayaraInternal.*" %>
  
<%	
String value="0";
ClsConnection ClsConnection=new ClsConnection();
Connection conn=null;
	try{
 //System.out.println("======aa==== ");		
		ClsAndroid and=new ClsAndroid();
		ClsCommon com=new ClsCommon();
		
		//String rtype =request.getParameter("rtype");
		//String agmtno=request.getParameter("rdocno");
		String userid=request.getParameter("userid");
		String km=request.getParameter("km");
		String fuel =request.getParameter("fuel");
		String time=request.getParameter("time");
		Date date=com.changeStringtoSqlDate(request.getParameter("date"));
		String kms=request.getParameter("kms");
		String repno=request.getParameter("repno");
		String drvid=request.getParameter("drid");
		String inbrh=request.getParameter("inbrhid");
		String inloc=request.getParameter("inloc");
		String pkupno=request.getParameter("pkupno");
		String typechk=request.getParameter("typechk");
		System.out.println("::"+kms);
		System.out.println(userid+":"+km+":"+fuel+":"+time+":"+date+"==branchclose:repno==="+repno+"==:drvid==="+drvid+"===inbrhid===="+inbrh+"=====inloc====="+inloc);

		conn=ClsConnection.getMyConnection();
		ClsCommon comm = new ClsCommon();
		conn.setAutoCommit(false);
		fuel=and.getFuelvalue(fuel);
		CallableStatement stmtUpdaterent = null;
		 java.sql.Date vmovdout=null,sqlrentaldate=null,sqlrentaldate2=null,sqlrentaldate3=null,sqlrentaldate4=null,sqlrentaldate5=null,sqlrentaldate6=null;
		 int docno=0,val=0;
		 int aa=0;
		 
		 if(Double.parseDouble(km)<Double.parseDouble(kms))
			{
				System.out.println("dd");
				//response.getWriter().write("Delivery KM Less Than Out KM");
				response.getWriter().write("Collection KM Must be greater than Out KM (Out KM:"+kms+")");
				conn.close();
				
				return ;
				 
				
			}
		 
		 
		
			
			
				Statement stmtnw=conn.createStatement();
				/* response.getWriter().write("Updated Successfully"); */
				String vmovtotime="",vmovtout="",vmovkmout="",vmovfout="",agmtno="",clientdoc="",rtype="",tran="",argtype="",rfleetno="",rdate="",cldate="",cltime="",clkm="",clfuel="",indate="",intime="",inkm="",infuel="",parent="",tottime="",totalkm="",totalfuel="",ofleetno="",oparent="",otime="",odate="",okm="",ofuel="",deltime="",deldate="",delkm="",delfuel="",instottime="",instotalkm="",instotalfuel=""; 
				
				if(!(repno.equalsIgnoreCase("0"))){
				
                String tstnw2="update an_acollection set bindate='"+date+"',bintime='"+time+"',binkm="+km+",binfuel="+fuel+",binbrhid="+inbrh+",binlocid="+inloc+" where rplno="+repno+" and rdtype='"+typechk+"'";
					
					val=stmtnw.executeUpdate(tstnw2);
					if(val<0){
						stmtnw.close();
					}
					
					
				String tstnw="update gl_vehreplace set indate='"+date+"',intime='"+time+"',inkm="+km+",infuel="+fuel+",inbrhid="+inbrh+",inloc="+inloc+",closestatus=1 where doc_no="+repno+"";
					
				val=stmtnw.executeUpdate(tstnw);
				if(val<0){
					stmtnw.close();
				}
				
				String tststrt="select coalesce(ra.cldocno,la.cldocno)cldocno,coalesce(r.ofleetno,'')ofleetno,(r.delkm-r.okm)instotalkm,(r.delfuel-r.ofuel)instotalfuel,("+km+"-clkm)totalkm,("+fuel+"-clfuel)totalfuel,coalesce(r.date,'')date,coalesce(r.rfleetno,'')rfleetno,coalesce(r.rtype,'')rtype,coalesce(r.rdocno,'')rdocno,r.cltime,coalesce(r.cldate,'')cldate,coalesce(r.clkm,'')clkm,coalesce(r.clfuel,'')clfuel,coalesce(r.indate,'')indate,coalesce(r.inkm,'')inkm,coalesce(r.infuel,'')infuel,coalesce(r.intime,'')intime,coalesce(r.odate,'')odate,coalesce(r.otime,'')otime,coalesce(r.okm,'')okm,coalesce(r.ofuel,'')ofuel,coalesce(r.deldate,'')deldate,coalesce(r.deltime,'')deltime,coalesce(r.delkm,'')delkm,coalesce(r.delfuel,'')delfuel from gl_vehreplace r left join gl_ragmt ra on (r.rdocno=ra.doc_no and r.rtype='RAG') left join gl_lagmt la on (r.rdocno=la.doc_no and r.rtype='LAG') where r.doc_no="+repno+"";
				System.out.println("RPLdetailfetch===="+tststrt);
				ResultSet rs= stmtnw.executeQuery(tststrt);
				while(rs.next()){
					sqlrentaldate=rs.getDate("date");
					//sqlrentaldate=comm.changeStringtoSqlDate(rdate);
					rfleetno=rs.getString("rfleetno");
					sqlrentaldate2=rs.getDate("cldate");
					//sqlrentaldate2=comm.changeStringtoSqlDate(cldate);
					sqlrentaldate3=rs.getDate("indate");
					//sqlrentaldate3=comm.changeStringtoSqlDate(indate);
					agmtno=rs.getString("rdocno");
					rtype=rs.getString("rtype");
					clientdoc=rs.getString("cldocno");
					cltime=rs.getString("cltime");
					clkm=rs.getString("clkm");
					clfuel=rs.getString("clfuel");
					indate=rs.getString("indate");
					intime=rs.getString("intime");
					inkm=rs.getString("inkm");
					infuel=rs.getString("infuel");
					totalkm=rs.getString("totalkm");
					totalfuel=rs.getString("totalfuel");
					ofleetno=rs.getString("ofleetno");
					sqlrentaldate4=rs.getDate("odate");
					//sqlrentaldate4=comm.changeStringtoSqlDate(odate);
					sqlrentaldate5=rs.getDate("deldate");
					//sqlrentaldate5=comm.changeStringtoSqlDate(deldate);
					otime=rs.getString("otime");
					okm=rs.getString("okm");
					ofuel=rs.getString("ofuel");
					deltime=rs.getString("deltime");
					delkm=rs.getString("delkm");
					delfuel=rs.getString("delfuel");
					instotalkm=rs.getString("instotalkm");
					instotalfuel=rs.getString("instotalfuel");
					System.out.println("=cl="+cltime+"=in="+intime+"=o="+otime+"=del="+deltime+"=time="+time);	
				}
				if(rtype.equalsIgnoreCase("RAG")){
					argtype="RentalAgreement";
					tran="RM";
				}
				if(rtype.equalsIgnoreCase("LAG")){
					argtype="LeaseAgreement";
					tran="LA";
				}else{
					argtype="other";
				}
				String tststrt2="select max(doc_no)maxdoc from gl_vmove where fleet_no="+rfleetno+"";
				System.out.println("vmove==rfleetno==docfetch===="+tststrt2);
				ResultSet rs2= stmtnw.executeQuery(tststrt2);
				while(rs2.next()){
					parent=rs2.getString("maxdoc");
					System.out.println("rfleet==parent===="+parent);
				}
				String tststrt4="select max(doc_no)maxdoc from gl_vmove where fleet_no="+ofleetno+"";
				System.out.println("vmove==ofleetno==docfetch===="+tststrt4);
				ResultSet rs4= stmtnw.executeQuery(tststrt4);
				while(rs4.next()){
					oparent=rs4.getString("maxdoc");
					System.out.println("ofleet==parent===="+oparent);
				}
				String tststrt3="SELECT (TIMESTAMPDIFF(second, aa.ts_din, aa.ts_dout) * 1.0 / 60) tottime FROM (SELECT concat('"+sqlrentaldate2+"',' ','"+cltime+"') AS ts_dout, concat( '"+date+"',' ','"+time+"') AS ts_din)  AS aa";
				System.out.println("firstinserttime======"+tststrt3);
				ResultSet rs3= stmtnw.executeQuery(tststrt3);
				while(rs3.next()){
					tottime=rs3.getString("tottime");
					System.out.println("firstinsert==totaltime===="+tottime);
				}
				String tststrt5="SELECT  (TIMESTAMPDIFF(second, aa.ts_din, aa.ts_dout) * 1.0 / 60) tottime FROM (SELECT concat('"+sqlrentaldate4+"',' ','"+otime+"') AS ts_dout, concat('"+sqlrentaldate5+"',' ','"+deltime+"') AS ts_din)  AS aa";
				System.out.println("secondinserttime======"+tststrt5);
				ResultSet rs5= stmtnw.executeQuery(tststrt5);
				while(rs5.next()){
					instottime=rs5.getString("tottime");
					System.out.println("secondinsert==totaltime===="+instottime);
				}
				
				
				
				String tstchk="select dout,coalesce(tout,'')tout,("+clkm+"-coalesce(kmout,''))kmout,("+clfuel+"-coalesce(fout,''))fout from gl_vmove where rdocno="+agmtno+" and rdtype='"+rtype+"' and status='OUT'";
				System.out.println("vmoveentrydetailsfetch======"+tstchk);
				ResultSet rs7= stmtnw.executeQuery(tstchk);
				while(rs7.next()){
					vmovdout=rs7.getDate("dout");
					vmovtout=rs7.getString("tout");
					vmovkmout=rs7.getString("kmout");
					vmovfout=rs7.getString("fout");
					
					
				}
				
				String tststrt7="SELECT  (TIMESTAMPDIFF(second, aa.ts_din, aa.ts_dout) * 1.0 / 60) tottime FROM (SELECT concat('"+vmovdout+"',' ','"+vmovtout+"') AS ts_dout, concat( '"+sqlrentaldate2+"',' ','"+cltime+"') AS ts_din)  AS aa";
				System.out.println("secondinserttime======"+tststrt7);
				ResultSet rs8= stmtnw.executeQuery(tststrt7);
				while(rs8.next()){
					vmovtotime=rs8.getString("tottime");
					System.out.println("firstlineupdate==totaltime===="+vmovtotime);
				}
				
				String tst="update gl_vmove set din='"+sqlrentaldate2+"',tin='"+cltime+"',kmin="+clkm+",fin="+clfuel+",ibrhid="+inbrh+",ilocid="+inloc+",status='IN',ttime='"+vmovtotime+"',tkm='"+vmovkmout+"',tfuel='"+vmovfout+"' where rdocno="+agmtno+" and rdtype='"+rtype+"' and status='OUT'";
				System.out.println("RPLbranchcloseupdate===="+tst);
				val=stmtnw.executeUpdate(tst);
				if(val<0){
					stmtnw.close();
				}
				String tst2="insert into gl_vmove(date, rdocno, rdtype, fleet_no, trancode, status, parent, repno, exchng, dout, tout, kmout, fout, obrhid, olocid, oreason, din, tin, kmin, fin, ibrhid, ilocid, ireason, iaccident, ttime, tkm, tfuel, trent, tideal, emp_id, emp_type, custno, fuel_invno, km_invno, DOC_NOOLD) values('"+sqlrentaldate+"','"+agmtno+"','"+rtype+"','"+rfleetno+"','DL','IN','"+parent+"','"+repno+"','0','"+sqlrentaldate2+"','"+cltime+"','"+clkm+"','"+clfuel+"','"+inbrh+"','"+inloc+"','"+argtype+"','"+date+"','"+time+"','"+km+"','"+fuel+"','"+inbrh+"','"+inloc+"','"+argtype+"','0','"+tottime+"','"+totalkm+"','"+totalfuel+"','0','0','"+drvid+"','DRV','0','0','0','0')";
				System.out.println("firstinsert===vmove==="+tst2);
				val=stmtnw.executeUpdate(tst2);
				if(val<0){
					stmtnw.close();
				}
				
				String tst3="insert into gl_vmove(date, rdocno, rdtype, fleet_no, trancode, status, parent, repno, exchng, dout, tout, kmout, fout, obrhid, olocid, oreason, din, tin, kmin, fin, ibrhid, ilocid, ireason, iaccident, ttime, tkm, tfuel, trent, tideal, emp_id, emp_type, custno, fuel_invno, km_invno, DOC_NOOLD) values('"+sqlrentaldate+"','"+agmtno+"','"+rtype+"','"+ofleetno+"','DL','IN','"+oparent+"','"+repno+"','0','"+sqlrentaldate4+"','"+otime+"','"+okm+"','"+ofuel+"','"+inbrh+"','"+inloc+"','"+argtype+"','"+sqlrentaldate5+"','"+deltime+"','"+delkm+"','"+delfuel+"','"+inbrh+"','"+inloc+"','"+argtype+"','0','"+instottime+"','"+instotalkm+"','"+instotalfuel+"','0','0','"+drvid+"','DRV','0','0','0','0')";
				System.out.println("secondinsert===vmove==="+tst3);
				val=stmtnw.executeUpdate(tst3);
				if(val<0){
					stmtnw.close();
				}
				
				String tststrt6="select max(doc_no)maxdoc from gl_vmove where fleet_no="+ofleetno+"";
				System.out.println("vmove==ofleetno2nd==docfetch===="+tststrt6);
				ResultSet rs6= stmtnw.executeQuery(tststrt6);
				while(rs6.next()){
					oparent=rs6.getString("maxdoc");
					System.out.println("ofleet2nd==parent===="+oparent);
				}
				
				String tst4="insert into gl_vmove(date, rdocno, rdtype, fleet_no, trancode, status, parent, repno, exchng, dout, tout, kmout, fout, obrhid, olocid, oreason, tin, kmin, fin, ibrhid, ilocid, ireason, iaccident, ttime, tkm, tfuel, trent, tideal, emp_id, emp_type, custno, fuel_invno, km_invno, DOC_NOOLD) values('"+sqlrentaldate+"','"+agmtno+"','"+rtype+"','"+ofleetno+"','"+tran+"','OUT','"+oparent+"','"+repno+"','0','"+sqlrentaldate5+"','"+deltime+"','"+delkm+"','"+delfuel+"','"+inbrh+"','"+inloc+"','"+argtype+"','0','0','0','0','0','0','0','0','0','0','0','0','"+clientdoc+"','CRM','0','0','0','0')";
				System.out.println("thirdinsert===vmove==="+tst4);
				val=stmtnw.executeUpdate(tst4);
				if(val<0){
					stmtnw.close();
				}
				
				}
				else if(!(pkupno.equalsIgnoreCase("0"))){
					String tstnw="update an_acollection set bindate='"+date+"',bintime='"+time+"',binkm="+km+",binfuel="+fuel+",binbrhid="+inbrh+",binlocid="+inloc+" where pkupno="+pkupno+" and rdtype='"+typechk+"'";
					
					val=stmtnw.executeUpdate(tstnw);
					if(val<0){
						stmtnw.close();
					}
				}
				else{
					stmtnw.close();
				}
			
				if(val>0){
					conn.commit();
					value="1";
				}else{
					stmtnw.close();
				}
		 	
	}
	catch(Exception e){
		
		
	 	e.printStackTrace();
	 	/* conn.close(); */ 
	 	/*  response.getWriter().write("Not Updated"); */
	}
	finally
	{
		conn.close();
	}
	response.getWriter().write(value);
	
  %>