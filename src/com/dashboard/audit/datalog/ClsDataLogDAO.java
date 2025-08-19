package com.dashboard.audit.datalog;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDataLogDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public JSONArray getLogData(String branch,String fromdate,String todate,String id,String hiduser,String hidform,String value) throws SQLException {
		    String strSql="";String joins="";String casestatement="";
		    JSONArray RESULTDATA=new JSONArray();
		    if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}   
		    Connection  conn = null;
			java.sql.Date sqlfromdate=null,sqltodate=null;
	           try {
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				if(sqlfromdate!=null){
					sqltest+=" and DATE(t.edate)>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and DATE(t.edate)<='"+sqltodate+"'";
				}
				
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqltest+=" and t.brhid="+branch+"";
				}
				if(!hiduser.equalsIgnoreCase("")){
					sqltest+=" and t.userid="+hiduser;
				}
				
				
					conn=ClsConnection.getMyConnection();
					Statement stmtmanual = conn.createStatement ();
					
					if(value.equalsIgnoreCase("formbtn")){
						
						if(!hidform.equalsIgnoreCase("")){
								if(hidform.equalsIgnoreCase("5")){
									sqltest+=" and t.dtype='INT'";
								}
								else if(hidform.equalsIgnoreCase("6")){
									sqltest+=" and t.dtype='INS'";
								}
								else{
									sqltest+=" and menu.mno="+hidform;
								}
								
							}
						
						joins=ClsCommon.getFinanceVocTablesJoins(conn);
						casestatement=ClsCommon.getFinanceVocTablesCase(conn);
						
						/*strSql="select case when dat.dtype in ('INV','INS','INT') then inv.voc_no when dat.dtype='RAG' then rag.voc_no when dat.dtype='RAC' then"+
								" rac.voc_no when dat.dtype='LAG' then lag.voc_no when dat.dtype='LAC' then lac.voc_no else dat.doc_no end doc_no,br.branchname,"+
								" dat.dtype,case when dat.dtype='INT' then 'Invoice Traffic' when dat.dtype='INS' then 'Invoice Salik' else menu.menu_name end formname,usr.user_name user,case when dat.entry='A' then 'Add' when dat.entry='E' then 'Edit' when dat.entry='D' then"+
								" 'Delete' when dat.entry='R' then 'Release' else dat.entry end action,dat.edate date from datalog dat left join my_menu menu on"+
								" dat.dtype=menu.doc_type  left join my_user usr on dat.userid=usr.doc_no left join my_brch br on dat.brhid=br.doc_no left join"+
								" gl_ragmt rag on (dat.dtype='RAG' and dat.doc_no=rag.doc_no) left join gl_ragmtclosem rac on (dat.dtype='RAC' and"+
								" dat.doc_no=rac.doc_no) left join gl_lagmt lag on (dat.dtype='LAG' and dat.doc_no=lag.doc_no) left join gl_lagmtclosem lac on"+
								" (dat.dtype='LAC' and dat.doc_no=lac.doc_no) left join gl_invm inv on"
								+ " (dat.dtype in ('INV','INS','INT') and dat.doc_no=inv.doc_no) where 1=1 "+sqltest;*/
						
						strSql="select "+casestatement+"a.branchname, a.transtype, case when a.transtype='BINV' then 'Branch Invoice' when a.transtype='CINV' then 'Cash Invoice' when a.transtype='RINV' then 'Credit Invoice' "
								+ "else a.formname end as formname, a.user, a.action, a.date from ( select t.doc_no transNo,br.branchname,"
								+ "t.dtype transType,t.brhid,case when t.dtype='INT' then 'Invoice Traffic' when t.dtype='INS' then 'Invoice Salik' else menu.menu_name end formname,"
								+ "usr.user_name user,CONVERT(case when t.entry='A' then 'Add' when t.entry='E' then 'Edit' when t.entry='D' then 'Delete' when t.entry='R' then 'Release'  when t.entry='X' then 'Exchange' when t.entry='C' then 'Cancel' "
								+ "else t.entry end,CHAR(25)) action,t.edate date from datalog t left join my_menu menu on t.dtype=menu.doc_type  left join my_user usr on t.userid=usr.doc_no "
								+ "left join  my_brch br on t.brhid=br.doc_no where 1=1 "+sqltest+") a"+joins+"";
						
					 }
					 else if(value.equalsIgnoreCase("bibtn")){
						 if(!hidform.equalsIgnoreCase("")){
								
									sqltest+=" and menu.doc_no="+hidform;
								}
			
						 strSql="select t.doc_no transno,br.branchname, t.dtype transtype,case when t.dtype='INT' then 'Invoice Traffic' "+
								"  when t.dtype='INS' then 'Invoice Salik' else menu.description end formname, "+
								" usr.user_name user,CONVERT(case when t.entry='A' then 'Add' when t.entry='E' "+
								" then 'Edit' when t.entry='D' then 'Delete' when t.entry='R' then 'Release' "+
								" when t.entry='X' then 'Exchange' when t.entry='C' then 'Cancel' "+
								 " else t.entry end,CHAR(25)) action,t.edate date "+
								  " from gl_biblog t left join "+
								 " gl_bibd menu on t.dtype=menu.dtype "+
								 " left join my_user usr on t.userid=usr.doc_no "+
								 " left join my_brch br on t.brhid=br.doc_no "+
								  " where 1=1   "+sqltest ;
					 }
					System.out.println(strSql);
					ResultSet resultSet = stmtmanual.executeQuery (strSql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtmanual.close();
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

	
	public JSONArray getLogExcelData(String branch,String fromdate,String todate,String id,String hiduser,String hidform,String value) throws SQLException {
		 String strSql="";String joins="";String casestatement="";
		    JSONArray RESULTDATA=new JSONArray();
		    if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}   
		    Connection  conn = null;
			java.sql.Date sqlfromdate=null,sqltodate=null;
	           try {
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				if(sqlfromdate!=null){
					sqltest+=" and t.edate>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and t.edate<='"+sqltodate+"'";
				}
				
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqltest+=" and t.brhid="+branch+"";
				}
				if(!hiduser.equalsIgnoreCase("")){
					sqltest+=" and t.userid="+hiduser;
				}
				
				
					conn=ClsConnection.getMyConnection();
					Statement stmtmanual = conn.createStatement ();
					
					if(value.equalsIgnoreCase("formbtn")){
						
						if(!hidform.equalsIgnoreCase("")){
								if(hidform.equalsIgnoreCase("5")){
									sqltest+=" and t.dtype='INT'";
								}
								else if(hidform.equalsIgnoreCase("6")){
									sqltest+=" and t.dtype='INS'";
								}
								else{
									sqltest+=" and menu.mno="+hidform;
								}
								
							}
						
						joins=ClsCommon.getFinanceVocTablesJoins(conn);
						casestatement=ClsCommon.getFinanceVocTablesCase(conn);
						
					/*strSql="select case when dat.dtype in ('INV','INS','INT') then inv.voc_no when dat.dtype='RAG' then rag.voc_no when dat.dtype='RAC' then"+
							" rac.voc_no when dat.dtype='LAG' then lag.voc_no when dat.dtype='LAC' then lac.voc_no else dat.doc_no end doc_no,br.branchname,"+
							" dat.dtype,case when dat.dtype='INT' then 'Invoice Traffic' when dat.dtype='INS' then 'Invoice Salik' else menu.menu_name end formname,usr.user_name user,case when dat.entry='A' then 'Add' when dat.entry='E' then 'Edit' when dat.entry='D' then"+
							" 'Delete' when dat.entry='R' then 'Release' else dat.entry end action,dat.edate date from datalog dat left join my_menu menu on"+
							" dat.dtype=menu.doc_type  left join my_user usr on dat.userid=usr.doc_no left join my_brch br on dat.brhid=br.doc_no left join"+
							" gl_ragmt rag on (dat.dtype='RAG' and dat.doc_no=rag.doc_no) left join gl_ragmtclosem rac on (dat.dtype='RAC' and"+
							" dat.doc_no=rac.doc_no) left join gl_lagmt lag on (dat.dtype='LAG' and dat.doc_no=lag.doc_no) left join gl_lagmtclosem lac on"+
							" (dat.dtype='LAC' and dat.doc_no=lac.doc_no) left join gl_invm inv on"
							+ " (dat.dtype in ('INV','INS','INT') and dat.doc_no=inv.doc_no) where 1=1 "+sqltest;*/
					
					strSql="select "+casestatement+"a.branchname, a.transtype, a.formname, a.user, a.action, a.date from ( select t.doc_no transNo,br.branchname,"
							+ "t.dtype transType,t.brhid,case when t.dtype='INT' then 'Invoice Traffic' when t.dtype='INS' then 'Invoice Salik' else menu.menu_name end formname,"
							+ "usr.user_name user,CONVERT(case when t.entry='A' then 'Add' when t.entry='E' then 'Edit' when t.entry='D' then 'Delete' when t.entry='R' then 'Release'   when t.entry='X' then 'Exchange' when t.entry='C' then 'Cancel' "
							+ "else t.entry end,CHAR(25)) action,t.edate date from datalog t left join my_menu menu on t.dtype=menu.doc_type  left join my_user usr on t.userid=usr.doc_no "
							+ "left join  my_brch br on t.brhid=br.doc_no where 1=1 "+sqltest+") a"+joins+"";
					
					 }
					 else if(value.equalsIgnoreCase("bibtn")){
						 if(!hidform.equalsIgnoreCase("")){
								
									sqltest+=" and menu.doc_no="+hidform;
								}
			
						 strSql="select t.doc_no transno,br.branchname, t.dtype transtype,case when t.dtype='INT' then 'Invoice Traffic' "+
								"  when t.dtype='INS' then 'Invoice Salik' else menu.description end formname, "+
								" usr.user_name user,CONVERT(case when t.entry='A' then 'Add' when t.entry='E' "+
								" then 'Edit' when t.entry='D' then 'Delete' when t.entry='R' then 'Release' "+
								" when t.entry='X' then 'Exchange' when t.entry='C' then 'Cancel' "+ 
								" else t.entry end,CHAR(25)) action,t.edate date "+
								  " from gl_biblog t left join "+
								 " gl_bibd menu on t.dtype=menu.dtype "+
								 " left join my_user usr on t.userid=usr.doc_no "+
								 " left join my_brch br on t.brhid=br.doc_no "+
								  " where 1=1   "+sqltest ;
					 }
					 
				
					ResultSet resultSet = stmtmanual.executeQuery (strSql);
					RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
					stmtmanual.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println("RESULTDATA=========>"+RESULTDATA);
		    return RESULTDATA;
		}

	
	
	
	
	
	public JSONArray getUser(String check) throws SQLException {
			String strSql="";
		    JSONArray RESULTDATA=new JSONArray();
		    if(!(check.trim().equalsIgnoreCase("1"))){
		    	return RESULTDATA;
		    }
		    Connection  conn = null;
	        try {
				conn=ClsConnection.getMyConnection();
				Statement stmtuser = conn.createStatement ();
				
				strSql="select user_name user,doc_no from my_user where status=3";
				ResultSet resultSet = stmtuser.executeQuery (strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtuser.close();
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
	
	public JSONArray getForm(String check) throws SQLException {
		String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    if(!(check.equalsIgnoreCase("1")))
	    {
	    	return RESULTDATA;
	    }
	    Connection  conn = null;
        try {
			conn=ClsConnection.getMyConnection();
			Statement stmtuser = conn.createStatement ();
			
			strSql="select mno,menu_name menu from my_menu where pmenu<>0 and gate='E' and func<>'' ";
			ResultSet resultSet = stmtuser.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtuser.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	public JSONArray getForm1(String check) throws SQLException {
		String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    if(!(check.equalsIgnoreCase("1")))
	    {
	    	return RESULTDATA;
	    }
	    Connection  conn = null;
        try {
			conn=ClsConnection.getMyConnection();
			Statement stmtuser = conn.createStatement ();
			
			strSql="select doc_no,description from gl_bibd where status='1'";
			ResultSet resultSet = stmtuser.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtuser.close();
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
	
	public JSONArray subDetails(String branch,String fromdate,String todate,String id,String hiduser,String hidform,String value) throws SQLException {

		 	String strSql="";String joins="";String casestatement="";
		    JSONArray RESULTDATA=new JSONArray();
		    if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}   
		    Connection  conn = null;
			java.sql.Date sqlfromdate=null,sqltodate=null;
	           try {
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				if(sqlfromdate!=null){
					sqltest+=" and DATE(t.edate)>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and DATE(t.edate)<='"+sqltodate+"'";
				}
				
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqltest+=" and t.brhid="+branch+"";
				}
				if(!hiduser.equalsIgnoreCase("")){
					sqltest+=" and t.userid="+hiduser;
				}
				
				
					conn=ClsConnection.getMyConnection();
					Statement stmtmanual = conn.createStatement ();
					
					if(value.equalsIgnoreCase("formbtn")){
						
						if(!hidform.equalsIgnoreCase("")){
								if(hidform.equalsIgnoreCase("5")){
									sqltest+=" and t.dtype='INT'";
								}
								else if(hidform.equalsIgnoreCase("6")){
									sqltest+=" and t.dtype='INS'";
								}
								else{
									sqltest+=" and menu.mno="+hidform;
								}
								
							}
						
						joins=ClsCommon.getFinanceVocTablesJoins(conn);
						casestatement=ClsCommon.getFinanceVocTablesCase(conn);
						
					/*strSql="select case when dat.dtype in ('INV','INS','INT') then inv.voc_no when dat.dtype='RAG' then rag.voc_no when dat.dtype='RAC' then"+
							" rac.voc_no when dat.dtype='LAG' then lag.voc_no when dat.dtype='LAC' then lac.voc_no else dat.doc_no end doc_no,br.branchname,"+
							" dat.dtype,case when dat.dtype='INT' then 'Invoice Traffic' when dat.dtype='INS' then 'Invoice Salik' else menu.menu_name end formname,count(*) count,usr.user_name user,case when dat.entry='A' then 'Add' when dat.entry='E' then 'Edit' when dat.entry='D' then"+
							" 'Delete' when dat.entry='R' then 'Release' else dat.entry end action,dat.edate date from datalog dat left join my_menu menu on"+
							" dat.dtype=menu.doc_type  left join my_user usr on dat.userid=usr.doc_no left join my_brch br on dat.brhid=br.doc_no left join"+
							" gl_ragmt rag on (dat.dtype='RAG' and dat.doc_no=rag.doc_no) left join gl_ragmtclosem rac on (dat.dtype='RAC' and"+
							" dat.doc_no=rac.doc_no) left join gl_lagmt lag on (dat.dtype='LAG' and dat.doc_no=lag.doc_no) left join gl_lagmtclosem lac on"+
							" (dat.dtype='LAC' and dat.doc_no=lac.doc_no) left join gl_invm inv on"
							+ " (dat.dtype in ('INV','INS','INT') and dat.doc_no=inv.doc_no) where 1=1 "+sqltest+" group by usr.doc_no ";*/
					
					strSql="select b.*,count(*) count from ( select "+casestatement+"a.branchname, a.transtype, a.formname, a.user, a.action, a.date, a.userid from ( select t.doc_no transNo,br.branchname,"
							+ "t.dtype transType,t.brhid,case when t.dtype='INT' then 'Invoice Traffic' when t.dtype='INS' then 'Invoice Salik' else menu.menu_name end formname,"
							+ "usr.user_name user,CONVERT(case when t.entry='A' then 'Add' when t.entry='E' then 'Edit' when t.entry='D' then 'Delete' when t.entry='R' then 'Release' "
							+ "else t.entry end,CHAR(25)) action,t.edate date,usr.doc_no userid from datalog t left join my_menu menu on t.dtype=menu.doc_type  left join my_user usr on t.userid=usr.doc_no "
							+ "left join  my_brch br on t.brhid=br.doc_no where 1=1 "+sqltest+") a"+joins+") b group by b.userid";
					
					 }
					 else if(value.equalsIgnoreCase("bibtn")){
						 if(!hidform.equalsIgnoreCase("")){
								
									sqltest+=" and menu.doc_no="+hidform;
								}
			
						 strSql="select t.doc_no transno,br.branchname, t.dtype transtype,case when t.dtype='INT' then 'Invoice Traffic' "+
								"  when t.dtype='INS' then 'Invoice Salik' else menu.description end formname, "+
								"count(*) count, usr.user_name user,CONVERT(case when t.entry='A' then 'Add' when t.entry='E' "+
								" then 'Edit' when t.entry='D' then 'Delete' when t.entry='R' then 'Release' "+
								 " else t.entry end,CHAR(25)) action,t.edate date "+
								  " from gl_biblog t left join "+
								 " gl_bibd menu on t.dtype=menu.dtype "+
								 " left join my_user usr on t.userid=usr.doc_no "+
								 " left join my_brch br on t.brhid=br.doc_no "+
								  " where 1=1   "+sqltest+" group by usr.doc_no "; 
					 }
					 
				
					ResultSet resultSet = stmtmanual.executeQuery(strSql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtmanual.close();
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

	
}
