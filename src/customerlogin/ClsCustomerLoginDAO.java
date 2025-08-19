package customerlogin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.trafficfine.ClsTrafficfineDAO;
import com.login.ClsLogin;

public class ClsCustomerLoginDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsLogin objlogin=new ClsLogin();
	
	public JSONArray invoicedGridLoading(String branch,String fromDate, String toDate, String cldocno, String rentalType, String agmtNo,String acno) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(acno.equalsIgnoreCase("")){
			return RESULTDATA;
		}
		System.out.println("Inside Invoiced");
		Connection conn = null;
        
		  try {
			    conn = objconn.getMyConnection();
			    Statement stmtTraffic = conn.createStatement();
			    
			    java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = objcommon.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = objcommon.changeStringtoSqlDate(toDate);
		        }
		        
			    String sql = "";
			    String sql1 = "";
			    
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			     }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			     }
		        
		        if(!(cldocno.equalsIgnoreCase("")) && !cldocno.equalsIgnoreCase("0")){
		        	sql+=" and ac.cldocno='"+cldocno+"'";
		        }
		        if(!(acno.equalsIgnoreCase("")) && !acno.equalsIgnoreCase("0")){
		        	sql+=" and ac.acno='"+acno+"'";
		        }
		        
		        if(!(rentalType.equalsIgnoreCase(""))){
		        	if(rentalType.equalsIgnoreCase("RAG")){
		        		sql+=" and s.rtype IN ('RM','RA', 'RD','RW','RF')";
		        	}
		        	else if(rentalType.equalsIgnoreCase("LAG")){
		        		sql+=" and s.rtype IN ('LA', 'LC')";
		        	}
		         }
		        
		        if(!(agmtNo.equalsIgnoreCase(""))){
		        	sql+=" and s.ra_no='"+agmtNo+"'";
		           }
		        double govfees=0.0;
				int feesmethod=0;
				String strgetfees="select method,value from gl_config where field_nme='govTrafficFees'";
				
				ResultSet rsgetfees=stmtTraffic.executeQuery(strgetfees);
				while(rsgetfees.next()){
					feesmethod=rsgetfees.getInt("method");
					govfees=rsgetfees.getDouble("value");
				}
				// double govfees=getGovFees(conn);
				ClsTrafficfineDAO trafficdao=new ClsTrafficfineDAO();
				int govfeesparking=trafficdao.getGovFeesParking(conn);
		        String strgovfeesparking="";
		        if(govfeesparking>0){
		        	strgovfeesparking=" or trim(fine_source) like '%RTA (Parking Fines)%' or trim(fine_source)) like '%RTA PARKING FINE%'  or trim(fine_source) like '%ROADS & TRANSPORT AUTHORITY%'  or trim(fine_source) like '%ROADS & TRASNPORT AUTHORITY%' ";
		        }
				sql1 = "select s.regNo,s.Ticket_No,s.TRAFFIC_DATE,s.Location,s.Desc1,s.fine,CONCAT(s.rtype,' - ',case when s.RTYPE in ('LA','LC') then l.voc_no else r.voc_no end) \r\n" + 
						"rano,m.voc_no invno,convert(coalesce(if((s.fine_source like  '%DUBAI%' "+strgovfeesparking+" ) and ("+feesmethod+"=1 or ("+feesmethod+"=2 and del_charges=1 )),s.amount+"+govfees+",s.amount),''),char(25)) amount \r\n" + 
						"from gl_traffic s left join gl_ragmt r on s.ra_no=r.doc_no and ((s.rtype='RM')or(s.rtype='RA')or(s.rtype='RD')or(s.rtype='RW')or(s.rtype='RF'))\r\n" + 
						"left join gl_lagmt l on s.ra_no=l.doc_no and ((s.rtype='LA')or(s.rtype='LC'))\r\n" + 
						"  left join gl_status st on s.rtype=st.Status\r\n" + 
						"left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type\r\n" + 
						"left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type\r\n" + 
						"left join gl_invm m on s.inv_no=m.doc_no and s.inv_type='INV'\r\n" + 
						"\r\n" + 
						"left join my_jvtran j on s.inv_no=j.doc_no and s.inv_type='JVT'\r\n" + 
						"where s.inv_no>0 and s.isallocated=1"+sql+" and s.ra_no<>0 and emp_type='CRM'";
				//System.out.println("=====invqoicegriddfgs======="+sql1);
				ResultSet resultSet = stmtTraffic.executeQuery(sql1);
			                
			    RESULTDATA=objcommon.convertToJSON(resultSet);
			    
			    stmtTraffic.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	public JSONObject getFleetSalesChartData(String acno) throws SQLException{
		Connection conn=null;
		JSONObject data=new JSONObject();
		if(acno.equalsIgnoreCase("")){
			return data;
		}
		//System.out.println("Inside FleetSalesChart");
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			int purchaseacno=0;
			String strgetrequire="select (select curdate()) todate,(select date_sub(curdate(),interval 12 month)) fromdate,(select head.doc_no from my_head head left join my_account ac on (head.doc_no=ac.acno) where ac.codeno='VEH') purchaseacno";
			ResultSet rsgetrequire=stmt.executeQuery(strgetrequire);
			while(rsgetrequire.next()){
				sqlfromdate=rsgetrequire.getDate("fromdate");
				sqltodate=rsgetrequire.getDate("todate");
				purchaseacno=rsgetrequire.getInt("purchaseacno");
			}
			/*ArrayList<String> monthsarray=new ArrayList<>();
			ArrayList<String> monthsvaluesarray=new ArrayList<>();
			ArrayList<String> fleetsalesmonthcount = new ArrayList<>();
			ArrayList<String> fleetpurchasemonthcount = new ArrayList<>();
			for(int monthindex=0;monthindex<12;monthindex++){
				String strgetmonthdate="select date_format(date_add('"+sqlfromdate+"',interval "+monthindex+" month),'%b %Y') displaydate, date_add('"+sqlfromdate+"',interval "+monthindex+" month) basedate, month(date_add('"+sqlfromdate+"',interval "+monthindex+" month)) basemonth, year(date_add('"+sqlfromdate+"',interval "+monthindex+" month)) baseyear";
				////System.out.println(strgetmonthdate);
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
				
				String strgetfleetpurchasecount="select min(date) date,coalesce(count(*),0) vehcount from gc_assettran where acno="+purchaseacno+" and dramount>0 and "+
				" month(date)="+basemonth+" and year(date)="+baseyear+" group by year(date),month(date) order by min(date)";
				////System.out.println(strgetfleetpurchasecount);
				int purchasecount=0;
				ResultSet rsgetfleetpurchasecount=stmt.executeQuery(strgetfleetpurchasecount);
				while(rsgetfleetpurchasecount.next()){
					purchasecount=rsgetfleetpurchasecount.getInt("vehcount");
				}
				
				fleetpurchasemonthcount.add(purchasecount+""); 
				int salescount=0;
				String strgetfleetsalescount="select min(m.date) date,count(*) vehcount from gl_vsalem m left join gl_vsaled d on m.doc_no=d.rdocno where month(m.date)="+basemonth+" and year(m.date)="+baseyear+" group by year(m.date),month(m.date) order by min(m.date)";
				//System.out.println(strgetfleetsalescount);
				ResultSet rsgetfleetsalescount=stmt.executeQuery(strgetfleetsalescount);
				while(rsgetfleetsalescount.next()){
					salescount=rsgetfleetsalescount.getInt("vehcount");
				}
				fleetsalesmonthcount.add(salescount+"");
			}*/
			JSONArray livefleetarray=new JSONArray();
			/*String strgetlivefleets="select brd.brand_name brandname,count(*) vehcount from gl_vehmaster veh left join gl_vehbrand brd on "+
			"veh.brdid=brd.doc_no where statu=3 and fstatus='L' and tran_code<>'FS' group by veh.brdid";
*/			
			/*
			 * String
			 * strgetlivefleets="select brd.brand_name brandname,model.vtype modelname,grp.gname groupname,yom.yom from gl_vehmaster veh left join gl_vehbrand brd on"
			 * +
			 * " veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left"
			 * +
			 * " join gl_yom yom on veh.yom=yom.doc_no where statu=3 and fstatus='L' and tran_code<>'FS'"
			 * ;
			 */
			String strgetlivefleets="select base.* from (\r\n" + 
					" select agmt.cldocno,brd.brand_name brandname,model.vtype modelname,grp.gname groupname,yom.yom from gl_ragmt agmt \r\n" + 
					" left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no \r\n" + 
					" left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no \r\n" + 
					" left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no where \r\n" + 
					" statu=3 and agmt.clstatus=0 and agmt.status=3  and fstatus='L' and tran_code<>'FS' union all\r\n" + 
					" select agmt.cldocno,brd.brand_name brandname,model.vtype modelname,grp.gname groupname,yom.yom from gl_lagmt agmt \r\n" + 
					" left join gl_vehmaster veh on (case when agmt.tmpfleet=0 then agmt.perfleet else agmt.tmpfleet end =veh.fleet_no )\r\n" + 
					" left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no \r\n" + 
					" left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no where \r\n" + 
					" statu=3 and agmt.clstatus=0 and agmt.status=3 and fstatus='L' and tran_code<>'FS') base left join my_acbook ac on (ac.cldocno=base.cldocno and ac.dtype='CRM') \r\n" + 
					" where ac.acno="+acno;
			//System.out.println(strgetlivefleets);
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
			/*data.put("labelsvalues", monthsvaluesarray);
			data.put("labels", monthsarray);
			data.put("purchasemonthcount", fleetpurchasemonthcount);
			data.put("salesmonthcount", fleetsalesmonthcount);*/
			data.put("livefleets", livefleetarray);
			//data.put("fleetstatustitle", "Fleet Induction and Sales "+monthsarray.get(0)+" - "+monthsarray.get(monthsarray.size()-1));
			////System.out.println(data);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONObject getFleetDistChartData(String acno)throws SQLException{
		Connection conn=null;
		JSONObject data=new JSONObject();
		if(acno.equalsIgnoreCase("")){
			return data; 
		}
		//System.out.println("Inside Fleet Dist");
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
			/*
			 * String
			 * strsql="select st.st_desc trancode,brd.brand_name brandname,model.vtype modelname,grp.gname groupname,yom.yom from gl_vehmaster "
			 * +
			 * " VEH  LEFT JOIN GL_STATUS ST ON (VEH.tran_code=ST.STATUS) left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel "
			 * +
			 * " model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no "
			 * + " where VEH.statu=3 and VEH.fstatus<>'Z'";
			 */
			String strsql="select base.* from (\r\n" + 
					" select agmt.cldocno,veh.fleet_no, st.st_desc trancode,brd.brand_name brandname,model.vtype modelname,grp.gname groupname,yom.yom from \r\n" + 
					" gl_ragmt agmt left join gl_vehmaster VEH on (agmt.fleet_no=veh.FLEET_NO) LEFT JOIN GL_STATUS ST ON (VEH.tran_code=ST.STATUS) left join gl_vehbrand brd on \r\n" + 
					" veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on \r\n" + 
					" veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no where agmt.status=3 and agmt.clstatus=0 and VEH.statu=3 and VEH.fstatus<>'Z' union all\r\n" + 
					" select agmt.cldocno,veh.fleet_no,st.st_desc trancode,brd.brand_name brandname,model.vtype modelname,grp.gname groupname,yom.yom from \r\n" + 
					" gl_lagmt agmt left join gl_vehmaster VEH on (case when agmt.tmpfleet=0 then agmt.perfleet else agmt.tmpfleet \r\n" + 
					" end =veh.FLEET_NO) LEFT JOIN GL_STATUS ST ON (VEH.tran_code=ST.STATUS) left join gl_vehbrand brd on \r\n" + 
					" veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on \r\n" + 
					" veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no where agmt.status=3 and agmt.clstatus=0 and VEH.statu=3 and VEH.fstatus<>'Z' ) base"+ 
					" left join my_acbook ac on base.cldocno=ac.cldocno and ac.dtype='CRM' where ac.acno="+acno;
			System.out.println("strsql="+strsql);
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
	public boolean clientLogin(String clientusername, String clientpassword,
			HttpSession session, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			int cldocno=0;
			String refname="";
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String str="select * from my_acbook where clientusername='"+clientusername+"' and clientpassword='"+clientpassword+"' and status=3 and dtype='CRM'";
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				cldocno=rs.getInt("cldocno");
				refname=rs.getString("refname");
			}
			
			String ip = objlogin.getRemortIP(request);
			String mac = objlogin.getMACAddress(ip);
			
			Map<String, String> env = System.getenv();
		    String xuser=env.get("USERNAME");
		    String xcomp=env.get("COMPUTERNAME");
			
		    if(cldocno>0){
		    	session.setAttribute("CLDOCNO", cldocno);
		    	session.setAttribute("BRANCHID","1");
		    	session.setAttribute("USERID","1");
		    	session.setAttribute("COMPANYID","1");
		    	session.setAttribute("USERNAME","ONLINEUSER");
				session.setAttribute("CLIENTNAME", refname);
				String strlog = "insert into gc_clientlog (cldocno,clientname,WIN_USER,win_cmp,WIN_MAC,DATE_IN) values ("+cldocno+",'"+refname+"','"+xuser+"','"+xcomp+"','"+mac+"',now())";
				int loginsert=stmt.executeUpdate(strlog);
				if(loginsert<=0){
					conn.close();
					return false;
				}
				else{
					conn.commit();
					return true;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}

	
	public JSONArray accountsStatement(String branch,String fromdate,String todate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        //System.out.println("Inside Account Statement");
		try {
				conn = objconn.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=objcommon.getFinanceVocTablesJoins(conn);
				casestatement=objcommon.getFinanceVocTablesCase(conn);
        		
			
				sql = "select b.*,coalesce(round(@i:=@i+nettotal,2),0) balance from ( select a.trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, a.currency, a.dramount, a.dr, a.cr, a.ldramount,"  
					    + "a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),2) nettotal,"+casestatement+"b.branchname from (select date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" and t.yrid=0 union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType "
						+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+" order by trdate,TRANSNO) b,(select @i:=0) as i";
					
				//System.out.println("Ac Stmt============"+sql);
				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtAccountStatement2.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountsStatementExcelExport(String branch,String fromdate,String todate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        //System.out.println("Inside Account Stmt Excel");
		try {
				conn = objconn.getMyConnection();
				Statement stmtAccountStatement1 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=objcommon.getFinanceVocTablesJoins(conn);
				casestatement=objcommon.getFinanceVocTablesCase(conn);
				
				sql = "select b.trdate 'Date',b.transtype 'Type',b.transno 'Doc No',b.branchname 'Branch',b.ref_detail 'Ref No',b.description 'Description',b.currency 'Currency',b.rate 'Rate',b.dr 'Debit',b.cr 'Credit',b.debit 'Base Debit',b.credit 'Base Credit',"
						+ "coalesce(round(@i:=@i+nettotal,2),0) 'Balance' from (select a.trdate,a.transtype,a.ref_detail,"+casestatement+"b.branchname,a.description,a.currency,a.rate,a.dr,a.cr,a.debit,a.credit,round((a.debit+(a.credit)*-1),2) nettotal from ("
						+ "select t.brhid,transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" and t.yrid=0 union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType "
						+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+"  group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+"  order by trdate,TRANSNO) b,(select @i:=0) as i";
				
				ResultSet resultSet = stmtAccountStatement1.executeQuery(sql);
				RESULTDATA=objcommon.convertToEXCEL(resultSet);
				
				//stmtAccountStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	

	public JSONArray directAccountsStatement(String branch,String fromdate,String todate,String accdocno,String check,String acctype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        //System.out.println("Inside Direct Accounnt Stmmt");
		try {
			
			
			conn = objconn.getMyConnection();
			Statement stmtAccountStatement2 = conn.createStatement();
			String sql = "";String joins="";String casestatement="";
			String condition1="";
			String sq1="";
			String db1="";
			String selct="";
    	    
                
			if(acctype.equalsIgnoreCase("AR")){
				condition1=" and io.clacno ="+accdocno;
				selct=" if(t.transtype='opn','',mh.account) account, if(t.transtype='opn','',mh.description) accountname";
				db1="CONVERT(if(amount>0,round((amount*1),2),''),CHAR(50)) debit, CONVERT(if(amount<0,round((amount*-1),2),''),CHAR(50)) credit ";
				
			}
			else if(acctype.equalsIgnoreCase("AP")){
				condition1="and io.vndacno ="+accdocno;
				selct=" if(t.transtype='opn','',h.account) account, if(t.transtype='opn','',h.description) accountname";
				db1="CONVERT(if(amount>0,round((amount*1),2),''),CHAR(50)) credit, CONVERT(if(amount<0,round((amount*-1),2),''),CHAR(50)) debit ";
			}
			
			
			
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=objcommon.getFinanceVocTablesJoins(conn);
				casestatement=objcommon.getFinanceVocTablesCase(conn);
				
				sql =   "select b.chqno,convert(b.chqdate,char(50)) chqdate,cast(b.transno as char) transno, trdate, transtype, docno, branchname, description, account, accountname, debit, credit, cntrno, grpno, alevel, brhid, nettotal,coalesce(round(@i:=@i+nettotal,2),0) balance from (select a.account,a.accountname,a.chqno,a.chqdate,a.trdate, "
						+ "a.transtype, a.transno docno,b.branchname, a.tr_des description,"
						+ "a.debit, a.credit,a.cntrno, a.grpno, a.alevel,"
						+ " a.brhid,round((a.debit+(a.credit)*-1),2) nettotal,CASE WHEN a.transtype in ('VSI') THEN "
						+ "vs.voc_no ELSE a.transno END AS 'transno' from (select t.chqno,t.chqdate,date(trdate) trdate,"
						+ "h.brhid,coalesce(transno,0) transno,t.transtype, t.tr_des, t.cntrno, amount, "
						+ " "+db1+","+selct+","
						+ "h.grpno,h.alevel,h.doc_no acno from my_head h inner join	"					
						+ "(select '' chqno,''chqdate,io.clacno,io.vndacno,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,'Opening Bal.' tr_des, "
						+ "1 srno,0 cntrno, sum(io.amount) amount,sum(io.outamount) outamount, 0 transNo,'OPN' transtype from in_opaccountd io "
						+ "where io.status=3 "+condition1+" and ((io.cndate >= '"+sqlFromDate+"' and io.dtype='OPN') or (io.cndate< '"+sqlFromDate+"')) union all "
						+ "select dir.chqno,dir.chqdate,io.clacno,io.vndacno,io.cndate trdate,io.remarks tr_des, 2 srno,io.cntrno,io.amount ,io.outamount,io.cno transNo,io.dtype transtype " 
						+ "from in_opaccountd io left join in_opdirpayment dir on (io.cno=dir.doc_no and io.dtype='DIPN') where io.status=3 "+condition1+" and cndate between '"+sqlFromDate+"' and  '"+sqlToDate+"' and io.dtype!='opn') t "
						+ " on h.doc_no=t.clacno left join my_head mh on t.vndacno=mh.doc_no left join my_curr c on c.doc_no=t.transno) a "
						+ " left join my_brch b on b.doc_no=a.brhid "
						+ "left join gl_vsalem vs on (a.transno=vs.doc_no and a.brhid=vs.brhid and "
						+ "a.transtype in ('VSI')) order by trdate,TRANSNO) b ,(select @i:=0) as i";
				
//				System.out.println("AccSatatement---876543-->"+sql);
				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtAccountStatement2.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray directaccountsStatementExcelExport(String branch,String fromdate,String todate,String accdocno,String check,String acctype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        System.out.println("Inside direct Account Excel");
		try {
				conn = objconn.getMyConnection();
				Statement stmtAccountStatement1 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				String condition1="";
				String sq1="";
				String db1="";
				String selct="";
				String selctdipn="left join in_opdirpayment dir on dir.doc_no=d.cno";
				
				if(acctype.equalsIgnoreCase("AR")){
					condition1=" and io.clacno ="+accdocno;
					selct=" if(t.transtype='opn','',mh.account) account, if(t.transtype='opn','',mh.description) accountname";
					db1="CONVERT(if(amount>0,round((amount*1),2),''),CHAR(50)) debit, CONVERT(if(amount<0,round((amount*-1),2),''),CHAR(50)) credit ";
					
				}
				else if(acctype.equalsIgnoreCase("AP")){
					condition1="and io.vndacno ="+accdocno;
					selct=" if(t.transtype='opn','',h.account) account, if(t.transtype='opn','',h.description) accountname";
					db1="CONVERT(if(amount>0,round((amount*1),2),''),CHAR(50)) credit, CONVERT(if(amount<0,round((amount*-1),2),''),CHAR(50)) debit ";
				}
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=objcommon.getFinanceVocTablesJoins(conn);
				casestatement=objcommon.getFinanceVocTablesCase(conn);
				
				sql = "select trdate date, transtype type, cast(b.transno as char) docno,b.chqno,convert(b.chqdate,char(50))chqdate,description,account,accountname, debit, credit "
						+ "from (select a.account,a.accountname,a.chqno,a.chqdate,a.trdate, a.transtype, a.transno docno,b.branchname, a.tr_des description,"
						+ "a.debit, a.credit,a.cntrno, a.grpno, a.alevel, a.brhid,round((a.debit+(a.credit)*-1),2) nettotal,CASE WHEN a.transtype in ('VSI') THEN "
						+ "vs.voc_no ELSE a.transno END AS 'transno' from (select t.chqno,t.chqdate,date(trdate) trdate,"
						+ "h.brhid,coalesce(transno,0) transno,t.transtype, t.tr_des, t.cntrno, amount, "
						+ " "+db1+","+selct+","
						+ "h.grpno,h.alevel,h.doc_no acno from my_head h inner join	"					
						+ "(select '' chqno,'' chqdate,io.clacno,io.vndacno,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,'Opening Bal.' tr_des, "
						+ "1 srno,0 cntrno, sum(io.amount) amount,sum(io.outamount) outamount, 0 transNo,'OPN' transtype from in_opaccountd io "
						+ "where io.status=3 "+condition1+" and ((io.cndate >= '"+sqlFromDate+"' and io.dtype='OPN') or (io.cndate< '"+sqlFromDate+"')) union all "
						+ "select dir.chqno,dir.chqdate,io.clacno,io.vndacno,io.cndate trdate,io.remarks tr_des, 2 srno,io.cntrno,io.amount ,io.outamount,io.cno transNo,io.dtype transtype " 
						+ "from in_opaccountd io left join in_opdirpayment dir on (io.cno=dir.doc_no and io.dtype='DIPN') where io.status=3 "+condition1+" and cndate between '"+sqlFromDate+"' and  '"+sqlToDate+"' and io.dtype!='opn') t "
						+ " on h.doc_no=t.clacno left join my_head mh on t.vndacno=mh.doc_no left join my_curr c on c.doc_no=t.transno) a "
						+ " left join my_brch b on b.doc_no=a.brhid "
						+ "left join gl_vsalem vs on (a.transno=vs.doc_no and a.brhid=vs.brhid and "
						+ "a.transtype in ('VSI')) order by trdate,TRANSNO) b ,(select @i:=0) as i";
				
//				System.out.println("EXCEL EXPORT----->"+sql);
				ResultSet resultSet = stmtAccountStatement1.executeQuery(sql);
				RESULTDATA=objcommon.convertToEXCEL(resultSet);
				
				//stmtAccountStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray getContractData(String cldocno,Connection conn){
		JSONArray contractarray=new JSONArray();
		System.out.println("Inside Contract Data");
		try{
			Statement stmt=conn.createStatement();
			int serial=1;
			/*String strmaster="select m.doc_no docno,m.voc_no vocno,date_format(m.date,'%d.%m.%Y') date,m.reftype,if(m.reftype='DIR',0,enq.voc_no) "+
			" refvocno,coalesce(contact.cperson,'') contactperson,coalesce(m.insurer,'') insured from in_contract m left join in_enqm enq on"+
			" (m.reftype='ENQ' and m.refno=enq.doc_no) left join my_crmcontact contact on (m.contactpid=contact.row_no and"+
			" m.cldocno=contact.cldocno) where m.status<>7 and m.cldocno="+cldocno+" order by m.doc_no desc";
			*/
			String strmaster="select * from ("+
			" select m.doc_no docno,m.voc_no vocno,date_format(m.date,'%d.%m.%Y') date,m.reftype,if(m.reftype='DIR',0,enq.voc_no)"+
			" refvocno,insurtype.name insurtype,d.policyno,date_format(d.enddt,'%d.%m.%Y') expirydate,concat(coalesce(motor.regno,''),' - ',coalesce(brd.brand_name,''),' ',"+
			" coalesce(model.vtype,'')) vehdetails from in_contract m left join in_enqm enq on"+
			" (m.reftype='ENQ' and m.refno=enq.doc_no) left join in_contractd d on (m.doc_no=d.rdocno) left join in_insurtype insurtype on"+
			" (d.instype=insurtype.doc_no) left join in_contractmotor motor on (m.doc_no=motor.rdocno) left join gl_vehbrand brd on"+
			" (motor.brandid=brd.doc_no) left join gl_vehmodel model on (motor.modelid=model.doc_no) where m.status<>7 and m.cldocno="+cldocno+" group by m.doc_no) aa"+
			" order by docno desc";
			ResultSet rsmaster=stmt.executeQuery(strmaster);
			
			while(rsmaster.next()){
				JSONObject objsub=new JSONObject();
				objsub.put("serial", serial);
				objsub.put("vocno", rsmaster.getString("vocno"));
				objsub.put("date", rsmaster.getString("date"));
				objsub.put("reftype", rsmaster.getString("reftype"));
				objsub.put("refvocno", rsmaster.getString("refvocno"));
				/*objsub.put("contactperson", rsmaster.getString("contactperson"));
				objsub.put("insured", rsmaster.getString("insured"));*/
				objsub.put("insurtype", rsmaster.getString("insurtype"));
				objsub.put("policyno", rsmaster.getString("policyno"));
				objsub.put("expirydate", rsmaster.getString("expirydate"));
				objsub.put("vehdetails", rsmaster.getString("vehdetails"));
				JSONArray attacharray=getContractAttachData(rsmaster.getInt("vocno"),"INS",conn);
				objsub.put("attachdata", attacharray);
				serial++;
				contractarray.add(objsub);
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return contractarray;
	}


	private JSONArray getContractAttachData(int refdocno, String reftype,Connection conn) {
		// TODO Auto-generated method stub
		JSONArray attacharray=new JSONArray();
		System.out.println("Inside Contract Attach Data");
		try{
			Statement stmt=conn.createStatement();
			
			/*String strattach="select sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.clientview=1 and a.doc_no="+refdocno+" and a.dtype='"+reftype+"' order by sr_no";
			//System.out.println(strattach);
			ResultSet rsattach=stmt.executeQuery(strattach);*/
			
			Statement cpstmt = conn.createStatement();
		       
		       int i=0;
		       String sqls="",sqltst="",docnoss="",dtypess="",sqltest="";  
		       String dtype="INS",docno="0";
		       String  cpsql="";
		       ResultSet rsattach=null;
		       /*String sqlsss="select * from gl_attachtypechk where dtype='"+dtype+"' and status=3";
		       ResultSet rs=cpstmt.executeQuery(sqlsss);
		       if(rs.next())
		       {
		    	   i=1;
		       }*/
		       String enddocno="",insdocno="",qotdocno="",enqdocno="",crmdocno="",ppcdocno="";
		     
		    	  
		    	   
		    	  /* if(i==0)
			       {
			    	   sqls= " and a.brhid='"+contractarray.get(j).split("::")[1]+"' " ;     
			       }*/
		    	   docno=refdocno+"";
		    	   ResultSet rs44=null;
			       sqltst="select en.brhid endbrch,qm.brhid qotbrhid,eq.brhid enqbrhid,cm.brhid cntbrhid,if(eq.clientid=2,pm.doc_no,eq.cldocno) cldocno,0 crgno,coalesce(eq.clientid,1) clientid,coalesce(eq.voc_no,0) enqno,coalesce(en.voc_no,0) endno,coalesce(cm.voc_no,0) insno,coalesce(qm.doc_no,0) qotno from in_contract cm left join in_enqm eq on cm.refno=eq.doc_no left join cm_prosclientm pm on (pm.tr_no=eq.cldocno and eq.clientid=2) left join in_srvqotm qm on qm.refdocno=eq.doc_no left join in_endorsement en on cm.doc_no=en.cntrno where 1=1 and cm.voc_no="+docno+"";
				//   System.out.println("sqltst--4->>>"+sqltst);  
				   rs44=cpstmt.executeQuery(sqltst); 
				    while(rs44.next()){    
			    			
				    	
				    	
				       docnoss+=rs44.getString("endno")+",";
		    		   if(!enddocno.contains(rs44.getString("endno"))){
		    			   if(!cpsql.equalsIgnoreCase("")){
				    		   cpsql=cpsql+" union all \n ";
				    	   }
		    			   cpsql=cpsql+" select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("endno")+") and a.dtype in ('END') and a.brhid="+rs44.getString("endbrch")+" and a.clientview=1 ";   
		    		   }
		    		   enddocno+=rs44.getString("endno")+",";
		    		   docnoss+=rs44.getString("insno")+",";
		    		   if(!insdocno.contains(rs44.getString("insno")+",")){
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("insno")+") and a.dtype in ('INS') and a.brhid="+rs44.getString("cntbrhid")+" and a.clientview=1 ";
					   }
		    		   insdocno+=rs44.getString("insno")+",";
				       //System.out.println("Ddddd"+docnoss);
				       
					   
		    		   docnoss+=rs44.getString("qotno")+",";
		    		   if(!qotdocno.contains(rs44.getString("qotno")+",")){
		    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("qotno")+") and a.dtype in ('SQOT') and a.brhid="+rs44.getString("qotbrhid")+"  and a.clientview=1 ";   
		    		   }
		    		   qotdocno+=rs44.getString("qotno")+",";
					   
		    		   docnoss+=rs44.getString("enqno")+",";
		    		   if(!enqdocno.contains(rs44.getString("enqno")+",")){
		    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("enqno")+") and a.dtype in ('ENQ') and a.brhid="+rs44.getString("enqbrhid")+"  and a.clientview=1 ";   
		    		   }
		    		   enqdocno+=rs44.getString("enqno")+",";
					   
	                if(rs44.getString("clientid").equalsIgnoreCase("1")){
		    			   dtypess+="'CRM'";
		    			   if(!crmdocno.contains(rs44.getString("clientid")+",")){
		    				   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('CRM')  and a.clientview=1  ";  
		    			   }
		    			   crmdocno+=rs44.getString("clientid")+",";
	                }else{
		    			   dtypess+="'PPC'";   
		    			   if(ppcdocno.contains(rs44.getString("clientid")+",")){
		    				   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('PPC')  and a.clientview=1  ";   
		    			   }
		    			   ppcdocno+=rs44.getString("clientid")+",";
		    		   }
					    dtypess+="'END'"+",";  
		    		   dtypess+="'INS'"+",";  
					   dtypess+="'SQOT'"+",";
		    		   dtypess+="'ENQ'"+",";
		    		   dtypess+="'CRM'"+",";
		    	     }
		       
		       
		       if(!(docnoss.equalsIgnoreCase("") || dtypess.equalsIgnoreCase(""))){  
		    	  // cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+docnoss+") and a.dtype in ("+dtypess+") "+sqls+" order by sr_no desc"; 
//		    	   System.out.println("cpsql--123->>>"+cpsql);
			       rsattach = cpstmt.executeQuery(cpsql);
		//	       data=objcommon.convertToJSON(resultSet);             
		       }
	    
			int serial=1;
			while(rsattach.next()){
				JSONObject objattach=new JSONObject();
				objattach.put("serial", serial);
				objattach.put("sr_no",rsattach.getString("sr_no"));
				objattach.put("extension", rsattach.getString("extension"));
				objattach.put("description", rsattach.getString("description"));
				objattach.put("filename", rsattach.getString("filename"));
				objattach.put("filepath", rsattach.getString("path"));
				objattach.put("type", rsattach.getString("type"));
				attacharray.add(objattach);
				serial++;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return attacharray;
	}
	
	
	public JSONObject getChartCountData(String cldocno,Connection conn){
		JSONObject data=new JSONObject();
		System.out.println("Inside Chart Count");
		try{
			java.sql.Date sqlfromdate=null,sqltodate=null;
			Statement stmt=conn.createStatement();
			String strgetrequire="select (select curdate()) todate,(select date_sub(curdate(),interval 12 month)) fromdate";
//			System.out.println(strgetrequire);
			ResultSet rsgetrequire=stmt.executeQuery(strgetrequire);
			while(rsgetrequire.next()){
				sqlfromdate=rsgetrequire.getDate("fromdate");
				sqltodate=rsgetrequire.getDate("todate");
			}
			ArrayList<String> monthsarray=new ArrayList<>();
			ArrayList<String> monthsvaluesarray=new ArrayList<>();
			ArrayList<String> chartragarray = new ArrayList<>();
			ArrayList<String> chartlagarray = new ArrayList<>();
			ArrayList<String> chartticketarray = new ArrayList<>();
			ArrayList<String> charttourvaluearray = new ArrayList<>();
			ArrayList<String> chartticketvaluearray = new ArrayList<>();
			ArrayList<String> charthotelvaluearray = new ArrayList<>();
			ArrayList<String> chartvisavaluearray = new ArrayList<>();
			ArrayList<String> chartothervaluearray = new ArrayList<>();
			for(int monthindex=0;monthindex<=12;monthindex++){
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
				
				String strchartcount="select coalesce((select count(*) from gl_ragmt m where m.cldocno="+cldocno+" and m.status=3 and "+
				" month(m.date)="+basemonth+" and year(m.date)="+baseyear+" group by year(m.date),month(m.date)),0) chartragcount,"+
				" coalesce((select count(*) from gl_lagmt m  where m.cldocno="+cldocno+" "+
				" and m.status=3 and month(m.date)="+basemonth+" and year(m.date)="+baseyear+" group by year(m.date),month(m.date)),0) chartlagcount";
				/*
				 * ","+
				 * " coalesce((select count(*) from ti_ticketvoucherm m left join ti_ticketvoucherd d on (m.doc_no=d.rdocno) where d.cldocno="
				 * +cldocno+" "+
				 * " and m.status=3 and month(d.bookdate)="+basemonth+" and year(d.bookdate)="
				 * +baseyear+" group by year(d.bookdate),month(d.bookdate) order by d.bookdate),0) chartticketcount,"
				 * +
				 * " coalesce((select round(sum(sr.total),2) from tr_invoicem inv left join tr_servicereqm ser on (ser.invtrno=inv.doc_no and inv.types='tour') left join tr_srtour sr on"
				 * +
				 * " (sr.rdocno=ser.doc_no) where inv.status=3 and inv.types='tour' and month(inv.date)="
				 * +basemonth+" and year(inv.date)="+baseyear+" group by"+
				 * " year(inv.date),month(inv.date) order by inv.date),0) charttourvalue,"+
				 * 
				 * " coalesce((select round(sum(tkt.sprice),2) from tr_invoicem inv left join ti_ticketvoucherd tkt on (tkt.invtrno=inv.doc_no and inv.types='ticket') where"
				 * + " inv.status=3 and inv.types='ticket' and month(inv.date)="
				 * +basemonth+" and year(inv.date)="+baseyear+" group by"+
				 * " year(inv.date),month(inv.date) order by inv.date),0) chartticketvalue,"+
				 * 
				 * " coalesce((select round(sum(hl.sprice),2) from tr_invoicem inv left join ti_hotelvoucherd hl on (hl.invtrno=inv.doc_no and inv.types='hotel') where"
				 * + " inv.status=3 and inv.types='hotel' and hl.vtype='H' and month(inv.date)="
				 * +basemonth+" and year(inv.date)="+baseyear+" group by"+
				 * " year(inv.date),month(inv.date) order by inv.date),0) charthotelvalue,"+
				 * 
				 * " coalesce((select round(sum(hl.sprice),2) from tr_invoicem inv left join ti_hotelvoucherd hl on (hl.invtrno=inv.doc_no and inv.types='hotel') where"
				 * + " inv.status=3 and inv.types='hotel' and hl.vtype='V' and month(inv.date)="
				 * +basemonth+" and year(inv.date)="+baseyear+" group by"+
				 * " year(inv.date),month(inv.date) order by inv.date),0) chartvisavalue,"+
				 * 
				 * " coalesce((select round(sum(hl.sprice),2) from tr_invoicem inv left join ti_hotelvoucherd hl on (hl.invtrno=inv.doc_no and inv.types='hotel') where"
				 * + " inv.status=3 and inv.types='hotel' and hl.vtype='O' and month(inv.date)="
				 * +basemonth+" and year(inv.date)="+baseyear+" group by"+
				 * " year(inv.date),month(inv.date) order by inv.date),0) chartothervalue";
				 */
				System.out.println(strchartcount);
				int chartragcount=0,chartlagcount=0,chartticketcount=0;
				double charttourvalue=0.0,chartticketvalue=0.0,charthotelvalue=0.0,chartvisavalue=0.0,chartothervalue=0.0;
				ResultSet rschartcount=stmt.executeQuery(strchartcount);
				while(rschartcount.next()){
					chartragcount=rschartcount.getInt("chartragcount");
					chartlagcount=rschartcount.getInt("chartlagcount");
					/*
					 * chartticketcount=rschartcount.getInt("chartticketcount");
					 * charttourvalue=rschartcount.getDouble("charttourvalue");
					 * chartticketvalue=rschartcount.getDouble("chartticketvalue");
					 * charthotelvalue=rschartcount.getDouble("charthotelvalue");
					 * chartvisavalue=rschartcount.getDouble("chartvisavalue");
					 * chartothervalue=rschartcount.getDouble("chartothervalue");
					 */				
				}
				chartragarray.add(chartragcount+"");
				chartlagarray.add(chartlagcount+"");
				/*
				 * chartticketarray.add(chartticketcount+"");
				 * charttourvaluearray.add(charttourvalue+"");
				 * chartticketvaluearray.add(chartticketvalue+"");
				 * charthotelvaluearray.add(charthotelvalue+"");
				 * chartvisavaluearray.add(chartvisavalue+"");
				 * chartothervaluearray.add(chartothervalue+"");
				 */
			}
			data.put("labelsvalues", monthsvaluesarray);
			data.put("labels", monthsarray);
			data.put("chartragcount", chartragarray);
			data.put("chartlagcount",chartlagarray);
			data.put("chartticketcount",chartticketarray);
			data.put("chartcounttitle", "Agreement Analytics of "+monthsarray.get(0)+" - "+monthsarray.get(monthsarray.size()-1));
			data.put("charttourvalue",charttourvaluearray);
			data.put("chartticketvalue",chartticketvaluearray);
			data.put("charthotelvalue",charthotelvaluearray);
			data.put("chartvisavalue",chartvisavaluearray);
			data.put("chartothervalue",chartothervaluearray);
			data.put("chartvaluetitle", "Invoice Analytics of "+monthsarray.get(0)+" - "+monthsarray.get(monthsarray.size()-1));
//			System.out.println(data);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	
	
	public JSONArray invoicelist(String fromdate,String todate,String acno,String id) throws SQLException {
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        System.out.println("Inside Invoice List");
        Connection conn=null;
        try{
        	java.sql.Date sqlfromdate = null,sqltodate = null;
        	String sqltest="";
        	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
        	{
        		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
        		sqltest+=" and m.date>='"+sqlfromdate+"'";
        	}
        	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
        	{
        		sqltodate=objcommon.changeStringtoSqlDate(todate);
        		sqltest+=" and m.date<='"+sqltodate+"'";
        	}
        	
        	if(!(acno.equalsIgnoreCase("")|| acno.equalsIgnoreCase("NA"))){
        		sqltest=sqltest+" and ac.acno='"+acno+"'";
        	}
        	conn = objconn.getMyConnection();
			Statement stmt= conn.createStatement ();
			
			String sql="select m.brhid,m.doc_no docno,br.branchname branch,m.voc_no vocno,m.date,case when m.reftype='SER' then 'Service Request' when "+
			" m.reftype='VOC' then 'Voucher' else '' end reftype,m.refno,m.types,m.remarks,round(jv.dramount,2) amount from tr_invoicem m left "+
			" join my_brch br on m.brhid=br.doc_no left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') inner join my_jvtran jv on "+
			" (jv.doc_no=m.doc_no and jv.dtype='TINV' and jv.acno=ac.acno and jv.status=3) where m.status=3"+sqltest;
			System.out.println(""+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
            data=objcommon.convertToJSON(resultSet);
            stmt.close();
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return data;
    }
	
	public JSONArray getTicketPivotData(String fromdate,String todate,String id,HttpSession session) throws SQLException{
		JSONArray data=new JSONArray();
		System.out.println("Inside Pivot");
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and tkt.bookdate>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and tkt.bookdate<='"+sqltodate+"'";
			}
			
			
			String strsql="select tkt.*,air.name from ti_ticketvoucherd tkt left join ti_airline air on tkt.airlineid=air.doc_no where 1=1"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray detailsgrid(String brnchval,String fromdate,String todate,String acno,String status,String fleet, 
    		String group,String brand,String model,String type,String outchk,String inchk,String catid,String id,String chkbetweendates) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(!id.trim().equalsIgnoreCase("1")) {
        	return RESULTDATA;
        }
        System.out.println("Inside Detail Grid");
        java.sql.Date sqlfromdate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=objcommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
      	
    	String rsqltest="" , sqltest="";
    	if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and r.clstatus='"+status+"'";
    		sqltest=sqltest+" and l.clstatus='"+status+"'";
    	}
    	if(!(acno.equalsIgnoreCase("") || acno.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and a.acno='"+acno+"'";
    		sqltest=sqltest+" and a.acno='"+acno+"'";
    	}
    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and r.fleet_no='"+fleet+"'";
    		sqltest=sqltest+" and if(l.perfleet=0,l.tmpfleet,l.perfleet)='"+fleet+"'";
    	}
    	if(!(group.equalsIgnoreCase("") || group.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and g.doc_no='"+group+"'";
    		sqltest=sqltest+" and g.doc_no='"+group+"'";
    	}
    	if(!(model.equalsIgnoreCase("") || model.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and mo.doc_no='"+model+"'";
    		sqltest=sqltest+" and mo.doc_no='"+model+"'";
    	}
    	if(!(brand.equalsIgnoreCase("")|| brand.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and br.doc_no='"+brand+"'";
    		sqltest=sqltest+" and br.doc_no='"+brand+"'";
    	}
    	if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and t.rentaltype='"+type+"' ";
    	}
    	if(!(catid.equalsIgnoreCase("") || catid.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and a.catid='"+catid+"' ";
			sqltest+=" and a.catid='"+catid+"' ";
    	}
    	
    	
    	
    	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
 			rsqltest+=" and r.brhid="+brnchval+"";
 			sqltest+=" and l.brhid='"+brnchval+"'";
 			
 		}
    	
    	
    	if(inchk.equalsIgnoreCase("IN"))
    	{
    		rsqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    		sqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    		
    	}
    	else
    	{
    		if(chkbetweendates.trim().equalsIgnoreCase("1")) {
    			rsqltest+="	and  r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
        		sqltest+="	and  l.outdate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    		}
    		else {
    			rsqltest+="	and  r.odate<='"+sqltodate+"' ";
        		sqltest+="	and  l.outdate<='"+sqltodate+"' ";
    		}
    		
    	}
    	
    	

    	
    	Connection conn =  null;
    	try {
				 conn =objconn.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 
			

            		
            		/*String sql ="(select r.rtaremarks,a.cldocno,r.date agmtdate,auth.authname authority,contractauth.authname contractauthority,plate.code_name platecode,contractplate.code_name contractplatecode,'Rent' as rltype,r.voc_no doc,r.fleet_no,v.FLNAME vehdetails,v.reg_no,r.ofleet_no ofno,v1.reg_no oreg_no,a.refname,a.contactperson,\r\n" + 
            				"cdr.name drname,a.per_mob,t.rentaltype,r.odate,r.otime,r.ddate,r.dtime,convert(coalesce(r.refno,''),char(30)) refnos,r.mrano mrno,convert(coalesce(cs.indate,''),char(30)) indate,\r\n" + 
            				"coalesce(cs.intime,'') intime,tc.rate rent,tc.cdw,tc.pai,\r\n" + 
            				"convert(if(r.invdate=r.odate,r.invdate,DATE_SUB(r.invdate,INTERVAL 1 DAY)),char(30)) AS invdate,\r\n" + 
            				"coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1 and rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1)),0) invRental,\r\n" + 
            				" coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17 and rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17)),0) invcdw\r\n" + 
            				" ,'' AS project,v1.eng_no originalfleet,v1.ch_no originalchase,'' replacefleet,'' replacechase,ur.user_name,clur.user_name closeuser,ms.sal_name,a.period2 crdp,mbr.branchname brch,ml.loc_name locname,if(r.invtype=1,'Month End','Period') invr,gy.yom, v.cur_km \r\n" + 
            				"from gl_ragmt r \r\n" + 
            				" left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM'\r\n" + 
            				"  left join gl_vehgroup g on g.doc_no=v.vgrpid    left join gl_vehmaster v1 on r.ofleet_no=v1.fleet_no\r\n" + 
            				"   left join  gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  left join  gl_rtarif tc on tc.rdocno=r.doc_no and tc.rstatus=7\r\n" + 
            				"    left join gl_vehbrand br   on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid\r\n" + 
            				" left join gl_vehauth auth on v.authid=auth.doc_no left join gl_vehplate plate on v.pltid=plate.doc_no"+
            				" left join gl_vehauth contractauth on v1.authid=contractauth.doc_no left join gl_vehplate contractplate on v1.pltid=contractplate.doc_no"+
            				"    left join     (select drid, rdocno from gl_rdriver where status=3 group by rdocno) dr  on dr.rdocno=r.doc_no    left join gl_drdetails cdr on cdr.dr_id=dr.drid\r\n" + 
            			" left join my_user ur on ur.doc_no=r.userid "+
            				"      left join gl_ragmtclosem cs on cs.agmtno=r.doc_no AND CS.STATUS=3"
            				+ " left join my_user clur on clur.doc_no=cs.userid "
            				+ " left join my_salm ms on ms.doc_no=r.salid "
            				
            				+ "left join my_brch mbr on mbr.doc_no=r.brhid left join my_locm ml on r.locid=ml.doc_no left join gl_yom gy on v.yom=gy.doc_no where r.status=3\r\n" + 
            				"        	"+rsqltest+" )\r\n" + 
            				"UNION\r\n" + 
            				"(select l.rtaremarks,a.cldocno,l.date agmtdate,auth.authname authority,contractauth.authname contractauthority,plate.code_name platecode,contractplate.code_name contractplatecode,'Lease' as rltype, l.voc_no doc, if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,v.FLNAME vehdetails,v.reg_no,l.perfleet ofno,orgveh.reg_no oreg_no,a.refname,a.contactperson,\r\n" + 
            				"d.name drname,a.per_mob,'Lease' rentaltype,l.outdate,l.outtime,l.duedate,l.outtime dtime,coalesce(l.refno,'') refnos,\r\n" + 
            				"coalesce(l.manualra,'') mrno,convert(coalesce(cs.indate,''),char(30)) indate,\r\n" + 
            				"coalesce(cs.intime,'') intime,tr.rate rent,tr.cdw,tr.pai,convert(if(l.invdate=l.outdate,l.invdate,DATE_SUB(l.invdate,INTERVAL 1 DAY)),char(30)) AS invdate,\r\n" + 
            				"coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1 and rowno=(select max(rowno)\r\n" + 
            				" from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1)),0) invRental,\r\n" + 
            				"  coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17 and rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17)),0) invcdw,\r\n" + 
            				" coalesce(prj.project_name,'') AS project ,repveh.eng_no originalfleet,coalesce(orgveh.ch_no,'') originalchase,\r\n" + 
            				"convert(coalesce(repveh.fleet_no,''),char(25)) replacefleet,coalesce(repveh.ch_no,'') replacechase,ur.user_name,clur.user_name closeuser,ms.sal_name, a.period2 crdp ,br1.branchname brch ,ml.loc_name locname,if(l.inv_type=1,'Month End','Period') invr,gy.yom, v.cur_km \r\n" + 
            				"from gl_lagmt l left join gl_project prj on l.projectno=prj.doc_no left join gl_vehmaster v on if(l.perfleet=0,l.tmpfleet,l.perfleet)=v.fleet_no\r\n" + 
            				"  left join gl_vehmaster orgveh on l.perfleet=orgveh.fleet_no left join gl_vehmaster repveh on l.tmpfleet=repveh.fleet_no\r\n" + 
            				"  left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid\r\n" + 
            				"   left join gl_vehbrand br on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid\r\n" + 
            				"   left join gl_ltarif tr on tr.rdocno=l.doc_no  left join(select drid, rdocno from gl_ldriver where status=3 group by rdocno) dr on dr.rdocno=l.doc_no\r\n" + 
            				" left join gl_vehauth auth on repveh.authid=auth.doc_no left join gl_vehplate plate on repveh.pltid=plate.doc_no"+
            				" left join gl_vehauth contractauth on orgveh.authid=contractauth.doc_no left join gl_vehplate contractplate on orgveh.pltid=contractplate.doc_no"+
            				"    left join  gl_drdetails d on (d.dr_id=dr.drid )"
            				+" left join my_user ur on ur.doc_no=l.userid "
            				+ " left join gl_lagmtclosem cs on cs.agmtno=l.doc_no\r\n" + 
            				 " left join my_user clur on clur.doc_no=cs.userid "+
            				"    left join my_salm ms on ms.doc_no=l.salid left join my_brch br1 on br1.doc_no=l.brhid  left join (select brhid,loc_name from my_locm group by brhid) ml on ml.brhid=br1.doc_no  left join gl_yom gy on orgveh.yom=gy.doc_no where l.status=3 "+sqltest+")";*/
            		
            		/*if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) AS duedate*/
            		String sqlchk ="(select (r.desc1) rtaremarks,(a.cldocno)cldocno,(r.date) agmtdate,(auth.authname) authority,(contractauth.authname) contractauthority,(plate.code_name) platecode,(contractplate.code_name) contractplatecode,'Rent' as rltype,(r.voc_no) doc,(r.fleet_no)fleet_no,(v.FLNAME) vehdetails,(v.reg_no)reg_no,(r.ofleet_no) ofno,(v1.reg_no) oreg_no,(a.refname)refname,(a.contactperson)contactperson,\r\n" + 
            				"(cdr.name) drname,(a.per_mob)per_mob,(t.rentaltype)rentaltype,(r.odate)odate,(r.otime)otime,(r.ddate)ddate,(r.dtime)dtime,coalesce((r.refno),'') refnos,(r.mrano) mrno,coalesce((cs.indate),'') indate,\r\n" + 
            				"coalesce((cs.intime),'') intime,(tc.rate) rent,(tc.cdw)cdw,(tc.pai)pai,\r\n" + 
            				"if((r.invdate)=(r.odate),(r.invdate),DATE_SUB((r.invdate),interval -1 DAY)) AS invdate,\r\n" + 
            				"coalesce((select (invoiced)invoiced from gl_rcalc where rdocno=(r.doc_no) and invno >0 and idno=1 and rowno=(select max(rowno) from gl_rcalc where rdocno=(r.doc_no) and invno >0 and idno=1)),0) invRental,\r\n" + 
            				" coalesce((select (invoiced)invoiced from gl_rcalc where rdocno=(r.doc_no) and invno >0 and idno=17 and rowno=(select max(rowno) from gl_rcalc where rdocno=(r.doc_no) and invno >0 and idno=17)),0) invcdw\r\n" + 
            				" ,'' AS project,(v1.eng_no) originalfleet,(v1.ch_no) originalchase,'' replacefleet,'' replacechase,(ur.user_name)user_name,(clur.user_name) closeuser,(ms.sal_name)sal_name,(a.period2) crdp,(mbr.brcode) branchcode,(mbr.branchname) brch,(ml.loc_name) locname,if((r.invtype)=1,'Month End','Period') invr,(gy.yom)yom, (v.cur_km)cur_km \r\n" + 
            				"from gl_ragmt r \r\n" + 
            				" left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM'\r\n" + 
            				"  left join gl_vehgroup g on g.doc_no=v.vgrpid    left join gl_vehmaster v1 on r.ofleet_no=v1.fleet_no\r\n" + 
            				"   left join  gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  left join  gl_rtarif tc on tc.rdocno=r.doc_no and tc.rstatus=7\r\n" + 
            				"    left join gl_vehbrand br   on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid\r\n" + 
            				" left join gl_vehauth auth on v.authid=auth.doc_no left join gl_vehplate plate on v.pltid=plate.doc_no left join gl_vehauth contractauth on v1.authid=contractauth.doc_no left join gl_vehplate contractplate on v1.pltid=contractplate.doc_no    left join     (select (drid)drid,(rdocno)rdocno from gl_rdriver where status=3 group by rdocno,drid) dr  on dr.rdocno=r.doc_no    left join gl_drdetails cdr on cdr.dr_id=dr.drid\r\n" + 
            				" left join my_user ur on ur.doc_no=r.userid       left join gl_ragmtclosem cs on cs.agmtno=r.doc_no AND CS.STATUS=3 left join my_user clur on clur.doc_no=cs.userid  left join my_salm ms on ms.doc_no=r.salid left join my_brch mbr on mbr.doc_no=r.brhid left join my_locm ml on r.locid=ml.doc_no left join gl_yom gy on v.yom=gy.doc_no where r.status=3\r\n" + 
            				"        		"+rsqltest+"  )\r\n" + 
            				"UNION\r\n" + 
            				"(select  (l.desc1) rtaremarks,(a.cldocno)clodcno,(l.date) agmtdate,(auth.authname) authority,(contractauth.authname) contractauthority,(plate.code_name) platecode,(contractplate.code_name) contractplatecode,'Lease' as rltype,(l.voc_no) doc, if((l.perfleet)=0,(l.tmpfleet),(l.perfleet)) fleet_no,(v.FLNAME) vehdetails,(v.reg_no)reg_no,(l.perfleet) ofno,(orgveh.reg_no) oreg_no,(a.refname)refname,(a.contactperson)contactperson,\r\n" + 
            				"(d.name) drname,(a.per_mob)per_mob,'Lease' rentaltype,(l.outdate)outdate,(l.outtime)outtime,(l.duedate)duedate,(l.outtime) dtime,coalesce((l.refno),'') refnos,\r\n" + 
            				"coalesce((l.manualra),'') mrno,coalesce((cs.indate),'') indate,\r\n" + 
            				"coalesce((cs.intime),'') intime,(tr.rate) rent,(tr.cdw)cdw,(tr.pai)pai,if((l.invdate)=(l.outdate),(l.invdate),DATE_SUB((l.invdate),interval 1 day)) AS invdate,\r\n" + 
            				"coalesce((select invoiced from gl_lcalc where rdocno=(l.doc_no) and invno >0 and idno=1 and rowno=(select max(rowno)\r\n" + 
            				" from gl_lcalc where rdocno=(l.doc_no) and invno >0 and idno=1)),0) invRental,\r\n" + 
            				"  coalesce((select invoiced from gl_lcalc where rdocno=(l.doc_no) and invno >0 and idno=17 and rowno=(select max(rowno) from gl_lcalc where rdocno=(l.doc_no) and invno >0 and idno=17)),0) invcdw,\r\n" + 
            				" coalesce((prj.project_name),'') AS project ,(repveh.eng_no) originalfleet,coalesce((orgveh.ch_no),'') originalchase,\r\n" + 
            				"coalesce((repveh.fleet_no),'') replacefleet,coalesce((repveh.ch_no),'') replacechase,(ur.user_name)user_name,(clur.user_name) closeuser,(ms.sal_name)sal_name,(a.period2) crdp ,(br1.brcode) branchcode,(br1.branchname) brch ,(ml.loc_name) locname,if((l.inv_type)=1,'Month End','Period') invr,(gy.yom)yom,(v.cur_km)cur_km \r\n" + 
            				"from gl_lagmt l left join gl_project prj on l.projectno=prj.doc_no left join gl_vehmaster v on if(l.perfleet=0,l.tmpfleet,l.perfleet)=v.fleet_no\r\n" + 
            				"  left join gl_vehmaster orgveh on l.perfleet=orgveh.fleet_no left join gl_vehmaster repveh on l.tmpfleet=repveh.fleet_no\r\n" + 
            				"  left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid\r\n" + 
            				"   left join gl_vehbrand br on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid\r\n" + 
            				"   left join gl_ltarif tr on tr.rdocno=l.doc_no  left join(select (drid)drid,(rdocno)rdocno from gl_ldriver where status=3 group by rdocno,drid) dr on dr.rdocno=l.doc_no\r\n" + 
            				" left join gl_vehauth auth on repveh.authid=auth.doc_no left join gl_vehplate plate on repveh.pltid=plate.doc_no left join gl_vehauth contractauth on orgveh.authid=contractauth.doc_no left join gl_vehplate contractplate on orgveh.pltid=contractplate.doc_no    left join  gl_drdetails d on (d.dr_id=dr.drid ) left join my_user ur on ur.doc_no=l.userid  left join gl_lagmtclosem cs on cs.agmtno=l.doc_no\r\n" + 
            				" left join my_user clur on clur.doc_no=cs.userid     left join my_salm ms on ms.doc_no=l.salid left join my_brch br1 on br1.doc_no=l.brhid  left join (select (brhid)brhid,(loc_name)loc_name from my_locm group by brhid,loc_name) ml on ml.brhid=br1.doc_no  left join gl_yom gy on orgveh.yom=gy.doc_no where l.status=3 	"+sqltest+" )";
            System.out.println("---uniondetailsgrid-----"+sqlchk);
                
            		ResultSet resultSet = stmtVeh.executeQuery(sqlchk);
            		 RESULTDATA=objcommon.convertToJSON(resultSet);
            		// System.out.println("--------"+RESULTDATA);
     				stmtVeh.close();
     				
            	
            	
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
}
