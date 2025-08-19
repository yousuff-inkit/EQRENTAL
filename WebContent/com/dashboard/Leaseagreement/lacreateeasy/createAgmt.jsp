<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="java.sql.*" %>
<%@page import="com.operations.agreement.leaseagmtformaster.*" %>
<%
String chkadvance=request.getParameter("chkadvance")==null?"":request.getParameter("chkadvance");
String cmbinvtype=request.getParameter("cmbinvtype")==null?"":request.getParameter("cmbinvtype");
String dateout=request.getParameter("dateout")==null?"":request.getParameter("dateout");
String timeout=request.getParameter("timeout")==null?"":request.getParameter("timeout");
String kmout=request.getParameter("kmout")==null?"":request.getParameter("kmout");
String cmbfuelout=request.getParameter("cmbfuelout")==null?"":request.getParameter("cmbfuelout");
String delivery=request.getParameter("delivery")==null?"":request.getParameter("delivery");
String deldriver=request.getParameter("deldriver")==null?"":request.getParameter("deldriver");
String delcharges=request.getParameter("delcharges")==null?"":request.getParameter("delcharges");
String masterrefno=request.getParameter("masterrefno")==null?"":request.getParameter("masterrefno");
String masterrefsrno=request.getParameter("masterrefsrno")==null?"":request.getParameter("masterrefsrno");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String duration=request.getParameter("duration")==null?"":request.getParameter("duration");
String clientdrivers=request.getParameter("clientdrivers")==null?"":request.getParameter("clientdrivers");
Connection conn=null;
int errorstatus=0;
try{
	System.out.println("Delivery Driver:"+deldriver);
	java.sql.Date sqlleasedate=null,sqldateout=null;
	String salesmanid="",desc="";
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsLeaseAgmtForMasterDAO agmtdao=new ClsLeaseAgmtForMasterDAO();
	conn=objconn.getMyConnection();
	
	Statement stmt=conn.createStatement();
	if(!dateout.equalsIgnoreCase("")){
		sqldateout=objcommon.changeStringtoSqlDate(dateout);
	}
	int rsdocno=0;
	String strgetrsveh="select rs.fleetnos fleet_no,rs.doc_no from gl_masterlagm m left join gl_masterlagd d on (m.doc_no=d.rdocno) left join gl_rsrveh "+
	" rs on d.doc_no=rs.rdocno where d.rdocno="+masterrefno+" and d.sr_no="+masterrefsrno+" and m.status<>7";
	ResultSet rsveh=stmt.executeQuery(strgetrsveh);
	while(rsveh.next()){
		rsdocno=rsveh.getInt("doc_no");
	}
	String strmisc="select curdate() leasedate ";
	ResultSet rsmisc=stmt.executeQuery(strmisc);
	while(rsmisc.next()){
		sqlleasedate=rsmisc.getDate("leasedate");	
	}
	String clientname="",acno="";
	if(deldriver.equalsIgnoreCase("")){
		deldriver="0";
	}
	String strgetclientdet="select sal_id salesmanid,refname,acno,brhid from my_acbook where cldocno="+cldocno+" and dtype='CRM'";
	System.out.println("Get Client Data:"+strgetclientdet);
	ResultSet rsgetclientdet=stmt.executeQuery(strgetclientdet);
	int clientbranch=0;
	while(rsgetclientdet.next()){
		salesmanid=rsgetclientdet.getString("salesmanid");
		clientname=rsgetclientdet.getString("refname");
		acno=rsgetclientdet.getString("acno");
		clientbranch=rsgetclientdet.getInt("brhid");
	}
	String strgetmasteragmtdet="select voc_no mastervocno from gl_masterlagm where doc_no="+masterrefno;
	System.out.println("Get Master Data:"+strgetmasteragmtdet);
	ResultSet rsgetmasteragmtdet=stmt.executeQuery(strgetmasteragmtdet);
	while(rsgetmasteragmtdet.next()){
		desc+="Created with reference to Master Agmt "+rsgetmasteragmtdet.getString("mastervocno");
	}
	String strgetmovedata="select ilocid inlocation from gl_vmove where doc_no=(select max(doc_no) from gl_vmove where fleet_no="+fleetno+")";
	System.out.println("Get Mov Data:"+strgetmovedata);
	String inlocation="";
	ResultSet rsgetmovdata=stmt.executeQuery(strgetmovedata);
	while(rsgetmovdata.next()){
		inlocation=rsgetmovdata.getString("inlocation");
	}
	String strgetvehdata="select flname from gl_vehmaster where fleet_no="+fleetno;
	System.out.println("Get Veh Data:"+strgetvehdata);
	String fleetname="";
	ResultSet rsgetvehdata=stmt.executeQuery(strgetvehdata);
	while(rsgetvehdata.next()){
		fleetname=rsgetvehdata.getString("flname");
	}
	ArrayList<String> paymentarray=new ArrayList();
	ArrayList<String> vehdetarray=new ArrayList();
	ArrayList<String> tarifarray=new ArrayList();
	ArrayList<String> driverarray=new ArrayList();
	String chfchk="0";
	/* if(!deldriver.equalsIgnoreCase("0") && !deldriver.equalsIgnoreCase("")){
		chfchk="1";
	} */
	chfchk="0";
	String strgettarifdata="select m.doc_no,m.voc_no,m.po,m.refno,m.cldocno,m.description,m.startdate,m.enddate,m.date,ac.refname,ac.address,ac.per_mob,ac.mail1,ac.contactperson,d.duration,d.rate,d.cdw, d.pai, d.excesskmrate,d.totalcostpermonth, d.drivercostpermonth, d.securitypass, round(d.fuel/d.duration,2) fuel, d.salik, round(d.safetyacc/d.duration) safetyacc, d.diw, d.hpd, d.rateperexhr,"
			   + " m.projectno,p.project_name,d.kmrestrict,(select method  from gl_config where field_nme='Clientinvchk') method,ac.advance,ac.invc_method,ac.contactPerson,ac.mail1,ac.cldocno,trim(ac.RefName) RefName,ac.per_mob,concat(ac.address,'  ',ac.address2) as address ,ac.per_tel,ac.codeno,ac.acno,trim(sm.sal_name) sal_name,sm.doc_no slmdocno "
		       + " from gl_masterlagm m left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') "
		       + " left join my_salm sm on ac.sal_id=sm.doc_no and sm.status<>7 "
		       + " left join gl_masterlagd d on m.doc_no=d.rdocno "
		       + " left join (select count(*) x,masterrefno from gl_lagmt group by masterrefno ) lgmt on m.doc_no=lgmt.masterrefno"
		       + " left join gl_project p on m.projectno=p.doc_no where m.status=3 and m.totalqty-coalesce(lgmt.x,0)>0 and m.doc_no="+masterrefno;
		       System.out.println("Get Tarif Data:"+strgettarifdata);
	ResultSet rsgettarifdata=stmt.executeQuery(strgettarifdata);
	double rate=0.0,cdw=0.0,pai=0.0,kmrest=0.0,exkmrte=0.0,totalcostpermonth=0.0,drivercostpermonth=0.0,securitypass=0.0,fuel=0.0,salik=0.0,safetyacc=0.0,diw=0.0,hpd=0.0,rateperexhr=0.0,chaufchg=0.0;
	while(rsgettarifdata.next()){
		rate=rsgettarifdata.getDouble("rate");
		cdw=rsgettarifdata.getDouble("cdw");
		pai=rsgettarifdata.getDouble("pai");
		kmrest=rsgettarifdata.getDouble("kmrestrict");
		exkmrte=rsgettarifdata.getDouble("excesskmrate");
		totalcostpermonth=rsgettarifdata.getDouble("totalcostpermonth");
		drivercostpermonth=rsgettarifdata.getDouble("drivercostpermonth");
		securitypass=rsgettarifdata.getDouble("securitypass");
		fuel=rsgettarifdata.getDouble("fuel");
		salik=rsgettarifdata.getDouble("salik");
		safetyacc=rsgettarifdata.getDouble("safetyacc");
		diw=rsgettarifdata.getDouble("diw");
		hpd=rsgettarifdata.getDouble("hpd");
		rateperexhr=rsgettarifdata.getDouble("rateperexhr");
		chaufchg=rsgettarifdata.getDouble("drivercostpermonth");
        
	}
	if(delivery.equalsIgnoreCase("")){
		delivery="0";
	}
	String arrdrivers[]=clientdrivers.split(",");
	for(int i=0;i<arrdrivers.length;i++){
		System.out.println(arrdrivers[i]);
		String temp[]=arrdrivers[i].split("::");
		java.sql.Date sqldob=null,sqlpassportexpiry=null,sqlissuedate=null,sqllicenseexpiry=null;
		/* 
		    0          1         2        3          4          5            6               7                  8    
		driverid+"::"+name+"::"+dob+"::"+age+"::"+nation+"::"+mobile+"::"+license+"::"+licenseissued+"::"+licenseexpiry+"::"+
		
		     9              10              11               12
		licensetype+"::"+issuedfrom+"::"+passport+"::"+passportexpiry
		 */
		temp[1]=(temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") ||temp[1].trim().isEmpty()?"":temp[1].trim()).toString(); 
		temp[3]=(temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().equalsIgnoreCase("NaN") || temp[3].trim().equalsIgnoreCase("") ||temp[3].trim().isEmpty()?"":temp[3].trim()).toString();
		temp[4]=(temp[4].trim().equalsIgnoreCase("undefined") || temp[4].trim().equalsIgnoreCase("NaN") || temp[4].trim().equalsIgnoreCase("") ||temp[4].trim().isEmpty()?"":temp[4].trim()).toString();
		temp[5]=(temp[5].trim().equalsIgnoreCase("undefined") || temp[5].trim().equalsIgnoreCase("NaN") || temp[5].trim().equalsIgnoreCase("") ||temp[5].trim().isEmpty()?"":temp[5].trim()).toString();
		temp[6]=(temp[6].trim().equalsIgnoreCase("undefined") || temp[6].trim().equalsIgnoreCase("NaN") || temp[6].trim().equalsIgnoreCase("") ||temp[6].trim().isEmpty()?"":temp[6].trim()).toString();
		temp[9]=(temp[9].trim().equalsIgnoreCase("undefined") || temp[9].trim().equalsIgnoreCase("NaN") || temp[9].trim().equalsIgnoreCase("") ||temp[9].trim().isEmpty()?"":temp[9].trim()).toString();
		temp[10]=(temp[10].trim().equalsIgnoreCase("undefined") || temp[10].trim().equalsIgnoreCase("NaN") || temp[10].trim().equalsIgnoreCase("") ||temp[10].trim().isEmpty()?"":temp[10].trim()).toString();
		temp[11]=(temp[11].trim().equalsIgnoreCase("undefined") || temp[11].trim().equalsIgnoreCase("NaN") || temp[11].trim().equalsIgnoreCase("") ||temp[11].trim().isEmpty()?"":temp[11].trim()).toString();
		temp[12]=(temp[12].trim().equalsIgnoreCase("undefined") || temp[12].trim().equalsIgnoreCase("NaN") || temp[12].trim().equalsIgnoreCase("") ||temp[12].trim().isEmpty()?"":temp[12].trim()).toString();
		if(!temp[2].equalsIgnoreCase("") && !temp[2].equalsIgnoreCase("undefined") && temp[2]!=null && !temp[2].equalsIgnoreCase("null")){
			sqldob=objcommon.changeStringtoSqlDate(temp[2]);
		}
		if(!temp[8].equalsIgnoreCase("") && !temp[8].equalsIgnoreCase("undefined") && temp[8]!=null && !temp[8].equalsIgnoreCase("null")){
			sqllicenseexpiry=objcommon.changeStringtoSqlDate(temp[8]);
		}
		if(!temp[7].equalsIgnoreCase("") && !temp[7].equalsIgnoreCase("undefined") && temp[7]!=null && !temp[7].equalsIgnoreCase("null")){
			sqlissuedate=objcommon.changeStringtoSqlDate(temp[7]);
		}
		if(!temp[12].equalsIgnoreCase("") && !temp[12].equalsIgnoreCase("undefined") && temp[12]!=null && !temp[12].equalsIgnoreCase("null")){
			sqlpassportexpiry=objcommon.changeStringtoSqlDate(temp[12]);
		}
		System.out.println("Temp[0]:"+temp[0]);
		System.out.println(temp[0]+"::"+temp[1]+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[7]+"::"+temp[8]+"::"+temp[9]+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]);
		if(temp[0].equalsIgnoreCase("") || temp[0].equalsIgnoreCase("undefined") || temp[0]==null){
			String strinsertdrv="INSERT INTO gl_drdetails(name,dob,nation,mobno,passport_no,pass_exp,dlno,issdate,issfrm,led,ltype,sr_no,dtype,"+
			" branch,cldocno,doc_no) VALUES('"+temp[1]+"','"+sqldob+"','"+temp[4]+"','"+temp[5]+"','"+temp[11]+"','"+sqlpassportexpiry+"','"+temp[6]+"',"+
			" '"+sqlissuedate+"','"+temp[10]+"','"+sqllicenseexpiry+"','"+temp[9]+"',"+i+",'CRM',"+clientbranch+","+cldocno+","+cldocno+")";
			System.out.println(strinsertdrv);
			int insertdriver=stmt.executeUpdate(strinsertdrv);
			if(insertdriver<=0){
				errorstatus=1;
			}
			else{
				String strgetdrv="select dr_id from gl_drdetails where cldocno="+cldocno+" and dtype='CRM' and sr_no="+i;
				ResultSet rsgetdrv=stmt.executeQuery(strgetdrv);
				while(rsgetdrv.next()){
					driverarray.add(rsgetdrv.getString("dr_id"));
				}
			}
		}
		else{
			driverarray.add(temp[0]);
		}
		//
	}
	/* for(int i=0;i<clientdrivers.split("::").length;i++){
		driverarray.add(clientdrivers.split("::")[i]);
	} */
	for(int i=0;i<driverarray.size();i++){
		System.out.println("Driver:"+driverarray.get(i));
	}
	tarifarray.add(rate+" :: "+cdw+" :: "
			   +pai+" :: "+0.0+" :: "+0.0+" :: "+securitypass+" :: "+0.0+" :: "+0.0+" :: "+kmrest+" :: "
			   +exkmrte+" :: "+chaufchg+" :: "+0.0+" :: "+0+" :: "+totalcostpermonth+" :: "+drivercostpermonth+" :: "+securitypass+" :: "+fuel+" :: "+salik+" :: "+safetyacc+" :: "+diw+" :: "+hpd+" :: "+rateperexhr+" :: ");
	System.out.println(cldocno+","+salesmanid+","+chfchk+","+deldriver+","+delivery+","+duration+","+chkadvance+","+cmbinvtype);
	System.out.println(sqlleasedate+"::"+Integer.parseInt(cldocno)+"::"+Integer.parseInt(salesmanid)+"::"+desc+"::"+cldocno+"::"+acno+"::"+0+"::"+"0"+"::"+Integer.parseInt(chfchk)+"::"+Integer.parseInt(deldriver)+"::"+Integer.parseInt(delivery)+"::"+
			"0"+"::"+fleetno+"::"+fleetname+"::"+dateout+"::"+timeout+"::"+kmout+"::"+cmbfuelout+"::"+""+"::"+""+"::"+""+"::"+""+"::"+""+"::"+""+"::"+""+"::"+""+"::"+
			""+"::"+""+"::"+""+"::"+""+"::"+""+"::"+""+"::"+""+"::"+""+"::"+""+"::"+""+"::"+""+"::"+driverarray+"::"+tarifarray+"::"+paymentarray+"::"+"A"+"::"+session+"::"+"LAG"+"::"+
			1+"::"+Integer.parseInt(duration)+"::"+Integer.parseInt(chkadvance)+"::"+Integer.parseInt(cmbinvtype)+"::"+inlocation+"::"+"LAG"+"::"+clientname+"::"+request+"::"+vehdetarray+"::"+"0"+"::"+0+"::"+""+"::"+
			"QOT"+"::"+masterrefno+"::"+masterrefsrno);
	stmt.close();
	conn.close();
	//agmtdao.insert(sqlleaseDate, clientId, salesmanid, Desc, clcodeno, clacno, addrvchk, adddrvcharges, chfchk, chaufferid, chkdlvry, tempfleet, perfleet, fleetname, dateout, timeout, kmout, fuelout, delDateout, delTimeout, delKmout, delFuelout, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, amt1, amt2, amt3, amt4, amt5, driverarray, lagmttariffarray, paymentarray, mode, session, formcode, per_name, per_value, advance_chk, invoice, Vehlocationid, fromcode, clientname, request, vehdetarray, exinsu, prodoc, po, cmbmasterreftype, masterrefno);
	int val=agmtdao.insert(sqlleasedate, Integer.parseInt(cldocno), Integer.parseInt(salesmanid), desc, cldocno, acno, 0, "0", Integer.parseInt(chfchk), Integer.parseInt(deldriver), Integer.parseInt(delivery), 
			"0", fleetno, fleetname, dateout, timeout, kmout, cmbfuelout, "", "", "", "", "", "", "", "", 
			"", "", "", "", "", "", "", "", "", "", "", driverarray, tarifarray, paymentarray, "A", session, "LAG", 
			2, Integer.parseInt(duration), Integer.parseInt(chkadvance), Integer.parseInt(cmbinvtype), inlocation, "LAG", clientname, request, vehdetarray, "0", 0, "", 
			"MLA", masterrefno);
	/* , masterrefsrno */
	
	if(val<=0){
		errorstatus=1;
	}
	if(val>0){
		boolean status=agmtdao.update(val, sqlleasedate, Integer.parseInt(delivery), "0", fleetno, sqldateout, timeout, kmout, cmbfuelout, 
				inlocation, "E", session, Integer.parseInt(cmbinvtype), paymentarray, delcharges, Integer.parseInt(deldriver), Integer.parseInt(cldocno));
		if(!status){
			System.out.println("LAG Edit Error");
			errorstatus=1;
		}
		/* The method update(int, Date, int, String, String, Date, String, String, String, String, String, HttpSession, 
				 int, ArrayList<String>, String, int, int) in the type ClsLeaseAgmtForMasterAlmariahDAO is not applicable for the 
				 arguments (int, Date, int, int, String, Date, String, String, String, String, String, HttpSession, int, ArrayList<String>, 
				 String, String, String) */
	}
	
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	stmt=conn.createStatement();
	String strmasterupdate="update gl_lagmt set rsvehdocno="+rsdocno+",masterreftype='MLA',masterrefno="+masterrefno+",masterrefsrno="+masterrefsrno+" where doc_no="+val;
	int masterupdate=stmt.executeUpdate(strmasterupdate);
	if(masterupdate<0){
		System.out.println("Master Update Error");
		errorstatus=1;
	}
	
	String strupdate="update gl_masterlagd set outqty=outqty+1 where rdocno="+masterrefno+" and sr_no="+masterrefsrno;
	int updatedetail=stmt.executeUpdate(strupdate);
	if(updatedetail<0){
		System.out.println("MLAGD Update Error");
		errorstatus=1;
	}
	
	/* agmtdao.insert(sqlleaseDate, clientId, salesmanid, Desc, clcodeno, clacno, addrvchk, adddrvcharges, chfchk, chaufferid, chkdlvry, 
			tempfleet, perfleet, fleetname, dateout, timeout, kmout, fuelout, delDateout, delTimeout, delKmout, delFuelout,
			m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, amt1, amt2, amt3, amt4, amt5, driverarray, lagmttariffarray, paymentarray, mode, 
			session, formcode, per_name, per_value, advance_chk, invoice, Vehlocationid, fromcode, clientname, request, vehdetarray, exinsu, 
			prodoc, po, cmbmasterreftype, masterrefno, masterrefsrno); */
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>