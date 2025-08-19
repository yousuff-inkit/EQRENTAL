package com.dashboard;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDashBoardDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsDashBoardBean dashBoardBean = new ClsDashBoardBean();
	
	public JSONArray masterSearch(HttpSession session) throws SQLException {
        List<ClsDashBoardBean> masterSearchBean = new ArrayList<ClsDashBoardBean>();
        Connection conn=null;
        JSONArray RESULTDATA=new JSONArray();
        
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
         if(Enumeration.nextElement().equalsIgnoreCase("USERID")){
          a=1;
         }
        }
        if(a==0){
        	return RESULTDATA;
         }
        
        String roleid=session.getAttribute("ROLEID").toString();
        //String userid=session.getAttribute("USERID").toString();
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDashBoard = conn.createStatement();
            	
				//ResultSet resultSet = stmtDashBoard.executeQuery("select m.doc_no,m.description,m.flag,p.roleid from gl_bibm m inner join (select distinct(mno) mno,"
					//	+ "permission,roleid from my_powrbi) p on p.mno=m.doc_no left join my_user u on (u.role_id=p.roleid) where m.status=1 and p.permission=1 and u.doc_no="+userid+" "
					//	+ "order by m.srno");
				
				ResultSet resultSet = stmtDashBoard.executeQuery("select m.doc_no,m.description,m.flag,p.roleid from gl_bibm m inner join (select distinct(mno) mno,"
						+ "permission,roleid from my_powrbi) p on p.mno=m.doc_no where m.status=1 and p.permission=1 and p.roleid="+roleid+" "
						+ "order by m.srno");
				
				//ResultSet resultSet = stmtDashBoard.executeQuery ("SELECT doc_no,description,flag FROM gl_bibm where status=1");
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtDashBoard.close();
				conn.close();
				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray detailSearch(String docNo,HttpSession session) throws SQLException {
        List<ClsDashBoardBean> detailSearchBean = new ArrayList<ClsDashBoardBean>();
        Connection conn=null;
        JSONArray RESULTDATA1=new JSONArray();
        
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
         if(Enumeration.nextElement().equalsIgnoreCase("USERID")){
          a=1;
         }
        }
        if(a==0){
        	return RESULTDATA1;
         }
        
        String roleid=session.getAttribute("ROLEID").toString();
        //String userid=session.getAttribute("USERID").toString();
        
		try {
			    conn = ClsConnection.getMyConnection();
				Statement stmtDashBoard1 = conn.createStatement();
            	
				//ResultSet resultSet1 = stmtDashBoard1.executeQuery ("select m.doc_no,m.description,m.value,m.flag,m.path from gl_bibd m inner join my_powrbi p on "
					//	+ "p.dno=m.doc_no left join my_user u on (u.role_id=p.roleid) where m.status=1 and p.permission=1 and u.doc_no="+userid+"  and m.rdocno="+docNo+" order by m.SRNO");
				
				ResultSet resultSet1 = stmtDashBoard1.executeQuery ("select m.doc_no,m.description,m.value,m.flag,m.path from gl_bibd m inner join my_powrbi p on "
						+ "p.dno=m.doc_no where m.status=1 and p.permission=1 and p.roleid="+roleid+"  and m.rdocno="+docNo+" order by m.SRNO");
				
				//ResultSet resultSet1 = stmtDashBoard1.executeQuery ("SELECT description,value,flag,path FROM gl_bibd where status=1 and  rdocno="+docNo+" order by srno");
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtDashBoard1.close();
				conn.close();
				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
        return RESULTDATA1;
    }
	
	public JSONArray detail(HttpSession session) throws SQLException {
        List<ClsDashBoardBean> detailBean = new ArrayList<ClsDashBoardBean>();
        Connection conn=null;
        JSONArray RESULTDATA2=new JSONArray();
        
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
         if(Enumeration.nextElement().equalsIgnoreCase("USERID")){
          a=1;
         }
        }
        if(a==0){
        	return RESULTDATA2;
         }
        
        String roleid=session.getAttribute("ROLEID").toString();
        //String userid=session.getAttribute("USERID").toString();
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDashBoard2 = conn.createStatement();
            	
				//ResultSet resultSet2 = stmtDashBoard2.executeQuery ("select m.doc_no,m.description,m.value,m.flag,m.path from gl_bibd m inner join my_powrbi p on "
				//		+ "p.dno=m.doc_no left join my_user u on (u.role_id=p.roleid) where m.status=1 and p.permission=1 and u.doc_no="+userid+" and m.rdocno in (select doc_no from gl_bibm where srno=1) order by m.SRNO");
				
				ResultSet resultSet2 = stmtDashBoard2.executeQuery ("select m.doc_no,m.description,m.value,m.flag,m.path from gl_bibd m inner join my_powrbi p on "
						+ "p.dno=m.doc_no where m.status=1 and p.permission=1 and p.roleid="+roleid+" and m.rdocno in (select doc_no from gl_bibm where srno=1) order by m.SRNO");
				
				//ResultSet resultSet2 = stmtDashBoard2.executeQuery ("SELECT description,value,flag,path FROM gl_bibd where status=1 and  rdocno=1 order by srno");
				
				RESULTDATA2=ClsCommon.convertToJSON(resultSet2);
				
				stmtDashBoard2.close();
				conn.close();
				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
        return RESULTDATA2;
    }
	
	public JSONArray readyToRents() throws SQLException {
    List<ClsDashBoardBean> readyToRentsBean = new ArrayList<ClsDashBoardBean>();
    Connection conn=null;
    JSONArray RESULTDATA3=new JSONArray();
	try {
			conn = ClsConnection.getMyConnection();
			Statement stmtDashBoard3 = conn.createStatement();
        	
			ResultSet resultSet3 = stmtDashBoard3.executeQuery("select m.vmodid,count(*) availability,SUBSTRING(v.gname,1,1) gname from gl_equipmaster m left join gl_vehgroup v on "
					+ "m.vgrpid=v.doc_no where tran_code='RR' group by vgrpid");

			RESULTDATA3=ClsCommon.convertToJSON(resultSet3);
			//System.out.println("======= "+RESULTDATA3);
			stmtDashBoard3.close();
			conn.close();
	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}finally{
		conn.close();
	}
    return RESULTDATA3;
   }

	public JSONArray idleDays() throws SQLException {
	    List<ClsDashBoardBean> idleDaysBean = new ArrayList<ClsDashBoardBean>();
	    Connection conn=null;
	    JSONArray RESULTDATA4=new JSONArray();
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDashBoard4 = conn.createStatement();
	        	
				/*ResultSet resultSet4 = stmtDashBoard4.executeQuery("select count(*) noofvehicles,aa.idledays from (select v.doc_no,din,tin,vm.fleet_no,"
						+ "TIMESTAMPDIFF(Day,cast(din as datetime),cast(curdate() as datetime)) idledays from gl_equipmaster vm inner join gl_emove v on v.fleet_no=vm.fleet_no "
						+ "and vm.status='IN' and v.doc_no=(select max(doc_no) from gl_emove where fleet_no= vm.fleet_no)) aa group by aa.idledays");*/
				
				ResultSet resultSet4 = stmtDashBoard4.executeQuery("select count(*) noofvehicles,aa.idledays from (select v.doc_no,din,tin,vm.fleet_no,"
						+ "coalesce(TIMESTAMPDIFF(Day,cast(din as datetime),cast(curdate() as datetime)),0) idledays from gl_equipmaster vm inner join gl_emove v "
						+ "on v.fleet_no=vm.fleet_no and vm.status='IN' and v.doc_no=(select max(doc_no) from gl_emove where fleet_no= vm.fleet_no)) aa group by aa.idledays");
	
				RESULTDATA4=ClsCommon.convertToJSON(resultSet4);
				
				stmtDashBoard4.close();
				conn.close();
	
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
	    return RESULTDATA4;
	}
	
	public JSONArray registrationInsuranceExpiry() throws SQLException {
	    List<ClsDashBoardBean> registrationInsuranceExpiryBean = new ArrayList<ClsDashBoardBean>();
	    Connection conn=null;
	    JSONArray RESULTDATA7=new JSONArray();
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDashBoard5 = conn.createStatement();
	        	
				/*ResultSet resultSet5 = stmtDashBoard5.executeQuery("SELECT  fleet_no,DATEDIFF(CURDATE(),reg_exp) reg_exp,DATEDIFF(CURDATE(),ins_exp) ins_exp FROM gl_equipmaster t WHERE t.reg_exp between "
						+ "( CURDATE( ) - INTERVAL   10 DAY ) and  ( CURDATE( ) + INTERVAL 10 DAY ) or t.ins_exp between ( CURDATE( ) - INTERVAL   10 DAY ) and  ( CURDATE( ) + INTERVAL 10 DAY )");*/
				
				ResultSet resultSet5 = stmtDashBoard5.executeQuery("SELECT  DATEDIFF(CURDATE(),reg_exp) reg_exp1,DATEDIFF(CURDATE(),ins_exp) ins_exp1,count(*) vehicles FROM gl_equipmaster t WHERE t.reg_exp between "
						+ "( CURDATE( ) - INTERVAL   10 DAY ) and  ( CURDATE( ) + INTERVAL 10 DAY ) or t.ins_exp between ( CURDATE( ) - INTERVAL   10 DAY ) and  ( CURDATE( ) + INTERVAL 10 DAY ) group by "
						+ "reg_exp1,ins_exp1");
	
				RESULTDATA7=ClsCommon.convertToJSON(resultSet5);
				
				stmtDashBoard5.close();
				conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
	    return RESULTDATA7;
	}
	
	public JSONArray fleetStatus() throws SQLException {
        List<ClsDashBoardBean> fleetStatusBean = new ArrayList<ClsDashBoardBean>();
        
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDashBoard6 = conn.createStatement ();
            	
				ResultSet resultSet6 = stmtDashBoard6.executeQuery ("select round(aa.val/bb.val *100,2) per,aa.tran_code from (select count(*) val,tran_code from gl_equipmaster vm  where fstatus='L' group by vm.tran_code )aa,"
						+ "(select count(*) val,tran_code from gl_equipmaster vm  where fstatus='L' and tran_code is not null )bb");
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet6);
				
				stmtDashBoard6.close();
				conn.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray toDoList(HttpSession session) throws SQLException {
        List<ClsDashBoardBean> toDoListBean = new ArrayList<ClsDashBoardBean>();
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
         if(Enumeration.nextElement().equalsIgnoreCase("USERID")){
          a=1;
         }
        }
        if(a==0){
        	return RESULTDATA;
         }
        String userid=session.getAttribute("USERID").toString();
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDashBoard7 = conn.createStatement ();
            	
				ResultSet resultSet7 = stmtDashBoard7.executeQuery ("select doc_no,date,title,description,priority from my_todolist where date=curdate() and status=3 and userid='"+userid+"'");
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet7);
				
				stmtDashBoard7.close();
				conn.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray toAddedList(HttpSession session) throws SQLException {
        List<ClsDashBoardBean> toDoListBean = new ArrayList<ClsDashBoardBean>();
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
         if(Enumeration.nextElement().equalsIgnoreCase("USERID")){
          a=1;
         }
        }
        if(a==0){
        	return RESULTDATA;
         }
        String userid=session.getAttribute("USERID").toString();
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDashBoard9 = conn.createStatement();
            	
				ResultSet resultSet9 = stmtDashBoard9.executeQuery ("select doc_no,date,title,description,priority from my_todolist where status=3 and userid='"+userid+"' order by date");
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet9);
				
				stmtDashBoard9.close();
				conn.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }

	public JSONArray brandGarageLoading() throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA10=new JSONArray();
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDashBoard10 = conn.createStatement();
	        	
				String sql = "select  b.brand_name brandgarage,CONVERT(coalesce(a.gm,''),CHAR(50)) gm,CONVERT(coalesce(c.ga,''),CHAR(50)) ga,CONVERT(coalesce(d.gs,''),CHAR(50)) gs "
					+ "from gl_equipmaster v  left join gl_vehbrand b on v.brdid=b.doc_no left join (select count(*) gm,brdid from gl_equipmaster where tran_code='GM' group by brdid) a "
					+ "on a.brdid=b.doc_no left join (select count(*) ga,brdid from gl_equipmaster where tran_code='GA' group by brdid) c on c.brdid=b.doc_no left join (select count(*) gs,brdid from "
					+ "gl_equipmaster where tran_code='GS' group by brdid) d on d.brdid=b.doc_no where tran_code in ('GM','GA','GS') group by v.brdid";
				
				ResultSet resultSet10 = stmtDashBoard10.executeQuery(sql);
				RESULTDATA10=ClsCommon.convertToJSON(resultSet10);
				
				stmtDashBoard10.close();
				conn.close();
	
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
		} finally{
			conn.close();
		}
	    return RESULTDATA10;
	}

	public JSONArray brandGarageReloading(String type) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA11=new JSONArray();
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDashBoard11 = conn.createStatement();
	        	
				String sql="";
				
				if(type.contains("-") || type.equalsIgnoreCase("0")){
					
					sql = "select  b.brand_name brandgarage,CONVERT(coalesce(a.gm,''),CHAR(50)) gm,CONVERT(coalesce(c.ga,''),CHAR(50)) ga,CONVERT(coalesce(d.gs,''),CHAR(50)) gs "
						+ "from gl_equipmaster v  left join gl_vehbrand b on v.brdid=b.doc_no left join (select count(*) gm,brdid from gl_equipmaster where tran_code='GM' group by brdid) a "
						+ "on a.brdid=b.doc_no left join (select count(*) ga,brdid from gl_equipmaster where tran_code='GA' group by brdid) c on c.brdid=b.doc_no left join (select count(*) gs,brdid from "
						+ "gl_equipmaster where tran_code='GS' group by brdid) d on d.brdid=b.doc_no where tran_code in ('GM','GA','GS') group by v.brdid";	
					
				} else {
						
					sql = "select  g.name brandgarage,CONVERT(coalesce(sum(a.gm),''),CHAR(50)) gm,CONVERT(coalesce(sum(c.ga),''),CHAR(50)) ga,CONVERT(coalesce(sum(d.gs),''),CHAR(50)) gs "
						+ "from gl_equipmaster v  left join gl_nrm n on v.fleet_no=n.fleet_no left join (select count(*) gm,fleet_no from gl_equipmaster where tran_code='GM' group by fleet_no) a "
						+ "on a.fleet_no=n.fleet_no left join (select count(*) ga,fleet_no from gl_equipmaster where tran_code='GA' group by fleet_no) c on c.fleet_no=n.fleet_no left join "
						+ "(select count(*) gs,fleet_no from gl_equipmaster where tran_code='GS' group by fleet_no) d on d.fleet_no=n.fleet_no left join gl_garrage g on g.doc_no=n.garageid "  
						+ "where tran_code in ('GM','GA','GS') and n.inbranch=0 group by n.garageid";
					
				}
				
				ResultSet resultSet11 = stmtDashBoard11.executeQuery(sql);
				RESULTDATA11=ClsCommon.convertToJSON(resultSet11);
				
				stmtDashBoard11.close();
				conn.close();
	
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
		} finally{
			conn.close();
		}
	    return RESULTDATA11;
	}
	
	public int insert(Date toDotDate, String txttitle, String txtdescription,String cmbpriority, HttpSession session, String mode) throws SQLException {
		Connection conn = null;

		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);

			//String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			CallableStatement stmtDashBoard8 = conn.prepareCall("{CALL toDoListDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtDashBoard8.registerOutParameter(8, java.sql.Types.INTEGER);
			
			stmtDashBoard8.setDate(1,toDotDate);
			stmtDashBoard8.setString(2,txttitle);
			stmtDashBoard8.setString(3,txtdescription);
			stmtDashBoard8.setString(4,cmbpriority);
			stmtDashBoard8.setString(5,company);
			stmtDashBoard8.setString(6,"0");
			stmtDashBoard8.setString(7,userid);
			stmtDashBoard8.setString(9,mode);
			int datas=stmtDashBoard8.executeUpdate();
			if(datas<=0){
				stmtDashBoard8.close();
				conn.close();
				return 0;
			}
			int docno=stmtDashBoard8.getInt("docNo");
			dashBoardBean.setTxttododocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtDashBoard8.close();
				conn.close();
				return docno;
			}
			stmtDashBoard8.close();
			conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
			conn.close();
	 }
	 return 0;
	}

	public boolean edit(int txttododocno, Date toDotDate, String txttitle,String txtdescription, String cmbpriority, HttpSession session, String mode) throws SQLException {
		
		Connection conn = null;

		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			//String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();

			CallableStatement stmtDashBoard8 = conn.prepareCall("{CALL toDoListDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtDashBoard8.setInt(8,txttododocno);
			
			stmtDashBoard8.setDate(1,toDotDate);
			stmtDashBoard8.setString(2,txttitle);
			stmtDashBoard8.setString(3,txtdescription);
			stmtDashBoard8.setString(4,cmbpriority);
			stmtDashBoard8.setString(5,company);
			stmtDashBoard8.setString(6,"0");
			stmtDashBoard8.setString(7,userid);
			stmtDashBoard8.setString(9,mode);
			int datas=stmtDashBoard8.executeUpdate();
			if(datas<=0){
				stmtDashBoard8.close();
				conn.close();
				return false;
			}
			int docno=stmtDashBoard8.getInt("docNo");
			dashBoardBean.setTxttododocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtDashBoard8.close();
				conn.close();
				return true;
			}
			stmtDashBoard8.close();
			conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return false;
	 }finally{
			conn.close();
	 }
		return false;
	}

	public boolean delete(int txttododocno, HttpSession session, String mode) throws SQLException {
		
		Connection conn = null;

		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			//String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();

			CallableStatement stmtDashBoard8 = conn.prepareCall("{CALL toDoListDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtDashBoard8.setInt(8,txttododocno);
			
			stmtDashBoard8.setDate(1,null);
			stmtDashBoard8.setString(2,null);
			stmtDashBoard8.setString(3,null);
			stmtDashBoard8.setString(4,null);
			stmtDashBoard8.setString(5,company);
			stmtDashBoard8.setString(6,"0");
			stmtDashBoard8.setString(7,userid);
			stmtDashBoard8.setString(9,mode);
			int datas=stmtDashBoard8.executeUpdate();
			if(datas<=0){
				stmtDashBoard8.close();
				conn.close();
				return false;
			}
			int docno=stmtDashBoard8.getInt("docNo");
			dashBoardBean.setTxttododocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtDashBoard8.close();
				conn.close();
				return true;
			}
			stmtDashBoard8.close();
			conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return false;
	 }finally{
			conn.close();
	 }
		return false;
	}

}
