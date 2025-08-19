<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
int errorstatus=0;
String docno=request.getParameter("docno")==null?"":request.getParameter("docno").toString();
String doneby=request.getParameter("doneby")==null?"":request.getParameter("doneby").toString();
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno").toString();
String drvdocno=request.getParameter("drvdocno")==null?"":request.getParameter("drvdocno").toString();
String date=request.getParameter("date")==null?"":request.getParameter("date").toString();
String time=request.getParameter("time")==null?"":request.getParameter("time").toString();
String km=request.getParameter("km")==null?"":request.getParameter("km").toString();
String fuel=request.getParameter("fuel")==null?"":request.getParameter("fuel").toString();
String mode=request.getParameter("mode")==null?"":request.getParameter("mode").toString();
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks").toString();
String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile").toString();
String calcdocno=request.getParameter("calcdocno")==null?"":request.getParameter("calcdocno").toString();
String fleetname=request.getParameter("fleetname")==null?"":request.getParameter("fleetname").toString();
String drivername=request.getParameter("drivername")==null?"":request.getParameter("drivername").toString();
String equipno=request.getParameter("equipno")==null?"":request.getParameter("equipno").toString();
String gridindex=request.getParameter("gridindex")==null?"":request.getParameter("gridindex").toString();
String gridlength=request.getParameter("gridlength")==null?"":request.getParameter("gridlength").toString();
String address=request.getParameter("address")==null?"":request.getParameter("address").toString();
String vendordocno=request.getParameter("vendordocno")==null?"":request.getParameter("vendordocno").toString();
String vendorinvno=request.getParameter("vendorinvno")==null?"":request.getParameter("vendorinvno").toString();
String vendoramt=request.getParameter("vendoramt")==null?"":request.getParameter("vendoramt").toString();
String vendorvatamt=request.getParameter("vendorvatamt")==null?"":request.getParameter("vendorvatamt").toString();
String vendornetamt=request.getParameter("vendornetamt")==null?"":request.getParameter("vendornetamt").toString();
String strgridarray[]=request.getParameterValues("gridarray[]")==null?null:request.getParameterValues("gridarray[]");
String vendorinvdate=request.getParameter("vendorinvdate")==null?"":request.getParameter("vendorinvdate").toString();

