package com.dashboard.invoices.leasealmariah;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.common.ClsLeaseInvoiceCalc;
import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.ClsManualInvoiceBean;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;


public class ClsLeaseAlmariahInvoiceDAO {
	ClsLeaseInvoiceCalcAlmariah ClsLeaseInvoiceCalc=new ClsLeaseInvoiceCalcAlmariah();
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public  JSONArray getClient(HttpSession session,String clname,String mob,String lcno,String passno,String nation,String dob) throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
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
	     	
	    	
	    
	    	java.sql.Date sqlStartDate=null;
	    
	    	
	    	 dob.trim();
	    	if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("0")))
	    	{
	    	sqlStartDate = ClsCommon.changeStringtoSqlDate(dob);
	    	}
	    	
	    		
	    	
	    	//System.out.println("name"+clname);
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.RefName like '"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.per_mob='"+mob+"'";
	    	}
	    	if(!(lcno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.dlno='"+lcno+"'";
	    	}
	    	if(!(passno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.passport_no='"+passno+"'";
	    	}
	    	if(!(nation.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.nation like'"+nation+"%'";
	    	}
	    	 if(!(sqlStartDate==null)){
	    		sqltest=sqltest+" and d.dob='"+sqlStartDate+"'";
	    	} 
	        
	  
			try {
					
					Statement stmtVeh8 = conn.createStatement ();
	            	
					String clsql="select distinct a.cldocno,trim(a.RefName) RefName,a.per_mob,trim(a.address) address,a.codeno,a.acno,m.doc_no,trim(m.sal_name)"+
							" sal_name from gl_lagmt agmt left join my_acbook a on (agmt.cldocno=a.cldocno and a.dtype='CRM')left join my_salm m on"+
							" a.sal_id=m.doc_no and m.status<>7 join gl_drdetails d on d.cldocno=a.cldocno where a.brhid="+brid+"" +sqltest;
					//System.out.println("rental"+clsql);
					ResultSet resultSet = stmtVeh8.executeQuery(clsql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh8.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    
    }
	public  JSONArray getInvoiceno(String date1,String branchvalue,String client,String status,String agmtno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		if(!status.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
        Connection conn = ClsConnection.getMyConnection();
        java.sql.Date sqldate=null;
        if(!(date1.equalsIgnoreCase(""))){
        	sqldate=ClsCommon.changeStringtoSqlDate(date1);
        }
		try {
			//System.out.println("Here");
			String sqltest="";
			String sqlclient="";
				if(!(client.equalsIgnoreCase(""))){
				sqlclient+=" and agmt.cldocno="+client;
			}
			if(!(branchvalue.equalsIgnoreCase(""))){
				sqltest=" and agmt.brhid="+branchvalue;
			}
			if(!agmtno.equalsIgnoreCase("")){
				sqltest+=" and agmt.doc_no="+agmtno;
			}
				 
				Statement stmtDashBoard = conn.createStatement ();
            /*	String strSql="select 'Month End (M) Adv' desc1,count(*) value from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno)  where "
            			+ " agmt.adv_chk=1 and agmt.inv_type=1 and agmt.invdate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+" union"+
            			" select 'Month End (M)' desc1,count(*) value from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno ) where agmt.adv_chk=0 "
            			+ " and agmt.inv_type=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+" union"+            			
            			" select 'Period (M) Adv' desc1,count(*) value from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno ) where agmt.adv_chk=1 "
            			+ " and agmt.inv_type=2 and agmt.invdate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+" union"+
            			" select 'Period (M)' desc1,count(*) value from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno) where agmt.adv_chk=0 and "
            			+ "agmt.inv_type=2 and agmt.invtodate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+" ";
						*/
					String strSql="select srno,desc1,sum(value) value from("+
						" select 1 srno,'Month End (M) Adv' desc1,count(*) value,agmt.cldocno from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno)"+
						" where  agmt.adv_chk=1 and agmt.inv_type=1 and agmt.invdate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+""+
						" union all"+
						" select 2 srno,'Month End (M)' desc1,count(*) value,agmt.cldocno from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno )"+
						" where  agmt.adv_chk=0  and agmt.inv_type=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+""+
						" union all"+
						" select 3 srno,'Period (M) Adv' desc1,count(*) value,agmt.cldocno from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno )"+
						" where  agmt.adv_chk=1  and agmt.inv_type=2 and agmt.invdate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+""+
						" union all"+
						" select 4 srno,'Period (M)' desc1,count(*) value,agmt.cldocno from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno)"+
						" where   agmt.adv_chk=0 and agmt.inv_type=2 and agmt.invtodate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+""+
						" ) as a group by srno";	
            	// System.out.println("Inv No Sql"+strSql);
				ResultSet resultSet = stmtDashBoard.executeQuery (strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtDashBoard.close();
				conn.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
		conn.close();
		}
        return RESULTDATA;
		
    }
	public  JSONArray getLeaseInvoice(String temp,String desc1,String date1,String branchvalue,String client,String mode,String agmtno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		if(!mode.equalsIgnoreCase("2")){
			return RESULTDATA;
		}
        java.sql.Date sqldate=null;
        if(!(date1.equalsIgnoreCase(""))){
        	sqldate=ClsCommon.changeStringtoSqlDate(date1);
        }
        Connection conn = ClsConnection.getMyConnection();
		try {
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
			if(!agmtno.equalsIgnoreCase("")){
				sqlclient+=" and agmt.doc_no="+agmtno;
			}
			//System.out.println("DESC1:"+desc1);
			if(desc1.equalsIgnoreCase("Month End (M) Adv")){
				sqltest=" and agmt.adv_chk=1 and agmt.inv_type=1 and agmt.invdate<='"+sqldate+"' and clstatus=0  "+sqlbranch+"";
			
			}
			if(desc1.equalsIgnoreCase("Month End (M)")){
				sqltest=" and agmt.adv_chk=0 and agmt.inv_type=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+"";
			
			}
			
			if(desc1.equalsIgnoreCase("Period (M) Adv")){
				sqltest=" and agmt.adv_chk=1 and agmt.inv_type=2 and agmt.invdate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+"";
				
			}
			if(desc1.equalsIgnoreCase("Period (M)")){
				sqltest="and agmt.adv_chk=0 and agmt.inv_type=2 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+"";
				
			}
				
				Statement stmtDashBoard = conn.createStatement();
				String strtarifsum="";
				String strSql="select agmt.doc_no rano,agmt.voc_no,'Monthly' ratype,agmt.invdate fromdate,ac.cldocno,agmt.inv_type,ac.acno,head.account,head.description acname,"+
						" agmt.invtodate todate,agmt.brhid,brh.curid,if(inv_type=1,"+
						" DATEDIFF((select todate),(select fromdate)),DATEDIFF((select todate),(select fromdate))) datediff  from gl_lagmt agmt left join"+
						" gl_ltarif tarif on (agmt.doc_no=tarif.rdocno ) inner join my_acbook ac on (agmt.cldocno=ac.cldocno and"+
						" ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no left join my_brch brh on agmt.brhid=brh.doc_no where 1=1 "+sqltest+" "+sqlclient+" order by agmt.voc_no";
            	
            	System.out.println("Invoice SQL"+strSql);
             	ResultSet resultSet = stmtDashBoard.executeQuery(strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
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
	public ArrayList<String> checkFirstInvoice(int agmtno,int id) throws SQLException {
		ArrayList<String> firstinv=new ArrayList<>();
		double amount=0.0;
		int count=0;
		Connection conn=ClsConnection.getMyConnection();
		
		try {
			Statement stmt=conn.createStatement();
				String strgetamt="";
				if(id==1){
					strgetamt="select coalesce(sum(amount),0.0) amount,count(*) count from gl_lothser where invno=0 and invstatus=0 and rdocno="+agmtno;	
				}
				if(id==2){
					strgetamt="select coalesce(sum(amount),0.0) amount,count(*) count from gl_lothser where rdocno="+agmtno;
				}
				//System.out.println("Other Income Sql:"+strgetamt);
				ResultSet rsgetamt=stmt.executeQuery(strgetamt);
					if(rsgetamt.next()){
						amount=rsgetamt.getDouble("amount");
						count=rsgetamt.getInt("count");
					}
					firstinv.add(amount+"");
					firstinv.add(count+"");
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			
		}
		
		return firstinv;
	}
	
	
	public int getAdvance(int agmtno, Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		int advchk=0;
		try{
			Statement stmt=conn.createStatement();
			String strchk="select adv_chk from gl_lagmt where doc_no="+agmtno;
			ResultSet rschk=stmt.executeQuery(strchk);
			
			if(rschk.next()){
				advchk=rschk.getInt("adv_chk");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return advchk;
	}
	/*public double getChauffercharge(int agmtno,java.sql.Date invdate,java.sql.Date invtodate) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		double chaufchg=0.0;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			ClsManualInvoiceDAO manualdao=new ClsManualInvoiceDAO();
			String getdays=manualdao.getTotalDays(agmtno, invdate, invtodate,"LAG");
			String daysarray[]=getdays.split("::");
			int monthcalmethod=Integer.parseInt(daysarray[0]);
			int rentalno=Integer.parseInt(daysarray[1]);
			double days=Double.parseDouble(daysarray[2]);
			double day=Double.parseDouble(daysarray[3]);
			int month=Integer.parseInt(daysarray[4]);
			int lastday=Integer.parseInt(daysarray[5]);
			String strsql="";
			
			if(monthcalmethod==0){
				strsql="select "+(days/rentalno)+"*chaufchg chaufferchg from gl_ltarif where rdocno="+agmtno;
			}
			else if(monthcalmethod==1){
				strsql="select (("+month+"*chaufchg)+(("+day/lastday+")*chaufchg)) chaufferchg from gl_ltarif where rdocno="+agmtno;
				
			}
			
			ResultSet rschauffer=stmt.executeQuery(strsql);
			while(rschauffer.next()){
				chaufchg=rschauffer.getDouble("chaufferchg");
			}
			stmt.close();
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return chaufchg;
	}*/
public  JSONArray getTotalData(String temp,String desc1,String date1,String branchvalue,String client,String mode,String agmtno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		if(!mode.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		java.sql.Date sqldate=null;
        if(!(date1.equalsIgnoreCase("NA"))){
        	sqldate=ClsCommon.changeStringtoSqlDate(date1);
        }
        Connection conn = ClsConnection.getMyConnection();
		try {
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
			if(desc1.equalsIgnoreCase("Month End (M) Adv")){
				sqltest=" and agmt.adv_chk=1 and agmt.inv_type=1 and agmt.invdate<='"+sqldate+"' and clstatus=0  "+sqlbranch+"";
			
			}
			if(desc1.equalsIgnoreCase("Month End (M)")){
				sqltest=" and agmt.adv_chk=0 and agmt.inv_type=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+"";
			
			}
			
			if(desc1.equalsIgnoreCase("Period (M) Adv")){
				sqltest=" and agmt.adv_chk=1 and agmt.inv_type=2 and agmt.invdate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+"";
				
			}
			if(desc1.equalsIgnoreCase("Period (M)")){
				sqltest="and agmt.adv_chk=0 and agmt.inv_type=2 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+"";
				
			}
			if(!agmtno.equalsIgnoreCase("")){
				sqlclient+=" and agmt.doc_no="+agmtno;
			}
				Statement stmtDashBoard = conn.createStatement();
				String strtarifsum="";
				String strSql="select agmt.doc_no rano,agmt.voc_no,'Monthly' ratype,agmt.invdate fromdate,ac.cldocno,agmt.inv_type,ac.acno,head.account,head.description acname,"+
						" agmt.invtodate todate,agmt.brhid,brh.curid,if(inv_type=1,"+
						" DATEDIFF((select todate),(select fromdate)),DATEDIFF((select todate),(select fromdate))) datediff  from gl_lagmt agmt left join"+
						" gl_ltarif tarif on (agmt.doc_no=tarif.rdocno ) inner join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
						" my_head head on ac.acno=head.doc_no left join my_brch brh on agmt.brhid=brh.doc_no where 1=1 "+sqltest+" "+sqlclient+" order by agmt.voc_no";
            	
            	//System.out.println("Invoice SQL"+strSql);
				double finalamt=0.0;
             	ArrayList<Double> invoicearray=new ArrayList<>();
				ArrayList<Double> salikarray=new ArrayList<>();
				ArrayList<String> newarray=new ArrayList<>();
             	ResultSet resultSet = stmtDashBoard.executeQuery(strSql);
             	ClsInvGetSalikAlmariah objgetsalik=new ClsInvGetSalikAlmariah();
             	while(resultSet.next()){
             		invoicearray=ClsLeaseInvoiceCalc.getInvoiceCalc(resultSet.getString("rano"), resultSet.getString("cldocno"), resultSet.getDate("fromdate"), resultSet.getDate("todate"), resultSet.getString("ratype"), resultSet.getString("inv_type"));
             		salikarray=objgetsalik.getSalik(resultSet.getDate("fromdate"), resultSet.getDate("todate"), resultSet.getString("cldocno"), resultSet.getString("rano"), "LAG");
             		
             		for(int i=0;i<4;i++){
                 		finalamt+=salikarray.get(i);
                 		//System.out.println("Check Final Amt Salik:"+finalamt);
                 	}
                 	for(int i=0;i<invoicearray.size();i++){
                 		finalamt+=invoicearray.get(i);
                 		//System.out.println("Check Final Amt Other:"+finalamt);
                 	}
             		newarray.add(resultSet.getString("rano")+"::"+resultSet.getString("voc_no")+"::"+resultSet.getString("ratype")+"::"+
             		resultSet.getDate("fromdate")+"::"+resultSet.getDate("todate")+"::"+resultSet.getString("acno")+"::"+resultSet.getString("acname")+"::"+finalamt+"::"+
             		resultSet.getString("cldocno")+"::"+invoicearray.get(0)+"::"+invoicearray.get(1)+"::"+salikarray.get(0)+"::"+salikarray.get(1)+"::"+salikarray.get(2)+"::"+
             		salikarray.get(3)+"::"+resultSet.getString("datediff")+"::"+resultSet.getString("brhid")+"::"+resultSet.getString("curid")+"::"+invoicearray.get(2)+"::"+
             		resultSet.getString("inv_type")+"::"+salikarray.get(4)+"::"+salikarray.get(5)+"::"+salikarray.get(6)+"::"+salikarray.get(7)+"::"+resultSet.getString("account")+"::"+
             		invoicearray.get(3)+"::"+invoicearray.get(4)+"::"+invoicearray.get(5)+"::"+invoicearray.get(6)+"::"+invoicearray.get(7));
             	
             		invoicearray=new ArrayList<>();
             		salikarray=new ArrayList<>();
             		finalamt=0.0;
             	}
             	//System.out.println(newarray);
             	//System.out.println(newarray.size());
             	RESULTDATA=convertArrayToJSON(newarray);
				//System.out.println(RESULTDATA);
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
			
		//	ArrayList<String> analysisRowArray=newarray.get(i);
			
			int length = newarray.size();
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
			obj.put("account",newarray.get(i).split("::")[24]);
			obj.put("securitypass",newarray.get(i).split("::")[25]);
			obj.put("fuel",newarray.get(i).split("::")[26]);
			obj.put("safetyacc",newarray.get(i).split("::")[27]);
			obj.put("diw",newarray.get(i).split("::")[28]);
			obj.put("hpd",newarray.get(i).split("::")[29]);
			jsonArray.add(obj);
		}
		
		
		return jsonArray;
		}
	public JSONArray getAgmtData(String client,String mobile,String date,String fleetno,String regno,String docno,String branch,String id) throws SQLException
	{
		JSONArray agmtdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return agmtdata;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			java.sql.Date sqldate=null;
			if(!date.equalsIgnoreCase("") && date!=null){
				sqldate=ClsCommon.changeStringtoSqlDate(date);
			}
			String sqltest="";
			if(!client.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+client+"%'";
			}
			if(!mobile.equalsIgnoreCase("")){
				sqltest+=" and ac.per_mob like '%"+mobile+"%'";
			}
			if(sqldate!=null){
				sqltest+=" and agmt.date='"+sqldate+"'";
			}
			if(!fleetno.equalsIgnoreCase("")){
				sqltest+=" and veh.fleet_no like '%"+fleetno+"%'";
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and veh.reg_no like '%"+regno+"%'";
			}
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and agmt.voc_no like '%"+docno+"%'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and agmt.brhid="+branch;
			}
			String strsql="select agmt.doc_no,agmt.voc_no,ac.refname,ac.per_mob,br.branchname branch,veh.fleet_no,veh.reg_no,agmt.date from gl_lagmt agmt left join "+
			" my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no) "+
			" left join my_brch br on agmt.brhid=br.doc_no where agmt.status=3 and agmt.clstatus=0"+sqltest;
			System.out.println(strsql);
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(strsql);
			agmtdata=ClsCommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return agmtdata;
	}
	
	public JSONArray getAccountData(String agmtno,String id,String rentalsum,String salikamt,String saliksrvc,String securitypass,String fuel,
			String safetyacc,String diw,String hpd)throws SQLException{
		JSONArray accountdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return accountdata;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int errorstatus=0;
			Statement stmt=conn.createStatement();
			ArrayList<String> acnoarray=new ArrayList<>();
			int chaufferextra=0,rentalacno=0,accacno=0,salikacno=0,saliksrvcacno=0,fuelacno=0,securitypassacno=0,diwacno=0,hpdacno=0;
			String stracno="select (select acno from gl_invmode where idno=1) rentalacno,"+
			" (select acno from gl_invmode where idno=2) accacno,"+
			" (select acno from gl_invmode where idno=8) salikacno,"+
			" (select acno from gl_invmode where idno=14) saliksrvcacno,"+
			" (select acno from gl_invmode where idno=11) fuelacno,"+
			" (select acno from gl_invmode where idno=22) securitypassacno,"+
			" (select acno from gl_invmode where idno=23) diwacno,"+
			" (select acno from gl_invmode where idno=24) hpdacno,"+
			" (select acno from gl_invmode where idno=3) chauffer,"+
			" (select acno from gl_invmode where idno=23) chaufferextra";
			ResultSet rsacno=stmt.executeQuery(stracno);
			while(rsacno.next()){
				rentalacno=rsacno.getInt("rentalacno");
				accacno=rsacno.getInt("accacno");
				salikacno=rsacno.getInt("salikacno");
				saliksrvcacno=rsacno.getInt("saliksrvcacno");
				fuelacno=rsacno.getInt("fuelacno");
				securitypassacno=rsacno.getInt("securitypassacno");
				diwacno=rsacno.getInt("chauffer");
				hpdacno=rsacno.getInt("chaufferextra");
				
			}
			if(Double.parseDouble(rentalsum)>0.0){
				acnoarray.add(rentalacno+"::"+rentalsum);
			}
			if(Double.parseDouble(salikamt)>0.0){
				acnoarray.add(salikacno+"::"+salikamt);
			}
			if(Double.parseDouble(saliksrvc)>0.0){
				acnoarray.add(saliksrvcacno+"::"+saliksrvc);
			}
			if(Double.parseDouble(securitypass)>0.0){
				acnoarray.add(securitypassacno+"::"+securitypass);
			}
			if(Double.parseDouble(fuel)>0.0){
				acnoarray.add(fuelacno+"::"+fuel);
			}
			if(Double.parseDouble(diw)>0.0){
				acnoarray.add(diwacno+"::"+diw);
			}
			if(Double.parseDouble(hpd)>0.0){
				acnoarray.add(hpdacno+"::"+hpd);
			}
			if(Double.parseDouble(safetyacc)>0.0){
				acnoarray.add(accacno+"::"+safetyacc);
			}
			int  deletedata=stmt.executeUpdate("delete from gl_invleasealmariahtemp where agmtno="+agmtno);
			
			for(int i=0;i<acnoarray.size();i++){
				String strsql="insert into gl_invleasealmariahtemp(acno, amount, agmtno)values("+acnoarray.get(i).split("::")[0]+","+acnoarray.get(i).split("::")[1]+","+agmtno+")";
				System.out.println(strsql);
				int insert=stmt.executeUpdate(strsql);
				if(insert<=0){
					errorstatus=1;
				}
			}
			if(errorstatus==0){
				conn.commit();
				String strsql="select inv.description,temp.amount from gl_invleasealmariahtemp temp left join gl_invmode inv on (temp.acno=inv.acno) where temp.agmtno="+agmtno;
				ResultSet rs=stmt.executeQuery(strsql);
				accountdata=ClsCommon.convertToJSON(rs);
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return accountdata;
	}
	
	public int customInvoiceInsert(Connection conn,ArrayList<String> invoicearray,String cmbagmttype, java.sql.Date date, String hidclient, int agmtno,
			String ledgernote, String invoicenote, java.sql.Date fromdate, java.sql.Date todate,String branchid,String userid,String currencyid,String mode,String acno,
			String dtype,String formdetailcode,String qty2) throws SQLException {
	// TODO Auto-generated method stub
	ClsManualInvoiceDAO manualdao=new ClsManualInvoiceDAO();
	ClsCommon objcommon=new ClsCommon();
	if(hidclient==null){
		return 0;
	}
	if(hidclient.equalsIgnoreCase("0")){
		return 0;
	}
	try{

		if(todate.compareTo(fromdate)<0){
			fromdate=todate;
		}
		 int salikcount=0,trafficcount=0;
		 double saliksrvcvat=0.0,trafficsrvcvat=0.0;
		 double saliksrvc=0.0,trafficsrvc=0.0;
		 String salikqty="",trafficqty="";
		int invdescconfig=manualdao.getInvDescConfig(conn);
		ClsManualInvoiceBean invoicebean=new ClsManualInvoiceBean();
		String note="";
		note=ledgernote;
		int oneDayExtraConfig=manualdao.getOneDayExtraConfig(conn);
		int invoicetypeno=0;	//For Determining from where it was invoiced
		int firstinvoicestatus=0;
		int advance=0,invtypeno=0;	//For Determining Month End Advance
		String rtype="";
		String salikdesc="";
		String trafficdesc="";
		Statement stmtacperiod=conn.createStatement();
		java.sql.Date duedate=null;
		duedate=date;
		String origin=dtype.contains("###")?dtype.split("###")[1]:"";
		String damagedtype=dtype.contains("###")?dtype.split("###")[0]:"";
		String damageinspno="";
		if(damagedtype.equalsIgnoreCase("IND")){
			invoicetypeno=6;
			damageinspno=dtype.split("###")[1];
			//origin="";

		}
		else{
			invoicetypeno=Integer.parseInt(dtype.contains("###")?dtype.split("###")[1]:"");
		}
		//	System.out.println("Invoice Type Code: "+invoicetypeno);
		int agmtvocno=0;
		String agmtrefno="";
		String agmtmrano="";
		Statement stmtagmtvoc=conn.createStatement();
		String stragmtvoc="";
		String agmtregno="";
		String agmtplate="";
		if(cmbagmttype.equalsIgnoreCase("RAG")){
			stragmtvoc="select agmt.voc_no,coalesce(agmt.refno,'') refno,coalesce(agmt.mrano,'') mrano,veh.reg_no,plt.code_name from gl_ragmt agmt left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no left join gl_vehplate plt on veh.pltid=plt.doc_no where agmt.doc_no="+agmtno;
		}
		else if(cmbagmttype.equalsIgnoreCase("LAG")){
			stragmtvoc="select agmt.voc_no,coalesce(agmt.refno,'') refno,coalesce(agmt.manualra,'') mrano,veh.reg_no,plt.code_name from gl_lagmt agmt left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no)  left join gl_vehplate plt on veh.pltid=plt.doc_no where agmt.doc_no="+agmtno;
		}
		if(!stragmtvoc.equalsIgnoreCase("")){
			ResultSet rsagmtvocno=stmtagmtvoc.executeQuery(stragmtvoc);
			while(rsagmtvocno.next()){
				agmtvocno=rsagmtvocno.getInt("voc_no");
				agmtrefno=rsagmtvocno.getString("refno");
				agmtmrano=rsagmtvocno.getString("mrano");
				agmtregno=rsagmtvocno.getString("reg_no");
				agmtplate=rsagmtvocno.getString("code_name");
			}
		}


		double damageamount=0.0;
		String strdelchg="";
		String straddrchg="";
		java.sql.Date tempfromdate=null;
		int aaa=0,testtrno=0;
		//System.out.println(date+"//////"+hidclient+"////"+agmtno+"///"+cmbagmttype);

		String stracperiod="select DATE_ADD(if("+date+" is null,null,'"+date+"'), INTERVAL (select period2 from my_acbook where cldocno="+hidclient+" and dtype='CRM') DAY) duedate";
		//System.out.println(stracperiod);
		ResultSet rsacperiod=stmtacperiod.executeQuery(stracperiod);
		while(rsacperiod.next()){
			duedate=rsacperiod.getDate("duedate");
		}
		//System.out.println("Duedate:"+duedate);
		tempfromdate=fromdate;
		if(!(origin.trim().equalsIgnoreCase("1"))){

			if(cmbagmttype.equalsIgnoreCase("RAG")){
				strdelchg="select (select if(delivery=1,coalesce(delchg,0),0) from gl_ragmt where doc_no="+agmtno+" and del_invno=0) del,(select acno from gl_invmode where idno=6) delacno ";
				straddrchg="select (select coalesce(if(addr=1,addrchg,0),0) addrchg from gl_ragmt where doc_no="+agmtno+" and addr_invno=0 and clstatus=0) addrchg,(select acno from gl_invmode where idno=12) others";
			}
			else if(cmbagmttype.equalsIgnoreCase("LAG")){
				strdelchg="select (select if(delivery=1,coalesce(delchg,0),0) from gl_lagmt where doc_no="+agmtno+" and del_invno=0) del,(select acno from gl_invmode where idno=6) delacno ";
				straddrchg="select (select coalesce(if(addr=1,addrchg,0),0) addrchg from gl_lagmt where doc_no="+agmtno+" and addr_invno=0 and clstatus=0) addrchg,(select acno from gl_invmode where idno=12) others";

			}
			else{

			}
			double delchg=0.0;
			int delacno=0;
			Statement stmtdelchg=conn.createStatement();
			ResultSet rsdelchg=stmtdelchg.executeQuery(strdelchg);
			while(rsdelchg.next()){
				delchg=rsdelchg.getDouble("del");
				delacno=rsdelchg.getInt("delacno");
			}
			stmtdelchg.close();
			double addrchg=0.0;
			int othersacno=0;
			Statement stmtaddrchg=conn.createStatement();
			ResultSet rsaddrchg=stmtaddrchg.executeQuery(straddrchg);
			while(rsaddrchg.next()){
				addrchg=rsaddrchg.getDouble("addrchg");
				othersacno=rsaddrchg.getInt("others");
			}
			int delflag=0,addrflag=0;
			for(int z=0;z<invoicearray.size();z++){
				String strcheckdel=invoicearray.get(z).split("::")[0];
				if(strcheckdel.equalsIgnoreCase("6")){
					delflag=1;
					break;
				}
			}
			for(int z=0;z<invoicearray.size();z++){
				String strcheckaddr=invoicearray.get(z).split("::")[0];
				if(strcheckaddr.equalsIgnoreCase("12")){
					addrflag=1;
					break;
				}
			}
			if(delchg>0 && delflag==0 && (!formdetailcode.equalsIgnoreCase("INS") && !formdetailcode.equalsIgnoreCase("INT"))){
				invoicearray.add("6"+"::"+delacno+"::"+note+"::1::"+delchg+"::"+delchg);
			}
			if(addrchg>0 && addrflag==0 && (!formdetailcode.equalsIgnoreCase("INS") && !formdetailcode.equalsIgnoreCase("INT"))){
				invoicearray.add("12"+"::"+othersacno+"::"+note+"::1::"+addrchg+"::"+addrchg);
			}

			//dtype=session.getAttribute("Code").toString();

			if(hidclient.equalsIgnoreCase("")){
				hidclient="0";
			}
			if(acno.equalsIgnoreCase("")){
				acno="0";
			}

			acno=acno==null?"0":acno;

			Statement stmtcheck=conn.createStatement();
			String strcheck="";
			
			int agmttype=0;
			//Adds 1 Date to From Date if invoice type is Monthly 
			String stradv="";
			if(cmbagmttype.equalsIgnoreCase("RAG")){
				stradv="select invtype,advchk from gl_ragmt where doc_no="+agmtno;
			}
			else if(cmbagmttype.equalsIgnoreCase("LAG")){
				stradv="select inv_type invtype,adv_chk advchk from gl_lagmt where doc_no="+agmtno;
			}
			Statement stmtadv=conn.createStatement();
			ResultSet rsadv=stmtadv.executeQuery(stradv);
			while(rsadv.next()){
				advance=rsadv.getInt("advchk");
				invtypeno=rsadv.getInt("invtype");
			}
			int invcount=0;
			//Getting the invoice count for decrementing 1 date from fromdate for period type invoice
			String strgetinvcount="select count(*) invcount from gl_invm invm left join gl_invd invd on invm.doc_no=invd.rdocno where invm.rano="+agmtno+" and invm.ratype='"+cmbagmttype+"' and invd.chid=1 and invm.status!=7";
			System.out.println(strgetinvcount);
			ResultSet rsinvcount=stmtcheck.executeQuery(strgetinvcount);
			while(rsinvcount.next()){
				invcount=rsinvcount.getInt("invcount");
			}
			
			if(invoicearray.get(0).split("::")[0].toString().equalsIgnoreCase("1")){
				if(cmbagmttype.equalsIgnoreCase("RAG") && invcount>0 ){
					strcheck="select if((select '"+fromdate+"')>agmt.odate,DATE_ADD('"+fromdate+"',INTERVAL 1 DAY),(select '"+fromdate+"')) fromdate from"+
							" gl_ragmt agmt where  agmt.doc_no="+agmtno+"";
				}
				if(cmbagmttype.equalsIgnoreCase("LAG") && invcount>0){
					/*strcheck="select if((select count(*) from gl_invm inv left join gl_lagmt agmt on inv.rano=agmt.doc_no where inv.status<>7 and inv.rano="+agmtno+""+
					" and inv.ratype='LAG' and agmt.inv_type=1)>0,(select DATE_ADD('"+fromdate+"',INTERVAL 1 DAY)),(select '"+fromdate+"')) fromdate";*/

					strcheck="select if((select '"+fromdate+"')>agmt.outdate,DATE_ADD('"+fromdate+"',INTERVAL 1 DAY),(select '"+fromdate+"')) fromdate from"+
							" gl_lagmt agmt where  agmt.doc_no="+agmtno+"";
				}
				//System.out.println("Invoice Date Check Query:"+strcheck);
				if(!strcheck.equalsIgnoreCase("")){
					ResultSet rscheck=stmtcheck.executeQuery(strcheck);
					if(rscheck.next()){
						System.out.println(invcount+"//"+invtypeno+"//"+origin);
						if(invtypeno==1){
							tempfromdate=rscheck.getDate("fromdate");
						}
						/*else if(invcount>0 && invtypeno==2 && oneDayExtraConfig==1 && (origin.equalsIgnoreCase("2") || origin.equalsIgnoreCase("4"))){
							tempfromdate=rscheck.getDate("fromdate");
						}*/
						else{
							//tempfromdate=fromdate;
						}
						
					}
				}
				
				System.out.println(invtypeno+"///"+oneDayExtraConfig+"///"+origin);
				//Checking Agreement is Monthend Advance
				
				if(invcount>0 && invtypeno==2 && oneDayExtraConfig==1 && (origin.equalsIgnoreCase("2") || origin.equalsIgnoreCase("4"))){
/*
* not first invoice checking to be added
*/
					strcheck="select date_add('"+fromdate+"',interval 1 day) fromdate";
					ResultSet rsperiod=stmtcheck.executeQuery(strcheck);
					while(rsperiod.next()){
						tempfromdate=rsperiod.getDate("fromdate");
					}
				}
				
			}


			if(cmbagmttype.equalsIgnoreCase("RAG")){
				note=objcommon.changeSqltoString(tempfromdate) +" to "+objcommon.changeSqltoString(todate) +" for Rental Agreement no "+agmtvocno;
				rtype=" in ('RA','RD','RW','RF','RM')";
				salikdesc="Salik Invoice for Rental Agreement "+agmtvocno+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
				trafficdesc="Traffic Invoice for Rental Agreement "+agmtvocno+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
			}
			else if(cmbagmttype.equalsIgnoreCase("LAG")){
				note=objcommon.changeSqltoString(tempfromdate) +" to "+objcommon.changeSqltoString(todate) +" for Lease Agreement no "+agmtvocno;
				rtype=" in ('LA','LC')";
				salikdesc="Salik Invoice for Lease Agreement "+agmtvocno+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
				trafficdesc="Traffic Invoice for Lease Agreement "+agmtvocno+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
			}
			
			if(invoicetypeno==6 && invdescconfig==1){
				String strdamagefleet="select insp.rfleet fleet_no,insp.reftype,veh.reg_no,plt.code_name from gl_vinspm insp left join gl_vehmaster veh on insp.rfleet=veh.fleet_no left join gl_vehplate plt on veh.pltid=plt.doc_no where insp.doc_no="+damageinspno;
				ResultSet rsdamagefleet=stmtcheck.executeQuery(strdamagefleet);
				String  damagefleet="";
				String agmtreftype="";
				String damageregno="";
				String damageplate="";
				while(rsdamagefleet.next()){
					damagefleet=rsdamagefleet.getString("fleet_no");
					agmtreftype=rsdamagefleet.getString("reftype");
					damageregno=rsdamagefleet.getString("reg_no");
					damageplate=rsdamagefleet.getString("code_name");
				}
				String damageagmttype="";
				if(agmtreftype.equalsIgnoreCase("RAG")){
					damageagmttype="Rental";
				}
				else if(agmtreftype.equalsIgnoreCase("LAG")){
					damageagmttype="Lease";
				}
				note=" Damage Invoice for fleet "+damagefleet+" of "+damageagmttype+" Agreement "+agmtvocno+" with Reg No "+damageregno+" and Plate Code "+damageplate;
			}

			
			if(!agmtmrano.equalsIgnoreCase("")){
				/*
				 * Overridden for Maxima
				 * */
				//note+=" ("+agmtrefno+")";
				note+=" ("+agmtmrano+")";
			}
			
			if(invdescconfig==1 && invoicetypeno!=6){
				note+=" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
			}

			




			/*if(advance==1 && invtypeno==1 && (origin.equalsIgnoreCase("2") || origin.equalsIgnoreCase("3") || origin.equalsIgnoreCase("4") || origin.equalsIgnoreCase("5"))){
				date=tempfromdate;
			}*/
			
			if(advance==1 && invtypeno==1 && (origin.equalsIgnoreCase("2") || origin.equalsIgnoreCase("4"))){
				date=tempfromdate;
			}

		}//Closing for Origin
		CallableStatement stmtManual = conn.prepareCall("{call invoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		if(invdescconfig==1){
			if(formdetailcode.equalsIgnoreCase("INS")){
				for(int i=0;i< invoicearray.size();i++){
					String[] invoice=invoicearray.get(i).split("::");
					if(invoice[0].equalsIgnoreCase("8") || invoice[0].equalsIgnoreCase("14")){
						salikqty=invoice[3];
					}
				}
				String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
				//Overridden for WORLDRAC on 04/05/2017
				String strfromdate="",strtodate="";
				if(fromdate!=null){
					strfromdate=objcommon.changeSqltoString(fromdate);
				}
				if(todate!=null){
					strtodate=objcommon.changeSqltoString(todate);
				}
				note=salikqty+" Saliks of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
			}
			else if(formdetailcode.equalsIgnoreCase("INT")){
				for(int i=0;i< invoicearray.size();i++){
					String[] invoice=invoicearray.get(i).split("::");
					if(invoice[0].equalsIgnoreCase("9") || invoice[0].equalsIgnoreCase("15")){
						trafficqty=invoice[3];
					}
				}
				String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
				//Overridden for WORLDRAC on 04/05/2017
				String strfromdate="",strtodate="";
				if(fromdate!=null){
					strfromdate=objcommon.changeSqltoString(fromdate);
				}
				if(todate!=null){
					strtodate=objcommon.changeSqltoString(todate);
				}
				note=trafficqty+" Traffics of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
			}
		}
		
		stmtManual.registerOutParameter(14, java.sql.Types.INTEGER);
		stmtManual.registerOutParameter(15, java.sql.Types.INTEGER);
		stmtManual.registerOutParameter(17, java.sql.Types.INTEGER);
		stmtManual.setDate(1,date);
		stmtManual.setString(2,cmbagmttype);
		stmtManual.setString(3,hidclient);
		stmtManual.setInt(4, agmtno);
		stmtManual.setString(5,origin.equalsIgnoreCase("1")?ledgernote:note);
		stmtManual.setString(6,origin.equalsIgnoreCase("1")?invoicenote:note);
		stmtManual.setString(7,currencyid);
		stmtManual.setString(8,acno);
		stmtManual.setDate(9,tempfromdate);
		stmtManual.setDate(10,todate);
		stmtManual.setString(11,formdetailcode);
		stmtManual.setString(12,userid);
		stmtManual.setString(13,branchid);
		stmtManual.setString(16,mode);
		//		System.out.println(stmtManual);
		stmtManual.executeQuery();
		aaa=stmtManual.getInt("docNo");
		testtrno=stmtManual.getInt("vtrNo");
		//request.setAttribute("tranno", testtrno);
		//	System.out.println("inv vocno"+stmtManual.getInt("voucher"));
		Statement stmtinvoice;
		int testcurid=0;
		double testcurrate=0.0;
		stmtinvoice = conn.createStatement();
		//System.out.println("Currency"+currencyid);

		ResultSet rscurr=stmtinvoice.executeQuery("select c_rate,doc_no from my_curr where doc_no='"+currencyid+"'");
		if(rscurr.next()){
			testcurid=rscurr.getInt("doc_no");
			testcurrate=rscurr.getDouble("c_rate");
		}
		else{
			System.out.println("Currency Error");
			return 0;
		}


		Statement stmtupdatemanual=conn.createStatement();
		String strupdatemanual="update gl_invm set manual="+invoicetypeno+" where doc_no="+aaa;
		int updatemanual=stmtupdatemanual.executeUpdate(strupdatemanual);
		if(updatemanual<0){
			return 0;
		}

		double salikamt=0.0,trafficamt=0.0,generalamt=0.0;
		double otherincome=0.0;
		double salikldr=0.0,trafficldr=0.0,generalldr=0.0;
		double smsamount=0.0;
		int srno=1,ismssend=0;
		int tempno=1;
		for(int i=0;i< invoicearray.size();i++){

			String[] invoice=invoicearray.get(i).split("::");
			//System.out.println(Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString()));
			//System.out.println(testcurrate);
			double testldramt=testcurrate*Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString());
			double partydramt=Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString())*-1;
			partydramt=objcommon.Round(partydramt, 2);
			double partyldramt=testldramt*-1;
			//double testamt=(double)invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5];
			//System.out.println("Invoice[5]:"+invoice[5]);
			String strqty=invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?"0":invoice[3];
			String temptot=invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?"0":invoice[5];
			String temprate=invoice[4].equalsIgnoreCase("undefined") || invoice[4].isEmpty()?"0":invoice[4];
			if(invoice[0].equalsIgnoreCase("10")){
				damageamount=Double.parseDouble(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?"0":invoice[5]);
				//System.out.println("Dmg Amt: "+damageamount+"////"+invoice[4]+"////"+invoice[5]);
			}
			/*//Deriving rate from total and quantity	
	if(!(invoice[0].equalsIgnoreCase("8") || invoice[0].equalsIgnoreCase("14"))){
		if(Double.parseDouble(strqty.split(" ")[0])<0){
			temprate=Double.parseDouble(temptot)*Double.parseDouble(strqty.split(" ")[0])+"";
		}
		else{
			temprate=Double.parseDouble(temptot)/Double.parseDouble(strqty.split(" ")[0])+"";	
		}

	}
//Deriving Ends here
			 */		if(Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]))>0){


				 String sql="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(i+1)+"','"+branchid+"','"+aaa+"'"+
						 ",'"+testtrno+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+strqty+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"','"+temprate+"')";
				 //		System.out.println(" Invd Sql"+sql);
				 int resultSet = stmtinvoice.executeUpdate (sql);
				 if(resultSet>0){


					 if((!origin.trim().equalsIgnoreCase("1"))){
						 if((Integer.parseInt(invoice[0])==9)|| (Integer.parseInt(invoice[0])==15)){

							 ismssend=1;
							 smsamount=smsamount+Double.parseDouble(invoice[5]);

						 }
					 }


					 if(!(origin.trim().equalsIgnoreCase("1"))){
						 if(invoice[0].equalsIgnoreCase("12") && Double.parseDouble(invoice[5])>0){
							 Statement stmtupdateaddr=conn.createStatement();
							 String strupdateaddr="";
							 if(cmbagmttype.equalsIgnoreCase("RAG")){
								 strupdateaddr="update gl_ragmt set addr_invno="+aaa+" where doc_no="+agmtno;
							 }
							 else if(cmbagmttype.equalsIgnoreCase("LAG")){
								 strupdateaddr="update gl_lagmt set addr_invno="+aaa+" where doc_no="+agmtno;
							 }
							 int updateval=stmtupdateaddr.executeUpdate(strupdateaddr);
							 if(updateval<0){
								 return 0;
							 }
							 stmtupdateaddr.close();
						 }


						 if(invoice[0].equalsIgnoreCase("6") && Double.parseDouble(invoice[5])>0){
							 String strdelivery="";
							 Statement stmtdelivery=conn.createStatement();
							 if(cmbagmttype.equalsIgnoreCase("RAG")){
								 strdelivery="update gl_ragmt set del_invno="+aaa+" where doc_no="+agmtno;
							 }
							 else if(cmbagmttype.equalsIgnoreCase("LAG")){
								 strdelivery="update gl_lagmt set del_invno="+aaa+" where doc_no="+agmtno;
							 }
							 int delval=stmtdelivery.executeUpdate(strdelivery);
							 if(delval<=0){
								 return 0;
							 }
						 }
					 }//Closing for Origin
					 if(cmbagmttype.equalsIgnoreCase("RAG")){
						 String strSqlrcalc="";
						 if(!(origin.trim().equalsIgnoreCase("1"))){
							 strSqlrcalc="insert into gl_rcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty)values('"+branchid+"','"+testtrno+"',"+
									 "'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+aaa+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"')";
						 }
						 else{
							 strSqlrcalc="insert into gl_rcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty,amount)values('"+branchid+"','"+testtrno+"',"+
									 "'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+aaa+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"')";
						 }

						 //System.out.println(strSqlrcalc);
						 int rcalcval=stmtinvoice.executeUpdate(strSqlrcalc);

						 if(rcalcval<=0){
							 System.out.println("Rcalc Error");
							 return 0;
						 }


					 }
					 if(cmbagmttype.equalsIgnoreCase("LAG")){
						 String strSqlrcalc="";
						 if(!(origin.trim().equalsIgnoreCase("1"))){
							 strSqlrcalc="insert into gl_lcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty)values('"+branchid+"','"+testtrno+"',"+
									 "'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+aaa+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"')";
						 }
						 else{
							 strSqlrcalc="insert into gl_lcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty,amount)values('"+branchid+"','"+testtrno+"',"+
									 "'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+aaa+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"')";
						 }
						 //System.out.println(strSqlrcalc);
						 int rcalcval=stmtinvoice.executeUpdate(strSqlrcalc);

						 if(rcalcval<=0){
							 System.out.println("Lcalc Error");
							 return 0;
						 }
					 }
				 }
				 else{
					 System.out.println("Invd Error");
					 return 0;
				 }
				 double invtype=0;
				 String todatecalc="";
				 int monthcalmethod=0;
				 int monthcalvalue=0;
				 //		System.out.println("Origin: "+origin+"//////");

				 //Extra Block for updating agmt invtodate in case of agreement started in monthend
				 Statement stmtdelcal=conn.createStatement();
				 int delcal=0;
				 //Deciding outddate or deliverydate
				 String strdelcal="select method from gl_config where field_nme='delcal'";
				 ResultSet rsdelcal=stmtdelcal.executeQuery(strdelcal);

				 while(rsdelcal.next()){
					 delcal=rsdelcal.getInt("method");
				 }
				 String strcheckdate="";
				 java.sql.Date temptodate=null;
				 //when delivery date must be considered
				 if(delcal==0){
					 if(cmbagmttype.equalsIgnoreCase("RAG")){
						 strcheckdate="select if(delivery=1 and delstatus=1,(select min(din) from gl_vmove where rdocno="+agmtno+" and rdtype='RAG' and "+
								 " trancode='DL' and repno=0),odate) temptodate from gl_ragmt where doc_no="+agmtno;	
					 }
					 else if(cmbagmttype.equalsIgnoreCase("LAG")){
						 strcheckdate="select if(delivery=1 and delstatus=1,(select min(din) from gl_vmove where rdocno="+agmtno+" and rdtype='LAG' and "+
								 "  trancode='DL' and repno=0),outdate) temptodate from gl_lagmt where doc_no="+agmtno;	
					 }

				 }
				 //When Outdate is considered
				 else{
					 if(cmbagmttype.equalsIgnoreCase("RAG")){
						 strcheckdate="select odate temptodate from gl_ragmt where doc_no="+agmtno;
					 }
					 else if(cmbagmttype.equalsIgnoreCase("LAG")){
						 strcheckdate="select outdate temptodate from gl_lagmt where doc_no="+agmtno;
					 }
				 }
				 //System.out.println("Check Date Query: "+strcheckdate);
				 ResultSet rstemptodate=stmtdelcal.executeQuery(strcheckdate);
				 while(rstemptodate.next()){
					 temptodate=rstemptodate.getDate("temptodate");
				 }

				 int samedatestatus=0;
				 String strchecksame="";
				 int startday=0;
				 int closestatus=0;
				 //System.out.println("Check invtype: "+invtype);
				 if(cmbagmttype.equalsIgnoreCase("RAG")){
					 ResultSet rsgetinvtype=stmtinvoice.executeQuery("select invtype,clstatus from gl_ragmt where doc_no="+agmtno);
					 if(rsgetinvtype.next()){
						 invtype=rsgetinvtype.getDouble("invtype");
						 closestatus=rsgetinvtype.getInt("clstatus");
					 }
				 }
				 else if(cmbagmttype.equalsIgnoreCase("LAG")){
					 ResultSet rsgetinvtype=stmtinvoice.executeQuery("select inv_type,clstatus from gl_lagmt where doc_no="+agmtno);
					 if(rsgetinvtype.next()){
						 invtype=rsgetinvtype.getDouble("inv_type");
						 closestatus=rsgetinvtype.getInt("clstatus");
					 }
				 }



				 if(invtype==2){
					 //Checking Out Date and Month End of Out date is same
					 strchecksame="select if('"+temptodate+"'=last_day('"+temptodate+"'),1,0) samedatestatus,day('"+temptodate+"') startday";
					 //System.out.println("Check Same Date Query: "+strchecksame);
					 ResultSet rssamedatestatus=stmtdelcal.executeQuery(strchecksame);
					 while(rssamedatestatus.next()){
						 samedatestatus=rssamedatestatus.getInt("samedatestatus");
						 startday=rssamedatestatus.getInt("startday");
					 }
				 }
				 //Extra Block for updating agmt invtodate in case of agreement started in monthend Ends





				 if(!(origin.trim().equalsIgnoreCase("1"))){
					 if(cmbagmttype.equalsIgnoreCase("RAG") &&  invoice[0].equalsIgnoreCase("1") && Double.parseDouble(invoice[5])>0){
						 ResultSet rsgetinvtype=stmtinvoice.executeQuery("select invtype from gl_ragmt where doc_no="+agmtno);
						 if(rsgetinvtype.next()){
							 invtype=rsgetinvtype.getDouble("invtype");
						 }
						 String tempdate="'"+todate+"'";
						 String sqlra="";
						 if(cmbagmttype.equalsIgnoreCase("RAG")){
							 sqlra="select method,value from GL_CONFIG WHERE FIELD_NME='monthlycal'";
						 }
						 else{
							 sqlra="select method,value from GL_CONFIG WHERE FIELD_NME='lesmonthlycal'";
						 }

						 ResultSet rsgetmonthcal=stmtinvoice.executeQuery(sqlra);
						 while(rsgetmonthcal.next()){
							 monthcalmethod=rsgetmonthcal.getInt("method");
							 monthcalvalue=rsgetmonthcal.getInt("value");
						 }
						 if(monthcalmethod==1){
							 if(invtype==1){
								 todatecalc="SELECT LAST_DAY(DATE_ADD('"+todate+"',INTERVAL 1 month))";
							 }
							 if(invtype==2){
								 todatecalc="DATE_ADD('"+todate+"',INTERVAL 1 month)";
							 }
						 }
						 else if(monthcalmethod==0){
							 if(invtype==1){
								 todatecalc="SELECT LAST_DAY(DATE_ADD('"+todate+"',INTERVAL 1 month))";
							 }
							 if(invtype==2){
								 todatecalc="DATE_ADD('"+todate+"',INTERVAL '"+monthcalvalue+"' DAY)";
							 }
							 /*todatecalc="SELECT DATE_ADD('"+todate+"',INTERVAL '"+monthcalvalue+"' DAY)";*/
						 }

						 //Checks Out Date and MonthEnd is same
						 if(samedatestatus==1  && invtype==2){

							 //Out Date is month end then invtodate should be monthend of next month.
/*								 todatecalc="select LAST_DAY(("+todatecalc+"))";

							 todatecalc="select  if("+startday+">(select day(("+todatecalc+"))),"+
									 " (SELECT DATE_ADD('"+todate+"',INTERVAL 1 month)),(select LAST_DAY((SELECT DATE_ADD('"+todate+"',INTERVAL 1 month)))))";	
*/								if(monthcalmethod==0){
								todatecalc="select LAST_DAY((SELECT DATE_ADD('"+todate+"',INTERVAL '"+monthcalvalue+"' DAY)))";
							}
							else if(monthcalmethod==1){
								todatecalc="select LAST_DAY((SELECT DATE_ADD('"+todate+"',INTERVAL 1 MONTH)))";
							}
						 }
						 if(samedatestatus==0){
							 if(invtype==2){
								if(monthcalmethod==1){
								 int remainday=0;
								 int sameday=0;
								 System.out.println("Todatecalc b4: "+todatecalc);
								 Statement stmtremain=conn.createStatement();
								 System.out.println(startday);
								 String check="select if("+startday+">(select day(("+todatecalc+"))),"+startday+"-(select day(("+todatecalc+"))),0) remainday,if(day("+todatecalc+")=day(last_day("+todatecalc+")),1,0) sameday";

								 System.out.println("Get Remainday Query: "+check);
								 ResultSet rsremain=stmtremain.executeQuery(check);
								 while(rsremain.next()){
									 remainday=rsremain.getInt("remainday");
									 sameday=rsremain.getInt("sameday");
								 }
								 if(sameday==1){
									 System.out.println("Inside Lastday");
									 todatecalc="select last_day("+todatecalc+")";
								 }
								 else if(remainday>0){
									 /*if(oneDayExtraConfig==1){
										 remainday--;
									 }*/
									 todatecalc="select date_add("+todatecalc+",interval "+remainday+" day)";
									 System.out.println("check todatecalc: "+todatecalc);
								 }
								 else {
									 if(oneDayExtraConfig==1){
										 String strbegindate="select a.begindatestatus,if(a.begindatestatus=1,last_day(date_add('"+todate+"',"+
									 " interval 1 day)),date_add('"+todate+"', interval 1 month)) begindate  from ("+
									 " SELECT if(date_add('"+temptodate+"',interval -DAY('"+temptodate+"')+1 DAY)='"+temptodate+"',1,0) begindatestatus)a";
										 System.out.println("==== "+strbegindate);
										 ResultSet rsbegindate=stmtremain.executeQuery(strbegindate);
										 while(rsbegindate.next()){
											 todatecalc=" select '"+rsbegindate.getDate("begindate")+"'";
										 }
										 
									 }
									 System.out.println("/////////Else//////////");
								 }

								 stmtremain.close();
								}
							}
						 }

						 			System.out.println("Final Todatecalc: "+todatecalc);
					if(invtype!=3){
						 if(closestatus==0){
							 String strupdate="update gl_ragmt set invdate='"+todate+"',invtodate=("+todatecalc+") where doc_no="+agmtno;
							 //System.out.println("Update Query"+strupdate);
							 int agmtupdate=stmtinvoice.executeUpdate(strupdate);
							 //System.out.println("Agmt Update Value"+agmtupdate);
							 if(agmtupdate<0){
								 System.out.println("Update Ragmt Error");
								 return 0;
							 }
						 }
					}	 
					 }



					 if(cmbagmttype.equalsIgnoreCase("LAG")  && invoice[0].equalsIgnoreCase("1")  && Double.parseDouble(invoice[5])>0){
						 ResultSet rsgetinvtype=stmtinvoice.executeQuery("select inv_type from gl_lagmt where doc_no="+agmtno);
						 if(rsgetinvtype.next()){
							 invtype=rsgetinvtype.getInt("inv_type");
						 }
						 String tempdate="'"+todate+"'";
						 ResultSet rsgetmonthcal=stmtinvoice.executeQuery("select method,value from GL_CONFIG WHERE FIELD_NME='monthlycal'");
						 while(rsgetmonthcal.next()){
							 monthcalmethod=rsgetmonthcal.getInt("method");
							 monthcalvalue=rsgetmonthcal.getInt("value");
						 }
						 if(monthcalmethod==1){
							 if(invtype==1){
								 todatecalc="SELECT LAST_DAY(DATE_ADD('"+todate+"',INTERVAL 1 month))";
							 }
							 if(invtype==2){
								 todatecalc="DATE_ADD('"+todate+"',INTERVAL 1 month)";
							 }
						 }
						 else if(monthcalmethod==0){
							 if(invtype==1){
								 todatecalc="SELECT LAST_DAY(DATE_ADD('"+todate+"',INTERVAL 1 month))";
							 }
							 if(invtype==2){
								 todatecalc="DATE_ADD('"+todate+"',INTERVAL '"+monthcalvalue+"' DAY)";
							 }
						 }
						 System.out.println(samedatestatus+"//"+invtype+"//"+monthcalmethod);
						 if(samedatestatus==1  && invtype==2){

							 //Out Date is month end then invtodate should be monthend of next month.
/*								 todatecalc="select LAST_DAY(("+todatecalc+"))";

							 todatecalc="select  if("+startday+">(select day(("+todatecalc+"))),"+
									 " (SELECT DATE_ADD('"+todate+"',INTERVAL 1 month)),(select LAST_DAY((SELECT DATE_ADD('"+todate+"',INTERVAL 1 month)))))";	
*/								if(monthcalmethod==0){
								todatecalc="select LAST_DAY((SELECT DATE_ADD('"+todate+"',INTERVAL '"+monthcalvalue+"' DAY)))";
							}
							else if(monthcalmethod==1){
								todatecalc="select LAST_DAY((SELECT DATE_ADD('"+todate+"',INTERVAL 1 MONTH)))";
							}
						 }
						 if(samedatestatus==0){
				if(invtype==2){
				int remainday=0;
				int sameday=0;
				Statement stmtremain=conn.createStatement();
				String check="select if("+startday+">(select day(("+todatecalc+"))),"+startday+"-(select day(("+todatecalc+"))),0) remainday,if(day("+todatecalc+")=day(last_day("+todatecalc+")),1,0) sameday";

				System.out.println("Get Remainday Query: "+check);
				ResultSet rsremain=stmtremain.executeQuery(check);
				while(rsremain.next()){
					remainday=rsremain.getInt("remainday");
					sameday=rsremain.getInt("sameday");
				}
				if(sameday==1){
					todatecalc="select last_day("+todatecalc+")";
				}
				else if(remainday>0){
					todatecalc="select date_add("+todatecalc+",interval "+remainday+" day)";
						System.out.println("check todatecalc: "+todatecalc);
				}
				else {
					System.out.println("/////////Else//////////");
					if(invtype==2 && oneDayExtraConfig==1 && samedatestatus==0){
						if(oneDayExtraConfig==1){
							 String strbegindate="select a.begindatestatus,if(a.begindatestatus=1,last_day(date_add('"+todate+"',"+
						 " interval 1 day)),date_add('"+todate+"', interval 1 month)) begindate  from ("+
						 " SELECT if(date_add('"+temptodate+"',interval -DAY('"+temptodate+"')+1 DAY)='"+temptodate+"',1,0) begindatestatus)a";
							 System.out.println("Cheking dates:"+strbegindate);
							 Statement stmtbegin=conn.createStatement();
							 ResultSet rsbegindate=stmtbegin.executeQuery(strbegindate);
							 while(rsbegindate.next()){
								 todatecalc=" select '"+rsbegindate.getDate("begindate")+"'";
							 }
						 }
					}
				}

				stmtremain.close();

			}
			}
			System.out.println("Checking configs"+invtype+"//"+oneDayExtraConfig+"//"+samedatestatus);
			

						 if(closestatus==0){
							String strupdate="update gl_lagmt set invdate='"+todate+"',invtodate=("+todatecalc+") where doc_no="+agmtno;
							if(invtype==3){
								 String quarterlytodate="";
								 if(monthcalmethod==1){
									 quarterlytodate="date_add(invtodate,interval 3 month)";
								 }
								 else{
									 quarterlytodate="date_add(invtodate,interval "+monthcalvalue+" day)";
								 }
								 strupdate="update gl_lagmt set invdate='"+todate+"',invtodate="+quarterlytodate+" where doc_no="+agmtno;
							 }
							 int agmtupdate=stmtinvoice.executeUpdate(strupdate);
							 if(agmtupdate<0){
								 System.out.println("Lagmt Error");
								 return 0;
							 }
						 }
					 }

					 if(!(origin.trim().equalsIgnoreCase("1"))){
						 if(invoice[0].equalsIgnoreCase("18") && Double.parseDouble(invoice[5])>0){
							 Statement stmtotherincome=conn.createStatement();
							 //System.out.println("Inside Other Income Update SQL");
							 String strotherincome="update gl_lothser set invno="+aaa+",invstatus=1 where rdocno="+agmtno+" and invstatus=0";
							 int otherincomeval=stmtotherincome.executeUpdate(strotherincome);
							 if(otherincomeval<0){
								 //				System.out.println("OtherIncome Update error");
								 //conn.close();
								 System.out.println(" Update Other Income Error");
								 return 0;
							 }
						 }

					 }

				 }//Closing for Origin


				 
				 
				 if(invoice[0].equalsIgnoreCase("8") || invoice[0].equalsIgnoreCase("14")){
					 salikamt+=Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5]));
					 salikcount++;
					 salikqty=invoice[3];
					 if(invoice[0].equalsIgnoreCase("14")){
						 saliksrvc=Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5]));
					 }
				 }

				 else if(invoice[0].equalsIgnoreCase("9") || invoice[0].equalsIgnoreCase("15")){
					 trafficamt+=Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5]));
					 trafficcount++;
					 trafficqty=invoice[3];
					 if(invoice[0].equalsIgnoreCase("15")){
						 trafficsrvc=Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5]));
					 }
				 }
				 //trafficldr=testcurrate*trafficamt;

				 else{
					 generalamt=objcommon.Round(generalamt+Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5])),2);
					 //			System.out.println("Check General Amount:"+generalamt);
				 }
				 salikldr=testcurrate*salikamt;
				 trafficldr=testcurrate*trafficamt;
				 generalldr=testcurrate*generalamt;

				 String sqljv2="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
						 "doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype)values('"+testtrno+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"',"+
						 "'"+partydramt+"','"+testcurrate+"','"+testcurid+"',0,-1,'"+(i+1)+"',"+
						 "'"+branchid+"','"+note+"',"+
						 "0,'"+date+"','"+formdetailcode+"','"+partyldramt+"','"+aaa+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"',"+
						 "'"+testcurid+"','5',1,0,3,'"+agmtno+"','"+cmbagmttype+"')";
				 //		System.out.println("SqlJV2"+sqljv2);
				 int rsjv2=stmtinvoice.executeUpdate(sqljv2);
				 if(rsjv2>0){


					 Statement stmtcostentry=conn.createStatement();
					 String strcostentry="select costentry from gl_invmode where acno="+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1]);
					 int costentry=0;
					 ResultSet rscostentry=stmtcostentry.executeQuery(strcostentry);
					 while(rscostentry.next()){
						 costentry=rscostentry.getInt("costentry");
					 }
					 if(costentry==1){
						 Statement stmtgettran=conn.createStatement();
						 String strgettran="select tranid from my_jvtran where acno="+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+" and tr_no="+testtrno;
						 //	System.out.println("GetTran Query:"+strgettran);
						 ResultSet rsgettran=stmtgettran.executeQuery(strgettran);
						 int temptranid=0;
						 while(rsgettran.next()){
							 temptranid=rsgettran.getInt("tranid");
						 }
						 int count=0;
						 ArrayList<String> costmovarray=new ArrayList<String>();
						 Statement stmtcostmov=conn.createStatement();
						 double temptimediff=0.0;
						 String tempcostfleet="";
						 String strtemptimediff="select (TIMESTAMPDIFF(second,'"+fromdate+" 00:00:00' ,'"+todate+" 23:59:59'))/(60*60) temptimediff";
						 Statement stmttemptimediff=conn.createStatement();
						 //			System.out.println("TemptimeDiff Sql:"+strtemptimediff);
						 ResultSet rstemptimediff=stmtcostmov.executeQuery(strtemptimediff);
						 while(rstemptimediff.next()){
							 temptimediff=rstemptimediff.getDouble("temptimediff");

						 }
						 //			System.out.println("TimeDiffer In Hours:"+temptimediff);
						 stmttemptimediff.close();
						 String strcostmov="";
						 if(damagedtype.equalsIgnoreCase("IND")){
							 strcostmov="select 0 hourdiff,rfleet fleet_no from gl_vinspm where doc_no="+damageinspno;
							 //System.out.println("Damage Get Cost Entry Query: "+strcostmov);
						 }
						 else{
							 strcostmov="select sum(aa.hourdiff) hourdiff,aa.fleet_no from("+
									 " select (TIMESTAMPDIFF(second,dout ,din))/(60*60) hourdiff,fleet_no,kk.repno from ("+
									 " select repno,fleet_no,if(dout<'"+fromdate+"',cast(concat('"+fromdate+" 00:00:00') as datetime),cast(concat(dout,' ',tout) as datetime))"+
									 " dout,tout,if(din>'"+todate+"',cast(concat('"+todate+" 23:59:59') as datetime),cast(coalesce(concat(din,' ',tin),'"+todate+" 23:59:59') as datetime)) din,tin"+
									 " from gl_vmove where rdocno="+agmtno+" and rdtype='"+cmbagmttype+"'  and trancode<>'DL'  and (dout between '"+fromdate+"' and '"+todate+"' or  coalesce(din,'"+todate+"')"+
									 " between '"+fromdate+"' and '"+todate+"')) kk)aa group by aa.fleet_no ";
							 /*String strcostmov="select (TIMESTAMPDIFF(second,dout ,coalesce(din,'"+todate+"')))/(60*60) hourdiff,fleet_no,kk.repno from ("+
				" select repno,fleet_no,if(dout<'"+fromdate+"',cast(concat('"+fromdate+" 00:00:00') as datetime),cast(concat(dout,' ',tout)"+
				" as datetime)) dout,tout,if(din>'"+todate+"',cast(concat('"+todate+" 23:59:59') as datetime),cast(concat(din,' ',tin) as datetime))"+
				" din,tin from gl_vmove where rdocno="+agmtno+" and rdtype='"+cmbagmttype+"' and (dout between '"+fromdate+"' and '"+todate+"' or "+
				" coalesce(din,'"+todate+"') between '"+fromdate+"' and '"+todate+"') group by fleet_no )kk";*/
							 //System.out.println("Cost Mov Sql:"+strcostmov);
						 }
						 ResultSet rscostmov=stmtcostmov.executeQuery(strcostmov);
						 int counter=0;
						 while(rscostmov.next()){

							 //count=rscostmov.getInt("repno");
							 //	if(count==0){
							 costmovarray.add(rscostmov.getString("hourdiff")+""+"::"+rscostmov.getString("fleet_no"));
							 //System.out.println(rscostmov.getString("hourdiff")+""+"::"+rscostmov.getString("fleet_no"));
							 counter++;
							 /*	}
			if(count>0){
				double tempamt=(Double.parseDouble(rscostmov.getString("hourdiff"))/temptimediff)*partydramt;
				costmovarray.add(tempamt+""+"::"+rscostmov.getString("fleet_no"));

			}*/


						 }
						 stmtcostmov.close();
						 Statement stmtcostinsert=conn.createStatement();
						 for(int j=0;j<costmovarray.size();j++){
							 //				System.out.println("============================================="+i);
							 if(counter==1){

								 String costmov=costmovarray.get(j);
								 String costmovamt=costmov.split("::")[0];
								 String costmovfleet=costmov.split("::")[1];
								 String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"'"+
										 ",6,"+partydramt+","+srno+","+temptranid+",0,"+costmovfleet+","+testtrno+")";
								 //System.out.println("Insert Costtran Sql:"+strcostinsert);
								 srno++;
								 int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
								 if(costinsertval<0){
									 //conn.close();
									 System.out.println("Cost Insert Error");
									 return 0;
								 }

							 }
							 else if(counter>1){
								 String costmov=costmovarray.get(j);
								 String costmovamt=costmov.split("::")[0];
								 String costmovfleet=costmov.split("::")[1];
								 double amt=(Double.parseDouble(costmovamt)/temptimediff)*partydramt;
								 //System.out.println("Total Amt:"+amt+":::costmovamt="+costmovamt+":::::::::TempTime Diff="+temptimediff+":::::::::Amount="+partydramt);
								 String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"'"+
										 ",6,"+amt+","+srno+","+temptranid+",0,"+costmovfleet+","+testtrno+")";
								 //			System.out.println("Insert Costtran Sql:"+strcostinsert);
								 srno++;
								 int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
								 if(costinsertval<0){
									 //conn.close();
									 System.out.println("Cost Insert Error2");
									 return 0;
								 }

							 }
						 }
						 stmtcostinsert.close();

					 }
					 else{

					 }

				 }	

				 else{
					 //			System.out.println("General Jvtran error");
					 //conn.close();
					 System.out.println("Jvtran Error");
					 return 0;
				 }


			 }
			 tempno++;	
		}

		if(ismssend>0){

			//sendSMS(aaa+"", branchid, dtype, smsamount+"", hidclient,"",conn);

		}

		if(salikamt>0){
			//		System.out.println("SalikAMt: "+salikamt+"::::::::::::::::Origin: "+origin.trim().equalsIgnoreCase("")+"========="+origin.trim()+"////////");
			if(!(origin.trim().equalsIgnoreCase("1"))){
				Statement stmtsalik=conn.createStatement();
				//System.out.println("Heere inside salik");
				String strupdatesalik="";
				if(invoicetypeno==8){
					strupdatesalik="update gl_salik set inv_no="+aaa+",inv_type='INV',status=1 where ra_no="+agmtno+" and isallocated=1 and rtype "+rtype+" and "+
							" sal_date>='"+fromdate+"' and sal_date<='"+todate+"' and inv_no=0";	
				}
				else{
					strupdatesalik="update gl_salik set inv_no="+aaa+",inv_type='INV',status=1 where ra_no="+agmtno+" and  isallocated=1 and rtype "+rtype+" and "+
							" sal_date<='"+todate+"' and inv_no=0";	
				}
				//		System.out.println("Update Salik:"+strupdatesalik);
				int val=stmtsalik.executeUpdate(strupdatesalik);
				if(val<0){
					System.out.println("Salik Update Error");
					//conn.close();

					return 0;
				}


			}//Closing for origin (salik update)
			String saliknote=""+salikqty+" Saliks";
			/*String saliknote=note;*/
			if(invdescconfig==1){
				String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
				//saliknote="Salik Charges "+temprenttype+" - "+agmtvocno+" MRA - "+agmtrefno+" NOS - "+salikcount;
				//Overridden for WORLDRAC on 04/05/2017
				String strfromdate="",strtodate="";
				if(fromdate!=null){
					strfromdate=objcommon.changeSqltoString(fromdate);
				}
				if(todate!=null){
					strtodate=objcommon.changeSqltoString(todate);
				}
				saliknote=salikqty+" Saliks of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate+""+" with Reg No "+agmtregno;
			}
			saliksrvcvat=manualdao.getSalikTrafficVAT(conn,"Salik",saliksrvc,hidclient,date,branchid);
			salikamt+=saliksrvcvat;
			salikldr=salikamt*testcurrate;
			String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
					"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+acno+"',"+
					"'"+salikamt+"','"+testcurrate+"','"+testcurid+"',0,1,8,"+
					"'"+branchid+"','"+saliknote+"',"+
					"0,'"+date+"','"+formdetailcode+"','"+salikldr+"','"+aaa+"','"+qty2+"',"+
					"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
			//System.out.println("SqlJV"+sqljv);
			int rsjv=stmtinvoice.executeUpdate(sqljv);
			if(rsjv>0){

			}
			else{
				System.out.println("Jvtran salik Error");
				return 0;
			}
		}

		if(trafficamt>0){
		//	System.out.println("==trafficamt==="+trafficamt);
		//	System.out.println("==origin.trim()==="+origin.trim());
			String temptrafficdesc="";
			if(!(origin.trim().equalsIgnoreCase("1"))){
				Statement stmttraffic=conn.createStatement();
				String strupdatetraffic="";
				int saperateinvtraffic=0;
				String strsaperateinvtraffic="select method from gl_config where field_nme='saperateInvTraffic'";
				ResultSet rssaperateinvtraffic=stmttraffic.executeQuery(strsaperateinvtraffic);
				while(rssaperateinvtraffic.next()){
					saperateinvtraffic=rssaperateinvtraffic.getInt("method");
				}
				if(invoicetypeno==9){
					if(saperateinvtraffic==0){
						strupdatetraffic="update gl_traffic set inv_no="+aaa+",inv_desc='"+trafficdesc+"',inv_type='INV',status=1 where ra_no="+agmtno+" and isallocated=1  and rtype "+rtype+" and emp_type='CRM' and traffic_date>='"+fromdate+"' and traffic_date <= '"+todate+"' and inv_no=0";
					}
						
				}
				else{
					strupdatetraffic="update gl_traffic set inv_no="+aaa+",inv_desc='"+trafficdesc+"',inv_type='INV',status=1 where ra_no="+agmtno+" and isallocated=1  and rtype "+rtype+" and emp_type='CRM' and traffic_date <= '"+todate+"' and inv_no=0";
				}
//				System.out.println("strupdatetraffic :"+strupdatetraffic);
				//System.out.println("Update Traffic:"+strupdatetraffic);
				if(!strupdatetraffic.equalsIgnoreCase("")){
					int val=stmttraffic.executeUpdate(strupdatetraffic);
					//System.out.println("Update Traffic Val:"+val+":::"+strupdatetraffic);
					if(val<0){
						System.out.println("Traffic Update Error");
						//conn.close();
						return 0;
					}
				}
				
				
				
				try
				{
					String  traffic_date="";
					
					String sql="select concat(ticket_no,' - ',DATE_FORMAT(traffic_date, '%d-%m-%Y')) trafficdesc,concat(ticket_no,' REG.NO ',regno ,' at ',DATE_FORMAT(traffic_date, '%d-%m-%Y'),' ',time) as trdates from gl_traffic t where inv_no='"+aaa+"'";
					Statement stmt=conn.createStatement();
					ResultSet rs1 = stmt.executeQuery(sql);

//					System.out.println("select concat(ticket_no,' against ',regno,' at ',DATE_FORMAT(traffic_date, '%d-%m-%Y'),' ',time) as trdates from gl_traffic t where inv_no='"+aaa+"'");

					int k=0;
					while(rs1.next())
					{
						
						if(k==0){
							traffic_date=rs1.getString("trdates");
							temptrafficdesc+=rs1.getString("trafficdesc");
						}
						else{
							traffic_date=traffic_date+","+rs1.getString("trdates");
							temptrafficdesc+=","+rs1.getString("trafficdesc");
						}

						k++;

					}
					
					rs1.close();
					//sendSMS(aaa+"", branchid, dtype, trafficamt+"", hidclient,traffic_date,conn);
				}catch(Exception e){e.printStackTrace();}


			}//Closing for origin (Traffic Update)

			String trafficnote=""+trafficqty+" Traffics";
			//String trafficnote=note;
			if(invdescconfig==1){
				// System.out.println("Inside Traffic Description");
				String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
				//trafficnote=temptrafficdesc+" - "+temprenttype+" - "+agmtvocno+" MRA - "+agmtrefno;
				//Overridden for WORLDRAC on 04/05/2017
				String strfromdate="",strtodate="";
				if(fromdate!=null){
					strfromdate=objcommon.changeSqltoString(fromdate);
				}
				if(todate!=null){
					strtodate=objcommon.changeSqltoString(todate);
				}
				trafficnote=trafficqty+" Traffics of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate+" with Reg No "+agmtregno;
			}
			// System.out.println("description ==== "+trafficnote);
			trafficsrvcvat=manualdao.getSalikTrafficVAT(conn,"Traffic",trafficsrvc,hidclient,date,branchid);
			trafficamt+=trafficsrvcvat;
			trafficldr=trafficamt*testcurrate;
			String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
					"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+acno+"',"+
					"'"+trafficamt+"','"+testcurrate+"','"+testcurid+"',0,1,9,"+
					"'"+branchid+"','"+trafficnote+"',"+
					"0,'"+date+"','"+formdetailcode+"','"+trafficldr+"','"+aaa+"','"+qty2+"',"+
					"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
			//	System.out.println("SqlJV"+sqljv);
			int rsjv=stmtinvoice.executeUpdate(sqljv);
			if(rsjv>0){

			}
			else{
				System.out.println("Jvtran Traffic Error");
				//conn.close();
				return 0;
			}
		}


		//Tax Portion Starts Here
		//	System.out.println("Default General Amount:"+generalamt);
		//if(!(origin.trim().equalsIgnoreCase("1"))){
			Statement stmtchecktax=conn.createStatement();
			String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+hidclient+" and dtype='CRM') clienttaxmethod";
			System.out.println(strchecktax);
			ResultSet rschecktax=stmtchecktax.executeQuery(strchecktax);
			int taxstatus=0;
			int clienttaxmethod=0;
			while(rschecktax.next()){
				taxstatus=rschecktax.getInt("taxmethod");
				clienttaxmethod=rschecktax.getInt("clienttaxmethod");
			}
			if(taxstatus==1 && clienttaxmethod==1){
					System.out.println("Inside TaxDetail");
				
				// Getting amount in which tax is applicable
				Statement stmtgettax=conn.createStatement();
				String strtaxapplied="select total from gl_invd inv left join gl_invmode ac on inv.chid=ac.idno where ac.tax=1 and inv.rdocno="+aaa;
				ResultSet rsapplied=stmtgettax.executeQuery(strtaxapplied);
				double generalamttax=0.0;
				while(rsapplied.next()){
					generalamttax+=rsapplied.getDouble("total");
				}
				int igststatus=0;
				if(cmbagmttype.equalsIgnoreCase("RAG")){
					String strigst="select igststatus from gl_ragmt where doc_no="+agmtno;
					ResultSet rsigst=stmtchecktax.executeQuery(strigst);
					while(rsigst.next()){
						igststatus=rsigst.getInt("igststatus");
					}
				}
				String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+date+"' between tax.fromdate and tax.todate";
				System.out.println("Tax Percent Query: "+strgettax);
				double setpercent=0.0;
				double vatpercent=0.0;
				ResultSet rsgettax=stmtgettax.executeQuery(strgettax);
				double vatval=0.0,setval=0.0;
				ArrayList<String> temptaxarray=new ArrayList<>();
				while(rsgettax.next()){
					setpercent=rsgettax.getDouble("set_per");
					vatpercent=rsgettax.getDouble("vat_per");
					vatval=(generalamttax*(vatpercent/100));
					setval=generalamttax*(setpercent/100);
					setval=objcommon.Round(setval, 2);
					vatval=objcommon.Round(vatval, 2);
					if(igststatus==1){
						if(rsgettax.getInt("idno")==21){
							if(setval>0.0){
								temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+setval+"::"+rsgettax.getString("description"));
								generalamt+=setval;
							}
						}
					}
					else{
						if(rsgettax.getInt("idno")==19 || rsgettax.getInt("idno")==20){
							if(vatval>0.0){
								temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+vatval+"::"+rsgettax.getString("description"));
								System.out.println("Before: "+generalamt+"///"+vatval);
								generalamt+=vatval;
								System.out.println("Before: "+generalamt+"///"+vatval);
							}
						}
					}
				}
				if(setpercent>0.0 || vatpercent>0.0){
					
					/*if(damageamount>0){
						//System.out.println("Damage amount: "+damageamount+"//////General Amount: "+generalamt);
						vatval=((generalamt-damageamount)*(vatpercent/100));	

					}
					else{
						vatval=(generalamttax*(vatpercent/100));
					}*/
					//setval=objcommon.Round(setval, 2);
					//vatval=objcommon.Round(vatval, 2);
					//generalamt=generalamt+setval;
					generalamt-=saliksrvcvat;
					generalamt-=trafficsrvcvat;
					generalamt=objcommon.Round(generalamt, 2);

					
					//generalamt=generalamt+vatval;
					generalamt=objcommon.Round(generalamt, 2);
					generalldr=generalamt*testcurrate;

					/*Statement stmtgetinvmode=conn.createStatement();
					String strgetinvmode="select (select acno from gl_invmode where idno=19) setacno,(select acno from gl_invmode where idno=20) vatacno";
					ResultSet rsinvmode=stmtgetinvmode.executeQuery(strgetinvmode);
					ArrayList<String> temptaxarray=new ArrayList<>();
					while(rsinvmode.next()){
						temptaxarray.add(19+"::"+rsinvmode.getString("setacno")+"::"+setval+"::"+"SET");
						temptaxarray.add(20+"::"+rsinvmode.getString("vatacno")+"::"+vatval+"::"+"VAT");
					}*/
					int tempsrno=invoicearray.size()+1;
					for(int j=0;j<temptaxarray.size();j++){
						String[] tax=temptaxarray.get(j).split("::");
						Statement stmttaxinvd=conn.createStatement();
						if(Double.parseDouble(tax[2])>0){
							String strtaxinvd="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+tempsrno+"','"+branchid+"','"+aaa+"'"+
									",'"+testtrno+"','"+(tax[0].equalsIgnoreCase("undefined") || tax[0].isEmpty()?0:tax[0])+"','1','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"')";	
										System.out.println("Invd Sql:"+strtaxinvd);
							int taxinvdval=stmttaxinvd.executeUpdate(strtaxinvd);
							if(taxinvdval>0){
								String strtaxjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
										"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype)values('"+testtrno+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"',"+
										"'"+Double.parseDouble(tax[2])*-1+"','"+testcurrate+"','"+testcurid+"',0,-1,'"+(tempsrno)+"',"+
										"'"+branchid+"','"+note+"',"+
										"0,'"+date+"','"+formdetailcode+"','"+(Double.parseDouble(tax[2])*testcurrate)*-1+"','"+aaa+"','"+(tax[3].equalsIgnoreCase("undefined") || tax[3].isEmpty()?0:tax[3])+"',"+
										"'"+testcurid+"','5',1,0,3,'"+agmtno+"','"+cmbagmttype+"')";
								tempsrno++;
								Statement stmttaxjv=conn.createStatement();
												System.out.println("Jvtran Sql:"+strtaxjv);
								int taxjvval=stmttaxjv.executeUpdate(strtaxjv);
								if(taxjvval>0){

								}
								else{
									System.out.println("Jvtran Tax Error");
									return 0;
								}
								stmttaxjv.close();
								stmttaxinvd.close();
							}
							else{
								System.out.println("Tax Invd Error");
								return 0;
							}
						}
					}
					stmtchecktax.close();
					//stmtgetinvmode.close();
					stmtgettax.close();
				}

			}


		//}//Closing for origin (Tax)
		//If Tax Method is Disabled in gl_config
		if(generalamt>0){

			int discountconfig=manualdao.getDiscountConfig(conn);
			double ramt=0.0;
			double discount=0.0;
			double discountldr=0.0;
			if(discountconfig==1){
				ramt=Math.round(generalamt);
				discount= (generalamt-ramt);
				discount=objcommon.Round(discount, 2);
				discountldr=discount*testcurrate;
			}
			else{
				ramt=generalamt;
				
			}
			double ramtldr=ramt*testcurrate;
			// discount a/c jvtran  discount*-1   
			Statement stmtdiscount=conn.createStatement();
			String strdiscount="select acno discountacno from gl_invmode where idno=13";
			ResultSet rsdiscount=stmtdiscount.executeQuery(strdiscount);
			int  discac=0;
			while(rsdiscount.next()){
				discac=rsdiscount.getInt("discountacno");
			}
			if(discount!=0.0){
				Statement stmtdiscjv=conn.createStatement();
				Statement stmtdiscinvd=conn.createStatement();
				String sql="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(tempno+1)+"','"+branchid+"','"+aaa+"'"+
						",'"+testtrno+"','13','1','"+(discount*-1)+"','"+discac+"','"+(discount*-1)+"')";
				int discinvd=stmtdiscinvd.executeUpdate(sql);
				if(discinvd<=0){
					stmtdiscinvd.close();
					stmtdiscjv.close();
					stmtdiscount.close();
					conn.close();
					return 0;
				}
				stmtdiscinvd.close();
							System.out.println(" Invd Sql"+sql);
				int discid=0;
				if(discount>0.0){
					discid=1;
				}
				else if(discount<0.0){
					discid=-1;
				}
				String sqljvdisc="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
						"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+discac+"',"+
						"'"+discount+"','"+testcurrate+"','"+testcurid+"',0,"+discid+",1,"+
						"'"+branchid+"','Discount',"+
						"0,'"+date+"','"+formdetailcode+"','"+discountldr+"','"+aaa+"','"+qty2+"',"+
						"'"+testcurid+"','5',1,0,3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
				int discval=stmtdiscjv.executeUpdate(sqljvdisc);
				if(discval<=0){
					stmtdiscjv.close();
					stmtdiscount.close();
					conn.close();
					return 0;

				}
				stmtdiscjv.close();
				stmtdiscount.close();
			}
			if(ramt>0){
				String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
						"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+acno+"',"+
						"'"+ramt+"','"+testcurrate+"','"+testcurid+"',0,1,1,"+
						"'"+branchid+"','"+note+"',"+
						"0,'"+date+"','"+formdetailcode+"','"+ramtldr+"','"+aaa+"','"+qty2+"',"+
						"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
						System.out.println("General Jv sql:"+sqljv);
				int rsjv=stmtinvoice.executeUpdate(sqljv);
				if(rsjv>0){
							System.out.println("Inside general jv");	
				}
				else{
					System.out.println("General jvtran error");
					//conn.close();
					return 0;
				}
			}
			
			stmtdiscount.close();
		}	
