package com.dashboard.analysis.businessdailyreport;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsBusinessDailyReportDAO {
	

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getSummaryData(String check,String fromdate,String todate) throws SQLException
	{
		if(!check.equalsIgnoreCase("1")){
			return null;
		}
		JSONArray RESULTDATA=new JSONArray();
		JSONArray ROWDATA=new JSONArray();
		JSONArray COLUMNDATA=new JSONArray();
		Connection conn =  null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			ArrayList<String> columnsarray=new ArrayList<>();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			columnsarray.add("Sr No::id::center::center:: ::5%:: :: :: ");
			columnsarray.add("Ref No::refno::center::center::true::10%:: :: :: ");
			columnsarray.add("Description::description::left::left:: :: :: :: :: ");
			
			String strbranch="select doc_no,branchname from my_brch where status=3";
			ResultSet rsbranch=stmt.executeQuery(strbranch);
			String branchname="";
			int y=0;
			int branchcount=0;
			while(rsbranch.next()){
				branchcount++;
				branchname=rsbranch.getString("branchname");
				columnsarray.add(""+branchname+"::branch"+y+"::right::right:: ::12%:: :: ::['sum']");
				y++;
				
			}
			columnsarray.add("BranchCount::brcount::right::right::true::8%:: :: :: ");
			columnsarray.add("Total::horizontotal::right::right:: ::8%:: :: ::['sum']");
			//System.out.println("Branch Count:"+branchcount);
			ArrayList<ArrayList<String>> rowsarray= new ArrayList<ArrayList<String>>();
/*			+ "select case when agmt.clstatus=0 and tarif.rentaltype='Daily' then 'Rental Daily Open' when agmt.clstatus=0 and tarif.rentaltype='Weekly' then "+
			" 'Rental Weekly Open' when agmt.clstatus=0 and tarif.rentaltype='Monthly' then 'Rental Monthly Open' when agmt.clstatus=0 and agmt.weekend=1 then 'Rental Weekend Open' when agmt.clstatus=1 and tarif.rentaltype='Daily' "+
			" then 'Rental Daily Close' when agmt.clstatus=1 and tarif.rentaltype='Weekly' then 'Rental Weekly Close' when agmt.clstatus=1 and "+
			" tarif.rentaltype='Monthly' then 'Rental Monthly Close' when agmt.clstatus=1 and agmt.weekend=1 then 'Rental Weekend Close' else '' end description,case when agmt.clstatus=0 and tarif.rentaltype='Daily' then 1 when "+
			" agmt.clstatus=0 and tarif.rentaltype='Weekly' then 2 when agmt.clstatus=0 and tarif.rentaltype='Monthly' then 3 when agmt.clstatus=0 and agmt.weekend=1 then 4 when agmt.clstatus=1 and"+
			" tarif.rentaltype='Daily' then 5 when agmt.clstatus=1 and tarif.rentaltype='Weekly' then 6 when agmt.clstatus=1 and tarif.rentaltype='Monthly' "+
			" then 7 when agmt.clstatus=1 and agmt.weekend=1 then 8 else 0 end orderstatus,if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,count(*),0) branch1,if(agmt.brhid=3,count(*),0)  branch2,"+
			" if(agmt.brhid=4,count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6,"+
			" if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt inner join "+
			" gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join gl_ragmtclosem agmtclose on (agmt.doc_no=agmtclose.agmtno and"+
			" agmt.clstatus=1) where if(agmt.clstatus=0,agmt.odate>='"+sqlfromdate+"',agmtclose.indate>='"+sqlfromdate+"') and"+
			" if(agmt.clstatus=0,agmt.odate<='"+sqltodate+"',agmtclose.indate<='"+sqltodate+"') and agmt.status=3 group by agmt.doc_no 
*/			
			String strfinal="select b.horizontotal,b.description,b.brcount,b.branch0,b.branch1,b.branch2,"+
			" b.branch3,b.branch4,b.branch5,b.branch6,b.branch7,b.branch8,b.branch9 from (select a.orderstatus,"+branchcount+" "+
			" brcount,a.description,sum(a.branch0) branch0,sum(a.branch1) branch1,sum(a.branch2) branch2,sum(a.branch3) branch3,sum(a.branch4) branch4,sum(a.branch5) "+
			" branch5,sum(a.branch6) branch6,sum(a.branch7) branch7,sum(a.branch8) branch8,sum(a.branch9) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+"+
			" sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from "+
			" ("
			+ "select case when tarif.rentaltype='Daily' then 'Rental Daily Open' when tarif.rentaltype='Weekly' then  'Rental Weekly Open' when"+
			" tarif.rentaltype='Monthly' then 'Rental Monthly Open' when agmt.weekend=1 then 'Rental Weekend Open' else '' end description,"+
			" case when tarif.rentaltype='Daily' then 1 when  tarif.rentaltype='Weekly' then 2 when tarif.rentaltype='Monthly' then 3 when"+
			" agmt.weekend=1 then 4 else 0 end orderstatus, if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,count(*),0) branch1,"+
			" if(agmt.brhid=3,count(*),0)  branch2, if(agmt.brhid=4, count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,"+
			" count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8,"+
			" if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt inner join  gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and"+
			" tarif.rstatus=5) where agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and agmt.status=3 and agmt.clstatus=0 group by"+
			" agmt.doc_no"+
			" union all"+
			" select case when tarif.rentaltype in ('Daily','Weekly','Monthly') or agmt.weekend=1 then 'Total Rental Open' else '' end description,"+
			" case when tarif.rentaltype in ('Daily','Weekly','Monthly') or agmt.weekend=1 then 5 else 0 end orderstatus,"+
			" if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,count(*),0) branch1,if(agmt.brhid=3,count(*),0)  branch2, if(agmt.brhid=4,"+
			" count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6,"+
			" if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt"+
			" inner join  gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) where agmt.odate>='"+sqlfromdate+"' and "+
			" agmt.odate<='"+sqltodate+"' and agmt.status=3 and agmt.clstatus=0 group by agmt.doc_no"+
			" union all"+
			" select case when tarif.rentaltype='Daily' then 'Rental Daily Close' when tarif.rentaltype='Weekly' then 'Rental Weekly Close' when"+
			" tarif.rentaltype='Monthly' then 'Rental Monthly Close' when agmt.weekend=1 then 'Rental Weekend Close' else '' end description, case when tarif.rentaltype='Daily'"+
			" then 6 when tarif.rentaltype='Weekly' then 7 when tarif.rentaltype='Monthly'  then 8 when agmt.weekend=1 then 9 else 0 end orderstatus,if(agmt.brhid=1,count(*),0)"+
			" branch0, if(agmt.brhid=2,count(*),0) branch1,if(agmt.brhid=3,count(*),0)  branch2, if(agmt.brhid=4,count(*),0) branch3,"+
			" if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,"+
			" count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt inner join"+
			" gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join gl_ragmtclosem agmtclose on"+
			" (agmt.doc_no=agmtclose.agmtno and agmt.clstatus=1) where agmtclose.indate>='"+sqlfromdate+"' and agmtclose.indate<='"+sqltodate+"' and"+
			" agmt.status=3 and agmt.clstatus=1 group by agmt.doc_no"+
			" union all"+
			" select case when tarif.rentaltype in ('Daily','Weekly','Monthly')"+
			" or agmt.weekend=1 then 'Total Rental Close' else '' end description, case when tarif.rentaltype in ('Daily','Weekly','Monthly') or"+
			" agmt.weekend=1 then 10 else 0 end orderstatus,if(agmt.brhid=1,count(*),0) branch0, if(agmt.brhid=2,count(*),0) branch1,"+
			" if(agmt.brhid=3,count(*),0)  branch2, if(agmt.brhid=4,count(*),0) branch3, if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,"+
			" count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8,"+
			" if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt inner join  gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5)"+
			" left join gl_ragmtclosem agmtclose on (agmt.doc_no=agmtclose.agmtno and agmt.clstatus=1) where agmtclose.indate>='"+sqlfromdate+"' and "+
			" agmtclose.indate<='"+sqltodate+"' and agmt.status=3 and agmt.clstatus=1 group by agmt.doc_no) a group by a.description"+
			" UNION ALL"+
			" select a.orderstatus,6 brcount,a.description,sum(a.branch0) branch0,sum(a.branch1) branch1,sum(a.branch2) branch2,sum(a.branch3)"+
			" branch3,sum(a.branch4) branch4,sum(a.branch5) branch5,sum(a.branch6) branch6,sum(a.branch7) branch7,sum(a.branch8) branch8,"+
			" sum(a.branch9) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+ sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)"+
			" +sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from ( select if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,"+
			" count(*),0) branch1,if(agmt.brhid=3,count(*),0) branch2, if(agmt.brhid=4,count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,"+
			" if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,"+
			" count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9,'Lease Open' description,11 orderstatus from gl_lagmt"+
			" agmt where agmt.clstatus=0 and agmt.outdate>='"+sqlfromdate+"' and agmt.outdate<='"+sqltodate+"' and agmt.status=3 group by agmt.doc_no) a group by a.description "+
			" union all "+
			" select a.orderstatus,6 brcount,a.description,sum(a.branch0) branch0,sum(a.branch1) branch1,sum(a.branch2) branch2,sum(a.branch3)"+
			" branch3,sum(a.branch4) branch4,sum(a.branch5) branch5,sum(a.branch6) branch6,sum(a.branch7) branch7,sum(a.branch8) branch8,"+
			" sum(a.branch9) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+ sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)"+
			" +sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from ( select if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,"+
			" count(*),0) branch1,if(agmt.brhid=3,count(*),0) branch2, if(agmt.brhid=4,count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,"+
			" if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,"+
			" count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9,'Lease Close' description,12 orderstatus from gl_lagmt"+
			" agmt left join gl_lagmtclosem agmtclose on (agmt.doc_no=agmtclose.agmtno and agmt.clstatus=1) where agmt.clstatus=1 and "+
			" agmtclose.indate>='"+sqlfromdate+"' and agmtclose.indate<='"+sqltodate+"' and agmt.status=3 group by agmt.doc_no"+
			" ) a"+
			" group by a.description UNION ALL"+
			" select a.orderstatus,"+branchcount+" brcount,'Replacements' description,coalesce(sum(a.branch0),0) branch0,coalesce(sum(a.branch1),0) branch1,coalesce(sum(a.branch2),0)"+
			" branch2,coalesce(sum(a.branch3),0) branch3,coalesce(sum(a.branch4),0) branch4,coalesce(sum(a.branch5),0) branch5,coalesce(sum(a.branch6),0)"+
			" branch6, coalesce(sum(a.branch7),0) branch7,coalesce(sum(a.branch8),0) branch8,coalesce(sum(a.branch9),0) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+"+
			" sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from ( select"+
			" 13 orderstatus,if(rep.obrhid =1,count(*),0) branch0,if(rep.obrhid =2,count(*),0) branch1,if(rep.obrhid =3,count(*),0) branch2, if(rep.obrhid =4,count(*),0)"+
			" branch3, if(rep.obrhid =5,count(*),0) branch4,if(rep.obrhid =6,count(*),0) branch5, if(rep.obrhid =7,count(*),0) branch6,"+
			" if(rep.obrhid =8,count(*),0) branch7, if(rep.obrhid =9,count(*),0) branch8,if(rep.obrhid =10,count(*),0) branch9 from gl_vehreplace rep where"+
			"  rep.date>='"+sqlfromdate+"' and rep.date<='"+sqltodate+"'  and rep.status=3 group by rep.doc_no) a union all"+
			" select a.orderstatus,"+branchcount+" brcount,'Ready To Rent' description,coalesce(sum(a.branch0),0) branch0, "+
			" coalesce(sum(a.branch1),0) branch1,coalesce(sum(a.branch2),0) branch2,coalesce(sum(a.branch3),0) branch3, "+
			" coalesce(sum(a.branch4),0) branch4,coalesce(sum(a.branch5),0) branch5,coalesce(sum(a.branch6),0) branch6, "+
			" coalesce(sum(a.branch7),0) branch7,coalesce(sum(a.branch8),0) branch8,coalesce(sum(a.branch9),0) branch9, "+
			" (sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+ sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+ "+
			" sum(a.branch8)+sum(a.branch9)) horizontotal from ( select 19 orderstatus,if(veh.a_br =1,count(*),0) branch0, "+
			" if(veh.a_br =2,count(*),0) branch1,if(veh.a_br =3,count(*),0) branch2, if(veh.a_br =4,count(*),0) branch3, "+
			" if(veh.a_br =5,count(*),0) branch4,if(veh.a_br =6,count(*),0) branch5, if(veh.a_br =7,count(*),0) branch6, "+
			" if(veh.a_br =8,count(*),0) branch7, if(veh.a_br =9,count(*),0) branch8,if(veh.a_br =10,count(*),0) branch9 "+
			" from gl_vehmaster veh where veh.tran_code='RR' and veh.statu=3 and reg_exp>=curdate() and ins_exp>=curdate() group by veh.doc_no) a "+
			" union all select a.orderstatus,"+branchcount+" brcount,'Unrentable' description,coalesce(sum(a.branch0),0) branch0,  coalesce(sum(a.branch1),0) branch1,"+
			" coalesce(sum(a.branch2),0) branch2,coalesce(sum(a.branch3),0) branch3,  coalesce(sum(a.branch4),0) branch4,coalesce(sum(a.branch5),0) branch5,coalesce(sum(a.branch6),0) branch6, "+
			" coalesce(sum(a.branch7),0) branch7,coalesce(sum(a.branch8),0) branch8,coalesce(sum(a.branch9),0) branch9, "+
			"  (sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+ sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+  sum(a.branch8)+sum(a.branch9)) horizontotal "+
			" from ( select 20 orderstatus,if(veh.a_br =1,count(*),0) branch0,  if(veh.a_br =2,count(*),0) branch1,if(veh.a_br =3,count(*),0) branch2, if(veh.a_br =4,count(*),0) branch3, "+
			" if(veh.a_br =5,count(*),0) branch4,if(veh.a_br =6,count(*),0) branch5, if(veh.a_br =7,count(*),0) branch6,  if(veh.a_br =8,count(*),0) branch7,"+
			" if(veh.a_br =9,count(*),0) branch8,if(veh.a_br =10,count(*),0) branch9  from gl_vehmaster veh where veh.tran_code='UR' and veh.statu=3 group by veh.doc_no) a  UNION ALL"+
			" select a.orderstatus,"+branchcount+" brcount,a.description,sum(a.branch0) branch0,sum(a.branch1) branch1,sum(a.branch2) branch2,sum(a.branch3) branch3,"+
			" sum(a.branch4) branch4, sum(a.branch5) branch5,sum(a.branch6) branch6,sum(a.branch7) branch7,sum(a.branch8) branch8,"+
			" sum(a.branch9) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+"+
			" sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from ( "+
			" select case when movtype='TR' then 14 when movtype='ST' then 15 when movtype='GA' then 16"+
			" when movtype='GM' then 17 when movtype='GS' then 18 else 0 end orderstatus,case when movtype='TR' then 'Movement Transfer' when"+
			" movtype='ST' then 'Movement Staff' when movtype='GA' then 'Movement Garage Accident'  when movtype='GM' then"+
			" 'Movement Garage Maintenance' when movtype='GS' then 'Movement Garage Service' else '' end description, if(nrm.brhid =1,count(*),0) branch0,"+
			" if(nrm.brhid =2,count(*),0) branch1,if(nrm.brhid =3,count(*),0) branch2,if(nrm.brhid =4,count(*),0) branch3, if(nrm.brhid =5,count(*),0) branch4,"+
			" if(nrm.brhid =6,count(*),0) branch5,if(nrm.brhid =7,count(*),0) branch6,if(nrm.brhid =8,count(*),0) branch7, if(nrm.brhid =9,count(*),0) branch8,"+
			" if(nrm.brhid =10,count(*),0) branch9 from gl_nrm nrm where  nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"'  and nrm.status=3 group by nrm.doc_no) a  group by a.description) "+
			" b order by b.orderstatus";
			//System.out.println("summary grid===="+strfinal);
			ResultSet rsfinal=stmt.executeQuery(strfinal);
			int id=1;
			
			while(rsfinal.next()){
				ArrayList<String> temp=new ArrayList<String>();
				temp.add(id+"");
				temp.add(id+"");
				temp.add(rsfinal.getString("description"));
				temp.add(rsfinal.getString("brcount"));
				temp.add(rsfinal.getString("horizontotal"));
				temp.add(rsfinal.getString("branch0"));
				temp.add(rsfinal.getString("branch1"));
				temp.add(rsfinal.getString("branch2"));
				temp.add(rsfinal.getString("branch3"));
				temp.add(rsfinal.getString("branch4"));
				temp.add(rsfinal.getString("branch5"));
				temp.add(rsfinal.getString("branch6"));
				temp.add(rsfinal.getString("branch7"));
				temp.add(rsfinal.getString("branch8"));
				temp.add(rsfinal.getString("branch9"));
				
				id++;
			
				rowsarray.add(temp);
			}
			
			COLUMNDATA=convertColumnAnalysisArrayToJSON(columnsarray);
			 ROWDATA=convertRowAnalysisArrayToJSON(rowsarray);
			 
			 JSONArray analysisarray=new JSONArray();
			 
			 analysisarray.addAll(COLUMNDATA);
			 analysisarray.addAll(ROWDATA);
			 RESULTDATA=analysisarray;
		//	System.out.println("Check"+analysisarray);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray getSummaryDataEx(String check,String fromdate,String todate) throws SQLException
	{
		if(!check.equalsIgnoreCase("1")){
			return null;
		}
		JSONArray RESULTDATA=new JSONArray();
		JSONArray ROWDATA=new JSONArray();
		JSONArray COLUMNDATA=new JSONArray();
		Connection conn =  null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			ArrayList<String> columnsarray=new ArrayList<>();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			columnsarray.add("Sr No::id::center::center:: ::5%:: :: :: ");
			columnsarray.add("Ref No::refno::center::center::true::10%:: :: :: ");
			columnsarray.add("Description::description::left::left:: :: :: :: :: ");
			
			String strbranch="select doc_no,branchname from my_brch where status=3";
			ResultSet rsbranch=stmt.executeQuery(strbranch);
			String branchname="";
			int y=0;
			int branchcount=0;
			while(rsbranch.next()){
				branchcount++;
				branchname=rsbranch.getString("branchname");
				columnsarray.add(""+branchname+"::branch"+y+"::right::right:: ::12%:: :: ::['sum']");
				y++;
				
			}
			columnsarray.add("BranchCount::brcount::right::right::true::8%:: :: :: ");
			columnsarray.add("Total::horizontotal::right::right:: ::8%:: :: ::['sum']");
			//System.out.println("Branch Count:"+branchcount);
			ArrayList<ArrayList<String>> rowsarray= new ArrayList<ArrayList<String>>();
/*			+ "select case when agmt.clstatus=0 and tarif.rentaltype='Daily' then 'Rental Daily Open' when agmt.clstatus=0 and tarif.rentaltype='Weekly' then "+
			" 'Rental Weekly Open' when agmt.clstatus=0 and tarif.rentaltype='Monthly' then 'Rental Monthly Open' when agmt.clstatus=0 and agmt.weekend=1 then 'Rental Weekend Open' when agmt.clstatus=1 and tarif.rentaltype='Daily' "+
			" then 'Rental Daily Close' when agmt.clstatus=1 and tarif.rentaltype='Weekly' then 'Rental Weekly Close' when agmt.clstatus=1 and "+
			" tarif.rentaltype='Monthly' then 'Rental Monthly Close' when agmt.clstatus=1 and agmt.weekend=1 then 'Rental Weekend Close' else '' end description,case when agmt.clstatus=0 and tarif.rentaltype='Daily' then 1 when "+
			" agmt.clstatus=0 and tarif.rentaltype='Weekly' then 2 when agmt.clstatus=0 and tarif.rentaltype='Monthly' then 3 when agmt.clstatus=0 and agmt.weekend=1 then 4 when agmt.clstatus=1 and"+
			" tarif.rentaltype='Daily' then 5 when agmt.clstatus=1 and tarif.rentaltype='Weekly' then 6 when agmt.clstatus=1 and tarif.rentaltype='Monthly' "+
			" then 7 when agmt.clstatus=1 and agmt.weekend=1 then 8 else 0 end orderstatus,if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,count(*),0) branch1,if(agmt.brhid=3,count(*),0)  branch2,"+
			" if(agmt.brhid=4,count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6,"+
			" if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt inner join "+
			" gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join gl_ragmtclosem agmtclose on (agmt.doc_no=agmtclose.agmtno and"+
			" agmt.clstatus=1) where if(agmt.clstatus=0,agmt.odate>='"+sqlfromdate+"',agmtclose.indate>='"+sqlfromdate+"') and"+
			" if(agmt.clstatus=0,agmt.odate<='"+sqltodate+"',agmtclose.indate<='"+sqltodate+"') and agmt.status=3 group by agmt.doc_no 
*/			
			String strfinal="select b.description 'Description',b.branch0 'Algarhoud Br',b.branch2,"+
			" b.branch3, b.horizontotal 'Total' from (select a.orderstatus,"+branchcount+" "+
			" brcount,a.description,sum(a.branch0) branch0,sum(a.branch1) branch1,sum(a.branch2) branch2,sum(a.branch3) branch3,sum(a.branch4) branch4,sum(a.branch5) "+
			" branch5,sum(a.branch6) branch6,sum(a.branch7) branch7,sum(a.branch8) branch8,sum(a.branch9) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+"+
			" sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from "+
			" ("
			+ "select case when tarif.rentaltype='Daily' then 'Rental Daily Open' when tarif.rentaltype='Weekly' then  'Rental Weekly Open' when"+
			" tarif.rentaltype='Monthly' then 'Rental Monthly Open' when agmt.weekend=1 then 'Rental Weekend Open' else '' end description,"+
			" case when tarif.rentaltype='Daily' then 1 when  tarif.rentaltype='Weekly' then 2 when tarif.rentaltype='Monthly' then 3 when"+
			" agmt.weekend=1 then 4 else 0 end orderstatus, if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,count(*),0) branch1,"+
			" if(agmt.brhid=3,count(*),0)  branch2, if(agmt.brhid=4, count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,"+
			" count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8,"+
			" if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt inner join  gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and"+
			" tarif.rstatus=5) where agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and agmt.status=3 and agmt.clstatus=0 group by"+
			" agmt.doc_no"+
			" union all"+
			" select case when tarif.rentaltype in ('Daily','Weekly','Monthly') or agmt.weekend=1 then 'Total Rental Open' else '' end description,"+
			" case when tarif.rentaltype in ('Daily','Weekly','Monthly') or agmt.weekend=1 then 5 else 0 end orderstatus,"+
			" if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,count(*),0) branch1,if(agmt.brhid=3,count(*),0)  branch2, if(agmt.brhid=4,"+
			" count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6,"+
			" if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt"+
			" inner join  gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) where agmt.odate>='"+sqlfromdate+"' and "+
			" agmt.odate<='"+sqltodate+"' and agmt.status=3 and agmt.clstatus=0 group by agmt.doc_no"+
			" union all"+
			" select case when tarif.rentaltype='Daily' then 'Rental Daily Close' when tarif.rentaltype='Weekly' then 'Rental Weekly Close' when"+
			" tarif.rentaltype='Monthly' then 'Rental Monthly Close' when agmt.weekend=1 then 'Rental Weekend Close' else '' end description, case when tarif.rentaltype='Daily'"+
			" then 6 when tarif.rentaltype='Weekly' then 7 when tarif.rentaltype='Monthly'  then 8 when agmt.weekend=1 then 9 else 0 end orderstatus,if(agmt.brhid=1,count(*),0)"+
			" branch0, if(agmt.brhid=2,count(*),0) branch1,if(agmt.brhid=3,count(*),0)  branch2, if(agmt.brhid=4,count(*),0) branch3,"+
			" if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,"+
			" count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt inner join"+
			" gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join gl_ragmtclosem agmtclose on"+
			" (agmt.doc_no=agmtclose.agmtno and agmt.clstatus=1) where agmtclose.indate>='"+sqlfromdate+"' and agmtclose.indate<='"+sqltodate+"' and"+
			" agmt.status=3 and agmt.clstatus=1 group by agmt.doc_no"+
			" union all"+
			" select case when tarif.rentaltype in ('Daily','Weekly','Monthly')"+
			" or agmt.weekend=1 then 'Total Rental Close' else '' end description, case when tarif.rentaltype in ('Daily','Weekly','Monthly') or"+
			" agmt.weekend=1 then 10 else 0 end orderstatus,if(agmt.brhid=1,count(*),0) branch0, if(agmt.brhid=2,count(*),0) branch1,"+
			" if(agmt.brhid=3,count(*),0)  branch2, if(agmt.brhid=4,count(*),0) branch3, if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,"+
			" count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8,"+
			" if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt inner join  gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5)"+
			" left join gl_ragmtclosem agmtclose on (agmt.doc_no=agmtclose.agmtno and agmt.clstatus=1) where agmtclose.indate>='"+sqlfromdate+"' and "+
			" agmtclose.indate<='"+sqltodate+"' and agmt.status=3 and agmt.clstatus=1 group by agmt.doc_no) a group by a.description"+
			" UNION ALL"+
			" select a.orderstatus,6 brcount,a.description,sum(a.branch0) branch0,sum(a.branch1) branch1,sum(a.branch2) branch2,sum(a.branch3)"+
			" branch3,sum(a.branch4) branch4,sum(a.branch5) branch5,sum(a.branch6) branch6,sum(a.branch7) branch7,sum(a.branch8) branch8,"+
			" sum(a.branch9) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+ sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)"+
			" +sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from ( select if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,"+
			" count(*),0) branch1,if(agmt.brhid=3,count(*),0) branch2, if(agmt.brhid=4,count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,"+
			" if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,"+
			" count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9,'Lease Open' description,11 orderstatus from gl_lagmt"+
			" agmt where agmt.clstatus=0 and agmt.outdate>='"+sqlfromdate+"' and agmt.outdate<='"+sqltodate+"' and agmt.status=3 group by agmt.doc_no) a group by a.description "+
			" union all "+
			" select a.orderstatus,6 brcount,a.description,sum(a.branch0) branch0,sum(a.branch1) branch1,sum(a.branch2) branch2,sum(a.branch3)"+
			" branch3,sum(a.branch4) branch4,sum(a.branch5) branch5,sum(a.branch6) branch6,sum(a.branch7) branch7,sum(a.branch8) branch8,"+
			" sum(a.branch9) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+ sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)"+
			" +sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from ( select if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,"+
			" count(*),0) branch1,if(agmt.brhid=3,count(*),0) branch2, if(agmt.brhid=4,count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,"+
			" if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,"+
			" count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9,'Lease Close' description,12 orderstatus from gl_lagmt"+
			" agmt left join gl_lagmtclosem agmtclose on (agmt.doc_no=agmtclose.agmtno and agmt.clstatus=1) where agmt.clstatus=1 and "+
			" agmtclose.indate>='"+sqlfromdate+"' and agmtclose.indate<='"+sqltodate+"' and agmt.status=3 group by agmt.doc_no"+
			" ) a"+
			" group by a.description UNION ALL"+
			" select a.orderstatus,"+branchcount+" brcount,'Replacements' description,coalesce(sum(a.branch0),0) branch0,coalesce(sum(a.branch1),0) branch1,coalesce(sum(a.branch2),0)"+
			" branch2,coalesce(sum(a.branch3),0) branch3,coalesce(sum(a.branch4),0) branch4,coalesce(sum(a.branch5),0) branch5,coalesce(sum(a.branch6),0)"+
			" branch6, coalesce(sum(a.branch7),0) branch7,coalesce(sum(a.branch8),0) branch8,coalesce(sum(a.branch9),0) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+"+
			" sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from ( select"+
			" 13 orderstatus,if(rep.obrhid =1,count(*),0) branch0,if(rep.obrhid =2,count(*),0) branch1,if(rep.obrhid =3,count(*),0) branch2, if(rep.obrhid =4,count(*),0)"+
			" branch3, if(rep.obrhid =5,count(*),0) branch4,if(rep.obrhid =6,count(*),0) branch5, if(rep.obrhid =7,count(*),0) branch6,"+
			" if(rep.obrhid =8,count(*),0) branch7, if(rep.obrhid =9,count(*),0) branch8,if(rep.obrhid =10,count(*),0) branch9 from gl_vehreplace rep where"+
			"  rep.date>='"+sqlfromdate+"' and rep.date<='"+sqltodate+"'  and rep.status=3 group by rep.doc_no) a union all"+
			" select a.orderstatus,"+branchcount+" brcount,'Ready To Rent' description,coalesce(sum(a.branch0),0) branch0, "+
			" coalesce(sum(a.branch1),0) branch1,coalesce(sum(a.branch2),0) branch2,coalesce(sum(a.branch3),0) branch3, "+
			" coalesce(sum(a.branch4),0) branch4,coalesce(sum(a.branch5),0) branch5,coalesce(sum(a.branch6),0) branch6, "+
			" coalesce(sum(a.branch7),0) branch7,coalesce(sum(a.branch8),0) branch8,coalesce(sum(a.branch9),0) branch9, "+
			" (sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+ sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+ "+
			" sum(a.branch8)+sum(a.branch9)) horizontotal from ( select 19 orderstatus,if(veh.a_br =1,count(*),0) branch0, "+
			" if(veh.a_br =2,count(*),0) branch1,if(veh.a_br =3,count(*),0) branch2, if(veh.a_br =4,count(*),0) branch3, "+
			" if(veh.a_br =5,count(*),0) branch4,if(veh.a_br =6,count(*),0) branch5, if(veh.a_br =7,count(*),0) branch6, "+
			" if(veh.a_br =8,count(*),0) branch7, if(veh.a_br =9,count(*),0) branch8,if(veh.a_br =10,count(*),0) branch9 "+
			" from gl_vehmaster veh where veh.tran_code='RR' and veh.statu=3 and reg_exp>=curdate() and ins_exp>=curdate() group by veh.doc_no) a "+
			" union all select a.orderstatus,"+branchcount+" brcount,'Unrentable' description,coalesce(sum(a.branch0),0) branch0,  coalesce(sum(a.branch1),0) branch1,"+
			" coalesce(sum(a.branch2),0) branch2,coalesce(sum(a.branch3),0) branch3,  coalesce(sum(a.branch4),0) branch4,coalesce(sum(a.branch5),0) branch5,coalesce(sum(a.branch6),0) branch6, "+
			" coalesce(sum(a.branch7),0) branch7,coalesce(sum(a.branch8),0) branch8,coalesce(sum(a.branch9),0) branch9, "+
			"  (sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+ sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+  sum(a.branch8)+sum(a.branch9)) horizontotal "+
			" from ( select 20 orderstatus,if(veh.a_br =1,count(*),0) branch0,  if(veh.a_br =2,count(*),0) branch1,if(veh.a_br =3,count(*),0) branch2, if(veh.a_br =4,count(*),0) branch3, "+
			" if(veh.a_br =5,count(*),0) branch4,if(veh.a_br =6,count(*),0) branch5, if(veh.a_br =7,count(*),0) branch6,  if(veh.a_br =8,count(*),0) branch7,"+
			" if(veh.a_br =9,count(*),0) branch8,if(veh.a_br =10,count(*),0) branch9  from gl_vehmaster veh where veh.tran_code='UR' and veh.statu=3 group by veh.doc_no) a  UNION ALL"+
			" select a.orderstatus,"+branchcount+" brcount,a.description,sum(a.branch0) branch0,sum(a.branch1) branch1,sum(a.branch2) branch2,sum(a.branch3) branch3,"+
			" sum(a.branch4) branch4, sum(a.branch5) branch5,sum(a.branch6) branch6,sum(a.branch7) branch7,sum(a.branch8) branch8,"+
			" sum(a.branch9) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+"+
			" sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from ( "+
			" select case when movtype='TR' then 14 when movtype='ST' then 15 when movtype='GA' then 16"+
			" when movtype='GM' then 17 when movtype='GS' then 18 else 0 end orderstatus,case when movtype='TR' then 'Movement Transfer' when"+
			" movtype='ST' then 'Movement Staff' when movtype='GA' then 'Movement Garage Accident'  when movtype='GM' then"+
			" 'Movement Garage Maintenance' when movtype='GS' then 'Movement Garage Service' else '' end description, if(nrm.brhid =1,count(*),0) branch0,"+
			" if(nrm.brhid =2,count(*),0) branch1,if(nrm.brhid =3,count(*),0) branch2,if(nrm.brhid =4,count(*),0) branch3, if(nrm.brhid =5,count(*),0) branch4,"+
			" if(nrm.brhid =6,count(*),0) branch5,if(nrm.brhid =7,count(*),0) branch6,if(nrm.brhid =8,count(*),0) branch7, if(nrm.brhid =9,count(*),0) branch8,"+
			" if(nrm.brhid =10,count(*),0) branch9 from gl_nrm nrm where  nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"'  and nrm.status=3 group by nrm.doc_no) a  group by a.description) "+
			" b order by b.orderstatus";
		//	System.out.println("summary grid===="+strfinal);
			ResultSet rsfinal=stmt.executeQuery(strfinal);
			
			RESULTDATA=objcommon.convertToEXCEL(rsfinal);
			/*int id=1;
			
			while(rsfinal.next()){
				ArrayList<String> temp=new ArrayList<String>();
				temp.add(id+"");
				temp.add(id+"");
				temp.add(rsfinal.getString("description"));
				temp.add(rsfinal.getString("brcount"));
				temp.add(rsfinal.getString("horizontotal"));
				temp.add(rsfinal.getString("branch0"));
				temp.add(rsfinal.getString("branch1"));
				temp.add(rsfinal.getString("branch2"));
				temp.add(rsfinal.getString("branch3"));
				temp.add(rsfinal.getString("branch4"));
				temp.add(rsfinal.getString("branch5"));
				temp.add(rsfinal.getString("branch6"));
				temp.add(rsfinal.getString("branch7"));
				temp.add(rsfinal.getString("branch8"));
				temp.add(rsfinal.getString("branch9"));
				
				id++;
			
				rowsarray.add(temp);
			}
			
			COLUMNDATA=convertColumnAnalysisArrayToJSON(columnsarray);
			 ROWDATA=convertRowAnalysisArrayToJSON(rowsarray);
			 
			 JSONArray analysisarray=new JSONArray();
			 
			 analysisarray.addAll(COLUMNDATA);
			 analysisarray.addAll(ROWDATA);
			 RESULTDATA=analysisarray;*/
		//	System.out.println("Check"+analysisarray);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}

	private JSONArray convertRowAnalysisArrayToJSON(
			ArrayList<ArrayList<String>> rowsarray) {
		// TODO Auto-generated method stub
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsarray.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> analysisRowArray=rowsarray.get(i);
			
			int length = analysisRowArray.size();
			
			obj.put("id",analysisRowArray.get(0));
			obj.put("refno",analysisRowArray.get(1));
			obj.put("description",analysisRowArray.get(2));
			obj.put("brcount",analysisRowArray.get(3));
			obj.put("horizontotal",analysisRowArray.get(4));
		//	System.out.println("Checking Row Array: "+i+"///"+analysisRowArray.get(i));
			for (int j = 5,k=0; j < length; j++,k++) {
				if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put("branch"+k,analysisRowArray.get(j));
				}
			}
			/**/
			
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;}

	private JSONArray convertColumnAnalysisArrayToJSON(
			ArrayList<String> columnsarray) {
		// TODO Auto-generated method stub
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < columnsarray.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] analysisColumnArray=columnsarray.get(i).split("::");
			
			obj.put("text",analysisColumnArray[0]);
			obj.put("datafield",analysisColumnArray[1]);
			obj.put("cellsAlign",analysisColumnArray[2]);
			obj.put("align",analysisColumnArray[3]);
			if(!(analysisColumnArray[4].trim().equalsIgnoreCase(""))){
				obj.put("hidden",analysisColumnArray[4]);
		    }
			if(!(analysisColumnArray[5].trim().equalsIgnoreCase(""))){
				obj.put("width",analysisColumnArray[5]);
		    }
			if(!(analysisColumnArray[6].trim().equalsIgnoreCase(""))){
			    obj.put("cellsFormat",analysisColumnArray[6]);
			}
			if(!(analysisColumnArray[7].trim().equalsIgnoreCase(""))){
			    obj.put("cellclassname",analysisColumnArray[7]);
			}
			if(!(analysisColumnArray[8].trim().equalsIgnoreCase(""))){
			    obj.put("aggregates",analysisColumnArray[8]);
			}
			/*if(!(analysisColumnArray[8].trim().equalsIgnoreCase(""))){
			    obj.put("aggregatesrenderer","rendererstring");
			}*/
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columns",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
	}
	
	
	
	public String getPrint(String description,String branch,String fromdate,String todate) throws SQLException{
		JSONArray detaildata=new JSONArray();
		String strsql="";
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			//System.out.println("Description: "+description);
			String brhid="";
			if(branch.equalsIgnoreCase("branch0")){
				brhid="1";
			}
			else if(branch.equalsIgnoreCase("branch1")){
				brhid="2";
			}
			else if(branch.equalsIgnoreCase("branch2")){
				brhid="3";
			}
			else if(branch.equalsIgnoreCase("branch3")){
				brhid="4";
			}
			else if(branch.equalsIgnoreCase("branch4")){
				brhid="5";
			}
			else if(branch.equalsIgnoreCase("branch5")){
				brhid="6";
			}
			else if(branch.equalsIgnoreCase("branch6")){
				brhid="7";
			}
			else if(branch.equalsIgnoreCase("branch7")){
				brhid="8";
			}
			else if(branch.equalsIgnoreCase("branch8")){
				brhid="9";
			}
			else if(branch.equalsIgnoreCase("branch9")){
				brhid="10";
			}
			
			if(description.equalsIgnoreCase("Rental Daily Open")){
				System.out.println("Rental Daily Open");
				strsql="select '' fuelin,'' kmin,null timein,null datein,'' branchin,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)  left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Daily' and agmt.clstatus=0 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Weekly Open")){
				System.out.println("Rental Weekly Open");
				strsql="select '' fuelin,'' kmin,null timein,null datein,'' branchin,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)   left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Weekly' and agmt.clstatus=0 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Monthly Open")){
				System.out.println("Rental Monthly Open");
				strsql="select '' fuelin,'' kmin,null timein,null datein,'' branchin,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)  left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Monthly' and agmt.clstatus=0  and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Total Rental Open")){
				System.out.println("Total Rental Open");
				strsql="select '' fuelin,'' kmin,null timein,null datein,'' branchin,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid  left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and (tarif.rentaltype in('Daily','Weekly','Monthly') or agmt.weekend=1) and agmt.clstatus=0  and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Daily Close")){
				System.out.println("Rental Daily Close");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin ,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Daily' and agmt.clstatus=1  and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Weekly Close")){
				System.out.println("Rental Weekly Close");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout, "+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin ,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid  left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Weekly' and agmt.clstatus=1  and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Monthly Close")){
				System.out.println("Rental Monthly Close");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Monthly' and agmt.clstatus=1 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Total Rental Close")){
				System.out.println("Total Rental Close");
				strsql="select  veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin ,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and (tarif.rentaltype in('Daily','Weekly','Monthly') or agmt.weekend=1) and agmt.clstatus=1 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Weekend Close")){
				System.out.println("Rental Weekend Close");
				strsql="select  veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and agmt.weekend=1 and agmt.clstatus=1 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Weekend Open")){
				System.out.println("Rental Weekend Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and agmt.weekend=1 and agmt.clstatus=0 and agmt.status=3";
			}
			else if (description.equalsIgnoreCase("Lease Open")) {
				System.out.println("Lease Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) fleet_no,ac.refname name,brout.branchname branchout,"+
				" agmt.outdate dateout,agmt.outtime timeout,agmt.outkm kmout,CASE WHEN agmt.outfuel=0.000 THEN 'Level 0/8' WHEN agmt.outfuel=0.125"+
				" THEN 'Level 1/8' WHEN agmt.outfuel=0.250 THEN 'Level 2/8' WHEN agmt.outfuel=0.375 THEN 'Level 3/8' WHEN agmt.outfuel=0.500 THEN"+
				" 'Level 4/8' WHEN agmt.outfuel=0.625 THEN 'Level 5/8'  WHEN agmt.outfuel=0.750 THEN 'Level 6/8' WHEN agmt.outfuel=0.875 THEN"+
				" 'Level 7/8' WHEN agmt.outfuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name driver from gl_lagmt agmt left join"+
				" my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join (select rdocno,brhid,drid from gl_ldriver group by rdocno) drv on drv.rdocno=agmt.doc_no and drv.brhid=agmt.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where"+
				" agmt.brhid="+brhid+" and agmt.outdate>='"+sqlfromdate+"' and agmt.outdate<='"+sqltodate+"' and agmt.clstatus=0 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Lease Close")){
				System.out.println("Lease Close");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) fleet_no,ac.refname name,brout.branchname branchout,"+
				" agmt.outdate dateout,agmt.outtime timeout,agmt.outkm kmout,CASE WHEN agmt.outfuel=0.000 THEN 'Level 0/8' WHEN agmt.outfuel=0.125"+
				" THEN 'Level 1/8' WHEN agmt.outfuel=0.250 THEN 'Level 2/8' WHEN agmt.outfuel=0.375 THEN 'Level 3/8' WHEN agmt.outfuel=0.500 THEN"+
				" 'Level 4/8' WHEN agmt.outfuel=0.625 THEN 'Level 5/8'  WHEN agmt.outfuel=0.750 THEN 'Level 6/8' WHEN agmt.outfuel=0.875 THEN"+
				" 'Level 7/8' WHEN agmt.outfuel=1.000 THEN 'Level 8/8'  END  fuelout,brin.branchname branchin,lclose.indate datein,"+
				" lclose.intime timein,lclose.inkm kmin,CASE WHEN lclose.infuel=0.000 THEN 'Level 0/8' WHEN lclose.infuel=0.125 THEN 'Level 1/8'"+
				" WHEN lclose.infuel=0.250 THEN 'Level 2/8' WHEN lclose.infuel=0.375 THEN 'Level 3/8' WHEN lclose.infuel=0.500 THEN 'Level 4/8' WHEN"+
				" lclose.infuel=0.625 THEN 'Level 5/8'  WHEN lclose.infuel=0.750 THEN 'Level 6/8' WHEN lclose.infuel=0.875 THEN 'Level 7/8' WHEN"+
				" lclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin,det.sal_name  driver  from gl_lagmt agmt left join"+
				" my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)"+
				" left join gl_lagmtclosem lclose on (agmt.doc_no=lclose.agmtno) left join my_brch brin on lclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_ldriver group by rdocno) drv on drv.rdocno=agmt.doc_no and drv.brhid=agmt.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV'"+
				" where agmt.brhid="+brhid+" and lclose.indate>='"+sqlfromdate+"' and lclose.indate<='"+sqltodate+"' and agmt.clstatus=1 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Replacements")){
				strsql="select veh.reg_no,veh.flname,rep.doc_no,rep.doc_no voc_no,rep.ofleetno fleet_no,ac.refname name,brout.branchname branchout,rep.odate dateout,rep.otime"+
				" timeout,rep.okm kmout,CASE WHEN rep.ofuel=0.000 THEN 'Level 0/8' WHEN rep.ofuel=0.125 THEN 'Level 1/8' WHEN rep.ofuel=0.250 THEN"+
				" 'Level 2/8' WHEN rep.ofuel=0.375 THEN 'Level 3/8' WHEN rep.ofuel=0.500 THEN 'Level 4/8' WHEN rep.ofuel=0.625 THEN 'Level 5/8'"+
				" WHEN rep.ofuel=0.750 THEN 'Level 6/8' WHEN rep.ofuel=0.875 THEN 'Level 7/8' WHEN rep.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rep.indate datein,rep.intime timein,rep.inkm kmin,CASE WHEN rep.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rep.infuel=0.125 THEN 'Level 1/8' WHEN rep.infuel=0.250 THEN 'Level 2/8' WHEN rep.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rep.infuel=0.500 THEN 'Level 4/8' WHEN rep.infuel=0.625 THEN 'Level 5/8'  WHEN rep.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rep.infuel=0.875 THEN 'Level 7/8' WHEN rep.infuel=1.000 THEN 'Level 8/8'  END  fuelin,case when rep.rtype='LAG' then detl.sal_name when rep.rtype='RAG' then detr.sal_name end driver from gl_vehreplace rep left join my_brch brout on"+
				" rep.obrhid=brout.doc_no left join my_brch brin on rep.inbrhid=brin.doc_no left join gl_ragmt ragmt on"+
				" (rep.rtype='RAG' and rep.rdocno=ragmt.doc_no) left join gl_lagmt lagmt on (rep.rtype='LAG' and rep.rdocno=lagmt.doc_no) left"+
				" join my_acbook ac on (if(rep.rtype='RAG',ragmt.cldocno=ac.cldocno,lagmt.cldocno=ac.cldocno) and ac.dtype='CRM') "+
				" left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drvr on ragmt.doc_no=drvr.rdocno and ragmt.brhid=drvr.brhid left join my_salesman detr on "+
				" detr.doc_no=ragmt.drid and detr.sal_type='DRV' left join (select rdocno,brhid,drid from gl_ldriver group by rdocno) drvl on drvl.rdocno=lagmt.doc_no and lagmt.brhid=drvl.brhid left join "+
				" my_salesman detl on detl.doc_no=lagmt.drid and detl.sal_type='DRV' left join gl_vehmaster veh on  veh.fleet_no=rep.ofleetno where rep.obrhid="+brhid+""+
				"  and rep.status=3 and rep.date>='"+sqlfromdate+"' and rep.date<='"+sqltodate+"'";
			}
			else if(description.equalsIgnoreCase("Movement Garage Accident")){
				strsql="select  veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name driver  from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GA' and nrm.brhid="+brhid+" and nrm.status=3 group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Movement Garage Maintenance")){
				strsql="select  veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name driver  from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GM' and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Movement Garage Service")){
				strsql="select veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin ,dr.sal_name driver from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GS' and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Movement Staff")){
				strsql="select veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name driver  from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='ST' and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Movement Transfer")){
				strsql="select veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name driver  from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='TR' and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Ready To Rent")){
				strsql="select '' driver,veh.reg_no,veh.flname,veh.doc_no,veh.doc_no voc_no,veh.fleet_no fleet_no,veh.flname name,'' branchout,null dateout,null timeout, "+
				" '' kmout,'' fuelout, brin.branchname branchin,null datein,null timein,'' kmin,'' fuelin from gl_vehmaster veh "+
				" left join my_brch brin on veh.a_br=brin.doc_no where veh.a_br="+brhid+" and veh.tran_code='RR' and veh.statu=3 "+
				" and reg_exp>=curdate() and ins_exp>=curdate() ";	
			}
			else if(description.equalsIgnoreCase("Unrentable")){
				strsql="select '' driver,veh.reg_no,veh.flname,veh.doc_no,veh.doc_no voc_no,veh.fleet_no fleet_no,veh.flname name,'' branchout,null dateout,null timeout, "+
				" '' kmout,'' fuelout, brin.branchname branchin,null datein,null timein,'' kmin,'' fuelin from gl_vehmaster veh "+
				" left join my_brch brin on veh.a_br=brin.doc_no where veh.a_br="+brhid+" and veh.tran_code='UR' and veh.statu=3 ";	
			}
			
			
			/*if(!strsql.equalsIgnoreCase("")){
				System.out.println("detail grid==="+strsql);
				
				ResultSet rs=stmt.executeQuery(strsql);
				detaildata=objcommon.convertToJSON(rs);
			}*/
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return strsql;
	}
	
	public JSONArray getDetailData(String description,String branch,String fromdate,String todate,String id) throws SQLException{
		JSONArray detaildata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return detaildata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			//System.out.println("Description: "+description);
			String brhid="";
			if(branch.equalsIgnoreCase("branch0")){
				brhid="1";
			}
			else if(branch.equalsIgnoreCase("branch1")){
				brhid="2";
			}
			else if(branch.equalsIgnoreCase("branch2")){
				brhid="3";
			}
			else if(branch.equalsIgnoreCase("branch3")){
				brhid="4";
			}
			else if(branch.equalsIgnoreCase("branch4")){
				brhid="5";
			}
			else if(branch.equalsIgnoreCase("branch5")){
				brhid="6";
			}
			else if(branch.equalsIgnoreCase("branch6")){
				brhid="7";
			}
			else if(branch.equalsIgnoreCase("branch7")){
				brhid="8";
			}
			else if(branch.equalsIgnoreCase("branch8")){
				brhid="9";
			}
			else if(branch.equalsIgnoreCase("branch9")){
				brhid="10";
			}
			
			if(description.equalsIgnoreCase("Rental Daily Open")){
				System.out.println("Rental Daily Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)  left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Daily' and agmt.clstatus=0 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Weekly Open")){
				System.out.println("Rental Weekly Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)   left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Weekly' and agmt.clstatus=0 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Monthly Open")){
				System.out.println("Rental Monthly Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)  left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Monthly' and agmt.clstatus=0  and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Total Rental Open")){
				System.out.println("Total Rental Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid  left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and (tarif.rentaltype in('Daily','Weekly','Monthly') or agmt.weekend=1) and agmt.clstatus=0  and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Daily Close")){
				System.out.println("Rental Daily Close");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin ,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Daily' and agmt.clstatus=1  and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Weekly Close")){
				System.out.println("Rental Weekly Close");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout, "+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin ,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid  left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Weekly' and agmt.clstatus=1  and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Monthly Close")){
				System.out.println("Rental Monthly Close");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Monthly' and agmt.clstatus=1 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Total Rental Close")){
				System.out.println("Total Rental Close");
				strsql="select  veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin ,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and (tarif.rentaltype in('Daily','Weekly','Monthly') or agmt.weekend=1) and agmt.clstatus=1 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Weekend Close")){
				System.out.println("Rental Weekend Close");
				strsql="select  veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and agmt.weekend=1 and agmt.clstatus=1 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Weekend Open")){
				System.out.println("Rental Weekend Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name driver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and agmt.weekend=1 and agmt.clstatus=0 and agmt.status=3";
			}
			else if (description.equalsIgnoreCase("Lease Open")) {
				System.out.println("Lease Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) fleet_no,ac.refname name,brout.branchname branchout,"+
				" agmt.outdate dateout,agmt.outtime timeout,agmt.outkm kmout,CASE WHEN agmt.outfuel=0.000 THEN 'Level 0/8' WHEN agmt.outfuel=0.125"+
				" THEN 'Level 1/8' WHEN agmt.outfuel=0.250 THEN 'Level 2/8' WHEN agmt.outfuel=0.375 THEN 'Level 3/8' WHEN agmt.outfuel=0.500 THEN"+
				" 'Level 4/8' WHEN agmt.outfuel=0.625 THEN 'Level 5/8'  WHEN agmt.outfuel=0.750 THEN 'Level 6/8' WHEN agmt.outfuel=0.875 THEN"+
				" 'Level 7/8' WHEN agmt.outfuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name driver from gl_lagmt agmt left join"+
				" my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join (select rdocno,brhid,drid from gl_ldriver group by rdocno) drv on drv.rdocno=agmt.doc_no and drv.brhid=agmt.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where"+
				" agmt.brhid="+brhid+" and agmt.outdate>='"+sqlfromdate+"' and agmt.outdate<='"+sqltodate+"' and agmt.clstatus=0 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Lease Close")){
				System.out.println("Lease Close");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) fleet_no,ac.refname name,brout.branchname branchout,"+
				" agmt.outdate dateout,agmt.outtime timeout,agmt.outkm kmout,CASE WHEN agmt.outfuel=0.000 THEN 'Level 0/8' WHEN agmt.outfuel=0.125"+
				" THEN 'Level 1/8' WHEN agmt.outfuel=0.250 THEN 'Level 2/8' WHEN agmt.outfuel=0.375 THEN 'Level 3/8' WHEN agmt.outfuel=0.500 THEN"+
				" 'Level 4/8' WHEN agmt.outfuel=0.625 THEN 'Level 5/8'  WHEN agmt.outfuel=0.750 THEN 'Level 6/8' WHEN agmt.outfuel=0.875 THEN"+
				" 'Level 7/8' WHEN agmt.outfuel=1.000 THEN 'Level 8/8'  END  fuelout,brin.branchname branchin,lclose.indate datein,"+
				" lclose.intime timein,lclose.inkm kmin,CASE WHEN lclose.infuel=0.000 THEN 'Level 0/8' WHEN lclose.infuel=0.125 THEN 'Level 1/8'"+
				" WHEN lclose.infuel=0.250 THEN 'Level 2/8' WHEN lclose.infuel=0.375 THEN 'Level 3/8' WHEN lclose.infuel=0.500 THEN 'Level 4/8' WHEN"+
				" lclose.infuel=0.625 THEN 'Level 5/8'  WHEN lclose.infuel=0.750 THEN 'Level 6/8' WHEN lclose.infuel=0.875 THEN 'Level 7/8' WHEN"+
				" lclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin,det.sal_name  driver  from gl_lagmt agmt left join"+
				" my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)"+
				" left join gl_lagmtclosem lclose on (agmt.doc_no=lclose.agmtno) left join my_brch brin on lclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_ldriver group by rdocno) drv on drv.rdocno=agmt.doc_no and drv.brhid=agmt.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV'"+
				" where agmt.brhid="+brhid+" and lclose.indate>='"+sqlfromdate+"' and lclose.indate<='"+sqltodate+"' and agmt.clstatus=1 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Replacements")){
				strsql="select veh.reg_no,veh.flname,rep.doc_no,rep.doc_no voc_no,rep.ofleetno fleet_no,ac.refname name,brout.branchname branchout,rep.odate dateout,rep.otime"+
				" timeout,rep.okm kmout,CASE WHEN rep.ofuel=0.000 THEN 'Level 0/8' WHEN rep.ofuel=0.125 THEN 'Level 1/8' WHEN rep.ofuel=0.250 THEN"+
				" 'Level 2/8' WHEN rep.ofuel=0.375 THEN 'Level 3/8' WHEN rep.ofuel=0.500 THEN 'Level 4/8' WHEN rep.ofuel=0.625 THEN 'Level 5/8'"+
				" WHEN rep.ofuel=0.750 THEN 'Level 6/8' WHEN rep.ofuel=0.875 THEN 'Level 7/8' WHEN rep.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rep.indate datein,rep.intime timein,rep.inkm kmin,CASE WHEN rep.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rep.infuel=0.125 THEN 'Level 1/8' WHEN rep.infuel=0.250 THEN 'Level 2/8' WHEN rep.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rep.infuel=0.500 THEN 'Level 4/8' WHEN rep.infuel=0.625 THEN 'Level 5/8'  WHEN rep.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rep.infuel=0.875 THEN 'Level 7/8' WHEN rep.infuel=1.000 THEN 'Level 8/8'  END  fuelin,case when rep.rtype='LAG' then detl.sal_name when rep.rtype='RAG' then detr.sal_name end driver from gl_vehreplace rep left join my_brch brout on"+
				" rep.obrhid=brout.doc_no left join my_brch brin on rep.inbrhid=brin.doc_no left join gl_ragmt ragmt on"+
				" (rep.rtype='RAG' and rep.rdocno=ragmt.doc_no) left join gl_lagmt lagmt on (rep.rtype='LAG' and rep.rdocno=lagmt.doc_no) left"+
				" join my_acbook ac on (if(rep.rtype='RAG',ragmt.cldocno=ac.cldocno,lagmt.cldocno=ac.cldocno) and ac.dtype='CRM') "+
				" left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drvr on ragmt.doc_no=drvr.rdocno and ragmt.brhid=drvr.brhid left join my_salesman detr on "+
				" detr.doc_no=ragmt.drid and detr.sal_type='DRV' left join (select rdocno,brhid,drid from gl_ldriver group by rdocno) drvl on drvl.rdocno=lagmt.doc_no and lagmt.brhid=drvl.brhid left join "+
				" my_salesman detl on detl.doc_no=lagmt.drid and detl.sal_type='DRV' left join gl_vehmaster veh on  veh.fleet_no=rep.ofleetno where rep.obrhid="+brhid+""+
				"  and rep.status=3 and rep.date>='"+sqlfromdate+"' and rep.date<='"+sqltodate+"'";
			}
			else if(description.equalsIgnoreCase("Movement Garage Accident")){
				strsql="select  veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name driver  from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GA' and nrm.brhid="+brhid+" and nrm.status=3 group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Movement Garage Maintenance")){
				strsql="select  veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name driver  from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GM' and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Movement Garage Service")){
				strsql="select veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin ,dr.sal_name driver from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GS' and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Movement Staff")){
				strsql="select veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name driver  from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='ST' and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Movement Transfer")){
				strsql="select veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name driver  from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='TR' and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Ready To Rent")){
				strsql="select veh.reg_no,veh.flname,veh.doc_no,veh.doc_no voc_no,veh.fleet_no fleet_no,veh.flname name,'' branchout,'' dateout,'' timeout, "+
				" '' kmout,'' fuelout, brin.branchname branchin,'' datein,'' timein,'' kmin,'' fuelin from gl_vehmaster veh "+
				" left join my_brch brin on veh.a_br=brin.doc_no where veh.a_br="+brhid+" and veh.tran_code='RR' and veh.statu=3 "+
				" and reg_exp>=curdate() and ins_exp>=curdate() ";	
			}
			else if(description.equalsIgnoreCase("Unrentable")){
				strsql="select veh.reg_no,veh.flname,veh.doc_no,veh.doc_no voc_no,veh.fleet_no fleet_no,veh.flname name,'' branchout,'' dateout,'' timeout, "+
				" '' kmout,'' fuelout, brin.branchname branchin,'' datein,'' timein,'' kmin,'' fuelin from gl_vehmaster veh "+
				" left join my_brch brin on veh.a_br=brin.doc_no where veh.a_br="+brhid+" and veh.tran_code='UR' and veh.statu=3 ";
					
			}
			
			
			if(!strsql.equalsIgnoreCase("")){
				System.out.println("detail grid==="+strsql);
				
				ResultSet rs=stmt.executeQuery(strsql);
				detaildata=objcommon.convertToJSON(rs);
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return detaildata;
	}
	
	/*public JSONArray getDetailDataEx(String description,String branch,String fromdate,String todate,String id) throws SQLException{
		JSONArray detaildata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return detaildata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			//System.out.println("Description: "+description);
			String brhid="";
			if(branch.equalsIgnoreCase("branch0")){
				brhid="1";
			}
			else if(branch.equalsIgnoreCase("branch1")){
				brhid="2";
			}
			else if(branch.equalsIgnoreCase("branch2")){
				brhid="3";
			}
			else if(branch.equalsIgnoreCase("branch3")){
				brhid="4";
			}
			else if(branch.equalsIgnoreCase("branch4")){
				brhid="5";
			}
			else if(branch.equalsIgnoreCase("branch5")){
				brhid="6";
			}
			else if(branch.equalsIgnoreCase("branch6")){
				brhid="7";
			}
			else if(branch.equalsIgnoreCase("branch7")){
				brhid="8";
			}
			else if(branch.equalsIgnoreCase("branch8")){
				brhid="9";
			}
			else if(branch.equalsIgnoreCase("branch9")){
				brhid="10";
			}
			
			if(description.equalsIgnoreCase("Rental Daily Open")){
				System.out.println("Rental Daily Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name deliveredDriver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)  left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Daily' and agmt.clstatus=0 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Weekly Open")){
				System.out.println("Rental Weekly Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name deliveredDriver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)   left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Weekly' and agmt.clstatus=0 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Monthly Open")){
				System.out.println("Rental Monthly Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name deliveredDriver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)  left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Monthly' and agmt.clstatus=0  and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Total Rental Open")){
				System.out.println("Total Rental Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name deliveredDriver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid  left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and (tarif.rentaltype in('Daily','Weekly','Monthly') or agmt.weekend=1) and agmt.clstatus=0  and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Daily Close")){
				System.out.println("Rental Daily Close");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin ,det.sal_name deliveredDriver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Daily' and agmt.clstatus=1  and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Weekly Close")){
				System.out.println("Rental Weekly Close");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout, "+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin ,det.sal_name deliveredDriver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid  left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Weekly' and agmt.clstatus=1  and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Monthly Close")){
				System.out.println("Rental Monthly Close");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin,det.sal_name deliveredDriver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Monthly' and agmt.clstatus=1 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Total Rental Close")){
				System.out.println("Total Rental Close");
				strsql="select  veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin ,det.sal_name deliveredDriver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and (tarif.rentaltype in('Daily','Weekly','Monthly') or agmt.weekend=1) and agmt.clstatus=1 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Weekend Close")){
				System.out.println("Rental Weekend Close");
				strsql="select  veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin,det.sal_name deliveredDriver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join gl_ragmtclosem"+
				" rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and agmt.weekend=1 and agmt.clstatus=1 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Rental Weekend Open")){
				System.out.println("Rental Weekend Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,"+
				" CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8'"+
				" WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN"+
				" agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name deliveredDriver "+
				" from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on"+
				" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and"+
				" agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and agmt.weekend=1 and agmt.clstatus=0 and agmt.status=3";
			}
			else if (description.equalsIgnoreCase("Lease Open")) {
				System.out.println("Lease Open");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) fleet_no,ac.refname name,brout.branchname branchout,"+
				" agmt.outdate dateout,agmt.outtime timeout,agmt.outkm kmout,CASE WHEN agmt.outfuel=0.000 THEN 'Level 0/8' WHEN agmt.outfuel=0.125"+
				" THEN 'Level 1/8' WHEN agmt.outfuel=0.250 THEN 'Level 2/8' WHEN agmt.outfuel=0.375 THEN 'Level 3/8' WHEN agmt.outfuel=0.500 THEN"+
				" 'Level 4/8' WHEN agmt.outfuel=0.625 THEN 'Level 5/8'  WHEN agmt.outfuel=0.750 THEN 'Level 6/8' WHEN agmt.outfuel=0.875 THEN"+
				" 'Level 7/8' WHEN agmt.outfuel=1.000 THEN 'Level 8/8'  END  fuelout,det.sal_name deliveredDriver from gl_lagmt agmt left join"+
				" my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) left join (select rdocno,brhid,drid from gl_ldriver group by rdocno) drv on drv.rdocno=agmt.doc_no and drv.brhid=agmt.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where"+
				" agmt.brhid="+brhid+" and agmt.outdate>='"+sqlfromdate+"' and agmt.outdate<='"+sqltodate+"' and agmt.clstatus=0 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Lease Close")){
				System.out.println("Lease Close");
				strsql="select veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) fleet_no,ac.refname name,brout.branchname branchout,"+
				" agmt.outdate dateout,agmt.outtime timeout,agmt.outkm kmout,CASE WHEN agmt.outfuel=0.000 THEN 'Level 0/8' WHEN agmt.outfuel=0.125"+
				" THEN 'Level 1/8' WHEN agmt.outfuel=0.250 THEN 'Level 2/8' WHEN agmt.outfuel=0.375 THEN 'Level 3/8' WHEN agmt.outfuel=0.500 THEN"+
				" 'Level 4/8' WHEN agmt.outfuel=0.625 THEN 'Level 5/8'  WHEN agmt.outfuel=0.750 THEN 'Level 6/8' WHEN agmt.outfuel=0.875 THEN"+
				" 'Level 7/8' WHEN agmt.outfuel=1.000 THEN 'Level 8/8'  END  fuelout,brin.branchname branchin,lclose.indate datein,"+
				" lclose.intime timein,lclose.inkm kmin,CASE WHEN lclose.infuel=0.000 THEN 'Level 0/8' WHEN lclose.infuel=0.125 THEN 'Level 1/8'"+
				" WHEN lclose.infuel=0.250 THEN 'Level 2/8' WHEN lclose.infuel=0.375 THEN 'Level 3/8' WHEN lclose.infuel=0.500 THEN 'Level 4/8' WHEN"+
				" lclose.infuel=0.625 THEN 'Level 5/8'  WHEN lclose.infuel=0.750 THEN 'Level 6/8' WHEN lclose.infuel=0.875 THEN 'Level 7/8' WHEN"+
				" lclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin,det.sal_name  deliveredDriver  from gl_lagmt agmt left join"+
				" my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)"+
				" left join gl_lagmtclosem lclose on (agmt.doc_no=lclose.agmtno) left join my_brch brin on lclose.brchid=brin.doc_no left join (select rdocno,brhid,drid from gl_ldriver group by rdocno) drv on drv.rdocno=agmt.doc_no and drv.brhid=agmt.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV'"+
				" where agmt.brhid="+brhid+" and lclose.indate>='"+sqlfromdate+"' and lclose.indate<='"+sqltodate+"' and agmt.clstatus=1 and agmt.status=3";
			}
			else if(description.equalsIgnoreCase("Replacements")){
				strsql="select veh.reg_no,veh.flname,rep.doc_no,rep.doc_no voc_no,rep.ofleetno fleet_no,ac.refname name,brout.branchname branchout,rep.odate dateout,rep.otime"+
				" timeout,rep.okm kmout,CASE WHEN rep.ofuel=0.000 THEN 'Level 0/8' WHEN rep.ofuel=0.125 THEN 'Level 1/8' WHEN rep.ofuel=0.250 THEN"+
				" 'Level 2/8' WHEN rep.ofuel=0.375 THEN 'Level 3/8' WHEN rep.ofuel=0.500 THEN 'Level 4/8' WHEN rep.ofuel=0.625 THEN 'Level 5/8'"+
				" WHEN rep.ofuel=0.750 THEN 'Level 6/8' WHEN rep.ofuel=0.875 THEN 'Level 7/8' WHEN rep.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,"+
				" brin.branchname branchin,rep.indate datein,rep.intime timein,rep.inkm kmin,CASE WHEN rep.infuel=0.000 THEN 'Level 0/8'"+
				" WHEN rep.infuel=0.125 THEN 'Level 1/8' WHEN rep.infuel=0.250 THEN 'Level 2/8' WHEN rep.infuel=0.375 THEN 'Level 3/8'"+
				" WHEN rep.infuel=0.500 THEN 'Level 4/8' WHEN rep.infuel=0.625 THEN 'Level 5/8'  WHEN rep.infuel=0.750 THEN 'Level 6/8'"+
				" WHEN rep.infuel=0.875 THEN 'Level 7/8' WHEN rep.infuel=1.000 THEN 'Level 8/8'  END  fuelin,case when rep.rtype='LAG' then detl.sal_name when rep.rtype='RAG' then detr.sal_name end deliveredDriver from gl_vehreplace rep left join my_brch brout on"+
				" rep.obrhid=brout.doc_no left join my_brch brin on rep.inbrhid=brin.doc_no left join gl_ragmt ragmt on"+
				" (rep.rtype='RAG' and rep.rdocno=ragmt.doc_no) left join gl_lagmt lagmt on (rep.rtype='LAG' and rep.rdocno=lagmt.doc_no) left"+
				" join my_acbook ac on (if(rep.rtype='RAG',ragmt.cldocno=ac.cldocno,lagmt.cldocno=ac.cldocno) and ac.dtype='CRM') "+
				" left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drvr on ragmt.doc_no=drvr.rdocno and ragmt.brhid=drvr.brhid left join my_salesman detr on "+
				" detr.doc_no=ragmt.drid and detr.sal_type='DRV' left join (select rdocno,brhid,drid from gl_ldriver group by rdocno) drvl on drvl.rdocno=lagmt.doc_no and lagmt.brhid=drvl.brhid left join "+
				" my_salesman detl on detl.doc_no=lagmt.drid and detl.sal_type='DRV' left join gl_vehmaster veh on  veh.fleet_no=rep.ofleetno where rep.obrhid="+brhid+""+
				"  and rep.status=3 and rep.date>='"+sqlfromdate+"' and rep.date<='"+sqltodate+"'";
			}
			else if(description.equalsIgnoreCase("Movement Garage Accident")){
				strsql="select  veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name deliveredDriver  from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GA' and nrm.brhid="+brhid+" and nrm.status=3 group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Movement Garage Maintenance")){
				strsql="select  veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name deliveredDriver  from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GM' and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Movement Garage Service")){
				strsql="select veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin ,dr.sal_name deliveredDriver from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GS' and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Movement Staff")){
				strsql="select veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name deliveredDriver  from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='ST' and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Movement Transfer")){
				strsql="select veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name,brout.branchname branchout,minmov.dout dateout,"+
				" minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN"+
				" minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
				" minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
				" minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,"+
				" CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
				" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
				" maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name deliveredDriver  from ("+
				" select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm inner join gl_vmove mov on (nrm.doc_no=mov.rdocno"+
				" and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='TR' and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no)"+
				" left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "+
				" left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on"+
				" (nrm.staffid=stf.doc_no and stf.sal_type='STF')";
			}
			else if(description.equalsIgnoreCase("Ready To Rent")){
				strsql="select veh.reg_no,veh.flname,veh.doc_no,veh.doc_no voc_no,veh.fleet_no fleet_no,veh.flname name,'' branchout,'' dateout,'' timeout, "+
				" '' kmout,'' fuelout, brin.branchname branchin,'' datein,'' timein,'' kmin,'' fuelin from gl_vehmaster veh "+
				" left join my_brch brin on veh.a_br=brin.doc_no where veh.a_br="+brhid+" and veh.tran_code='RR' and veh.statu=3 "+
				" and reg_exp>=curdate() and ins_exp>=curdate() ";	
			}
			else if(description.equalsIgnoreCase("Unrentable")){
				strsql="select veh.reg_no,veh.flname,veh.doc_no,veh.doc_no voc_no,veh.fleet_no fleet_no,veh.flname name,'' branchout,'' dateout,'' timeout, "+
				" '' kmout,'' fuelout, brin.branchname branchin,'' datein,'' timein,'' kmin,'' fuelin from gl_vehmaster veh "+
				" left join my_brch brin on veh.a_br=brin.doc_no where veh.a_br="+brhid+" and veh.tran_code='UR' and veh.statu=3 ";	
			}
			
			
			if(!strsql.equalsIgnoreCase("")){
			//	System.out.println("detail grid==="+strsql);
				
				ResultSet rs=stmt.executeQuery(strsql);
				detaildata=objcommon.convertToEXCEL(rs);
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return detaildata;
	}*/
	
	public JSONArray getDetailDataEx(String description,String branch,String fromdate,String todate,String id) throws SQLException{
		JSONArray detaildata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return detaildata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",st="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			//System.out.println("Description: "+description);
			String brhid="";
			if(branch.equalsIgnoreCase("branch0")){
				brhid="1";
			}
			else if(branch.equalsIgnoreCase("branch1")){
				brhid="2";
			}
			else if(branch.equalsIgnoreCase("branch2")){
				brhid="3";
			}
			else if(branch.equalsIgnoreCase("branch3")){
				brhid="4";
			}
			else if(branch.equalsIgnoreCase("branch4")){
				brhid="5";
			}
			else if(branch.equalsIgnoreCase("branch5")){
				brhid="6";
			}
			else if(branch.equalsIgnoreCase("branch6")){
				brhid="7";
			}
			else if(branch.equalsIgnoreCase("branch7")){
				brhid="8";
			}
			else if(branch.equalsIgnoreCase("branch8")){
				brhid="9";
			}
			else if(branch.equalsIgnoreCase("branch9")){
				brhid="10";
			}
			
			String strbranch="select doc_no,branchname from my_brch where status=3";
			ResultSet rsbranch=stmt.executeQuery(strbranch);
			String branchname="";
			int y=0;
			int branchcount=0;
			while(rsbranch.next()){
				branchcount++;
				
				
			}
			
			String strfinal="select b.horizontotal,b.description,b.brcount,b.branch0,b.branch1,b.branch2,"+
					" b.branch3,b.branch4,b.branch5,b.branch6,b.branch7,b.branch8,b.branch9 from (select a.orderstatus,"+branchcount+" "+
					" brcount,a.description,sum(a.branch0) branch0,sum(a.branch1) branch1,sum(a.branch2) branch2,sum(a.branch3) branch3,sum(a.branch4) branch4,sum(a.branch5) "+
					" branch5,sum(a.branch6) branch6,sum(a.branch7) branch7,sum(a.branch8) branch8,sum(a.branch9) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+"+
					" sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from "+
					" ("
					+ "select case when tarif.rentaltype='Daily' then 'Rental Daily Open' when tarif.rentaltype='Weekly' then  'Rental Weekly Open' when"+
					" tarif.rentaltype='Monthly' then 'Rental Monthly Open' when agmt.weekend=1 then 'Rental Weekend Open' else '' end description,"+
					" case when tarif.rentaltype='Daily' then 1 when  tarif.rentaltype='Weekly' then 2 when tarif.rentaltype='Monthly' then 3 when"+
					" agmt.weekend=1 then 4 else 0 end orderstatus, if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,count(*),0) branch1,"+
					" if(agmt.brhid=3,count(*),0)  branch2, if(agmt.brhid=4, count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,"+
					" count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8,"+
					" if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt inner join  gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and"+
					" tarif.rstatus=5) where agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and agmt.status=3 and agmt.clstatus=0 group by"+
					" agmt.doc_no"+
					" union all"+
					" select case when tarif.rentaltype in ('Daily','Weekly','Monthly') or agmt.weekend=1 then 'Total Rental Open' else '' end description,"+
					" case when tarif.rentaltype in ('Daily','Weekly','Monthly') or agmt.weekend=1 then 5 else 0 end orderstatus,"+
					" if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,count(*),0) branch1,if(agmt.brhid=3,count(*),0)  branch2, if(agmt.brhid=4,"+
					" count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6,"+
					" if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt"+
					" inner join  gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) where agmt.odate>='"+sqlfromdate+"' and "+
					" agmt.odate<='"+sqltodate+"' and agmt.status=3 and agmt.clstatus=0 group by agmt.doc_no"+
					" union all"+
					" select case when tarif.rentaltype='Daily' then 'Rental Daily Close' when tarif.rentaltype='Weekly' then 'Rental Weekly Close' when"+
					" tarif.rentaltype='Monthly' then 'Rental Monthly Close' when agmt.weekend=1 then 'Rental Weekend Close' else '' end description, case when tarif.rentaltype='Daily'"+
					" then 6 when tarif.rentaltype='Weekly' then 7 when tarif.rentaltype='Monthly'  then 8 when agmt.weekend=1 then 9 else 0 end orderstatus,if(agmt.brhid=1,count(*),0)"+
					" branch0, if(agmt.brhid=2,count(*),0) branch1,if(agmt.brhid=3,count(*),0)  branch2, if(agmt.brhid=4,count(*),0) branch3,"+
					" if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,"+
					" count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt inner join"+
					" gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join gl_ragmtclosem agmtclose on"+
					" (agmt.doc_no=agmtclose.agmtno and agmt.clstatus=1) where agmtclose.indate>='"+sqlfromdate+"' and agmtclose.indate<='"+sqltodate+"' and"+
					" agmt.status=3 and agmt.clstatus=1 group by agmt.doc_no"+
					" union all"+
					" select case when tarif.rentaltype in ('Daily','Weekly','Monthly')"+
					" or agmt.weekend=1 then 'Total Rental Close' else '' end description, case when tarif.rentaltype in ('Daily','Weekly','Monthly') or"+
					" agmt.weekend=1 then 10 else 0 end orderstatus,if(agmt.brhid=1,count(*),0) branch0, if(agmt.brhid=2,count(*),0) branch1,"+
					" if(agmt.brhid=3,count(*),0)  branch2, if(agmt.brhid=4,count(*),0) branch3, if(agmt.brhid=5,count(*),0) branch4,if(agmt.brhid=6,"+
					" count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,count(*),0) branch8,"+
					" if(agmt.brhid=10,count(*),0) branch9 from gl_ragmt agmt inner join  gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5)"+
					" left join gl_ragmtclosem agmtclose on (agmt.doc_no=agmtclose.agmtno and agmt.clstatus=1) where agmtclose.indate>='"+sqlfromdate+"' and "+
					" agmtclose.indate<='"+sqltodate+"' and agmt.status=3 and agmt.clstatus=1 group by agmt.doc_no) a group by a.description"+
					" UNION ALL"+
					" select a.orderstatus,6 brcount,a.description,sum(a.branch0) branch0,sum(a.branch1) branch1,sum(a.branch2) branch2,sum(a.branch3)"+
					" branch3,sum(a.branch4) branch4,sum(a.branch5) branch5,sum(a.branch6) branch6,sum(a.branch7) branch7,sum(a.branch8) branch8,"+
					" sum(a.branch9) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+ sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)"+
					" +sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from ( select if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,"+
					" count(*),0) branch1,if(agmt.brhid=3,count(*),0) branch2, if(agmt.brhid=4,count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,"+
					" if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,"+
					" count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9,'Lease Open' description,11 orderstatus from gl_lagmt"+
					" agmt where agmt.clstatus=0 and agmt.outdate>='"+sqlfromdate+"' and agmt.outdate<='"+sqltodate+"' and agmt.status=3 group by agmt.doc_no) a group by a.description "+
					" union all "+
					" select a.orderstatus,6 brcount,a.description,sum(a.branch0) branch0,sum(a.branch1) branch1,sum(a.branch2) branch2,sum(a.branch3)"+
					" branch3,sum(a.branch4) branch4,sum(a.branch5) branch5,sum(a.branch6) branch6,sum(a.branch7) branch7,sum(a.branch8) branch8,"+
					" sum(a.branch9) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+ sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)"+
					" +sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from ( select if(agmt.brhid=1,count(*),0) branch0,if(agmt.brhid=2,"+
					" count(*),0) branch1,if(agmt.brhid=3,count(*),0) branch2, if(agmt.brhid=4,count(*),0) branch3,if(agmt.brhid=5,count(*),0) branch4,"+
					" if(agmt.brhid=6,count(*),0) branch5, if(agmt.brhid=7,count(*),0) branch6, if(agmt.brhid=8,count(*),0) branch7,if(agmt.brhid=9,"+
					" count(*),0) branch8, if(agmt.brhid=10,count(*),0) branch9,'Lease Close' description,12 orderstatus from gl_lagmt"+
					" agmt left join gl_lagmtclosem agmtclose on (agmt.doc_no=agmtclose.agmtno and agmt.clstatus=1) where agmt.clstatus=1 and "+
					" agmtclose.indate>='"+sqlfromdate+"' and agmtclose.indate<='"+sqltodate+"' and agmt.status=3 group by agmt.doc_no"+
					" ) a"+
					" group by a.description UNION ALL"+
					" select a.orderstatus,"+branchcount+" brcount,'Replacements' description,coalesce(sum(a.branch0),0) branch0,coalesce(sum(a.branch1),0) branch1,coalesce(sum(a.branch2),0)"+
					" branch2,coalesce(sum(a.branch3),0) branch3,coalesce(sum(a.branch4),0) branch4,coalesce(sum(a.branch5),0) branch5,coalesce(sum(a.branch6),0)"+
					" branch6, coalesce(sum(a.branch7),0) branch7,coalesce(sum(a.branch8),0) branch8,coalesce(sum(a.branch9),0) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+"+
					" sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from ( select"+
					" 13 orderstatus,if(rep.obrhid =1,count(*),0) branch0,if(rep.obrhid =2,count(*),0) branch1,if(rep.obrhid =3,count(*),0) branch2, if(rep.obrhid =4,count(*),0)"+
					" branch3, if(rep.obrhid =5,count(*),0) branch4,if(rep.obrhid =6,count(*),0) branch5, if(rep.obrhid =7,count(*),0) branch6,"+
					" if(rep.obrhid =8,count(*),0) branch7, if(rep.obrhid =9,count(*),0) branch8,if(rep.obrhid =10,count(*),0) branch9 from gl_vehreplace rep where"+
					"  rep.date>='"+sqlfromdate+"' and rep.date<='"+sqltodate+"'  and rep.status=3 group by rep.doc_no) a union all"+
					" select a.orderstatus,"+branchcount+" brcount,'Ready To Rent' description,coalesce(sum(a.branch0),0) branch0, "+
					" coalesce(sum(a.branch1),0) branch1,coalesce(sum(a.branch2),0) branch2,coalesce(sum(a.branch3),0) branch3, "+
					" coalesce(sum(a.branch4),0) branch4,coalesce(sum(a.branch5),0) branch5,coalesce(sum(a.branch6),0) branch6, "+
					" coalesce(sum(a.branch7),0) branch7,coalesce(sum(a.branch8),0) branch8,coalesce(sum(a.branch9),0) branch9, "+
					" (sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+ sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+ "+
					" sum(a.branch8)+sum(a.branch9)) horizontotal from ( select 19 orderstatus,if(veh.a_br =1,count(*),0) branch0, "+
					" if(veh.a_br =2,count(*),0) branch1,if(veh.a_br =3,count(*),0) branch2, if(veh.a_br =4,count(*),0) branch3, "+
					" if(veh.a_br =5,count(*),0) branch4,if(veh.a_br =6,count(*),0) branch5, if(veh.a_br =7,count(*),0) branch6, "+
					" if(veh.a_br =8,count(*),0) branch7, if(veh.a_br =9,count(*),0) branch8,if(veh.a_br =10,count(*),0) branch9 "+
					" from gl_vehmaster veh where veh.tran_code='RR' and veh.statu=3 and reg_exp>=curdate() and ins_exp>=curdate() group by veh.doc_no) a "+
					" union all select a.orderstatus,"+branchcount+" brcount,'Unrentable' description,coalesce(sum(a.branch0),0) branch0,  coalesce(sum(a.branch1),0) branch1,"+
					" coalesce(sum(a.branch2),0) branch2,coalesce(sum(a.branch3),0) branch3,  coalesce(sum(a.branch4),0) branch4,coalesce(sum(a.branch5),0) branch5,coalesce(sum(a.branch6),0) branch6, "+
					" coalesce(sum(a.branch7),0) branch7,coalesce(sum(a.branch8),0) branch8,coalesce(sum(a.branch9),0) branch9, "+
					"  (sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+ sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+  sum(a.branch8)+sum(a.branch9)) horizontotal "+
					" from ( select 20 orderstatus,if(veh.a_br =1,count(*),0) branch0,  if(veh.a_br =2,count(*),0) branch1,if(veh.a_br =3,count(*),0) branch2, if(veh.a_br =4,count(*),0) branch3, "+
					" if(veh.a_br =5,count(*),0) branch4,if(veh.a_br =6,count(*),0) branch5, if(veh.a_br =7,count(*),0) branch6,  if(veh.a_br =8,count(*),0) branch7,"+
					" if(veh.a_br =9,count(*),0) branch8,if(veh.a_br =10,count(*),0) branch9  from gl_vehmaster veh where veh.tran_code='UR' and veh.statu=3 group by veh.doc_no) a  UNION ALL"+
					" select a.orderstatus,"+branchcount+" brcount,a.description,sum(a.branch0) branch0,sum(a.branch1) branch1,sum(a.branch2) branch2,sum(a.branch3) branch3,"+
					" sum(a.branch4) branch4, sum(a.branch5) branch5,sum(a.branch6) branch6,sum(a.branch7) branch7,sum(a.branch8) branch8,"+
					" sum(a.branch9) branch9,(sum(a.branch0)+sum(a.branch1)+sum(a.branch2)+"+
					" sum(a.branch3)+sum(a.branch4)+sum(a.branch5)+sum(a.branch6)+sum(a.branch7)+sum(a.branch8)+sum(a.branch9)) horizontotal from ( "+
					" select case when movtype='TR' then 14 when movtype='ST' then 15 when movtype='GA' then 16"+
					" when movtype='GM' then 17 when movtype='GS' then 18 else 0 end orderstatus,case when movtype='TR' then 'Movement Transfer' when"+
					" movtype='ST' then 'Movement Staff' when movtype='GA' then 'Movement Garage Accident'  when movtype='GM' then"+
					" 'Movement Garage Maintenance' when movtype='GS' then 'Movement Garage Service' else '' end description, if(nrm.brhid =1,count(*),0) branch0,"+
					" if(nrm.brhid =2,count(*),0) branch1,if(nrm.brhid =3,count(*),0) branch2,if(nrm.brhid =4,count(*),0) branch3, if(nrm.brhid =5,count(*),0) branch4,"+
					" if(nrm.brhid =6,count(*),0) branch5,if(nrm.brhid =7,count(*),0) branch6,if(nrm.brhid =8,count(*),0) branch7, if(nrm.brhid =9,count(*),0) branch8,"+
					" if(nrm.brhid =10,count(*),0) branch9 from gl_nrm nrm where  nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"'  and nrm.status=3 group by nrm.doc_no) a  group by a.description) "+
					" b order by b.orderstatus";
					System.out.println("summary grid===="+strfinal);
					ResultSet rsfinal=stmt.executeQuery(strfinal);
			
			
			while(rsfinal.next()){
			//	System.out.println("detail grid==="+strsql);
				
				st+="'"+rsfinal.getString("description")+"'"+",";
				
			}
			st=st+"'"+0+"'";
			System.out.println("st==="+st);
			detaildata=getExcelDetails(sqlfromdate,sqltodate,brhid,st);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return detaildata;
	}
	public JSONArray getExcelDetails(Date sqlfromdate,Date sqltodate,String brhid,String st) throws SQLException{
		JSONArray excel=new JSONArray();
		Connection conn=null;
		try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
String str="select diff 'DESCRIPTION',voc_no 'DOC_NO',name 'NAME',fleet_no 'FLEET_NO',reg_no 'REG_NO',flname 'FLEET NAME',branchout 'BRANCH OUT',convert(dateout,char(50)) 'DATE OUT',convert(timeout,char(50)) 'TIME OUT',convert(kmout,char(50)) 'KM OUT',fuelout 'FUEL OUT',branchin 'BRANCH IN',convert(datein,char(50)) 'DATE IN',convert(timein,char(50)) 'TIME IN',convert(kmin,char(50)) 'KM IN',fuelin 'FUEL OUT',driver 'DELIVERED DRIVER' from (select 'Rental Daily Open' diff,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,convert(agmt.odate,char(50)) dateout,agmt.otime timeout,agmt.okm kmout, CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' " 
+ "WHEN agmt.ofuel=0.250 THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8' "
+ "WHEN agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,'' fuelin,'' kmin,'' timein,'' datein,'' branchin,det.sal_name driver from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) "
+ "left join my_acbook ac on(agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)  "
+ "left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid "
+ "left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' " 
+ "where agmt.brhid="+brhid+" and agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Daily' " 
+ "and agmt.clstatus=0 and agmt.status=3 union all "
+ "select 'UNRENTABLE' diff,veh.reg_no,veh.flname,veh.doc_no,veh.doc_no voc_no,veh.fleet_no fleet_no,veh.flname name,'' branchout, "
+ "'' dateout,'' timeout,  '' kmout,'' fuelout,'' fuelin,'' kmin,'' timein,'' datein,'' branchin,'' driver from gl_vehmaster veh  "
+ "left join my_brch brin on veh.a_br=brin.doc_no where veh.a_br=1 and veh.tran_code='UR' and veh.statu=3 "
+ "union all select 'Rental Weekly Open' diff,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout, "
+ "agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' "
+ "WHEN agmt.ofuel=0.250 THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8' "
+ "WHEN agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,'' fuelin,'' kmin,'' timein,'' datein,'' branchin,det.sal_name driver from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) " 
+ "left join my_acbook ac on(agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no)  " 
+ "left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid "
+ "left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' "
+ "where agmt.brhid="+brhid+" and agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Weekly' " 
+ "and agmt.clstatus=0 and agmt.status=3 union all "
+ "select 'Rental Monthly Open' diff,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name, "
+ "brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' " 
+ "WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,'' fuelin,'' kmin,'' timein,'' datein,'' branchin,det.sal_name driver from gl_ragmt agmt " 
+ "inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) left join my_acbook ac on(agmt.cldocno=ac.cldocno and ac.dtype='CRM') "
+ "left join my_brch brout on (agmt.brhid=brout.doc_no)  left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno " 
+ "and agmt.brhid=drv.brhid left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Monthly' " 
+ "and agmt.clstatus=0  and agmt.status=3 union all "
+ "select 'Total Rental Open' diff,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' "
+ " WHEN agmt.ofuel=0.250 THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,'' fuelin,'' kmin, "
+ "'' timein,'' datein,'' branchin,det.sal_name driver from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) " 
+ " left join my_acbook ac on(agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) "
+ " left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid " 
+ " left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" " 
+ " and agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and (tarif.rentaltype in('Daily','Weekly','Monthly') or agmt.weekend=1) "
+ " and agmt.clstatus=0  and agmt.status=3 union all select 'Rental Daily Close' diff,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no, "
+ " ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' "
+ " WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8' "
+ "WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8' "
+ "WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8' "
+ "WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin ,det.sal_name driver "
+ "from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) " 
+ "left join my_acbook ac on(agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) " 
+ "left join gl_ragmtclosem rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no "
+ "left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid "
+ "left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" " 
+ "and rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Daily' and agmt.clstatus=1 "
+ "  and agmt.status=3 union all "
+ "select 'Rental Weekly Close' diff,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' "
+ " WHEN agmt.ofuel=0.250 THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout, "
+ "brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8' "
+ "WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8' "
+ "WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8' "
+ "WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin ,det.sal_name driver "
+ "from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) "
+ "left join my_acbook ac on(agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) " 
+ "left join gl_ragmtclosem rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no "
+ "left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid " 
+ "left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" " 
+ "and rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Weekly' and agmt.clstatus=1 "
+ "  and agmt.status=3 union all "
+ "  select 'Rental Monthly Close' diff,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout, "
+ "  agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' "
+ "WHEN agmt.ofuel=0.250 THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8' "
+ "WHEN agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout, "
+ "brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8' "
+ "WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8' "
+ "WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8' "
+ "WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin,det.sal_name driver  "
+ "from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) "
+ "left join my_acbook ac on(agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) " 
+ "left join gl_ragmtclosem rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no  "
+ "left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid " 
+ "left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" "
+ "and rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and tarif.rentaltype='Monthly' and agmt.clstatus=1 "
+ "and agmt.status=3 union all " 
+ "select  'Total Rental Close' diff,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' "
+ "WHEN agmt.ofuel=0.250 THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8' "
+ "WHEN agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout, "
+ "brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8' "
+ "WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8' "
+ "WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8' "
+ "WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin ,det.sal_name driver "
+ "from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) "
+ "left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) " 
+ "left join gl_ragmtclosem rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no "
+ "left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid " 
+ "left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" " 
+ "and rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 "
+ "and (tarif.rentaltype in('Daily','Weekly','Monthly') or agmt.weekend=1) "
+ "and agmt.clstatus=1 and agmt.status=3 union all select  'Rental Weekend Close' diff,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no, "
+ "ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' "
+ "WHEN agmt.ofuel=0.125 THEN 'Level 1/8' WHEN agmt.ofuel=0.250 THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8'  WHEN agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,brin.branchname branchin,rclose.indate datein,rclose.intime timein,rclose.inkm kmin,CASE WHEN rclose.infuel=0.000 THEN 'Level 0/8' "
+ "WHEN rclose.infuel=0.125 THEN 'Level 1/8' WHEN rclose.infuel=0.250 THEN 'Level 2/8' WHEN rclose.infuel=0.375 THEN 'Level 3/8' "
+ "WHEN rclose.infuel=0.500 THEN 'Level 4/8' WHEN rclose.infuel=0.625 THEN 'Level 5/8'  WHEN rclose.infuel=0.750 THEN 'Level 6/8' "
+ "WHEN rclose.infuel=0.875 THEN 'Level 7/8' WHEN rclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin,det.sal_name driver "
+ "from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) "
+ "left join my_acbook ac on(agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) " 
+ "left join gl_ragmtclosem rclose on agmt.doc_no=rclose.agmtno left join my_brch brin on rclose.brchid=brin.doc_no "
+ "left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid " 
+ "left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" " 
+ "and rclose.indate>='"+sqlfromdate+"' and rclose.indate<='"+sqltodate+"' and tarif.rstatus=5 and agmt.weekend=1 and agmt.clstatus=1 "
+ " and agmt.status=3 union all "
+ "select 'Rental Weekend Open' diff,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,agmt.fleet_no,ac.refname name,brout.branchname branchout,agmt.odate dateout,agmt.otime timeout,agmt.okm kmout,CASE WHEN agmt.ofuel=0.000 THEN 'Level 0/8' WHEN agmt.ofuel=0.125 THEN 'Level 1/8' "
+ "WHEN agmt.ofuel=0.250 THEN 'Level 2/8' WHEN agmt.ofuel=0.375 THEN 'Level 3/8' WHEN agmt.ofuel=0.500 THEN 'Level 4/8' WHEN agmt.ofuel=0.625 THEN 'Level 5/8' "
+ "WHEN agmt.ofuel=0.750 THEN 'Level 6/8' WHEN agmt.ofuel=0.875 THEN 'Level 7/8' WHEN agmt.ofuel=1.000 THEN 'Level 8/8'  END  fuelout,'' branchin,'' datein, "
+ "'' timein,'' kmin,'' fuelin,det.sal_name driver from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) "
+ "left join my_acbook ac on(agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) "
+ "left join (select rdocno,brhid,drid from gl_rdriver group by rdocno  ) drv on agmt.doc_no=drv.rdocno and agmt.brhid=drv.brhid " 
+ "left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no  left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" "
+ " and agmt.odate>='"+sqlfromdate+"' and agmt.odate<='"+sqltodate+"' and tarif.rstatus=5 and agmt.weekend=1 and agmt.clstatus=0 "
+ " and agmt.status=3 union all "
+ "select 'Lease Open' diff,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) fleet_no,ac.refname name,brout.branchname branchout,agmt.outdate dateout,agmt.outtime timeout,agmt.outkm kmout,CASE WHEN agmt.outfuel=0.000 THEN 'Level 0/8' "
+ "WHEN agmt.outfuel=0.125 THEN 'Level 1/8' WHEN agmt.outfuel=0.250 THEN 'Level 2/8' WHEN agmt.outfuel=0.375 THEN 'Level 3/8' "
+ "WHEN agmt.outfuel=0.500 THEN 'Level 4/8' WHEN agmt.outfuel=0.625 THEN 'Level 5/8'  WHEN agmt.outfuel=0.750 THEN 'Level 6/8' "
+ " WHEN agmt.outfuel=0.875 THEN 'Level 7/8' WHEN agmt.outfuel=1.000 THEN 'Level 8/8'  END  fuelout,'' branchin,'' datein,'' timein,'' kmin,'' fuelin, "
+ " det.sal_name driver from gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') "
+ " left join my_brch brout on (agmt.brhid=brout.doc_no) left join (select rdocno,brhid,drid from gl_ldriver group by rdocno) drv on drv.rdocno=agmt.doc_no "
+ " and drv.brhid=agmt.brhid left join gl_vehmaster veh on if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no "
+ " left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' where agmt.brhid="+brhid+" and agmt.outdate>='"+sqlfromdate+"' "
+ " and agmt.outdate<='"+sqltodate+"' and agmt.clstatus=0 and agmt.status=3 union all "
+ "select 'Lease Close' diff,veh.reg_no,veh.flname,agmt.doc_no,agmt.voc_no,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) fleet_no,ac.refname name, "
+ "brout.branchname branchout,agmt.outdate dateout,agmt.outtime timeout,agmt.outkm kmout,CASE WHEN agmt.outfuel=0.000 THEN 'Level 0/8' "
+ "WHEN agmt.outfuel=0.125 THEN 'Level 1/8' WHEN agmt.outfuel=0.250 THEN 'Level 2/8' WHEN agmt.outfuel=0.375 THEN 'Level 3/8' "
+ "WHEN agmt.outfuel=0.500 THEN 'Level 4/8' WHEN agmt.outfuel=0.625 THEN 'Level 5/8'  WHEN agmt.outfuel=0.750 THEN 'Level 6/8' "
+ " WHEN agmt.outfuel=0.875 THEN 'Level 7/8' WHEN agmt.outfuel=1.000 THEN 'Level 8/8'  END  fuelout,brin.branchname branchin,lclose.indate datein, "
+ "lclose.intime timein,lclose.inkm kmin,CASE WHEN lclose.infuel=0.000 THEN 'Level 0/8' WHEN lclose.infuel=0.125 THEN 'Level 1/8' "
+ "WHEN lclose.infuel=0.250 THEN 'Level 2/8' WHEN lclose.infuel=0.375 THEN 'Level 3/8' WHEN lclose.infuel=0.500 THEN 'Level 4/8' "
+ " WHEN lclose.infuel=0.625 THEN 'Level 5/8'  WHEN lclose.infuel=0.750 THEN 'Level 6/8' WHEN lclose.infuel=0.875 THEN 'Level 7/8' "
+ " WHEN lclose.infuel=1.000 THEN 'Level 8/8'  END  fuelin,det.sal_name  driver  from gl_lagmt agmt "
+ " left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch brout on (agmt.brhid=brout.doc_no) "
+ "left join gl_lagmtclosem lclose on (agmt.doc_no=lclose.agmtno) left join my_brch brin on lclose.brchid=brin.doc_no "
+ "left join (select rdocno,brhid,drid from gl_ldriver group by rdocno) drv on drv.rdocno=agmt.doc_no and drv.brhid=agmt.brhid "
+ "left join gl_vehmaster veh on if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no  "
+ "left join my_salesman det on agmt.drid=det.doc_no and det.sal_type='DRV' "
+ "where agmt.brhid="+brhid+" and lclose.indate>='"+sqlfromdate+"' and lclose.indate<='"+sqltodate+"' and agmt.clstatus=1 and agmt.status=3 union all "
+ "select 'Replacements' diff,veh.reg_no,veh.flname,rep.doc_no,rep.doc_no voc_no,rep.ofleetno fleet_no,ac.refname name,brout.branchname branchout, "
+ "rep.odate dateout,rep.otime timeout,rep.okm kmout,CASE WHEN rep.ofuel=0.000 THEN 'Level 0/8' WHEN rep.ofuel=0.125 THEN 'Level 1/8' "
+ "WHEN rep.ofuel=0.250 THEN 'Level 2/8' WHEN rep.ofuel=0.375 THEN 'Level 3/8' WHEN rep.ofuel=0.500 THEN 'Level 4/8' WHEN rep.ofuel=0.625 THEN 'Level 5/8' "
+ "WHEN rep.ofuel=0.750 THEN 'Level 6/8' WHEN rep.ofuel=0.875 THEN 'Level 7/8' WHEN rep.ofuel=1.000 THEN 'Level 8/8'  END  fuelout, "
+ "brin.branchname branchin,rep.indate datein,rep.intime timein,rep.inkm kmin,CASE WHEN rep.infuel=0.000 THEN 'Level 0/8' "
+ "WHEN rep.infuel=0.125 THEN 'Level 1/8' WHEN rep.infuel=0.250 THEN 'Level 2/8' WHEN rep.infuel=0.375 THEN 'Level 3/8' "
+ "WHEN rep.infuel=0.500 THEN 'Level 4/8' WHEN rep.infuel=0.625 THEN 'Level 5/8'  WHEN rep.infuel=0.750 THEN 'Level 6/8' "
+ "WHEN rep.infuel=0.875 THEN 'Level 7/8' WHEN rep.infuel=1.000 THEN 'Level 8/8'  END  fuelin,case when rep.rtype='LAG' then detl.sal_name " 
+ "when rep.rtype='RAG' then detr.sal_name end driver from gl_vehreplace rep left join my_brch brout on rep.obrhid=brout.doc_no "
+ "left join my_brch brin on rep.inbrhid=brin.doc_no left join gl_ragmt ragmt on(rep.rtype='RAG' and rep.rdocno=ragmt.doc_no) "
+ "left join gl_lagmt lagmt on (rep.rtype='LAG' and rep.rdocno=lagmt.doc_no) "
+ "left join my_acbook ac on (if(rep.rtype='RAG',ragmt.cldocno=ac.cldocno,lagmt.cldocno=ac.cldocno) and ac.dtype='CRM') " 
+ "left join (select rdocno,brhid,drid from gl_rdriver group by rdocno) drvr on ragmt.doc_no=drvr.rdocno and ragmt.brhid=drvr.brhid " 
+ "left join my_salesman detr on detr.doc_no=ragmt.drid and detr.sal_type='DRV' "
+ "left join (select rdocno,brhid,drid from gl_ldriver group by rdocno) drvl on drvl.rdocno=lagmt.doc_no and lagmt.brhid=drvl.brhid "
+ "left join my_salesman detl on detl.doc_no=lagmt.drid and detl.sal_type='DRV' left join gl_vehmaster veh on  veh.fleet_no=rep.ofleetno " 
+ "where rep.obrhid="+brhid+" and rep.status=3 and rep.date>='"+sqlfromdate+"' and rep.date<='"+sqltodate+"' union all "
+ "select 'Movement Garage Accident' diff,veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name, "
+ "brout.branchname branchout,minmov.dout dateout,minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' "
+ "WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' "
+ " WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' "
+ " WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' "
+ " WHEN maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' "
+ " WHEN maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin, "
+ " dr.sal_name driver  from (select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm "
+ " inner join gl_vmove mov on (nrm.doc_no=mov.rdocno and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GA' "
+ " and nrm.brhid="+brhid+" and nrm.status=3 group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no) "
+ "left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "
+ "left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no "
+ "left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on (nrm.staffid=stf.doc_no and stf.sal_type='STF') union all "
+ "select  'Movement Garage Maintenance' diff,veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name, "
+ "brout.branchname branchout,minmov.dout dateout,minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' "
+ " WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' "
+ " WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' "
+ " WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' "
+ " WHEN maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' "
+ " WHEN maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name driver " 
+ " from (select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm "
+ " inner join gl_vmove mov on (nrm.doc_no=mov.rdocno and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GM' "
+ " and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no) "
+ "left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no " 
+ "left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no "
+ "left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on (nrm.staffid=stf.doc_no and stf.sal_type='STF') union all "
+ "select 'Movement Garage Service' diff,veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name, "
+ "brout.branchname branchout,minmov.dout dateout, minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' "
+ " WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' "
+ " WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' "
+ " WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' "
+ " WHEN maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' "
+ " WHEN maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin ,dr.sal_name driver "
+ " from (select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm "
+ " inner join gl_vmove mov on (nrm.doc_no=mov.rdocno and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='GS' " 
+ " and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no) "
+ "left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no " 
+ "left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no "
+ "left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on (nrm.staffid=stf.doc_no and stf.sal_type='STF') union all "
+ "select 'Movement Staff' diff,veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name, "
+ "brout.branchname branchout,minmov.dout dateout,minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' "
+ " WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' "
+ " WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' "
+ " WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' " 
+ " WHEN maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' "
+ " WHEN maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name driver "
+ " from (select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm "
+ " inner join gl_vmove mov on (nrm.doc_no=mov.rdocno and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='ST' "
+ " and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no) "
+ "left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no "
+ "left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no "
+ "left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on (nrm.staffid=stf.doc_no and stf.sal_type='STF') union all "
+ "select 'Movement Transfer' diff,veh.reg_no,veh.flname,nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,if(nrm.drid=0,stf.sal_name,dr.sal_name) name, "
+ "brout.branchname branchout,minmov.dout dateout,minmov.tout timeout,minmov.kmout,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' "
+ " WHEN minmov.fout=0.125 THEN 'Level 1/8' WHEN minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' " 
+ " WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN minmov.fout=0.625 THEN 'Level 5/8' WHEN minmov.fout=0.750 THEN 'Level 6/8' "
+ " WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN minmov.fout=1.000 THEN 'Level 8/8' END fuelout,brin.branchname branchin,maxmov.din datein,maxmov.tin timein,maxmov.kmin,CASE WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' "
+ " WHEN maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' "
+ " WHEN maxmov.fin=0.750 THEN 'Level 6/8' WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' END fuelin,dr.sal_name driver " 
+ " from (select min(mov.doc_no) mindocno,max(mov.doc_no) maxdocno,mov.rdocno from gl_nrm nrm "
+ " inner join gl_vmove mov on (nrm.doc_no=mov.rdocno and mov.rdtype='MOV') where nrm.date>='"+sqlfromdate+"' and nrm.date<='"+sqltodate+"' and nrm.movtype='TR' "
+ " and nrm.brhid="+brhid+"  and nrm.status=3  group by mov.rdocno,mov.rdtype)a left join gl_vmove minmov on (a.mindocno=minmov.doc_no) "
+ "left join gl_vmove maxmov on (a.maxdocno=maxmov.doc_no) left join gl_nrm nrm on a.rdocno=nrm.doc_no left join my_brch brout on nrm.outbranch=brout.doc_no " 
+ "left join my_brch brin on nrm.inbranch=brin.doc_no left join gl_vehmaster veh on  veh.fleet_no=nrm.fleet_no "
+ "left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman stf on(nrm.staffid=stf.doc_no and stf.sal_type='STF') union all "
+ "select 'Ready To Rent' diff,veh.reg_no,veh.flname,veh.doc_no,veh.doc_no voc_no,veh.fleet_no fleet_no,veh.flname name,'' branchout,'' dateout,'' timeout, "
+ "'' kmout,'' fuelout, brin.branchname branchin,'' datein,'' timein,'' kmin,'' fuelin,'' driver from gl_vehmaster veh "
+ "left join my_brch brin on veh.a_br=brin.doc_no where veh.a_br=1 and veh.tran_code='RR' and veh.statu=3 and reg_exp>=curdate() and ins_exp>=curdate()) a where a.diff in ("+st+")";


		System.out.println("excel query==="+str);
		ResultSet rs=stmt.executeQuery(str);
		excel=objcommon.convertToEXCEL(rs);
		stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return excel;
	}
}
