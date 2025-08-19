package com.equipment.equipvehsalesinvreturn;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsAmountToWords;
import com.common.ClsApplyDelete;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.equipment.equipvehsalesinvreturn.ClsEquipVehSalesInvReturnBean;

import net.sf.json.JSONArray;

public class ClsEquipVehSalesInvReturnDAO {
	ClsEquipVehSalesInvReturnBean disposalbean=new ClsEquipVehSalesInvReturnBean();
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
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
	        	String strSql="select sale1.description salesinvremarks,sale1.voc_no salesinvvocno,sale.salesinvdocno,sale.salesinvtrno,sale.doc_no,"+
				" sale.voc_no,sale.date,sale.acno,if(sale.type='S','Sale','Total Loss') typename,sale.type,"+
				" sale.description,sale.trno,ac.refname,ac.address,ac.per_mob,ac.mail1,sale.cldocno,sale.brhid from eq_vsaleretm sale left "+
	        	" join eq_vsalem sale1 on (sale.salesinvtrno=sale1.trno) left join my_head head on sale.acno=head.doc_no left join my_acbook ac on (sale.cldocno=ac.cldocno and ac.dtype='CRM') where sale.status<>7 and sale.brhid='"+branch+"'"+sqltest;
	        //	System.out.println("search======"+strSql);
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
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public JSONArray getSalesInv(String searchdate,String name,String docno,String acno,String mobile) throws SQLException {
	    Connection conn = null;
	    JSONArray data=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!(searchdate.equalsIgnoreCase(""))){
				sqldate=objcommon.changeStringtoSqlDate(searchdate);
			}
			if(!(docno.equalsIgnoreCase("") || docno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and m.voc_no like '%"+docno+"%'";
			}
			if(sqldate!=null){
				sqltest=sqltest+" and m.date='"+sqldate+"'";
				
			}
			if(!(name.equalsIgnoreCase("") || name.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and ac.refname like '%"+name+"%'";
			}
			if(!(acno.equalsIgnoreCase("") || acno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and head.account like '%"+acno+"%'";
			}
			if(!(mobile.equalsIgnoreCase("") || mobile.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and ac.per_mob like '%"+mobile+"%'";
			}
				Statement stmt = conn.createStatement();
	        	String strSql="select m.trno salesinvtrno,ac.cldocno,m.doc_no,m.voc_no,head.doc_no acno,head.account,ac.refname,m.description,m.date,ac.per_mob,ac.address,ac.mail1,curr.code currency,m.currrate rate,m.clientcurr curid,m.billtype from eq_vsalem m "+
				" left join my_head head on (m.acno=head.doc_no) left join my_acbook ac on head.doc_no=ac.acno left join my_curr curr on curr.doc_no=m.clientcurr where m.status=3"+sqltest;
	        	System.out.println(strSql); 
				ResultSet resultSet = stmt.executeQuery (strSql);
				data=objcommon.convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
	    return data;
	}
	
	
	public   JSONArray fleetSearch(String branch,String salesinvdocno) throws SQLException {
	    Connection conn =null;
	    JSONArray data=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			
			Statement stmt = conn.createStatement();
	        	String strSql="select veh.fleet_no,veh.flname,veh.reg_no,plate.code_name platecode,veh.ch_no chassisno,d.salesprice,d.dep_posted,"+
	        	" d.pvalue pur_value,d.acdep acc_dep,d.curdep cur_dep,d.netbook,d.netval net_pl,d.sr_no,d.trsalesprice from eq_vsaled d left join gl_equipmaster "+
	        	" veh on d.fleetno=veh.fleet_no left join gl_vehplate plate on veh.pltid=plate.doc_no where tran_code='FS' and statu<>7 and d.returnstatus=0 and d.rdocno="+salesinvdocno;
//	        	System.out.println(strSql);
				ResultSet resultSet = stmt.executeQuery (strSql);
				data=objcommon.convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("data=========>"+data);
	    return data;
	}
	
	
	public JSONArray getVehSalesInvReturnJvData(String trno,String id,String fleetno) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    if(!id.equalsIgnoreCase("2")){
	    	return RESULTDATA;
	    }
	    Connection conn=null;
		try {
				conn=objconn.getMyConnection();
				Statement stmtjv=conn.createStatement ();
				String strSql="select if(j.dramount>0,round(j.dramount*j.id,2),0) credit ,if(j.dramount<0,round(j.dramount*j.id,2),0) debit,"+
	        	" round(j.ldramount*j.id,2) baseamt,j.description desc1,h.account acno,	h.description acname,h.atype type from my_jvtran j left join my_head h on"+
	        	" j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId where j.tr_no="+trno+" and j.costtype=6 and j.costcode in ("+fleetno+")";
	        //	System.out.println(strSql);
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
	
	public boolean edit(Date sqlStartDate, String cmbtype,
			String description, HttpSession session, String mode, int docno,int trno,ArrayList<String> disposalarray,String formdetailcode,String clientacno,String client,
			String branch, String salesinvdocno, String salesinvtrno,String cmbbilltype,String clientcurr,Double currrate) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtDisposal = conn.prepareCall("{call eqSalesInvReturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
			stmtDisposal.setString(13,salesinvdocno);
			stmtDisposal.setString(14,salesinvtrno);
			  stmtDisposal.setString(15,cmbbilltype);
              stmtDisposal.setString(16,clientcurr);
              stmtDisposal.setDouble(17,currrate);

			int aa = stmtDisposal.executeUpdate();
			
//			System.out.println("inside DAO1");
			if (aa>0) {
//				System.out.println("Success");
				Statement stmtDisp= conn.createStatement ();
				int i=stmtDisp.executeUpdate("delete from eq_vsaled where rdocno='"+docno+"' and trno='"+trno+"'");
				if(i>0){
					int j=insertdet(disposalarray, docno, trno, conn,sqlStartDate,clientacno,mode,formdetailcode,session,client,null,branch,salesinvdocno,salesinvtrno,cmbbilltype,description);
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
			String description, HttpSession session, String mode, int docno,int trno,String formdetailcode,String clientacno,String branch) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtDisposal = conn.prepareCall("{call eqSalesInvReturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
			stmtDisposal.setString(13,"0");
			stmtDisposal.setString(14,"0");
			int aa = stmtDisposal.executeUpdate();
			
//			System.out.println("inside DAO1");
			ClsApplyDelete ad=new ClsApplyDelete();
			int data=ad.getFinanceApplyDelete(conn, trno);
			
			  if (aa>0 && data==1) {
				  //System.out.println("Success");
				  conn.commit();
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
	public ClsEquipVehSalesInvReturnBean insert(Date sqlStartDate,  String cmbtype,
			String description, HttpSession session, String mode,ArrayList<String> disposalarray,
			String formdetailcode,String clientacno,String client,String days,String branch,HttpServletRequest request,
			String mdoc, String salesinvdocno, String salesinvtrno,String cmbbilltype,String clientcurr, Double currrate) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			int docno1=0,trno=0,vocno=0;
//			System.out.println("Inside Dao");
			conn.setAutoCommit(false);	
			CallableStatement stmtDisposal = conn.prepareCall("{call eqSalesInvReturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
			stmtDisposal.setString(13,salesinvdocno);
			stmtDisposal.setString(14,salesinvtrno);
			 stmtDisposal.setString(15,cmbbilltype);
	            stmtDisposal.setString(16,clientcurr);
	            stmtDisposal.setDouble(17,currrate);

			stmtDisposal.executeQuery();
			docno1=stmtDisposal.getInt("docNo");
			trno=stmtDisposal.getInt("trNo1");
			vocno=stmtDisposal.getInt("vocno");
			request.setAttribute("VOCNO", vocno);
//			System.out.println("Docno:"+docno1+"/////Trno:"+trno+"/////Vocno:"+vocno);
			if (docno1 > 0) {
				disposalbean.setTrno(trno);
//				System.out.println("no====="+docno1);
				disposalbean.setDocno(docno1);
//				System.out.println("Success"+disposalbean.getDocno());
//				System.out.println("Action Arrray length"+disposalarray.size());
				int j=insertdet(disposalarray,docno1,trno,conn,sqlStartDate,clientacno,mode,formdetailcode,session,client,days,branch,salesinvdocno,salesinvtrno,cmbbilltype,description);
				
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
			String formdetailcode,HttpSession session,String client,String days,String branch, String salesinvdocno, String salesinvtrno,String cmbbilltype,String description) throws SQLException {
		
		try {
//			System.out.println("Inside Insert Details");
			Statement stmtDisposal;
			int val=0;
			stmtDisposal = conn.createStatement ();
//			System.out.println(disposalarray.size());
			for(int i=0;i< disposalarray.size();i++){
				String[] disposal=disposalarray.get(i).split("::");
//				System.out.println("Here");
				String sql="insert into eq_vsaleretd(trno,rdocno,sr_no,fleetno,salesprice,dep_posted,pvalue,acdep,curdep,netval,salestatus,netbook,salesinvdocno,salesinvtrno,trsalesprice)values('"+trno+"','"+docno+"','"+(i+1)+"',"+
				"'"+(disposal[0].equalsIgnoreCase("undefined") || disposal[0].isEmpty()?0:disposal[0])+"','"+(disposal[2].equalsIgnoreCase("undefined") || disposal[2].isEmpty()?0:disposal[2])+"',"+
				"'"+objcommon.changetstmptoSqlDate((disposal[3].equalsIgnoreCase("undefined") || disposal[3].isEmpty()?0:disposal[3]).toString())+"','"+(disposal[4].equalsIgnoreCase("undefined") || disposal[4].isEmpty()?0:disposal[4])+"',"+
				"'"+(disposal[5].equalsIgnoreCase("undefined") || disposal[5].isEmpty()?0:disposal[5])+"','"+(disposal[6].equalsIgnoreCase("undefined") || disposal[6].isEmpty()?0:disposal[6])+"',"+
				"'"+(disposal[7].equalsIgnoreCase("undefined") || disposal[7].isEmpty()?0:disposal[7])+"',1,'"+(disposal[8].equalsIgnoreCase("undefined") || disposal[8].isEmpty()?0:disposal[8])+"',"+salesinvdocno+","+salesinvtrno+","
			    + "'"+(disposal[9].equalsIgnoreCase("undefined") || disposal[9].isEmpty()?0:disposal[9])+"')";
				String strupdateveh="update gl_equipmaster set fstatus='L' where fleet_no="+(disposal[0].equalsIgnoreCase("undefined") || disposal[0].isEmpty()?0:disposal[0]);
				String strupdatesalesinvdet="update eq_vsaled set returnstatus=1 where rdocno="+salesinvdocno+" and fleetno="+(disposal[0].equalsIgnoreCase("undefined") || disposal[0].isEmpty()?0:disposal[0]);
				
				Statement stmtvehupdate=conn.createStatement();					
				int updatesalesinvdet=stmtvehupdate.executeUpdate(strupdatesalesinvdet);
				if(updatesalesinvdet<=0){
					return 0;
				}
				//System.out.println("Sql"+sql);
				 val = stmtDisposal.executeUpdate (sql);
				if(val<0){
					return 0;
				}
				if(val>0){
					int updateval=stmtvehupdate.executeUpdate(strupdateveh);
					if(updateval>0){
						String fleetno=(disposal[0].equalsIgnoreCase("undefined") || disposal[0].isEmpty()?0:disposal[0]).toString();
						java.sql.Date deprdate=objcommon.changetstmptoSqlDate((disposal[3].equalsIgnoreCase("undefined") || disposal[3].isEmpty()?0:disposal[3]).toString());
						double purchasevalue=Double.parseDouble((disposal[4].equalsIgnoreCase("undefined") || disposal[4].isEmpty()?0:disposal[4]).toString());
					    double accdepr=Double.parseDouble((disposal[5].equalsIgnoreCase("undefined") || disposal[5].isEmpty()?0:disposal[5]).toString());
					    double currdepr=Double.parseDouble((disposal[6].equalsIgnoreCase("undefined") || disposal[6].isEmpty()?0:disposal[6]).toString());
					    double salesprice=Double.parseDouble((disposal[2].equalsIgnoreCase("undefined") || disposal[2].isEmpty()?0:disposal[2]).toString());
					    double netvalue=Double.parseDouble((disposal[7].equalsIgnoreCase("undefined") || disposal[7].isEmpty()?0:disposal[7]).toString());
					    double netbook=Double.parseDouble((disposal[8].equalsIgnoreCase("undefined") || disposal[8].isEmpty()?0:disposal[8]).toString());
	                     double trsalesprice=Double.parseDouble((disposal[9].equalsIgnoreCase("undefined") || disposal[9].isEmpty()?0:disposal[9]).toString());

					    int jvval=insertJVEntries(fleetno,sqlStartDate,deprdate,purchasevalue,accdepr,currdepr,salesprice,netvalue,clientacno,
					    		mode,formdetailcode,session.getAttribute("USERID").toString(),branch,session.getAttribute("CURRENCYID").toString(),
					    		client,docno,trno,netbook,conn,salesinvdocno,salesinvtrno,cmbbilltype,trsalesprice,description);
						
						if(jvval<0){
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
			int docno, int trno, double netbook, Connection conn, String salesinvdocno, String salesinvtrno,String cmbbilltype,double trsalesprice, String description) {
		// TODO Auto-generated method stub
		
		try{
			Statement stmt=conn.createStatement();
			int vehacno=0,vadacno=0,vdeacno=0,netacno=0,cvsacno=0,srno=0,vsexp=0,vsexpacno=0,netid=0,taxacno=0,tax=0,
					clienttax=0,doubleentry=0;
			String regno="";
			double currate=0.0,testdramt=0.0,testldramt=0.0,vatpercent=0.0,taxamt=0.0;
			String note="";
			
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
			//	System.out.println(strgetdata);
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

			  testdramt=purchasevalue;
			  testldramt=testdramt*currate;
			  note="Purchase Value of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;
			  if(testdramt!=0){
				  String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
				  " doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+vehacno+","+testdramt+","+currate+","+
				  " "+curid+",0,1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',"+testldramt+","+docno+",'Purchase Value',"+curid+",'5',1,0,3,6,"+fleetno+")";
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


			  testdramt=(accdepr+currdepr)*-1;
			  testldramt=testdramt*currate;
			  note="AccDepr+CurrDepr of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;

			  if(testdramt!=0.0){

			  	String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
			  	" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+vadacno+","+testdramt+","+currate+","+
			  	" "+curid+",0,-1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',"+testldramt+","+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
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
			  
			  testdramt=currdepr*-1;
			  testldramt=testdramt*currate;
			  note="CurrDepr of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;
			  if(testdramt!=0.0){
				  String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,"+
				" ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+vdeacno+","+testdramt+","+currate+","+
				" "+curid+",0,-1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',"+testldramt+","+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
				  int insertjv=stmt.executeUpdate(strinsertjv);
				  if(insertjv<0){
					  return 0;
				  }
			  }

			  testdramt=currdepr;
			  testldramt=testdramt*currate;
			  note="CurrDepr of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;

			  if(testdramt!=0){
				  String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
				" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+vadacno+","+testdramt+","+currate+","+
				" "+curid+",0,1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',"+testldramt+","+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
				int insertjv=stmt.executeUpdate(strinsertjv);
				if(insertjv<=0){
					return 0;
				}
				String strinsertgc="insert into eq_assettran(date,doc_no,fleet_no,acno,dramount,brhid,ttype,ftype,tr_no,frmdate,days)values('"+sqlStartDate+"',"+docno+","+fleetno+","+
				" "+vadacno+","+testdramt+","+branch+",'ESI',1,"+trno+",'"+deprdate+"',"+currdepr+")";
				int insertgc=stmt.executeUpdate(strinsertgc);
			  	if(insertgc<=0){
			  		return 0;
			  	}
			  }

			  testdramt=salesprice*-1;
			  testldramt=testdramt*currate;
			 // note="Sales Price of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;
              note="Sales Price - "+regno+" Fl "+fleetno+" - "+description;

			  String clientcurr="";double clientrate=0.00;
              String llls1="select  clientcurr, currrate clientrate from eq_vsalem where doc_no='"+salesinvdocno+"'";
              System.out.println("---1----sqls10----"+llls1) ;
                  ResultSet t1sql1s1 = stmt.executeQuery(llls1);
                  if(t1sql1s1.next()) {

                  clientcurr=t1sql1s1.getString("clientcurr");    
                  clientrate=t1sql1s1.getDouble("clientrate");    
  
        
                  }     
                  double testdramt1=trsalesprice*-1;
                  double  testldramt1=0.00;
                   testdramt=salesprice*-1;
			  if(testdramt!=0.0){
			      if(tax==1 && clienttax==1){    
			          if(cmbbilltype.equalsIgnoreCase("1"))  
                      {
			    	  String strgettax="select coalesce(vat_per,0.0) vatpercent,inv.acno taxacno from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqlStartDate+"' between tax.fromdate and tax.todate";
			    	  ResultSet rsgettax=stmt.executeQuery(strgettax);
			    	  while(rsgettax.next()){
							vatpercent=rsgettax.getDouble("vatpercent");
							taxacno=rsgettax.getInt("taxacno");
						}
					/*	taxamt=testdramt*(vatpercent/100);
				        if(taxamt!=0.0){
				            testdramt=testdramt+(testdramt*(vatpercent/100));
				        }

				        testldramt=testdramt*clientrate;*/
			    	  
			    	  taxamt=testdramt*(vatpercent/100);
                      String uptaxsql="update eq_vsaleretm set taxamount='"+taxamt+"' where doc_no="+docno+" ";
                      stmt.executeUpdate(uptaxsql);
                      
                      testdramt1=testdramt1+(testdramt1*(vatpercent/100));

                        
                      testldramt1=testdramt1*clientrate;
                   
				        String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,"+
				        " dtype,ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+clientacno+","+testdramt1+","+
				        " "+clientrate+","+clientcurr+",0,-1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',"+testldramt1+","+docno+",'"+note+"',"+clientcurr+",'5',1,"+cldocno+",3,6,"+fleetno+")";
				        int insertjv=stmt.executeUpdate(strinsertjv);
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
							        " doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+taxacno+","+taxamt+","+currate+","+
							        " "+curid+",0,1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',"+taxamt*currate+","+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
							        int insertjv2=stmt.executeUpdate(strinsertjv2);
							        if(insertjv2<=0){
							        	return 0;
							        }
				        }
			      }
				
			  
			  else if(cmbbilltype.equalsIgnoreCase("2")) 
              {
			      String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,"+
			                " dtype,ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+clientacno+","+testdramt1+","+clientrate+","+
			                 " "+clientcurr+",0,-1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',"+testdramt+","+docno+",'"+note+"',"+clientcurr+",'5',1,"+cldocno+",3,6,"+fleetno+")";
			                  int insertjv=stmt.executeUpdate(strinsertjv);
			                  if(insertjv<=0){
			                      return 0;
			                  }
			                         
              }
			      }
			  else{
                  String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,"+
                " dtype,ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+clientacno+","+testdramt1+","+clientrate+","+
                 " "+clientcurr+",0,-1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',"+testdramt+","+docno+",'"+note+"',"+clientcurr+",'5',1,"+cldocno+",3,6,"+fleetno+")";
                  int insertjv=stmt.executeUpdate(strinsertjv);
                  if(insertjv<=0){
                      return 0;
                  }
                          
              }
          }

			    if(vsexp==1){
			    	testdramt=(netvalue+netbook);
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
			            " doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+netacno+","+testdramt+","+currate+","+
			            " "+curid+",0,"+netid+","+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',"+testldramt+","+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
			            int insertjv=stmt.executeUpdate(strinsertjv);
			            if(insertjv<=0){
			            	return 0;
			            }
			            testdramt=netbook*-1;
			            testldramt=testdramt*currate;
			            note="Sales Expenditure of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;
			            if(testdramt!=0){
			                String strinsert="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,"+
			                " ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+vsexpacno+","+testdramt+","+currate+","+
			            " "+curid+",0,-1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',"+testldramt+","+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
			                int insertjv2=stmt.executeUpdate(strinsert);
			                if(insertjv2<=0){
			                	return 0;
			                }
			            }
			        }
			    }
			    else{
			    	testdramt=netvalue;
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
			                " doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+netacno+","+testdramt+","+currate+","+
			                " "+curid+",0,"+netid+","+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',"+testldramt+","+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
			                  int insertjv=stmt.executeUpdate(strinsertjv);
			                  if(insertjv<=0){
			                	  return 0;
			                  }
			              }
			        }
			        else{
			            testdramt=salesprice;
			            testldramt=testdramt*currate;
			            note="Sales Price of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;
			            String strinsert="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,"+
			            " dtype,ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+netacno+","+testdramt+","+
			            " "+currate+","+curid+",0,1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',"+testldramt+","+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
			            int insertjv=stmt.executeUpdate(strinsert);
			            if(insertjv<=0){
			            	return 0;
			            }
			            testdramt=netbook*-1;
			            testldramt=testdramt*currate;
			            note="Net Book of "+formdetailcode+"  "+docno+"  "+regno+" Fl "+fleetno;

			            String strinsertjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
			            " doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+trno+","+cvsacno+","+testdramt+","+currate+","+
			            " "+curid+",0,-1,"+srno+","+branch+",'"+note+"',0,'"+sqlStartDate+"','"+formdetailcode+"',"+testldramt+","+docno+",'"+note+"',"+curid+",'5',1,0,3,6,"+fleetno+")";
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
	            //   System.out.println("--jvdramount----"+jvdramount) ;
	                if(jvdramount>0 || jvdramount<0)
	                {
	                         
	                     if(jvdramount>1 || jvdramount<-1){
	                         System.out.println("jvdramount>1 and <-1 condition satisfies amount is :-"+jvdramount);
	                            conn.close();
	                            return 0;
	                        }
	                     }
			    
			    
			    String strupdateassettran="update eq_assettran set transtype='R' where fleet_no="+fleetno+" and tr_no in ("+trno+","+salesinvtrno+")";
			    int updateassettran=stmt.executeUpdate(strupdateassettran);
			    if(updateassettran<=0){
			    	return 0;
			    }
			}
			return docno;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}
	
	
	public   ClsEquipVehSalesInvReturnBean getPrint(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ClsEquipVehSalesInvReturnBean bean=new ClsEquipVehSalesInvReturnBean();
		Connection conn=null;
		String currency="";
		try{
			conn=objconn.getMyConnection();
			ClsAmountToWords obj=new ClsAmountToWords();
			Statement stmt=conn.createStatement();
			String strsql="select sale1.doc_no salesinvdocno,sale1.voc_no salesinvvocno,sale1.trno salesinvtrno,coalesce(sale1.description,'') salesinvremarks,coalesce(br.tinno,'') comptrn,coalesce(ac.trnnumber,'') clienttrn,br.branchname,lc.loc_name,br.address branchaddress,br.tel brtel,br.fax brfax,comp.company,sale.doc_no,sale.voc_no,DATE_FORMAT(sale.date,'%d/%m/%Y') "+
			" date,sale.cldocno,coalesce(ac.refname,'') refname,coalesce(ac.address,'') addr1,coalesce(ac.address2,'') addr2,coalesce(ac.com_mob,'') mob,coalesce(ac.per_mob,'') phone,"
			+ "if(sale.type='S','Sale','Loss') type,sale.description,cur.code cur,DATE_FORMAT(CURDATE(),'%d/%m/%Y') finaldate,ms.user_name from eq_vsaleretm sale left join eq_vsalem sale1 on sale.salesinvtrno=sale1.trno left join my_acbook ac on "+
			" (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on (sale.brhid=br.doc_no) left join my_comp comp on (br.cmpid=comp.doc_no) left join my_curr cur on comp.curid=cur.doc_no"
			+ " inner join my_locm l on l.brhid=br.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=br.doc_no) "
			+ "left join datalog dl on sale.doc_no=dl.doc_no and dl.dtype='ESIR' left join my_user ms on ms.doc_no=dl.userid  where  sale.doc_no="+docno;
			ResultSet rssale=stmt.executeQuery(strsql);
	//		System.out.println("main details"+strsql);
			
			while(rssale.next()){
				bean.setLblsalesinvdocno(rssale.getString("salesinvdocno"));
				bean.setLblsalesinvremarks(rssale.getString("salesinvremarks"));
				bean.setLblsalesinvtrno(rssale.getString("salesinvtrno"));
				bean.setLblsalesinvvocno(rssale.getString("salesinvvocno"));
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
				
				currency=rssale.getString("cur");
				
			}
			
			

	//		ArrayList<Double> totalarray=new ArrayList<>();

			String strtotal="select round(sum(coalesce(saled.salesprice,0)),2) total from eq_vsaleretd saled where saled.rdocno="+docno;
			ResultSet rstotal=stmt.executeQuery(strtotal);
			System.out.println("hhhh"+strtotal);

			while(rstotal.next()){
		//		totalarray.add(rstotal.getDouble("total"));
				
				bean.setLbltotal(rstotal.getString("total"));
			//	bean.setLblamountwords(currency+" "+obj.convertNumberToWords(Double.parseDouble(rstotal.getString("total")))+" only");
			String amountwords=obj.convertAmountToWords(rstotal.getString("total"));
				bean.setLblamountwords(currency+" "+amountwords+"");
			}
			
		String strgettax="select round(sum(coalesce(dramount,0)),2)*jv.id taxamt from eq_vsaleretm sale inner join my_jvtran jv on (sale.trno=jv.tr_no) inner join gl_invmode ac on (jv.acno=ac.acno)  where sale.doc_no="+docno+" and ac.idno=20";
			
            ResultSet rsgettax=stmt.executeQuery(strgettax);
			double taxamt=0.0;
			while(rsgettax.next()){
				taxamt=rsgettax.getDouble("taxamt");
			}
			bean.setLbltaxtotal(taxamt+"");
			double nettotal=objcommon.Round((Double.parseDouble(bean.getLbltotal())+taxamt), 2);
			bean.setLblnettaxtotal(nettotal+"");
			String amountwords=obj.convertAmountToWords(nettotal+"");
			//System.out.println("hhhh"+amountwords);
			bean.setLblamountwords(amountwords+"");
	
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
			String strsql="select veh.ch_no chasisno,concat(veh.reg_no,'-',plt.code_name) reg,saled.sr_no,saled.fleetno fleet_no ,round(saled.salesprice,2) salesprice,if(ac.tax=1,round((salesprice*coalesce(vat_per,0))/100,2),0.00) taxamt,if(ac.tax=1,round((salesprice+(salesprice*coalesce(vat_per,0))/100),2),round(salesprice,2)) netamt,DATE_FORMAT(saled.dep_posted,'%d/%m/%Y') dep_posted,round(saled.pvalue,2) pur_value,round(saled.acdep,2) acc_dep,round(saled.curdep,2) cur_dep,round(saled.netbook,2) netbook,round(saled.netval,2) net_pl,veh.flname,ac.tax "+
	        			" from eq_vsaleretd saled left join gl_equipmaster veh on saled.fleetno=veh.fleet_no left join eq_vsaleretm sale on saled.rdocno=sale.doc_no "
	        			+ " left join gl_vehplate plt on veh.pltid=plt.doc_no left join gl_taxdetail t on sale.date between t.fromdate and todate left join my_acbook ac on sale.cldocno=ac.cldocno and ac.dtype='CRM' "+
	        			" where saled.rdocno="+docno;
			
			
			ResultSet rsprint=stmt.executeQuery(strsql);
			String temp="";
			int i=0;
		//	System.out.println("taxqryyyyyyy====="+strsql);
			
			while(rsprint.next()){
				temp=rsprint.getString("sr_no")+"::"+rsprint.getString("reg")+"::"+rsprint.getString("flname")+"::"+rsprint.getString("dep_posted")+"::"+rsprint.getString("chasisno")+"::"+rsprint.getString("salesprice")+"::"+rsprint.getString("pur_value")+"::"+rsprint.getString("acc_dep")+"::"+rsprint.getString("cur_dep")+"::"+rsprint.getString("netbook")+"::"+rsprint.getString("taxamt")+"::"+rsprint.getString("netamt")+"::"+rsprint.getString("net_pl");
			//	System.out.println("valueeee"+temp);
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
	
	public   ArrayList<String> getSaleInvPrint2(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> invprint=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select concat(veh.reg_no,'-',plt.code_name) reg,veh.ch_no chassis,saled.sr_no,saled.fleetno fleet_no ,round(saled.salesprice,2) salesprice,DATE_FORMAT(saled.dep_posted,'%d/%m/%Y') dep_posted,round(saled.pvalue,2) pur_value,round(saled.acdep,2) acc_dep,round(saled.curdep,2) cur_dep,round(saled.netbook,2) netbook,round(saled.netval,2) net_pl,veh.flname"+
	        			" from eq_vsaleretd saled left join gl_equipmaster veh on saled.fleetno=veh.fleet_no left join eq_vsaleretm sale on saled.rdocno=sale.doc_no"+
	        			" left join gl_vehplate plt on veh.pltid=plt.doc_no where saled.rdocno="+docno;
		//	System.out.println("qqqqqqqqqqqqqqqq"+strsql);
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
			String strsql="select concat(veh.reg_no,'-',plt.code_name) reg,veh.ch_no chassis,saled.sr_no,saled.fleetno fleet_no ,round(saled.salesprice,2) salesprice,if(ac.tax=1,round((salesprice*coalesce(vat_per,0))/100,2),0.00) taxamt,"
					+ " if(ac.tax=1,round((coalesce(vat_per,0)),2),0.00) taxper , round(if(ac.tax=1,round((salesprice+(salesprice*coalesce(vat_per,0))/100),2),salesprice),2) netamt,DATE_FORMAT(saled.dep_posted,'%d/%m/%Y') dep_posted,round(saled.pvalue,2) pur_value,round(saled.acdep,2) acc_dep,round(saled.curdep,2) cur_dep,round(saled.netbook,2) netbook,round(saled.netval,2) net_pl,veh.flname"+
	        			" from eq_vsaleretd saled left join gl_equipmaster veh on saled.fleetno=veh.fleet_no left join eq_vsaleretm sale on saled.rdocno=sale.doc_no"+
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
			//System.out.println("temp"+temp);
						
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
	
	
	public   JSONArray disposalgridSearch(String branch,String docno) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
				conn=objconn.getMyConnection();
				Statement stmtmovement = conn.createStatement ();
				if(!(branch.equalsIgnoreCase(""))){
	        	String strSql="select saled.sr_no,saled.fleetno fleet_no ,saled.salesprice,saled.dep_posted,saled.pvalue pur_value,saled.acdep acc_dep,saled.curdep cur_dep,saled.netbook,saled.netval net_pl,veh.flname,veh.reg_no,saled.trsalesprice "+
	        			" from eq_vsaleretd saled left join gl_equipmaster veh on saled.fleetno=veh.fleet_no left join eq_vsalem sale on saled.rdocno=sale.doc_no"+
	        			" where saled.rdocno='"+docno+"' and sale.brhid="+branch;
//	        	System.out.println(strSql);
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
}



