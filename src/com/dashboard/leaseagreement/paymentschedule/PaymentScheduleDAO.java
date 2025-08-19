package com.dashboard.leaseagreement.paymentschedule;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class PaymentScheduleDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	
	public  JSONArray pymtScheduleGrid(String branch, String pdate) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
    	String sqltest="";
    	
    
     
        
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and l.brhid="+branch+"";
    		}
    		
    		 java.sql.Date sqlDate = null;
    	     	if(!(pdate.equalsIgnoreCase("undefined"))&&!(pdate.equalsIgnoreCase(""))&&!(pdate.equalsIgnoreCase("0")))
    	     	{
    	     		sqlDate=ClsCommon.changeStringtoSqlDate(pdate);
    	     		
    	     	}
    	     	else{
    	     
    	     	}
    		
    	
    	Connection conn=null;
     
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtinv = conn.createStatement();
				 
				String sql="select l.voc_no lano,a.refname client,l.outdate odate,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleetno,"
						+ "v.flname fleetname,lpc.date dates,round(lpc.amount,2) amount,l.doc_no,l.acno clacno,l.cldocno,l.brhid,a.period2,lpc.srno "
						+ "from gl_leasepytcalc lpc left join gl_lagmt l on l.doc_no=lpc.rdocno left join my_acbook a on l.cldocno=a.cldocno and a.dtype='CRM' "
						+ "left join gl_vehmaster v on if(l.perfleet=0,l.tmpfleet,l.perfleet)=v.fleet_no "
						+ " where l.status=3 and lpc.markstatus=0 and l.clstatus=0 and lpc.date<='"+sqlDate+"' "+sqltest+" ";
		//	System.out.println("------sql------"+sql);
				
				ResultSet resultSet = stmtinv.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
					stmtinv.close();
				conn.close();
		    	
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }




	public int insert(ArrayList<String> invoicearray, HttpSession session,
			HttpServletRequest request) throws SQLException {
//		System.out.println("Inside DAO");
		// TODO Auto-generated method stub
		Connection conn=null;
		int val=0;
		try{
			conn = ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			conn.setAutoCommit(false);
			String invmsql=null,invdsql=null,jvtran1sql=null,jvtran2sql=null;
			java.sql.Date sqlDueDate = null;
			java.sql.Date sqlLPCDate = null;
			int invid=0;
			int acno=0;
			int errorstatus=0;
			String sqlinvmod="select idno,acno from gl_invmode where description='LEASE CHARGES'";
			ResultSet rsinv_acno=stmt.executeQuery(sqlinvmod);
			while(rsinv_acno.next())
			{
				 invid=rsinv_acno.getInt("idno");
				 acno=rsinv_acno.getInt("acno");
					 
			}
			
			for(int k=0;k<invoicearray.size();k++)
			{
					
				String[] pmgntarr=((String) invoicearray.get(k)).split("::"); 
				
				 String lano = ""+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"";
				  String docno = ""+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"";
				  String cldocno = ""+(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().equalsIgnoreCase("")|| pmgntarr[2].isEmpty()?0:pmgntarr[2].trim())+"";
				  
				  String clacno = ""+(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("NaN")|| pmgntarr[3].trim().equalsIgnoreCase("")|| pmgntarr[3].isEmpty()?0:pmgntarr[3].trim())+"";
				  String amount = ""+(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().equalsIgnoreCase("")|| pmgntarr[4].isEmpty()?0:pmgntarr[4].trim())+"";
				  String brch = ""+(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("NaN")|| pmgntarr[5].trim().equalsIgnoreCase("")|| pmgntarr[5].isEmpty()?0:pmgntarr[5].trim())+"";
			//	  String userid = ""+(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("NaN")|| pmgntarr[6].trim().equalsIgnoreCase("")|| pmgntarr[6].isEmpty()?0:pmgntarr[6].trim())+"";
				  String fleetno = ""+(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("NaN")|| pmgntarr[6].trim().equalsIgnoreCase("")|| pmgntarr[6].isEmpty()?0:pmgntarr[6].trim())+"";
				  String period2 = ""+(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("NaN")|| pmgntarr[7].trim().equalsIgnoreCase("")|| pmgntarr[7].isEmpty()?0:pmgntarr[7].trim())+"";
				  String srno = ""+(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("NaN")|| pmgntarr[8].trim().equalsIgnoreCase("")|| pmgntarr[8].isEmpty()?0:pmgntarr[8].trim())+"";
				  String lpcdate = ""+(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("NaN")|| pmgntarr[9].trim().equalsIgnoreCase("")|| pmgntarr[9].isEmpty()?"":pmgntarr[9].trim())+"";
				
				  sqlLPCDate=ClsCommon.changeStringtoSqlDate(lpcdate);
				  
					 String strinvdesc="select (select method from gl_config where field_nme='invdesc') method,(select reg_no from gl_vehmaster where fleet_no="+fleetno+") reg_no,"+
							" (select plt.code_name from gl_vehmaster veh left join gl_vehplate plt on veh.pltid=plt.doc_no where veh.fleet_no="+fleetno+") plate";
					 int invdesc=0;
					 String regno="",plate="";
					 ResultSet rsinvdesc=stmt.executeQuery(strinvdesc);
					 while(rsinvdesc.next()){
						invdesc=rsinvdesc.getInt("method");
					 	regno=rsinvdesc.getString("reg_no");
					 	plate=rsinvdesc.getString("plate");
					 }
					 String desc="";
					 desc="LAG - "+lano;
					 	
					 if(invdesc==1){
						 desc=desc+" with Reg No "+regno+" and Plate Code "+plate;
					 }
				String strtaxincl="select taxincl from gl_lagmt where doc_no="+docno;
//				System.out.println("Agmt Taxincl:"+strtaxincl);
				ResultSet rstaxincl=stmt.executeQuery(strtaxincl);
				int taxincl=0;
				while(rstaxincl.next()){
					taxincl=rstaxincl.getInt("taxincl");
				}  
				String strcurrency="select t.curid,c.code currency,cb.rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no"+
				" left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr"+
				" where coalesce(toDate,curdate())>='"+sqlLPCDate+"' and frmDate<='"+sqlLPCDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid)"+
				" where t.doc_no="+clacno;
//				System.out.println(strcurrency);
				int curid=0;
				double currate=0.0;
				ResultSet rscurrency=stmt.executeQuery(strcurrency);
				while(rscurrency.next()){
					curid=rscurrency.getInt("curid");
					currate=rscurrency.getDouble("rate");
				}
				  double neg_amount=Double.parseDouble(amount)*-1;
				  
				  String sqlinserttrno="insert into my_trno(USERNO, TRTYPE, brhId, edate, transid) values('"+session.getAttribute("USERID").toString()+"','INV','"+brch+"',NOW(),0)";
				  stmt.executeUpdate(sqlinserttrno);
				  
				  int trno=0;
				  String sqltrno="select max(trno) trno from my_trno where trtype='INV' ";
				  ResultSet rstrno=stmt.executeQuery(sqltrno);
				  if(rstrno.next())
				  {
					
					 trno=rstrno.getInt("trno");
					 
				  }
				  
				  int invmaxdoc=0;
				  int invmaxvoc=0;
				  String invmax="select coalesce(max(doc_no),0)+1 invmdoc from gl_invm";
				  ResultSet rsinv=stmt.executeQuery(invmax);
					 if(rsinv.next())
					 {
						
						invmaxdoc=rsinv.getInt("invmdoc");
						
						 
					 }
				String invvocmax="select coalesce(max(voc_no),0)+1 invmvoc from gl_invm where brhid="+brch;
				ResultSet rsinvvoc=stmt.executeQuery(invvocmax);
				while(rsinvvoc.next()){
					invmaxvoc=rsinvvoc.getInt("invmvoc");
				}
					//due date
					
			String sqldate=("select DATE_ADD('"+sqlLPCDate+"', INTERVAL "+period2+" DAY) AS duedate");
		    ResultSet rsdate1 = stmt.executeQuery(sqldate);
		        
		     while (rsdate1.next()) {
		     sqlDueDate=rsdate1.getDate("duedate");
		     }
			
		     String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+cldocno+" and dtype='CRM') clienttaxmethod";
				ResultSet rschecktax=stmt.executeQuery(strchecktax);
				int taxstatus=0;
				int clienttaxmethod=0;
				while(rschecktax.next()){
					taxstatus=rschecktax.getInt("taxmethod");
					clienttaxmethod=rschecktax.getInt("clienttaxmethod");
				}
				
			invmsql="insert into gl_invm (brhid, DOC_NO, DATE, RATYPE, CLDOCNO, RANO, LDGRNOTE, INVNOTE, CURID, ACNO, TR_NO, DTYPE, FROMDATE, TODATE, status, dispatch, userid, manual, voc_no) values('"+brch+"', '"+invmaxdoc+"', '"+sqlLPCDate+"', 'LAG','"+cldocno+"' , '"+docno+"', '"+desc+"', '"+desc+"', '"+curid+"', '"+clacno+"', '"+trno+"', 'INV', '"+sqlLPCDate+"', '"+sqlLPCDate+"', 3, 0,'"+session.getAttribute("USERID").toString()+"', 11, '"+invmaxvoc+"')";
		 	int invmaster=stmt.executeUpdate(invmsql);
			if(invmaster<=0){
				errorstatus=1;
				return 0;
			}
			double invdamt=0.0,clamt=0.0;
			
			clamt=ClsCommon.Round(Double.parseDouble(amount),2);
			if(taxincl==1 && taxstatus>0 && clienttaxmethod>0){
				invdamt = ClsCommon.sqlRound(((Double.parseDouble(amount)/105)*100),2);
				// neg_amount = invdamt *-1 ;
				
			}
			else{
				invdamt = ClsCommon.sqlRound(Double.parseDouble(amount),2) ;
				clamt=ClsCommon.sqlRound(Double.parseDouble(amount),0);
			}
			if(taxincl==0  && taxstatus>0 && clienttaxmethod>0){
				invdamt = ClsCommon.sqlRound(Double.parseDouble(amount),2) ;
				clamt=ClsCommon.sqlRound(Double.parseDouble(amount)+(Double.parseDouble(amount)*0.05),0);
			}
			/*else if(taxstatus>0 && clienttaxmethod>0) {
				invdamt = ClsCommon.sqlRound(Double.parseDouble(amount),2) ;
				clamt=ClsCommon.sqlRound(Double.parseDouble(amount)+(Double.parseDouble(amount)*0.05),0);
			}*/
			// invd lease charges 
			
			invdsql="insert into gl_invd(SR_NO, BRHID, RDOCNO, TRNO, CHID, UNITS, AMOUNT, TOTAL, ACNO, remarks) "
					+ " values(1,'"+brch+"','"+invmaxdoc+"', '"+trno+"','"+invid+"' , '1', '"+invdamt+"', '"+invdamt+"', '"+acno+"','"+desc+"' )";
			double generalamt=0.0,generalldr=0.0;
			generalamt=invdamt;		
			int invdetail=stmt.executeUpdate(invdsql);
//			System.out.println("===== invd lease charge === "+invdsql);
			if(invdetail<=0){
				errorstatus=1;
				return 0;
			}
			
			// jvtran insertion lease charges 
			jvtran1sql="insert into my_jvtran(tr_no, acno, dramount, rate, curId, trtype, id, ref_row, brhid, description, yrId, date, dTYPE, stkmove, ldramount, doc_no, LAGE, ref_detail, lbrrate, status, category, refTrNo, rdocno, rtype, bankreconcile, prep, costtype, costcode) "
					+ " values ('"+trno+"', '"+acno+"', '"+neg_amount+"', "+currate+", '"+currate+"', '5', -1, 1, '"+brch+"', '"+desc+"', 0, '"+sqlLPCDate+"', 'INV', 0, '"+neg_amount*currate+"', '"+invmaxdoc+"', 1, '1', "+currate+", 3, '', 0, '"+docno+"', 'LAG', 0, 0,6, '"+fleetno+"')";
//			System.out.println("===== jvtran lease charge === "+jvtran1sql);
			int jv1=stmt.executeUpdate(jvtran1sql);
			if(jv1<=0){
				errorstatus=1;
				return 0;
			}
			
			// jvtran insertion client account 
			
			String strgettran="select tranid from my_jvtran where acno="+acno+" and tr_no="+trno;
			ResultSet rsgettran=stmt.executeQuery(strgettran);
			int tranid=0;
			while(rsgettran.next()){
				tranid=rsgettran.getInt("tranid");
			}
			
			String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values("+acno+",6,"+amount+",1,"+tranid+",0,"+fleetno+","+trno+")";
			int costinsert=stmt.executeUpdate(strcostinsert);
			if(costinsert<=0){
				errorstatus=1;
				return 0;
			}
			//biblog
					 
			String sqlbiblog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+invmaxdoc+"','"+brch+"','INV',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			int biblog=stmt.executeUpdate(sqlbiblog);  
			if(biblog<=0){
				errorstatus=1;
				return 0;
			}
					//update leasepytcalc	 	
					 	
			String updatesql="update gl_leasepytcalc set markstatus='"+invmaxdoc+"',trno="+trno+" where srno='"+srno+"'";
			int updatepyt=stmt.executeUpdate(updatesql);
			if(updatepyt<0){
				errorstatus=1;
				return 0;
			}
			
			
			if(taxstatus>0 && clienttaxmethod>0){
//				System.out.println("Inside Tax Method");
				String strtaxapplied="select total from gl_invd inv left join gl_invmode ac on inv.chid=ac.idno "
						+ " where ac.tax=1 and inv.rdocno="+invmaxdoc;
//				System.out.println(strtaxapplied);
				ResultSet rsapplied=stmt.executeQuery(strtaxapplied);
				double generalamttax=0.0;
				while(rsapplied.next()){
					generalamttax+=rsapplied.getDouble("total");
				}
				String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax "
						+ " left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqlLPCDate+"' between tax.fromdate and tax.todate";
//				System.out.println("Tax Query: "+strgettax);
				double setpercent=0.0;
				double vatpercent=0.0;
				ResultSet rsgettax=stmt.executeQuery(strgettax);
				double vatval=0.0,setval=0.0;
				ArrayList<String> temptaxarray=new ArrayList<>();
				
				while(rsgettax.next()){
					setpercent=rsgettax.getDouble("set_per");
					vatpercent=rsgettax.getDouble("vat_per");
					if(taxincl==1){
						/*invdamt = (Double.parseDouble(amount)/105)*100;
						neg_amount = invdamt *-1 ;*/
						
						vatval=Double.parseDouble(amount)-((Double.parseDouble(amount)/(100+vatpercent))*100);
						setval=Double.parseDouble(amount)-((Double.parseDouble(amount)/(100+setpercent))*100);
						
					}
					else {
						// invdamt = Double.parseDouble(amount) ;
						vatval=(generalamttax*(vatpercent/100));
						setval=generalamttax*(setpercent/100);
					}
					
					setval=ClsCommon.Round(setval, 2);
					vatval=ClsCommon.Round(vatval, 2);
					
					if(rsgettax.getInt("idno")==19 || rsgettax.getInt("idno")==20){
//						System.out.println("Vatval: "+vatval);
						if(vatval>0.0){
							
							temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+vatval+"::"+rsgettax.getString("description"));
							if(taxincl==0){
								generalamt+=vatval;
							}
							
						}
					}
					if(setpercent>0.0 || vatpercent>0.0){
						
						generalamt=ClsCommon.Round(generalamt, 2);
						generalamt=ClsCommon.Round(generalamt, 2);
						generalldr=generalamt*currate;
						int tempsrno=invoicearray.size()+1;
						for(int j=0;j<temptaxarray.size();j++){
							String[] tax=temptaxarray.get(j).split("::");
							Statement stmttaxinvd=conn.createStatement();
							if(Double.parseDouble(tax[2])>0){
								int taxinvdval=0;
								
									String strtaxinvd="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+tempsrno+"','"+brch+"','"+invmaxdoc+"'"+
											",'"+trno+"','"+(tax[0].equalsIgnoreCase("undefined") || tax[0].isEmpty()?0:tax[0])+"','1','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"')";	
//												System.out.println("Invd tax line Sql:"+strtaxinvd);
									taxinvdval=stmttaxinvd.executeUpdate(strtaxinvd);
								
								
								if( taxinvdval>0 ){
									// if(taxincl==0){
									String strtaxjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
											"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype, costtype, costcode)values('"+trno+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"',"+
											"'"+Double.parseDouble(tax[2])*-1+"','"+currate+"','"+curid+"',0,-1,'"+(tempsrno)+"',"+
											"'"+brch+"','"+desc+"',"+
											"0,'"+sqlLPCDate+"','INV','"+(Double.parseDouble(tax[2])*currate)*-1+"','"+invmaxdoc+"','"+(tax[3].equalsIgnoreCase("undefined") || tax[3].isEmpty()?0:tax[3])+"',"+
											"'"+curid+"','5',1,'"+cldocno+"',3,'"+docno+"','LAG',6, '"+fleetno+"')";
									tempsrno++;
									Statement stmttaxjv=conn.createStatement();
//													System.out.println("Jvtran tax line Sql:"+strtaxjv);
									int taxjvval=stmttaxjv.executeUpdate(strtaxjv);
									if(taxjvval>0){

									}
									else{
										System.out.println("Jvtran Tax Error");
										return 0;
									}
									stmttaxjv.close();
									stmttaxinvd.close();
									//}
								}
								else{
									System.out.println("Tax Invd Error");
									return 0;
								}
							}
						}
					}
					
				}
				
				if(generalamt>0){

					double ramt=Math.round(generalamt);
					double ramtldr=ramt*currate;
					System.out.println(generalamt+"$$$$"+ramt);
					double discount = 0.0;
					if(taxincl==1 && vatval>0.0){
						double tempramt=Math.round(generalamt+vatval);
						discount=(generalamt+vatval)-tempramt;
					}
					else{
						discount=generalamt-ramt;
					}
					discount=ClsCommon.Round(discount, 2);
					double discountldr=discount*currate;
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
						String sql="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('2','"+brch+"','"+invmaxdoc+"'"+
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
//									System.out.println(" Invd Sql"+sql);
						int discid=0;
						if(discount>0.0){
							discid=1;
						}
						else if(discount<0.0){
							discid=-1;
						}
						String sqljvdisc="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate, costtype, costcode)values('"+trno+"','"+discac+"',"+
								"'"+discount+"','"+currate+"','"+curid+"',0,"+discid+",1,"+
								"'"+brch+"','Discount',"+
								"0,'"+sqlLPCDate+"','INV','"+discountldr+"','"+invmaxdoc+"','1',"+
								"'"+curid+"','5',1,"+cldocno+",3,'"+docno+"','LAG','"+sqlDueDate+"',6, '"+fleetno+"')";
//						System.out.println("===== jvtran discount == "+sqljvdisc);
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
					if(taxincl==1){
					/*String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
							"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate, costtype, costcode)values('"+trno+"','"+clacno+"',"+
							"'"+ramt+"','"+currate+"','"+curid+"',0,1,1,'"+brch+"','"+desc+"',"+
							"0,'"+sqlLPCDate+"','INV','"+ramtldr+"','"+invmaxdoc+"','1',"+
							"'"+curid+"','5',1,"+cldocno+",3,'"+docno+"','LAG','"+sqlDueDate+"',6, '"+fleetno+"')";
							
//					System.out.println("General client account 2  sql:"+sqljv);
					int rsjv=stmt.executeUpdate(sqljv);
					if(rsjv>0){
								System.out.println("Inside general jv");	
					}
					else{
						System.out.println("General jvtran error");
						//conn.close();
						return 0;
					}*/
					}
					stmtdiscount.close();
				}
				
//				System.out.println("Tax Incl="+taxincl+"////"+vatval);
				if(taxincl==1 && vatval>0.0){
					String strupdatetaxincl="update my_jvtran set dramount=(dramount+"+vatval+"),ldramount=(ldramount+"+vatval+") where tr_no="+trno+" and acno="+acno+" and id=-1";
//					System.out.println("Tax Update:"+strupdatetaxincl);
					int updatetaxincl=stmt.executeUpdate(strupdatetaxincl);
					if(updatetaxincl<0){
						return 0;
					}
					/*String strupdatetaxinclinvd="update gl_invd set amount=(amount-"+vatval+"),total=(total-"+vatval+") where trno="+trno+" and acno="+acno+"";
					System.out.println("Tax Update:"+strupdatetaxinclinvd);
					int updatetaxinclinvd=stmt.executeUpdate(strupdatetaxinclinvd);
					if(updatetaxinclinvd<0){
						return 0;
					}*/
				}
			}
			String strgettotal="select sum(total) total from gl_invd where trno="+trno;
			ResultSet rstotal=stmt.executeQuery(strgettotal);
			double invdtotal=0.0;
			while(rstotal.next()){
				invdtotal=rstotal.getDouble("total");
			}
			jvtran2sql="insert into my_jvtran(tr_no, acno, dramount, rate, curId, duedate, trtype, id, ref_row, brhid, description, yrId, cldocno, date, dTYPE, stkmove, ldramount, doc_no, LAGE, ref_detail, lbrrate, status, category, refTrNo, rdocno, rtype, bankreconcile, prep, costtype, costcode) "
					+ " values ('"+trno+"', '"+clacno+"', '"+invdtotal+"', "+currate+", '"+curid+"', '"+sqlDueDate+"','5', 1, 1, '"+brch+"', '"+desc+"', 0, '"+cldocno+"', '"+sqlLPCDate+"', 'INV', 0, '"+invdtotal*currate+"', '"+invmaxdoc+"', 1, '1', '"+currate+"', 3, '', 0, '"+docno+"', 'LAG', 0, 0,0, 0)";
			int jv2=stmt.executeUpdate(jvtran2sql);
//			System.out.println("===== jvtran client charge === "+jvtran2sql);
			if(jv2<=0){
				errorstatus=1;
				return 0;
			}
			String strsqlchecktally="select sum(dramount) sumamt from my_jvtran where tr_no="+trno;
			ResultSet rschecktally=stmt.executeQuery(strsqlchecktally);
			while(rschecktally.next()){
				if(rschecktally.getDouble("sumamt")!=0.0){
					System.out.println("JV TALLY ERROR");
					errorstatus=1;
					return 0;
				}
			}
			}
			
			if(errorstatus!=1){
				conn.commit();
				val=1;
			}
			else{
				val=0;
			}
			
		}
		catch(Exception e){
			
			e.printStackTrace();
			val=0;
		}
		finally{
			conn.close();
		}
		return val;
	}
	
}
