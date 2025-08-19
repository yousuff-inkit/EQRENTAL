package com.dashboard.audit.attachmentlist;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsAttachmentListDAO {

	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray docSearch(String type) throws SQLException {
		Connection conn=null;
		JSONArray RESULTDATA1=new JSONArray();
		String sql1="";
		
		
		if((type.equals("ALL"))){
			   sql1=sql1+"";
			  }
			
		else if(( type.equals("InSystem"))){
			   sql1=sql1+"and status=3";
			  }
		else if((type.equals("Deleted"))){
			   sql1=sql1+"and status=7";
			  }
		else{
			
		}
		
		try {


			conn = ClsConnection.getMyConnection();
			Statement stmtMAD = conn.createStatement();

//			String sql = "select ex.doc_no doc_no,dtype,branchname,ex.brhid as brhid from my_exdet ex inner join my_brch b on(ex.brhid=b.doc_no) where ex.dtype='"+dtype+"'";
			String sql="select  distinct doc_no,dtype,brhid,status from my_fileattach where 1=1 "+sql1+"  group by doc_no";
			//System.out.println("sql1doc====="+sql);
			ResultSet resultSet1 = stmtMAD.executeQuery(sql);
			RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
			
			stmtMAD.close();
			conn.close();
			}catch(Exception e){
			e.printStackTrace();
			conn.close();
			}finally{
			conn.close();
			}
			return RESULTDATA1;
	}

	
	public JSONArray dtypeSearch(String type) throws SQLException {
		Connection conn=null;
		JSONArray RESULTDATA1=new JSONArray();
		String sql1="";
		
		
		if((type.equals("ALL"))){
			   sql1=sql1+"";
			  }
			
		else if(( type.equals("InSystem"))){
			   sql1=sql1+"and status=3";
			  }
		else if((type.equals("Deleted"))){
			   sql1=sql1+"and status=7";
			  }
		else{
			
		}
		
		try {


			conn = ClsConnection.getMyConnection();
			Statement stmtMAD = conn.createStatement();

			String sql = "select distinct dtype,status from my_fileattach where 1=1 "+sql1+" group by dtype";

			//System.out.println("sqldtype===="+sql);
			ResultSet resultSet1 = stmtMAD.executeQuery(sql);
			RESULTDATA1=ClsCommon.convertToJSON(resultSet1);

			stmtMAD.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA1;
	}
	public JSONArray detailsgrid(String brhid,String frmdate,String todate,String doc_no,String dtype,String type) throws SQLException {
		Connection conn=null;
		JSONArray RESULTDATA1=new JSONArray();

		try {
			String sql = null;
			String condition="";
			String sql1 = "",sql2 = "";
			Date frmsqldate=ClsCommon.changeStringtoSqlDate(frmdate);
			Date tosqldate=ClsCommon.changeStringtoSqlDate(todate);

			if(!((doc_no.equalsIgnoreCase("")) || (doc_no.equalsIgnoreCase("0")))){
				sql1=sql1+" and d.doc_no="+doc_no+"";
			}
			if(!((dtype.equalsIgnoreCase("")) || (dtype.equalsIgnoreCase("0")))){
				sql1=sql1+" and d.dtype='"+dtype+"'";
			}
			
			if((type.equals("ALL"))){
				   sql1=sql1+"";
				  }
				
			else if(( type.equals("InSystem"))){
				   sql1=sql1+"and d.status=3";
				  }
			else if((type.equals("Deleted"))){
				   sql1=sql1+"and d.status=7";
				  }
			else{
				
			}
			conn = ClsConnection.getMyConnection();
			Statement stmtMAD = conn.createStatement();

			String select1=",",join1="";
			String sqldetails="select select1,join1 from my_attachname;";
			ResultSet rsdetails= stmtMAD.executeQuery(sqldetails);
			while(rsdetails.next()){
				select1+=rsdetails.getString("select1");
				join1=rsdetails.getString("join1");
			}
			
			/*sql = "select DATE_FORMAT(d.apprDate, '%d/%m/%Y') as adate,d.doc_no,d.userid,d.brhid,u.user_name,b.branchname,d.dtype,d.remarks,apprlevel,if(d.apprStatus=5,'Forwarded ',if(d.apprStatus=3,'Approved',if(d.apprStatus=2,'Returned ',if(d.apprStatus=4,'Rejected ',if(d.apprStatus=1,'Submitted ',' Send'))))) apprtype,d.apprstatus from my_exdet d left join my_brch "
						+ "b on(d.brhid=b.doc_no) left join my_user u on(d.userid=u.doc_no) left join my_exeopt o on (o.doc_no=d.apprstatus) where 1=1 "+sql1+" and DATE_FORMAT(d.apprDate, '%Y-%m-%d')>='"+frmsqldate+"' and DATE_FORMAT(d.apprDate, '%Y-%m-%d')<='"+tosqldate+"' group by doc_no,apprlevel having max(apprlevel)" ;
			 */
			sql="select d.rowno,d.dtype, d.doc_no, d.brhId,replace(path,'\\\\',';') path,DATE_FORMAT(d.date, '%d.%m.%Y') as date ,d.user,b.branchname, a.type_name type,d.filename,d.descpt descr "+select1+""
				+ " from my_fileattach d left join my_attach_type a on(d.ref_id=a.doc_no) left join my_brch b on(d.brhid=b.doc_no) "+join1+" where 1=1 "+sql1+" and DATE_FORMAT(d.Date, '%Y-%m-%d')>='"+frmsqldate+"' "
				+ " and DATE_FORMAT(d.Date, '%Y-%m-%d')<='"+tosqldate+"'";



			ResultSet resultSet1 = stmtMAD.executeQuery(sql);
			RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
			// System.out.println("===sql===="+sql);

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA1;
	}
	
	public JSONArray detailsgridExcel(String brhid,String frmdate,String todate,String doc_no,String dtype,String type) throws SQLException {
		Connection conn=null;
		JSONArray RESULTDATA1=new JSONArray();

		try {
			String sql = null;
			String condition="";
			String sql1 = "",sql2 = "";
			Date frmsqldate=ClsCommon.changeStringtoSqlDate(frmdate);
			Date tosqldate=ClsCommon.changeStringtoSqlDate(todate);

			if(!((doc_no.equalsIgnoreCase("")) || (doc_no.equalsIgnoreCase("0")))){
				sql1=sql1+" and d.doc_no="+doc_no+"";
			}
			if(!((dtype.equalsIgnoreCase("")) || (dtype.equalsIgnoreCase("0")))){
				sql1=sql1+" and d.dtype='"+dtype+"'";
			}
			
			if((type.equals("ALL"))){
				   sql1=sql1+"";
				  }
				
			else if(( type.equals("InSystem"))){
				   sql1=sql1+"and d.status=3";
				  }
			else if((type.equals("Deleted"))){
				   sql1=sql1+"and d.status=7";
				  }
			else{
				
			}
			conn = ClsConnection.getMyConnection();
			Statement stmtMAD = conn.createStatement();

			String select1=",",join1="";
			String sqldetails="select select1,join1 from my_attachname;";
			ResultSet rsdetails= stmtMAD.executeQuery(sqldetails);
			while(rsdetails.next()){
				select1+=rsdetails.getString("select1");
				join1=rsdetails.getString("join1");
			}
			
			/*sql = "select DATE_FORMAT(d.apprDate, '%d/%m/%y') as adate,d.doc_no,d.userid,d.brhid,u.user_name,b.branchname,d.dtype,d.remarks,apprlevel,if(d.apprStatus=5,'Forwarded ',if(d.apprStatus=3,'Approved',if(d.apprStatus=2,'Returned ',if(d.apprStatus=4,'Rejected ',if(d.apprStatus=1,'Submitted ',' Send'))))) apprtype,d.apprstatus from my_exdet d left join my_brch "
						+ "b on(d.brhid=b.doc_no) left join my_user u on(d.userid=u.doc_no) left join my_exeopt o on (o.doc_no=d.apprstatus) where 1=1 "+sql1+" and DATE_FORMAT(d.apprDate, '%Y-%m-%d')>='"+frmsqldate+"' and DATE_FORMAT(d.apprDate, '%Y-%m-%d')<='"+tosqldate+"' group by doc_no,apprlevel having max(apprlevel)" ;
			 */
			sql="select  b.branchname 'BRANCH',d.dtype  'DTYPE',d.doc_no 'DOCNO',d.descpt  'DESCRIPTION', a.type_name 'TYPE',d.filename 'FILENAME',d.user 'USER',DATE_FORMAT(d.date, '%d.%m.%Y') as 'DATE' "+select1
				+ " from my_fileattach d left join my_attach_type a on(d.ref_id=a.doc_no) left join my_brch b on(d.brhid=b.doc_no)"+join1+" where 1=1 "+sql1+" and DATE_FORMAT(d.Date, '%Y-%m-%d')>='"+frmsqldate+"' "
				+ " and DATE_FORMAT(d.Date, '%Y-%m-%d')<='"+tosqldate+"'";



			ResultSet resultSet1 = stmtMAD.executeQuery(sql);
			RESULTDATA1=ClsCommon.convertToEXCEL(resultSet1);
			System.out.println("===sql===="+sql);

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA1;
	}
}
