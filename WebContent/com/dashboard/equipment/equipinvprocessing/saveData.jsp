<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.project.execution.ServiceSale.ClsServiceSaleDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
	String contractdocno=request.getParameter("contractdocno")==null?"":request.getParameter("contractdocno");
	String contractvocno=request.getParameter("contractvocno")==null?"":request.getParameter("contractvocno");
	String delcharges=request.getParameter("delcharges")==null?"0.0":request.getParameter("delcharges");
	String collectcharges=request.getParameter("collectcharges")==null?"0.0":request.getParameter("collectcharges");
	String srvcharges=request.getParameter("srvcharges")==null?"0.0":request.getParameter("srvcharges");
	String srvdesc=request.getParameter("srvdesc")==null?"":request.getParameter("srvdesc");
	String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
	//System.out.println(request.getParameterValues("equiparray[]"));
	String strequiparray[]=request.getParameterValues("equiparray[]");
	String periodupto=request.getParameter("periodupto")==null?"":request.getParameter("periodupto");
	System.out.println(contractdocno+"::"+contractvocno+"::"+cldocno+"::"+periodupto);
	JSONObject objdata=new JSONObject();
	Connection conn=null;
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	int errorstatus=0;
	try{
		conn=objconn.getMyConnection();
		java.sql.Date sqlperiodupto=null;
		if(!periodupto.equalsIgnoreCase("")){
			sqlperiodupto=objcommon.changeStringtoSqlDate(periodupto);	
		}	
		Statement stmt=conn.createStatement();
		String stracdetails="select head.atype,head.doc_no,head.description,head.curid,head.rate from my_acbook ac left join my_head head on head.doc_no=ac.acno where ac.cldocno="+cldocno+" and ac.dtype='CRM'";
		System.out.println(stracdetails);
		ResultSet rsacdetails=stmt.executeQuery(stracdetails);
		String atype="",acdocno="",acname="",accurid="",acrate="";
		while(rsacdetails.next()){
			atype=rsacdetails.getString("atype");
			acdocno=rsacdetails.getString("doc_no");
			acname=rsacdetails.getString("description");
			accurid=rsacdetails.getString("curid");
			acrate=rsacdetails.getString("rate");
		}
		int rentalacno=0,delacno=0,collectacno=0,srvacno=0;
		String strmisc="select (select costtype from my_costunit where costgroup='Equipment') costtype,"+
		"(select acno from my_account where codeno='EQUIP RENTAL') rentalacno,"+
		"(select acno from my_account where codeno='EQUIP DELIVERY') delacno,"+
		"(select acno from my_account where codeno='EQUIP COLLECTION') collectacno,"+
		"(select acno from my_account where codeno='EQUIP SERVICE') srvacno,"+
		"(select coalesce(lpono,'') from gl_rentalcontractm where doc_no="+contractdocno+") lpono,"+
		"(select lpodate from gl_rentalcontractm where doc_no="+contractdocno+") lpodate";
		System.out.println(strmisc);
		String costtype="";
		ResultSet rsmisc=stmt.executeQuery(strmisc);
		java.sql.Date sqllpodate=null;
		String lpono="";
		while(rsmisc.next()){
			costtype=rsmisc.getString("costtype");
			rentalacno=rsmisc.getInt("rentalacno");
			delacno=rsmisc.getInt("delacno");
			collectacno=rsmisc.getInt("collectacno");
			srvacno=rsmisc.getInt("srvacno");
			lpono=rsmisc.getString("lpono");
			if(rsmisc.getDate("lpodate")!=null){
				sqllpodate=rsmisc.getDate("lpodate");
			}
		}
		
		double nettotal=0.0;
		String masterdesc="Equip.Invoice for Contract No "+contractvocno+" on "+periodupto;
		ClsServiceSaleDAO saledao=new ClsServiceSaleDAO();
		ArrayList<String> salearray=new ArrayList();
		double vatpercent=0.0;
		for(int i=0,j=1;i<strequiparray.length;i++,j++){
			nettotal+=Double.parseDouble(strequiparray[i].split("::")[3].trim());
			double netamount=Double.parseDouble(strequiparray[i].split("::")[5].trim());
			double rate=Double.parseDouble(strequiparray[i].split("::")[7].trim());
			double amount=Double.parseDouble(strequiparray[i].split("::")[3].trim());
			vatpercent=Double.parseDouble(strequiparray[i].split("::")[8].trim());
			double vatamt=Double.parseDouble(strequiparray[i].split("::")[4].trim());
			String fleetno=strequiparray[i].split("::")[9].trim();
			String flname=strequiparray[i].split("::")[10].trim();
			String daysused=strequiparray[i].split("::")[6].trim();
			String desc=flname;
			String calcdocno=strequiparray[i].split("::")[0].trim();
			String strinvdate=strequiparray[i].split("::")[1].trim();
			String strinvtodate=strequiparray[i].split("::")[2].trim();
			java.sql.Date sqlinvdate=null,sqlinvtodate=null;
			if(!strinvdate.equalsIgnoreCase("")){
				sqlinvdate=objcommon.changeStringtoSqlDate(strinvdate);
			}
			if(!strinvtodate.equalsIgnoreCase("")){
				sqlinvtodate=objcommon.changeStringtoSqlDate(strinvtodate);
			}
			String strcheckdates="select concat(date_format(if(coalesce(calc.delenddate,calc.delstartdate)='"+sqlinvdate+"','"+sqlinvdate+"',date_add('"+sqlinvdate+"', interval 1 day)),'%d.%m.%Y'),' to ',date_format(coalesce(calc.contractenddate,calc.invtodate),'%d.%m.%Y'), '  HireDays :',datediff(coalesce(calc.contractenddate,calc.invtodate),invdate) , '  Hire Rate ' , round(total,2) ) dateremarks from gl_rentalquotecalc  calc left join gl_rentalcontractd d on calc.detdocno = quotedetdocno  where calc.doc_no="+calcdocno;
			//System.out.println("==="+strcheckdates);
			ResultSet rscheckdates=stmt.executeQuery(strcheckdates);
			String remarks="";
			while(rscheckdates.next()){
				remarks=rscheckdates.getString("dateremarks");
			}
			String stracno="select c.catacno from  gl_equipmaster q inner join gl_vehcategory c on q.catid=c.doc_no where fleet_no="+fleetno;
		//	System.out.println("==="+stracno);
			ResultSet rsacno=stmt.executeQuery(stracno);
			while(rsacno.next()){
				rentalacno=rsacno.getInt("catacno");
			}
			
			rate=(amount/Double.parseDouble(daysused));
			rate=objcommon.Round(rate, 2);
			salearray.add(j+"::"+daysused+" :: "+desc+" :: "+rate+" :: "+amount+" :: "+0.0+" :: "+amount+" :: "+vatpercent+" :: "+vatamt+" :: "+netamount+" :: "+netamount+" :: "+costtype+" :: "+fleetno+" :: "+remarks+" :: "+rentalacno+" :: "+0+" :: ");
			/* rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
			 +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "
			 +rows[i].taxper+" :: "+rows[i].taxperamt+" :: "+rows[i].taxamount+" :: "+rows[i].nuprice+" :: "
			 +rows[i].costtype+" :: "+rows[i].costcode+" :: "+rows[i].remarks+" :: "+rows[i].headdoc+" :: "+aa+" :: " */
		}
		if(Double.parseDouble(delcharges)>0.0){
			String desc="Equipment Delivery Charges";
			double vatamt=(vatpercent/100)*(Double.parseDouble(delcharges));
			double netamount=Double.parseDouble(delcharges)+vatamt;
			nettotal+=Double.parseDouble(delcharges);
			String remarks="Delivery Charges";
			salearray.add((salearray.size()+1)+"::"+1+" :: "+desc+" :: "+delcharges+" :: "+delcharges+" :: "+0.0+" :: "+delcharges+" :: "+vatpercent+" :: "+vatamt+" :: "+netamount+" :: "+netamount+" :: "+0+" :: "+0+" :: "+remarks+" :: "+delacno+" :: "+0+" :: ");
		}
		if(Double.parseDouble(collectcharges)>0.0){
			String desc="Equipment Collection Charges";
			double vatamt=(vatpercent/100)*(Double.parseDouble(collectcharges));
			double netamount=Double.parseDouble(collectcharges)+vatamt;
			nettotal+=Double.parseDouble(collectcharges);
			String remarks="Collection Charges";
			salearray.add((salearray.size()+1)+"::"+1+" :: "+desc+" :: "+collectcharges+" :: "+collectcharges+" :: "+0.0+" :: "+collectcharges+" :: "+vatpercent+" :: "+vatamt+" :: "+netamount+" :: "+netamount+" :: "+0+" :: "+0+" :: "+remarks+" :: "+collectacno+" :: "+0+" :: ");
		}
		if(Double.parseDouble(srvcharges)>0.0){
			String desc=srvdesc;
			double vatamt=(vatpercent/100)*(Double.parseDouble(srvcharges));
			double netamount=Double.parseDouble(srvcharges)+vatamt;
			nettotal+=Double.parseDouble(srvcharges);
			String remarks="Service Charges";
			salearray.add((salearray.size()+1)+"::"+1+" :: "+desc+" :: "+srvcharges+" :: "+srvcharges+" :: "+0.0+" :: "+srvcharges+" :: "+vatpercent+" :: "+vatamt+" :: "+netamount+" :: "+netamount+" :: "+0+" :: "+0+" :: "+remarks+" :: "+srvacno+" :: "+0+" :: ");
		}
		conn.close();
		System.out.println(sqllpodate+"::"+lpono);
		int value=saledao.insert(sqlperiodupto,sqlperiodupto,"ERC",contractvocno, atype, acdocno, acname,accurid,acrate,"","", masterdesc, 
			session, brhid, "A", nettotal, salearray, "SRS", request, sqllpodate,lpono, "0",0,vatpercent);
		String vocno=request.getAttribute("vocno").toString();
		/* Date sqlStartDate,Date purdeldate, String reftype,String refno, String acctype,
		String accdoc, String puraccname, String cmbcurr, String currate,
		String delterms, String payterms, String purdesc,
		HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,String Formdetailcode,
		HttpServletRequest request, Date sqlinvdate, String invno,String indateval,int interstate,Double taxperc */
		if(value>0){
			//Updating Inv Dates
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			stmt=conn.createStatement();
			for(int i=0,j=1;i<strequiparray.length;i++,j++){
				String calcdocno=strequiparray[i].split("::")[0].trim();
				String strupdate="update gl_rentalquotecalc set invdate=invtodate,invtodate=last_day(date_add(invtodate,interval 1 month)) where doc_no="+calcdocno;
				int update=stmt.executeUpdate(strupdate);
				if(update<=0){
					errorstatus=1;
				}
			}
			if(Double.parseDouble(delcharges)>0.0 || Double.parseDouble(collectcharges)>0 || Double.parseDouble(srvcharges)>0){
				String sqlfilters="";
				if(Double.parseDouble(delcharges)>0.0){
					sqlfilters+=" delinvno="+value;
				}
				if(Double.parseDouble(collectcharges)>0.0){
					if(!sqlfilters.equalsIgnoreCase("")){
						sqlfilters+=" ,collectinvno="+value;	
					}
					else{
						sqlfilters+=" collectinvno="+value;
					}
				}
				if(Double.parseDouble(srvcharges)>0.0){
					if(!sqlfilters.equalsIgnoreCase("")){
						sqlfilters+=" ,srvinvno="+value;	
					}
					else{
						sqlfilters+=" srvinvno="+value;
					}
				}
				String strupdate="update gl_rentalcontractm set "+sqlfilters+" where doc_no="+contractdocno;
				int update=stmt.executeUpdate(strupdate);
				if(update<=0){
					errorstatus=1;
				}
			}
			objdata.put("errorstatus",errorstatus);
			objdata.put("invvocno", vocno);
		}
		if(errorstatus==0){
			conn.commit();
		}
	}
	catch(Exception e){
		e.printStackTrace();
		objdata.put("errorstatus","1");
	}
	finally{
		conn.close();
	}
	response.getWriter().write(objdata+"");
%>