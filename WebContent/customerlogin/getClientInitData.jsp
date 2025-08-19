<%@page import="com.dashboard.ClsDashBoardNewDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="customerlogin.ClsCustomerLoginDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
Connection conn=null;
JSONObject objrenewal=new JSONObject();
JSONObject objinsurtype=new JSONObject();
JSONObject objcontactperson=new JSONObject();
JSONObject objpolicyno=new JSONObject();
JSONObject objchartdata=new JSONObject();
JSONObject objlivefleets=new JSONObject();
ClsCustomerLoginDAO dao=new ClsCustomerLoginDAO();
String refname="",mobile="",email="",acno="",pdcinhand="",subreciept="",advance="",balance="",unapplied="",total="";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	ClsCommon objcommon=new ClsCommon();
	String cldocno=session.getAttribute("CLDOCNO")==null?"":session.getAttribute("CLDOCNO").toString();
	String strsql="select curdate() sqldate,coalesce(refname,'') refname,coalesce(per_mob,'') mobile,coalesce(mail1,'') email,acno from my_acbook where cldocno="+cldocno+" and dtype='CRM'";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		refname=rs.getString("refname");
		mobile=rs.getString("mobile");
		email=rs.getString("email");
		acno=rs.getString("acno");
		sqldate=rs.getDate("sqldate");
	}
	 
	/* String strgetcarddata="select coalesce(aa.pdcamount,0) pdcinhand,coalesce(aa.subrcpt,0) subreciept,coalesce(aa.advance,0) advance,coalesce(aa.balance,0) balance,coalesce(aa.total,0) total,coalesce(aa.unapplied,0) unapplied from (select f.pdcamount,g.subrcpt,a.*,bk.period2 creditperiod,bk.credit creditlimit,bk.mail1 email,if(bk.per_mob is null,bk.com_mob,if(bk.per_mob='NA',bk.com_mob,if(bk.per_mob=' ',bk.com_mob,bk.per_mob))) mobile_no,bk.contactPerson contact_person,s.sal_name from (select name 'account_name',CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) 'advance',"+
	" CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) 'balance',CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) 'unapplied',"+
	" CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) 'total',CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) 'level_1',"+
	" CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) 'level_2',CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) 'level_3',"+
	" CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) 'level_4',CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) 'level_5',"+
	" ag.acno 'account',ag.brhid 'branch_id' from (select d.name,d.acno,d.brhid,d.doc_no,"+
	" if(d.duedys between 0 and 30 and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between 31 and 60 and d.bal>0,"+
	" round((d.bal),2),0) l2,if(d.duedys between 61 and 90 and d.bal>0,round((d.bal),2),0) l3,if(d.duedys between 91 and 120 and d.bal>0,"+
	" round((d.bal),2),0) l4,if(d.duedys >=121 and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,"+
	" if(d.bal>0,d.bal,0) t7 from  (select j.acno,j.brhid,h.description name,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqldate+"' as datetime)) duedys"+
	" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where"+
	" j.date<='"+sqldate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='AR' and j.date<='"+sqldate+"'  and j.acno="+acno+" and j.id > 0 group by j.tranid having bal<>0"+ 
	" union all select j.acno,j.brhid,h.description name,sum(dramount)- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqldate+"' as datetime)) duedys"+
	" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqldate+"'"+
	" group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='AR' and j.date<='"+sqldate+"' and j.acno="+acno+" and j.id < 0 group by j.tranid having bal<>0) d) ag group by acno ) a  left join (select SUM(j.DRAMOUNT)pdcAmount,j.TR_NO,j.acno  from MY_JVTRAN J INNER JOIN my_CHQDET C ON J.TR_NO=C.TR_NO WHERE C.PDC=1  AND C.STATUS='E' AND J.STATUS=3   and j.acno="+acno+" group by j.acno )f on f.acno=a.account  left join (select sum(dramount) subrcpt,j.acno from my_jvtran j where date>'"+sqldate+"' and dramount<0  and j.acno="+acno+" group by j.acno)g on g.acno=a.account  left join my_acbook bk on a.account=bk.acno"+
	" and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no where 1=1) aa "; */
	String sqld=" and j.id < 0";
	String sqld1=" and j.id > 0";
	
	/*select ="select name 'account_name',ag.contact 'contact_person',ag.pmob 'mobile_no',CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) 'advance',"
		+ "CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) 'balance',CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) 'unapplied', "  
		+ "CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) 'total',CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) 'level_1',"
		+ "CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) 'level_2',CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) 'level_3',"  
		+ "CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) 'level_4',CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) 'level_5',ag.acno 'account',"
		+ "ag.brhid 'branch_id' from (select d.name,d.mob,d.contact,d.pmob,d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" "
		+ "and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" "
		+ "and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,"
		+ "if(d.duedys >="+level5from+" and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal>0,d.bal,0) t7 from ";*/
	String level1from="0",level1to="30",level2from="31",level2to="60",level3from="61",level3to="90",level4from="91",level4to="120",level5from="121",atype="AR",sql="";
	if(!(acno.equalsIgnoreCase("0")) && !(acno.equalsIgnoreCase(""))){
		sql+=" and j.acno="+acno+"";
    }
	String select ="select 1 branch,a.*,bk.refname 'account_name',bk.period2 creditperiod,bk.credit creditlimit,bk.mail1 email,if(bk.per_mob is null,bk.com_mob,if(bk.per_mob='NA',bk.com_mob,\r\n" + 
			"if(bk.per_mob=' ',bk.com_mob,bk.per_mob))) mobile_no,bk.contactPerson contact_person,s.sal_name from (select \r\n" + 
			"cast(format(round(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),'0'),2),2) as CHAR(50)) 'advance',\r\n" + 
			"cast(format(round(if(sum(t7+u6)>0,round((sum(t7+u6)),2),'0'),2),2) as CHAR(50)) 'balance',"+
			" cast(FORMAT(round(if(sum(u6)<0,round((sum(u6*-1)),2),'0'),2),2) as CHAR(50)) 'unapplied',\r\n" + 
			"cast(format(round(if(sum(t7)>0,round((sum(t7)),2),'0'),2),2) as CHAR(50)) 'total',cast(if(sum(l1)>0,round((sum(l1)),2),'0') as CHAR(50)) 'level_1',\r\n" + 
			"cast(if(sum(l2)>0,round((sum(l2)),2),'0') as CHAR(50)) 'level_2',cast(if(sum(l3)>0,round((sum(l3)),2),'0') as CHAR(50)) 'level_3',\r\n" + 
			"cast(if(sum(l4)>0,round((sum(l4)),2),'0') as CHAR(50)) 'level_4',cast(if(sum(l5)>0,round((sum(l5)),2),'0') as CHAR(50)) 'level_5',\r\n" + 
			"ag.acno 'account' from (\r\n" + 
			"select d.acno ,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,\r\n" + 
			"round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,\r\n" + 
			"round((d.bal),2),0) l4,if(d.duedys >="+level5from+" and d.bal>0,round((d.bal),2),0) l5,if(d.bal<0,round((d.bal),2),'0') U6,\r\n" + 
			"if(d.bal>0,d.bal,0) t7 from ";
			
			
	String strgetcarddata = select+" (select j.acno,dramount - coalesce(o.amount,0)*id bal, j.tranid,j.doc_no,DATEDIFF(cast(j.date as datetime),cast('"+sqldate+"' as datetime)) duedys\r\n" + 
			"from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,sum(coalesce(amount,0)) amount from my_outd o \r\n" + 
			"inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqldate+"' group by ap_trid) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqldate+"' "+sql+"  and j.id > 0  and ((dramount) - coalesce(o.amount,0)*id)<>0  \r\n" + 
			" union all \r\n" + 
			" select j.acno,dramount- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,DATEDIFF(cast(j.date as datetime),cast('"+sqldate+"' as datetime)) duedys\r\n" + 
			" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select o.tranid,sum(coalesce(amount,0)) amount \r\n" + 
			" from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqldate+"'\r\n" + 
			" group by o.tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqldate+"' \r\n" + 
			" "+sql+" and j.id < 0 and ((dramount) - coalesce(o.amount,0)*id)<>0 ) d) ag group by acno ) a  left join my_acbook bk on a.account=bk.acno\r\n" + 
			" and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no where 1=1 ";
	//System.out.println(strgetcarddata);
	ResultSet rscarddata=stmt.executeQuery(strgetcarddata);
	while(rscarddata.next()){
		//pdcinhand=rscarddata.getString("pdcinhand");
		//subreciept=rscarddata.getString("subreciept");
		advance=rscarddata.getString("advance");
		balance=rscarddata.getString("balance");
		unapplied=rscarddata.getString("unapplied");
		total=rscarddata.getString("total");
	}
	//objchartdata=dao.getChartCountData(cldocno,conn);
	objchartdata=dao.getFleetDistChartData(acno);
	objlivefleets=dao.getFleetSalesChartData(acno);
	ArrayList<String> helpdeskarray=new ArrayList();
	int helpdeskserial=1;
	/* String strgethelpdesk="select doc_no,coalesce(name,'') name,coalesce(department,'') department,coalesce(email,'') email,coalesce(mobile,'') mobile from gl_helpdesk where status=3";
	ResultSet rsgethelpdesk=stmt.executeQuery(strgethelpdesk);
	while(rsgethelpdesk.next()){
		helpdeskarray.add(helpdeskserial+"***"+rsgethelpdesk.getInt("doc_no")+"***"+rsgethelpdesk.getString("name")+"***"+rsgethelpdesk.getString("department")+"***"+rsgethelpdesk.getString("email")+"***"+rsgethelpdesk.getString("mobile"));
		helpdeskserial++;
	} */
	objpolicyno.put("helpdeskdata", helpdeskarray);
	//System.out.println(objpolicyno);
	
	
	//gets client corresponding vehicles
	String strgetveh="select concat(veh.REG_NO,' ',plt.CODE_NAME,' ',veh.FLNAME) refname,veh.FLEET_NO fleetno from gl_ragmt agmt"+ 
	" left join gl_vehmaster veh on (agmt.fleet_no=veh.FLEET_NO)"+ 
	" left join gl_vehplate plt on veh.pltid=plt.doc_no where agmt.cldocno="+cldocno+" and agmt.clstatus=0 and agmt.status=3 union all"+
	" select concat(veh.REG_NO,' ',plt.CODE_NAME,' ',veh.FLNAME) refname,veh.FLEET_NO fleetno from gl_lagmt agmt"+ 
	" left join gl_vehmaster veh on (if(agmt.tmpfleet=0,agmt.perfleet,agmt.tmpfleet)=veh.FLEET_NO)"+ 
	" left join gl_vehplate plt on veh.pltid=plt.doc_no"+
	" where agmt.cldocno="+cldocno+" and agmt.clstatus=0 and agmt.status=3";
	//System.out.println(strgetveh);
	ResultSet rsgetveh=stmt.executeQuery(strgetveh);
	JSONArray veharray=new JSONArray();
	while(rsgetveh.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("fleetno",rsgetveh.getString("fleetno"));
		objtemp.put("refname",rsgetveh.getString("refname"));
		veharray.add(objtemp);
	}
	
	String strgettype="select name refname,doc_no docno from cm_cuscalltype where status=3";
	ResultSet rsgettype=stmt.executeQuery(strgettype);
	JSONArray typearray=new JSONArray();
	while(rsgettype.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgettype.getString("docno"));
		objtemp.put("refname",rsgettype.getString("refname"));
		typearray.add(objtemp);
	}
	String strgetfeed="select date_format(m.date,'%d.%M.%Y') date,m.doc_no docno,m.fleetno,m.regno,m.calledBy,m.calledByMob mobile,m.callDateTime datetime,ct.name typename,m.callType type,"+
	" m.callPlace place,m.remarks,coalesce(st.name,'') statusname from cm_cuscallm m"+ 
	" left join cm_cuscallstatus st on m.statusid=st.srno "+
	" left join cm_cuscalltype ct on m.callType=ct.doc_no and ct.status=3"+ 
	" where m.status=3 and m.cldocno="+cldocno;
	ResultSet rsgetfeed=stmt.executeQuery(strgetfeed);
	JSONArray feedarray=new JSONArray();
	while(rsgetfeed.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgetfeed.getString("docno"));
		objtemp.put("regno",rsgetfeed.getString("regno"));
		objtemp.put("fleetno",rsgetfeed.getString("fleetno"));
		objtemp.put("calledby",rsgetfeed.getString("calledby"));
		objtemp.put("mobile",rsgetfeed.getString("mobile"));
		objtemp.put("datetime",rsgetfeed.getString("datetime"));
		objtemp.put("date",rsgetfeed.getString("date"));
		objtemp.put("typename",rsgetfeed.getString("typename"));		
		objtemp.put("type",rsgetfeed.getString("type"));
		objtemp.put("place",rsgetfeed.getString("place"));
		objtemp.put("remarks",rsgetfeed.getString("remarks"));
		objtemp.put("statusname",rsgetfeed.getString("statusname"));
		feedarray.add(objtemp);
	}
	
	objpolicyno.put("feedvehdata",veharray);
	objpolicyno.put("feedtypedata",typearray);
	objpolicyno.put("feeddata",feedarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
//System.out.println(refname+" :: "+mobile+" :: "+email+" :: "+acno+" :: "+pdcinhand+" :: "+subreciept+" :: "+advance+" :: "+balance+" :: "+unapplied+" :: "+total+" :: "+objrenewal+" :: "+objinsurtype+" :: "+objcontactperson+" :: "+objpolicyno+" :: "+objchartdata+" :: "+objlivefleets);
response.getWriter().write(refname+" :: "+mobile+" :: "+email+" :: "+acno+" :: "+pdcinhand+" :: "+subreciept+" :: "+advance+" :: "+balance+" :: "+unapplied+" :: "+total+" :: "+objrenewal+" :: "+objinsurtype+" :: "+objcontactperson+" :: "+objpolicyno+" :: "+objchartdata+" :: "+objlivefleets);
%>