ArrayList<String> gridarray=new ArrayList();
for(int i=0;i<strgridarray.length;i++){
	gridarray.add(strgridarray[i]);
}
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	
	//Updating in Rental Quote Calc - Corresponding to each equipment
	java.sql.Date sqldate=null,sqlvendorinvdate=null;
	if(!date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	if(!vendorinvno.equalsIgnoreCase("")){
		sqlvendorinvdate=objcommon.changeStringtoSqlDate(vendorinvdate);
	}
	String strupdatecalc="";
	int deldocno=0;
	String sessionbranch=session.getAttribute("BRANCHID")==null?"0":session.getAttribute("BRANCHID").toString();
	if(mode.equalsIgnoreCase("1")){
		String strdeldocno="select coalesce(max(deldocno),0)+1 deldocno from eq_deldetails";
		ResultSet rsdeldocno=stmt.executeQuery(strdeldocno);
		while(rsdeldocno.next()){
			deldocno=rsdeldocno.getInt("deldocno");
		}
		/* 
		String strdel="";
		if(sqlvendorinvdate!=null){
			strdel="insert into eq_deldetails(deldocno,vndid, invno, amount, vat, netamt, fleet, driver, date, time, km, fuel, address, remarks,brhid, userid,vendorinvdate)values("+deldocno+","+vendordocno+",'"+vendorinvno+"',"+vendoramt+","+vendorvatamt+","+vendornetamt+",'"+fleetname+"','"+drivername+"','"+sqldate+"','"+time+"',"+km+","+fuel+",'"+address+"','"+remarks+"',"+sessionbranch+","+userid+",'"+sqlvendorinvdate+"')";
		}
		else{
			strdel="insert into eq_deldetails(deldocno,vndid, invno, amount, vat, netamt, fleet, driver, date, time, km, fuel, address, remarks,brhid, userid)values("+deldocno+","+vendordocno+",'"+vendorinvno+"',"+vendoramt+","+vendorvatamt+","+vendornetamt+",'"+fleetname+"','"+drivername+"','"+sqldate+"','"+time+"',"+km+","+fuel+",'"+address+"','"+remarks+"',"+sessionbranch+","+userid+")";
		}
		
		 */
		String strdel="insert into eq_deldetails(deldocno,date,time,km,fuel,address,remarks,brhid,userid,doneby,mobile) values("+deldocno+",'"+sqldate+"','"+time+"',"+km+","+fuel+",'"+address+"','"+remarks+"',"+sessionbranch+","+userid+","+doneby+",'"+mobile+"')";
		int del=stmt.executeUpdate(strdel);
		if(del<=0){
			System.out.println("Del Details Master Insert Error");
			errorstatus=1;
		}
	}
	
	for(int i=0;i<gridarray.size();i++){
		if(mode.equalsIgnoreCase("1")){
			calcdocno=gridarray.get(i).split("::")[0].trim();
			equipno=gridarray.get(i).split("::")[1].trim();
			docno=gridarray.get(i).split("::")[2].trim();
		}
		else{
			calcdocno=gridarray.get(i).split("::")[0].trim();
			equipno=gridarray.get(i).split("::")[1].trim();
			docno=gridarray.get(i).split("::")[2].trim();
			fleetno=gridarray.get(i).split("::")[3].trim();
			doneby=gridarray.get(i).split("::")[4].trim();			
		}
		
		if(mode.equalsIgnoreCase("2")){
			//Getting deldocno
			String strgetdeldocno="select deldocno from gl_rentalquotecalc where doc_no="+calcdocno;
			ResultSet rsgetdeldocno=stmt.executeQuery(strgetdeldocno);
			while(rsgetdeldocno.next()){
				deldocno=rsgetdeldocno.getInt("deldocno");
			}
		}
		//Getting Relevant Data
		
		String strgetcontractdet="select m.brhid,loc.doc_no locid,cldocno from gl_rentalcontractm m left join my_locm loc on m.brhid=loc.brhid where m.doc_no="+docno+" group by m.doc_no";
		ResultSet rsgetcontractdet=stmt.executeQuery(strgetcontractdet);
		int brhid=0,locid=0,cldocno=0;
		while(rsgetcontractdet.next()){
			brhid=rsgetcontractdet.getInt("brhid");
			locid=rsgetcontractdet.getInt("locid");
			cldocno=rsgetcontractdet.getInt("cldocno");
		}
		String strupdatedelfilter="";
		String strupdatedel="";
		if(mode.equalsIgnoreCase("1")){
			String sqlfilters1="";
			if(doneby.equalsIgnoreCase("3")){
				sqlfilters1+=" vendordocno="+vendordocno+",vendorinvno='"+vendorinvno+"',vendoramt="+vendoramt+",vendorvatamt="+vendorvatamt+",vendornetamt="+vendornetamt+",";
				strupdatedelfilter+=" vndid="+vendordocno+",invno='"+vendorinvno+"',invdate='"+sqlvendorinvdate+"',amount="+vendoramt+",vat="+vendorvatamt+",netamt="+vendornetamt+",";
			}
			if(doneby.equalsIgnoreCase("1")){
				sqlfilters1+=" delstartkm="+km+",delstartfuel="+fuel+",delfleetno="+fleetno+",deldrvdocno="+drvdocno+",";
				strupdatedelfilter+=" deldrvdocno="+drvdocno+",delfleetno="+fleetno+",";
			}
			if(!doneby.equalsIgnoreCase("1")){
				if(sqlfilters1.equalsIgnoreCase("")){
					sqlfilters1+=" invdate='"+sqldate+"',invtodate=last_day('"+sqldate+"'),";
				}
				else{
					sqlfilters1+=" invdate='"+sqldate+"',invtodate=last_day('"+sqldate+"'),";
				}
			}
			strupdatecalc="update gl_rentalquotecalc set "+sqlfilters1+" deldocno="+deldocno+",address='"+address+"',delstartdate='"+sqldate+"',delstarttime='"+time+"',doneby="+doneby+",delmode="+mode+",delfleetname='"+fleetname+"',drivername='"+drivername+"' where doc_no="+calcdocno;
			strupdatedel="update eq_deldetails set "+strupdatedelfilter+" fleet='"+fleetname+"',driver='"+drivername+"' where deldocno="+deldocno;
			
		}
		else if(mode.equalsIgnoreCase("2")){
			String sqlfilters1="";
			if(doneby.equalsIgnoreCase("1")){
				sqlfilters1+=" delendkm="+km+",delendfuel="+fuel+",invdate='"+sqldate+"',invtodate=last_day('"+sqldate+"'),";
			}
			strupdatecalc="update gl_rentalquotecalc set "+sqlfilters1+" delenddate='"+sqldate+"',delendtime='"+time+"',delmode="+mode+" where doc_no="+calcdocno;
			strupdatedel="update eq_deldetails set enddate='"+sqldate+"',endtime='"+time+"',endkm="+km+",endfuel="+fuel+",endremarks='"+remarks+"' where deldocno="+deldocno;
		}
		
		System.out.println(strupdatecalc);
		int updatecalc=stmt.executeUpdate(strupdatecalc);
		if(updatecalc<=0){
			System.out.println("Calc Update Error");
			errorstatus=1;
		}
		int updatedel=stmt.executeUpdate(strupdatedel);
		if(updatedel<=0){
			System.out.println("Del Update Error");
			errorstatus=1;
		}
		
		if(doneby.equalsIgnoreCase("1") && mode.equalsIgnoreCase("1")){
			System.out.println("Inside Own");
			if(i==gridarray.size()-1){
				String strinsertmov="insert into gl_vmove(date,rdocno,rdtype,fleet_no,trancode,status,parent,repno,exchng,dout,tout,kmout,fout,obrhid,olocid,oreason,emp_id,emp_type)values"+
				" (CURDATE(),"+docno+",'ERC',"+fleetno+",'DL','OUT',0,0,0,'"+sqldate+"','"+time+"',"+km+","+fuel+","+brhid+","+locid+",'"+remarks+"',"+drvdocno+",'DRV')";
				System.out.println(strinsertmov);
				int insertmov=stmt.executeUpdate(strinsertmov);
				if(insertmov<=0){
					System.out.println("Vmove insert Error");
					errorstatus=1;
				}	
				
				String strupdateveh="update gl_vehmaster set tran_code='DL',status='OUT' where fleet_no="+fleetno;
				int updateveh=stmt.executeUpdate(strupdateveh);
				if(updateveh<=0){
					System.out.println("Vehicle Master Update Error");
				}
			}
			
			String strinsertemov="insert into gl_emove(date,rdocno,rdtype,fleet_no,trancode,status,parent,repno,exchng,dout,tout,kmout,fout,obrhid,olocid,oreason,emp_id,emp_type)values"+
			" (CURDATE(),"+docno+",'ERC',"+equipno+",'DL','OUT',0,0,0,'"+sqldate+"','"+time+"',"+km+","+fuel+","+brhid+","+locid+",'"+remarks+"',"+drvdocno+",'DRV')";
			System.out.println(strinsertemov);
			int insertemov=stmt.executeUpdate(strinsertemov);
			if(insertemov<=0){
				errorstatus=1;
				System.out.println("Equip Mov Insert Error");
			}
			
			String strupdateequip="update gl_equipmaster set tran_code='DL',status='OUT' where fleet_no="+equipno;
			int updateequip=stmt.executeUpdate(strupdateequip);
			if(updateequip<=0){
				System.out.println("Equip Master Update Error");
			}
		}
		if(doneby.equalsIgnoreCase("2") && mode.equalsIgnoreCase("1")){
			System.out.println("Inside Vendor");
			String strinsertemov="insert into gl_emove(date,rdocno,rdtype,fleet_no,trancode,status,parent,repno,exchng,dout,tout,kmout,fout,obrhid,olocid,oreason,emp_id,emp_type)values"+
			" (CURDATE(),"+docno+",'ERC',"+equipno+",'RA','OUT',0,0,0,'"+sqldate+"','"+time+"',"+km+","+fuel+","+brhid+","+locid+",'"+remarks+"',"+cldocno+",'CRM')";
			System.out.println(strinsertemov);
			int insertemov=stmt.executeUpdate(strinsertemov);
			if(insertemov<=0){
				System.out.println("Equip Mov Insert Error");
				errorstatus=1;
			}
			
			String strupdateequip="update gl_equipmaster set tran_code='DL',status='OUT' where fleet_no="+equipno;
			int updateequip=stmt.executeUpdate(strupdateequip);
			if(updateequip<=0){
				System.out.println("Equip Master Update Error");
			}
		}
		if(doneby.equalsIgnoreCase("1") && mode.equalsIgnoreCase("2")){
			System.out.println("Inside Own");
			if(i==gridarray.size()-1){
				String strinsertmov="update gl_vmove set status='IN',din='"+sqldate+"',tin='"+time+"',kmin="+km+",fin="+fuel+",ibrhid="+brhid+",ilocid="+locid+",ireason='"+remarks+"' where rdocno="+docno+" and rdtype='ERC' and fleet_no="+fleetno+" and status='OUT'"; 
				System.out.println(strinsertmov);
				int insertmov=stmt.executeUpdate(strinsertmov);
				if(insertmov<=0){
					System.out.println("Vehicle Mov Update Error");
					errorstatus=1;
				}
				int maxmovdocno=0;
				String strmaxmovdocno="select max(doc_no) maxdocno from gl_vmove where rdocno="+docno+" and rdtype='ERC' and fleet_no="+fleetno+" and status='IN'";
				ResultSet rsmaxmovdocno=stmt.executeQuery(strmaxmovdocno);
				while(rsmaxmovdocno.next()){
					maxmovdocno=rsmaxmovdocno.getInt("maxdocno");
				}
				String strupdatemov="update gl_vmove set ttime=timestampdiff(second,concat(dout,' ',tout),concat(din,' ',tin))/60,tkm=round(kmin-kmout,2),tfuel=fin-fout where doc_no="+maxmovdocno;
				System.out.println(strupdatemov);
				int updatemov=stmt.executeUpdate(strupdatemov);
				if(updatemov<=0){
					System.out.println("Vehicle Mov 2 Update Error");
					errorstatus=1;
				}	
			
				String strupdateveh="update gl_vehmaster set tran_code='UR',status='IN' where fleet_no="+fleetno;
				int updateveh=stmt.executeUpdate(strupdateveh);
				if(updateveh<=0){
					System.out.println("Vehicle Master Update Error");
					errorstatus=1;		
				}
			}
			
			String strupdateemov="update gl_emove set status='IN',din='"+sqldate+"',tin='"+time+"',kmin="+km+",fin="+fuel+",ibrhid="+brhid+",ilocid="+locid+",ireason='"+remarks+"' where rdocno="+docno+" and rdtype='ERC' and fleet_no="+equipno+" and status='OUT'"; 
			System.out.println(strupdateemov);
			int updateemov=stmt.executeUpdate(strupdateemov);
			if(updateemov<=0){
				System.out.println("Equipment Move Update Error");
				errorstatus=1;
			}
			

			String strupdateequip="update gl_equipmaster set tran_code='RA',status='OUT' where fleet_no="+equipno;
			int updateequip=stmt.executeUpdate(strupdateequip);
			if(updateequip<=0){
				System.out.println("EquipMaster Update Error");
			}
			String strinsertemov="insert into gl_emove(date,rdocno,rdtype,fleet_no,trancode,status,parent,repno,exchng,dout,tout,kmout,fout,obrhid,olocid,oreason,emp_id,emp_type)values"+
			" (CURDATE(),"+docno+",'ERC',"+equipno+",'RA','OUT',0,0,0,'"+sqldate+"','"+time+"',"+km+","+fuel+","+brhid+","+locid+",'"+remarks+"',"+cldocno+",'CRM')";
			System.out.println(strinsertemov);
			int insertemov=stmt.executeUpdate(strinsertemov);
			if(insertemov<=0){
				System.out.println("Equip Mov Insert Error");
				errorstatus=1;
			}
		}
		if(doneby.equalsIgnoreCase("2") && mode.equalsIgnoreCase("2")){
			System.out.println("Inside Vendor");
			/* String strinsertemov="update gl_emove set status='IN',din='"+sqldate+"',tin='"+time+"',kmin="+km+",fin="+fuel+",ibrhid="+brhid+",ilocid="+locid+",ireason='"+remarks+"' where rdocno="+docno+" and rdtype='ERC' and fleet_no="+equipno+" and status='OUT'";
			System.out.println(strinsertemov);
			int insertemov=stmt.executeUpdate(strinsertemov);
			if(insertemov<=0){
				errorstatus=1;
			} */	
		}
	}
	
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>