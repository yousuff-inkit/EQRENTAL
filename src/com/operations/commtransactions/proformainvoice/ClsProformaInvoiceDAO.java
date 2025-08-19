package com.operations.commtransactions.proformainvoice;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.common.*;
import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.ClsManualInvoiceAction;
import com.operations.commtransactions.invoice.ClsManualInvoiceBean;
import com.operations.vehicletransactions.movement.ClsMovementBean;
import com.sms.SmsAction;
public class ClsProformaInvoiceDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
ClsProformaInvoiceBean bean = new ClsProformaInvoiceBean();
	public   JSONArray accountSearch() throws SQLException {
		List<ClsManualInvoiceBean> invoicebean = new ArrayList<ClsManualInvoiceBean>();
		String strSql="";
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		try {
			conn=objconn.getMyConnection();

			Statement stmtmanual = conn.createStatement ();
			strSql="select idno,acno,description from gl_invmode where status=1";
			//System.out.println(strSql);
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
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



	public   JSONArray mainSearch(String client,String cmbagmttype,String agmtno,String searchdate,String docno,String branch,String id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		//	    	    	System.out.println(client+":"+cmbagmttype+":"+agmtno+":"+searchdate+":"+docno);
		// String brnchid=session.getAttribute("BRANCHID").toString();
		//System.out.println("name"+sclname);

		String sqltest="";
		java.sql.Date sqldate=null;
		if(!(searchdate.equalsIgnoreCase(""))){
			sqldate=objcommon.changeStringtoSqlDate(searchdate);	
		}

		if(!(client.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+client+"%'";
		}
		if(!(cmbagmttype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and inv.ratype='"+cmbagmttype+"'";
		}
		if(!(agmtno.equalsIgnoreCase(""))){
			if(cmbagmttype.equalsIgnoreCase("RAG")){
				sqltest=sqltest+" and agmt.voc_no like '%"+agmtno+"%'";	
			}
			else if(cmbagmttype.equalsIgnoreCase("LAG")){
				sqltest=sqltest+" and lagmt.voc_no like '%"+agmtno+"%'";
			}

		}

		if(!(docno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and inv.voc_no='"+docno+"'";
		}

		if(branch.equalsIgnoreCase("")){
			branch="0";
		}
		if(!branch.equalsIgnoreCase("")){
			sqltest=sqltest+" and inv.brhid="+branch+"";
		}
		if(sqldate!=null){
			sqltest=sqltest+" and inv.date='"+sqldate+"'";
		}
		Connection conn =null;

		try {
			conn= objconn.getMyConnection();
			Statement stmtsearch = conn.createStatement ();
			String str1Sql="select inv.doc_no,inv.voc_no voucherno,inv.rano,inv.date,inv.ratype agmttype,ac.refname,if(inv.ratype='RAG',agmt.voc_no,lagmt.voc_no) voc_no "+
					" from gl_proinvm inv left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_ragmt agmt on "+
					" (inv.rano=agmt.doc_no and inv.ratype='RAG') left join gl_lagmt lagmt on (inv.rano=lagmt.doc_no and inv.ratype='LAG') where inv.status<>7 "+sqltest+""+
					" group by inv.doc_no";
			System.out.println(str1Sql);
			ResultSet resultSet = stmtsearch.executeQuery(str1Sql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtsearch.close();
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
		//System.out.println(RESULTDATA);
		conn.close();
		return RESULTDATA;
	}





	public   JSONArray getInvoiceGridData(String branch,String docno) throws SQLException {
		List<ClsManualInvoiceBean> invoicebean = new ArrayList<ClsManualInvoiceBean>();
		String strSql="";
		JSONArray RESULTDATA=new JSONArray();
		Connection  conn = null;
		try {

			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			strSql="select invmod.idno idno,invd.acno account,invmod.description,invd.units qty,invd.amount rate,invd.total from gl_proinvm inv"+
					" left join gl_proinvd invd on inv.doc_no=invd.rdocno left join gl_invmode invmod on invd.chid=invmod.idno where inv.doc_no='"+docno+"' and inv.status=3 ";
			//    	System.out.println(strSql);
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
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
	public   JSONArray invoiceSearch() throws SQLException {
		List<ClsManualInvoiceBean> invoicebean = new ArrayList<ClsManualInvoiceBean>();
		String strSql="";
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		try {
			conn=objconn.getMyConnection();

			Statement stmtmanual = conn.createStatement ();
			strSql="select inv.doc_no,inv.rano,inv.date,inv.ratype agmttype,ac.refname from gl_proinvm inv left join my_acbook ac on"+
					" (inv.cldocno=ac.cldocno and ac.dtype='CRM') where inv.status<>7";
			//	System.out.println(strSql);
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
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
	public   JSONArray getAgmtnoSearch(String docno,String fleet,String regno,String client,String agmttype,String date,String mobile,String license,String branch) throws SQLException {
		List<ClsManualInvoiceBean> invoicebean = new ArrayList<ClsManualInvoiceBean>();
		String strSql="";
		JSONArray RESULTDATA=new JSONArray();
		Connection conn =null;
		try {
			conn= objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			java.sql.Date sqlStartDate=null;
			String sqltest="";

			if(!(date.equalsIgnoreCase(""))){
				sqlStartDate=objcommon.changeStringtoSqlDate(date);
			}
			if(sqlStartDate!=null){
				sqltest=sqltest+" and agmt.date='"+sqlStartDate+"'";
			}
			if(!(license.equalsIgnoreCase(""))){
				sqltest=sqltest+" and dr.dlno like '%"+license+"%'";
			}

			if(!(docno.equalsIgnoreCase(""))){
				sqltest=" and agmt.voc_no='"+docno+"'";
			}
			if(!(fleet.equalsIgnoreCase(""))){
				if(agmttype.equalsIgnoreCase("RAG")){
					sqltest=sqltest+" and agmt.ofleet_no like '%"+fleet+"%'";
				}
				if(agmttype.equalsIgnoreCase("LAG")){
					sqltest=sqltest+" and (agmt.tmpfleet like '%"+fleet+"%' or agmt.perfleet like '%"+fleet+"%')";
				}

			}
			if(!(regno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.reg_no like '%"+regno+"%'";
			}
			if(!(client.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.refname like '%"+client+"%'";
			}
			if(!(mobile.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.per_mob like '%"+mobile+"%'";
			}

			//System.out.println("DOCNO:"+docno+"FLEET:"+fleet+"REGNO:"+regno+"CLIENT:"+client+"DATE:"+date+"MOBILE:"+mobile);
			JSONArray jsonArray = new JSONArray();
			//System.out.println("AGMT"+agmttype);
			if(agmttype.equalsIgnoreCase("RAG")){
				strSql="select distinct agmt.doc_no,agmt.voc_no,agmt.cldocno,agmt.ofleet_no,ac.refname,ac.address,coalesce(ac.mail1,'') as email,ac.per_mob,ac.acno,coalesce(dr.name,dr1.name) name,coalesce(dr.mobno,dr1.mobno) mobno,coalesce(dr.dlno,dr1.dlno) dlno,veh.reg_no,"+
						" veh.flname,mov.fleet_no from gl_ragmt agmt "+
						" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_rdriver rdr on  agmt.doc_no=rdr.rdocno  and rdr.status=3  left join gl_drdetails dr on ((rdr.drid=dr.dr_id) "+
						" and dr.dtype='CRM') left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+ 
						" left join gl_vehmaster veh on agmt.ofleet_no=veh.fleet_no left join gl_vmove mov on (agmt.doc_no=mov.rdocno and mov.rdtype='RAG')"+
						" where agmt.brhid="+branch+" and agmt.status=3 "+sqltest+"  group by agmt.doc_no";
			}
			if(agmttype.equalsIgnoreCase("LAG")){
				strSql="select distinct agmt.doc_no,agmt.voc_no,agmt.cldocno,if(agmt.tmpfleet=0,agmt.perfleet,agmt.tmpfleet) ofleet_no,ac.refname,coalesce(ac.mail1,'') as email,ac.address,"+
						" ac.per_mob,ac.acno,dr.name,dr.mobno,dr.dlno,veh.reg_no,veh.flname,mov.fleet_no from gl_lagmt agmt "+
						" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_ldriver rdr on  agmt.doc_no=rdr.rdocno  and rdr.status=3 left join gl_drdetails dr on ((rdr.drid=dr.dr_id) "+
						" and dr.dtype='CRM') left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+
						" left join gl_vehmaster veh on if(agmt.tmpfleet=0,agmt.perfleet,agmt.tmpfleet)=veh.fleet_no left join"+
						" gl_vmove mov on (agmt.doc_no=mov.rdocno and mov.rdtype='LAG') where agmt.brhid="+branch+" and agmt.status=3 "+sqltest+"  group by agmt.doc_no";
			}
			//	System.out.println(strSql);
			if(!(strSql.equalsIgnoreCase(""))){
				ResultSet resultSet = stmtmanual.executeQuery (strSql);

				RESULTDATA=objcommon.convertToJSON(resultSet);

			}
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
	public   ClsProformaInvoiceBean getViewDetails(int docno,String branchid,String cmbagmttype) throws SQLException {
		//List<ClsVehicleBean> listBean = new ArrayList<ClsVehicleBean>();
	//	ClsManualInvoiceBean bean = new ClsManualInvoiceBean();
		Connection  conn =null;
		try {
			conn= objconn.getMyConnection();
			Statement stmtinvoice = conn.createStatement ();
			String strSql="";
			System.out.println("Agmttype:"+cmbagmttype);
			if(cmbagmttype.equalsIgnoreCase("RAG")){
				strSql="select distinct inv.ratype,inv.doc_no invdoc,inv.voc_no  voucherno,inv.date,inv.ldgrnote,inv.fromdate,inv.todate,inv.invnote,agmt.doc_no agmtdoc,agmt.voc_no,agmt.cldocno,"
						+ "agmt.ofleet_no,ac.refname,ac.address,coalesce(ac.per_mob,'') per_mob,ac.acno,coalesce(ac.mail1,'') as email,coalesce(coalesce(dr.name,dr1.name),'') name,coalesce(coalesce(dr.mobno,dr1.mobno),'') mobno,"
						+ "coalesce(coalesce(dr.dlno,dr1.dlno),'') dlno,veh.reg_no,veh.flname,mov.fleet_no from gl_proinvm inv left "
						+ "join gl_proinvd invd on inv.doc_no=invd.rdocno left join gl_ragmt agmt on inv.rano=agmt.doc_no left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM')"
						+ "left join ( select min(srno) srno,rdocno from gl_rdriver where status=3 group by rdocno ) gdr on  agmt.doc_no=gdr.rdocno "
						+ "left join gl_rdriver rdr on  agmt.doc_no=rdr.rdocno and rdr.srno=gdr.srno left join gl_drdetails dr on ((rdr.drid=dr.dr_id) "
						+ " and dr.dtype='CRM') left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no) and dr1.dtype='DRV') left join gl_vehmaster veh on "
						+ "agmt.ofleet_no=veh.fleet_no left join gl_vmove mov on (agmt.doc_no=mov.rdocno and mov.rdtype='RAG') where inv.doc_no='"+docno+"' and inv.status=3";
			}


			if(cmbagmttype.equalsIgnoreCase("LAG")){
				strSql="select distinct inv.ratype,inv.doc_no invdoc,inv.voc_no voucherno,inv.date,inv.ldgrnote,inv.fromdate,inv.todate,inv.invnote,agmt.doc_no agmtdoc,agmt.voc_no,"
						+ "agmt.cldocno,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) ofleet_no,ac.refname,ac.address,coalesce(ac.per_mob,'') per_mob,coalesce(ac.mail1,'') as email,ac.acno,coalesce(coalesce(dr.name,dr1.name),'') name,coalesce(coalesce(dr.mobno,dr1.mobno),'') mobno,"
						+ "coalesce(coalesce(dr.dlno,dr1.dlno),'') dlno,veh.reg_no,veh.flname,mov.fleet_no from gl_proinvm inv left join gl_proinvd invd on inv.doc_no=invd.rdocno left "
						+ "join gl_lagmt agmt on inv.rano=agmt.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') "
						+ "left join ( select min(srno) srno,rdocno from gl_ldriver where status=3 group by rdocno ) gdr on  agmt.doc_no=gdr.rdocno "
						+ " left join gl_ldriver ldr on  agmt.doc_no=ldr.rdocno and ldr.srno=gdr.srno  left join gl_drdetails dr on ((ldr.drid=dr.dr_id) "
						+ " and dr.dtype='CRM') left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no) and dr1.dtype='DRV') left join gl_vehmaster veh on "
						+ " if(agmt.tmpfleet=0,agmt.perfleet,agmt.tmpfleet)=veh.fleet_no left join gl_vmove mov on (agmt.doc_no=mov.rdocno and mov.rdtype='LAG')"
						+ " where inv.status=3 and inv.doc_no="+docno;
			}
			//System.out.println("View Sql:"+strSql);

			ResultSet resultSet = stmtinvoice.executeQuery (strSql);

			while (resultSet.next()) {
				bean.setHidcmbagmttype(resultSet.getString("ratype"));
				bean.setHiddate(resultSet.getString("date"));
				bean.setLedgernote(resultSet.getString("ldgrnote"));
				bean.setInvoicenote(resultSet.getString("invnote"));
				bean.setHidfromdate(resultSet.getString("fromdate"));
				bean.setHidtodate(resultSet.getString("todate"));
				bean.setDocno(resultSet.getInt("invdoc"));
				bean.setVoucherno(resultSet.getInt("voucherno"));
				bean.setAgmtno(resultSet.getInt("agmtdoc"));
				bean.setAgmtvoucherno(resultSet.getInt("voc_no"));
				bean.setHidclient(resultSet.getString("cldocno"));
				String temp1="";
				temp1="Fleet: "+resultSet.getString("ofleet_no");
				temp1=temp1+" "+resultSet.getString("flname");
				temp1=temp1+" Reg No: "+resultSet.getString("reg_no");
				bean.setContractvehicle(temp1);
				String temp2="";
				bean.setClient(resultSet.getString("refname"));
				temp2="Address: "+resultSet.getString("address");
				temp2=temp2+"Mobile: "+resultSet.getString("per_mob");
				bean.setClientdetails(temp2);
				String temp3="";
				bean.setDriver(resultSet.getString("name"));
				bean.setAcno(resultSet.getString("acno"));
				temp3="Mobile: "+resultSet.getString("mobno");
				temp3=temp3+"License No: "+resultSet.getString("dlno");
				bean.setDriverdetails(temp3);
				String temp4="";
				temp4="Fleet: "+resultSet.getString("fleet_no");
				temp4=temp4+" "+resultSet.getString("flname");
				temp4=temp4+" Reg No: "+resultSet.getString("reg_no");
				bean.setVehicledetails(temp4);
				bean.setEmail(resultSet.getString("email"));

			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
	}
	public int insert(Connection conn,ArrayList<String> invoicearray,String cmbagmttype, Date date, String hidclient, int agmtno,
			String ledgernote, String invoicenote, Date fromdate, Date todate,String branchid,String userid,String currencyid,String mode,String acno,
			String dtype,String formdetailcode,String qty2) throws SQLException {


		if(hidclient==null){
			return 0;
		}
		if(hidclient.equalsIgnoreCase("0")){
			return 0;
		}
		int docno=0;
		int trno=0;
		try{
			ClsProformaInvoiceBean invoicebean=new ClsProformaInvoiceBean();
			CallableStatement stmtManual = conn.prepareCall("{call proformaInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtManual.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtManual.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtManual.registerOutParameter(17, java.sql.Types.INTEGER);
			stmtManual.setDate(1,date);
			stmtManual.setString(2,cmbagmttype);
			stmtManual.setString(3,hidclient);
			stmtManual.setInt(4, agmtno);
			stmtManual.setString(5,ledgernote);
			stmtManual.setString(6,invoicenote);
			stmtManual.setString(7,currencyid);
			stmtManual.setString(8,acno);
			stmtManual.setDate(9,fromdate);
			stmtManual.setDate(10,todate);
			stmtManual.setString(11,formdetailcode);
			stmtManual.setString(12,userid);
			stmtManual.setString(13,branchid);
			stmtManual.setString(16,mode);
			//		System.out.println(stmtManual);
			stmtManual.executeQuery();
			docno=stmtManual.getInt("docNo");
			trno=stmtManual.getInt("vtrNo");
			//request.setAttribute("tranno", testtrno);
			//	System.out.println("inv vocno"+stmtManual.getInt("voucher"));
			Statement stmtinvoice;
			int testcurid=0;
			double testcurrate=0.0;
			stmtinvoice = conn.createStatement();
			//System.out.println("Currency"+currencyid);
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
				
				if(Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]))>0){
					String sql="insert into gl_proinvd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(i+1)+"','"+branchid+"','"+docno+"'"+
							 ",'"+trno+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+strqty+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"','"+temprate+"')";
					 //		System.out.println(" Invd Sql"+sql);
					int resultSet = stmtinvoice.executeUpdate (sql);
					if(resultSet>0){
					}
					else{
						System.out.println("Invd Error");
						return 0;
					}
				 }
				 tempno++;	
			}


			//Tax Portion Starts Here
			//	System.out.println("Default General Amount:"+generalamt);
			//if(!(origin.trim().equalsIgnoreCase("1"))){
				double generalamt=0.0;
				Statement stmtchecktax=conn.createStatement();
				String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+hidclient+" and dtype='CRM') clienttaxmethod";
//				System.out.println(strchecktax);
				ResultSet rschecktax=stmtchecktax.executeQuery(strchecktax);
				int taxstatus=0;
				int clienttaxmethod=0;
				while(rschecktax.next()){
					taxstatus=rschecktax.getInt("taxmethod");
					clienttaxmethod=rschecktax.getInt("clienttaxmethod");
				}
				if(taxstatus==1 && clienttaxmethod==1){
//						System.out.println("Inside TaxDetail");
					
					// Getting amount in which tax is applicable
					Statement stmtgettax=conn.createStatement();
					String strtaxapplied="select total from gl_proinvd inv left join gl_invmode ac on inv.chid=ac.idno where ac.tax=1 and inv.rdocno="+docno;
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
					String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno left join my_brch br on tax.province=br.province where tax.status<>7 and '"+date+"' between tax.fromdate and tax.todate and br.doc_no="+branchid;
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
						
						//generalamt-=saliksrvcvat;
						//generalamt-=trafficsrvcvat;
						generalamt=objcommon.Round(generalamt, 2);

						
						//generalamt=generalamt+vatval;
						generalamt=objcommon.Round(generalamt, 2);
						//generalldr=generalamt*testcurrate;

						int tempsrno=invoicearray.size()+1;
						for(int j=0;j<temptaxarray.size();j++){
							String[] tax=temptaxarray.get(j).split("::");
							Statement stmttaxinvd=conn.createStatement();
							if(Double.parseDouble(tax[2])>0){
								String strtaxinvd="insert into gl_proinvd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+tempsrno+"','"+branchid+"','"+docno+"'"+
										",'"+trno+"','"+(tax[0].equalsIgnoreCase("undefined") || tax[0].isEmpty()?0:tax[0])+"','1','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"')";	
											System.out.println("Invd Sql:"+strtaxinvd);
								int taxinvdval=stmttaxinvd.executeUpdate(strtaxinvd);
								if(taxinvdval>0){
									
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

				int discountconfig=getDiscountConfig(conn);
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
					String sql="insert into gl_proinvd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(tempno+1)+"','"+branchid+"','"+docno+"'"+
							",'"+trno+"','13','1','"+(discount*-1)+"','"+discac+"','"+(discount*-1)+"')";
					int discinvd=stmtdiscinvd.executeUpdate(sql);
					if(discinvd<=0){
						stmtdiscinvd.close();
						stmtdiscjv.close();
						stmtdiscount.close();
						conn.close();
						return 0;
					}
					stmtdiscinvd.close();
					
					stmtdiscjv.close();
					stmtdiscount.close();
				}
				if(ramt>0){
					
				}
				
				stmtdiscount.close();
			}	
//			System.out.println("no====="+docno);
			invoicebean.setDocno(docno);
			
			if (docno > 0) {
				return docno;
			}

		}catch(Exception e){	
			e.printStackTrace();	
			conn.close();
			System.out.println("Exception error");
			return 0;
		}
		return 0;
	}
public double getSalikTrafficVAT(Connection conn, String string,
			double trafficsrvc, String hidclient, Date date,String branchid) {
		// TODO Auto-generated method stub
		double srvcvat=0.0;
		try{
			Statement stmt=conn.createStatement();
			String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+hidclient+" and dtype='CRM') clienttaxmethod";
			System.out.println(strchecktax);
			ResultSet rschecktax=stmt.executeQuery(strchecktax);
			int taxstatus=0;
			int clienttaxmethod=0;
			while(rschecktax.next()){
				taxstatus=rschecktax.getInt("taxmethod");
				clienttaxmethod=rschecktax.getInt("clienttaxmethod");
			}
			if(taxstatus==1 && clienttaxmethod==1){
				
				String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno left join my_brch br on tax.province=br.province where tax.status<>7 and '"+date+"' between tax.fromdate and tax.todate and br.doc_no="+branchid;
				System.out.println("Tax Percent Query: "+strgettax);
				double setpercent=0.0;
				double vatpercent=0.0;
				ResultSet rsgettax=stmt.executeQuery(strgettax);
				double vatval=0.0,setval=0.0;
				ArrayList<String> temptaxarray=new ArrayList<>();
				while(rsgettax.next()){
					setpercent=rsgettax.getDouble("set_per");
					vatpercent=rsgettax.getDouble("vat_per");
					vatval=(trafficsrvc*(vatpercent/100));
					setval=trafficsrvc*(setpercent/100);
					setval=objcommon.Round(setval, 2);
					vatval=objcommon.Round(vatval, 2);
					
				}
				srvcvat=vatval;
		}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return srvcvat;
	}



public int getDiscountConfig(Connection conn) throws SQLException {
		// TODO Auto-generated method stub
	int discount=0;
	try{
		Statement stmt=conn.createStatement();
		String str="select method from gl_config where field_nme='invDiscount'";
		ResultSet rs=stmt.executeQuery(str);
		while(rs.next()){
			discount=rs.getInt("method");
		}
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
		return discount;
	}
public int getInvDescConfig(Connection conn) {
		// TODO Auto-generated method stub
		int invdesc=0;
		try{
			Statement stmt=conn.createStatement();
			String str="select method from gl_config where field_nme='invdesc'";
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				invdesc=rs.getInt("method");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return invdesc;
	}

	public   ClsProformaInvoiceBean getPrint(String fromno,String tono,String branch,String printdocno,String allbranch,String hidheader) throws SQLException {
		//ClsManualInvoiceBean bean = new ClsManualInvoiceBean();
		Connection  conn =null;
		HttpServletRequest request=ServletActionContext.getRequest();
		ArrayList<ClsProformaInvoiceAction> employees = new ArrayList();
		try {
			conn= objconn.getMyConnection();
			ClsNumberToWord obj=new ClsNumberToWord();
			ClsAmountToWords objamt=new ClsAmountToWords();
			Statement stmtinvoice = conn.createStatement ();
			String strSql="";
			//System.out.println("Print Docno:"+printdocno);
			//System.out.println("Check2:"+agmttype);
			/*if(agmttype.equalsIgnoreCase("RAG")){
				strSql="select ac.acno,br.branch,year(inv.date) dateyear,agmt.pono,DATE_FORMAT(CURDATE(),'%d/%m/%Y') finaldate,cur.code,cmp.company,cmp.address,cmp.tel,cmp."+
			" fax,br.branchname,ac.refname,ac.com_mob,ac.per_mob,ac.fax1,dr.name,inv.doc_no, DATE_FORMAT(inv.date,'%d/%m/%Y') date,inv.rano,"+
			" DATE_FORMAT(inv.fromdate,'%d/%m/%Y') fromdate, DATE_FORMAT(inv.todate,'%d/%m/%Y') todate,inv.acno, inv.ratype,"+
			" hed.description,agmt.ofleet_no,agmt.mrano,DATE_FORMAT(agmt.odate,'%d/%m/%Y') agmtdate,veh.flname,veh.reg_no,plt.code_name,"+
			" auth.authname, round(sum(invd.total),2) total, round(sum(invd.total),2) nettotal,dr.name driven,ac.address,"+
			" ac.address2,loc.loc_name from gl_proinvm inv left join gl_proinvd invd on inv.doc_no=invd.rdocno left join gl_ragmt agmt on"+
			" inv.rano=agmt.doc_no left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM')  left join my_head hed on"+
			" inv.acno=hed.doc_no  left join gl_vehmaster veh on agmt.ofleet_no=veh.fleet_no left join gl_vehplate plt on veh.pltid=plt.doc_no"+
			" left join gl_vehauth auth on veh.authid=auth.doc_no left join gl_rdriver rdr on agmt.doc_no=rdr.rdocno left join gl_drdetails dr"+
			" on (agmt.drid=dr.dr_id or rdr.drid=dr.dr_id) left join my_brch br on inv.brhid=br.doc_no left join my_comp cmp on"+
			" br.cmpid=cmp.doc_no left join my_curr cur on cmp.curid=cur.doc_no left join my_locm loc on loc.brhid=br.doc_no where inv.doc_no >="+fromno+" and inv.doc_no<="+tono+" group by inv.doc_no";
			}
			if(agmttype.equalsIgnoreCase("LAG")){
				strSql="select ac.acno,br.branch,year(inv.date) dateyear,DATE_FORMAT(CURDATE(),'%d/%m/%Y') finaldate,cur.code,cmp.company,cmp.address,cmp.tel,cmp.fax,br.branchname,"+
						"ac.refname,coalesce(ac.com_mob,'') com_mob,ac.per_mob,ac.fax1,coalesce(dr.name,'') name, inv.doc_no,DATE_FORMAT(inv.date,"+
						" '%d/%m/%Y') date,inv.rano,DATE_FORMAT(inv.fromdate,'%d/%m/%Y') fromdate,coalesce(DATE_FORMAT(inv.todate,'%d/%m/%Y'),'') todate,"+
						" inv.acno, inv.ratype,hed.description,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)ofleet_no,coalesce(DATE_FORMAT(agmt.outdate,'%d/%m/%Y'),'')"+
						" agmtdate,veh.flname,veh.reg_no,plt.code_name,auth.authname, round(sum(invd.total),2) total, round(sum(invd.total),2) nettotal,"+
						" coalesce(dr.name,'') driven,ac.address,ac.address2,loc.loc_name from gl_proinvm inv left join gl_proinvd invd on inv.doc_no=invd.rdocno"+
						" left join gl_lagmt agmt on inv.rano=agmt.doc_no left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM')  left join"+
						" my_head hed on inv.acno=hed.doc_no  left join gl_vehmaster veh on ((select if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)"+
						" ofleet_no)=veh.fleet_no) left join gl_vehplate plt on veh.pltid=plt.doc_no left join gl_vehauth auth on veh.authid=auth.doc_no"+
						" left join gl_ldriver rdr on agmt.doc_no=rdr.rdocno left join gl_drdetails dr on (agmt.drid=dr.dr_id or rdr.drid=dr.dr_id)"+
						" left join my_brch br on inv.brhid=br.doc_no left join my_comp cmp on br.cmpid=cmp.doc_no left join my_curr cur on"+
						" cmp.curid=cur.doc_no left join my_locm loc on loc.brhid=br.doc_no where inv.doc_no >="+fromno+" and inv.doc_no<="+tono+" group by inv.doc_no";
			}*/
			//System.out.println(strSql);

			String sqltest="";
			/*if(!fromno.equalsIgnoreCase("") && !tono.equalsIgnoreCase("")){
				sqltest+=" and inv.voc_no >="+fromno+" and inv.voc_no<="+tono+"";
			}
			if(fromno.equalsIgnoreCase("") && tono.equalsIgnoreCase("")){
				if(!printdocno.equalsIgnoreCase("")){
					sqltest+=" and inv.voc_no in ("+printdocno+")";	
				}

			}
			if(!printdocno.equalsIgnoreCase("")){
				sqltest+=" and inv.voc_no in ("+printdocno+")";
			}
			else{
				if(!fromno.equalsIgnoreCase("")){
					sqltest+=" and inv.voc_no>="+fromno+"";
				}
				if(!tono.equalsIgnoreCase("")){
					sqltest+=" and inv.voc_no<="+tono+"";
				}
			}*/

			if(allbranch.equalsIgnoreCase("1")){
				sqltest+=" and inv.doc_no in ("+printdocno+")";
			}
			else{
				if(!printdocno.equalsIgnoreCase("")){
					sqltest+=" and inv.voc_no in ("+printdocno+") and inv.brhid="+branch;
				}
				else{
					if(!fromno.equalsIgnoreCase("")){
						sqltest+=" and inv.voc_no>="+fromno+"";
					}
					if(!tono.equalsIgnoreCase("")){
						sqltest+=" and inv.voc_no<="+tono+"";
					}
					if(!branch.equalsIgnoreCase("")){
						sqltest+=" and inv.brhid="+branch;
					}
				}

			}

			ArrayList<Double> totalarray=new ArrayList<>();
			ArrayList<String> totalstringarray=new ArrayList<>();
			String strtotal="select round(sum(coalesce(total,0)),2) total,inv.doc_no from gl_proinvm inv left join gl_proinvd on doc_no=rdocno where 1=1 "+sqltest+" and inv.status<>7 group by doc_no order by doc_no";
			ResultSet rstotal=stmtinvoice.executeQuery(strtotal);

			while(rstotal.next()){
				totalarray.add(rstotal.getDouble("total"));
				totalstringarray.add(rstotal.getString("total"));
			}

			String stremc="select concat('Reg No :',agmt.emcregno,' ',agmt.emcplate) emccustomervehicle,concat('Fleet No :',veh.fleet_no,' ',veh.flname,' Reg No :',"+
			" reg_no,' ',plt.code_name) emccourtesyvehicle from gl_proinvm inv left join gl_ragmt agmt on (inv.rano=agmt.doc_no and inv.ratype='RAG') left join "+
			" gl_vehmaster veh on agmt.fleet_no=veh.fleet_no left join gl_vehplate plt on veh.pltid=plt.doc_no where 1=1 "+sqltest;
			
			ResultSet rsemc=stmtinvoice.executeQuery(stremc);
			while(rsemc.next()){
				bean.setLblcustomervehicle(rsemc.getString("emccustomervehicle"));
				bean.setLblcourtesyvehicle(rsemc.getString("emccourtesyvehicle"));
			}
			
					strSql="select DATE_FORMAT(coalesce(if(lagmt.per_name=1,DATE_ADD(lagmt.outdate,INTERVAL lagmt.per_value YEAR),DATE_ADD(lagmt.outdate,INTERVAL lagmt.per_value MONTH)),agmt.ddate),'%d/%m/%y')enddate,"
							+ " DATE_FORMAT(if((d.method=0)&&(d.delivery=1), din ,  coalesce(agmt.odate,lagmt.outdate)),'%d/%m/%Y') agmtdate,ac.trnnumber clienttrn,coalesce(br.tinno,'') comptrn,coalesce(inv.ldgrnote,'') ledgernote,datediff(inv.todate,inv.fromdate) creditdiff,"
					+" insp.doc_no inspno,inspveh.reg_no inspregno,inv.dtype,coalesce(if(inv.ratype='RAG',agmt.refno,lagmt.refno),'') refno,"
					+" case when inv.ratype='RAG' then agmt.otime when inv.ratype='LAG' then lagmt.outtime else '' end invfromtime, "
					+" case when inv.ratype='RAG' and inv.manual=3 then agmtcl.intime when inv.ratype='RAG' and inv.manual<>3 then agmt.otime" 
					+" when inv.ratype='LAG' and inv.manual=5 then lagmtcl.intime when inv.ratype='LAG' and inv.manual<>5 then lagmt.outtime else '' end invtotime,sal.sal_name salesman,"
					+" inv.voc_no,br.pbno,br.stcno,br.cstno,coalesce(dr.name,dr1.name) driven,inv.fromdate sqlfromdate,inv.todate sqltodate,br.branch,year(inv.date) dateyear,"
					+" if(inv.ratype='RAG',agmt.pono,lagmt.po) pono, DATE_FORMAT(CURDATE(),'%d/%m/%Y') finaldate,cur.code,cmp.company,cmp.address ,cmp.tel,cmp.fax,cmp.email,"
					+" cmp.web website,br.branchname,br.address branchaddress,br.tel branchtel,br.fax branchfax,ac.refname,ac.com_mob,ac.per_tel,ac.per_mob,ac.fax1,dr.name, inv.doc_no, DATE_FORMAT(inv.date,'%d/%m/%Y') date,"
					+" if(inv.ratype='RAG',if(agmt.refno is not null,concat(agmt.voc_no,' (',agmt.refno,')'),agmt.voc_no),"
					+" if(lagmt.refno is not null,concat(lagmt.voc_no,' (',lagmt.refno,')'),lagmt.voc_no)) rano1,inv.rano,DATE_FORMAT(inv.fromdate,'%d/%m/%Y') fromdate,"
					+" DATE_FORMAT(inv.todate,'%d/%m/%Y') todate,ac.codeno,inv.acno, convert(concat(inv.ratype,'  -  ',if(inv.ratype='RAG',rt.rentaltype,lt.rentaltype)),char(100)) ratype1 , inv.ratype , if(inv.ratype='RAG',agmt.ofleet_no,veh.fleet_no) ofleet_no, "
					+" if(inv.ratype='RAG',agmt.mrano,lagmt.manualra) mrano,coalesce(DATE_FORMAT(agmt.odate,'%d/%m/%Y'), DATE_FORMAT(lagmt.outdate,'%d/%m/%Y')) agmtdate,"
					+" veh.flname,veh.reg_no,plt.code_name,auth.authname,ac.address cladd,ac.address2 cladd1,lc.loc_name,u.user_name,"
					+" DATE_FORMAT(date_add(inv.date , interval ac.period2 day),'%d/%m/%Y') duedate "
					+" from gl_proinvm inv left join gl_ragmt agmt on (inv.rano=agmt.doc_no and inv.ratype='RAG')"
					+" left join gl_lagmt lagmt on(inv.rano=lagmt.doc_no and inv.ratype='LAG')"
					+" left join (select concat(t.rentaltype,' - ',round(t1.rate,2)) rentaltype,r.doc_no from gl_ragmt r inner join gl_rtarif t "
					+" on r.doc_no=t.rdocno and t.rstatus=5 inner join gl_rtarif t1 on r.doc_no=t1.rdocno and t1.rstatus=7) rt "
					+" on ( rt.doc_no=inv.rano and inv.ratype='RAG' ) left join ( select concat('Lease' ,' - ' ,round(t.rate,2)) rentaltype,l.doc_no "
					+" from gl_lagmt l inner join gl_ltarif t on l.doc_no=t.rdocno ) lt on (lt.doc_no=inv.rano and inv.ratype='LAG' ) "
					+" left join gl_ragmtclosem agmtcl on (agmt.doc_no=agmtcl.agmtno) left join gl_lagmtclosem lagmtcl on (lagmt.doc_no=lagmtcl.agmtno)"
					+" left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM')"
					+" left join my_salm sal on (ac.sal_id=sal.doc_no and ac.dtype='CRM')"
					+" left join gl_vehmaster veh on ((agmt.ofleet_no=veh.fleet_no  and inv.ratype='RAG') or ((select if(perfleet=0,tmpfleet,perfleet) fleet"
					+" from gl_lagmt where doc_no=inv.rano)=veh.fleet_no and inv.ratype='LAG')) left join gl_vehplate plt on veh.pltid=plt.doc_no"
					+" left join gl_vehauth auth on veh.authid=auth.doc_no"
					+" left join (select min(srno) srno,rdocno from gl_rdriver"
					+" where status=3 group by rdocno) gdr on  agmt.doc_no=gdr.rdocno"
					+" left join gl_rdriver rdr on  agmt.doc_no=rdr.rdocno and rdr.srno=gdr.srno"
					+" left join (select min(srno) srno,rdocno from gl_ldriver where status=3 group by rdocno) gldr on  lagmt.doc_no=gldr.rdocno"
					+" left join gl_ldriver ldr on lagmt.doc_no=ldr.rdocno and ldr.srno=gldr.srno"
					+" left join gl_drdetails dr on ((rdr.drid=dr.dr_id or ldr.drid=dr.dr_id) and dr.dtype='CRM')"
					+" left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no or lagmt.drid=dr1.doc_no) and dr1.dtype='DRV')"
					+" left join my_brch br on inv.brhid=br.doc_no left join my_comp cmp on br.cmpid=cmp.doc_no"
					+" left join my_curr cur on cmp.curid=cur.doc_no left join gl_vinspm insp on inv.doc_no=insp.invno"
					+" left join gl_vehmaster inspveh on insp.rfleet=inspveh.fleet_no inner join my_locm l on l.brhid=br.doc_no"
					+" inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc"
					+" on(lc.loc=l.loc and lc.brhid=br.doc_no) left join my_user u on u.doc_no=inv.userid"
					+" left join ( select g.method,m.voc_no invno,coalesce(if(m.ratype='RAG',r.delivery,l.delivery),'') delivery, m.rano"
					+" from gl_proinvm m left join gl_ragmt r on (m.rano=r.doc_no and m.ratype='RAG')"
					+" left join gl_lagmt l on(m.rano=l.doc_no and m.ratype='LAG'), gl_config g where g.field_nme='delcal') as d on d.invno=inv.voc_no"
					+" left join gl_vmove v on v.rdocno=d.rano and (v.rdtype=inv.ratype) and trancode='dl' and repno=0 "
					+" where 1=1 "+sqltest+" and inv.status<>7 group by inv.doc_no";

			System.out.println("Print query:"+strSql);
			/*String strSqldetail="select invd.sr_no,imod.description,invd.units,invd.amount,invd.total from gl_proinvd invd left join gl_invmode imod on "+
								" invd.chid=imod.idno where invd.rdocno >="+fromno+" and invd.rdocno<="+tono+"";
			//System.out.println("Detail"+strSqldetail);
			 */			
			ArrayList<ArrayList<String>> printdet=new ArrayList<>();
			ArrayList<ArrayList<String>> printfleetmaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printsalikmaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printtrafficdubaimaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printtrafficelsemaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printdamagemaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printagmtdetailmaster=new ArrayList<>();
			ResultSet resultSet = stmtinvoice.executeQuery (strSql);
			int i=0;
			String ledgernote="";
			String lblwithtaxvalue="",lblwithouttaxvalue="",lblwithtaxamount="",lblwithouttaxamount="",lblwithtaxtotal="",
			lblwithouttaxtotal="",lbltaxgroupvalue="",lbltaxgrouptotal="";
			String lbltotalvatexcl="0.00",lbltotalvat="0.00",lbltotalvatincl="0.00";
			String lblnettaxvalue="0.00",lblnettaxamount="0.00",lblnettaxtotal="0.00";
			while(resultSet.next()){
				String fleet="";
				fleet="Fleet :"+resultSet.getString("ofleet_no");
				fleet=fleet+" "+resultSet.getString("flname");
				fleet=fleet+" Reg No :"+resultSet.getString("reg_no");
				fleet=fleet+" "+resultSet.getString("code_name");
				fleet=fleet+" "+resultSet.getString("authname");
				//bean.setLblcstno(resultSet.getString("cstno"));
				//bean.setLblservicetax(resultSet.getString("stcno"));
				//bean.setLblpan(resultSet.getString("pbno"));
				/*String lbltotal,String lblnetamount,
				String lblamountwords,String lblcheckedby,String lblrecievedby,String lblfinaldate*/
				/*String lblinvno,String lblclient,String lblaccount,String lbldate,String lbladdress1,String lblrano,String lbladdress2,String lbllpono,
				String lblmrano,String lblmobile,String lblratype,String lblphone,String lblcontractstart,String lbldriven,String lblinvfrom,String lblinvto,String lblcontractvehicle*/
				
				ArrayList<String> printtaxsummary=getPrintTaxSummary(conn,resultSet.getString("doc_no"));
				if(printtaxsummary.size()>0){
					lblwithtaxvalue=printtaxsummary.get(0);
					lblwithtaxamount=printtaxsummary.get(1);
					lblwithtaxtotal=printtaxsummary.get(2);
					lblwithouttaxvalue=printtaxsummary.get(3);
					lblwithouttaxamount=printtaxsummary.get(4);
					lblwithouttaxtotal=printtaxsummary.get(5);
					lbltaxgroupvalue=printtaxsummary.get(6);
					lbltaxgrouptotal=printtaxsummary.get(8);
					lblnettaxvalue=printtaxsummary.get(9);
					lblnettaxamount=printtaxsummary.get(10);
					lblnettaxtotal=printtaxsummary.get(11);

				}
				ArrayList<String> vattotalarray=getTotalVat(conn,resultSet.getString("doc_no"));
				if(vattotalarray.size()>0){
					lbltotalvatexcl=vattotalarray.get(0);
					lbltotalvat=vattotalarray.get(1);
					lbltotalvatincl=vattotalarray.get(2);
				}
				ArrayList<String> printdetin=new ArrayList<String>();
				printdetin=getPrintdetails(resultSet.getString("doc_no"));
				printdet.add(printdetin);

				ArrayList<String> printdamage=new ArrayList<String>();
				printdamage=getPrintDamage(resultSet.getString("doc_no"));
				printdamagemaster.add(printdamage);

				//Show traffic Fees
				int showfees=0;				   
				showfees=showTrafficFees(resultSet.getString("doc_no"));


				ArrayList<String> printfleet=new ArrayList<>();
				printfleet=getFleetdetails(resultSet.getString("rano"),resultSet.getDate("sqlfromdate"),resultSet.getDate("sqltodate"),resultSet.getString("ratype"));
				printfleetmaster.add(printfleet);
				String currentfleet=getCurrentFleet(resultSet.getString("rano"),resultSet.getString("ratype"),resultSet.getDate("sqlfromdate"),resultSet.getDate("sqltodate"));
				//					System.out.println("Current:"+currentfleet);
				ArrayList<String> salikdet=new ArrayList<>();
				salikdet=getSalikDetails(resultSet.getString("doc_no"));
				printsalikmaster.add(salikdet);

				ArrayList<String> trafficdetdubai=new ArrayList<>();
				trafficdetdubai=getTrafficDetailsDubai(resultSet.getString("doc_no"));
				printtrafficdubaimaster.add(trafficdetdubai);

				ArrayList<String> trafficdetelse=new ArrayList<>();
				trafficdetelse=getTrafficDetailsElse(resultSet.getString("doc_no"));

				printtrafficelsemaster.add(trafficdetelse);
//				System.out.println("Salik Size: "+salikdet.size());
				//For Easy Lease
				ArrayList<String> agmtdetailarrayeasy=new ArrayList<>();
				//System.out.println("Agmt Invoice Doc No: "+resultSet.getString("doc_no"));
				agmtdetailarrayeasy=getAgmtDetailEasy(resultSet.getString("doc_no"),conn);
				printagmtdetailmaster.add(agmtdetailarrayeasy);
				
				ledgernote=resultSet.getString("ledgernote");
				if(trafficdetdubai.size()>0 || trafficdetelse.size()>0){
					ledgernote+=" with Reg No ";
				}
				for(int k=0;k<trafficdetdubai.size();k++){
					if(k==0){
						if(!ledgernote.contains(trafficdetdubai.get(k).split("::")[1])){
							ledgernote+=trafficdetdubai.get(k).split("::")[1];
						}
						
					}
					else{
						if(!ledgernote.contains(trafficdetdubai.get(k).split("::")[1])){
							ledgernote+=trafficdetdubai.get(k).split("::")[1];
						}
					}
				}
				for(int k=0;k<trafficdetelse.size();k++){
					if(k==0){
						if(!ledgernote.contains(trafficdetelse.get(k).split("::")[1])){
							ledgernote+=trafficdetelse.get(k).split("::")[1];
						}
						
					}
					else{
						if(!ledgernote.contains(trafficdetelse.get(k).split("::")[1])){
							ledgernote+=trafficdetelse.get(k).split("::")[1];
						}
					}
				}
					System.out.println("out date:"+resultSet.getString("agmtdate"));
					String pattern="##,###.00";
					DecimalFormat decimalFormat=new DecimalFormat(pattern);
				employees.add(new ClsProformaInvoiceAction(resultSet.getString("voc_no"),resultSet.getString("refname"),resultSet.getString("codeno"),resultSet.getString("date"),
						resultSet.getString("cladd"),resultSet.getString("rano1"),resultSet.getString("cladd1"),resultSet.getString("pono"),resultSet.getString("mrano"),
						resultSet.getString("per_mob"),resultSet.getString("ratype1"),resultSet.getString("com_mob"),resultSet.getString("agmtdate"),resultSet.getString("driven"),
						resultSet.getString("fromdate"),resultSet.getString("todate"),fleet,resultSet.getString("company"),resultSet.getString("address"),
						resultSet.getString("tel"),resultSet.getString("fax"),"Tax Invoice",resultSet.getString("branchname"),resultSet.getString("branchaddress"),
						resultSet.getString("branchtel"),resultSet.getString("branchfax"),totalstringarray.get(i).toString(),totalstringarray.get(i).toString(),
						" "+objamt.convertAmountToWords(totalstringarray.get(i))+" .",resultSet.getString("user_name") ,resultSet.getString("finaldate"),salikdet.size(),
						resultSet.getString("branch"),resultSet.getString("dateyear"),trafficdetdubai.size(),trafficdetelse.size(),
						resultSet.getString("pbno"),resultSet.getString("stcno"),resultSet.getString("cstno"),resultSet.getString("loc_name"),resultSet.getString("salesman"),
						resultSet.getString("invfromtime"),resultSet.getString("invtotime"),resultSet.getString("code"),currentfleet,resultSet.getString("dtype"),
						printfleet.size(),hidheader,printdamage.size(),resultSet.getString("inspno"),resultSet.getString("inspregno"),showfees,agmtdetailarrayeasy.size(),
						resultSet.getString("email"),resultSet.getString("website"),resultSet.getString("creditdiff"),resultSet.getString("duedate"),
						resultSet.getString("per_tel"),ledgernote,bean.getLblcustomervehicle(),bean.getLblcourtesyvehicle(),lblwithtaxvalue,
						lblwithouttaxvalue,lblwithtaxamount,lblwithouttaxamount,lblwithtaxtotal,lblwithouttaxtotal,lbltaxgroupvalue,
						lbltaxgrouptotal,lblnettaxvalue+"",lblnettaxamount+"",
						lblnettaxtotal+"",resultSet.getString("comptrn"),resultSet.getString("clienttrn"),
						resultSet.getString("enddate"),lbltotalvatexcl+"",lbltotalvat+"",
						lbltotalvatincl+""));

				bean.setLblcompname(resultSet.getString("company"));
				bean.setLblcompaddress(resultSet.getString("address"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblbranch(resultSet.getString("branchname"));
				bean.setLblbranchaddress(resultSet.getString("branchaddress"));
				bean.setLblbranchtel(resultSet.getString("branchtel"));
				bean.setLblbranchfax(resultSet.getString("branchfax"));
				bean.setLblprintname("Tax Invoice");
				bean.setLblclient(resultSet.getString("refname"));
				bean.setLblphone(resultSet.getString("com_mob"));
				
				//easylease
			    bean.setLbltelphone(resultSet.getString("per_tel"));
			    // end easylease
				bean.setLblmobile(resultSet.getString("per_mob"));
				bean.setLblfax(resultSet.getString("fax1"));
				bean.setLbldriven(resultSet.getString("driven"));
				bean.setLblinvno(resultSet.getString("doc_no"));
				bean.setLblbranchcode(resultSet.getString("branch"));
				bean.setLbldateyear(resultSet.getString("dateyear"));
				bean.setLbldate(resultSet.getString("date").toString());
				bean.setLblrano(resultSet.getString("rano"));
				bean.setLblinvfrom(resultSet.getString("fromdate").toString());
				bean.setLblinvto(resultSet.getString("todate"));
				bean.setLblcurrentvehicle(currentfleet);
				bean.setLblshowfees(showfees);
				String ac="";
				ac=resultSet.getString("acno");
				//ac=ac+" "+resultSet.getString("description");
				bean.setLblaccount(ac);
				if(resultSet.getString("ratype")!=null){
					if(resultSet.getString("ratype").equalsIgnoreCase("RAG")){
						bean.setLblmrano(resultSet.getString("mrano"));
					}
				}
				if(resultSet.getString("agmtdate")!=null){
					bean.setLblcontractstart(resultSet.getString("agmtdate").toString());
					 bean.setLblcontractend(resultSet.getString("enddate"));
				}
				

				bean.setLblcontractvehicle(fleet);
				bean.setLblratype(resultSet.getString("ratype1"));
				bean.setLbltotal(totalarray.get(i).toString());
				bean.setLblnetamount(totalarray.get(i).toString());
				bean.setLbldriven(resultSet.getString("driven"));
				bean.setLbladdress1(resultSet.getString("address"));
				bean.setLbladdress2(resultSet.getString("cladd1"));
				bean.setLblfinaldate(resultSet.getString("finaldate").toString());
				bean.setLbllocation(resultSet.getString("loc_name"));
				bean.setLblinvfromtime(resultSet.getString("invfromtime"));
				bean.setLblinvtotime(resultSet.getString("invtotime"));
				if(resultSet.getString("ratype").equalsIgnoreCase("RAG")){
					bean.setLbllpono(resultSet.getString("pono"));
				}
				bean.setLblamountwords(resultSet.getString("code")+" "+obj.convertNumberToWords(totalarray.get(i))+" only");

				i++;		
			}
			request.setAttribute("EASYAGMTPRINT", printagmtdetailmaster);
			request.setAttribute("FLEETPRINT", printfleetmaster);
			request.setAttribute("INVPRINT", printdet); 
			request.setAttribute("SALIKPRINT", printsalikmaster);
			request.setAttribute("TRAFFICPRINTDUBAI", printtrafficdubaimaster);
			request.setAttribute("TRAFFICPRINTELSE", printtrafficelsemaster);
			request.setAttribute("DAMAGEPRINT", printdamagemaster);
			request.setAttribute("TRIAL", employees);
//			System.out.println("Check Agmt Details Details: "+printagmtdetailmaster);
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
	}

	public ArrayList<String> getTotalVat(Connection conn, String docno) {
		// TODO Auto-generated method stub
		ArrayList<String> vatarray=new ArrayList<>();
		try{
			Statement stmt=conn.createStatement();
			String stralfahimtotal="select (select format(coalesce(round(sum(total),2),0.00),2)  from gl_proinvd invd where rdocno="+docno+" and chid<>20) totalvatexcl,"+
					" (select format(coalesce(round(sum(total),2),0.00),2)  from gl_proinvd invd where rdocno="+docno+" and chid=20) totalvat,"+
					" (select format(coalesce(round(sum(total),2),0.00),2)  from gl_proinvd invd where rdocno="+docno+") totalvatincl";
			ResultSet rs=stmt.executeQuery(stralfahimtotal);
			while(rs.next()){
				vatarray.add(rs.getString("totalvatexcl"));
				vatarray.add(rs.getString("totalvat"));
				vatarray.add(rs.getString("totalvatincl"));
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return vatarray;
	}



	public ArrayList<String> getPrintTaxSummary(Connection conn, String docno) {
		// TODO Auto-generated method stub
		ArrayList<String> taxarray=new ArrayList<>();
		try{
			Statement stmt=conn.createStatement();
			//Tax Print Modification on 29-12-2017
			String strtaxconfig="select (select method from gl_config where field_nme='invPrintTax') printtaxconfig,(select cldocno from gl_proinvm where doc_no="+docno+" and status=3) cldocno,(select date from gl_proinvm where doc_no="+docno+" and status=3) date";
			ResultSet rstaxconfig=stmt.executeQuery(strtaxconfig);
			int taxconfig=0;
			int cldocno=0;
			java.sql.Date sqldate=null;
			while(rstaxconfig.next()){
				taxconfig=rstaxconfig.getInt("printtaxconfig");
				cldocno=rstaxconfig.getInt("cldocno");
				sqldate=rstaxconfig.getDate("date");
			}
			if(taxconfig==1){
				String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+cldocno+" and dtype='CRM') clienttaxmethod";
//				System.out.println(strchecktax);
				ResultSet rschecktax=stmt.executeQuery(strchecktax);
				int taxstatus=0;
				int clienttaxmethod=0;
				while(rschecktax.next()){
					taxstatus=rschecktax.getInt("taxmethod");
					clienttaxmethod=rschecktax.getInt("clienttaxmethod");
				}
				String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on "+
				" tax.acidno=inv.idno where tax.status<>7 and '"+sqldate+"' between tax.fromdate and tax.todate";
				double vatpercent=0.0;
				ResultSet rsgettax=stmt.executeQuery(strgettax);
				double vatval=0.0,setval=0.0;
				while(rsgettax.next()){
					vatpercent=rsgettax.getDouble("vat_per");
					vatval=vatpercent/100;
				}
				String strprinttax="select sum(vatgroupamount) vatgroupamount,sum(withtaxvalue) withtaxvalue,sum(withouttaxvalue) withouttaxvalue,"+
				" (withtaxamount) withtaxamount from ( select round(sum(if("+clienttaxmethod+"=0,invd.total,0)),2) vatgroupamount,round(sum(if("+taxstatus+"=1 and "+clienttaxmethod+"=1 and "+vatval+">0.0 and mo.tax=1,invd.total,0)),2) withtaxvalue,"+
				" round(sum(if(("+taxstatus+"=1 and "+clienttaxmethod+"=1 and mo.tax=0) or "+vatpercent+"<=0.0,invd.total,0)),2) "+
				" withouttaxvalue,round(coalesce(taxdet.total,0),2) withtaxamount from gl_proinvd "+
				" invd left join gl_invmode mo on invd.chid=mo.idno  left join (select sum(total) total,rdocno from gl_proinvd where chid=20 group by rdocno,chid) "+
				" taxdet on (taxdet.rdocno=invd.rdocno) where invd.rdocno="+docno+" and idno not in (20,19) group by idno) aa";
//				System.out.println("taxquery....."+strprinttax);
				
				ResultSet rs=stmt.executeQuery(strprinttax);
				
				while(rs.next()){
					
					//System.out.println(decimalFormat.format(rs.getDouble("withtaxvalue")));
					taxarray.add(customFormat(conn, rs.getString("withtaxvalue")));
					
					taxarray.add(customFormat(conn, rs.getString("withtaxamount")));
					double taxtotal=rs.getDouble("withtaxvalue")+rs.getDouble("withtaxamount");
					taxarray.add(customFormat(conn, customRound(conn,taxtotal)));
					taxarray.add(customFormat(conn, rs.getString("withouttaxvalue")));
					taxarray.add(customFormat(conn,"0.00"));
					taxarray.add(customFormat(conn, rs.getString("withouttaxvalue")));
					taxarray.add(customFormat(conn, rs.getString("vatgroupamount")));
					taxarray.add(customFormat(conn, "0.00"));
					taxarray.add(customFormat(conn, rs.getString("vatgroupamount")));
					double mastervalue=rs.getDouble("withtaxvalue")+rs.getDouble("withouttaxvalue")+rs.getDouble("vatgroupamount");
					double mastertax=rs.getDouble("withtaxamount");
					double mastertotal=taxtotal+rs.getDouble("withouttaxvalue")+rs.getDouble("vatgroupamount");
					taxarray.add(customFormat(conn, customRound(conn, mastervalue)));
					taxarray.add(customFormat(conn, customRound(conn, mastertax)));
					taxarray.add(customFormat(conn, customRound(conn, mastertotal)));
					
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return taxarray;
	}
	
	public String customFormat(Connection conn, String amount) {
		// TODO Auto-generated method stub
		String value="";
		try{
			Statement stmt=conn.createStatement();
			String str="select format("+amount+",2) amount";
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				value=rs.getString("amount");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return value;
	}
	public String customRound(Connection conn, double amount) {
		// TODO Auto-generated method stub
		String value="";
		try{
			Statement stmt=conn.createStatement();
			String str="select round("+amount+",2) amount";
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				value=rs.getString("amount");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return value;
	}



	public ArrayList<String> getAgmtDetailEasy(String docno, Connection conn) {
		// TODO Auto-generated method stub
		ArrayList<String> agmtarray=new ArrayList<>();
		try{
			Statement stmt=conn.createStatement();
			int i=1;
/*			String strsql="select coalesce(veh.reg_no,'') reg_no,if(current.reg_no is null,veh.reg_no,current.reg_no)  currentregno,coalesce(agmt.po,'') po,agmt.voc_no,date_format(inv.fromdate,'%d-%m-%Y') fromdate,date_format(inv.todate,'%d-%m-%Y') todate,round(inv.rentalamt,2)"+
			" rentalamt,round(inv.accamt,2) accamt,round(inv.insuramt,2) insuramt,round(inv.amount,2) amount from gl_inveasylease inv left join"+
			" gl_lagmt agmt on inv.agmtno=agmt.doc_no left join gl_vehmaster veh on (agmt.perfleet=veh.fleet_no) left join gl_vehmaster current on (agmt.tmpfleet=current.fleet_no) where inv.invdocno="+docno+" and inv.status=3";*/
			String strtaxconfig="select (select method from gl_config where field_nme='tax') taxconfig,(select ac.tax from gl_proinvm inv inner join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') where inv.doc_no="+docno+") clienttax,(select date from gl_proinvm where doc_no="+docno+") docdate";
			ResultSet rstaxconfig=stmt.executeQuery(strtaxconfig);
			int taxconfig=0;
			int clienttax=0;
			java.sql.Date sqldocdate=null;
			while(rstaxconfig.next()){
				taxconfig=rstaxconfig.getInt("taxconfig");
				clienttax=rstaxconfig.getInt("clienttax");
				sqldocdate=rstaxconfig.getDate("docdate");
			}
			double vatpercent=0.0,vatvalue=0.0;
			if(taxconfig==1 && clienttax==1){
				String strvat="select vat_per from gl_taxdetail where status=3 and '"+sqldocdate+"' between fromdate and todate";
				ResultSet rsvat=stmt.executeQuery(strvat);
				while(rsvat.next()){
					vatpercent=rsvat.getDouble("vat_per");
					vatvalue=vatpercent/100;
				}
			}
			String strsql="select * from ("+
			" select '' outregno,'' repdate,invm.voc_no invvocno,'' repdocno,coalesce(veh.reg_no,'') reg_no,coalesce(agmt.po,'') po,datediff(inv.todate,inv.fromdate) datediff,"+
			" agmt.voc_no,date_format(date_add(inv.fromdate,interval 1 day),'%d-%m-%Y') fromdate,date_format(inv.todate,'%d-%m-%Y') todate,round(inv.rentalamt,2)"+
			" rentalamt,round(inv.accamt,2) accamt,round(inv.insuramt,2) insuramt,round(inv.amount*"+vatvalue+",2) vat,round(inv.amount,2)+round(inv.amount*"+vatvalue+",2) amount from gl_inveasylease inv left join"+
			" gl_lagmt agmt on inv.agmtno=agmt.doc_no left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet=veh.fleet_no,agmt.perfleet=veh.fleet_no)) left join gl_proinvm invm on inv.invdocno=invm.doc_no where inv.invdocno="+docno+" and inv.status=3"+
			" union all"+
			" select outveh.reg_no outregno,date_format(rep.date,'%d-%m-%Y') repdate,invm.voc_no invvocno,rep.doc_no repdocno,coalesce(veh.reg_no,'') reg_no,coalesce(agmt.po,'') po,datediff(inv.todate,inv.fromdate) datediff,"+
			" agmt.voc_no,date_format(date_add(inv.fromdate,interval 1 day),'%d-%m-%Y') fromdate,date_format(inv.todate,'%d-%m-%Y') todate,round(inv.rentalamt,2)"+
			" rentalamt,round(inv.accamt,2) accamt,round(inv.insuramt,2) insuramt,round(inv.amount*"+vatvalue+",2) vat,round(inv.amount,2)+round(inv.amount*"+vatvalue+",2) amount from gl_inveasylease inv left join"+
			" gl_lagmt agmt on inv.agmtno=agmt.doc_no left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet=veh.fleet_no,agmt.perfleet=veh.fleet_no)) left join gl_proinvm invm on inv.invdocno=invm.doc_no "+
			" left join gl_vehreplace rep on inv.agmtno=rep.rdocno left join gl_vehmaster outveh on rep.ofleetno=outveh.fleet_no where inv.invdocno="+docno+" and inv.status=3 and rep.doc_no is not null and (rep.date>=inv.fromdate and rep.date<=inv.todate)) a order by a.voc_no";
//			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				String temp="";
				if(!rs.getString("repdocno").equalsIgnoreCase("") && rs.getString("repdocno")!=null){
					temp=" "+"::"+" "+"::"+" "+"::"+"Replace Date"+"::"+rs.getString("repdate")+"::"+" "+"::"+" "+"::"+rs.getString("outregno")+"::"+" "+"::"+" "+"::"+" "+"::"+" "+"::"+" ";
				}
				else{
					temp=i+"::"+rs.getString("voc_no")+"::"+rs.getString("invvocno")+"::"+rs.getString("po")+"::"+rs.getString("fromdate")+"::"+rs.getString("todate")+"::"+rs.getString("datediff")+"::"+rs.getString("reg_no")+"::"+rs.getString("rentalamt")+"::"+rs.getString("accamt")+"::"+rs.getString("insuramt")+"::"+rs.getString("vat")+"::"+rs.getString("amount");
					i++;
					
				}
				
				agmtarray.add(temp);
				
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return agmtarray;
	}

	public   int showTrafficFees(String docno) throws SQLException {
		// TODO Auto-generated method stub
		int showfees=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select amount from gl_traffic where inv_no="+docno+" and amount>0 and inv_type='INV' and fine_source like '%DUBAI%'");
			while(rs.next()){
				showfees++;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		finally{
			conn.close();
		}
		return showfees;
	}

	public   ArrayList<String> getPrintDamage(String docno) throws SQLException {
		ArrayList<String> damagearray=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sql="select dmg.type code,dmg.name,inspd.type,inspd.remarks from gl_vinspm insp left join gl_vinspd  inspd on (insp.doc_no=inspd.rdocno) "+
					" left join gl_damage dmg on inspd.dmid=dmg.doc_no where insp.invno="+docno;
			int i=0;
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				i++;
				damagearray.add(i+"::"+rs.getString("code")+"::"+rs.getString("name")+"::"+rs.getString("type")+"::"+rs.getString("remarks"));
			}

		}
		catch(Exception e){
			e.printStackTrace();
			return null;
		}
		finally{
			conn.close();
		}
		// TODO Auto-generated method stub
		return damagearray;
	}
	public   String getCurrentFleet(String lblrano,String lblratype,java.sql.Date sqlfromdate,java.sql.Date sqltodate) throws SQLException {
		Connection conn=null;
		String currentfleet="";
		try {
			conn=objconn.getMyConnection();
			Statement stmtcurrent=conn.createStatement();
			String strmaxdoc="select coalesce(max(doc_no),0) maxdoc from gl_vmove where rdocno="+lblrano+" and rdtype='"+lblratype+"'"+
					" and dout between '"+sqlfromdate+"' and '"+sqltodate+"'";
			//System.out.println(strmaxdoc);
			int maxdoc=0;
			ResultSet rsmaxdoc=stmtcurrent.executeQuery(strmaxdoc);
			while(rsmaxdoc.next()){
				maxdoc=rsmaxdoc.getInt("maxdoc");
			}
			if(maxdoc==0){
				strmaxdoc="select coalesce(max(doc_no),0) maxdoc from gl_vmove where rdocno="+lblrano+" and rdtype='"+lblratype+"'";
				rsmaxdoc=stmtcurrent.executeQuery(strmaxdoc);
				while(rsmaxdoc.next()){
					maxdoc=rsmaxdoc.getInt("maxdoc");
				}
			}
			String strcurrentfleet="select mov.fleet_no,veh.flname,veh.reg_no,plt.code_name,auth.authname from gl_vmove mov left join gl_vehmaster veh on "+
					" mov.fleet_no=veh.fleet_no left join gl_vehplate plt on veh.pltid=plt.doc_no left join gl_vehauth auth on veh.authid=auth.doc_no where  mov.doc_no="+maxdoc;

			ResultSet rscurrent=stmtcurrent.executeQuery(strcurrentfleet);

			while(rscurrent.next()){
				currentfleet="Fleet :"+rscurrent.getString("fleet_no")+"  "+rscurrent.getString("flname")+"  "+"Reg No:"+rscurrent.getString("reg_no")+"  "+rscurrent.getString("code_name")+"  "+rscurrent.getString("authname");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return currentfleet;
	}



	public   ArrayList<String> getPrintdetails(String docno) throws SQLException {
		ArrayList<String> arr=new ArrayList<String>();
		Connection conn =null;
		try {
			conn= objconn.getMyConnection();
			Statement stmtinvoice = conn.createStatement ();
			String strSqldetail="";
			/*		
		strSqldetail="select r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,m.description from gl_invmode m left join (select r.chid,"+
				" r.units,round(r.amount,2) amount,round(coalesce(sum(total),0),2) total from gl_proinvd r where r.chid not in(8,9,14,15) and"+
				" rdocno="+docno+" group by chid"+
				" union all"+
				" select r.chid,r.units,round(sum(r.amount),2),round(coalesce(sum(total),0),2) total from gl_proinvd r where r.chid in(8,14) and rdocno="+docno+""+
				" union all"+
				" select r.chid,r.units,round(r.amount,2),round(coalesce(sum(total),0),2) total from gl_proinvd r where r.chid  in(9,15) and rdocno="+docno+""+
				" ) r on(m.idno=r.chid) where r.chid is not null";*/

			String stragreed="select method from gl_config where field_nme='printAgreedrate'";
			ResultSet rsagreed=stmtinvoice.executeQuery(stragreed);
			int agreedrate=0;
			while(rsagreed.next()){
				agreedrate=rsagreed.getInt("method");
			}
			String strprintsrvc="select method from gl_config where field_nme='printSrvc'";
			int printsrvc=0;
			ResultSet rsprintsrvc=stmtinvoice.executeQuery(strprintsrvc);
			while(rsprintsrvc.next()){
				printsrvc=rsprintsrvc.getInt("method");
			}
			String strnorate="select method from gl_config where field_nme='NoRatePrint'";
			int norate=0;
			ResultSet rsnorate=stmtinvoice.executeQuery(strnorate);
			while(rsnorate.next()){
				norate=rsnorate.getInt("method");
			}
			if(agreedrate==1){
				if(printsrvc==1){
					strSqldetail="select  r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,case when r.chid=19 then concat(m.description,' @ ',"+
							" (select  round(set_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail  where  r.date >=fromdate and"+
							" r.date <=todate and status=3 )),' %') when r.chid=20 then concat(m.description,' @ ', (select round(vat_per,1) from gl_taxdetail"+
							" where doc_no=(select max(doc_no) from gl_taxdetail where r.date >=fromdate and r.date <=todate and status=3)),' %') else"+
							" m.description end description from gl_invmode m left join (select r.chid,r.units,round(case when r.chid=1 and m.ratype='RAG' then"+
							" rtrf.rate when r.chid=1 and m.ratype='LAG' then ltrf.rate when r.chid=2 and m.ratype='RAG' then rtrf.gps+rtrf.babyseater+rtrf.cooler"+
							" when r.chid=2 and m.ratype='LAG' then ltrf.gps+ltrf.babyseater+ltrf.cooler when r.chid=3 and m.ratype='RAG' then rtrf.chaufchg"+
							" when r.chid=3 and m.ratype='LAG' then ltrf.chaufchg when r.chid=4 and m.ratype='RAG' then rtrf.exkmrte when r.chid=4 and"+
							" m.ratype='LAG' then ltrf.exkmrte when r.chid=5 and m.ratype='RAG' then rtrf.exhrchg when r.chid=7 and m.ratype='RAG' then"+
							" rtrf.oinschg  when r.chid=17 and m.ratype='RAG' then rtrf.cdw+rtrf.pai+rtrf.cdw1+rtrf.pai1 when r.chid=18 and m.ratype='LAG' then"+
							" ltrf.cdw+ltrf.pai+ltrf.cdw1+ltrf.pai1  else 0 end,2) amount, round(coalesce(sum(total),0),2) total,m.date from gl_proinvm m"+
							" left join gl_rtarif rtrf on (m.rano=rtrf.rdocno and m.ratype='RAG' and rtrf.rstatus=7) left join gl_ltarif ltrf on"+
							" (m.rano=ltrf.rdocno and m.ratype='LAG')inner join gl_proinvd r on m.doc_no=r.rdocno where r.rdocno="+docno+
							" group by chid ) r on(m.idno=r.chid) where r.chid is not null";

				}
				else{
					strSqldetail="select  r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,case when r.chid=19 then concat(m.description,' @ ', "
							+ "	(select  round(set_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail  where "
							+ " r.date >=fromdate and r.date <=todate and status=3 )),' %') when r.chid=20 then concat(m.description,' @ ', "
							+ "(select round(vat_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail where "
							+ "r.date >=fromdate and r.date <=todate and status=3)),' %') else m.description end description from gl_invmode m left join "
							+ "(select r.chid,r.units,round(case when r.chid=1 and m.ratype='RAG' then rtrf.rate when r.chid=1 and m.ratype='LAG' then ltrf.rate when r.chid=2 and"+
							" m.ratype='RAG' then rtrf.gps+rtrf.babyseater+rtrf.cooler when r.chid=2 and m.ratype='LAG' then ltrf.gps+ltrf.babyseater+ltrf.cooler"+
							" when r.chid=3 and m.ratype='RAG' then rtrf.chaufchg when r.chid=3 and m.ratype='LAG' then ltrf.chaufchg when r.chid=4 and"+
							" m.ratype='RAG' then rtrf.exkmrte when r.chid=4 and m.ratype='LAG' then ltrf.exkmrte when r.chid=5 and m.ratype='RAG' then"+
							" rtrf.exhrchg when r.chid=7 and m.ratype='RAG' then rtrf.oinschg  when"+
							" r.chid=17 and m.ratype='RAG' then rtrf.cdw+rtrf.pai+rtrf.cdw1+rtrf.pai1 when r.chid=18 and m.ratype='LAG' then"+
							" ltrf.cdw+ltrf.pai+ltrf.cdw1+ltrf.pai1  else 0 end,2) amount, round(coalesce(sum(total),0),2) total,m.date from gl_proinvm m  "+
							" left join gl_rtarif rtrf on (m.rano=rtrf.rdocno and m.ratype='RAG' and rtrf.rstatus=7)"+
							" left join gl_ltarif ltrf on (m.rano=ltrf.rdocno and m.ratype='LAG')inner join"+
							" gl_proinvd r on m.doc_no=r.rdocno where r.chid not in(8,9,14,15) and r.rdocno="+docno+" group by chid union all "+
							" select r.chid,r.units,round(sum(r.amount),2) amount ,round(coalesce(sum(total),0),2)  total,m.date from gl_proinvm m  "+
							" inner join gl_proinvd r on m.doc_no=r.rdocno  where r.chid in(8,14) and r.rdocno="+docno+" union all select r.chid,r.units, "+
							" round(sum(r.amount),2) amount, round(coalesce(sum(total),0),2) total,m.date from gl_proinvm m  inner join gl_proinvd r on m.doc_no=r.rdocno  where"+
							" r.chid in(9,15) and r.rdocno="+docno+") r on(m.idno=r.chid) where r.chid is not null";		
				}

			}
			else{
				if(printsrvc==1){
					strSqldetail="select  r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,case when r.chid=19 then concat(m.description,' @ ',"+
							" (select  round(set_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail  where  r.date >=fromdate and"+
							" r.date <=todate and status=3 )),' %') when r.chid=20 then concat(m.description,' @ ', (select round(vat_per,1) from gl_taxdetail"+
							" where doc_no=(select max(doc_no) from gl_taxdetail where r.date >=fromdate and r.date <=todate and status=3)),' %') else"+
							" m.description end description from gl_invmode m left join (select r.chid,r.units,round(sum(r.amount),2) amount,"+
							" round(coalesce(sum(total),0),2) total,m.date from gl_proinvm m inner join gl_proinvd r on m.doc_no=r.rdocno where"+
							" r.rdocno="+docno+" group by chid) r on(m.idno=r.chid) where r.chid is not null";
				}
				else{
					strSqldetail="select  r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,case when r.chid=19 then concat(m.description,' @ ', "
							+ "	(select  round(set_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail  where "
							+ " r.date >=fromdate and r.date <=todate and status=3 )),' %') when r.chid=20 then concat(m.description,' @ ', "
							+ "(select round(vat_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail where "
							+ "r.date >=fromdate and r.date <=todate and status=3)),' %') else m.description end description from gl_invmode m left join "
							+ "(select r.chid,r.units,round(sum(r.amount),2) amount, round(coalesce(sum(total),0),2) total,m.date from gl_proinvm m inner join"+
							" gl_proinvd r on m.doc_no=r.rdocno where r.chid not in(8,9,14,15) and r.rdocno="+docno+" group by chid union all "+
							" select r.chid,r.units,round(sum(r.amount),2) amount ,round(coalesce(sum(total),0),2)  total,m.date from gl_proinvm m  "+
							" inner join gl_proinvd r on m.doc_no=r.rdocno  where r.chid in(8,14) and r.rdocno="+docno+" union all select r.chid,r.units, "+
							" round(sum(r.amount),2) amount, round(coalesce(sum(total),0),2) total,m.date from gl_proinvm m  inner join gl_proinvd r on m.doc_no=r.rdocno  where"+
							" r.chid in(9,15) and r.rdocno="+docno+") r on(m.idno=r.chid) where r.chid is not null";

				}
			}
			
			String strtaxconfig="select (select method from gl_config where field_nme='invPrintTax') printtaxconfig,(select cldocno from gl_proinvm where doc_no="+docno+" and status=3) cldocno,(select date from gl_proinvm where doc_no="+docno+" and status=3) date";
			ResultSet rstaxconfig=stmtinvoice.executeQuery(strtaxconfig);
			int taxconfig=0;
			int cldocno=0;
			java.sql.Date sqldate=null;
			while(rstaxconfig.next()){
				taxconfig=rstaxconfig.getInt("printtaxconfig");
				cldocno=rstaxconfig.getInt("cldocno");
				sqldate=rstaxconfig.getDate("date");
			}
			double vatamt=0.0;
			String strvatamt="select coalesce(round(total,2),0.00) vatamt from gl_proinvd where chid=20 and rdocno="+docno;
			ResultSet rsvatamt=stmtinvoice.executeQuery(strvatamt);
			while(rsvatamt.next()){
				vatamt=rsvatamt.getDouble("vatamt");
			}
			
			if(taxconfig==1){
				String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+cldocno+" and dtype='CRM') clienttaxmethod";
//				System.out.println(strchecktax);
				ResultSet rschecktax=stmtinvoice.executeQuery(strchecktax);
				int taxstatus=0;
				int clienttaxmethod=0;
				while(rschecktax.next()){
					taxstatus=rschecktax.getInt("taxmethod");
					clienttaxmethod=rschecktax.getInt("clienttaxmethod");
				}
				
				if(taxstatus==1){
					
					String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqldate+"' between tax.fromdate and tax.todate";
//					System.out.println();
					double vatpercent=0.0;
					ResultSet rsgettax=stmtinvoice.executeQuery(strgettax);
					double vatval=0.0,setval=0.0;
					while(rsgettax.next()){
						vatpercent=rsgettax.getDouble("vat_per");
						vatval=vatpercent/100;
					}
					if(vatamt==0.00){
						vatpercent=0.00;
						vatval=0.00;
					}
					if(printsrvc==0){
						String strsql="select mo.description,format(round(invd.total,2),2) amount,format(round(if(mo.tax=1,"+vatpercent+",0),2),2) taxpercent,format(round(if(mo.tax=1,coalesce(invd.total*"+vatval+",0),0),2),2) "+
						" taxamount,format(round(invd.total,2)+round(if(mo.tax=1,coalesce(invd.total*"+vatval+",0),0),2),2) total from gl_proinvd invd left join "+
						" gl_invmode mo on invd.chid=mo.idno left join (select total,rdocno from gl_proinvd where chid=20 group by rdocno,chid) taxdet "+
						" on (taxdet.rdocno=invd.rdocno) where invd.rdocno="+docno+" and idno not in (20,19)";
//						System.out.println(strsql);
						ResultSet rs=stmtinvoice.executeQuery(strsql);
						int rowcount=1;
						String temp="";
						while(rs.next()){
							temp=rowcount+"::"+rs.getString("description")+"::"+rs.getString("amount")+"::"+rs.getString("taxpercent")+"::"+rs.getString("taxamount")+"::"+rs.getString("total");
							arr.add(temp);
							rowcount++;
						}
					}
					else{
						String strsql="select if(mo.idno=1,1,invd.units) qty,format(round(invd.amount,2),2) rate,if(mo.idno=1,concat(mo.description,' (',invd.units,')'),mo.description) description,format(round(invd.total,2),2) amount,format(round(if(mo.tax=1,"+vatpercent+",0),2),2) taxpercent,format(round(if(mo.tax=1,coalesce(invd.total*"+vatval+",0),0),2),2) "+
								" taxamount,format(round(invd.total,2)+round(if(mo.tax=1,coalesce(invd.total*"+vatval+",0),0),2),2) total from gl_proinvd invd left join gl_invmode mo on"+
								" invd.chid=mo.idno  left join (select total,rdocno from gl_proinvd where chid=20 group by rdocno,chid) taxdet "+
						" on (taxdet.rdocno=invd.rdocno) where invd.rdocno="+docno+" and idno not in (20,19)";
//								System.out.println(strsql);
								ResultSet rs=stmtinvoice.executeQuery(strsql);
								int rowcount=1;
								String temp="";
								String pattern="##,###.00";
								DecimalFormat decimalFormat=new DecimalFormat(pattern);
								while(rs.next()){
									if(agreedrate==1){
										temp=rowcount+"::"+rs.getString("description")+"::"+rs.getString("qty")+"::"+rs.getString("rate")+"::"+rs.getString("amount")+"::"+rs.getString("taxpercent")+"::"+rs.getString("taxamount")+"::"+rs.getString("total");
									}
									else{
										temp=rowcount+"::"+rs.getString("description")+"::"+rs.getString("qty")+"::"+rs.getString("rate")+"::"+rs.getString("amount")+"::"+rs.getString("taxpercent")+"::"+rs.getString("taxamount")+"::"+rs.getString("total");
									}
									arr.add(temp);
									rowcount++;
								}
					}
					
				}
				else if(taxstatus==1 && vatamt==0.00){
					double vatval=0.0;
					double vatpercent=0.0;
					if(printsrvc==0){
						String strsql="select mo.description,format(round(invd.total,2),2) amount,format(round(if(mo.tax=1,"+vatpercent+",0),2),2) taxpercent,format(round(if(mo.tax=1,coalesce(taxdet.total,0),0),2),2) "+
								" taxamount,format(round(invd.total,2)+round(if(mo.tax=1,coalesce(taxdet.total,0),0),2),2) total from gl_proinvd invd left join gl_invmode mo on"+
								" invd.chid=mo.idno  left join (select total,rdocno from gl_proinvd where chid=20 group by rdocno,chid) taxdet "+
						" on (taxdet.rdocno=invd.rdocno) where invd.rdocno="+docno+" and idno not in (20,19)";
//								System.out.println(strsql);
								ResultSet rs=stmtinvoice.executeQuery(strsql);
								int rowcount=1;
								String temp="";
								while(rs.next()){
									temp=rowcount+"::"+rs.getString("description")+"::"+rs.getString("amount")+"::"+rs.getString("taxpercent")+"::"+rs.getString("taxamount")+"::"+rs.getString("total");
									arr.add(temp);
									rowcount++;
								}
					}
					else{
						String strsql="select if(mo.idno=1,1,invd.units) qty,format(round(invd.amount,2),2) rate,if(mo.idno=1,concat(mo.description,' (',invd.units,')'),mo.description) description,format(round(invd.total,2),2) amount,format(round(if(mo.tax=1,"+vatpercent+",0),2),2) taxpercent,format(round(if(mo.tax=1,coalesce(taxdet.total,0),0),2),2) "+
								" taxamount,format(round(invd.total,2)+round(if(mo.tax=1,coalesce(taxdet.total,0),0),2),2) total from gl_proinvd invd left join gl_invmode mo on"+
								" invd.chid=mo.idno  left join (select total,rdocno from gl_proinvd where chid=20 group by rdocno,chid) taxdet "+
						" on (taxdet.rdocno=invd.rdocno) where invd.rdocno="+docno+" and idno not in (20,19)";
//								System.out.println(strsql);
								ResultSet rs=stmtinvoice.executeQuery(strsql);
								int rowcount=1;
								String temp="";
								while(rs.next()){
									temp=rowcount+"::"+rs.getString("description")+"::"+rs.getString("qty")+"::"+rs.getString("rate")+"::"+rs.getString("amount")+"::"+rs.getString("taxpercent")+"::"+rs.getString("taxamount")+"::"+rs.getString("total");
									arr.add(temp);
									rowcount++;
								}
					}
					/*String strsql="select mo.description,round(invd.total,2) amount,round(if(mo.tax=1,"+vatpercent+",0),2) taxpercent,round(if(mo.tax=1,invd.total*"+vatval+",0),2) "+
							" taxamount,round(invd.total,2)+round(if(mo.tax=1,invd.total*"+vatval+",0),2) total from gl_proinvd invd left join gl_invmode mo on"+
							" invd.chid=mo.idno where rdocno="+docno+" and idno not in (20,19)";
//							System.out.println(strsql);
							ResultSet rs=stmtinvoice.executeQuery(strsql);
							int rowcount=1;
							String temp="";
							while(rs.next()){
								temp=rowcount+"::"+rs.getString("description")+"::"+rs.getString("amount")+"::"+rs.getString("taxpercent")+"::"+rs.getString("taxamount")+"::"+rs.getString("total");
								arr.add(temp);
								rowcount++;
							}*/
				}
					
			}
			else{
			//System.out.println("Print Details:"+strSqldetail);
			ResultSet rsdetail=stmtinvoice.executeQuery(strSqldetail);

			int rowcount=1;
			String firstsql="";
			/*if(rsdetail.last()){
			rowcount=rsdetail.getRow();
			rsdetail.beforeFirst();
		}*/
//			System.out.println("NoRate: "+norate);
			while(rsdetail.next()){
				//for(int i=0;i<rowcount;i++){
				String temp="";
				if(norate==1){
					//Overridden for EASYLEASE
					System.out.println("Inside Agreed Rate");
					temp=rowcount+"::"+rsdetail.getString("description")+"::"+rsdetail.getString("units")+"::"+rsdetail.getString("total");
//					System.out.println("inside 1");
				}
				else if(agreedrate==1){
					temp=rowcount+"::"+rsdetail.getString("description")+"::"+rsdetail.getString("amount")+"::"+rsdetail.getString("units")+"::"+rsdetail.getString("total");	
					System.out.println("inside 2");
				}
				else{
					temp=rowcount+"::"+rsdetail.getString("description")+"::"+rsdetail.getString("units")+"::"+rsdetail.getString("amount")+"::"+rsdetail.getString("total");
					System.out.println("inside 3");
				}

//				System.out.println(temp);
				String secndsql="select '"+rowcount+"' as srno,'"+rsdetail.getString("description")+"' as descp,"
						+ "'"+rsdetail.getString("units")+"' as unit,'"+rsdetail.getString("amount")+"' as amount,'"+rsdetail.getString("total")+"' as total" ;
				if(rowcount==1){
				 firstsql="select '"+rowcount+"' as srno,'"+rsdetail.getString("description")+"' as descp,"
						+ "'"+rsdetail.getString("units")+"' as unit,'"+rsdetail.getString("amount")+"' as amount,'"+rsdetail.getString("total")+"' as total" ;
				}
				else{
				firstsql=firstsql +" union all  "+secndsql;
				}	
				
				arr.add(temp);
				rowcount++;
				/*System.out.println(arr.Get[i]);*/
				//}

			}
			//System.out.println("========== "+arr);
			bean.setPrintdetailsql(firstsql);
		}
			stmtinvoice.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		// TODO Auto-generated method stub
		return arr;
	}
	public   ArrayList<String> getFleetdetails(String lblrano,java.sql.Date fromdate,java.sql.Date todate,String lblratype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> fleetarray=new ArrayList<>();
		int rowcount=1;
				String otherfleetsql="";
		try {
			String strfleetdetails="select distinct mov.fleet_no,veh.flname,veh.reg_no,DATE_FORMAT(mov.dout,'%d/%m/%Y') dout,COALESCE(DATE_FORMAT(mov.din,'%d/%m/%Y '),'') "+
					" din from gl_vmove mov left join gl_vehmaster veh on (mov.fleet_no=veh.fleet_no ) where mov.rdocno="+lblrano+" and mov.rdtype='"+lblratype+"' and mov.repno<> 0 and mov.trancode<>'DL'"+
					" and ((dout >='"+fromdate+"' and dout <='"+todate+"') or (din >='"+fromdate+"' and din <='"+todate+"'))";
			conn=objconn.getMyConnection();

			Statement stmtfleetdetails = conn.createStatement();
							System.out.println("Fleet Query:"+strfleetdetails);
			ResultSet rsfleetdetails=stmtfleetdetails.executeQuery(strfleetdetails);
			while(rsfleetdetails.next()){
				String temp=rsfleetdetails.getString("fleet_no")+"  "+rsfleetdetails.getString("flname")+"  "+"Reg No:"+rsfleetdetails.getString("reg_no")+"  "+"From Date:"+rsfleetdetails.getString("dout")+"  "+"To Date:"+rsfleetdetails.getString("din");
				fleetarray.add(temp);
				String secndsql="select 'Other Fleets' as name,'"+temp+"' as otherfleets" ;
				if(rowcount==1){
					otherfleetsql="select 'Other Fleets' as name,'"+temp+"' as otherfleets" ;
				}
				else{
					otherfleetsql=otherfleetsql +" union all  "+secndsql;
				}
rowcount++;

			}
			bean.setOtherfleetsql(otherfleetsql);
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return fleetarray;
	}



	public   ArrayList<String> getSalikDetails(String docno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> salikarray=new ArrayList<>();
String saliksql="";
		try{
			conn=objconn.getMyConnection();

			Statement stmt=conn.createStatement();
			java.sql.Date fromdate=null,todate=null;
			/*	Statement stmtdate=conn.createStatement();
			ResultSet rsdate=stmtdate.executeQuery("select fromdate,todate from gl_proinvm where doc_no="+docno+"");
			while(rsdate.next()){
				fromdate=rsdate.getDate("fromdate");
				todate=rsdate.getDate("todate");
			}*/
			
			
			
			String strprintsalikconfig="select method from gl_config where field_nme='PrintSalikSrvc'";
			int saliksrvcconfig=0;
			ResultSet rssrvcconfig=stmt.executeQuery(strprintsalikconfig);
			int i=1;
			while(rssrvcconfig.next()){
				saliksrvcconfig=rssrvcconfig.getInt("method");
			}
			
			String strsalik="select trans,DATE_FORMAT(salik_date,'%b-%e-%Y %h:%i:%s %p') salik_date,DATE_FORMAT(sal_date,'%b-%e-%Y') sal_date,"+
					" concat('Tag #:',coalesce(tagno,''),' ',coalesce(source,''),'-',coalesce(cust_plate,''),' ',coalesce(regno,'')) plateinfo,location,"+
					" direction,format(round(if("+saliksrvcconfig+"=1,amount+1,amount),2),2) amount from gl_salik where inv_no="+docno+" and amount>0 and inv_type='INV' order by regno,date";
			/*and sal_date between '"+fromdate+"' and '"+todate+"'*/
			ResultSet rssalik=stmt.executeQuery(strsalik);
			
			while(rssalik.next()){
				String temp=i+"::"+rssalik.getString("trans")+"::"+rssalik.getString("salik_date")+"::"+rssalik.getString("sal_date")+"::"+rssalik.getString("plateinfo")+"::"+rssalik.getString("location")+"::"+rssalik.getString("direction")+"::"+rssalik.getString("amount");
				//System.out.println(temp);
				salikarray.add(temp);
		String secndsql="select '"+i+"' as srno,'"+rssalik.getString("trans")+"' as trans,"
						+ "'"+rssalik.getString("salik_date")+"' as tripdate,'"+rssalik.getString("sal_date")+"' as postdate,"
						+ "'"+rssalik.getString("plateinfo")+"' as plateinfo,'"+rssalik.getString("location")+"' as location,"
						+ "'"+rssalik.getString("direction")+"' as direction,'"+rssalik.getString("amount")+"' as amount" ;
				if(i==1){
					saliksql="select '"+i+"' as srno,'"+rssalik.getString("trans")+"' as trans,"
							+ "'"+rssalik.getString("salik_date")+"' as tripdate,'"+rssalik.getString("sal_date")+"' as postdate,"
							+ "'"+rssalik.getString("plateinfo")+"' as plateinfo,'"+rssalik.getString("location")+"' as location,"
							+ "'"+rssalik.getString("direction")+"' as direction,'"+rssalik.getString("amount")+"' as amount" ;
				}
				else{
					saliksql=saliksql +" union all  "+secndsql;
				}
				
			
				i++;
			}
bean.setSaliksql(saliksql);
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
		return salikarray;
	}

	public   ArrayList<String> getTrafficDetailsDubai(String docno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> trafficarray=new ArrayList<>();
String trafficdubaisql="";
		try{
			conn=objconn.getMyConnection();

			Statement stmt=conn.createStatement();
			/*String strsalik="select trans,DATE_FORMAT(salik_date,'%M-%e-%Y %h:%i:%s %p') salik_date,DATE_FORMAT(sal_date,'%M-%e-%Y') sal_date,"+
					" concat('Tag #:',tagno,' ',source,'-',coalesce(cust_plate,''),' ',regno) plateinfo,location,"+
					" direction,amount from gl_salik where inv_no="+docno+" and amount>0 ";*/
			String strtraffic="select regno,ticket_no,DATE_FORMAT(traffic_date,'%b-%e-%Y')traffic_date,time,format(round(amount,2),2) amount,concat(if(desc1 is null,' ',desc1),' , Location -',coalesce(location,'')) desc1,coalesce(fine_source,'') fine_source from gl_traffic where inv_no="+docno+" and amount>0 and inv_type='INV' and tcno like '50%'";
			/*and sal_date between '"+fromdate+"' and '"+todate+"'*/
			ResultSet rstraffic=stmt.executeQuery(strtraffic);
			int i=1;
			while(rstraffic.next()){
				String temp=i+"::"+rstraffic.getString("regno")+"::"+rstraffic.getString("ticket_no")+"::"+rstraffic.getString("traffic_date")+"::"+rstraffic.getString("time")+"::"+rstraffic.getString("amount")+"::"+rstraffic.getString("fine_source")+"::"+rstraffic.getString("desc1");
				//System.out.println(temp);
				// If Tc No is 1 then Dubai Else Abu Dhabi 

				trafficarray.add(temp);
String secndsql="select '"+i+"' as srno,'"+rstraffic.getString("regno")+"' as regno,"
						+ "'"+rstraffic.getString("ticket_no")+"' as ticketno,'"+rstraffic.getString("traffic_date")+"' as trafficdate,"
						+ "'"+rstraffic.getString("time")+"' as time,'"+rstraffic.getString("amount")+"' as amount,"
						+ "'"+rstraffic.getString("fine_source")+"' as finesource,'"+rstraffic.getString("desc1")+"' as descp" ;
				if(i==1){
					trafficdubaisql="select '"+i+"' as srno,'"+rstraffic.getString("regno")+"' as regno,"
					+ "'"+rstraffic.getString("ticket_no")+"' as ticketno,'"+rstraffic.getString("traffic_date")+"' as trafficdate,"
					+ "'"+rstraffic.getString("time")+"' as time,'"+rstraffic.getString("amount")+"' as amount,"
					+ "'"+rstraffic.getString("fine_source")+"' as finesource,'"+rstraffic.getString("desc1")+"' as descp" ;
				}
				else{
					trafficdubaisql=trafficdubaisql +" union all  "+secndsql;
				}
				i++;
			}
bean.setTrafficdubaisql(trafficdubaisql);
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
		return trafficarray;
	}


	public   ArrayList<String> getTrafficDetailsElse(String docno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> trafficarray=new ArrayList<>();
String trafficabudabisql="";
		try{
			conn=objconn.getMyConnection();

			Statement stmt=conn.createStatement();
			java.sql.Date fromdate=null,todate=null;

			/*String strsalik="select trans,DATE_FORMAT(salik_date,'%M-%e-%Y %h:%i:%s %p') salik_date,DATE_FORMAT(sal_date,'%M-%e-%Y') sal_date,"+
					" concat('Tag #:',tagno,' ',source,'-',coalesce(cust_plate,''),' ',regno) plateinfo,location,"+
					" direction,amount from gl_salik where inv_no="+docno+" and amount>0 ";*/
			String strtraffic="select regno,ticket_no,DATE_FORMAT(traffic_date,'%b-%e-%Y')traffic_date,time,format(round(amount,2),2) amount,concat(if(desc1 is null,' ',desc1),' , Location -',coalesce(location,'')) desc1,coalesce(fine_source,'') fine_source from gl_traffic where inv_no="+docno+" and amount>0 and inv_type='INV' and tcno not like '50%'";
			/*and sal_date between '"+fromdate+"' and '"+todate+"'*/
			int i=1;
			ResultSet rstraffic=stmt.executeQuery(strtraffic);
			while(rstraffic.next()){
				String temp=i+"::"+rstraffic.getString("regno")+"::"+rstraffic.getString("ticket_no")+"::"+rstraffic.getString("traffic_date")+"::"+rstraffic.getString("time")+"::"+rstraffic.getString("amount")+"::"+rstraffic.getString("fine_source")+"::"+rstraffic.getString("desc1");
				//System.out.println(temp);
				// If Tc No is 1 then Dubai Else Abu Dhabi 

				trafficarray.add(temp);
String secndsql="select '"+i+"' as srno,'"+rstraffic.getString("regno")+"' as regno,"
						+ "'"+rstraffic.getString("ticket_no")+"' as ticketno,'"+rstraffic.getString("traffic_date")+"' as trafficdate,"
						+ "'"+rstraffic.getString("time")+"' as time,'"+rstraffic.getString("amount")+"' as amount,"
						+ "'"+rstraffic.getString("fine_source")+"' as finesource,'"+rstraffic.getString("desc1")+"' as descp" ;
				if(i==1){
					trafficabudabisql="select '"+i+"' as srno,'"+rstraffic.getString("regno")+"' as regno,"
					+ "'"+rstraffic.getString("ticket_no")+"' as ticketno,'"+rstraffic.getString("traffic_date")+"' as trafficdate,"
					+ "'"+rstraffic.getString("time")+"' as time,'"+rstraffic.getString("amount")+"' as amount,"
					+ "'"+rstraffic.getString("fine_source")+"' as finesource,'"+rstraffic.getString("desc1")+"' as descp" ;
				}
				else{
					trafficabudabisql=trafficabudabisql +" union all  "+secndsql;
				}
				i++;
			}
bean.setTrafficabudhabusql(trafficabudabisql);
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
		return trafficarray;
	}



	public double getChaufferCharge(int agmtno,java.sql.Date invdate,java.sql.Date invtodate,String agmttype) throws SQLException{
		Connection conn=null;
		int monthcalmethod=0,monthcalvalue=0,rentalno=0;
		double chaufchg=0.0;
		try{
			conn=objconn.getMyConnection();
			Statement stmtconfig=conn.createStatement();
			String strconfig="";
			if(agmttype.equalsIgnoreCase("RAG")){
				strconfig="select method,value from gl_config where field_nme='monthlycal'";
			}
			else if(agmttype.equalsIgnoreCase("LAG")){
				strconfig="select method,value from gl_config where field_nme='lesmonthlycal'";
			}
			else{

			}
			ResultSet rsconfig=stmtconfig.executeQuery(strconfig);
			while(rsconfig.next()){
				monthcalmethod=rsconfig.getInt("method");
				monthcalvalue=rsconfig.getInt("value");
			}
			String strsql="";

			double day=0.0,month=0.0,days=0.0;
			int lastday=0;
			int oneDayExtraConfig=getOneDayExtraConfig(conn);
			int invtype=0;
			int invcount=0;
			
			String strgetinvtype="";
			if(agmttype.equalsIgnoreCase("RAG")){
				strgetinvtype="select (select invtype from gl_ragmt where doc_no="+agmtno+") invtype,(select count(*) from gl_proinvm where rano="+agmtno+" and ratype='RAG') invcount";
				
			}
			else{
				strgetinvtype="select (select inv_type from gl_lagmt where doc_no="+agmtno+") invtype,(select count(*) from gl_proinvm where rano="+agmtno+" and ratype='LAG') invcount";
			}
//			System.out.println();
			
			ResultSet rsgetinvtype=stmtconfig.executeQuery(strgetinvtype);
			while(rsgetinvtype.next()){
				invtype=rsgetinvtype.getInt("invtype");
				invcount=rsgetinvtype.getInt("invcount");
			}
			if(oneDayExtraConfig==1 && invcount==0){
				String straddonedate="select date_sub('"+invdate+"',interval 1 day) invdate";
				ResultSet rsaddonedate=stmtconfig.executeQuery(straddonedate);
				while(rsaddonedate.next()){
					invdate=rsaddonedate.getDate("invdate");
				}
			}
			if(monthcalmethod==1){
				Statement stmtmonthdays=conn.createStatement();
				String strmonthdays="SELECT (select DAY(LAST_DAY('"+invdate+"'))) monthdays,(select method from gl_config where field_nme='closecal') closecal";
				ResultSet rsmonthdays=stmtmonthdays.executeQuery(strmonthdays);
				int closecal=0;
				while(rsmonthdays.next()){
					monthcalvalue=rsmonthdays.getInt("monthdays");
					closecal=rsmonthdays.getInt("closecal");
				}
				Statement stmtMonth=conn.createStatement();
				
				String strgetmonth="";
				if(closecal==0){
					strgetmonth="select a.months,DAY(LAST_DAY('"+invtodate+"')) lastday, DATEDIFF( '"+invtodate+"', DATE_ADD('"+invdate+"',INTERVAL a.months month) ) days from ("+
							" select if(day('"+invdate+"')>day('"+invtodate+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+invtodate+"' ),"+
							" EXTRACT( YEAR_MONTH FROM '"+invdate+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+invtodate+"' ),"+
							" EXTRACT( YEAR_MONTH FROM '"+invdate+"' ) )) months) a";	
				}
				else if(closecal==1){
					strgetmonth="select DAY(LAST_DAY('"+invtodate+"')) lastday, DATEDIFF( '"+invtodate+"', DATE_ADD('"+invdate+"',INTERVAL 0 month) ) days,0 months";
				}


				ResultSet rsgetmonth=stmtMonth.executeQuery(strgetmonth);
				while(rsgetmonth.next()){
					day=rsgetmonth.getDouble("days");
					month=rsgetmonth.getDouble("MONTHS");
					lastday=rsgetmonth.getInt("lastday");
				}
				if(agmttype.equalsIgnoreCase("RAG")){
					strsql="select round((("+month+"*chaufchg)+(("+day/lastday+")*chaufchg)),2) chaufferchg from gl_rtarif where rstatus=7 and rdocno="+agmtno;
				}
				else if(agmttype.equalsIgnoreCase("LAG")){
					strsql="select round((("+month+"*chaufchg)+(("+day/lastday+")*chaufchg)),2) chaufferchg from gl_ltarif where rdocno="+agmtno;
				}
			}
			else if(monthcalmethod==0){
				rentalno=monthcalvalue;
				long diff=invtodate.getTime()-invdate.getTime();
				long datediff = diff / (24 * 60 * 60 * 1000);
				days=datediff;
				if(agmttype.equalsIgnoreCase("RAG")){
					strsql="select round("+(days/rentalno)+"*chaufchg,2) chaufferchg from gl_rtarif where rstatus=7 and rdocno="+agmtno;	
				}
				else if(agmttype.equalsIgnoreCase("LAG")){
					strsql="select round("+(days/rentalno)+"*chaufchg,2) chaufferchg from gl_ltarif where rdocno="+agmtno;
				}

				else{

				}
			}
			Statement stmtchauf=conn.createStatement();
			ResultSet rschaufchg=stmtchauf.executeQuery(strsql);

			while(rschaufchg.next()){
				chaufchg=rschaufchg.getDouble("chaufferchg");
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return chaufchg;
	}







	public boolean edit(Connection conn,ArrayList<String> invoicearray, String cmbagmttype,
			Date date, String hidclient, int agmtno, String ledgernote,
			String invoicenote, Date fromdate, Date todate, String branchid,
			String userid, String currencyid, String mode, String acno,
			String dtype, String formdetailcode, String qty2,int docno) throws SQLException {
		// TODO Auto-generated method stub

		try{
			ArrayList<String> editarray=new ArrayList<>();
			for(int i=0;i<invoicearray.size();i++){
				int idno=Integer.parseInt(invoicearray.get(i).split("::")[0]);
//				System.out.println("IDNO: "+idno);
				if(idno!=13 && idno!=19 && idno!=20 && idno!=21){
					editarray.add(invoicearray.get(i));
				}
			}
			invoicearray=editarray;
			Statement stmttrno=conn.createStatement();
			String strtrno="select tr_no from gl_proinvm where doc_no="+docno;
			int trno=0;
			ResultSet rstrno=stmttrno.executeQuery(strtrno);
			while(rstrno.next()){
				trno=rstrno.getInt("tr_no");
			}
			//Updating Master Data
			//brhid="+branchid+",ratype='"+cmbagmttype+"',cldocno='"+hidclient+"',rano="+agmtno+",curid="+currencyid+",acno="+acno+"
			Statement stmtmaster=conn.createStatement();
			String strmaster="update gl_proinvm set date='"+date+"',ldgrnote='"+ledgernote+"'"+
					",invnote='"+invoicenote+"',fromdate='"+fromdate+"',todate='"+todate+"',userid='"+userid+"' where doc_no="+docno;
			int masterupdate=stmtmaster.executeUpdate(strmaster);
			if(masterupdate<0){
//				System.out.println("/////////Master Update Error/////////////");
				return false;
			}
			if(masterupdate>0){
				Statement stmtlog=conn.createStatement();
				String strlog="insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+","+branchid+",'"+formdetailcode+"',now(),"+userid+",'E')";
				int logval=stmtlog.executeUpdate(strlog);
				if(logval<0){
					return false;
				}
				Statement stmtdelete=conn.createStatement();
				String strdelete="delete from gl_proinvd where rdocno="+docno;
				int deleteval=stmtdelete.executeUpdate(strdelete);
				if(deleteval<0){
					return false;

				}
				stmtdelete.close();
				if(deleteval>0){
					int tempno=0;
					Statement stmtinsert=conn.createStatement();
					for(int i=0;i< invoicearray.size();i++){
						String[] invoice=invoicearray.get(i).split("::");
						String strinsert="insert into gl_proinvd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(i+1)+"','"+branchid+"','"+docno+"'"+
						",'"+trno+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"','"+(invoice[4].equalsIgnoreCase("undefined") || invoice[4].isEmpty()?0:invoice[4])+"')";
						int insertval=stmtinsert.executeUpdate(strinsert);
						if(insertval<0){
							return false;
						}
						if(insertval>0){

						}
						tempno++;
					}
					



					//if(!origin.equalsIgnoreCase("1")){

						//Tax Portion Starts Here
					double generalamt=0.0;
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
						String strtaxapplied="select total from gl_proinvd inv left join gl_invmode ac on inv.chid=ac.idno where ac.tax=1 and inv.rdocno="+docno;
						System.out.println(strtaxapplied);
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
										generalamt+=vatval;
									}
								}
							}
						}
						System.out.println();
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
							//generalamt-=saliksrvcvat;
							//generalamt-=trafficsrvcvat;
							generalamt=objcommon.Round(generalamt, 2);

							
							//generalamt=generalamt+vatval;
							generalamt=objcommon.Round(generalamt, 2);
							//generalldr=generalamt*testcurrate;

							int tempsrno=invoicearray.size()+1;
							for(int j=0;j<temptaxarray.size();j++){
								System.out.println(temptaxarray.get(j));
								String[] tax=temptaxarray.get(j).split("::");
								Statement stmttaxinvd=conn.createStatement();
								if(Double.parseDouble(tax[2])>0){
									String strtaxinvd="insert into gl_proinvd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+tempsrno+"','"+branchid+"','"+docno+"'"+
											",'"+trno+"','"+(tax[0].equalsIgnoreCase("undefined") || tax[0].isEmpty()?0:tax[0])+"','1','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"')";	
												System.out.println("Invd Sql:"+strtaxinvd);
									int taxinvdval=stmttaxinvd.executeUpdate(strtaxinvd);
									if(taxinvdval>0){
										
									}
									else{
										System.out.println("Tax Invd Error");
										return false;
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

					int discountconfig=getDiscountConfig(conn);
					double ramt=0.0;
					double discount=0.0;
					double discountldr=0.0;
					if(discountconfig==1){
						ramt=Math.round(generalamt);
						discount= (generalamt-ramt);
						discount=objcommon.Round(discount, 2);
						//discountldr=discount*testcurrate;
					}
					else{
						ramt=generalamt;
						
					}
					//double ramtldr=ramt*testcurrate;
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
						String sql="insert into gl_proinvd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(tempno+1)+"','"+branchid+"','"+docno+"'"+
								",'"+trno+"','13','1','"+(discount*-1)+"','"+discac+"','"+(discount*-1)+"')";
						int discinvd=stmtdiscinvd.executeUpdate(sql);
						if(discinvd<=0){
							stmtdiscinvd.close();
							stmtdiscjv.close();
							stmtdiscount.close();
							conn.close();
							return false;
						}
						stmtdiscinvd.close();
									System.out.println(" Invd Sql"+sql);
						
					}
					if(ramt>0){
							
					}
					
					stmtdiscount.close();
				}						//}

					//If Tax Method is Disabled in gl_config
	
					//System.out.println("no====="+docno);


					if (docno > 0) {
						return true;
					}


				}




			}


		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}






	public boolean delete(Connection conn,int docno,Date date,Date fromdate,Date todate,String cmbagmttype,int agmtno,String branchid,String userid,String formdetailcode) throws SQLException {

		try{

			//Getting TRNO for further deleting
			Statement stmttrno=conn.createStatement();
			String strtrno="select tr_no from gl_proinvm where doc_no="+docno;
			int trno=0;
			ResultSet rstrno=stmttrno.executeQuery(strtrno);
			while(rstrno.next()){
				trno=rstrno.getInt("tr_no");
			}
			stmttrno.close();




			//Change status into delete status of Invoice Master Table
			Statement stmtinvoice;
			stmtinvoice = conn.createStatement ();
			int updateval = stmtinvoice.executeUpdate("update gl_proinvm set status=7 where doc_no='"+docno+"'");
			if (updateval<0) {
				return false;
			}
			stmtinvoice.close();
			//Clearing invoice Reference in Agreement tables
			String strclearagmtinvno="";
			String strclearcalc="";

			if(cmbagmttype.equalsIgnoreCase("RAG")){
				strclearagmtinvno="update gl_ragmt set addr_invno=0,del_invno=0 where doc_no="+agmtno;

				strclearcalc="delete from gl_rcalc where rdocno="+agmtno+" and trno="+trno;
			}
			if(cmbagmttype.equalsIgnoreCase("LAG")){
				strclearagmtinvno="update gl_lagmt set addr_invno=0,del_invno=0 where doc_no="+agmtno;

				strclearcalc="delete from gl_rcalc where rdocno="+agmtno+" and trno="+trno;


			}
			Statement stmtclearagmt=conn.createStatement();
			int clearagmt=stmtclearagmt.executeUpdate(strclearagmtinvno);
			if(clearagmt<0){
				return false;
			}
			stmtclearagmt.close();

			//Clearing Data from Rcalc/Lcalc tables
			Statement stmtclearcalc=conn.createStatement();
			int clearcalc=stmtclearcalc.executeUpdate(strclearcalc);
			if(clearcalc<0){
				return false;
			}

			stmtclearcalc.close();

			if(cmbagmttype.equalsIgnoreCase("LAG")){
				String strleaseserv="update gl_lothser set invno=0,invstatus=0 where invno="+docno;
				Statement stmtleaseserv=conn.createStatement();
				int leaseserv=stmtleaseserv.executeUpdate(strleaseserv);
				if(leaseserv<0){
					return false;
				}

				stmtleaseserv.close();
			}

			//Deleting data from my_jvtran
			ClsApplyDelete objapply=new ClsApplyDelete();
			int applydelete=objapply.getFinanceApplyDelete(conn, trno);
			if(applydelete<0){
				return false;
			}
			String strjvdelete="update my_jvtran set status=7 where tr_no="+trno;
			Statement stmtjvdelete=conn.createStatement();
			int jvdeleteval=stmtjvdelete.executeUpdate(strjvdelete);
			if(jvdeleteval<0){
				return false;
			}

			stmtjvdelete.close();

			//Clearing Invoice Reference from salik table

			String strclearsalik="update gl_salik set status=0,inv_no=0,inv_type='' where inv_no="+agmtno;
			Statement stmtclearsalik=conn.createStatement();
			int clearsalikval=stmtclearsalik.executeUpdate(strclearsalik);
			if(clearsalikval<0){
				return false;
			}
			stmtclearsalik.close();

			//Clearing Invoice Reference from traffic table

			String strcleartraffic="update gl_traffic set status=0,inv_no=0,inv_type='',inv_desc='' where inv_no="+docno;
			Statement stmtcleartraffic=conn.createStatement();
			int cleartrafficval=stmtcleartraffic.executeUpdate(strcleartraffic);
			if(cleartrafficval<0){
				return false;
			}

			stmtcleartraffic.close();

			Statement stmtclearcost=conn.createStatement();
			String strclearcost="delete from my_costtran where tr_no="+trno;
			int clearcost=stmtclearcost.executeUpdate(strclearcost);
			if(clearcost<0){
				return false;
			}
			stmtclearcost.close();

			Statement stmtlog=conn.createStatement();
			String strlog="insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+","+branchid+",'"+formdetailcode+"',now(),"+userid+",'D')";
			int logval=stmtlog.executeUpdate(strlog);
			if(logval<0){
				return false;
			}
			if(logval>0){
				return true;
			}
			//System.out.println("Success");




		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}


		return false;
	}



	public int getVoucherno(int val) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int voucherno=0;
		try{
			conn=objconn.getMyConnection();
			Statement stmtvoucher=conn.createStatement();
			String strvoucher="select voc_no from gl_proinvm where doc_no="+val;
			ResultSet rsvoucher=stmtvoucher.executeQuery(strvoucher);
			while(rsvoucher.next()){
				voucherno=rsvoucher.getInt("voc_no");
			}
			stmtvoucher.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();	
		}
		finally{
			conn.close();
		}
		return voucherno;
	}


	public   int getCompChk() throws SQLException {



		Connection conn = null;
		int isindian=0;

		try {
			conn = objconn.getMyConnection();
			Statement stmt1 = conn.createStatement ();
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();


			String strSql1 = "select method from gl_config where field_nme='indian'";

			ResultSet rs1 = stmt1.executeQuery(strSql1);
			while(rs1.next ()) {
				isindian=rs1.getInt("method");
			}




			stmt1.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return isindian;
	}	


	public   String getFileName(String formcode) throws SQLException {



		Connection conn = null;
		String path="";
		String fileName ="";
		String filepath="";
		try {
			conn = objconn.getMyConnection();
			Statement stmt1 = conn.createStatement ();
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();

			/*	Calendar now = GregorianCalendar.getInstance();

        		SimpleDateFormat df = new SimpleDateFormat("HH");
        		String formattedDate = df.format(new Date())*/;

        		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
        		java.util.Date date = new java.util.Date();
        		//System.out.println(dateFormat.format(date)); //2014/08/06 15:59:48


        		//String currdate=""+now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+" "+ formattedDate+"."+now.get(Calendar.MINUTE)+"."+now.get(Calendar.SECOND)+" ";

        		String currdate=dateFormat.format(date);

        		//System.out.println("===currdate======"+currdate);

        		String strSql1 = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");

        		ResultSet rs1 = stmt1.executeQuery(strSql1);
        		while(rs1.next ()) {
        			path=rs1.getString("imgPath");
        		}

        		fileName = formcode+"["+request.getParameter("vocno")+"]"+currdate+".pdf";

        		filepath=path+ "/attachment/"+formcode+"/"+fileName;

        		ServletContext context = ((HttpSession) request).getServletContext();
        		File dir = new File(path+ "/attachment/"+formcode);
        		dir.mkdirs();



        		stmt1.close();
        		conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return filepath;
	}


	public   ClsProformaInvoiceBean sendMail (String fromno,String branch) throws SQLException {
		ClsProformaInvoiceBean bean = new ClsProformaInvoiceBean();
		Connection  conn =null;
		HttpServletRequest request=ServletActionContext.getRequest();
		ArrayList<ClsProformaInvoiceAction> employees = new ArrayList();
		try {
			conn= objconn.getMyConnection();
			ClsNumberToWord obj=new ClsNumberToWord();
			
			Statement stmtinvoice = conn.createStatement ();
			String strSql="";



			ArrayList<Double> totalarray=new ArrayList<>();

			String strtotal="select round(sum(coalesce(total,0)),2) total,inv.doc_no from gl_proinvm inv left join gl_proinvd on doc_no=rdocno where inv.doc_no="+fromno+"  and inv.status<>7 and inv.brhid="+branch+" group by doc_no order by doc_no";
			ResultSet rstotal=stmtinvoice.executeQuery(strtotal);

			while(rstotal.next()){
				totalarray.add(rstotal.getDouble("total"));
			}


			strSql="select  coalesce(br.tinno,'') as tinno,coalesce(br.pbno,'') as pbno,coalesce(br.stcno,'') stcno,coalesce(br.cstno,'') cstno,coalesce(dr.name,dr1.name) driven,inv.fromdate sqlfromdate,inv.todate sqltodate,br.branch,year(inv.date) dateyear,agmt.pono,DATE_FORMAT(CURDATE(),'%d/%m/%Y')"+
					" finaldate,cur.code,cmp.company,cmp.address ,cmp.tel,cmp.fax,br.branchname,ac.refname,ac.com_mob,ac.per_mob,ac.fax1,dr.name,"+
					" inv.voc_no as doc_no, DATE_FORMAT(inv.date,'%d/%m/%Y') date,inv.rano,DATE_FORMAT(inv.fromdate,'%d/%m/%Y') fromdate,"+
					" DATE_FORMAT(inv.todate,'%d/%m/%Y') todate,inv.acno, inv.ratype,if(inv.ratype='RAG',coalesce(agmt.ofleet_no,''),coalesce(veh.fleet_no,'')) ofleet_no,"+
					" if(inv.ratype='RAG',coalesce(agmt.mrano,''),coalesce(lagmt.manualra,'')) mrano,coalesce(DATE_FORMAT(agmt.odate,'%d/%m/%Y'),"+
					" DATE_FORMAT(lagmt.outdate,'%d/%m/%Y')) agmtdate,veh.flname,veh.reg_no,plt.code_name,auth.authname,ac.address cladd,ac.address2 cladd1,lc.loc_name,u.user_name"+
					" from gl_proinvm inv"+
					" left join gl_ragmt agmt on (inv.rano=agmt.doc_no and inv.ratype='RAG')"+
					" left join gl_lagmt lagmt on(inv.rano=lagmt.doc_no and inv.ratype='LAG')"+
					" left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM')"+
					" left join gl_vehmaster veh on ((agmt.ofleet_no=veh.fleet_no  and inv.ratype='RAG') or ((select if(perfleet=0,tmpfleet,perfleet) fleet from gl_lagmt"+
					" where doc_no=inv.rano)=veh.fleet_no and inv.ratype='LAG'))"+
					" left join gl_vehplate plt on veh.pltid=plt.doc_no"+
					" left join gl_vehauth auth on veh.authid=auth.doc_no"+
					" left join (select min(srno) srno,rdocno from gl_rdriver where status=3 group by rdocno) gdr on  agmt.doc_no=gdr.rdocno "+
					" left join gl_rdriver rdr on agmt.doc_no=rdr.rdocno and rdr.srno=gdr.srno "+ 
					" left join (select min(srno) srno,rdocno from gl_ldriver where status=3 group by rdocno) gldr on  lagmt.doc_no=gldr.rdocno "+
					" left join gl_ldriver ldr on lagmt.doc_no=ldr.rdocno and ldr.srno=gldr.srno  "+
					" left join gl_drdetails dr on ((rdr.drid=dr.dr_id or ldr.drid=dr.dr_id) and dr.dtype='CRM')"+
					" left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no or lagmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+
					" left join my_brch br on inv.brhid=br.doc_no"+
					" left join my_comp cmp on br.cmpid=cmp.doc_no"+
					" left join my_curr cur on cmp.curid=cur.doc_no"+
					" inner join my_locm l on l.brhid=br.doc_no"+
					" inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=br.doc_no)"+
					" left join my_user u on u.doc_no=inv.userid where inv.doc_no="+fromno+"  and inv.status<>7 and inv.brhid="+branch+" group by inv.doc_no";

			//System.out.println("Print query:"+strSql);
			/*String strSqldetail="select invd.sr_no,imod.description,invd.units,invd.amount,invd.total from gl_proinvd invd left join gl_invmode imod on "+
						" invd.chid=imod.idno where invd.rdocno >="+fromno+" and invd.rdocno<="+tono+"";
	//System.out.println("Detail"+strSqldetail);
			 */			
			ArrayList<ArrayList<String>> printdet=new ArrayList<>();
			ArrayList<ArrayList<String>> printfleetmaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printsalikmaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printtrafficdubaimaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printtrafficelsemaster=new ArrayList<>();
			ResultSet resultSet = stmtinvoice.executeQuery (strSql);
			int i=0;
			while(resultSet.next()){
				String fleet="";
				fleet="Fleet :"+resultSet.getString("ofleet_no");
				fleet=fleet+" "+resultSet.getString("flname");
				fleet=fleet+" Reg No :"+resultSet.getString("reg_no");
				fleet=fleet+" "+resultSet.getString("code_name");
				fleet=fleet+" "+resultSet.getString("authname");

				bean.setLblcompname(resultSet.getString("company"));
				bean.setLblcompaddress(resultSet.getString("address"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblbranch(resultSet.getString("branchname"));
				bean.setLblprintname("Invoice");
				bean.setLblclient(resultSet.getString("refname"));
				bean.setLblphone(resultSet.getString("com_mob"));
				bean.setLblmobile(resultSet.getString("per_mob"));
				bean.setLblfax(resultSet.getString("fax1"));
				bean.setLbldriven(resultSet.getString("driven"));
				bean.setLblinvno(resultSet.getString("doc_no"));
				bean.setLblbranchcode(resultSet.getString("branch"));
				bean.setLbldateyear(resultSet.getString("dateyear"));
				bean.setLbldate(resultSet.getString("date").toString());
				bean.setLblrano(resultSet.getString("rano"));
				bean.setLblinvfrom(resultSet.getString("fromdate").toString());
				bean.setLblinvto(resultSet.getString("todate"));
				bean.setLblrecievedby(resultSet.getString("user_name"));
				String ac="";
				ac=resultSet.getString("acno");
				//ac=ac+" "+resultSet.getString("description");
				bean.setLblaccount(ac);
				if(resultSet.getString("ratype").equalsIgnoreCase("RAG")){
					bean.setLblmrano(resultSet.getString("mrano"));
				}
				bean.setLblcontractstart(resultSet.getString("agmtdate").toString());

				bean.setLblcontractvehicle(fleet);
				bean.setLblratype(resultSet.getString("ratype"));
				bean.setLbltotal(totalarray.get(i).toString());
				bean.setLblnetamount(totalarray.get(i).toString());
				bean.setLbldriven(resultSet.getString("driven"));
				bean.setLbladdress1(resultSet.getString("cladd"));
				bean.setLbladdress2(resultSet.getString("cladd1"));
				bean.setLblfinaldate(resultSet.getString("finaldate").toString());
				bean.setLbllocation(resultSet.getString("loc_name"));
				/*
		bean.setTinno(resultSet.getString("tinno"));
		bean.setLblservicetax(resultSet.getString("stcno"));
		bean.setLblcstno(resultSet.getString("cstno"));
				 */
				if(resultSet.getString("ratype").equalsIgnoreCase("RAG")){
					bean.setLbllpono(resultSet.getString("pono"));
				}
				bean.setLblamountwords(resultSet.getString("code")+" "+obj.convertNumberToWords(totalarray.get(i))+" only");

				i++;		
			}

			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
	}
	public   HashMap getEmailPrintdetails(String docno) throws SQLException {
		ArrayList<String> arr=null;
		HashMap map=new HashMap();
		Connection conn =null;
		try {
			conn= objconn.getMyConnection();
			Statement stmtinvoice = conn.createStatement ();
			String strSqldetail="";
			/*		
strSqldetail="select r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,m.description from gl_invmode m left join (select r.chid,"+
		" r.units,round(r.amount,2) amount,round(coalesce(sum(total),0),2) total from gl_proinvd r where r.chid not in(8,9,14,15) and"+
		" rdocno="+docno+" group by chid"+
		" union all"+
		" select r.chid,r.units,round(sum(r.amount),2),round(coalesce(sum(total),0),2) total from gl_proinvd r where r.chid in(8,14) and rdocno="+docno+""+
		" union all"+
		" select r.chid,r.units,round(r.amount,2),round(coalesce(sum(total),0),2) total from gl_proinvd r where r.chid  in(9,15) and rdocno="+docno+""+
		" ) r on(m.idno=r.chid) where r.chid is not null";*/


			strSqldetail="select  r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,case when r.chid=19 then concat(m.description,' @ ', "
					+ "	(select  round(set_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail  where "
					+ " r.date >=fromdate and r.date <=todate and status=3 )),' %') when r.chid=20 then concat(m.description,' @ ', "
					+ "(select round(vat_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail where "
					+ "r.date >=fromdate and r.date <=todate and status=3)),' %') else m.description end description from gl_invmode m left join "
					+ "(select r.chid,r.units,round(r.amount,2) amount, round(coalesce(sum(total),0),2) total,m.date from gl_proinvm m  inner join"
					+ " gl_proinvd r on m.doc_no=r.rdocno where r.chid not in(8,9,14,15) and rdocno="+docno+" group by chid union all "
					+ "	select r.chid,r.units,round(sum(r.amount),2),round(coalesce(sum(total),0),2)  total,m.date from gl_proinvm m  "
					+ " inner join gl_proinvd r on m.doc_no=r.rdocno  where r.chid in(8,14) and rdocno="+docno+" union all select r.chid,r.units, "
					+ " round(r.amount,2), round(coalesce(sum(total),0),2) total,m.date from gl_proinvm m  inner join gl_proinvd r on m.doc_no=r.rdocno  where"
					+ "	r.chid in(9,15) and rdocno="+docno+") r on(m.idno=r.chid) where r.chid is not null";

			//System.out.println("====getPrintdetails==== "+strSqldetail);
			ResultSet rsdetail=stmtinvoice.executeQuery(strSqldetail);

			int rowcount=1;
			/*if(rsdetail.last()){
	rowcount=rsdetail.getRow();
	rsdetail.beforeFirst();
}*/
			while(rsdetail.next()){
				arr=new ArrayList<String>();
				arr.add(rowcount+"");
				arr.add(rsdetail.getString("description"));
				arr.add(rsdetail.getString("units"));
				arr.add(rsdetail.getString("amount"));
				arr.add(rsdetail.getString("total"));

				map.put(rowcount, arr);
				//System.out.println("=====rowcountrowcountrowcount===== "+map.get(rowcount));
				rowcount++;


			}
			//System.out.println("========== "+arr);
			stmtinvoice.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		// TODO Auto-generated method stub
		return map;
	}

	public   ArrayList<String>  getFleetdetailsmail(String lblrano,Date fromdate,Date todate,String lblratype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> fleetarray=new ArrayList<>();
		try {
			String strfleetdetails="select distinct mov.fleet_no,veh.flname,veh.reg_no,DATE_FORMAT(mov.dout,'%d/%m/%Y') dout,COALESCE(DATE_FORMAT(mov.din,'%d/%m/%Y '),'') "+
					" din from gl_vmove mov left join gl_vehmaster veh on (mov.fleet_no=veh.fleet_no ) where mov.rdocno="+lblrano+" and mov.rdtype='"+lblratype+"' and mov.repno<> 0 and mov.trancode<>'DL'"+
					" and ((dout >='"+fromdate+"' and dout <='"+todate+"') or (din >='"+fromdate+"' and din <='"+todate+"'))";
			conn=objconn.getMyConnection();

			//System.out.println("==getFleetdetails===="+strfleetdetails);

			Statement stmtfleetdetails = conn.createStatement();
			ResultSet rsfleetdetails=stmtfleetdetails.executeQuery(strfleetdetails);
			while(rsfleetdetails.next()){
				String temp=rsfleetdetails.getString("fleet_no")+"  "+rsfleetdetails.getString("flname")+"  "+"Reg No:"+rsfleetdetails.getString("reg_no")+"  "+"From Date:"+rsfleetdetails.getString("dout")+"  "+"To Date:"+rsfleetdetails.getString("din");
				fleetarray.add(temp);
			}
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return fleetarray;
	}

	public  JSONArray printInvoiceSearch(String mode,String fromdate,String todate,String agmtno,String agmttype,String client,String branch,String fromno,String tono) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		if(!mode.equalsIgnoreCase("1")){
			return RESULTDATA;
		}

		String sqltest="";
		java.sql.Date sqlfromdate=null,sqltodate=null;

		if(!fromdate.equalsIgnoreCase("")){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("")){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}

		if(!fromno.equalsIgnoreCase("")){
			sqltest+=" and inv.voc_no>="+fromno+"";
		}
		if(!tono.equalsIgnoreCase("")){
			sqltest+=" and inv.voc_no<="+tono+"";
		}

		if(sqlfromdate!=null ){
			sqltest+=" and inv.date>='"+sqlfromdate+"'";
		}
		if(sqltodate!=null){
			sqltest+=" and inv.date<='"+sqltodate+"'";
		}

		if(!agmttype.equalsIgnoreCase("")){
			sqltest+=" and inv.ratype='"+agmttype+"'";
		}
		if(agmttype.equalsIgnoreCase("RAG")){
			if(!agmtno.equalsIgnoreCase("")){
				sqltest+=" and agmt.voc_no="+agmtno+"";
			}
		}
		if(agmttype.equalsIgnoreCase("LAG")){
			if(!agmtno.equalsIgnoreCase("")){
				sqltest+=" and lagmt.voc_no="+agmtno+"";
			}
		}
		if(!client.equalsIgnoreCase("")){
			sqltest+=" and ac.refname like '%"+client+"%'";
		}
		if(!branch.equalsIgnoreCase("")){
			sqltest+=" and inv.brhid="+branch+"";
		}


		Connection conn=null;

		try {
			conn= objconn.getMyConnection();
			Statement stmtsearch = conn.createStatement ();
			String str1Sql="select inv.doc_no,inv.voc_no voucherno,inv.rano,inv.date,inv.ratype agmttype,ac.refname,if(inv.ratype='RAG',agmt.voc_no,lagmt.voc_no) voc_no "+
					" from gl_proinvm inv left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_ragmt agmt on "+
					" (inv.rano=agmt.doc_no and inv.ratype='RAG') left join gl_lagmt lagmt on (inv.rano=lagmt.doc_no and inv.ratype='LAG') where inv.status<>7 "+sqltest+""+
					" group by inv.doc_no";
			//		System.out.println("Print Search Query:"+str1Sql);
			ResultSet resultSet = stmtsearch.executeQuery(str1Sql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtsearch.close();
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
		//System.out.println(RESULTDATA);
		conn.close();
		return RESULTDATA;
	}

	public String sendSMS(String doc_no,String branchid,String dtype,String trafficamt,String hidclient,String traffic_date,Connection conn){


		Statement smt=null;
		try {
			
			smt = conn.createStatement();

			SmsAction sms=new SmsAction();
			String phone="",clname="";
			try
			{


				ResultSet rs= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
								"select refname,per_mob from my_acbook where doc_no="+hidclient+" and dtype='CRM'");

				if(rs.next())
				{

					phone=rs.getString("per_mob");
					clname=rs.getString("refname");
					

				}
				rs.close();	
			}catch(Exception e){e.printStackTrace();}



			String doctype=dtype.contains("###")?dtype.split("###")[0]:dtype;

			sms.doSendSms(phone, clname, trafficamt, doc_no, traffic_date,doctype, branchid,conn);
		}
		catch(Exception e){
			e.printStackTrace();
			return "fail";
		}

		return "success";
	}

public int getOneDayExtraConfig(Connection conn) {
		// TODO Auto-generated method stub
		int oneDayExtraConfig=0;
		try{
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select method from gl_config where field_nme='invOneDayExtra'");
			while(rs.next()){
				oneDayExtraConfig=rs.getInt("method");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return oneDayExtraConfig;
	}
}
