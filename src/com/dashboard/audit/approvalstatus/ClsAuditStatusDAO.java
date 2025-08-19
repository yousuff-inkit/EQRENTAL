package com.dashboard.audit.approvalstatus;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;

public class ClsAuditStatusDAO  {
	ClsConnection ClsConnection=new ClsConnection();      
	ClsCommon ClsCommon=new ClsCommon();
    
public JSONArray mainfollow(String fromdate,String todate,String barchval,String formname,String docno,String check) throws SQLException{  	 
	//System.out.println("egsssgbdf"+formname);
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		try {
			//if(barchval=="NA"){
				//return RESULTDATA;
				
			//}
			 conn = ClsConnection.getMyConnection();
			Statement stmtApp = conn.createStatement ();
			//System.out.println(barchval);
			 String sqlll="";
			    java.sql.Date sqlfromdate = null;
		        java.sql.Date sqltodate = null;
		       if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		     	}
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		     	}
			 if(!((formname.equalsIgnoreCase("")) || (formname.equalsIgnoreCase("0")))){
		    	 sqlll +=" and t.dtype='"+formname+"'";
	    	 }

		    
			 if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")))){
		    	 sqlll +=sqlll+" and t.brhid="+barchval+"";
	    	 }
		     if(!((docno.equalsIgnoreCase("")) || (docno.equalsIgnoreCase("0")))){
		    	 	sqlll=sqlll+" and t.doc_no='"+docno+"'";
             }
			if(check.equalsIgnoreCase("1")){
			String sql="",select1="",join1="",sqll="";
			int i=0;
			sql= "select * from win_tbldet where dtype='"+formname+"'";
			ResultSet resultSet=stmtApp.executeQuery(sql);
			while(resultSet.next()){
				select1=resultSet.getString("select1");
				join1=resultSet.getString("join1");  
			}
			if(select1!=null && join1!=null){
			sqll="Select t.remarks as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,if(t.apprStatus=1,'Submitted',if(t.apprStatus=9,'Returned document',if(t.apprStatus=3,'Approved',if(t.apprStatus=4,'Rejected','')))) status,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
	      				+ " DATE_FORMAT(t.apprdate,'%d.%m.%Y %H:%i:%s') subdatetime,"
	       				+ " u.user_name  "+select1
	       				+ " from  my_exdet t  inner join (select max(sr_no) srno from my_exdet group by dtype,doc_no) t1  on t.sr_no=t1.srno   inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
	       				+join1 +" where 1=1 and date(t.apprdate) between '"+sqlfromdate+"' and '"+sqltodate+"'  "+sqlll + " order by doc_no,apprlevel";

			}else{  
			sqll="Select t.remarks as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,if(t.apprStatus=1,'Submitted',if(t.apprStatus=9,'Returned document',if(t.apprStatus=3,'Approved',if(t.apprStatus=4,'Rejected','')))) status,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
      				+ " DATE_FORMAT(t.apprdate,'%d.%m.%Y %H:%i:%s') subdatetime,"
       				+ " u.user_name  "
       				+ " from  my_exdet t  inner join (select max(sr_no) srno from my_exdet group by dtype,doc_no) t1  on t.sr_no=t1.srno   inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
       				+" where 1=1 and date(t.apprdate) between '"+sqlfromdate+"' and '"+sqltodate+"'  "+sqlll + " order by doc_no,apprlevel";
			}
			// System.out.println("======summary========="+sqll);
			
			ResultSet result=stmtApp.executeQuery(sqll);
			RESULTDATA=ClsCommon.convertToJSON(result);
			}
			else if(check.equalsIgnoreCase("2")){
				String sql="",select1="",join1="",sqll="";
				sql= "select * from win_tbldet where dtype='"+formname+"'";
				ResultSet resultSet=stmtApp.executeQuery(sql);
				while(resultSet.next()){
					select1=resultSet.getString("select1");
					join1=resultSet.getString("join1");
				}
				/*sqll="Select t.desc1 as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
	       				+ " CONVERT(concat(day(t.sub_Date),'/',month(t.sub_Date),'/',year(t.sub_Date),' ', time(t.sub_Date)),CHAR(50)) subdatetime,"
	       				+ " u.user_name   "+select1
	       				+ " from my_exeb t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no "
	       				+join1 +" where 2=2 and t.sub_date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlll+" union "
	       	       		+ "Select t.remarks as remarks,if(t.apprStatus=1,'Submitted',if(t.apprStatus=9,'Returned document',if(t.apprStatus=1,'Submitted',if(t.apprStatus=2,'First Level',if(t.apprStatus=3,'Second Level',if(t.apprStatus=4,'Final Level','')))))) level,t.apprStatus,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
	       	    	    + " CONVERT(concat(day(t.subDate),'/',month(t.subDate),'/',year(t.subDate),' ', time(t.subDate)),CHAR(50)) subdatetime,"
	       	       	    + " u.user_name  "+select1
	       	       	    + " from my_exdet t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
	       	       	    +join1 + " where 2=2 and t.subdate between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlll+ " order by doc_no,apprlevel" ;
           	*/
				if(select1!=null && join1!=null){
				sqll="Select t.desc1 as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,'Not Approved' status,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
	       				+ " DATE_FORMAT(t.sub_date,'%d.%m.%Y %H:%i:%s') subdatetime,"
	       				+ " u.user_name   "+select1
	       				+ " from my_exeb t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no "
	       				+join1 +" where 2=2 and date(t.sub_date) between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlll+" union "
	       	       		+ "Select t.remarks as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,if(t.apprStatus=1,'Submitted',if(t.apprStatus=9,'Returned document',if(t.apprStatus=3,'Approved',if(t.apprStatus=4,'Rejected','')))) status,t.apprStatus,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
	       	    	    + " DATE_FORMAT(t.subdate,'%d.%m.%Y %H:%i:%s') subdatetime,"
	       	       	    + " u.user_name  "+select1    
	       	       	    + " from my_exdet t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
	       	       	    +join1 + " where 2=2 and date(t.subdate) between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlll+ " order by doc_no,apprlevel" ;
				}else{  
					sqll="Select t.desc1 as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,'Not Approved' status,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
		       				+ " DATE_FORMAT(t.sub_date,'%d.%m.%Y %H:%i:%s') subdatetime,"
		       				+ " u.user_name   "
		       				+ " from my_exeb t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no "
		       				+" where 2=2 and date(t.sub_date) between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlll+" union "
		       	       		+ "Select t.remarks as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,if(t.apprStatus=1,'Submitted',if(t.apprStatus=9,'Returned document',if(t.apprStatus=3,'Approved',if(t.apprStatus=4,'Rejected','')))) status,t.apprStatus,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
		       	    	    + " DATE_FORMAT(t.subdate,'%d.%m.%Y %H:%i:%s') subdatetime,"
		       	       	    + " u.user_name  "    
		       	       	    + " from my_exdet t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
		       	       	    + " where 2=2 and date(t.subdate) between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlll+ " order by doc_no,apprlevel" ;
				}
				System.out.println("detail=========="+sqll);
				
				ResultSet result=stmtApp.executeQuery(sqll);
				RESULTDATA=ClsCommon.convertToJSON(result);
				
			}
			//System.out.println(RESULTDATA);
				stmtApp.close();
				conn.close();
}
catch(Exception e){
	e.printStackTrace();
	conn.close();	
}
//System.out.println(RESULTDATA);
return RESULTDATA;
	}