//		System.out.println("no====="+aaa);
		invoicebean.setDocno(aaa);
		String testjv1="select dramount from my_jvtran where tr_no="+testtrno;
		ResultSet rstestjv1=stmtinvoice.executeQuery(testjv1);
//					 System.out.println("Test Sum Jvtran"+testjv1);
			while(rstestjv1.next()){
//			System.out.println("jv vvalue"+rstestjv1.getDouble("dramount"));
			}
		if (aaa > 0) {
				
			//			System.out.println("InvNo > 0");

			String testjv="select sum(coalesce(dramount,0)) dramount from my_jvtran where tr_no="+testtrno;
			ResultSet rstestjv=stmtinvoice.executeQuery(testjv);
			//			System.out.println("Test Sum Jvtran"+testjv);
			while(rstestjv.next()){
				//	System.out.println("jv vvalue"+rstestjv.getDouble("dramount"));
				if(rstestjv.getDouble("dramount")==0.00){
					//	System.out.println("testjv"+rstestjv.getDouble("dramount"));
					//	System.out.println("Success"+invoicebean.getDocno());

					stmtinvoice.close();
					stmtManual.close();
					//	conn.close();
					return aaa;
				}
				else{
					stmtinvoice.close();
					stmtManual.close();
					//conn.close();
					System.out.println("Jv tally Error");
					return 0;
				}
			}

		}

	}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		System.out.println("Exception error");
		return 0;
	}
	return 0;
}
}
