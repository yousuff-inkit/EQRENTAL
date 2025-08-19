package com.dashboard.invoices.leasealmariah;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

public class ClsLeaseInvoiceCalcAlmariah {

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
		}
		if(invtype.equalsIgnoreCase("2")){
			//Monthcal Calculation for Period
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
	" round(((select datediff)/(select "+monthcal+"))*babyseater,0) babyseatersum,round(((select datediff)/(select "+monthcal+"))*cooler,0) coolersum ,"+
	" round(securitypass,0) securitypass,"+
	" round(fuel,0) fuel,"+
	" round(salik,0) salik,"+
	" round(safetyacc,0) safetyacc,"+
	" round(diw,0) diw,"+
	" round(hpd,0) hpd,"+
	" round(rateperexhr,0) rateperexhr,"+
	" ((select ratesum)+(select cdwsum)+(select paisum)+(select cdw1sum)+(select pai1sum)) rentalsum,"+
	" ((select cdwsum)+(select paisum)+(select cdw1sum)+(select pai1sum)) inschgsum,"+
	" ((select gpssum)+(select babyseatersum)+(select coolersum)) accsum from gl_ltarif where rdocno="+rano+" and rstatus=0";
	System.out.println(strtarifsum);
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
	double securitypass=0.0,fuel=0.0,salik=0.0,safetyacc=0.0,diw=0.0,hpd=0.0,rateperexhr=0.0;
	
	while(rstarifsum.next()){
		rentalsum=rstarifsum.getDouble("ratesum");
		datediff=rstarifsum.getDouble("datediff");
		accsum=rstarifsum.getDouble("accsum");
		rateperexhr=rstarifsum.getDouble("rateperexhr");
		//monthcal=rstarifsum.getDouble("monthcal");
		securitypass=rstarifsum.getDouble("securitypass");
		fuel=rstarifsum.getDouble("fuel");
		safetyacc=rstarifsum.getDouble("safetyacc");
		diw=rstarifsum.getDouble("diw");
		hpd=rstarifsum.getDouble("hpd");
	}
	double chaufferextra=0.0;
	String strgetovertime="select ((sum(ot)/60))*"+rateperexhr+" chaufferextra from gl_drtimesheethrs hrs left "+
	" join gl_lagmt agmt on hrs.aggno=agmt.doc_no left join gl_ldriver drv on hrs.drid=drv.drid"+
	" where hrs.aggno="+rano;
	ResultSet rsgetovertime=stmt.executeQuery(strgetovertime);
	while(rsgetovertime.next()){
		chaufferextra=rsgetovertime.getDouble("chaufferextra");
	}
	ClsManualInvoiceDAO manualdao=new ClsManualInvoiceDAO();
	double chaufchg=manualdao.getChaufferCharge(Integer.parseInt(rano), fromdate, todate, "LAG");
	String strgetdriver="select if(req.driver='Yes',1,0) driver from gl_lagmt agmt left join gl_masterlagm m on (agmt.masterreftype='MLA' and"+
	" agmt.masterrefno=m.doc_no) left join gl_masterlagd d on (m.doc_no=d.rdocno and d.sr_no=agmt.masterrefsrno) left join"+
	" gl_almariahleasecalcm calc on (m.reftype='QOT' and m.qotrefno=calc.doc_no) left join gl_almariahleasecalcreq req on"+
	" (req.rdocno=calc.doc_no and req.sr_no=agmt.masterrefsrno) where agmt.doc_no="+rano;
	System.out.println(strgetdriver);
	int drivercheck=0;
	ResultSet rsdrivercheck=stmt.executeQuery(strgetdriver);
	while(rsdrivercheck.next()){
		drivercheck=rsdrivercheck.getInt("driver");
	}
	invoicearray.add(rentalsum);
	invoicearray.add(accsum);
	invoicearray.add(inschgsum);
	invoicearray.add(securitypass);
	invoicearray.add(fuel);
	invoicearray.add(safetyacc);
	invoicearray.add(drivercheck==1?chaufchg:0.00);
	invoicearray.add(drivercheck==1?chaufferextra:0.00);
	conn.close();
} catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
	conn.close();
}
return invoicearray;
}

}
