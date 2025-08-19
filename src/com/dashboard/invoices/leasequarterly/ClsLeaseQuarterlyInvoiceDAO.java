package com.dashboard.invoices.leasequarterly;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.common.ClsCommon;
import com.common.ClsLeaseInvoiceCalc;
import com.common.ClsRentalInvoiceCalc;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsLeaseQuarterlyInvoiceDAO {

	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	ClsLeaseInvoiceCalc leasecalc=new ClsLeaseInvoiceCalc();
	public  JSONArray getLeaseQuarterlyInvoice(String temp,String desc1,String date1,String branchvalue,String client,String mode) throws SQLException {
//		List<ClsRentalInvoiceBean> rentalBean = new ArrayList<ClsRentalInvoiceBean>();
		JSONArray RESULTDATA=new JSONArray();
		if(!mode.equalsIgnoreCase("2")){
			return RESULTDATA;
		}
        java.sql.Date sqldate=null;
        if(!(date1.equalsIgnoreCase(""))){
        	sqldate=objcommon.changeStringtoSqlDate(date1);
        }
        
        Connection  conn =null;
		try {
			conn=objconn.getMyConnection();
			//System.out.println("Here");
			//System.out.println("Branch Value"+branchvalue);
			String sqltest="";
			String sqlbranch="";
			if(!(branchvalue.equalsIgnoreCase(""))){
				sqlbranch=" and agmt.brhid="+branchvalue;
			}
			String sqlclient="";
			if(!(client.equalsIgnoreCase(""))){
				sqlclient=" and agmt.cldocno="+client;
			}
			if(desc1.equalsIgnoreCase("Period (M) Adv")){
				sqltest=" and agmt.adv_chk=1 and agmt.inv_type=3 and agmt.invdate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
				
			}
			if(desc1.equalsIgnoreCase("Period (M)")){
				sqltest=" and agmt.adv_chk=0 and agmt.inv_type=3 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
				
			}
			//System.out.println("DESC1:"+desc1);
			
				
				Statement stmtDashBoard = conn.createStatement ();
				/*String strduedatecal="select method from gl_config where field_nme='duedatecal'";
				int duedatecal=0;
				ResultSet rsduedate=stmtDashBoard.executeQuery(strduedatecal);
				while(rsduedate.next()){
					duedatecal=rsduedate.getInt("method");
				}*/
				String strSql="select agmt.doc_no rano,'Monthly' ratype,agmt.voc_no,agmt.inv_type invtype,agmt.invdate fromdate,ac.cldocno,ac.acno,head.account,head.description acname,"+
						" agmt.invtodate todate,agmt.brhid,if(inv_type=1,"+
						" DATEDIFF((select todate),(select fromdate)),DATEDIFF((select todate),(select fromdate))) datediff  from gl_lagmt agmt left join"+
						" gl_ltarif tarif on (agmt.doc_no=tarif.rdocno) inner join my_acbook ac on (agmt.cldocno=ac.cldocno and"+
						" ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no where 1=1 "+sqltest+" "+sqlclient+" order by agmt.voc_no";
            	
				System.out.println(strSql);
				ResultSet resultSet = stmtDashBoard.executeQuery (strSql);
        		RESULTDATA=objcommon.convertToJSON(resultSet);
				java.sql.Date fromdate=null,todate=null;
				
				stmtDashBoard.close();
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
        return RESULTDATA;
    }
	
	
	public  JSONArray getInvoiceno(String date1,String branchvalue,String client,String status) throws SQLException {
		//System.out.println("Inside Invno");
		JSONArray RESULTDATA=new JSONArray();
		if(!status.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		if(branchvalue.equalsIgnoreCase("NA") || branchvalue.equalsIgnoreCase("a")){
			return RESULTDATA;
		}
        java.sql.Date sqldate=null;
        if(!(date1.equalsIgnoreCase("NA"))){
        	sqldate=objcommon.changeStringtoSqlDate(date1);
        }
        
       Connection conn =null;
		try {
			conn=objconn.getMyConnection();
			//System.out.println("Here");
			String sqltest="";
			String sqlclient="";
			String sqlconfig="";
			if(!(client.equalsIgnoreCase(""))){
				sqlclient=" and agmt.cldocno="+client;
			}
			if(!(branchvalue.equalsIgnoreCase(""))){
				sqltest=" and agmt.brhid="+branchvalue;
			}
				Statement stmtDashBoard = conn.createStatement ();
				String strSql="select srno,desc1,sum(value) value from("+
            			" select 1 srno,'Period (M) Adv' desc1,count(*) value from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno "+
            			" ) where agmt.adv_chk=1 and agmt.inv_type=3 and agmt.invdate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqltest+" "+sqlclient+" union all"+
            			" select 2 srno,'Period (M)' desc1,count(*) value from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno "+
            			" ) where agmt.adv_chk=0 and agmt.inv_type=3 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqltest+" "+sqlclient+" "+sqlconfig+") as a group by srno";
            	System.out.println("Inv No Sql"+strSql);
				ResultSet resultSet = stmtDashBoard.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
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
	
	
	public  JSONArray getTotaldata(String temp,String desc1,String date1,String branchvalue,String client,String mode) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!mode.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
        java.sql.Date sqldate=null;
        if(!(date1.equalsIgnoreCase("NA"))){
        	sqldate=objcommon.changeStringtoSqlDate(date1);
        }
        
        Connection  conn =null;
		try {
			conn=objconn.getMyConnection();
			String sqltest="";
			String sqlbranch="";
			if(!(branchvalue.equalsIgnoreCase(""))){
				sqlbranch=" and agmt.brhid="+branchvalue;
			}
			String sqlclient="";
			if(!(client.equalsIgnoreCase(""))){
				sqlclient=" and agmt.cldocno="+client;
			}
			//System.out.println("DESC1:"+desc1);
			
			if(desc1.equalsIgnoreCase("Period (M) Adv")){
				sqltest=" and agmt.adv_chk=1 and agmt.inv_type=3 and agmt.invdate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
				
			}
			if(desc1.equalsIgnoreCase("Period (M)")){
				sqltest=" and agmt.adv_chk=0 and agmt.inv_type=3 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
				
			}
				
				Statement stmtDashBoard = conn.createStatement ();
				
				String strSql="select 0 duedatecal ,head.curid,agmt.doc_no rano,agmt.voc_no,'LAG' ratype,agmt.inv_type invtype,agmt.invdate fromdate,ac.cldocno,ac.acno,head.account,head.description acname,"+
						" agmt.invtodate todate,agmt.brhid,if(inv_type=1,"+
						" DATEDIFF((select todate),(select fromdate)),DATEDIFF((select todate),(select fromdate))) datediff  from gl_lagmt agmt left join"+
						" gl_ltarif tarif on (agmt.doc_no=tarif.rdocno) inner join my_acbook ac on (agmt.cldocno=ac.cldocno and"+
						" ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no where 1=1  "+sqltest+" "+sqlclient+" order by agmt.voc_no";
     
				double finalamt=0.0;
             	ArrayList<Double> invoicearray=new ArrayList<>();
				ArrayList<Double> salikarray=new ArrayList<>();
				ArrayList<String> newarray=new ArrayList<>();
             	ResultSet resultSet = stmtDashBoard.executeQuery(strSql);
             	while(resultSet.next()){
             		invoicearray=leasecalc.getInvoiceCalc(resultSet.getString("rano"), resultSet.getString("cldocno"), resultSet.getDate("fromdate"), resultSet.getDate("todate"), resultSet.getString("ratype"), resultSet.getString("invtype"));
             		salikarray=objcommon.getSalik(resultSet.getDate("fromdate"), resultSet.getDate("todate"), resultSet.getString("cldocno"), resultSet.getString("rano"), "LAG");
             		
             		for(int i=0;i<4;i++){
                 		finalamt+=salikarray.get(i);
                 	}
                 	for(int i=0;i<invoicearray.size();i++){
                 		finalamt+=invoicearray.get(i);
                 	}
             		newarray.add(resultSet.getString("rano")+"::"+resultSet.getString("voc_no")+"::"+resultSet.getString("ratype")+"::"+
             		resultSet.getDate("fromdate")+"::"+resultSet.getDate("todate")+"::"+resultSet.getString("acno")+"::"+resultSet.getString("acname")+"::"+finalamt+"::"+
             		resultSet.getString("cldocno")+"::"+invoicearray.get(0)+"::"+invoicearray.get(1)+"::"+salikarray.get(0)+"::"+salikarray.get(1)+"::"+salikarray.get(2)+"::"+
             		salikarray.get(3)+"::"+resultSet.getString("datediff")+"::"+resultSet.getString("brhid")+"::"+resultSet.getString("curid")+"::"+invoicearray.get(2)+"::"+
             		resultSet.getString("invtype")+"::"+salikarray.get(4)+"::"+salikarray.get(5)+"::"+salikarray.get(6)+"::"+salikarray.get(7)+"::"+resultSet.getString("account")+"::"+resultSet.getString("duedatecal"));
             	
             		invoicearray=new ArrayList<>();
             		salikarray=new ArrayList<>();
             		finalamt=0.0;
             	}
             	RESULTDATA=convertArrayToJSON(newarray);
				stmtDashBoard.close();
				conn.close();
				return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;

	}
	

	public  JSONArray convertArrayToJSON(ArrayList<String> newarray) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < newarray.size(); i++) {
			
			JSONObject obj = new JSONObject();
			

			obj.put("rano",newarray.get(i).split("::")[0]);
			obj.put("voc_no",newarray.get(i).split("::")[1]);
			obj.put("ratype",newarray.get(i).split("::")[2]);
			obj.put("fromdate",newarray.get(i).split("::")[3]);
			obj.put("todate",newarray.get(i).split("::")[4]);
			obj.put("acno",newarray.get(i).split("::")[5]);
			obj.put("acname",newarray.get(i).split("::")[6]);
			obj.put("amount",newarray.get(i).split("::")[7]);
			obj.put("cldocno",newarray.get(i).split("::")[8]);
			obj.put("rentalsum",newarray.get(i).split("::")[9]);
			obj.put("accsum",newarray.get(i).split("::")[10]);
			obj.put("salikamt",newarray.get(i).split("::")[11]);
			obj.put("trafficamt",newarray.get(i).split("::")[12]);
			obj.put("saliksrvc",newarray.get(i).split("::")[13]);
			obj.put("trafficsrvc",newarray.get(i).split("::")[14]);
			obj.put("datediff",newarray.get(i).split("::")[15]);
			obj.put("brhid",newarray.get(i).split("::")[16]);
			obj.put("curid",newarray.get(i).split("::")[17]);
			obj.put("insurchg",newarray.get(i).split("::")[18]);
			obj.put("inv_type",newarray.get(i).split("::")[19]);
			obj.put("salikcount",newarray.get(i).split("::")[20]);
			obj.put("trafficcount",newarray.get(i).split("::")[21]);
			obj.put("salamount",newarray.get(i).split("::")[22]);
			obj.put("salrate",newarray.get(i).split("::")[23]);
			obj.put("account", newarray.get(i).split("::")[24]);
			obj.put("duedatecal", newarray.get(i).split("::")[25]);

			jsonArray.add(obj);
		}
		
		
		return jsonArray;
		}
	
}
