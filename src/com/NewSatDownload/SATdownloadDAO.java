package com.NewSatDownload;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.connection.ClsConnection;
import com.sun.org.apache.bcel.internal.generic.DCONST;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

public class SATdownloadDAO {
	 static SATdownloadForm satBean=new SATdownloadForm();
	ClsConnection connobj=new  ClsConnection();
	//Connection conn = ClsConnection.getMyConnection();
	public boolean salikInsertAUH(String ts,String plno,String tag,String Trans,java.sql.Date dtripvalue,String Loc,String Dir,String src,
			Double Amount,String time,java.sql.Date dtvalue,int xsadoc,java.sql.Date sd,int xsasrno,String type,String salik_fdate,String branch) throws SQLException{


		//Connection  conn = connobj.getMyConnection();
		boolean result=false;
		PreparedStatement prest;
		int dno=0,xdoc=0;
		Connection  conn = connobj.getMyConnection();
		// conn.setAutoCommit(false);
		ResultSet rs;
		try {
//			System.out.println(" 3rd LAAAASSSSSTTTTTTTTTTTTTTTTTT"+Trans);
			rs = conn.createStatement().executeQuery("Select * from gl_salik t where trans='"+Trans+"'");


			if(rs.next())
			{
				return false;
			}
			else
			{
//				System.out.println("SECOND LAST");
				if(plno!=null&&!plno.equals(""))
				{
//					System.out.println("LAAAASSSSSTTTTTTTTTTTTTTTTTT");
					xsasrno++;

				/*	System.out.println("Insert Into gl_salik(Salik_User, regno, TagNo,Trans,salik_date,Location,Direction,Source,Amount,Salik_time,sal_date,Doc_no,date,sr_no,TYPE,salik_fdate,sal_post)" +
							" VALUES('"+ts+"','"+plno+"','"+tag+"','"+Trans+"','"+dtripvalue+"','"+Loc+"','"+Dir+"','"+src+"','"+Amount+"','"+time+"','"+dtvalue+"',"+xsadoc+",'"+sd+"',"+xsasrno+",'SAL',"+salik_fdate+"");
*/
					prest =conn.prepareStatement("Insert Into gl_salik(Salik_User, regno, TagNo,Trans,salik_date,Location,Direction,Source,Amount,Salik_time,sal_date,Doc_no,date,sr_no,TYPE,salik_fdate,sal_post,branch)" +
							" VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					prest.setString(1,ts);
					prest.setString(2,plno); 
					prest.setString(3,tag);
					prest.setString(4,Trans);
					prest.setDate(5,dtripvalue);
					prest.setString(6,Loc);
					prest.setString(7,Dir);
					prest.setString(8,src);
					prest.setDouble(9,Amount);
					prest.setString(10,time);
					prest.setDate(11,dtripvalue);
					prest.setInt(12,xsadoc);
					prest.setDate(13,sd);
					prest.setInt(14,xsasrno);
					prest.setString(15,"SAL");
					prest.setString(16,salik_fdate);
					prest.setDate(17,dtvalue);
					prest.setString(18,branch);
					prest.executeUpdate();




					try {
						prest = conn.prepareStatement("Update gl_salik set salik_date= concat(date(salik_date),' ',time(salik_time)) where doc_no="+xsadoc);

						int aa=prest.executeUpdate();

						result=true;
						//conn.commit();

					} catch (SQLException e) {
						conn.close();
						e.printStackTrace();
					}
					
					try {

//						System.out.println("update gl_salik  set autodate=now() where  doc_no in('"+xsadoc+"')");
						prest = conn.prepareStatement("update gl_salik  set autodate=now() where doc_no in("+xsadoc+")");

						int aa=prest.executeUpdate();

						result=true;
//						conn.commit();

					} catch (SQLException e) {

						conn.close();
						e.printStackTrace();
					}

				}
			}	
		} catch (SQLException e1) {
			conn.close();
			e1.printStackTrace();
		}

		finally{
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					conn.close();
					e.printStackTrace();
				}
		}
		return result;

	}