public JSONArray excelmainfollow(String fromdate,String todate,String barchval,String formname,String docno,String check) throws SQLException{  	 
	//System.out.println("egsssgbdf"+formname);
			JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;
			try {
				//if(barchval=="NA"){
					//return RESULTDATA;
					
				//}
				 conn = ClsConnection.getMyConnection();
				Statement stmtApp = conn.createStatement ();
				//System.out.println(barchval);
				 String sqlll="";
				    java.sql.Date sqlfromdate = null;
			        java.sql.Date sqltodate = null;
			       if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
			     	{
			     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			     	}
			     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
			     	{
			     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			     	}
				 if(!((formname.equalsIgnoreCase("")) || (formname.equalsIgnoreCase("0")))){
			    	 sqlll +=" and t.dtype='"+formname+"'";
		    	 }

			    
				 if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")))){
			    	 sqlll +=sqlll+" and t.brhid="+barchval+"";
		    	 }
			     if(!((docno.equalsIgnoreCase("")) || (docno.equalsIgnoreCase("0")))){
			    	 	sqlll=sqlll+" and t.doc_no='"+docno+"'";
	             }
				if(check.equalsIgnoreCase("1")){
				String sql="",select1="",join1="",sqll="";
				int i=0;
				sql= "select * from win_tbldet where dtype='"+formname+"'";
				ResultSet resultSet=stmtApp.executeQuery(sql);
				while(resultSet.next()){
					select1=resultSet.getString("select1");
					join1=resultSet.getString("join1");  
				}
				if(select1!=null && join1!=null){
				sqll="Select t.remarks as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,if(t.apprStatus=1,'Submitted',if(t.apprStatus=9,'Returned document',if(t.apprStatus=3,'Approved',if(t.apprStatus=4,'Rejected','')))) status,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
		      				+ " DATE_FORMAT(t.apprdate,'%d.%m.%Y %H:%i:%s') subdatetime,"
		       				+ " u.user_name  "+select1
		       				+ " from  my_exdet t  inner join (select max(sr_no) srno from my_exdet group by dtype,doc_no) t1  on t.sr_no=t1.srno   inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
		       				+join1 +" where 1=1 and date(t.apprdate) between '"+sqlfromdate+"' and '"+sqltodate+"'  "+sqlll + " order by doc_no,apprlevel";

				}else{  
				sqll="Select t.remarks as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,if(t.apprStatus=1,'Submitted',if(t.apprStatus=9,'Returned document',if(t.apprStatus=3,'Approved',if(t.apprStatus=4,'Rejected','')))) status,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
	      				+ " DATE_FORMAT(t.apprdate,'%d.%m.%Y %H:%i:%s') subdatetime,"
	       				+ " u.user_name  "
	       				+ " from  my_exdet t  inner join (select max(sr_no) srno from my_exdet group by dtype,doc_no) t1  on t.sr_no=t1.srno   inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
	       				+" where 1=1 and date(t.apprdate) between '"+sqlfromdate+"' and '"+sqltodate+"'  "+sqlll + " order by doc_no,apprlevel";
				}
				//System.out.println("======summary========="+sqll);
				
				ResultSet result=stmtApp.executeQuery(sqll);
				RESULTDATA=ClsCommon.convertToJSON(result);
				}
				else if(check.equalsIgnoreCase("2")){
					String sql="",select1="",join1="",sqll="";
					sql= "select * from win_tbldet where dtype='"+formname+"'";
					ResultSet resultSet=stmtApp.executeQuery(sql);
					while(resultSet.next()){
						select1=resultSet.getString("select1");
						join1=resultSet.getString("join1");
					}
					/*sqll="Select t.desc1 as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
		       				+ " CONVERT(concat(day(t.sub_Date),'/',month(t.sub_Date),'/',year(t.sub_Date),' ', time(t.sub_Date)),CHAR(50)) subdatetime,"
		       				+ " u.user_name   "+select1
		       				+ " from my_exeb t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no "
		       				+join1 +" where 2=2 and t.sub_date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlll+" union "
		       	       		+ "Select t.remarks as remarks,if(t.apprStatus=1,'Submitted',if(t.apprStatus=9,'Returned document',if(t.apprStatus=1,'Submitted',if(t.apprStatus=2,'First Level',if(t.apprStatus=3,'Second Level',if(t.apprStatus=4,'Final Level','')))))) level,t.apprStatus,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
		       	    	    + " CONVERT(concat(day(t.subDate),'/',month(t.subDate),'/',year(t.subDate),' ', time(t.subDate)),CHAR(50)) subdatetime,"
		       	       	    + " u.user_name  "+select1
		       	       	    + " from my_exdet t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
		       	       	    +join1 + " where 2=2 and t.subdate between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlll+ " order by doc_no,apprlevel" ;
	           	*/
					if(select1!=null && join1!=null){
					sqll="Select t.desc1 as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,'Not Approved' status,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
		       				+ " DATE_FORMAT(t.sub_date,'%d.%m.%Y %H:%i:%s') subdatetime,"
		       				+ " u.user_name   "+select1
		       				+ " from my_exeb t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no "
		       				+join1 +" where 2=2 and date(t.sub_date) between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlll+" union "
		       	       		+ "Select t.remarks as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,if(t.apprStatus=1,'Submitted',if(t.apprStatus=9,'Returned document',if(t.apprStatus=3,'Approved',if(t.apprStatus=4,'Rejected','')))) status,t.apprStatus,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
		       	    	    + " DATE_FORMAT(t.subdate,'%d.%m.%Y %H:%i:%s') subdatetime,"
		       	       	    + " u.user_name  "+select1    
		       	       	    + " from my_exdet t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
		       	       	    +join1 + " where 2=2 and date(t.subdate) between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlll+ " order by doc_no,apprlevel" ;
					}else{  
						sqll="Select t.desc1 as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,'Not Approved' status,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
			       				+ " DATE_FORMAT(t.sub_date,'%d.%m.%Y %H:%i:%s') subdatetime,"
			       				+ " u.user_name   "
			       				+ " from my_exeb t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no "
			       				+" where 2=2 and date(t.sub_date) between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlll+" union "
			       	       		+ "Select t.remarks as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,if(t.apprStatus=1,'Submitted',if(t.apprStatus=9,'Returned document',if(t.apprStatus=3,'Approved',if(t.apprStatus=4,'Rejected','')))) status,t.apprStatus,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
			       	    	    + " DATE_FORMAT(t.subdate,'%d.%m.%Y %H:%i:%s') subdatetime,"
			       	       	    + " u.user_name  "    
			       	       	    + " from my_exdet t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
			       	       	    + " where 2=2 and date(t.subdate) between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlll+ " order by doc_no,apprlevel" ;
					}
					//System.out.println("detail=========="+sqll);
					
					ResultSet result=stmtApp.executeQuery(sqll);
					RESULTDATA=ClsCommon.convertToEXCEL(result);
					
				}
				//System.out.println(RESULTDATA);
					stmtApp.close();
					conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();	
	}
	//System.out.println(RESULTDATA);
	return RESULTDATA;
	}
public JSONArray Approvalsearch() throws SQLException{
	JSONArray RESULTDATA=new JSONArray();
	Connection conn=null;
			try{
				conn=ClsConnection.getMyConnection();
				Statement stmtAPP = conn.createStatement();
				String sql="",select1="",join1="",sqll="" ;
				sql = "select select1,join1 from win_tbldet where dtype='lqt' ";
				//System.out.println(sql);
				ResultSet resultSet= stmtAPP.executeQuery(sql);
				while(resultSet.next()){
					select1=resultSet.getString("select1");
					join1=resultSet.getString("join1");
				}
				
				sqll="select t.doc_no,t.dtype "+select1+" from my_exeb t "+join1 ;
				//System.out.println(sqll);
				ResultSet result=stmtAPP.executeQuery(sqll);
				
				RESULTDATA=ClsCommon.convertToJSON(result);
				//System.out.println(RESULTDATA);
 				stmtAPP.close();
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
