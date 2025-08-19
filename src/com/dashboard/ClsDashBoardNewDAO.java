package com.dashboard;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.connection.*;

public class ClsDashBoardNewDAO {

ClsConnection objconn= new ClsConnection();
	public JSONObject getFleetSalesChartData() throws SQLException{
		Connection conn=null;
		JSONObject data=new JSONObject();
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			int purchaseacno=0;
			String strgetrequire="select (select CURDATE()) todate,(select date_sub(CURDATE(),interval 12 month)) fromdate,(select head.doc_no from my_head head left join my_account ac on (head.doc_no=ac.acno) where ac.codeno='VEH') purchaseacno";
			ResultSet rsgetrequire=stmt.executeQuery(strgetrequire);
			while(rsgetrequire.next()){
				sqlfromdate=rsgetrequire.getDate("fromdate");
				sqltodate=rsgetrequire.getDate("todate");
				purchaseacno=rsgetrequire.getInt("purchaseacno");
			}
			ArrayList<String> monthsarray=new ArrayList<>();
			ArrayList<String> monthsvaluesarray=new ArrayList<>();
			ArrayList<String> fleetsalesmonthcount = new ArrayList<>();
			ArrayList<String> fleetpurchasemonthcount = new ArrayList<>();
			for(int monthindex=0;monthindex<12;monthindex++){
				String strgetmonthdate="select date_format(date_add('"+sqlfromdate+"',interval "+monthindex+" month),'%b %Y') displaydate,"+
				" date_add('"+sqlfromdate+"',interval "+monthindex+" month) basedate,"+
				" month(date_add('"+sqlfromdate+"',interval "+monthindex+" month)) basemonth,"+
				" year(date_add('"+sqlfromdate+"',interval "+monthindex+" month)) baseyear";
				//System.out.println(strgetmonthdate);
				int basemonth=0,baseyear=0;
				ResultSet rsgetmonthdate=stmt.executeQuery(strgetmonthdate);
				java.sql.Date sqlbasedate=null;
				while(rsgetmonthdate.next()){
					sqlbasedate=rsgetmonthdate.getDate("basedate");
					monthsarray.add(rsgetmonthdate.getString("displaydate"));
					monthsvaluesarray.add(rsgetmonthdate.getDate("basedate").toString());
					basemonth=rsgetmonthdate.getInt("basemonth");
					baseyear=rsgetmonthdate.getInt("baseyear");
				}
				
				String strgetfleetpurchasecount="select date,coalesce(count(*),0) vehcount from gc_assettran where acno="+purchaseacno+" and dramount>0 and "+
				" month(date)="+basemonth+" and year(date)="+baseyear+" group by year(date),month(date) order by date";
				//System.out.println(strgetfleetpurchasecount);
				int purchasecount=0;
				ResultSet rsgetfleetpurchasecount=stmt.executeQuery(strgetfleetpurchasecount);
				while(rsgetfleetpurchasecount.next()){
					purchasecount=rsgetfleetpurchasecount.getInt("vehcount");
				}
				
				fleetpurchasemonthcount.add(purchasecount+""); 
				int salescount=0;
				String strgetfleetsalescount="select m.date,count(*) vehcount from gl_vsalem m left join gl_vsaled d on m.doc_no=d.rdocno where month(m.date)="+basemonth+" and year(m.date)="+baseyear+" group by year(m.date),month(m.date) order by m.date";
				//System.out.println(strgetfleetsalescount);
				ResultSet rsgetfleetsalescount=stmt.executeQuery(strgetfleetsalescount);
				while(rsgetfleetsalescount.next()){
					salescount=rsgetfleetsalescount.getInt("vehcount");
				}
				fleetsalesmonthcount.add(salescount+"");
			}
			JSONArray livefleetarray=new JSONArray();
			/*String strgetlivefleets="select brd.brand_name brandname,count(*) vehcount from gl_vehmaster veh left join gl_vehbrand brd on "+
			"veh.brdid=brd.doc_no where statu=3 and fstatus='L' and tran_code<>'FS' group by veh.brdid";
*/			
			String strgetlivefleets="select brd.brand_name brandname,model.vtype modelname,grp.gname groupname,yom.yom from gl_vehmaster veh left join gl_vehbrand brd on"+
			" veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left"+
			" join gl_yom yom on veh.yom=yom.doc_no where statu=3 and fstatus='L' and tran_code<>'FS'";
			ResultSet rsgetlivefleets=stmt.executeQuery(strgetlivefleets);
			while(rsgetlivefleets.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("brandname",rsgetlivefleets.getString("brandname"));
				objtemp.put("modelname",rsgetlivefleets.getString("modelname"));
				objtemp.put("groupname",rsgetlivefleets.getString("groupname"));
				objtemp.put("yom",rsgetlivefleets.getString("yom"));
				livefleetarray.add(objtemp);
				/*livefleetarray.add(rsgetlivefleets.getString("brandname")+"::"+rsgetlivefleets.getInt("vehcount"));*/
			}
			data.put("labelsvalues", monthsvaluesarray);
			data.put("labels", monthsarray);
			data.put("purchasemonthcount", fleetpurchasemonthcount);
			data.put("salesmonthcount", fleetsalesmonthcount);
			data.put("livefleets", livefleetarray);
			data.put("fleetstatustitle", "Fleet Induction and Sales "+monthsarray.get(0)+" - "+monthsarray.get(monthsarray.size()-1));
			//System.out.println(data);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	
	public JSONObject getBrandwiseFleetSales(String basedate) throws SQLException{
		Connection conn=null;
		JSONObject data=new JSONObject();
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			int purchaseacno=0;
			String strgetrequire="select head.doc_no purchaseacno from my_head head left join my_account ac on (head.doc_no=ac.acno) where ac.codeno='VEH'";
			ResultSet rsgetrequire=stmt.executeQuery(strgetrequire);
			while(rsgetrequire.next()){
				purchaseacno=rsgetrequire.getInt("purchaseacno");
			}
			String strbrandwise="select aa.brand_name,sum(aa.inductioncount) inductioncount,sum(aa.salescount) salescount from ("+
			" select brd.doc_no,brd.brand_name,coalesce(count(*),0) inductioncount,0 salescount from gc_assettran asset left join gl_vehmaster veh "+
			" on asset.fleet_no=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no where asset.acno="+purchaseacno+" and "+
			" asset.dramount>0 and month(asset.date)=month('"+basedate+"') and year(asset.date)=year('"+basedate+"') group by brd.doc_no union all"+
			" select brd.doc_no,brd.brand_name,0 inductioncount,coalesce(count(*),0) salescount from gl_vsalem m left join gl_vsaled d on "+
			" m.doc_no=d.rdocno left join gl_vehmaster veh on d.fleetno=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no where "+
			" month(m.date)=month('"+basedate+"') and year(m.date)=year('"+basedate+"')  group by brd.doc_no) aa group by aa.doc_no";			
			System.out.println(strbrandwise);
			ResultSet rs=stmt.executeQuery(strbrandwise);
			int srno=1;
			ArrayList<String> brandwisearray=new ArrayList<>();
			while(rs.next()){
				brandwisearray.add(srno+"::"+rs.getString("brand_name")+"::"+rs.getString("inductioncount")+"::"+rs.getString("salescount"));
				srno++;
			}
			
			data.put("brandwisedata", brandwisearray);
			System.out.println("Brandwise Date:"+data);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONObject getModelwiseFleetSales(String basedate) throws SQLException{
		Connection conn=null;
		JSONObject data=new JSONObject();
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			int purchaseacno=0;
			String strgetrequire="select head.doc_no purchaseacno from my_head head left join my_account ac on (head.doc_no=ac.acno) where ac.codeno='VEH'";
			ResultSet rsgetrequire=stmt.executeQuery(strgetrequire);
			while(rsgetrequire.next()){
				purchaseacno=rsgetrequire.getInt("purchaseacno");
			}
			String strbrandwise="select concat(aa.brand_name,' ',aa.vtype) modelname,sum(aa.inductioncount) inductioncount,sum(aa.salescount) salescount from ("+
			" select model.doc_no,model.vtype,brd.brand_name,coalesce(count(*),0) inductioncount,0 salescount from gc_assettran asset left join gl_vehmaster"+
			" veh on asset.fleet_no=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no"+
			" where asset.acno="+purchaseacno+" and asset.dramount>0 and month(asset.date)=month('"+basedate+"') and year(asset.date)=year('"+basedate+"') group by model.doc_no union all"+
			" select model.doc_no,model.vtype,brd.brand_name,0 inductioncount,coalesce(count(*),0) salescount  from gl_vsalem m left join gl_vsaled d on"+
			" m.doc_no=d.rdocno left join gl_vehmaster veh on d.fleetno=veh.fleet_no"+
			" left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no where month(m.date)=month('"+basedate+"')"+
			" and year(m.date)=year('"+basedate+"')  group by model.doc_no) aa group by aa.doc_no";			
			//System.out.println(strbrandwise);
			ResultSet rs=stmt.executeQuery(strbrandwise);
			int srno=1;
			ArrayList<String> modelwisearray=new ArrayList<>();
			while(rs.next()){
				modelwisearray.add(srno+"::"+rs.getString("modelname")+"::"+rs.getString("inductioncount")+"::"+rs.getString("salescount"));
				srno++;
			}
			
			data.put("modelwisedata", modelwisearray);
			//System.out.println("Modelwise Date:"+data);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	
	public JSONObject getFleetDistChartData()throws SQLException{
		Connection conn=null;
		JSONObject data=new JSONObject();
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			ArrayList<String> strcolor=new ArrayList<>();
			strcolor.add("rgb(252, 92, 82)");
			strcolor.add("rgb(242, 139, 70)");
			strcolor.add("rgb(255, 158, 1)");
			strcolor.add("rgb(252, 210, 2)");
			strcolor.add("rgb(248, 255, 1)");
			strcolor.add("rgb(176, 222, 9)");
			strcolor.add("rgb(4, 210, 21)");
			strcolor.add("rgb(13, 142, 207)");
			strcolor.add("rgb(148, 178, 234)");
			strcolor.add("rgb(222, 75, 237)");
			strcolor.add("rgb(216, 128, 195)");
			strcolor.add("rgb(222, 22, 113)");
			strcolor.add("rgb(244, 72, 111)");
			strcolor.add("rgb(221, 221, 221)");
			strcolor.add("rgb(153, 153, 153)");
			strcolor.add("rgb(51, 51, 51)");
			/*String strsql="select * from (select ST.ST_DESC,convert(count(*),char(10)) VALUE,VEH.tran_code from gl_vehmaster VEH  LEFT JOIN GL_STATUS ST ON (VEH.tran_code=ST.STATUS) where VEH.statu=3 and VEH.fstatus<>'Z'  and VEH.tran_code not in ('la','ra') GROUP BY VEH.tran_code) aa  union all  select  ST.ST_DESC,count(*),veh.tran_code from gl_vehmaster veh  inner JOIN GL_STATUS ST ON (VEH.tran_code=ST.STATUS) inner join (select max(doc_no) doc,fleet_no from gl_vmove group by fleet_no) v on v.fleet_no=veh.fleet_no inner join gl_vmove vm on vm.doc_no=v.doc left join gl_ragmt ra on ra.doc_no=vm.rdocno and vm.rdtype='rag'   left join gl_lagmt la on la.doc_no=vm.rdocno and vm.rdtype='lag'   where  VEH.statu=3 and VEH.fstatus<>'Z'  and VEH.tran_code  in ('la','ra') group by veh.tran_code";*/
			String strsql="select st.st_desc trancode,brd.brand_name brandname,model.vtype modelname,grp.gname groupname,yom.yom from gl_vehmaster "+
			" VEH  LEFT JOIN GL_STATUS ST ON (VEH.tran_code=ST.STATUS) left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel "+
			" model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no "+
			" where VEH.statu=3 and VEH.fstatus<>'Z'";
			ResultSet rs=stmt.executeQuery(strsql);
			ArrayList<String> valuearray=new ArrayList<>();
			ArrayList<String> namearray=new ArrayList<>();
			ArrayList<String> colorarray=new ArrayList<>();
			JSONArray fleetdistarray=new JSONArray();
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("trancode",rs.getString("trancode"));
				objtemp.put("brandname",rs.getString("brandname"));
				objtemp.put("modelname",rs.getString("modelname"));
				objtemp.put("groupname",rs.getString("groupname"));
				objtemp.put("yom",rs.getString("yom"));
				fleetdistarray.add(objtemp);
			}
			for(int i=0;i<valuearray.size();i++){
				colorarray.add(strcolor.get(i));
			}
			data.put("fleetdistdata",fleetdistarray);
			/*data.put("values", valuearray);
			data.put("names", namearray);
			data.put("colors",colorarray);*/
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getFleetUtilizeData(Connection conn,String groupby,java.sql.Date sqlfromdate,java.sql.Date sqltodate){
		JSONArray dataarray=new JSONArray();
		try{
			String sqlgroup="",sqlselect="";
			if(groupby.equalsIgnoreCase("brand") || groupby.equalsIgnoreCase("")){
				sqlgroup=" group by f.brdid";
				sqlselect=" brd.doc_no refno,brd.brand_name description";
			 }
			else if(groupby.equalsIgnoreCase("model")){
				sqlgroup=" group by f.vmodid";
				sqlselect=" model.doc_no refno,model.vtype description";
			}
			else if(groupby.equalsIgnoreCase("group")){
				sqlgroup=" group by f.vgrpid";
				sqlselect=" grp.doc_no refno,grp.gname description";
			}
			else if(groupby.equalsIgnoreCase("yom")){
				sqlgroup=" group by f.yomid";
				sqlselect=" yom.doc_no refno,yom.yom description";
			}
			Statement stmt=conn.createStatement();
			String strSql="select brdid, vmodid, vgrpid, yomid, tran_code, trancode, round((rental/60)/24,2) rental, round((transfer/60)/24,2)+round((staff/60)/24,2) staff, round((readytorent/60)/24,2) readytorent, round((unrentable/60)/24,2) unrentable, round((garage/60)/24,2) garage, round(((total+1)/60)/24,2) total, refno, description, purdate, saledate, color,round((forsale/60)/24,2) forsale,round((round(total+1,2)-round(rental,2)-round(delivery,2)-round(staff,2)-round(transfer,2)-round(forsale,2)-round(garage,2))/60,2)+round((delivery/60)/24,2) as other from (select veh.fleet_no,veh.brdid,veh.vmodid,veh.vgrpid, veh.yom yomid,veh.tran_code,trancode,coalesce(sum(rental),0) rental,coalesce(sum(delivery),0) delivery,coalesce(sum(staff),0) staff,coalesce(sum(transfer),0) transfer,coalesce(sum(readytorent),0) readytorent ,coalesce(sum(unrentable),0) unrentable,coalesce(sum(garage),0) garage,timestampdiff(minute,'"+sqlfromdate+" 00:00','"+sqltodate+" 23:59') as  total, "+sqlselect+", veh.prch_dte purdate,salem.date saledate,clr.color, coalesce(( select if(trancode='FS' and veh.tran_code='FS' and salem.date>'"+sqltodate+"',timestampdiff(minute,(cast(concat(dout,' ',tout)  as datetime)), (cast(concat(if(salem.date>'"+sqltodate+"',salem.date,'"+sqltodate+"'),' ','23:59')as datetime))) , if(trancode='FS' and veh.tran_code='FS' and salem.date<'"+sqlfromdate+"',timestampdiff(minute,'"+sqlfromdate+"','"+sqltodate+"'),forsale)) from  gl_vmove mov where doc_no=(select max(doc_no) from gl_vmove where trancode='FS' and fleet_no=veh.fleet_no)),0) forsale from ( select (cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime)),fleet_no,trancode,if(trancode in ('RM','RW','RD','LA','CU','RA'), timestampdiff(minute,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) rental, if(trancode in ('GA','GM','GS'),timestampdiff(minute,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as datetime))),0) garage,if(trancode in ('DL'), timestampdiff(minute,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate, ' ',intime)as datetime))),0) delivery, if(trancode in ('TR'),timestampdiff(minute,(cast(concat(outdate, ' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) transfer,if(trancode in ('ST'),timestampdiff(minute, (cast(concat(outdate,' ',outtime) as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) staff,if(trancode in ('RR'), timestampdiff(minute,(cast(concat(outdate, ' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) readytorent, if(trancode in ('UR'),timestampdiff(minute, (cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))) ,0) unrentable,if(trancode in ('FS'), timestampdiff(minute,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) forsale from ("+
					" select dout outdate,tout outtime,din indate,tin intime,v.* from gl_vmove v where ((dout between '"+sqlfromdate+"' and '"+sqltodate+"') and (din between '"+sqlfromdate+"' and '"+sqltodate+"') ) union all select '"+sqlfromdate+"' outdate,'00:00' outtime,'"+sqltodate+"' indate,'23:59' intime,v.* from gl_vmove v where ((dout<'"+sqlfromdate+"') and (din>'"+sqltodate+"') ) union all select '"+sqlfromdate+"' outdate,'00:00' outtime,din indate,tin intime,v.* from gl_vmove v where ((dout<'"+sqlfromdate+"') and (din between '"+sqlfromdate+"' and '"+sqltodate+"') ) union all select dout outdate,tout outtime,'"+sqltodate+"' indate,'23:59' intime,v.* from gl_vmove v where ((dout between '"+sqlfromdate+"'  and '"+sqltodate+"') and (din>'"+sqltodate+"')) union all"+
					" select if(dout<'"+sqlfromdate+"','"+sqlfromdate+"',dout) outdate,if(dout<'"+sqlfromdate+"','00:00',tout) outtime,'"+sqltodate+"' indate,'23:59' intime,v.* from"+
					" gl_vmove v where status='OUT' and dout<'"+sqltodate+"' )a ) main left join gl_vehmaster veh on main.fleet_no=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no  left join my_color clr on veh.clrid=clr.doc_no left join gl_yom yom on veh.yom=yom.doc_no left join gl_vsaled saled on main.fleet_no=saled.fleetno left join gl_vsalem salem on saled.rdocno=salem.doc_no group by main.fleet_no) as f where 1=1 "+sqlgroup;
			System.out.println(strSql);
			ResultSet rs=stmt.executeQuery(strSql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("refno",rs.getString("refno"));
				objtemp.put("description",rs.getString("description"));
				objtemp.put("rental",rs.getString("rental"));
				objtemp.put("garage",rs.getString("garage"));
				objtemp.put("staff",rs.getString("staff"));
				objtemp.put("forsale",rs.getString("forsale"));
				objtemp.put("unrentable",rs.getString("unrentable"));
				objtemp.put("other",rs.getString("other"));
				dataarray.add(objtemp);
			}
			System.out.println("Array:"+dataarray);
			return dataarray;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return dataarray;
	}
	
}