	public  JSONArray sat_fleetsearch() throws SQLException {

		

		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		Statement stmt =null;

		try {

			
			
			 conn = connobj.getMyConnection();
			
			stmt = conn.createStatement ();


			ResultSet resultSet = stmt.executeQuery ("select salik_tag,reg_no,fleet_no,category,authname,concat(code_no,code_name) as plate,va.doc_no as authcode,vp.code_no as platecode "
					+ "from gl_vehmaster vm inner join gl_vehauth va on(vm.authid=va.doc_no) inner join gl_vehplate vp on(vm.pltid=vp.doc_no )");

			RESULTDATA=convertToJSON(resultSet);
			//System.out.println("=====RESULTDATA"+RESULTDATA);

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
	
	
public  JSONArray sat_sourcesearch(String site) throws SQLException {

		

		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		Statement stmt =null;

		try {

			
			 conn = connobj.getMyConnection();
			stmt = conn.createStatement ();
			String sql="";
			if(site.equalsIgnoreCase("AUH")){
				sql="select codeno source,adhno sourceid from gl_webcat where type='s' order by  CAST(adhno AS UNSIGNED)";
			}
			else if(site.equalsIgnoreCase("DXB")){
				sql="select codeno source,nalias sourceid from gl_webcat where type='s' order by  CAST(adhno AS UNSIGNED)";
			}
			ResultSet resultSet = stmt.executeQuery (sql);

			RESULTDATA=convertToJSON(resultSet);
			//System.out.println("=====RESULTDATA"+RESULTDATA);

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}


public JSONArray sat_plateNo() throws SQLException {

	

	JSONArray RESULTDATA=new JSONArray();
	Connection conn = null;
	Statement stmt =null;

	try {

		
		 conn = connobj.getMyConnection();
		stmt = conn.createStatement ();


		ResultSet resultSet = stmt.executeQuery ("select reg_no,flname from gl_vehmaster");

		RESULTDATA=convertToJSON(resultSet);
		//System.out.println("=====RESULTDATA"+RESULTDATA);

	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	finally{
		stmt.close();
		conn.close();
	}
	return RESULTDATA;
}
	

public  JSONArray sat_colorsearch(String source,String site) throws SQLException {

	

	JSONArray RESULTDATA=new JSONArray();
	Connection conn = null;
	Statement stmt =null;

	try {

		
		 conn = connobj.getMyConnection();
		stmt = conn.createStatement ();
		String sql="";
		
		if(site.equalsIgnoreCase("AUH")){
			sql="select codeno color,adhno colorid from gl_webcat where emirate='"+source+"'and type='p' and adhno is not null order by  CAST(adhno AS UNSIGNED)";
		}
		else if(site.equalsIgnoreCase("DXB")){
			sql="select codeno color,adhno colorid from gl_webcat where emirate='"+source+"'and type='ps' and adhno is not null order by  CAST(adhno AS UNSIGNED)";
		}

		//System.out.println("=sql=sat_colorsearch="+sql);
		
		ResultSet resultSet = stmt.executeQuery (sql);

		
		RESULTDATA=convertToJSON(resultSet);
		//System.out.println("=====RESULTDATA"+RESULTDATA);

	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	finally{
		stmt.close();
		conn.close();
	}
	return RESULTDATA;
}

	
	
	public  JSONArray sat_unamesearch(String site) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		Statement stmt =null;

		try {

//			System.out.println("=====unamesearch");
			 conn = connobj.getMyConnection();
			stmt = conn.createStatement ();


			ResultSet resultSet = stmt.executeQuery ("SELECT username,iscaptcha FROM gl_webid where type='U' and site='"+site+"'");

			RESULTDATA=convertToJSON(resultSet);
//			System.out.println("=====RESULTDATA"+RESULTDATA);

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray sat_tfilesearch(String site) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		Statement stmt =null;

		try {

//			System.out.println("=====filesearch");
			 conn = connobj.getMyConnection();
			stmt = conn.createStatement ();


			ResultSet resultSet = stmt.executeQuery ("SELECT username,iscaptcha FROM gl_webid where site='"+site+"' and type='F'");

			RESULTDATA=convertToJSON(resultSet);
//			System.out.println("SELECT username FROM gl_webid where site='"+site+"'");
//			System.out.println("=====RESULTDATA"+RESULTDATA);

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}



	public  JSONArray convertToJSON(ResultSet resultSet)
			throws Exception {
		JSONArray jsonArray = new JSONArray();
		while (resultSet.next()) {
			int total_rows = resultSet.getMetaData().getColumnCount();
			JSONObject obj = new JSONObject();
			for (int i = 0; i < total_rows; i++) {
				obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
			}
			jsonArray.add(obj);
		}
		return jsonArray;
	}

	public boolean trafficInsert(String Ticket_No,java.sql.Date traffic_date,String Time,String fine_Source,String regNo,
			String PlateCategory,String pcolor,String LicenseNo,String LicenseFrom,String NotPayReason,Double Amount,
			String location,String fine,String remarks,java.sql.Date sd,String type,String category,int sr_no,String tcno,
			int xdoc,Date date,String branch,String plate_source,String site,String desc1,String xdocs) throws SQLException{



		boolean result=false;
		PreparedStatement prest;
		int dno=0;
		String inv="0";String sts="";
		String amount="0.0";
		ClsConnection connobj=new  ClsConnection();
		Connection conn = connobj.getMyConnection();
//		conn.setAutoCommit(false);
		try
		{

			boolean xflag=true;
			ResultSet sub=null;
			if(category.equalsIgnoreCase("traffic")){

				sub = conn.createStatement(
						ResultSet.TYPE_SCROLL_SENSITIVE,
						ResultSet.CONCUR_UPDATABLE).executeQuery(
								"Select * from  gl_traffic where doc_no="+xdoc);

				int xsrno = 1;
				String fineno="";

				int config=0;
				String strconfig="select * from gl_config where field_nme='trafficdownloadupdated'";
				ResultSet rsconfig= conn.createStatement().executeQuery(strconfig);
				while(rsconfig.next()){
					config=rsconfig.getInt("method");
				}

				fineno=Ticket_No;
				String extticket="";
				int isallocated=0;
//				System.out.println("Select * from gl_traffic t where t.Ticket_No='"+fineno+"'");
				ResultSet rs = conn.createStatement().executeQuery("Select * from gl_traffic t where t.Ticket_No='"+fineno+"'");
				if(rs.next()){
					String loc=rs.getString("Location");
					Double lo=0.0;
					FileInputStream in=null;
					Properties props = new Properties();
					int dwno=0; 
					isallocated=rs.getInt("isallocated");
					sts=rs.getString("status");
					String fines=String.valueOf(rs.getDouble("fine"));
					amount=String.valueOf(rs.getDouble("amount"));

					extticket=rs.getString("Ticket_No");
					/*if(loc!=null&&!loc.equalsIgnoreCase("")){
						lo=Double.parseDouble(loc);
						loc=String.valueOf(lo);
						}*/
					inv=rs.getString("inv_no")==null?"0":rs.getString("inv_no") ;
					/*if(inv==null || inv.equalsIgnoreCase("0"))
					{
						System.out.println("Deleted Traffic:"+fineno+" With Inv #"+inv);*/
						if((inv.equalsIgnoreCase("0"))&&((!(Amount.toString().equalsIgnoreCase(amount))))){
//							System.out.println("INSIDE  Delete gl_traffic");
//							prest =conn.prepareStatement("Delete from  gl_traffic  where Ticket_No='"+fineno+"'");
							prest =conn.prepareStatement("Delete from  gl_traffic  where  isallocated=0 and Ticket_No='"+fineno+"'");
							prest.executeUpdate();	
						/*}*/
					}
	//			System.out.println(fineno!=null+"==="+!fineno.equals("")+"====="+inv.equalsIgnoreCase("0")+"===="+(!(Amount.toString().equalsIgnoreCase(amount)))+"===="+ config);
				}

				// if(extticket.trim().equalsIgnoreCase("")||(fineno!=null&&!fineno.trim().equalsIgnoreCase("")&&(inv.trim().equalsIgnoreCase("0"))))
				if(fineno!=null&&!fineno.equals("")&&(inv.equalsIgnoreCase("0") &&!(Amount.toString().equalsIgnoreCase(amount))) && isallocated==0)
			{
					//if(Ticket_No.equalsIgnoreCase("7022300157")){
						/*System.out.println("Insert Into gl_traffic(regno, Ticket_No, Remarks,status,Doc_no,Time,Traffic_Date,Amount,sr_no,type,location,fine_source,pcolor,fine,tcno,Licence_no,Licence_From,source)" +
								" VALUES('"+regNo+"','"+Ticket_No+"','"+remarks+"',0,'"+xdoc+"','"+Time+"','"+traffic_date+"',"+Amount+",'"+sr_no+"','"+type+"','"+location+"','"+fine_Source+"','"+pcolor+"',"+fine+",'"+tcno+"','"+LicenseNo+"','"+LicenseFrom+"','"+plate_source+"'");*/
					//}

					prest =conn.prepareStatement("Insert Into gl_traffic(regno, Ticket_No, Remarks,status,Doc_no,Time,Traffic_Date,Amount,sr_no,type,location,fine_source,pcolor,fine,tcno,Licence_no,Licence_From,date,Branch,desc1,inv_no,source,autodate)" +
							" VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,0,?,now())");
					prest.setString(1,regNo.trim());
					prest.setString(2,Ticket_No); 
//					System.out.println(remarks+"======="+desc1);
					prest.setString(3,(site.equalsIgnoreCase("AUH")?remarks:null));
					prest.setInt(4,0);
					prest.setInt(5,xdoc);
					prest.setString(6,Time);
					prest.setDate(7,traffic_date);
					prest.setDouble(8,Amount);
					prest.setInt(9,sr_no);
					prest.setString(10,type);
					prest.setString(11,location);
					prest.setString(12,fine_Source);
					prest.setString(13,pcolor);
					prest.setString(14,fine);
					prest.setString(15,tcno);
					prest.setString(16,LicenseNo);
					prest.setString(17,LicenseFrom);
					prest.setDate(18,date);
					prest.setString(19,branch);
					prest.setString(20,(site.equalsIgnoreCase("AUH")?remarks:desc1));
					//prest.setString(20,remarks);
					prest.setString(21,plate_source);
					prest.executeUpdate();

					result=true;
//					conn.commit();

					if(site.equalsIgnoreCase("AUH")){



						try {

//							System.out.println("update gl_traffic t,gl_webcat c set pcolor=itemno where c.codeno=t.pcolor and c.codeno='"+pcolor+"' and c.emirate='"+plate_source+"'");
//							prest = conn.prepareStatement("update gl_traffic t,gl_webcat c set pcolor=itemno,SET desc1 = REPLACE (REPLACE (desc1, ' \r ', ' '), ' \n ', ' ') where c.codeno=t.pcolor and c.codeno='"+pcolor+"' and c.emirate='"+plate_source+"'");
							prest = conn.prepareStatement("update gl_traffic t,gl_webcat c set pcolor=itemno,fleetno=1 where c.nalias='"+pcolor+"'  and c.emirate='"+plate_source+"' and c.type!='PS' and fleetno=0");
							//int aa=prest.executeUpdate();

							result=true;
//							conn.commit();

						} catch (SQLException e) {

							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
						try {

//							System.out.println("update gl_traffic  set autodate=now() where  doc_no in('"+xdocs+"')");
							prest = conn.prepareStatement("update gl_traffic  set autodate=now(), desc1 = REPLACE (REPLACE (desc1, ' \r ', ' '), ' \n ', ' ')  where doc_no in("+xdocs+")");

							int aa=prest.executeUpdate();

							result=true;
//							conn.commit();

						} catch (SQLException e) {
							conn.close();
							e.printStackTrace();
						}
					}    
				}
			}
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
			result=false;
		}
		finally{

			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					conn.close();
					e.printStackTrace();
				}
		}
		return result;
	}

	public boolean salikInsert(String ts,String plno,String tag,String Trans,java.sql.Date dtripvalue,String Loc,String Dir,String src,Double Amount,String time,java.sql.Date dtvalue,int xsadoc,java.sql.Date sd,int xsasrno,String type,String salik_fdate,String branch) throws SQLException{


		//Connection  conn = connobj.getMyConnection();
		boolean result=false;
		PreparedStatement prest;
		int dno=0,xdoc=0;
		Connection  conn = connobj.getMyConnection();
		// conn.setAutoCommit(false);
		ResultSet rs;
		try {
//			System.out.println(" 3rd LAAAASSSSSTTTTTTTTTTTTTTTTTT"+Trans);
			rs = conn.createStatement().executeQuery("Select * from gl_salik t where t.trans='"+Trans+"'");


			if(rs.next())
			{
				return false;
			}
			else
			{
//				System.out.println("SECOND LAST");
				if(Trans!=null&&!Trans.equals(""))
				{
//					System.out.println("LAAAASSSSSTTTTTTTTTTTTTTTTTT");
					xsasrno++;

//					System.out.println("Insert Into gl_salik(Salik_User, regno, TagNo,Trans,salik_date,Location,Direction,Source,Amount,Salik_time,sal_date,Doc_no,date,sr_no,TYPE,salik_fdate,sal_post)" +
							//" VALUES('"+ts+"','"+plno+"','"+tag+"','"+Trans+"','"+dtripvalue+"','"+Loc+"','"+Dir+"','"+src+"','"+Amount+"','"+time+"','"+dtvalue+"',"+xsadoc+",'"+sd+"',"+xsasrno+",'SAL',"+salik_fdate+"");

					prest =conn.prepareStatement("Insert Into gl_salik(Salik_User, regno, TagNo,Trans,salik_date,Location,Direction,Source,Amount,Salik_time,sal_date,Doc_no,date,sr_no,TYPE,salik_fdate,sal_post,branch)" +
							" VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					prest.setString(1,ts);
					prest.setString(2,plno); 
					prest.setString(3,tag);
					prest.setString(4,Trans);
					prest.setDate(5,dtripvalue);
					prest.setString(6,Loc);
					prest.setString(7,Dir);
					prest.setString(8,src);
					prest.setDouble(9,Amount);
					prest.setString(10,time);
					prest.setDate(11,dtripvalue);
					prest.setInt(12,xsadoc);
					prest.setDate(13,sd);
					prest.setInt(14,xsasrno);
					prest.setString(15,"SAL");
					prest.setString(16,salik_fdate);
					prest.setDate(17,dtvalue);
					prest.setString(18,branch);
					prest.executeUpdate();




					try {
						prest = conn.prepareStatement("Update gl_salik set salik_date= concat(date(salik_date),' ',time(salik_time)) where doc_no="+xsadoc);

						int aa=prest.executeUpdate();

						result=true;
						//conn.commit();

					} catch (SQLException e) {
						conn.close();
						e.printStackTrace();
					}
					
					try {

//						System.out.println("update gl_salik  set autodate=now() where  doc_no in('"+xsadoc+"')");
						prest = conn.prepareStatement("update gl_salik  set autodate=now() where doc_no in("+xsadoc+")");

						int aa=prest.executeUpdate();

						result=true;
//						conn.commit();

					} catch (SQLException e) {

						conn.close();
						e.printStackTrace();
					}

				}
			}	
		} catch (SQLException e1) {
			conn.close();
			e1.printStackTrace();
		}

		finally{
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					conn.close();
					e.printStackTrace();
				}
		}
		return result;

	}



	public  JSONArray loadSalikData(String xdocs) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;

		try {

//			System.out.println("=====sat_unamesearch");
			 conn = connobj.getMyConnection();
			stmt = conn.createStatement ();

			ResultSet resultSet = stmt.executeQuery ("Select Salik_User,trans,salik_date,salik_time,sal_date,regno,source,tagno,location,direction,amount,date from gl_salik where Doc_no in ("+xdocs+")");
//			System.out.println("============"+stmt);
			RESULTDATA=convertToJSON(resultSet);
//			System.out.println("=====RESULTDATA"+RESULTDATA);

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}

	public String  loadCaptchatext(String txtcaptcha) throws SQLException {


		try {

			satBean=new SATdownloadForm();
			satBean.setCaptchatxt(txtcaptcha);
			loadCaptcha();


		}
		catch(Exception e){
			e.printStackTrace();
		}
		return txtcaptcha;
	}

	public static String  loadCaptcha() throws SQLException {

		String txtcaptcha=null;
		try {
//			System.out.println("====ggggetCaptchatxt==="+satBean.getCaptchatxt());
			txtcaptcha=satBean.getCaptchatxt();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return txtcaptcha;
	}



	public  JSONArray loadTrafficData(String xdocs) throws SQLException {

//		System.out.println("==xdocs===="+xdocs);

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		Statement stmt =null;

		try {

//			System.out.println("=====loadtraffic");
			 conn = connobj.getMyConnection();
			stmt = conn.createStatement ();




			ResultSet resultSet = stmt.executeQuery ("Select tcno,ticket_no,traffic_date,time,fine_source,amount,regno,Pcolor,licence_no,licence_from,tick_violat,tick_location from gl_traffic where Doc_no in ("+xdocs+")");
//			System.out.println("Select tcno,ticket_no,traffic_date,time,fine_source,amount,regno,Pcolor,licence_no,licence_from,tick_violat,tick_location from gl_traffic where Doc_no in ("+xdocs+")");
			RESULTDATA=convertToJSON(resultSet);
//			System.out.println("==loadTrafficData===RESULTDATA"+RESULTDATA);

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
	
    public   JSONArray vehSearch(HttpSession session,String fleetno,String regno,String flname,String stag,String pcode,String aa) throws SQLException {


	   	 JSONArray RESULTDATA=new JSONArray();
	   	    Enumeration<String> Enumeration = session.getAttributeNames();
	   	    int a=0;
	   	    while(Enumeration.hasMoreElements()){
	   	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	   	      a=1;
	   	     }
	   	    }
	   	    if(a==0){
	   	  return RESULTDATA;
	   	     }
	   	        
	    	    	
	        String brid=session.getAttribute("BRANCHID").toString();
	     	
	  
	    		
	    
	    	
   	String sqltest="";
	    	
	    	if((!(fleetno.equalsIgnoreCase(""))) && (!(fleetno.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and v.fleet_no like '%"+fleetno+"%'";
	    	}
	    	if((!(regno.equalsIgnoreCase(""))) && (!(regno.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and v.reg_no like '%"+regno+"%'  ";
	    	}
	    	if((!(flname.equalsIgnoreCase(""))) && (!(flname.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and v.FLNAME like '%"+flname+"%'";
	    	}
	    	if((!(stag.equalsIgnoreCase(""))) && (!(stag.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and v.salik_tag like '%"+stag+"%'";
	    	}
	    	if((!(pcode.equalsIgnoreCase(""))) && (!(pcode.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and plate.code_name like '%"+pcode+"%'";
	    	}
	   
	    	 Connection conn =null;
			try {
				
				conn = connobj.getMyConnection();
				if(aa.equalsIgnoreCase("yes"))
				{					
					  
					Statement stmtVeh8 = conn.createStatement ();
			
				String vehsql="select  REG_NO, FLEET_NO, FLNAME, SALIK_TAG,plate.code_name platecode from gl_vehmaster v "
						+ "left join gl_vehplate plate on v.pltid=plate.doc_no where  statu=3 "+sqltest+" ";	
				System.out.println("--------lease-------"+vehsql);
					ResultSet resultSet = stmtVeh8.executeQuery(vehsql);
					
					RESULTDATA=convertToJSON(resultSet);
					stmtVeh8.close();
					
				}
				conn.close();
				 return RESULTDATA;
			}
			catch(Exception e){
				conn.close();
				e.printStackTrace();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
    
    public int downloadExcelSaliks(Connection conn,String exceldocno,HttpSession session)throws SQLException{
    	int xsadoc=0;
    	try {
        	System.out.println("inside excel dao");
    		Statement stmt=conn.createStatement();
    		String str="select path,filename from my_fileattach where dtype='SAT' and doc_no="+exceldocno;
    		ResultSet rs=stmt.executeQuery(str);
    		String filename="",filepath="";
    		while(rs.next()){
    			filename=rs.getString("filename");
    			filepath=rs.getString("path");
    		}
    		//System.out.println(filepath);
    		System.out.println(filepath);
    		filepath = filepath.replace("\\", "//");
			System.out.println(filepath);
            
    		int qudraAllSalik=0;
			ResultSet rsallsalik=conn.createStatement().executeQuery("select method from gl_config where field_nme='qudraAllSalik'");
			while(rsallsalik.next()){
				qudraAllSalik=rsallsalik.getInt("method");
			}
    		FileInputStream input = new FileInputStream(filepath);
            POIFSFileSystem fs = new POIFSFileSystem( input );
            HSSFWorkbook wb = new HSSFWorkbook(fs);
            HSSFSheet sheet = wb.getSheetAt(0);
            Row excelRow;
            session.setAttribute("TOTALITEMCOUNT",sheet.getLastRowNum()-10);
            int xsasrno=0;
            String ts=session.getAttribute("USERNAME").toString();
    		ResultSet rssalikmax = conn.createStatement().executeQuery("Select coalesce((max(doc_no)+1),1) max from gl_salik");
    		
    		String xdocs="";
    		if(rssalikmax.next())
    		{	
    			xsadoc=0;
    			xsadoc=rssalikmax.getInt("max");

    			xdocs=xdocs+","+xsadoc;	
    			xsasrno=0;
    		}
    		session.setAttribute("ITEMCURRENTDOCNO",xsadoc);
            for(int i=10; i<(sheet.getLastRowNum()); i++){
            	
            	String transactionID="",tagNumber="",plate="";
            	java.sql.Date tripsDate=null;
    			java.sql.Date sd = null;
    			double amount=0.00;
            	
            	SimpleDateFormat formatDate = new SimpleDateFormat("MM/dd/yyyy");
            	excelRow = sheet.getRow(i);
                
                if(excelRow.getCell(2).getCellType()==1){
                	transactionID = excelRow.getCell(2).getStringCellValue()=="" || excelRow.getCell(2).getStringCellValue()==null?"0":excelRow.getCell(2).getStringCellValue().replace("'", " ");
                	//System.out.println("Transaction ID:"+transactionID);
                } else {
                	transactionID = String.valueOf((int) excelRow.getCell(2).getNumericCellValue());	
                	//System.out.println("Transaction ID:"+transactionID);
                }
                if(transactionID.equalsIgnoreCase("") || transactionID==null || transactionID.equalsIgnoreCase("0")){
                	continue;
                }
                DataFormatter formatter = new DataFormatter();
                String formatteddate =formatter.formatCellValue(excelRow.getCell(4));
                java.util.Date tripDate = formatDate.parse(formatteddate.split(" ")[0]);
                tripsDate= new java.sql.Date(tripDate.getTime());
                String tripTime = formatteddate;
                DateFormat timeinputformat = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss aa");
                DateFormat timeoutputformat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
                java.util.Date tempdate=timeinputformat.parse(tripTime); 
                String outputtimeformat = timeoutputformat.format(tempdate);
				//System.out.println(tripsDate+"::"+outputtimeformat);
				String time=outputtimeformat.split(" ")[1];
                
                String transactionPostDate = formatter.formatCellValue(excelRow.getCell(5));
                //excelRow.getCell(5).getStringCellValue()=="" || excelRow.getCell(5).getStringCellValue()==null?"0":excelRow.getCell(5).getStringCellValue();
                String tollGate = excelRow.getCell(7).getStringCellValue()==""  || excelRow.getCell(7).getStringCellValue()==null?"0":excelRow.getCell(7).getStringCellValue();
                String direction = excelRow.getCell(16).getStringCellValue()==""  || excelRow.getCell(16).getStringCellValue()==null?"0":excelRow.getCell(16).getStringCellValue();
                
                if(excelRow.getCell(14).getCellType()==1){
                	tagNumber = excelRow.getCell(14).getStringCellValue()=="" || excelRow.getCell(14).getStringCellValue()==null?"0":excelRow.getCell(14).getStringCellValue().replace("'", " ");
                } else {
                	tagNumber = String.valueOf((int) excelRow.getCell(14).getNumericCellValue());	
                }
                
                if(excelRow.getCell(12).getCellType()==1){
                	plate = excelRow.getCell(12).getStringCellValue()=="" || excelRow.getCell(12).getStringCellValue()==null?"0":excelRow.getCell(12).getStringCellValue().replace("'", " ");
                } else {
                	plate = String.valueOf((int) excelRow.getCell(12).getNumericCellValue());	
                }
                
                if(excelRow.getCell(17).getCellType()==1){
                	amount = Double.parseDouble(excelRow.getCell(17).getStringCellValue()=="" || excelRow.getCell(17).getStringCellValue()==null?"0":excelRow.getCell(17).getStringCellValue().replace("'", " "));
                } else {
                	amount = (double) excelRow.getCell(17).getNumericCellValue();
                }
                
                xsasrno++;
    			SATdownloadDAO dao=new SATdownloadDAO();
    			String location=excelRow.getCell(15).getStringCellValue()==""  || excelRow.getCell(15).getStringCellValue()==null?"0":excelRow.getCell(15).getStringCellValue();
    			//System.out.println(transactionID+"::"+tripsDate+"::"+time+"::"+tollGate+"::"+direction+"::"+tagNumber+"::"+plate+"::"+amount);
    			/*if(amount>0){
    				boolean result=dao.salikInsert(ts,plate,tagNumber,transactionID,tripsDate,location,direction,tollGate,amount,time,tripsDate,xsadoc,sd,xsasrno,"","","");
					
    			}*/
    			if(qudraAllSalik==1){ 
    				boolean result=dao.salikInsert(ts,plate,tagNumber,transactionID,tripsDate,location,direction,tollGate,amount,time,tripsDate,xsadoc,sd,xsasrno,"","","");
    			}
    			else{
    				if(amount>0){
    					boolean result=dao.salikInsert(ts,plate,tagNumber,transactionID,tripsDate,location,direction,tollGate,amount,time,tripsDate,xsadoc,sd,xsasrno,"","","");
    				}
    			}
            }
            
            /*File currentFile = new File(SATEXCEL,"ExportTrips.xls");
            currentFile.delete();*/
            
			/*
			 * File currentFolder = new File(filepath);
			 * FileUtils.deleteDirectory(currentFolder);
			 */
        
    	}
    	catch(Exception e) {
    		e.printStackTrace();
    	}
    	return xsadoc;


    }

}