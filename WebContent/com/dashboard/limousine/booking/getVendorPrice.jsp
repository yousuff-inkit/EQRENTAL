<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String jobname=request.getParameter("docname")==null?"":request.getParameter("docname");
String tarifdocno="",tarifdetaildocno="",estdistance="",esttime="",tarif="",exdistancerate="",extimerate="";
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String jobtype="";
	if(jobname.charAt(0)=='T'){
		jobtype="Transfer";
	}
	else{
		jobtype="Limo";
	}
	String strchecknecessary="";
	if(jobtype.equalsIgnoreCase("Transfer")){
		strchecknecessary="select pickuplocid pickuplocid,dropfflocid dropofflocid,gid groupid,m.cldocno,ac.catid,tran.transfertype,tran.assignedvendor from gl_limobooktransfer "+
		" tran left join gl_limobookm m on (tran.bookdocno=m.doc_no) left join my_acbook ac on (tran.assignedvendor=ac.cldocno and ac.dtype='VND') "+
		" where tran.bookdocno="+bookdocno+" and tran.docname='"+jobname+"'";		
	}
	else if(jobtype.equalsIgnoreCase("Limo")){
		strchecknecessary="select pickuplocid pickuplocid,hrs.blockhrs,gid groupid,m.cldocno,ac.catid,hrs.transfertype,hrs.assignedvendor from"+
		" gl_limobookhours hrs left join gl_limobookm m on (hrs.bookdocno=m.doc_no) left join my_acbook ac on (hrs.assignedvendor=ac.cldocno"+
		" and ac.dtype='VND') where hrs.bookdocno="+bookdocno+" and hrs.docname='"+jobname+"'";
	}
	
	ResultSet rschecknecessary=stmt.executeQuery(strchecknecessary);
	int pickuplocation=0,dropofflocation=0,group=0,cldocno=0,catid=0,vendorid=0;
	double blockhrs=0.0;
	String transfertype="";
	while(rschecknecessary.next()){
		pickuplocation=rschecknecessary.getInt("pickuplocid");
		if(jobtype.equalsIgnoreCase("Transfer")){
			dropofflocation=rschecknecessary.getInt("dropofflocid");	
		}
		else{
			blockhrs=rschecknecessary.getDouble("blockhrs");
		}
		group=rschecknecessary.getInt("groupid");
		cldocno=rschecknecessary.getInt("cldocno");
		catid=rschecknecessary.getInt("catid");
		vendorid=rschecknecessary.getInt("assignedvendor");
		transfertype=rschecknecessary.getString("transfertype");
	}
	if(pickuplocation>0 && dropofflocation>0 && group>0 && jobtype.equalsIgnoreCase("Transfer")){
		int isFound=0;
		if(isFound==0){
			String strgettarif="select m.doc_no,m.validto,m.tariftype,m.tarifvendor,m.desc1,tran.estdist estdistance,tran.doc_no "+
			" tarifdetaildocno,tran.esttime,tran.gid,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limovendortarifm m left join gl_limovendortariftransfer tran on"+
			" tran.tarifdocno=m.doc_no  where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+group+" and tran.pickuplocid="+pickuplocation+""+ 
			" and tran.dropofflocid="+dropofflocation+") and m.tariftype='Vendor' and m.tarifvendor="+vendorid+" and m.tariffor='"+transfertype+"' group by m.doc_no";
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
			String strgettarif="select m.doc_no,m.validto,m.tariftype,m.tarifvendor,m.desc1,tran.estdist estdistance,tran.doc_no "+
			" tarifdetaildocno,tran.esttime,tran.gid,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limovendortarifm m left join gl_limovendortariftransfer tran on"+
			" tran.tarifdocno=m.doc_no  where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+group+" and tran.pickuplocid="+pickuplocation+""+ 
			" and tran.dropofflocid="+dropofflocation+") and m.tariftype='Corporate' and m.tarifvendor="+catid+" and m.tariffor='"+transfertype+"' group by m.doc_no";
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
	}
	else if(group>0 && jobtype.equalsIgnoreCase("Limo")){
		int isFound=0;
		if(isFound==0){
			String strgettarif="select m.doc_no,m.validto,m.tariftype,m.tarifvendor,m.desc1,hrs.doc_no tarifdetaildocno,hrs.gid,"+
			" hrs.tarif,hrs.exhrrate,hrs.nighttarif,hrs.nightexhrrate from gl_limovendortarifm m left"+
			" join gl_limovendortarifhours hrs on hrs.tarifdocno=m.doc_no where current_date between m.validfrom and m.validto and"+
			" m.status=3 and (hrs.gid="+group+" and hrs.blockhrs="+blockhrs+") and m.tariftype='Vendor' and m.tarifvendor="+vendorid+" and m.tariffor='"+transfertype+"'"+
			" group by m.doc_no";
			System.out.println(strgettarif);
			ResultSet rsgettarifnew=stmt.executeQuery(strgettarif);
			while(rsgettarifnew.next()){
				tarifdocno=rsgettarifnew.getString("doc_no");
				tarifdetaildocno=rsgettarifnew.getString("tarifdetaildocno");
				tarif=rsgettarifnew.getString("tarif");	
				isFound=1;
			}
		}
		if(isFound==0){
			String strgettarif="select m.doc_no,m.validto,m.tariftype,m.tarifvendor,m.desc1,hrs.doc_no tarifdetaildocno,hrs.gid,"+
			" hrs.tarif,hrs.exhrrate,hrs.nighttarif,hrs.nightexhrrate from gl_limovendortarifm m left"+
			" join gl_limovendortarifhours hrs on hrs.tarifdocno=m.doc_no where current_date between m.validfrom and m.validto and"+
			" m.status=3 and (hrs.gid="+group+" and hrs.blockhrs="+blockhrs+") and m.tariftype='corporate' and m.tarifvendor="+catid+" and m.tariffor='"+transfertype+"'"+
			" group by m.doc_no";
			System.out.println(strgettarif);
			ResultSet rsgettarifnew=stmt.executeQuery(strgettarif);
			while(rsgettarifnew.next()){
				tarifdocno=rsgettarifnew.getString("doc_no");
				tarifdetaildocno=rsgettarifnew.getString("tarifdetaildocno");
				tarif=rsgettarifnew.getString("tarif");	
				isFound=1;
			}
		}
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(tarif);
%>