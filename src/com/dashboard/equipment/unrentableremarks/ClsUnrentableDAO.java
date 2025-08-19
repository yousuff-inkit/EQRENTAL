package com.dashboard.equipment.unrentableremarks;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsUnrentableDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray getReleaseData(String brchval) throws SQLException {
        List<ClsUnrentableBean> releaseBean = new ArrayList<ClsUnrentableBean>();
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        try {
        	conn=ClsConnection.getMyConnection();
//			System.out.println("Here");
				
				Statement stmtDashBoard = conn.createStatement ();
				String strSql="";
				if(brchval.equalsIgnoreCase("a")){
            	strSql="select veh.prch_dte purdate,veh.doc_no,grp.gid ,brd.brand,veh.fleet_no,veh.flname,yom.yom,clr.color,veh.reg_no regno,"
						+ "veh.brhid branch,veh.cur_km km,round(veh.c_fuel,3) fuel,veh.status opstatus,veh.fstatus aststatus from gl_equipmaster veh left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join "
						+ " gl_vehbrand brd on veh.brdid=brd.doc_no left join my_color clr on veh.clrid=clr.doc_no left join gl_yom yom on veh.yom=yom.doc_no where "
						+ " tran_code='IN' and fstatus='I' and dtype='EEM' and statu<>7";
				}
				else{
					strSql="select veh.prch_dte purdate,veh.doc_no,grp.gid ,brd.brand,veh.fleet_no,veh.flname,yom.yom,clr.color,veh.reg_no regno,"
							+ "veh.brhid branch,veh.cur_km km,round(veh.c_fuel,3) fuel,veh.status opstatus,veh.fstatus aststatus from gl_equipmaster veh left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join "
							+ " gl_vehbrand brd on veh.brdid=brd.doc_no left join my_color clr on veh.clrid=clr.doc_no left join gl_yom yom on veh.yom=yom.doc_no where "
							+ " tran_code='IN' and fstatus='I'   and dtype='EEM' and  statu<>7 and veh.brhid="+brchval;
				}
//            	System.out.println("ReleaseSQL"+strSql);
				ResultSet resultSet = stmtDashBoard.executeQuery (strSql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtDashBoard.close();
				conn.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        finally{
        	conn.close();
        }
        return RESULTDATA;
    }
	
	public String statussearch() throws SQLException {
		String cellarray1 = "";  
	     Connection conn = null;
	  try {
	     conn = ClsConnection.getMyConnection();
	    Statement stmt6 = conn.createStatement ();
	    
	   
	    String tasql= ("select doc_no,st_desc from gl_unrentablestatus");
	    //System.out.println("----------"+tasql);
	    ResultSet resultSet5 = stmt6.executeQuery(tasql);
	    while (resultSet5.next()) {
	     
	    
	     
	     cellarray1+=resultSet5.getString("st_desc")+",";
	     //bean.setRentaltype(resultSet5.getString("rentaltype"));
	     
	    
	    }
	    cellarray1=cellarray1.substring(0, cellarray1.length()-1);
	    stmt6.close();
	    conn.close();
	  }
	  catch(Exception e){
	   conn.close();
	   e.printStackTrace();
	  }
	     return cellarray1;
	 }
	
	
	public JSONArray searchUnrentable(String branchval,String relodestatus) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqltest="";
				if(!(branchval.equalsIgnoreCase("")) && !(branchval.equalsIgnoreCase("a")) && !(branchval.equalsIgnoreCase("NA"))){
            		sqltest=" and m.a_br='"+branchval+"'";
            	}
				String sql1="";
				if(!(relodestatus.equalsIgnoreCase("ALL"))){
					 sql1=" and m.UNRENTABLESTATUS='"+relodestatus+"'";
				}
				
				
				
            	String sqldata="select  'Save' btnsave,coalesce(un.remarks,'') remarks,v.doc_no movdocno,m.doc_no,m.a_br brhid,br.branchname,m.FLEET_NO,m.FLNAME,m.REG_NO,v.kmin cur_km,m.SRVC_KM,y.YOM,m.renttype renttype,v.din,v.tin,"+
            			" CASE WHEN v.fin='0.000' THEN 'Level 0/8' WHEN v.fin='0.125' THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' WHEN v.fin='0.375'"+
            			" THEN 'Level 3/8' WHEN v.fin='0.500' THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' WHEN m.C_FUEL='0.750' THEN 'Level 6/8'"+
            			" WHEN m.C_FUEL='0.875' THEN 'Level 7/8' WHEN m.C_FUEL='1.000' THEN 'Level 8/8' END as 'C_FUEL',l.LOC_NAME,g.gname,c.color,"+
            			" b.brand_name, TIMESTAMPDIFF(Day,cast(din as datetime),cast(curdate() as datetime)) idledays,m.UNRENTABLESTATUS cstatus from gl_equipmaster m "
            			+ " inner join gl_emove v on v.fleet_no=m.fleet_no and m.tran_code='UR' and m.fstatus='L' "
    					+ " inner  join   (select max(doc_no) maxd,fleet_no from gl_emove group by fleet_no) a "
    					+ " on v.doc_no=a.maxd and v.fleet_no=a.fleet_no "
    					+ " left join my_locm l on l.doc_no=m.A_LOC  left join gl_vehgroup g on g.doc_no=m.VGRPID left join"
            			+ " my_color c on(m.clrid=c.doc_no)  left join gl_vehbrand b on(m.brdid=b.doc_no) left join my_brch br on br.doc_no=m.a_br"
            			+ " left join gl_yom y on y.doc_no=m.yom left join gl_unrentable un on (v.doc_no=un.movdocno and v.fleet_no=un.fleetno) where 1=1 "+sql1+" " +sqltest ;
            					
				//System.out.println("UnRentable Query:"+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public int release(int releasefleet, String cmbrlsbranch, String cmbrlsloc,
			String releasekm, String releasefuel, int docno,
			HttpSession session, String mode, String cmbrentalstatus,
			Date reldate, String releasetime) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			System.out.println(cmbrlsloc);
			Statement stmt=conn.createStatement();
			/*ResultSet rsstmt=stmt.executeQuery("select doc_no from gl_equipmaster where fleet_no='"+releasefleet+"' and statu<>7");
			if(rsstmt.next()){
				return -1;
			}*/
			String checkregno="";int regnoerror=0;
			ResultSet rsregno=stmt.executeQuery("select reg_no from gl_equipmaster where fleet_no="+releasefleet+" and status<>7");
			if(rsregno.next()){
				checkregno=rsregno.getString("reg_no");
			}
			else{
				regnoerror=1;
			}
			if(checkregno.equalsIgnoreCase("") || checkregno==null ||checkregno.isEmpty()){
				regnoerror=1;
			}
			if(regnoerror==1){
				stmt.close();
				conn.close();
				return -2;
			}
			CallableStatement stmtVeh = conn.prepareCall("{CALL eqReleaseDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtVeh.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtVeh.setInt(1, releasefleet);
			stmtVeh.setString(2,releasefuel);
			stmtVeh.setString(3,releasekm);
			stmtVeh.setString(4, mode);
			stmtVeh.setInt(5, docno);
			stmtVeh.setString(6, cmbrlsloc);
			stmtVeh.setString(7,session.getAttribute("USERID").toString());
			stmtVeh.setString(8,cmbrlsbranch);
			stmtVeh.setString(9, cmbrentalstatus);
			stmtVeh.setDate(11, reldate);
			stmtVeh.setString(12, releasetime);
			
//			System.out.println(stmtVeh);
			int val = stmtVeh.executeUpdate();
			val=stmtVeh.getInt("docNo1");
//			System.out.println(val);
//			System.out.println("delete");
			//Bean.setDocno(val);
			
			if (val > 0) {
//				System.out.println("Sucess");
				conn.commit();
				stmtVeh.close();
				conn.close();
				return val;
			}	
			stmtVeh.close();
			conn.close();
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}
	public JSONArray subDetailss(String brnchval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
       
       
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
				String sqltest="";
				if(!(brnchval.equalsIgnoreCase("")) && !(brnchval.equalsIgnoreCase("a"))){
            		sqltest=" and m.a_br='"+brnchval+"'";
            	}
            		String sql="select uns.st_desc description,count(*) count,uns.st_desc relodestatus from gl_equipmaster m  left join gl_unrentablestatus uns on uns.st_desc=m.unrentablestatus where m.tran_code='UR' and m.fstatus='L' and m.statu=3 "+sqltest+" group by m.UNRENTABLESTATUS"
            				+ " union all "
            				+ " select 'ALL' description,count(*) count,'ALL' relodestatus from gl_equipmaster m  where m.tran_code='UR' and m.fstatus='L' and m.statu=3 "+sqltest  ;
//           System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     		      
     				
            	
          
            	conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray searchUnrentableexcel(String branchval,String relodestatus) throws SQLException {
//System.out.println("lkjnjnghklnlnblnlnkldbnbnblnblknlknln");
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqltest="";
				if(!(branchval.equalsIgnoreCase("")) && !(branchval.equalsIgnoreCase("a")) && !(branchval.equalsIgnoreCase("NA"))){
            		sqltest=" and m.a_br='"+branchval+"'";
            	}
				
				String sql1="";
				if(!(relodestatus.equalsIgnoreCase("ALL"))){
					 sql1=" and m.UNRENTABLESTATUS='"+relodestatus+"'";
				}
				
				
            	String sqldata="select br.branchname 'Avail. Br',l.LOC_NAME 'Location',g.gname 'Group',b.brand_name 'Brand',m.FLEET_NO 'Fleet',m.FLNAME 'Fleet Name',m.UNRENTABLESTATUS 'Current Status',coalesce(un.remarks,'') 'Remarks',y.YOM 'YOM',c.color 'Color',m.REG_NO 'Asset id',v.kmin 'Cur. KM',m.SRVC_KM 'Due Serv',"	
            			+ " CASE WHEN v.fin='0.000' THEN 'Level 0/8' WHEN v.fin='0.125' THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' WHEN v.fin='0.375'"+
            			" THEN 'Level 3/8' WHEN v.fin='0.500' THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' WHEN m.C_FUEL='0.750' THEN 'Level 6/8'"+
            			" WHEN m.C_FUEL='0.875' THEN 'Level 7/8' WHEN m.C_FUEL='1.000' THEN 'Level 8/8' END as 'Fuel',m.renttype 'Rent Type',m.a_br 'BranchId',"+
            			" TIMESTAMPDIFF(Day,cast(din as datetime),cast(curdate() as datetime)) 'Idle Days' from gl_equipmaster m "
            			+ " inner join gl_emove v on v.fleet_no=m.fleet_no and m.tran_code='UR' and m.fstatus='L'"
    					+ " inner  join   (select max(doc_no) maxd,fleet_no from gl_emove group by fleet_no) a "
    					+ " on v.doc_no=a.maxd and v.fleet_no=a.fleet_no "
    					+ " left join my_locm l on l.doc_no=m.A_LOC  left join gl_vehgroup g on g.doc_no=m.VGRPID left join"
            			+ " my_color c on(m.clrid=c.doc_no)  left join gl_vehbrand b on(m.brdid=b.doc_no) left join my_brch br on br.doc_no=m.a_br"
            			+ " left join gl_yom y on y.doc_no=m.yom left join gl_unrentable un on (v.doc_no=un.movdocno and v.fleet_no=un.fleetno) where 1=1 "+sql1+" " +sqltest ;
            					
				/*System.out.println("UnRentable Query excel:"+sqldata);*/
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
}
