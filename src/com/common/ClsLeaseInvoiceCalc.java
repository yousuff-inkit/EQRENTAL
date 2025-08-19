package com.common;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.*;
public class ClsLeaseInvoiceCalc {
	ClsConnection ClsConnection=new ClsConnection();

public  ArrayList<Double> getInvoiceCalc(String rano,String cldocno,Date fromdate,Date todate,String rentaltype,String invtype) throws SQLException{
	ArrayList<Double> invoicearray=new ArrayList<Double>();
Connection conn=ClsConnection.getMyConnection();
try {
	
	Statement stmt=conn.createStatement();
	int monthcal=0;
	String strfrom="";
	//System.out.println("==========="+rentaltype);
	int quarterlymethod=0,quarterlyvalue=0;
	if(rentaltype.equalsIgnoreCase("monthly")){
		if(invtype.equalsIgnoreCase("1")){
			strfrom="select if((select method from gl_config where field_nme='lesmonthlycal')=1,(select (DAY(LAST_DAY('"+todate+"')))) ,"+
					"(select value from gl_config where field_nme='lesmonthlycal')) monthcal";
//			System.out.println("================"+stmt);
			
			}
			if(invtype.equalsIgnoreCase("2")){
		//Monthcal Calculation for Period
				//select lastday of fromdate if monthend of both months are same else select lastday of todate
				/*
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
					
						strcheckdate="select if(delivery=1 and delstatus=1,(select din from gl_vmove where rdocno="+rano+" and rdtype='LAG' and "+
					"  trancode='DL' and repno=0),outdate) temptodate from gl_lagmt where doc_no="+rano;	
					
					
				}
				//When Outdate is considered
				else{
					
					
						strcheckdate="select outdate temptodate from gl_lagmt where doc_no="+rano;
					
				}
				System.out.println("Check Date Query: "+strcheckdate);
				ResultSet rstemptodate=stmtdelcal.executeQuery(strcheckdate);
				while(rstemptodate.next()){
					temptodate=rstemptodate.getDate("temptodate");
				}
				
				
				
				
				
				strfrom="select if((select method from gl_config where field_nme='lesmonthlycal')=1,(select if(DAY(LAST_DAY('"+temptodate+"'))=DAY('"+temptodate+"'),"+
						" DAY(LAST_DAY('"+todate+"')),DAY(LAST_DAY('"+fromdate+"')))) ,(select value from gl_config where field_nme='lesmonthlycal')) monthcal";
				*/
					strfrom="select if((select method from gl_config where field_nme='lesmonthlycal')=1,"+
						" datediff('"+todate+"','"+fromdate+"'),(select value from gl_config where field_nme='lesmonthlycal')) monthcal";
				
		

			}
			if(invtype.equalsIgnoreCase("3")){
				strfrom="select if((select method from gl_config where field_nme='lesmonthlycal')=1,"+
						" datediff('"+todate+"','"+fromdate+"'),(select value from gl_config where field_nme='lesmonthlycal')) monthcal";
				String strquarterly="select (select method from gl_config where field_nme='lesmonthlycal) method,"+
						" (select value from gl_config where field_nme='lesmonthlycal) value";
				ResultSet rsquarterly=stmt.executeQuery(strquarterly);
				
				while(rsquarterly.next()){
					quarterlymethod=rsquarterly.getInt("method");
					quarterlyvalue=rsquarterly.getInt("value");
				}
			}
			ResultSet rs=stmt.executeQuery(strfrom);
			while(rs.next()){
				monthcal=rs.getInt("monthcal");
			}
		/*ResultSet rs=stmt.executeQuery("select if((select method from gl_config where field_nme='monthlycal')=1,(select (DAY(LAST_DAY('"+todate+"')))) ,"+
				"(select value from gl_config where field_nme='monthlycal')) monthcal");
		System.out.println("================"+stmt);
		while(rs.next()){
			monthcal=rs.getInt("monthcal");
		}*/
		
	}
	ClsManualInvoiceDAO invoicedao=new ClsManualInvoiceDAO();
	int oneDayExtraConfig=invoicedao.getOneDayExtraConfig(conn);
	String strgetagmtdata="select (select inv_type invtype from gl_lagmt where doc_no="+rano+") invtype,'Monthly' rentaltype,(select count(*) from gl_invm where rano="+rano+" and ratype='LAG') invcount";
	int invtypeno=0;
	String agmttype="";
	int invcount=0;
	ResultSet rsgetagmtdata=stmt.executeQuery(strgetagmtdata);
	while(rsgetagmtdata.next()){
		invtypeno=rsgetagmtdata.getInt("invtype");
		agmttype=rsgetagmtdata.getString("rentaltype");
		invcount=rsgetagmtdata.getInt("invcount");
		
	}
	String strtarifsum="select if((select method from gl_config where field_nme='lesmonthlycal')=1,(select (DAY(LAST_DAY('"+todate+"')))) ,"+
			"(select value from gl_config where field_nme='lesmonthlycal')) monthcal,"+
			" if("+oneDayExtraConfig+"=1 and "+invtypeno+"=1 and '"+agmttype+"'='Monthly' and "+invcount+"=0,DATEDIFF('"+todate+"','"+fromdate+"')+1,DATEDIFF('"+todate+"','"+fromdate+"')) datediff,"+
			" round(((select datediff)/(select "+monthcal+"))*rate,0) ratesum,round(((select datediff)/(select "+monthcal+"))*cdw,0) cdwsum,"+
			" round(((select datediff)/(select "+monthcal+"))*pai,0) paisum,round(((select datediff)/(select "+monthcal+"))*cdw1,0) cdw1sum,"+
			" round(((select datediff)/(select "+monthcal+"))*pai1,0) pai1sum,round(((select datediff)/(select "+monthcal+"))*gps,0) gpssum,"+
			" round(((select datediff)/(select "+monthcal+"))*babyseater,0) babyseatersum,round(((select datediff)/(select "+monthcal+"))*cooler,0)"+
			" coolersum ,((select ratesum)+(select cdwsum)+(select paisum)+(select cdw1sum)+(select pai1sum)) rentalsum,"+
			" ((select cdwsum)+(select paisum)+(select cdw1sum)+(select pai1sum)) inschgsum,"+
			" ((select gpssum)+(select babyseatersum)+(select coolersum)) accsum from gl_ltarif where rdocno="+rano+" and rstatus=0";

	if(invtype.equalsIgnoreCase("3")){
		strtarifsum="select DATEDIFF('"+todate+"','"+fromdate+"') datediff,"+
				" round(3*rate,0) ratesum,round(3*cdw,0) cdwsum,"+
				" round(3*pai,0) paisum,round(3*cdw1,0) cdw1sum,"+
				" round(3*pai1,0) pai1sum,round(3*gps,0) gpssum,"+
				" round(3*babyseater,0) babyseatersum,round(3*cooler,0)"+
				" coolersum ,((select ratesum)+(select cdwsum)+(select paisum)+(select cdw1sum)+(select pai1sum)) rentalsum,"+
				" ((select cdwsum)+(select paisum)+(select cdw1sum)+(select pai1sum)) inschgsum,"+
				" ((select gpssum)+(select babyseatersum)+(select coolersum)) accsum from gl_ltarif where rdocno="+rano+" and rstatus=0";
	}
//	System.out.println("Invoiccalc"+strtarifsum);
	//System.out.println("Date Difference :"+datediff);
	//System.out.println("From Date:"+fromdate+"     To Date:"+todate);
	ResultSet rstarifsum=stmt.executeQuery(strtarifsum);
	/*monthcal=0.0,*/
	double rentalsum=0.0,datediff=0.0,accsum=0.0,inschgsum=0.0;
	while(rstarifsum.next()){
		rentalsum=rstarifsum.getDouble("ratesum");
		datediff=rstarifsum.getDouble("datediff");
		accsum=rstarifsum.getDouble("accsum");
		//monthcal=rstarifsum.getDouble("monthcal");
		inschgsum=rstarifsum.getDouble("inschgsum");
	}
	invoicearray.add(rentalsum);
	invoicearray.add(accsum);
	invoicearray.add(inschgsum);
	conn.close();
} catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
	conn.close();
}
return invoicearray;
}

}
