package com.equipment.equipvehicledisposal;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsApplyDelete;
import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.common.ClsVatInsert;
import com.common.ClsAmountToWords;
import com.connection.ClsConnection;

public class ClsEquipVehicleDisposalDAO {
ClsEquipVehicleDisposalBean disposalbean=new ClsEquipVehicleDisposalBean();
ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();

public   JSONArray fleetSearch(String branch) throws SQLException {
    Connection conn =null;
    JSONArray RESULTDATA=new JSONArray();
	try {
		conn=objconn.getMyConnection();
		
		Statement stmtmovement = conn.createStatement();
		  if(!(branch.equalsIgnoreCase("0"))){
		        
        	String strSql="select veh.fleet_no,veh.flname,veh.reg_no,plate.code_name platecode,veh.ch_no chassisno  from gl_equipmaster veh left join gl_vehplate plate on veh.pltid=plate.doc_no where veh.brhid="+branch+" and tran_code='FS' and veh.fstatus='L' and statu<>7 and fleet_no not in"+
        			"(select fleetno from eq_vsaled d left join eq_vsalem m on m.doc_no=d.rdocno where d.salestatus=1 and d.returnstatus=0 and m.status=3)";
        	System.out.println("fleet search===="+strSql);
			ResultSet resultSet = stmtmovement.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmovement.close();
			conn.close();
		  }
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
//	System.out.println("RESULTDATA=========>"+RESULTDATA);
    return RESULTDATA;
}
public   JSONArray getSearchData(String docno,String date,String client,String cmbtype,String acno,String mobile,String branch) throws SQLException {
    Connection conn = null;
    JSONArray RESULTDATA=new JSONArray();
	try {
		conn=objconn.getMyConnection();
		java.sql.Date sqldate=null;
		String sqltest="";
		if(!(date.equalsIgnoreCase(""))){
			sqldate=objcommon.changeStringtoSqlDate(date);
		}
		if(!(docno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sale.voc_no like '%"+docno+"%'";
		}
		if(!(cmbtype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sale.type='"+cmbtype+"'";
		}
		if(!(acno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sale.acno like '%"+acno+"%'";
		}
		if(sqldate!=null){
			sqltest=sqltest+" and sale.date='"+sqldate+"'";
			
		}
		if(!(client.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+client+"%'";
		}
		if(!(mobile.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.per_mob like '%"+mobile+"%'";
		}
		 
			Statement stmtmovement = conn.createStatement();
			if(!(branch.equalsIgnoreCase("0"))){
        	String strSql="select sale.clientcurr clientcurrid,cur.c_name clientcurr,sale.currrate,sale.doc_no,sale.voc_no,sale.date,sale.acno,if(sale.type='S','Sale','Total Loss') typename,sale.type,sale.description,sale.trno,ac.refname,ac.address,ac.per_mob,ac.mail1,sale.cldocno,sale.brhid,sale.billtype from eq_vsalem sale left join"+
	        				" my_head head on sale.acno=head.doc_no left join my_acbook ac on (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join my_curr cur on cur.doc_no=sale.clientcurr where sale.status<>7 and sale.brhid='"+branch+"'"+sqltest+ " order by sale.doc_no";
//        	System.out.println("search======"+strSql);
			ResultSet resultSet = stmtmovement.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			
			stmtmovement.close();
			conn.close();
			return RESULTDATA;
			}
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
//	System.out.println("RESULTDATA=========>"+RESULTDATA);
    return RESULTDATA;
}

public   JSONArray clientSearch(String searchdate,String name,String docno,String acno,String mobile) throws SQLException {
    Connection conn = null;
    JSONArray RESULTDATA=new JSONArray();
	try {
		conn=objconn.getMyConnection();
		java.sql.Date sqldate=null;
		String sqltest="";
		if(!(searchdate.equalsIgnoreCase(""))){
			sqldate=objcommon.changeStringtoSqlDate(searchdate);
		}
		if(!(docno.equalsIgnoreCase("") || docno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and cldocno like '%"+docno+"%'";
		}
		if(sqldate!=null){
			sqltest=sqltest+" and date='"+sqldate+"'";
			
		}
		if(!(name.equalsIgnoreCase("") || name.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and refname like '%"+name+"%'";
		}
		if(!(acno.equalsIgnoreCase("") || acno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and acno like '%"+acno+"%'";
		}
		if(!(mobile.equalsIgnoreCase("") || mobile.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and per_mob like '%"+mobile+"%'";
		}
			Statement stmtmovement = conn.createStatement();
        	String strSql="select cldocno,refname,address,per_mob,acno,mail1,curid,cur.c_rate currrate,cur.code clientcurr from my_acbook a left join my_curr cur on cur.doc_no=a.curid where dtype='CRM' and a.status<>7"+sqltest;
//        	System.out.println(strSql);
			ResultSet resultSet = stmtmovement.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmovement.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
//	System.out.println("RESULTDATA=========>"+RESULTDATA);
    return RESULTDATA;
}



	public ClsEquipVehicleDisposalBean insert(Date sqlStartDate,  String cmbtype,
			String description, HttpSession session, String mode,ArrayList<String> disposalarray,
			String formdetailcode,String clientacno,String client,String days,String branch,HttpServletRequest request,String mdoc,String cmbbilltype,String clientcurr,double currrate) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			int docno1=0,trno=0,vocno=0;
//			System.out.println("Inside Dao");
			conn.setAutoCommit(false);	
			CallableStatement stmtDisposal = conn.prepareCall("{call eqdisposalmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtDisposal.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtDisposal.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtDisposal.registerOutParameter(12, java.sql.Types.INTEGER);
			stmtDisposal.setDate(1,sqlStartDate);
			stmtDisposal.setString(2,clientacno);
			stmtDisposal.setString(3, cmbtype);
			stmtDisposal.setString(4, description);
			stmtDisposal.setString(5,session.getAttribute("USERID").toString());
			stmtDisposal.setString(6,branch);
			stmtDisposal.setString(9,mode);
			stmtDisposal.setString(10,formdetailcode);
			stmtDisposal.setString(11,client);
			stmtDisposal.setString(13,cmbbilltype);
			stmtDisposal.setString(14,clientcurr);
			stmtDisposal.setDouble(15,currrate);

			stmtDisposal.executeQuery();
			docno1=stmtDisposal.getInt("docNo");
			trno=stmtDisposal.getInt("trNo1");
			vocno=stmtDisposal.getInt("vocno");
			request.setAttribute("VOCNO", vocno);
	//		System.out.println("sqlStartDate"+sqlStartDate+"///clientacno"+clientacno+"///cmbtype"+cmbtype+"///description"+description+"///branch"+branch+"///mode"+mode+"///formdetailcode"+formdetailcode+"///client"+client+"///userid"+session.getAttribute("USERID").toString()+"////Docno:"+docno1+"/////Trno:"+trno+"/////Vocno:"+vocno);
			if (docno1 > 0) {
				disposalbean.setTrno(trno);
//				System.out.println("no====="+docno1);
				disposalbean.setDocno(docno1);
//				System.out.println("Success"+disposalbean.getDocno());
//				System.out.println("Action Arrray length"+disposalarray.size());
				int j=insertdet(disposalarray,docno1,trno,conn,sqlStartDate,clientacno,mode,formdetailcode,session,client,days,branch,cmbbilltype,description);
				
					if(j>0){
						conn.commit();
						return disposalbean;
					}
					else{
						disposalbean.setDocno(0);
						
						return disposalbean;
					}
						
					}
			
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		return disposalbean;

}
	private  int insertdet(ArrayList<String> disposalarray,int docno,int trno,Connection conn,Date sqlStartDate,String clientacno,String mode,
			String formdetailcode,HttpSession session,String client,String days,String branch,String cmbbilltype,String description) throws SQLException {
		
		try {
//			System.out.println("Inside Insert Details");
			Statement stmtDisposal;
			int val=0;
			stmtDisposal = conn.createStatement ();
//			System.out.println(disposalarray.size());
			for(int i=0;i< disposalarray.size();i++){
				String[] disposal=disposalarray.get(i).split("::");
				System.out.println("Here="+disposal[3]);
			    java.sql.Date sqldate = null ;
			    String sqldates="";
		        if(!(disposal[3].equalsIgnoreCase("") || disposal[3].equalsIgnoreCase("undefined") || disposal[3].isEmpty() || disposal[3].equalsIgnoreCase("null"))){
		            sqldate=objcommon.changetstmptoSqlDate(disposal[3]);
		            sqldates="'"+sqldate+"'";
		        } 
		        else
		        {
		            sqldates=""+sqldate+"";
		        }
				String sql="insert into eq_vsaled(trno,rdocno,sr_no,fleetno,salesprice,dep_posted,pvalue,acdep,curdep,netval,salestatus,netbook,trsalesprice)values('"+trno+"','"+docno+"','"+(i+1)+"',"+
				"'"+(disposal[0].equalsIgnoreCase("undefined") || disposal[0].isEmpty()?0:disposal[0])+"','"+(disposal[2].equalsIgnoreCase("undefined") || disposal[2].isEmpty()?0:disposal[2])+"',"+
				" "+sqldates+",'"+(disposal[4].equalsIgnoreCase("undefined") || disposal[4].isEmpty()?0:disposal[4])+"',"+
				"'"+(disposal[5].equalsIgnoreCase("undefined") || disposal[5].isEmpty()?0:disposal[5])+"','"+(disposal[6].equalsIgnoreCase("undefined") || disposal[6].isEmpty()?0:disposal[6])+"',"+
				"'"+(disposal[7].equalsIgnoreCase("undefined") || disposal[7].isEmpty()?0:disposal[7])+"',1,'"+(disposal[8].equalsIgnoreCase("undefined") || disposal[8].isEmpty()?0:disposal[8])+"',"+
				"'"+(disposal[9].equalsIgnoreCase("undefined") || disposal[9].isEmpty()?0:disposal[9])+"')";
				String strupdateveh="update gl_equipmaster set fstatus='Z' where fleet_no="+(disposal[0].equalsIgnoreCase("undefined") || disposal[0].isEmpty()?0:disposal[0]);
				Statement stmtvehupdate=conn.createStatement();					
				System.out.println("Sql"+sql);
				 val = stmtDisposal.executeUpdate (sql);
				if(val<0){
					return 0;
				}
				if(val>0){
					int updateval=stmtvehupdate.executeUpdate(strupdateveh);
					java.sql.Date deprdate=null;
					String deprdates="";
					if(updateval>0){
					    if(!(disposal[3].equalsIgnoreCase("undefined") || disposal[3].equalsIgnoreCase("null") ||disposal[3].equalsIgnoreCase(null) ))
					    {
	                      deprdate =objcommon.changetstmptoSqlDate(disposal[3]);
					    }  
    
						String fleetno=(disposal[0].equalsIgnoreCase("undefined") || disposal[0].isEmpty()?0:disposal[0]).toString();
						double purchasevalue=Double.parseDouble((disposal[4].equalsIgnoreCase("undefined") || disposal[4].isEmpty()?0:disposal[4]).toString());
					    double accdepr=Double.parseDouble((disposal[5].equalsIgnoreCase("undefined") || disposal[5].isEmpty()?0:disposal[5]).toString());
					    double currdepr=Double.parseDouble((disposal[6].equalsIgnoreCase("undefined") || disposal[6].isEmpty()?0:disposal[6]).toString());
					    double salesprice=Double.parseDouble((disposal[2].equalsIgnoreCase("undefined") || disposal[2].isEmpty()?0:disposal[2]).toString());
					    double netvalue=Double.parseDouble((disposal[7].equalsIgnoreCase("undefined") || disposal[7].isEmpty()?0:disposal[7]).toString());
					    double netbook=Double.parseDouble((disposal[8].equalsIgnoreCase("undefined") || disposal[8].isEmpty()?0:disposal[8]).toString());
					    double trsalesprice=Double.parseDouble((disposal[9].equalsIgnoreCase("undefined") || disposal[9].isEmpty()?0:disposal[9]).toString());
   
					    int jvval=insertJVEntries(fleetno,sqlStartDate,deprdate,purchasevalue,accdepr,currdepr,salesprice,netvalue,clientacno,
					    		mode,formdetailcode,session.getAttribute("USERID").toString(),branch,session.getAttribute("CURRENCYID").toString(),
					    		client,docno,trno,netbook,conn,cmbbilltype,trsalesprice,description);
						/*CallableStatement stmtDisposalJv = conn.prepareCall("{call disposalJvDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						stmtDisposalJv.setString(1,(disposal[0].equalsIgnoreCase("undefined") || disposal[0].isEmpty()?0:disposal[0]).toString());
						stmtDisposalJv.setDate(2,sqlStartDate);
						stmtDisposalJv.setDate(3,objcommon.changetstmptoSqlDate((disposal[3].equalsIgnoreCase("undefined") || disposal[3].isEmpty()?0:disposal[3]).toString()));
						stmtDisposalJv.setString(4, (disposal[4].equalsIgnoreCase("undefined") || disposal[4].isEmpty()?0:disposal[4]).toString());
						stmtDisposalJv.setString(5,(disposal[5].equalsIgnoreCase("undefined") || disposal[5].isEmpty()?0:disposal[5]).toString());
						stmtDisposalJv.setString(6,(disposal[6].equalsIgnoreCase("undefined") || disposal[6].isEmpty()?0:disposal[6]).toString());
						stmtDisposalJv.setString(7,(disposal[2].equalsIgnoreCase("undefined") || disposal[2].isEmpty()?0:disposal[2]).toString());
						stmtDisposalJv.setString(8,(disposal[7].equalsIgnoreCase("undefined") || disposal[7].isEmpty()?0:disposal[7]).toString());
						stmtDisposalJv.setString(9,clientacno);
						stmtDisposalJv.setString(10,mode);
						stmtDisposalJv.setString(11,formdetailcode);
						stmtDisposalJv.setString(12,session.getAttribute("USERID").toString());
						stmtDisposalJv.setString(13,branch);
						stmtDisposalJv.setString(14,session.getAttribute("CURRENCYID").toString());
						stmtDisposalJv.setString(15,client);
						stmtDisposalJv.setInt(16,docno);
						stmtDisposalJv.setInt(17,trno);
						stmtDisposalJv.setString(18,null);
						stmtDisposalJv.setString(19,(disposal[8].equalsIgnoreCase("undefined") || disposal[8].isEmpty()?0:disposal[8]).toString());
//						System.out.println("Statement:"+stmtDisposalJv);
						int jvval=stmtDisposalJv.executeUpdate();*/
//						System.out.println("JV value"+jvval);
						if(jvval<=0){
							return 0;
						}
					}
					else{
						return 0;
					}
				}
				
			}
			return val;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return 0;
		// TODO Auto-generated method stub
		
	}
	private int insertJVEntries(String fleetno, Date sqlStartDate,
			Date deprdate, double purchasevalue, double accdepr,
			double currdepr, double salesprice, double netvalue,
			String clientacno, String mode, String formdetailcode,
			String userid, String branch, String curid, String cldocno,
			int docno, int trno, double netbook, Connection conn,String cmbbilltype,double trsalesprice,String desc) {
		// TODO Auto-generated method stub
		
		try{
			Statement stmt=conn.createStatement();
			int vehacno=0,vadacno=0,vdeacno=0,netacno=0,cvsacno=0,srno=0,vsexp=0,vsexpacno=0,netid=0,taxacno=0,tax=0,
					clienttax=0,doubleentry=0;
			double currate=0.0,testdramt=0.0,testldramt=0.0,vatpercent=0.0,taxamt=0.0,taxamt2=0.0;
			String note="";
			String regno="";
			if(mode.equalsIgnoreCase("A")){
				srno++;
				String strgetdata="select (select reg_no from gl_equipmaster  where fleet_no="+fleetno+") regno,"+
				" (select coalesce(max(doc_no)+1,1) from eq_vsalem) docno,"+
				" (select coalesce(max(trno)+1,1) from my_trno) trno,"+
				" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='EVEH') vehacno,"+
				" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='EVAD') vadacno,"+
				" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='EVDE') vdeacno,"+
				" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='NET') netacno,"+
				" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='VSEXP') vsexpacno,"+
				" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='COST OF VEHICLE SOLD') cvsacno,"+
				" (select c_rate from my_curr where doc_no="+curid+") currate,"+
				" (select doc_no from my_head where cldocno="+cldocno+" and dtype='CRM') clientacno,"+
				" (select method from gl_config where field_nme='vsexp') vsexp,"+
				" (select method from gl_config where field_nme='tax') tax,"+
				" (select tax from my_acbook where cldocno="+cldocno+" and dtype='CRM') clienttax,"+
				" (select method from gl_config where field_nme='VSIDoubleEntry') doubleentry";
				System.out.println(strgetdata);
				ResultSet rsgetdata=stmt.executeQuery(strgetdata);
				while(rsgetdata.next()){
					regno=rsgetdata.getString("regno");
					
					vehacno=rsgetdata.getInt("vehacno");
					vadacno=rsgetdata.getInt("vadacno");
					vdeacno=rsgetdata.getInt("vdeacno");
					netacno=rsgetdata.getInt("netacno");
					currate=rsgetdata.getDouble("currate");
					vsexp=rsgetdata.getInt("vsexp");
					vsexpacno=rsgetdata.getInt("vsexpacno");
					tax=rsgetdata.getInt("tax");
					clienttax=rsgetdata.getInt("clienttax");
					doubleentry=rsgetdata.getInt("doubleentry");
					cvsacno=rsgetdata.getInt("cvsacno");
				}
				int cvalue=0;
String amtdec="select cvalue from my_system where codeno='amtdec'";
ResultSet amtdecrs=stmt.executeQuery(amtdec);
while(amtdecrs.next()){
    cvalue=amtdecrs.getInt("cvalue");
}

              testdramt=purchasevalue*-1;
			  testldramt=testdramt*currate;
			  note="Purchase Value of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;
			  if(testdramt!=0){
				  String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
				  " doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+vehacno+",round("+testdramt+","+cvalue+"),"+currate+","+
				  " "+curid+",0,-1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',round("+testldramt+","+cvalue+"),"+docno+",'Purchase Value',"+curid+",'5',1,0,3,6,"+fleetno+")";
				 int insertjv=stmt.executeUpdate(strinsertjv);
				 if(insertjv<=0){
					 return 0;
				 }
				 String strinsertgc="insert into eq_assettran(date,doc_no,fleet_no,acno,dramount,brhid,ttype,ftype,tr_no)values('"+sqlStartDate+"',"+docno+","+fleetno+","+
				" "+vehacno+","+testdramt+","+branch+",'ESI',1,"+trno+")";
				 int insertgc=stmt.executeUpdate(strinsertgc);
				 if(insertgc<=0){
					 return 0;
				 }
			  }


			  testdramt=(accdepr+currdepr);
			  testldramt=testdramt*currate;
			  note="AccDepr+CurrDepr of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;

			  if(testdramt!=0.0){

			  	String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
			  	" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+vadacno+",round("+testdramt+","+cvalue+"),"+currate+","+
			  	" "+curid+",0,1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',round("+testldramt+","+cvalue+"),"+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
			  	int insertjv=stmt.executeUpdate(strinsertjv);
			  	if(insertjv<0){
			  		return 0;
			  	}
			  	String strinsertgc="insert into eq_assettran(date,doc_no,fleet_no,acno,dramount,brhid,ttype,ftype,tr_no)values('"+sqlStartDate+"',"+docno+","+fleetno+","+
			  	" "+vadacno+","+testdramt+","+branch+",'ESI',1,"+trno+")";
			  	int insertgc=stmt.executeUpdate(strinsertgc);
			  	if(insertgc<=0){
			  		return 0;
			  	}
			  }
			  
			  testdramt=currdepr;
			  testldramt=testdramt*currate;
			  note="CurrDepr of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;
			  if(testdramt!=0.0){
				  String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,"+
				" ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+vdeacno+",round("+testdramt+","+cvalue+"),"+currate+","+
				" "+curid+",0,1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',round("+testldramt+","+cvalue+"),"+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
				  int insertjv=stmt.executeUpdate(strinsertjv);
				  if(insertjv<0){
					  return 0;
				  }
			  }

			  testdramt=currdepr*-1;
			  testldramt=testdramt*currate;
			  note="CurrDepr of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;

			  if(testdramt!=0){
				  String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
				" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+vadacno+",round("+testdramt+","+cvalue+"),"+currate+","+
				" "+curid+",0,-1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',round("+testldramt+","+cvalue+"),"+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
				int insertjv=stmt.executeUpdate(strinsertjv);
				if(insertjv<=0){
					return 0;
				}
				String strinsertgc="insert into eq_assettran(date,doc_no,fleet_no,acno,dramount,brhid,ttype,ftype,tr_no,frmdate,days)values('"+sqlStartDate+"',"+docno+","+fleetno+","+
				" "+vadacno+","+testdramt+","+branch+",'ESI',1,"+trno+",if("+deprdate+"=null,"+deprdate+",'"+deprdate+"'),"+currdepr+")";
				int insertgc=stmt.executeUpdate(strinsertgc);
			  	if(insertgc<=0){
			  		return 0;
			  	}
			  }
   
			  testdramt=salesprice;
			  testldramt=testdramt;
	             note="Sales Price - "+regno+" Fl "+fleetno+" - "+desc;

			 // note="Sales Price of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno+" "+desc;
				// System.out.println("cmbbilltype==="+cmbbilltype+"tax==="+tax+"note===="+note);  
				 String clientcurr="";double clientrate=0.00;
					String llls1="select  clientcurr, currrate clientrate from eq_vsalem where doc_no='"+docno+"'";
					System.out.println("---1----sqls10----"+llls1) ;
						ResultSet t1sql1s1 = stmt.executeQuery(llls1);
						if(t1sql1s1.next()) {

						clientcurr=t1sql1s1.getString("clientcurr");	
						clientrate=t1sql1s1.getDouble("clientrate");	
  

						}
						double testdramt1=trsalesprice;
						double  testldramt1=0.00;
						 testdramt=salesprice;
			  if(testdramt!=0.0){
			      System.out.println("Tax==="+tax+"clienttax==="+clienttax);
			      if(tax==1 && clienttax==1){
			    	  if(cmbbilltype.equalsIgnoreCase("1"))
						 {
			    	  String strgettax="select coalesce(vat_per,0.0) vatpercent,inv.acno taxacno from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqlStartDate+"' between tax.fromdate and tax.todate";
			    	  ResultSet rsgettax=stmt.executeQuery(strgettax);
			    	  while(rsgettax.next()){
							vatpercent=rsgettax.getDouble("vatpercent");
							taxacno=rsgettax.getInt("taxacno");
						}
						taxamt=testdramt*(vatpercent/100);
						String uptaxsql="update eq_vsalem set taxamount='"+taxamt+"' where doc_no="+docno+" ";
						stmt.executeUpdate(uptaxsql);
						
						testdramt1=testdramt1+(testdramt1*(vatpercent/100));

				          
				        testldramt1=testdramt1*clientrate;
				        String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,"+
				        " dtype,ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+clientacno+",round("+testdramt1+","+cvalue+"),"+
				        " "+clientrate+","+clientcurr+",0,1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',round("+testldramt1+","+cvalue+"),"+docno+",'"+note+"',"+clientcurr+",'5',1,"+cldocno+",3,6,"+fleetno+")";
				        int insertjv=stmt.executeUpdate(strinsertjv);
				        System.out.println("jventry==="+strinsertjv);
				        if(insertjv<=0){
				        	return 0;
				        }
				        note="Tax of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;
				        if(testdramt>0){
				        	taxamt=taxamt*-1;
				        }
				        else{
				        	taxamt=taxamt*-1;
				        }
				        if(taxamt!=0.0){
				        	String strinsertjv2="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
							        " doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+taxacno+",round("+taxamt+","+cvalue+"),"+currate+","+
							        " "+curid+",0,-1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',round("+taxamt*currate+","+cvalue+"),"+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
							System.out.println("strinsertjv2==="+strinsertjv2);       
				        	int insertjv2=stmt.executeUpdate(strinsertjv2);
							        if(insertjv2<=0){
							        	return 0;
							        }
				        }
			      }
			    	  else if(cmbbilltype.equalsIgnoreCase("2"))
						 {
				    	  String strgettax="select coalesce(vat_per,0.0) vatpercent,inv.acno taxacno from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqlStartDate+"' between tax.fromdate and tax.todate";
				    	  ResultSet rsgettax=stmt.executeQuery(strgettax);
				    	  while(rsgettax.next()){
								vatpercent=rsgettax.getDouble("vatpercent");
								taxacno=rsgettax.getInt("taxacno");
							}
							

					        String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,"+
					        " dtype,ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+clientacno+",round("+testdramt1+","+cvalue+"),"+
					        " "+clientrate+","+clientcurr+",0,1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',round("+testdramt+","+cvalue+"),"+docno+",'"+note+"',"+clientcurr+",'5',1,"+cldocno+",3,6,"+fleetno+")";
					        int insertjv=stmt.executeUpdate(strinsertjv);
					        if(insertjv<=0){
					        	return 0;
					        }
					       
				      }
			      }  
				  else{
					  String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,"+
					" dtype,ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+clientacno+",round("+testdramt1+","+cvalue+"),"+clientrate+","+
			         " "+clientcurr+",0,1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',round("+testdramt+","+cvalue+"),"+docno+",'"+note+"',"+clientcurr+",'5',1,"+cldocno+",3,6,"+fleetno+")";
					  int insertjv=stmt.executeUpdate(strinsertjv);
					  if(insertjv<=0){
						  return 0;
					  }
							  
				  }
			  	
			
			  }
			 
			
			    if(vsexp==1){
			    	testdramt=(netvalue+netbook)*-1;
			    	testldramt=testdramt*currate;
			        if(testdramt<0){
			        	netid=-1;
			        }
			        else{
			            netid=1;
			        }
			        note="Net Amount of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;

			        if(testdramt!=0){

			            String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
			            " doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+netacno+",round("+testdramt+","+cvalue+"),"+currate+","+
			            " "+curid+",0,1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',round("+testldramt+","+cvalue+"),"+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
			            int insertjv=stmt.executeUpdate(strinsertjv);
			            if(insertjv<=0){
			            	return 0;
			            }
			            testdramt=netbook;
			            testldramt=testdramt*currate;
			            note="Sales Expenditure of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;
			            if(testdramt!=0){
			                String strinsert="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,"+
			                " ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+vsexpacno+",round("+testdramt+","+cvalue+"),"+currate+","+
			            " "+curid+",0,1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',round("+testldramt+","+cvalue+"),"+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
			                int insertjv2=stmt.executeUpdate(strinsert);
			                if(insertjv2<=0){
			                	return 0;
			                }
			            }
			        }
			    }
			    else{
			    	testdramt=netvalue*-1;
			    	testldramt=testdramt*currate;

			        if(testdramt<0){
			        	netid=-1;
			        }
			        else{
			            netid=1;
			        }
			        note="Net Amount of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;


			        if(doubleentry==0){

			              if(testdramt!=0){

			                  String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
			                " doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+netacno+",round("+testdramt+","+cvalue+"),"+currate+","+
			                " "+curid+",0,"+netid+","+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',round("+testldramt+","+cvalue+"),"+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
			                  int insertjv=stmt.executeUpdate(strinsertjv);
			                  if(insertjv<=0){
			                	  return 0;
			                  }
			              }
			        }
			        else{
			            testdramt=salesprice*-1;
			            testldramt=testdramt*currate;
			              note="Sales Price - "+regno+" Fl "+fleetno+" - "+desc;

			      //      note="Sales Price of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno+" "+desc;
			            String strinsert="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,"+
			            " dtype,ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+netacno+",round("+testdramt+","+cvalue+"),"+
			            " "+currate+","+curid+",0,-1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',round("+testldramt+","+cvalue+"),"+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
			            int insertjv=stmt.executeUpdate(strinsert);
			            if(insertjv<=0){
			            	return 0;
			            }
			            testdramt=netbook;
			            testldramt=testdramt*currate;
			            note="Net Book of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;

			            String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
			            " doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+cvsacno+",round("+testdramt+","+cvalue+"),"+currate+","+
			            " "+curid+",0,1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',round("+testldramt+","+cvalue+"),"+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
			            int insertjv2=stmt.executeUpdate(strinsertjv);
			            if(insertjv2<=0){
			            	return 0;
			            }
			        }

			    }
			
			double jvdramount=0.00;
			 String jvselect="SELECT sum(ldramount) dramount from my_jvtran where tr_no='"+trno+"'";
			   //System.out.println("-----5--sqls3----"+sqls3) ;
			   ResultSet jvrs = stmt.executeQuery (jvselect);
				
				if (jvrs.next()) {
			
					jvdramount=jvrs.getDouble("dramount");	
					 
					
			              }
			//	 System.out.println("--jvdramount----"+jvdramount) ;
				if(jvdramount>0 || jvdramount<0)
				{
					
					 if(jvdramount>1 || jvdramount<-1){
						 System.out.println("jvdramount>1 and <-1 condition satisfies amount is :-"+jvdramount);
	                    	conn.close();
							return 0;
	                    }
					 }
				int vocno=0;	
		    	
				 Statement stmt1=conn.createStatement();
				
				String sqlss="select voc_no from eq_vsalem where doc_no='"+docno+"' ";
				ResultSet selrs=stmt1.executeQuery(sqlss);
				
				if(selrs.next())
				{
					vocno=selrs.getInt("voc_no");
				}
				
				ArrayList<String> arr=new ArrayList<String>(); 
				ClsVatInsert ClsVatInsert=new ClsVatInsert();
				Statement newStatement=conn.createStatement();
				String selectsqls="select m.currrate rate, coalesce(d.salesprice+m.taxamount,0.00) nettaxamount,"
						+ "d.salesprice total1,0.00 total2,0.00 total3,"
						+ "0.00 total4,0.00 total5,0.00 total6,0.00 total7,0.00 total8,"
						+ "0.00 total9,0.00 total10,coalesce(m.taxamount,0.00) tax1,0.00 tax2,0.00 tax3,"
						+ "0.00 tax4,0.00 tax5,0.00 tax6,0.00 tax7,0.00 tax8,0.00 tax9,"
						+ "0.00 tax10 from eq_vsalem m left join eq_vsaled d "
						+ "on m.doc_no=d.rdocno where m.doc_no="+docno+" ";
				
				 
            //System.out.println("=ABC===="+selectsqls);
			ResultSet rss101=newStatement.executeQuery(selectsqls);
int curate=0;
				if(rss101.first())
					{ 
		            curate=rss101.getInt("rate");

					arr.add(rss101.getDouble("nettaxamount")*curate+"::"+rss101.getDouble("total1")*curate+"::"+rss101.getDouble("total2")*curate+"::"+
							rss101.getDouble("total3")*curate+"::"+rss101.getDouble("total4")*curate+"::"+rss101.getDouble("total5")*curate+"::"+
							rss101.getDouble("total6")*curate+"::"+rss101.getDouble("total7")*curate+"::"+rss101.getDouble("total8")*curate+"::"+
							rss101.getDouble("total9")*curate+"::"+rss101.getDouble("total10")*curate+"::"+rss101.getDouble("tax1")*curate+"::"+
							rss101.getDouble("tax2")*curate+"::"+rss101.getDouble("tax3")*curate+"::"+rss101.getDouble("tax4")*curate+"::"+
							rss101.getDouble("tax5")*curate+"::"+rss101.getDouble("tax6")*curate+"::"+rss101.getDouble("tax7")*curate+"::"+
							rss101.getDouble("tax8")*curate+"::"+rss101.getDouble("tax9")*curate+"::"+rss101.getDouble("tax10")*curate+"::"+"0");
					}
				int client=Integer.parseInt(clientacno);
				//System.out.println("sqlstartdate==="+sqlStartDate);
					int result=ClsVatInsert.vatinsert(1,1,conn,trno,client,vocno,sqlStartDate,formdetailcode,branch,String.valueOf(docno),Integer.parseInt(cmbbilltype),arr,mode)	;
						if(result==0)	
					        {
							 
							conn.close();
							return docno;
							}
				   
				
			}
			 Statement ss11=conn.createStatement();
			 if(docno>0) {
                 int roundoffacno=0, id=1;
                 double roundamt=0.0; 
                 int iapprovalStatus=3;
                 String description="";
                 String sqlround = "select sum(ldramount)*-1 roundamt,(select acno from my_account where codeno='ROUND OF ACCOUNT') roundoffacno from my_jvtran where tr_no='"+trno+"'";   
                 System.out.println("-------my_jvtran  roundoff---------"+sqlround);  
                 ResultSet rs45 = ss11.executeQuery (sqlround);   
                 while (rs45.next()) {
                     roundoffacno = rs45.getInt("roundoffacno");
                     roundamt = rs45.getDouble("roundamt");
                  }      
                 if(roundamt<0) {
                     id = -1;
                 }else {
                     id = 1;  
                 }
                 if(roundamt>-1 && roundamt<1 && roundamt!=0) {   
                     String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
                             + "values('"+sqlStartDate+"','"+""+"',"+docno+",'"+roundoffacno+"','"+description+"','"+1+"','"+1+"',round("+roundamt+",2),round("+roundamt+",2),0,"+id+",0,0,0,0,0,0,0,'CPU','"+branch+"',"+trno+",'"+iapprovalStatus+"')";
                      
                      System.out.println("-------my_jvtran insertion roundoff---------"+sql11);  
                      int ss1 = ss11.executeUpdate(sql11);
                      if(ss1<=0)
                         {
                             conn.close();
                             return 0;
                         } 
                 }
             }
         double total = 0;
		         
		          String sql="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno ;

                   System.out.println("LDR CHECK"+sql);
		          ResultSet rsJv = ss11.executeQuery(sql);
		          while (rsJv.next()) {
		              total=rsJv.getDouble("jvtotal");
		              System.out.println("TOTAL VAL"+total);
		          }

		          if(total == 0){
		             // conn.commit();
		             // ss11.close();
		           
		             // conn.close();
		              System.out.println("Sucess");
		              return docno;
		          }else{
		              System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
		              ss11.close();
		            

		              conn.close();
		              return 0;
		          }
		          
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}
	public boolean edit(Date sqlStartDate, String cmbtype,
			String description, HttpSession session, String mode, int docno,int trno,ArrayList<String> disposalarray,String formdetailcode,String clientacno,String client,String branch,String cmbbilltype,String clientcurr,double currrate) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtDisposal = conn.prepareCall("{call eqdisposalmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("checking");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtDisposal.setInt(7,docno);
			stmtDisposal.setInt(8, trno);
			stmtDisposal.setInt(12, 0);
			stmtDisposal.setDate(1,sqlStartDate);
			stmtDisposal.setString(2,clientacno);
			stmtDisposal.setString(3, cmbtype);
			stmtDisposal.setString(4, description);
			stmtDisposal.setString(5,session.getAttribute("USERID").toString());
			stmtDisposal.setString(6,branch);
			stmtDisposal.setString(9,mode);
			stmtDisposal.setString(10,formdetailcode);
			stmtDisposal.setString(11,client);
			stmtDisposal.setString(13,cmbbilltype);
			stmtDisposal.setString(14,clientcurr);
			stmtDisposal.setDouble(15,currrate);

			int aa = stmtDisposal.executeUpdate();
			   
//			System.out.println("inside DAO1");
			if (aa>0) {
//				System.out.println("Success");
				Statement stmtDisp= conn.createStatement ();
				int i=stmtDisp.executeUpdate("delete from eq_vsaled where rdocno='"+docno+"' and trno='"+trno+"'");
				if(i>0){
					int j=insertdet(disposalarray, docno, trno, conn,sqlStartDate,clientacno,mode,formdetailcode,session,client,null,branch,cmbbilltype,description);
					if(j<=0){
						return false;
					}
				}
				conn.commit();
				stmtDisposal.close();
				conn.close();
				return true;
			}
			stmtDisposal.close();
			conn.close();
		}catch(Exception e){
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		
		return false;
	}
	public boolean delete(Date sqlStartDate, String cmbtype,
			String description, HttpSession session, String mode, int docno,int trno,String formdetailcode,String clientacno,String branch,String cmbbilltype,String clientcurr, double currrate) throws SQLException {
		Connection conn=null;
		String fleetno="0";
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			
			CallableStatement stmtDisposal = conn.prepareCall("{call eqdisposalmDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("checking");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtDisposal.setInt(7,docno);
			stmtDisposal.setInt(8, trno);
			stmtDisposal.setInt(12, 0);
			stmtDisposal.setDate(1,sqlStartDate); 
			stmtDisposal.setString(2,clientacno);
			stmtDisposal.setString(3, cmbtype);
			stmtDisposal.setString(4, description);
			stmtDisposal.setString(5,branch);
			stmtDisposal.setString(6,session.getAttribute("USERID").toString());
			stmtDisposal.setString(9,mode);
			stmtDisposal.setString(10,formdetailcode);
			stmtDisposal.setString(11,null);
			stmtDisposal.setString(13,cmbbilltype);
			stmtDisposal.setString(14,clientcurr);
			stmtDisposal.setDouble(15,currrate);

			int aa = stmtDisposal.executeUpdate();
			
//			System.out.println("inside DAO1");
			Statement stmtDisp= conn.createStatement ();
			
			String sql="select fleetno from eq_vsaled d left join eq_vsalem m on m.doc_no=d.rdocno where rdocno="+docno+" and m.brhid="+session.getAttribute("BRANCHID")+"";
			//System.out.println("fleet fetch==="+sql);
			ResultSet resultSet = stmtDisp.executeQuery (sql);
			if(resultSet.next()){
			fleetno=resultSet.getString("fleetno");
			}
			ClsApplyDelete ad=new ClsApplyDelete();
			int data=ad.getFinanceApplyDelete(conn, trno);
			
			
			
			  if (aa>0 && data==1) {
				 String upd="update GL_EQUIPMASTER set tran_code='FS', STATUS='IN',FSTATUS='L' WHERE FLEET_NO IN ("+fleetno+")"; 
				  //System.out.println("vehmaster update====="+upd);
				  int val=stmtDisp.executeUpdate(upd);
				 // System.out.println("val====="+val);
				  String jv="update my_jvtran set status=7 where tr_no="+trno+""; 
				  //System.out.println("jv====="+jv);
				  int val1=stmtDisp.executeUpdate(jv);
				  //System.out.println("val1====="+val1);
				  String asset="delete  from eq_assettran where tr_no="+trno+""; 
				  //System.out.println("asset====="+asset);
				  int val2=stmtDisp.executeUpdate(asset);
				  //System.out.println("val2====="+val2);
				  conn.commit();
				  return true; 
				}
			  stmtDisp.close();
			stmtDisposal.close();
			conn.close();
		}catch(Exception e){
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		return false;
	}
	public   JSONArray disposalSearch(String branch) throws SQLException {
	    List<ClsEquipVehicleDisposalBean> movementbean = new ArrayList<ClsEquipVehicleDisposalBean>();
	  
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		try {
				conn=objconn.getMyConnection();
				Statement stmtmovement = conn.createStatement ();
	        	String strSql="select sale.doc_no,sale.voc_no,sale.date,sale.acno,sale.type,sale.description,sale.trno,head.description accname from eq_vsalem sale left join"+
	        				" my_head head on sale.acno=head.doc_no where sale.status<>7 and sale.brhid='"+branch+"'";
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray disposalgridSearch(String branch,String docno) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
				conn=objconn.getMyConnection();
				Statement stmtmovement = conn.createStatement ();
				if(!(branch.equalsIgnoreCase(""))){
	        	String strSql="select saled.trsalesprice,saled.sr_no,saled.fleetno fleet_no ,saled.salesprice,saled.dep_posted,saled.pvalue pur_value,saled.acdep acc_dep,saled.curdep cur_dep,saled.netbook,saled.netval net_pl,veh.flname,veh.reg_no "+
	        			" from eq_vsaled saled left join gl_equipmaster veh on saled.fleetno=veh.fleet_no left join eq_vsalem sale on saled.rdocno=sale.doc_no"+
	        			" where saled.rdocno='"+docno+"' and sale.brhid="+branch+" ";
	        	System.out.println("main grid ugugiughhiihi======="+strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet); 
				}
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	public   JSONArray getTabularData(String fromdate,String todate) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
				conn=objconn.getMyConnection();
				Statement stmtmovement = conn.createStatement ();
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!(fromdate.equalsIgnoreCase(""))){
					sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				}
				if(!(todate.equalsIgnoreCase(""))){
					sqltodate=objcommon.changeStringtoSqlDate(todate);
				}
	        	String strSql="select aa.fleet_no,aa.flname,aa.reg_no,aa.code_name plate,(aa.asset_opn-aa.asset_add-aa.asset_del)asset_total,aa.prch_dte purdate,"+
	        			" sum(aa.asset_opn)asset_opn,sum(aa.asset_add)asset_add,sum(aa.asset_del)asset_del from("+
	        			" select asset.fleet_no,veh.flname,veh.reg_no,plate.code_name,veh.prch_dte,if(asset.date<'"+sqlfromdate+"',asset.dramount,'') as asset_opn,"+
	        			" if(asset.date>'"+sqlfromdate+"' and asset.date<'"+sqltodate+"',asset.dramount,'') as asset_add,if(asset.date>'"+sqltodate+"',asset.dramount,'') "+
	        			" as asset_del from eq_assettran asset left join gl_equipmaster veh on asset.fleet_no=veh.fleet_no left join gl_vehplate plate on"+
	        			" veh.pltid=plate.doc_no WHERE asset.TRANSTYPE='T'  )aa group by fleet_no";
	        //	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}

	
	public JSONArray getJvData(String trno,String id) throws SQLException {
	    
	    JSONArray RESULTDATA=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return RESULTDATA;
	    }
	    Connection conn =null;
	    try {
				conn=objconn.getMyConnection();
				Statement stmtjv=conn.createStatement ();
//				System.out.println("Jvreload");
	        	String strSql="select if(j.dramount>0,round(j.dramount*j.id,2),0)debit ,if(j.dramount<0,round(j.dramount*j.id,2),0) credit,"+
	        			" round(j.ldramount*j.id,2) baseamt,j.description desc1,h.account acno,	h.description acname,h.atype type from my_jvtran j left join my_head h on"+
	        			" j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId where j.tr_no="+trno;
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtjv.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtjv.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray getTempJvData(String mdoc,String id) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    if(!id.equalsIgnoreCase("2")){
	    	return RESULTDATA;
	    }
	    Connection conn=null;
		try {
				conn=objconn.getMyConnection();
				Statement stmtjv=conn.createStatement ();
	        	String strSql="select if(j.dramount>0,round(j.dramount*j.id,2),0)debit ,if(j.dramount<0,round(j.dramount*j.id,2),0) credit,"+
	        			" round(j.ldramount*j.id,2) baseamt,j.desc1,h.account acno,	h.description acname,h.atype type from eq_vsaletempjv j left join my_head h on"+
	        			" j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId where j.mdoc="+mdoc;
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtjv.executeQuery(strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtjv.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	public   ClsEquipVehicleDisposalBean getPrint(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ClsEquipVehicleDisposalBean bean=new ClsEquipVehicleDisposalBean();
		Connection conn=null;
		String currency="";
		try{
			conn=objconn.getMyConnection();
			ClsAmountToWords obj=new ClsAmountToWords();
			Statement stmt=conn.createStatement();
			String strsql="select if(year(sale.date)>2020,'EASY LEASE MOTOR CYCLE RENTAL PSC','EASY LEASE MOTOR CYCLE RENTAL LLC') easycmpname,comp.email,coalesce(br.tinno,'') comptrn,coalesce(ac.trnnumber,'') clienttrn,br.branchname,lc.loc_name,br.address branchaddress,br.tel brtel,br.fax brfax,comp.company,sale.doc_no,sale.voc_no,DATE_FORMAT(sale.date,'%d/%m/%Y') "+
			" date,sale.cldocno,coalesce(ac.refname,'') refname,coalesce(ac.address,'') addr1,coalesce(ac.address2,'') addr2,coalesce(ac.com_mob,'') mob,coalesce(ac.per_mob,'') phone,"
			+ "if(sale.type='S','Sale','Loss') type,sale.description,cur.code cur,DATE_FORMAT(CURDATE(),'%d/%m/%Y') finaldate,ms.user_name from eq_vsalem sale left join my_acbook ac on "+
			" (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on (sale.brhid=br.doc_no) left join my_comp comp on (br.cmpid=comp.doc_no) left join my_curr cur on comp.curid=cur.doc_no"
			+ " inner join my_locm l on l.brhid=br.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=br.doc_no) "
			+ "left join datalog dl on sale.doc_no=dl.doc_no and dl.dtype='ESI' left join my_user ms on ms.doc_no=dl.userid  where  sale.doc_no="+docno;
			ResultSet rssale=stmt.executeQuery(strsql);
//			System.out.println("main details"+strsql);
			
			while(rssale.next()){
				bean.setEasycmpname(rssale.getString("easycmpname"));
				bean.setLblcomptrn(rssale.getString("comptrn"));
				bean.setLblclienttrn(rssale.getString("clienttrn"));
				bean.setLbldocno(rssale.getString("voc_no"));
				bean.setLblclientcode(rssale.getString("cldocno"));
				bean.setLblclientname(rssale.getString("refname"));
				bean.setLbltype(rssale.getString("type"));
				bean.setLbldesc(rssale.getString("description"));
				bean.setLbldate(rssale.getString("date"));
				bean.setLblbranch(rssale.getString("branchname"));
				bean.setLblcompfax(rssale.getString("brfax"));
				bean.setLblcomptel(rssale.getString("brtel"));
				bean.setLblcompname(rssale.getString("company"));
				bean.setLblcompaddress(rssale.getString("branchaddress"));
				bean.setLbllocation(rssale.getString("loc_name"));
				bean.setLbladdress1(rssale.getString("addr1"));
				bean.setLbladdress2(rssale.getString("addr2"));
				bean.setLblmobile(rssale.getString("mob"));
				bean.setLblphone(rssale.getString("phone"));
				bean.setLblcheckedby(rssale.getString("user_name"));
				bean.setLblfinaldate(rssale.getString("finaldate"));
				bean.setLblcompemail(rssale.getString("email"));
				
				currency=rssale.getString("cur");
				
			}
	//		ArrayList<Double> totalarray=new ArrayList<>();

			String strtotal="select round(sum(coalesce(saled.salesprice,0)),2) total from eq_vsaled saled where saled.rdocno="+docno;
			ResultSet rstotal=stmt.executeQuery(strtotal);
//			System.out.println("hhhh"+strtotal);
			while(rstotal.next()){
		//		totalarray.add(rstotal.getDouble("total"));

				bean.setLbltotal(rstotal.getString("total"));
			//	bean.setLblamountwords(currency+" "+obj.convertNumberToWords(Double.parseDouble(rstotal.getString("total")))+" only");
			String amountwords=obj.convertAmountToWords(rstotal.getString("total"));
				//bean.setLblamountwords(currency+" "+amountwords+"");
				bean.setLblamountwords(" "+amountwords+"");
			}
		String strgettax="select coalesce(round(sum(coalesce(dramount,0)),2)*-1,0) taxamt,billtype from eq_vsalem sale inner join my_jvtran jv on (sale.trno=jv.tr_no) inner join gl_invmode ac on (jv.acno=ac.acno)  where sale.doc_no="+docno+" and ac.idno=20";
			
            ResultSet rsgettax=stmt.executeQuery(strgettax);
			double taxamt=0.00;
			double nettotal=0.00;
			String billtype="";
			while(rsgettax.next()){
				taxamt=rsgettax.getDouble("taxamt");
				billtype=rsgettax.getString("billtype");
			}
			bean.setLbltaxtotal(taxamt+"");
	         bean.setLblbilltype(billtype);

			DecimalFormat decim = new DecimalFormat("0.00");
			
			nettotal=objcommon.Round((Double.parseDouble(bean.getLbltotal())+taxamt),2);
			//System.out.println(bean.getLbltotal()+"bean.getLbltotal()"+decim.format(nettotal));
			bean.setLblnettaxtotal(decim.format(nettotal)+"");
			String amountwords=obj.convertAmountToWords(nettotal+"");
			String taxamtwrds=obj.convertAmountToWords(taxamt+"");
			//System.out.println("hhhh"+amountwords);
	//bean.setLblamountwords(amountwords+"");
			bean.setLbltaxamtwrds(taxamtwrds+"");
           
	
/*String strtax="select sum(saled.salesprice*0.05) taxamt from eq_vsaled saled where saled.rdocno="+docno;
			
            ResultSet rstax=stmt.executeQuery(strtax);
            double taxtotal=0.0;
			while(rstax.next()){
				taxtotal=rstax.getDouble("taxamt");
			}
			System.out.println("llll"+taxtotal);
			bean.setTaxtotal(taxtotal+"");
			*/
		}
		catch(Exception e){
			e.printStackTrace();
			
		}
		finally{
			conn.close();
		}
		return bean;
	}
		
	public   ArrayList<String> getSaleInvPrint(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> invprint=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select veh.ch_no chasisno,coalesce(concat(veh.reg_no,'-',plt.code_name),'') reg,saled.sr_no,saled.fleetno fleet_no ,round(saled.trsalesprice,2) salesprice,if(ac.tax=1,round((trsalesprice*coalesce(vat_per,0))/100,2),0.00) taxamt,if(ac.tax=1,round((trsalesprice+(trsalesprice*coalesce(vat_per,0))/100),2),round(trsalesprice,2)) netamt,DATE_FORMAT(saled.dep_posted,'%d/%m/%Y') dep_posted,round(saled.pvalue,2) pur_value,round(saled.acdep,2) acc_dep,round(saled.curdep,2) cur_dep,round(saled.netbook,2) netbook,round(saled.netval,2) net_pl,veh.flname,ac.tax "+
	        			" from eq_vsaled saled left join gl_equipmaster veh on saled.fleetno=veh.fleet_no left join eq_vsalem sale on saled.rdocno=sale.doc_no "
	        			+ " left join gl_vehplate plt on veh.pltid=plt.doc_no left join gl_taxdetail t on sale.date between t.fromdate and todate left join my_acbook ac on sale.cldocno=ac.cldocno and ac.dtype='CRM' "+
	        			" where saled.rdocno="+docno;
			
			
			ResultSet rsprint=stmt.executeQuery(strsql);
			String temp="";
			int i=0;
//			System.out.println("taxqryyyyyyy====="+strsql);
			
			while(rsprint.next()){
				temp=rsprint.getString("sr_no")+"::"+rsprint.getString("reg")+"::"+rsprint.getString("flname")+"::"+rsprint.getString("dep_posted")+"::"+rsprint.getString("chasisno")+"::"+rsprint.getString("salesprice")+"::"+rsprint.getString("pur_value")+"::"+rsprint.getString("acc_dep")+"::"+rsprint.getString("cur_dep")+"::"+rsprint.getString("netbook")+"::"+rsprint.getString("taxamt")+"::"+rsprint.getString("netamt")+"::"+rsprint.getString("net_pl");
//				System.out.println("valueeee"+temp);
				invprint.add(temp);
				
				i++;
			}
			
						
			return invprint;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invprint;
	}
	
	 
	   public   ArrayList<String> getSaleInvPrints(String docno) throws SQLException {
	        // TODO Auto-generated method stub
	        ArrayList<String> invprint2=new ArrayList<>();
	        Connection conn=null;
	        try{
	            conn=objconn.getMyConnection();
	            Statement stmt=conn.createStatement();
	            String strsql="select veh.ch_no chasisno,coalesce(concat(veh.reg_no,'-',plt.code_name),'') reg,saled.sr_no,saled.fleetno fleet_no ,round(saled.trsalesprice,2) salesprice,if(ac.tax=1,round((trsalesprice*coalesce(vat_per,0))/100,2),0.00) taxamt,if(billtype=1,round((trsalesprice+(trsalesprice*coalesce(vat_per,0))/100),2),round(trsalesprice,2)) netamt,DATE_FORMAT(saled.dep_posted,'%d/%m/%Y') dep_posted,round(saled.pvalue,2) pur_value,round(saled.acdep,2) acc_dep,round(saled.curdep,2) cur_dep,round(saled.netbook,2) netbook,round(saled.netval,2) net_pl,veh.flname,ac.tax "+
	                        " from eq_vsaled saled left join gl_equipmaster veh on saled.fleetno=veh.fleet_no left join eq_vsalem sale on saled.rdocno=sale.doc_no "
	                        + " left join gl_vehplate plt on veh.pltid=plt.doc_no left join gl_taxdetail t on sale.date between t.fromdate and todate left join my_acbook ac on sale.cldocno=ac.cldocno and ac.dtype='CRM' "+
	                        " where saled.rdocno="+docno;
	            
	            
	            ResultSet rsprint=stmt.executeQuery(strsql);
	            String temp="";
	            int i=0;
	          System.out.println("taxqryyyyyyy====="+strsql);
	            
	            while(rsprint.next()){
	                temp=rsprint.getString("sr_no")+"::"+rsprint.getString("reg")+"::"+rsprint.getString("flname")+"::"+rsprint.getString("dep_posted")+"::"+rsprint.getString("chasisno")+"::"+rsprint.getString("salesprice")+"::"+rsprint.getString("pur_value")+"::"+rsprint.getString("acc_dep")+"::"+rsprint.getString("cur_dep")+"::"+rsprint.getString("netbook")+"::"+rsprint.getString("netamt")+"::"+rsprint.getString("net_pl");
	              System.out.println("valueeee"+temp);
	                invprint2.add(temp);
	                
	                i++;
	            }
	            
	                        
	            return invprint2;
	        }
	        catch(Exception e){
	            e.printStackTrace();
	        }
	        finally{
	            conn.close();
	        }
	        return invprint2;
	    }

	
	public   ArrayList<String> getSaleInvPrint2(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> invprint=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select coalesce(concat(veh.reg_no,'-',plt.code_name),'') reg,veh.ch_no chassis,saled.sr_no,saled.fleetno fleet_no ,round(saled.salesprice,2) salesprice,DATE_FORMAT(saled.dep_posted,'%d/%m/%Y') dep_posted,round(saled.pvalue,2) pur_value,round(saled.acdep,2) acc_dep,round(saled.curdep,2) cur_dep,round(saled.netbook,2) netbook,round(saled.netval,2) net_pl,veh.flname"+
	        			" from eq_vsaled saled left join gl_equipmaster veh on saled.fleetno=veh.fleet_no left join eq_vsalem sale on saled.rdocno=sale.doc_no"+
	        			" left join gl_vehplate plt on veh.pltid=plt.doc_no where saled.rdocno="+docno;
//			System.out.println("qqqqqqqqqqqqqqqq"+strsql);
			ResultSet rsprint=stmt.executeQuery(strsql);
			String temp="";
			int i=0;
			while(rsprint.next()){
				temp=rsprint.getString("sr_no")+"::"+rsprint.getString("fleet_no")+"::"+rsprint.getString("reg")+"::"+rsprint.getString("chassis")+"::"+rsprint.getString("flname")+"::"+rsprint.getString("salesprice")+"::"+rsprint.getString("dep_posted")+"::"+rsprint.getString("salesprice")+"::"+rsprint.getString("pur_value")+"::"+rsprint.getString("acc_dep")+"::"+rsprint.getString("cur_dep")+"::"+rsprint.getString("netbook")+"::"+rsprint.getString("net_pl");
				invprint.add(temp);
				i++;
			}
			
						
			return invprint;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invprint;
	}
	public   ArrayList<String> getPsaleInvPrint(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> invprint=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select coalesce(concat(veh.reg_no,'-',plt.code_name),'') reg,veh.ch_no chassis,saled.sr_no,saled.fleetno fleet_no ,round(saled.salesprice,2) salesprice,if(ac.tax=1,round((salesprice*coalesce(vat_per,0))/100,2),0.00) taxamt,"
					+ " if(ac.tax=1,round((coalesce(vat_per,0)),2),0.00) taxper , round(if(ac.tax=1,round((salesprice+(salesprice*coalesce(vat_per,0))/100),2),salesprice),2) netamt,DATE_FORMAT(saled.dep_posted,'%d/%m/%Y') dep_posted,round(saled.pvalue,2) pur_value,round(saled.acdep,2) acc_dep,round(saled.curdep,2) cur_dep,round(saled.netbook,2) netbook,round(saled.netval,2) net_pl,veh.flname"+
	        			" from eq_vsaled saled left join gl_equipmaster veh on saled.fleetno=veh.fleet_no left join eq_vsalem sale on saled.rdocno=sale.doc_no"+
	        			" left join gl_vehplate plt on veh.pltid=plt.doc_no left join gl_taxdetail t on sale.date between t.fromdate and todate left join my_acbook ac on sale.cldocno=ac.cldocno and ac.dtype='CRM' where saled.rdocno="+docno;
		//	System.out.println("mmmmm"+strsql);
			ResultSet rsprint=stmt.executeQuery(strsql);
			String temp="";
			int i=0;
			while(rsprint.next()){
				temp=rsprint.getString("sr_no")+"::"+rsprint.getString("fleet_no")+"::"+rsprint.getString("reg")+"::"+rsprint.getString("chassis")+"::"+rsprint.getString("flname")+"::"+rsprint.getString("salesprice")+"::"+rsprint.getString("taxper")+"::"+rsprint.getString("taxamt")+"::"+rsprint.getString("netamt")+"::"+rsprint.getString("dep_posted")+"::"+rsprint.getString("salesprice")+"::"+rsprint.getString("pur_value")+"::"+rsprint.getString("acc_dep")+"::"+rsprint.getString("cur_dep")+"::"+rsprint.getString("netbook")+"::"+rsprint.getString("net_pl");
				invprint.add(temp);
				i++;
				//System.out.println("tempppp"+temp);
			}
//			System.out.println("temp"+temp);
						
			return invprint;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invprint;
	}
	
	
	
	
	public   ArrayList<String> getJvPrint(String trno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> jvprint=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
		
		Statement stmt=conn.createStatement();
		String strsql="select if(j.dramount>0,round(j.dramount*j.id,2),0)debit ,if(j.dramount<0,round(j.dramount*j.id,2),0) credit,"+
	        			" round(j.ldramount*j.id,2) baseamt,j.description desc1,h.account acno,	h.description acname,h.atype type from my_jvtran j left join my_head h on"+
	        			" j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId where j.tr_no="+trno;
		ResultSet rsjv=stmt.executeQuery(strsql);
		String temp="";
		int i=1;
		while(rsjv.next()){
			
			temp=i+"::"+rsjv.getString("type")+"::"+rsjv.getString("acno")+"::"+rsjv.getString("acname")+"::"+rsjv.getString("debit")+"::"+rsjv.getString("credit")+"::"+rsjv.getString("baseamt")+"::"+rsjv.getString("desc1");
			jvprint.add(temp);
			i++;
		}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jvprint;
	}
	
	
	public String getJvPrinttotal(String trno) throws SQLException {
		// TODO Auto-generated method stub
		String strjvtotal="";
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select sum(if(j.dramount>0,round(j.dramount*j.id,2),0)) debit ,sum(if(j.dramount<0,round(j.dramount*j.id,2),0)) credit"+
			" from my_jvtran j left join my_head h on j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId where j.tr_no="+trno;
			ResultSet rsjv=stmt.executeQuery(strsql);
			while(rsjv.next()){
				strjvtotal=rsjv.getString("debit")+"::"+rsjv.getString("credit");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return strjvtotal;
	}
	
	public int getTempJV(double purvalue,double accdepr,double currdepr,double salesprice,double netvalue,String curid,
			int cldocno,double netbook,String fleetno,String dtype,java.sql.Date sqldocdate,String mode,Connection conn,String cmbbilltype,double trsalesprice,int clientcurr,double clientrate,String desc) throws SQLException{
		int docno=0;
		int trno=0;
		int errorstatus=0;
		try{
			
			Statement stmt=conn.createStatement();
			int vehacno=0,vadacno=0,vdeacno=0,netacno=0,cvsacno=0,srno=0,vsexp=0,vsexpacno=0,clientacno=0,netid=0,taxacno=0,tax=0,
					clienttax=0,doubleentry=0;
			double currate=0.0,testdramt=0.0,testldramt=0.0,vatpercent=0.0,taxamt=0.0,taxamt2=0.0;
			String note="";
			String regno="";
			
			if(mode.equalsIgnoreCase("A")){
				srno++;
				String strgetdata="select (select reg_no from gl_equipmaster  where fleet_no="+fleetno+") regno,"+
				" (select coalesce(max(doc_no)+1,1) from eq_vsalem) docno,"+
				" (select coalesce(max(trno)+1,1) from my_trno) trno,"+
				" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='EVEH') vehacno,"+
				" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='EVAD') vadacno,"+
				" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='EVDE') vdeacno,"+
				" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='NET') netacno,"+
				" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='VSEXP') vsexpacno,"+
				" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='COST OF VEHICLE SOLD') cvsacno,"+
				" (select c_rate from my_curr where doc_no="+curid+") currate,"+
				" (select doc_no from my_head where cldocno="+cldocno+" and dtype='CRM') clientacno,"+
				" (select method from gl_config where field_nme='vsexp') vsexp,"+
				" (select method from gl_config where field_nme='tax') tax,"+
				" (select tax from my_acbook where cldocno="+cldocno+" and dtype='CRM') clienttax,"+
				" (select method from gl_config where field_nme='VSIDoubleEntry') doubleentry";
//				System.out.println(strgetdata);
				ResultSet rsgetdata=stmt.executeQuery(strgetdata);
				while(rsgetdata.next()){
					regno=rsgetdata.getString("regno");
					docno=rsgetdata.getInt("docno");
					trno=rsgetdata.getInt("trno");
					vehacno=rsgetdata.getInt("vehacno");
					vadacno=rsgetdata.getInt("vadacno");
					vdeacno=rsgetdata.getInt("vdeacno");
					netacno=rsgetdata.getInt("netacno");
					currate=rsgetdata.getDouble("currate");
					clientacno=rsgetdata.getInt("clientacno");
					vsexp=rsgetdata.getInt("vsexp");
					vsexpacno=rsgetdata.getInt("vsexpacno");
					tax=rsgetdata.getInt("tax");
					clienttax=rsgetdata.getInt("clienttax");
					doubleentry=rsgetdata.getInt("doubleentry");
					cvsacno=rsgetdata.getInt("cvsacno");
				}
				
				testdramt=purvalue*-1;
				testldramt=testdramt*currate;
				note="Purchase Value of "+dtype+"  "+docno+"  "+regno+" Fl "+fleetno;

				if(testdramt!=0.0){
					String strinsertpur="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+vehacno+","+testdramt+","+curid+",-1,'"+note+"',"+docno+","+testldramt+")";
					int insertpur=stmt.executeUpdate(strinsertpur);
					if(insertpur<=0){
						errorstatus=1;
						return 0;
					}
				}

				testdramt=(accdepr+currdepr);
				testldramt=testdramt*currate;
				note="AccDepr+CurrDepr of "+dtype+"  "+docno+"  "+regno+" Fl "+fleetno;
				
				if(testdramt!=0.0){
					String strinsertaccdepr="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+vadacno+","+testdramt+","+curid+",1,'"+note+"',"+docno+","+testldramt+")";
					int insertaccdepr=stmt.executeUpdate(strinsertaccdepr);
					if(insertaccdepr<=0){
						errorstatus=1;
						return 0;
					}
				}

				testdramt=currdepr;
				testldramt=testdramt*currate;
				note="CurrDepr of "+dtype+"  "+docno+"  "+regno+" Fl "+fleetno;
				
				if(testdramt!=0.0){
					String strinsertcurrdepr="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+vdeacno+","+testdramt+","+curid+",1,'"+note+"',"+docno+","+testldramt+")";
					int insertcurrdepr=stmt.executeUpdate(strinsertcurrdepr);
					if(insertcurrdepr<=0){
						errorstatus=1;
						return 0;
					}
				}

				testdramt=currdepr*-1;
				testldramt=testdramt*currate;
				note="CurrDepr of "+dtype+"  "+docno+"  "+regno+" Fl "+fleetno;
				if(testdramt!=0.0){
					String strinsertcurrdepr="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+vadacno+","+testdramt+","+curid+",-1,'"+note+"',"+docno+","+testldramt+")";
					int insertcurrdepr=stmt.executeUpdate(strinsertcurrdepr);
					if(insertcurrdepr<=0){
						errorstatus=1;
						return 0;
					}
				}

				testdramt=salesprice;
				testldramt=testdramt*currate;
				note="Sales Price of "+dtype+"  "+docno+"  "+regno+" Fl "+fleetno+" "+desc;
			
				 
					double	testdramt1=trsalesprice;
					double  testldramt1=0.00;
				if(testdramt!=0){
					if(tax==1 && clienttax==1){
						if(cmbbilltype.equalsIgnoreCase("1"))
						{
				    	String strgettax="select coalesce(vat_per,0.0) vatpercent,inv.acno taxacno from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqldocdate+"' between tax.fromdate and tax.todate";
						ResultSet rsgettax=stmt.executeQuery(strgettax);
						while(rsgettax.next()){
							vatpercent=rsgettax.getDouble("vatpercent");
							taxacno=rsgettax.getInt("taxacno");
						}
						testdramt1=testdramt1+(testdramt1*(vatpercent/100));

						taxamt=testdramt*(vatpercent/100);
				        

                        testldramt1=testdramt1*clientrate;

				        String strinsertwithtax="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+clientacno+","+testdramt1+",'"+clientcurr+"',1,'"+note+"',"+docno+","+testldramt1+")";
				        int insertwithtax=stmt.executeUpdate(strinsertwithtax);
				        if(insertwithtax<=0){
							errorstatus=1;
							return 0;
						}   
				        if(testdramt>0){
				        	taxamt=taxamt*-1;
				        }
				        else{
				        	taxamt=taxamt*-1;
				        }     
				        note="Tax of "+dtype+"  "+docno+"  "+regno+" Fl "+fleetno;
				        if(taxamt!=0.0){
				        	String strinserttax="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+taxacno+","+taxamt+","+curid+",-1,'"+note+"',"+docno+","+taxamt*currate+")";
				        	int inserttax=stmt.executeUpdate(strinserttax);
				        	if(inserttax<=0){
				        		errorstatus=1;
				        		return 0;
				        	}
				        }
				        /*else{
				        	String strinserttax="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+clientacno+","+testdramt+","+curid+",1,'"+note+"',"+docno+","+testldramt+")";
				        	int inserttax=stmt.executeUpdate(strinserttax);
				        	if(inserttax<=0){
				        		errorstatus=1;
				        		return 0;
				        	}
				        }*/
					}
						else if(cmbbilltype.equalsIgnoreCase("2"))
						{
						    testldramt1=testdramt1*clientrate;
					    	String strgettax="select coalesce(vat_per,0.0) vatpercent,inv.acno taxacno from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqldocdate+"' between tax.fromdate and tax.todate";
							ResultSet rsgettax=stmt.executeQuery(strgettax);
							while(rsgettax.next()){
								vatpercent=rsgettax.getDouble("vatpercent");
								taxacno=rsgettax.getInt("taxacno");
							}
							


					        String strinsertwithtax="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+clientacno+","+testdramt1+","+clientcurr+",1,'"+note+"',"+docno+","+testldramt1+")";
					        int insertwithtax=stmt.executeUpdate(strinsertwithtax);
					        if(insertwithtax<=0){
								errorstatus=1;
								return 0;
							}
					       
					        /*else{
					        	String strinserttax="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+clientacno+","+testdramt+","+curid+",1,'"+note+"',"+docno+","+testldramt+")";
					        	int inserttax=stmt.executeUpdate(strinserttax);
					        	if(inserttax<=0){
					        		errorstatus=1;
					        		return 0;
					        	}
					        }*/
						}
					}
					else{
					    testldramt1=testdramt1*clientrate;
						String strinserttax="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+clientacno+","+testdramt1+","+clientcurr+",1,'"+note+"',"+docno+","+testldramt1+")";
			        	int inserttax=stmt.executeUpdate(strinserttax);
			        	if(inserttax<=0){
			        		errorstatus=1;
			        		return 0;
			        	}
					}
				    if(vsexp==1){
				    	testdramt=(netvalue+netbook)*-1;
				    	testldramt=testdramt*currate;

				        if(testdramt<0){
				            netid=-1;
				        }
				        else{
				            netid=1;
				        }
				        note="Net Amount of "+dtype+"  "+docno+"  "+regno+" Fl "+fleetno;

				        if(testdramt!=0.0){
				        	String strinsertnet="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+netacno+","+testdramt+","+curid+","+netid+",'"+note+"',"+docno+","+testldramt+")";
				        	int insertnet=stmt.executeUpdate(strinsertnet);
				        	if(insertnet<=0){
				        		errorstatus=1;
				        		return 0;
				        	}
				        	testdramt=netbook;
				        	testldramt=testdramt*currate;
				        	note="Sales Expenditure of "+dtype+"  "+docno+"  "+regno+" Fl "+fleetno;
				            if(testdramt!=0.0){
				            	String strinsertvsexp="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+vsexpacno+","+testdramt+","+
				                " "+curid+",1,'"+note+"',"+docno+","+testldramt+")";
				            	int insertvsexp=stmt.executeUpdate(strinsertvsexp);
				            	if(insertvsexp<=0){
				            		errorstatus=1;
				            		return 0;
				            	}
				            }
				        }
				    }
				    else{
				    	testdramt=netvalue*-1;
				    	testldramt=testdramt*currate;
				        if(testdramt<0){
				        	netid=-1;
				        }
				        else{
				        	netid=1;
				        }
				        note="Net Amount of "+dtype+"  "+docno+"  "+regno+" Fl "+fleetno;
				        if(doubleentry==0){
				        	if(testdramt!=0.0){
					        	String strinsertnet="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+netacno+","+testdramt+","+curid+","+netid+",'"+note+"',"+docno+","+testldramt+")";
					        	int insertnet=stmt.executeUpdate(strinsertnet);
				            	if(insertnet<=0){
				            		errorstatus=1;
				            		return 0;
				            	}
					        }
				        }
				        else{
				        	testdramt=salesprice*-1;
				        	testldramt=testdramt*currate;
				        	note="Sales Price of "+dtype+"  "+docno+"  "+regno+" Fl "+fleetno+" "+desc;
				        	String strinsertnew1="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+netacno+","+testdramt+","+curid+",-1,'"+note+"',"+docno+","+testldramt+")";
				        	int insertnew1=stmt.executeUpdate(strinsertnew1);
				        	if(insertnew1<=0){
				        		errorstatus=1;
				        		return 0;
				        	}
				        	testdramt=netbook;
				        	testldramt=testdramt*currate;
				        	note="Net Book of "+dtype+"  "+docno+"  "+regno+" Fl "+fleetno;
				        	String strinsertnew2="insert into eq_vsaletempjv(trno,acno,dramount,curid,id,desc1,mdoc,ldramount)values("+trno+","+cvsacno+","+testdramt+","+curid+",1,'"+note+"',"+docno+","+testldramt+")";
				        	int insertnew2=stmt.executeUpdate(strinsertnew2);
				        	if(insertnew2<=0){
				        		errorstatus=1;
				        		return 0;
				        	}
				        }
				        
				    }
				}

			
			}
			
			if(errorstatus==0){
				return docno;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			errorstatus=0;
			return 0;
		}
		finally{
		}
		return 0;
	}
	
}
