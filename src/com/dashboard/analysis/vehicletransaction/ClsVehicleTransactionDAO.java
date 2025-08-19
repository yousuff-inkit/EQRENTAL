package com.dashboard.analysis.vehicletransaction;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehicleTransactionDAO {
	
	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();  
	
	public  JSONArray loadGridData(HttpSession session,String fromdate,String todate) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqldata="",date="";   
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
		try {

			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlfromdate = com.changeStringtoSqlDate(fromdate);
				
				 date = fromdate.substring(fromdate.length()- 4);
			}
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqltodate = com.changeStringtoSqlDate(todate);
			}  
			sqldata="select voc_no,type,z.fleet_no fleetno,veh.reg_no regno,name,branchout,DATE_FORMAT(dateout,'%d.%m.%Y') dateout,timeout,kmout,fuelout,branchin,DATE_FORMAT(datein,'%d.%m.%Y') datein,timein, "
					+" round(kmin,2) kmin,fuelin,brd.brand_name brand,model.vtype model,rate from(select "
					+" (tarif1.rate+tarif1.cdw+tarif1.pai+tarif1.cdw1+tarif1.pai1+tarif1.gps+tarif1.babyseater+tarif1.cooler) rate, "
					+" case when tarif.rentaltype='Daily' then 'Rental Daily Open' when tarif.rentaltype='Weekly' "
					+" then 'Rental Weekly Open' when tarif.rentaltype='Monthly' then 'Rental Monthly Open' end type , "
					+" agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout, "
					+" agmt.otime timeout,agmt.okm kmout,CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 "
					+" THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN "
					+" agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN agmt.ofuel=0.750 "
					+" THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  "
					+" fuelout,'' branchin,'' datein,'' timein,'' kmin,'' fuelin from gl_ragmt agmt inner join gl_rtarif tarif "
					+" on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) inner join gl_rtarif tarif1 on "
					+" (agmt.doc_no=tarif1.rdocno and tarif1.rstatus=7) left join my_acbook ac on "
					+" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) where "
					+" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and (tarif.rentaltype "
					+" in('Daily','Weekly','Monthly') or agmt.weekend=1) and agmt.clstatus=0  and agmt.status=3 union all "
					+" select (tarif1.rate+tarif1.cdw+tarif1.pai+tarif1.cdw1+tarif1.pai1+tarif1.gps+tarif1.babyseater+tarif1.cooler) rate, "
					+" case when tarif.rentaltype='Daily' then 'Rental Daily Close' when tarif.rentaltype='Weekly' then "
					+" 'Rental Weekly Close' when tarif.rentaltype='Monthly' then 'Rental Monthly Close' end type , "
					+" agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout, "
					+" agmt.otime timeout,agmt.okm kmout,CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 "
					+" THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN "
					+" agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN agmt.ofuel=0.750 "
					+" THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  "
					+" fuelout,brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE "
					+" WHEN rclose.infuel=0.000 THEN 'Level 0/8'WHEN rclose.infuel=0.125 THEN 'Level 1/8' "
					+" WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8' WHEN "
					+" rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 "
					+" THEN 'Level 6/8' WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  "
					+" END  fuelin from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and "
					+" tarif.rstatus=5) inner join gl_rtarif tarif1 on (agmt.doc_no=tarif1.rdocno and tarif1.rstatus=7) "
					+" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on "
					+" (agmt.brhid=brout.doc_no) left join gl_ragmtclosem rclose on agmt.doc_no=rclose.agmtno left join "
					+" my_brch brin on rclose.brchid=brin.doc_no where rclose.indate>='"+sqlfromdate+"' and "
					+" rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and (tarif.rentaltype in('Daily','Weekly','Monthly') or "
					+" agmt.weekend=1) and agmt.clstatus=1 and agmt.status=3 union all "
					+" select (tarif1.rate+tarif1.cdw+tarif1.pai+tarif1.cdw1+tarif1.pai1+tarif1.gps+tarif1.babyseater+tarif1.cooler) rate, "
					+" 'Rental Weekend Close' type,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name, "
					+" brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,CASE WHEN "
					+" agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 "
					+" THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN "
					+" agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 "
					+" THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,brin.branchname branchin, "
					+" rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8' "
					+" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN "
					+" rclose.infuel=0.375 THEN 'Level 3/8' WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 "
					+" THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8' WHEN rclose.infuel=0.875 THEN 'Level 7/8' "
					+" WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin from gl_ragmt agmt inner join gl_rtarif tarif "
					+" on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) inner join gl_rtarif tarif1 "
					+" on (agmt.doc_no=tarif1.rdocno and tarif1.rstatus=7) left join my_acbook ac on "
					+" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) "
					+" left join gl_ragmtclosem rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on "
					+" rclose.brchid=brin.doc_no where rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and "
					+" tarif.rstatus=5 and agmt.weekend=1 and agmt.clstatus=1 and agmt.status=3 union all "
					+" select (tarif1.rate+tarif1.cdw+tarif1.pai+tarif1.cdw1+tarif1.pai1+tarif1.gps+tarif1.babyseater+tarif1.cooler) rate, "
					+" 'Rental Weekend Open' type,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name, "
					+" brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,CASE WHEN "
					+" agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 "
					+" THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN "
					+" agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 "
					+" THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,'','','','','' from gl_ragmt "
					+" agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) inner join gl_rtarif "
					+" tarif1 on (agmt.doc_no=tarif1.rdocno and tarif1.rstatus=7) left join my_acbook ac on "
					+" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) where "
					+" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and agmt.weekend=1 and "
					+" agmt.clstatus=0 and agmt.status=3 union all "
					+" select (rate+cdw+pai+cdw1+pai1+gps+babyseater+cooler) rate,'Lease Open' type,agmt.doc_no,agmt.voc_no, "
					+" if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) fleet_no,ac.refname name,brout.branchname branchout, "
					+" agmt.outdate dateout,agmt.outtime timeout,agmt.outkm kmout,CASE WHEN agmt.outfuel=0.000 THEN 'Level 0/8' "
					+" WHEN agmt.outfuel=0.125 THEN 'Level 1/8' WHEN agmt.outfuel=0.250 THEN 'Level 2/8' WHEN "
					+" agmt.outfuel=0.375 THEN 'Level 3/8' WHEN agmt.outfuel=0.500 THEN 'Level 4/8' WHEN agmt.outfuel=0.625 "
					+" THEN 'Level 5/8'  WHEN agmt.outfuel=0.750 THEN 'Level 6/8' WHEN agmt.outfuel=0.875 THEN 'Level 7/8' "
					+" WHEN agmt.outfuel=1.000 THEN 'Level 8/8'  END  fuelout,'','','','','' from gl_lagmt agmt inner join "
					+" gl_ltarif ltarif on agmt.doc_no=ltarif.rdocno left join my_acbook ac on (agmt.cldocno=ac.cldocno and "
					+" ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) where agmt.outdate>='"+sqlfromdate+"' "
					+" and agmt.outdate<='"+sqltodate+"' and agmt.clstatus=0 and agmt.status=3 union all "
					+" select (rate+cdw+pai+cdw1+pai1+gps+babyseater+cooler) rate,'Lease Close' type,agmt.doc_no,agmt.voc_no, "
					+" if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) fleet_no,ac.refname name,brout.branchname branchout, "
					+" agmt.outdate dateout,agmt.outtime timeout,agmt.outkm kmout,CASE WHEN agmt.outfuel=0.000 "
					+" THEN 'Level 0/8' WHEN agmt.outfuel=0.125 THEN 'Level 1/8' WHEN agmt.outfuel=0.250 THEN 'Level 2/8' "
					+" WHEN agmt.outfuel=0.375 THEN 'Level 3/8' WHEN agmt.outfuel=0.500 THEN 'Level 4/8' WHEN agmt.outfuel=0.625 "
					+" THEN 'Level 5/8'  WHEN agmt.outfuel=0.750 THEN 'Level 6/8' WHEN agmt.outfuel=0.875 THEN 'Level 7/8' "
					+" WHEN agmt.outfuel=1.000 THEN 'Level 8/8'  END  fuelout,brin.branchname branchin,lclose.indate datein, "
					+" lclose.intime timein,lclose.inkm kmin,CASE WHEN lclose.infuel=0.000 THEN 'Level 0/8' WHEN "
					+" lclose.infuel=0.125 THEN 'Level 1/8' WHEN lclose.infuel=0.250 THEN 'Level 2/8' WHEN lclose.infuel=0.375 "
					+" THEN 'Level 3/8' WHEN lclose.infuel=0.500 THEN 'Level 4/8' WHEN lclose.infuel=0.625 THEN 'Level 5/8'  "
					+" WHEN lclose.infuel=0.750 THEN 'Level 6/8' WHEN lclose.infuel=0.875 THEN 'Level 7/8' WHEN "
					+" lclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin from gl_lagmt agmt inner join gl_ltarif ltarif on "
					+" agmt.doc_no=ltarif.rdocno left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') "
					+" left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_lagmtclosem lclose on "
					+" (agmt.doc_no=lclose.agmtno) left join my_brch brin on lclose.brchid=brin.doc_no where "
					+" lclose.indate>='"+sqlfromdate+"' and lclose.indate<='"+sqltodate+"' and agmt.clstatus=1 and agmt.status=3 "
					+" union all select 0 rate,'Replacements' type,rep.doc_no,rep.doc_no voc_no,rep.ofleetno fleet_no, "
					+" ac.refname name,brout.branchname branchout,rep.odate dateout,rep.otime timeout,rep.okm kmout,CASE WHEN "
					+" rep.ofuel=0.000 THEN 'Level 0/8' WHEN rep.ofuel=0.125 THEN 'Level 1/8' WHEN rep.ofuel=0.250 "
					+" THEN 'Level 2/8' WHEN rep.ofuel=0.375 THEN 'Level 3/8' WHEN rep.ofuel=0.500 THEN 'Level 4/8' WHEN "
					+" rep.ofuel=0.625 THEN 'Level 5/8' WHEN rep.ofuel=0.750 THEN 'Level 6/8' WHEN rep.ofuel=0.875 "
					+" THEN 'Level 7/8' WHEN rep.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,brin.branchname branchin, "
					+" rep.indate datein,rep.intime timein,rep.inkm kmin,CASE WHEN rep.infuel=0.000 THEN 'Level 0/8' WHEN "
					+" rep.infuel=0.125 THEN 'Level 1/8' WHEN rep.infuel=0.250 THEN 'Level 2/8' WHEN rep.infuel=0.375 "
					+" THEN 'Level 3/8' WHEN rep.infuel=0.500 THEN 'Level 4/8' WHEN rep.infuel=0.625 THEN 'Level 5/8'  "
					+" WHEN rep.infuel=0.750 THEN 'Level 6/8' WHEN rep.infuel=0.875 THEN 'Level 7/8' WHEN rep.infuel=1.000 "
					+" THEN 'Level 8/8'  END  fuelin from gl_vehreplace rep left join my_brch brout on rep.obrhid=brout.doc_no "
					+" left join my_brch brin on rep.inbrhid=brin.doc_no left join gl_ragmt ragmt on (rep.rtype='RAG' and "
					+" rep.rdocno=ragmt.doc_no) left join gl_lagmt lagmt on (rep.rtype='LAG' and rep.rdocno=lagmt.doc_no) "
					+" left join my_acbook ac on (if(rep.rtype='RAG',ragmt.cldocno=ac.cldocno,lagmt.cldocno=ac.cldocno) "
					+" and ac.dtype='CRM') where rep.status=3 and rep.date>='"+sqlfromdate+"' and rep.date<='"+sqltodate+"' union all "
					+" select 0 rate,'Movement Garage Accident' type,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0, "
					+" stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,minmov.tout timeout, "
					+" minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN "
					+" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 "
					+" THEN 'Level 4/8' WHEN minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' "
					+" WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN minmov.fout=1.000 THEN 'Level 8/8' END fuelout, "
					+" brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,CASE WHEN maxmov.fin=0.000 "
					+" THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN "
					+" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 "
					+" THEN 'Level 5/8' WHEN maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' "
					+" WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin  from ( select min(mov.doc_no) mindocno,max(mov.doc_no) "
					+" maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno and "
					+" mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GA' "
					+" and nrm.status=3 group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on "
					+" (a.mindocno=minmov.doc_no) left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join "
					+" gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no left join "
					+" my_brch brin on nrm.inbranch=brin.doc_no left join my_salesman dr on "
					+" (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on (nrm.staffid=stf.doc_no "
					+" and stf.sal_type='STF') union all select 0 rate,'Movement Garage Maintenance' type,nrm.fleet_no, "
					+" nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout, "
					+" minmov.dout dateout,minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' "
					+" WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 "
					+" THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN minmov.fout=0.625 THEN 'Level 5/8' "
					+" WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN minmov.fout=1.000 "
					+" THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin, "
					+" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN "
					+" maxmov.fin=0.250 THEN 'Level 2/8' WHEN maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 "
					+" THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN maxmov.fin=0.750 THEN 'Level 6/8' WHEN "
					+" maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin  "
					+" from ( select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join "
					+" gl_vmove mov on (nrm.doc_no=mov.rdocno and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and "
					+" nrm.date<='"+sqltodate+"' and nrm.movtype='GM' and nrm.status=3  group by mov.rdocno,mov.rdtype)a "
					+" left join gl_vmove minmov on (a.mindocno=minmov.doc_no) left join gl_vmove maxmov on "
					+" (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout "
					+" on nrm.outbranch=brout.doc_no left join my_brch brin on nrm.inbranch=brin.doc_no left join my_salesman "
					+" dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on (nrm.staffid=stf.doc_no "
					+" and stf.sal_type='STF') union all select 0 rate,'Movement Garage Service' type,nrm.fleet_no,nrm.doc_no, "
					+" nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov. "
					+" dout dateout,minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' "
					+" WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN minmov.fout=0.250 THEN 'Level 2/8' "
					+" WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN "
					+" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 "
					+" THEN 'Level 7/8' WHEN minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin, "
					+" maxmov.din datein,maxmov.tin timein,maxmov.kmin,CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' "
					+" WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN maxmov.fin=0.375 "
					+" THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN "
					+" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 "
					+" THEN 'Level 8/8' END fuelin from ( select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno "
					+" from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno and mov.rdtype='MOV') where "
					+" nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GS' and nrm.status=3 group by "
					+" mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no) left join gl_vmove "
					+" maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch "
					+" brout on nrm.outbranch=brout.doc_no left join my_brch brin on nrm.inbranch=brin.doc_no left join "
					+" my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on "
					+" (nrm.staffid=stf.doc_no and stf.sal_type='STF') union all select 0 rate,'Movement Staff' type, "
					+" nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name, "
					+" brout.branchname branchout,minmov.dout dateout,minmov.tout timeout,minmov.kmout,CASE WHEN "
					+" minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN minmov.fout=0.250 "
					+" THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN "
					+" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 "
					+" THEN 'Level 7/8' WHEN minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin, "
					+" maxmov.din datein,maxmov.tin timein,maxmov.kmin,CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN "
					+" maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN maxmov.fin=0.375 "
					+" THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN "
					+" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 "
					+" THEN 'Level 8/8' END fuelin  from ( select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno, "
					+" mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno and mov.rdtype='MOV') "
					+" where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='ST' and nrm.status=3  "
					+" group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no) left join "
					+" gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join "
					+" my_brch brout on nrm.outbranch=brout.doc_no left join my_brch brin on nrm.inbranch=brin.doc_no "
					+" left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on "
					+" (nrm.staffid=stf.doc_no and stf.sal_type='STF') union all select 0 rate,'Movement Transfer' type, "
					+" nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name, "
					+" brout.branchname branchout,minmov.dout dateout,minmov.tout timeout,minmov.kmout,CASE WHEN "
					+" minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN minmov.fout=0.250 "
					+" THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN "
					+" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 "
					+" THEN 'Level 7/8' WHEN minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin, "
					+" maxmov.din datein,maxmov.tin timein,maxmov.kmin,CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' "
					+" WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN maxmov.fin=0.375 "
					+" THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN "
					+" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 "
					+" THEN 'Level 8/8' END fuelin  from ( select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno "
					+" from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno and mov.rdtype='MOV') where "
					+" nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='TR' and nrm.status=3  group by "
					+" mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no) left join gl_vmove "
					+" maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join "
					+" my_brch brout on nrm.outbranch=brout.doc_no left join my_brch brin on nrm.inbranch=brin.doc_no "
					+" left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on "
					+" (nrm.staffid=stf.doc_no and stf.sal_type='STF') ) z left join (select fleet_no,reg_no,brdid,vmodid "
					+" from gl_vehmaster) veh on veh.fleet_no=z.fleet_no left join (select doc_no,brand_name from gl_vehbrand) "
					+" brd on brd.doc_no=veh.brdid left join (select doc_no,vtype from gl_vehmodel) model on "
					+" model.doc_no=veh.vmodid";			    
		//	System.out.println("=vehicle transaction grid--->>>"+sqldata);
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=com.convertToJSON(resultSet);
				//	System.out.println("=====RESULTDATA"+RESULTDATA);
			
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}

}
