<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String strgridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	ArrayList<String> gridarray=new ArrayList();
	String strupdatecondition="",strmgmtcondition="";
	for(int i=0;i<strgridarray.split(",").length;i++){
		String temparray[]=strgridarray.split(",")[i].split("::");
		String bookdocno=temparray[0].trim().equalsIgnoreCase("") || temparray[0].trim().equalsIgnoreCase("undefined") || temparray[0].trim()==null || temparray[0].trim().equalsIgnoreCase("0")?"":temparray[0].trim();
		String jobname=temparray[1].trim().equalsIgnoreCase("") || temparray[1].trim().equalsIgnoreCase("undefined") || temparray[1].trim()==null || temparray[1].trim().equalsIgnoreCase("0")?"":temparray[1].trim();
		String pickuplocid=temparray[2].trim().equalsIgnoreCase("") || temparray[2].trim().equalsIgnoreCase("undefined") || temparray[2].trim()==null || temparray[2].trim().equalsIgnoreCase("0")?"":temparray[2].trim();
		String dropofflocid=temparray[3].trim().equalsIgnoreCase("") || temparray[3].trim().equalsIgnoreCase("undefined") || temparray[3].trim()==null || temparray[3].trim().equalsIgnoreCase("0")?"":temparray[3].trim();
		String groupid=temparray[4].trim().equalsIgnoreCase("") || temparray[4].trim().equalsIgnoreCase("undefined") || temparray[4].trim()==null || temparray[4].trim().equalsIgnoreCase("0")?"":temparray[4].trim();
		String strpickuplocation="",strdropofflocation="",strgroup="";
		int pickupairport=0,dropoffairport=0;
		if(!pickuplocid.equalsIgnoreCase("")){
			strupdatecondition+=strupdatecondition.equalsIgnoreCase("")?"pickuplocid="+pickuplocid+"":",pickuplocid="+pickuplocid;
			String strgetlocation="select location,chkairport from gl_cordinates where status=3 and doc_no="+pickuplocid;
			ResultSet rsgetlocation=stmt.executeQuery(strgetlocation);
			while(rsgetlocation.next()){
				strpickuplocation=rsgetlocation.getString("location");
				pickupairport=rsgetlocation.getInt("chkairport");				
			}
			strmgmtcondition+=strmgmtcondition.equalsIgnoreCase("")?"plocation='"+strpickuplocation+"'":",plocation='"+strpickuplocation+"'";
			if(pickupairport>0){
				strmgmtcondition+=strmgmtcondition.equalsIgnoreCase("")?"triptype='Arrival'":",triptype='Arrival'";
				strupdatecondition+=strupdatecondition.equalsIgnoreCase("")?"triptype='Arrival'":",triptype='Arrival'";
			}
		}
		if(!dropofflocid.equalsIgnoreCase("")){
			strupdatecondition+=strupdatecondition.equalsIgnoreCase("")?"dropfflocid="+dropofflocid+"":",dropfflocid="+dropofflocid;
			String strgetlocation="select location,chkairport from gl_cordinates where status=3 and doc_no="+dropofflocid;
			ResultSet rsgetlocation=stmt.executeQuery(strgetlocation);
			while(rsgetlocation.next()){
				strdropofflocation=rsgetlocation.getString("location");
				dropoffairport=rsgetlocation.getInt("chkairport");
			}
			strmgmtcondition+=strmgmtcondition.equalsIgnoreCase("")?"dlocation='"+strdropofflocation+"'":",dlocation='"+strdropofflocation+"'";
			if(dropoffairport>0){
				strmgmtcondition+=strmgmtcondition.equalsIgnoreCase("")?"triptype='Departure'":",triptype='Departure'";
				strupdatecondition+=strupdatecondition.equalsIgnoreCase("")?"triptype='Departure'":",triptype='Departure'";
			}
		}
		if(!groupid.equalsIgnoreCase("")){
			strupdatecondition+=strupdatecondition.equalsIgnoreCase("")?"gid="+groupid+"":",gid="+groupid;
			String strgetgroup="select gname from gl_vehgroup where doc_no="+groupid+" and status=3";
			ResultSet rsgetgroup=stmt.executeQuery(strgetgroup);
			while(rsgetgroup.next()){
				strgroup=rsgetgroup.getString("gname");
			}
			strmgmtcondition+=strmgmtcondition.equalsIgnoreCase("")?"groupname='"+strgroup+"'":",groupname='"+strgroup+"'";
		}
		String strupdate="update gl_limobooktransfer set "+strupdatecondition+" where bookdocno="+bookdocno+" and docname='"+jobname+"'";
		int update=stmt.executeUpdate(strupdate);
		if(update<=0){
			errorstatus=1;
		}
		if(!strmgmtcondition.equalsIgnoreCase("")){
			String strupdatemgmt="update gl_limomanagement set "+strmgmtcondition+" where docno="+bookdocno+" and job='"+jobname+"'";
			int updatemgmt=stmt.executeUpdate(strupdatemgmt);
			if(updatemgmt<=0){
				errorstatus=1;
			}
		}
		
		String strchecknecessary="select pickuplocid pickuplocid,dropfflocid dropofflocid,gid groupid,m.cldocno,ac.catid,tran.transfertype from gl_limobooktransfer "+
		" tran left join gl_limobookm m on (tran.bookdocno=m.doc_no) left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') "+
		" where tran.bookdocno="+bookdocno+" and tran.docname='"+jobname+"'";
		ResultSet rschecknecessary=stmt.executeQuery(strchecknecessary);
		int pickuplocation=0,dropofflocation=0,group=0,cldocno=0,catid=0;
		String transfertype="";
		while(rschecknecessary.next()){
			pickuplocation=rschecknecessary.getInt("pickuplocid");
			dropofflocation=rschecknecessary.getInt("dropofflocid");
			group=rschecknecessary.getInt("groupid");
			cldocno=rschecknecessary.getInt("cldocno");
			catid=rschecknecessary.getInt("catid");
			transfertype=rschecknecessary.getString("transfertype");
		}
		if(pickuplocation>0 && dropofflocation>0 && group>0){
			int isFound=0;
			String tarifdocno="",tarifdetaildocno="",estdistance="",esttime="",tarif="",exdistancerate="",extimerate="";
			String strgettarif="select m.doc_no,m.validto,m.tarifclient,tran.gid,tran.doc_no tarifdetaildocno,tran.estdist estdistance,"+
			" tran.esttime,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm  m left join gl_limotariftransfer tran "+
			" on tran.tarifdocno=m.doc_no where current_date between m.validfrom and "+
			" m.validto and m.status=3 and (tran.gid="+group+" and tran.pickuplocid="+pickuplocation+" and tran.dropofflocid="+dropofflocation+") "+
			" and m.tariftype='Client' and m.tarifclient="+cldocno+" and m.tariffor='"+transfertype+"' group by m.doc_no";
			System.out.println(strgettarif);
			ResultSet rsgettarif=stmt.executeQuery(strgettarif);
			while(rsgettarif.next()){
				tarifdocno=rsgettarif.getString("doc_no");
				tarifdetaildocno=rsgettarif.getString("tarifdetaildocno");
				estdistance=rsgettarif.getString("estdistance");
				esttime=rsgettarif.getString("esttime");
				tarif=rsgettarif.getString("tarif");
				exdistancerate=rsgettarif.getString("exdistancerate");
				extimerate=rsgettarif.getString("extimerate");
				isFound=1;
			}
			if(isFound==0){
				strgettarif="select m.doc_no,m.validto,m.tariftype,m.tarifclient,m.desc1,tran.estdist estdistance,tran.doc_no "+
				" tarifdetaildocno,tran.esttime,tran.gid,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm m left join gl_limotariftransfer tran on"+
				" tran.tarifdocno=m.doc_no  where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+group+" and tran.pickuplocid="+pickuplocation+""+ 
				" and tran.dropofflocid="+dropofflocation+") and m.tariftype='Corporate' and m.tarifclient="+catid+" and m.tariffor='"+transfertype+"' group by m.doc_no";
				System.out.println(strgettarif);
				ResultSet rsgettarifnew=stmt.executeQuery(strgettarif);
				while(rsgettarifnew.next()){
					tarifdocno=rsgettarifnew.getString("doc_no");
					tarifdetaildocno=rsgettarifnew.getString("tarifdetaildocno");
					estdistance=rsgettarifnew.getString("estdistance");
					esttime=rsgettarifnew.getString("esttime");
					tarif=rsgettarifnew.getString("tarif");
					exdistancerate=rsgettarifnew.getString("exdistancerate");
					extimerate=rsgettarifnew.getString("extimerate");
					isFound=1;
				}
			}
			if(isFound==0){
				strgettarif="select m.doc_no,m.validto,m.tarifclient,tran.doc_no tarifdetaildocno,tran.gid,tran.estdist estdistance,"+
				" tran.esttime,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm  m left join gl_limotariftransfer tran on tran.tarifdocno=m.doc_no "+ 
				" where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+group+" and tran.pickuplocid="+pickuplocation+" and "+
				" tran.dropofflocid="+dropofflocation+") and m.tariftype='regular' and m.tariffor='"+transfertype+"' group by m.doc_no";
				System.out.println(strgettarif);
				ResultSet rsgettarifnew=stmt.executeQuery(strgettarif);
				while(rsgettarifnew.next()){
					tarifdocno=rsgettarifnew.getString("doc_no");
					tarifdetaildocno=rsgettarifnew.getString("tarifdetaildocno");
					estdistance=rsgettarifnew.getString("estdistance");
					esttime=rsgettarifnew.getString("esttime");
					tarif=rsgettarifnew.getString("tarif");
					exdistancerate=rsgettarifnew.getString("exdistancerate");
					extimerate=rsgettarifnew.getString("extimerate");
					isFound=1;
				}
			}
			
			if(isFound==1){
				String strupdatetarif="update gl_limobooktransfer set tarifdocno="+tarifdocno+",tarifdetaildocno="+tarifdetaildocno+","+
				" estdist="+estdistance+", esttime='"+esttime+"',tarif="+tarif+", exdistrate="+exdistancerate+",extimerate="+extimerate+","+
				" detailupdate=1 where bookdocno="+bookdocno+" and docname='"+jobname+"'";
				int updatetarif=stmt.executeUpdate(strupdatetarif);
				if(updatetarif<=0){
					errorstatus=1;
				}
				
				String strupdatemgmttarif="update gl_limomanagement set tarifdocno="+tarifdocno+",tarifdetaildocno="+tarifdetaildocno+" where docno="+bookdocno+" and job='"+jobname+"'";
				int updatemgmttarif=stmt.executeUpdate(strupdatemgmttarif);
				if(updatemgmttarif<=0){
					errorstatus=1;
				}
			}
		}
	}
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>