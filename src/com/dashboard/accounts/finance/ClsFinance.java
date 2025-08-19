package com.dashboard.accounts.finance;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsFinance  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray accountDetails(String type,String account,String partyname,String contact,String chk) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    String sql = null;
	    	    String condition="";
	    	    String sql1 = "";
	    	    String sql2 = "";
	    	    
				if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}
				else if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}
	    	    
	    	    if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql1=sql1+" and t.account like '%"+account+"%'";
	            }
	            if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
	             sql1=sql1+" and t.description like '%"+partyname+"%'";
	            }
	            if(!((contact.equalsIgnoreCase("")) || (contact.equalsIgnoreCase("0")))){
	                sql1=sql1+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				conn = ClsConnection.getMyConnection();
				Statement stmtFinance1 = conn.createStatement();
	        	
				if(type.equalsIgnoreCase("AR") || type.equalsIgnoreCase("AP")){
					sql = "select a.per_mob,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ ""+condition+" left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and a.status<>7 and t.m_s=0"+sql1;
					
				}
				
				
				if(type.equalsIgnoreCase("GL") || type.equalsIgnoreCase("HR")){
				    if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
		                sql2=sql2+" and t.account like '%"+account+"%'";
		            }
		            if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
		             sql2=sql2+" and t.description like '%"+partyname+"%'";
		             }
					sql = "select t.doc_no,t.account,t.description,c.code curr from my_head t left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and t.m_s=0"+ sql2+" ";
					System.out.println(sql);
				}
				
				if(chk.equalsIgnoreCase("2")){
					ResultSet resultSet1 = stmtFinance1.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				else{
					stmtFinance1.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtFinance1.close();
				conn.close();
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray finance(String branch,String fromdate,String todate,String accType,String accdocno,String dtype,String docRangeFrom,String docRangeTo,String amtRangeFrom,String amtRangeTo,String chk) throws SQLException {
        
		
		JSONArray RESULTDATA=new JSONArray();
		 if(!(chk.equalsIgnoreCase("1"))){
	        	System.out.println("========CNO grid====");
	      
				return RESULTDATA;
	        }
		Connection conn = null;
		
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFinance = conn.createStatement();
				String sql = "";

				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					if(!(dtype.equalsIgnoreCase("COT") || dtype.equalsIgnoreCase("SEC") || dtype.equalsIgnoreCase("MCP"))){  
						sql+=" and d.brhId="+branch+"";
					}else {
						sql+=" and m.brhId="+branch+"";
					}
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			    }
		        
		        if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
		        	if(!(dtype.equalsIgnoreCase("COT") || dtype.equalsIgnoreCase("SEC") || dtype.equalsIgnoreCase("CNO") || dtype.equalsIgnoreCase("DNO") || dtype.equalsIgnoreCase("JVT") || dtype.equalsIgnoreCase("MCP"))){
		        		sql+=" and (d.acno="+accdocno+" or d1.acno="+accdocno+")";
					}else if(dtype.equalsIgnoreCase("SEC")){   
		        		sql+=" and m.acno_to="+accdocno+"";
					}else if(dtype.equalsIgnoreCase("CNO") || dtype.equalsIgnoreCase("DNO") || dtype.equalsIgnoreCase("TCN") || dtype.equalsIgnoreCase("TDN") || dtype.equalsIgnoreCase("JVT")){
		        		sql+=" and d.acno="+accdocno+"";
					}else {
						if(!(accType.equalsIgnoreCase("GL"))){
							if(dtype.equalsIgnoreCase("BPV") || dtype.equalsIgnoreCase("BRV") || dtype.equalsIgnoreCase("IBP") || dtype.equalsIgnoreCase("IBR")){
								sql+=" and (d.acno="+accdocno+" or d1.acno="+accdocno+")";
							} else if(dtype.equalsIgnoreCase("CPV") || dtype.equalsIgnoreCase("CRV") || dtype.equalsIgnoreCase("ICPV") || dtype.equalsIgnoreCase("ICRV")){
								sql+=" and (d.acno="+accdocno+" or d1.acno="+accdocno+")";
							} else {
								sql+=" and m.acno="+accdocno+"";
							}
						} else {
							sql+=" and m.acno="+accdocno+"";
						}
					}
	            }
            	
		        if(!(((docRangeFrom.equalsIgnoreCase("")) && (docRangeTo.equalsIgnoreCase(""))) || ((docRangeFrom.equalsIgnoreCase("0")) && (docRangeTo.equalsIgnoreCase("0"))))){
		        	sql+=" and m.doc_no between "+docRangeFrom+" and "+docRangeTo+"";
		        }
		        
		        if(dtype.equalsIgnoreCase("JVT") || dtype.equalsIgnoreCase("IJV")){
		        	if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
			        	sql+=" and if(d.dramount<0,(d.dramount*-1),d.dramount) between "+amtRangeFrom+" and "+amtRangeTo+"";
			        }
		        	
		        } else if(dtype.equalsIgnoreCase("CNO") || dtype.equalsIgnoreCase("DNO") || dtype.equalsIgnoreCase("TCN") || dtype.equalsIgnoreCase("TDN")){
		        	if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
			        	sql+=" and if(m.dramount<0,(m.dramount*-1),m.dramount) between "+amtRangeFrom+" and "+amtRangeTo+"";
			        }
		        	
		        }else if(dtype.equalsIgnoreCase("COT")){
		        	if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
			        	sql+=" and if(m.dramount<0,(m.dramount*-1),m.dramount) between "+amtRangeFrom+" and "+amtRangeTo+"";
			        }
		        	
		        }else if(dtype.equalsIgnoreCase("SEC")){
		        	if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
			        	sql+=" and if(m.amount<0,(m.amount*-1),m.amount) between "+amtRangeFrom+" and "+amtRangeTo+"";
			        }
		        }else if(dtype.equalsIgnoreCase("MCP")){
		        	if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
			        	sql+=" and if(m.totalamount<0,(m.totalamount*-1),m.totalamount) between "+amtRangeFrom+" and "+amtRangeTo+"";   
			        }
		        } else {
		        	if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
			        	sql+=" and if(d.amount<0,(d.amount*-1),d.amount) between "+amtRangeFrom+" and "+amtRangeTo+"";
			        }
		        }
		        
		        
		        if(dtype.equalsIgnoreCase("CPV") || dtype.equalsIgnoreCase("CRV") || dtype.equalsIgnoreCase("ICPV") || dtype.equalsIgnoreCase("ICRV") || dtype.equalsIgnoreCase("PC")){

		        	sql = "SELECT m.doc_no,m.date,m.desc1 description,if(d.amount<0,(d.amount*-1),d.amount) amount,if(d.lamount<0,(d.lamount*-1),d.lamount) localamount,t.description accountname,c.code currency,"
		        		+ "(select GROUP_CONCAT(h.description) from my_cashbd d left join my_head h on d.acno=h.doc_no where d.sr_no!=0 and d.tr_no=m.tr_no) reference FROM my_cashbm m left join "
						+ "my_cashbd d on (m.tr_no=d.tr_no and d.sr_no=0) left join my_cashbd d1 on (m.tr_no=d1.tr_no and d1.sr_no=1) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='"+dtype+"'"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("BPV") || dtype.equalsIgnoreCase("BRV") || dtype.equalsIgnoreCase("IBP") || dtype.equalsIgnoreCase("IBR")){

		        	sql = "SELECT m.doc_no,m.date,m.chqdt dates,m.chqno,concat(t.description,' [ ',m.desc1,' ] ') as remarks,if(t.description is null,t1.description,t.description) description,if(d.amount<0,(d.amount*-1),d.amount) amount,if(d.lamount<0,(d.lamount*-1),d.lamount) localamount,c.code currency,"
		        			+ "(select GROUP_CONCAT(h.description) from my_chqbd d left join my_head h on d.acno=h.doc_no where d.sr_no!=0 and d.tr_no=m.tr_no) reference FROM my_chqbm m "
		        			+ "left join my_chqbd d on (m.tr_no=d.tr_no and d.sr_no=0) left join my_chqbd d1 on (m.tr_no=d1.tr_no and d1.sr_no=1) left join my_head t on d.acno=t.doc_no  left join my_head t1 on d1.acno=t1.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='"+dtype+"'"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("CNO") || dtype.equalsIgnoreCase("DNO") || dtype.equalsIgnoreCase("TCN") || dtype.equalsIgnoreCase("TDN")){

		        	sql = "SELECT h1.description customername,m.doc_no,m.refno,m.date,mm.voc_no invno,mm.date invdate,m.description,if(m.amount<0,(m.amount*-1),m.amount) amount,if((m.amount*d.rate)<0,(m.amount*d.rate*-1),(m.amount*d.rate)) localamount,t.description accountname,c.code currency,"
		        			+ "(select GROUP_CONCAT(h.description) from my_cnotd d left join my_head h on d.acno=h.doc_no where d.tr_no=m.tr_no) reference FROM my_cnot m left join my_cnotd d on "
		        			+ "(m.tr_no=d.tr_no and d.sr_no=1) left join gl_invm mm on (mm.doc_no=m.invno and m.invno!=0) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no left join my_head h1 on h1.doc_no=m.acno where m.status=3 and m.dtype='"+dtype+"'"+sql;      
		           
		       //System.out.println("sql"+sql);
		        }      
		        
		        if(dtype.equalsIgnoreCase("JVT") || dtype.equalsIgnoreCase("IJV")){   

		        	sql = "SELECT m.doc_no,m.date,m.description,if(d.dramount<0,(d.dramount*-1),d.dramount) amount,if(d.ldramount<0,(d.ldramount*-1),d.ldramount) localamount,t.description accountname,c.code currency,"
		        			+ "(select GROUP_CONCAT(h.description) from my_jvtran d left join my_head h on d.acno=h.doc_no where d.tr_no=m.tr_no) reference FROM my_jvma m left join my_jvtran d on "
		        			+ "(m.tr_no=d.tr_no  and d.ref_row=1) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='"+dtype+"'"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("COT")){

		        	sql = "select m.doc_no,m.date,m.description,case when m.chqno='' then '' when m.chqno='0' then '' when m.chqno is null then '' else concat('No. : ',m.chqno,' Dated ',DATE_FORMAT(m.chqdt,'%m-%b-%Y')) END as 'cheque',"
		        		+ "concat(m.type,' To ',m.type_to) type,if(m.dramount<0,(m.dramount*-1),m.dramount) amount,if(m.lamount<0,(m.lamount*-1),m.lamount) localamount,t.description accountname,c.code currency,t1.description reference from my_contratrans m "
		        		+ "left join my_head t on m.acno=t.doc_no left join my_head t1 on m.acno_to=t1.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("SEC")){

		        	sql = "select m.date,m.doc_no,m.chqno,m.chqdt,m.amount,m.remarks,m.acno_from,m.acno_to,h.description bank,h1.description from my_secchq m left join my_head h on m.acno_from=h.doc_no left join my_head h1 on m.acno_to=h1.doc_no "
		        		+ "where m.status=3"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("FCR")){

		        	sql = "SELECT m.doc_no,m.date,m.desc1 description,if(d.amount<0,(d.amount*-1),d.amount) amount,if(d.lamount<0,(d.lamount*-1),d.lamount) localamount,t.description accountname,c.code currency FROM my_fuelcardbm m left join "  
		        		+ "my_fuelcardbd d on (m.tr_no=d.tr_no and d.sr_no=0) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='FCR'"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("UCP")){

		        	sql = "select m.doc_no,m.date,m.desc1 remarks,m.chqdt dates,m.chqno,if(d.amount<0,(d.amount*-1),d.amount) amount,if(d.lamount<0,(d.lamount*-1),d.lamount) localamount,t.description accountname,c.code currency,"
		        		+ "(select GROUP_CONCAT(h.description) from my_unclrchqbd d left join my_head h on d.acno=h.doc_no where d.sr_no!=0 and d.rdocno=m.doc_no) reference from my_unclrchqbm m left join my_unclrchqbd d "
		        		+ "on (m.doc_no=d.rdocno and d.sr_no=0) left join my_unclrchqbd d1 on (m.doc_no=d1.rdocno and d1.sr_no=1) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='UCP'"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("UCR")){

		        	sql = "select m.doc_no,m.date,m.desc1 remarks,m.chqdt dates,m.chqno,if(d.amount<0,(d.amount*-1),d.amount) amount,if(d.lamount<0,(d.lamount*-1),d.lamount) localamount,t.description accountname,c.code currency,"
		        			+ "(select GROUP_CONCAT(h.description) from my_unclrchqreceiptd d left join my_head h on d.acno=h.doc_no where d.sr_no!=0 and d.rdocno=m.doc_no) reference from my_unclrchqreceiptm m left join my_unclrchqreceiptd d "
		        			+ "on (m.doc_no=d.rdocno and d.sr_no=0) left join my_unclrchqreceiptd d1 on (m.doc_no=d1.rdocno and d1.sr_no=1) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='UCR'"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("PRIV")){

		        	sql = "select t.description accountname,m.doc_no,m.date,concat(t.description,' [ ',m.desc1,' ] ') as remarks,t.description as reference,sum(coalesce(d.tax,0)) as taxtotal,sum(coalesce(d.nettotal,0))amount,sum(coalesce(d.nettaxamount,0))nettotal  from rl_prinvm m "
		        			+ "left join rl_prinvd d on m.doc_no=d.rdocno left join my_head t on m.acno=t.doc_no where m.status=3 "+sql+" group by m.doc_no";
		        }
		        
		        if(dtype.equalsIgnoreCase("MCP")){  

		        	sql = "SELECT m.doc_no,m.date,m.desc1 description,if(m.totalamount<0,(m.totalamount*-1),m.totalamount) amount,t.description accountname,c.code currency,"
		        			+ "(select GROUP_CONCAT(distinct h.description) from my_mcpbd d left join my_head h on d.acno=h.doc_no where  d.tr_no=m.tr_no)  reference FROM my_mcpbm m "
		        			+ "left join my_head t on m.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='"+dtype+"' "+sql+"";   
		        }
		        
		        //System.out.println("sqlllll======="+sql);
		    	ResultSet resultSet = stmtFinance.executeQuery(sql);
	        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
		        stmtFinance.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
        return RESULTDATA;
    }

	public JSONArray financeExcelExport(String branch,String fromdate,String todate,String accType,String accdocno,String dtype,String docRangeFrom,String docRangeTo,String amtRangeFrom,String amtRangeTo,String chk) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
		if(!(chk.equalsIgnoreCase("1"))){
        	
        	System.out.println("===CNO excel====");
      
			return RESULTDATA;
        }
		Connection conn = null;
		
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtFinance = conn.createStatement();
				String sql = "";

				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					if(!(dtype.equalsIgnoreCase("COT") || dtype.equalsIgnoreCase("SEC"))){
						sql+=" and d.brhId="+branch+"";
					}else {
						sql+=" and m.brhId="+branch+"";
					}
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			    }
		        
		        if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
		        	if(!(dtype.equalsIgnoreCase("COT") || dtype.equalsIgnoreCase("SEC") || dtype.equalsIgnoreCase("CNO") || dtype.equalsIgnoreCase("DNO") || dtype.equalsIgnoreCase("JVT"))){
		        		sql+=" and (d.acno="+accdocno+" or d1.acno="+accdocno+")";
					}else if(dtype.equalsIgnoreCase("SEC")){
		        		sql+=" and m.acno_to="+accdocno+"";
					}else if(dtype.equalsIgnoreCase("CNO") || dtype.equalsIgnoreCase("DNO") || dtype.equalsIgnoreCase("JVT")){
		        		sql+=" and d.acno="+accdocno+"";
					}else {
						if(!(accType.equalsIgnoreCase("GL"))){
							if(dtype.equalsIgnoreCase("BPV") || dtype.equalsIgnoreCase("BRV") || dtype.equalsIgnoreCase("IBP") || dtype.equalsIgnoreCase("IBR")){
								sql+=" and (d.acno="+accdocno+" or d1.acno="+accdocno+")";
							} else if(dtype.equalsIgnoreCase("CPV") || dtype.equalsIgnoreCase("CRV") || dtype.equalsIgnoreCase("ICPV") || dtype.equalsIgnoreCase("ICRV")){
								sql+=" and (d.acno="+accdocno+" or d1.acno="+accdocno+")";
							} else {
								sql+=" and m.acno="+accdocno+"";
							}
						} else {
							sql+=" and m.acno="+accdocno+"";
						}
					}
	            }
            	
		        if(!(((docRangeFrom.equalsIgnoreCase("")) && (docRangeTo.equalsIgnoreCase(""))) || ((docRangeFrom.equalsIgnoreCase("0")) && (docRangeTo.equalsIgnoreCase("0"))))){
		        	sql+=" and m.doc_no between "+docRangeFrom+" and "+docRangeTo+"";
		        }
		        
		        if(dtype.equalsIgnoreCase("JVT") || dtype.equalsIgnoreCase("IJV")){
		        	
		        	if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
			        	sql+=" and if(d.dramount<0,(d.dramount*-1),d.dramount) between "+amtRangeFrom+" and "+amtRangeTo+"";
			        }
		        	
		        } else if(dtype.equalsIgnoreCase("CNO") || dtype.equalsIgnoreCase("DNO")){
		        	
		        	if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
			        	sql+=" and if(m.dramount<0,(m.dramount*-1),m.dramount) between "+amtRangeFrom+" and "+amtRangeTo+"";
			        }
		        	
		        }else if(dtype.equalsIgnoreCase("COT")){
		        	
		        	if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
			        	sql+=" and if(m.dramount<0,(m.dramount*-1),m.dramount) between "+amtRangeFrom+" and "+amtRangeTo+"";
			        }
		        	
		        }else if(dtype.equalsIgnoreCase("SEC")){
		        	
		        	if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
			        	sql+=" and if(m.amount<0,(m.amount*-1),m.amount) between "+amtRangeFrom+" and "+amtRangeTo+"";
			        }
		        	
		        } else {
		        	if(!(((amtRangeFrom.equalsIgnoreCase("")) && (amtRangeTo.equalsIgnoreCase(""))) || ((amtRangeFrom.equalsIgnoreCase("0")) && (amtRangeTo.equalsIgnoreCase("0"))))){
			        	sql+=" and if(d.amount<0,(d.amount*-1),d.amount) between "+amtRangeFrom+" and "+amtRangeTo+"";
			        }
		        }
		        
		        
		        if(dtype.equalsIgnoreCase("CPV") || dtype.equalsIgnoreCase("CRV") || dtype.equalsIgnoreCase("ICPV") || dtype.equalsIgnoreCase("ICRV") || dtype.equalsIgnoreCase("PC")){

		        	sql = "SELECT m.doc_no 'Doc No',m.date 'Date',t.description 'Account',m.desc1 'Remarks',(select GROUP_CONCAT(h.description) from my_cashbd d left join my_head h on d.acno=h.doc_no where d.sr_no!=0 and d.tr_no=m.tr_no) 'Reference',"
		        		+ "if(d.amount<0,(d.amount*-1),d.amount) 'Amount',c.code 'Currency',if(d.lamount<0,(d.lamount*-1),d.lamount) 'Local Amount' FROM my_cashbm m left join "
						+ "my_cashbd d on (m.tr_no=d.tr_no and d.sr_no=0) left join my_cashbd d1 on (m.tr_no=d1.tr_no and d1.sr_no=1) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='"+dtype+"'"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("BPV") || dtype.equalsIgnoreCase("BRV") || dtype.equalsIgnoreCase("IBP") || dtype.equalsIgnoreCase("IBR")){

		        	sql = "SELECT m.doc_no 'Doc No',m.date 'Date',concat(t.description,' [ ',m.desc1,' ] ') as 'Remarks',(select GROUP_CONCAT(h.description) from my_chqbd d left join my_head h on d.acno=h.doc_no where d.sr_no!=0 and d.tr_no=m.tr_no) 'Reference',"
		        			+ "if(d.amount<0,(d.amount*-1),d.amount) 'Amount',c.code 'Currency',if(d.lamount<0,(d.lamount*-1),d.lamount) 'Local Amount',m.chqno 'Cheque No',m.chqdt 'Cheque Date' "
		        			+ "FROM my_chqbm m left join my_chqbd d on (m.tr_no=d.tr_no and d.sr_no=0) left join my_chqbd d1 on (m.tr_no=d1.tr_no and d1.sr_no=1) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='"+dtype+"'"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("CNO") || dtype.equalsIgnoreCase("DNO")){

		        	sql = "SELECT m.doc_no 'Doc No',m.date 'Date',t.description 'Account',h1.description 'Customer Name',m.description 'Remarks',mm.voc_no 'INV NO',mm.date 'INV DATE',m.refno 'Ref No',(select GROUP_CONCAT(h.description) from my_cnotd d left join my_head h on d.acno=h.doc_no where d.tr_no=m.tr_no) 'Reference',"
		        			+ "if(m.amount<0,(m.amount*-1),m.amount) 'Amount',c.code 'Currency',if((m.amount*d.rate)<0,(m.amount*d.rate*-1),(m.amount*d.rate)) localamount FROM my_cnot m left join my_cnotd d on "
		        			+ "(m.tr_no=d.tr_no and d.sr_no=1) left join my_head t on d.acno=t.doc_no left join gl_invm mm on (mm.doc_no=m.invno and m.invno!=0) left join my_curr c on t.curid=c.doc_no left join my_head h1 on h1.doc_no=m.acno where m.status=3  and m.dtype='"+dtype+"'"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("JVT") || dtype.equalsIgnoreCase("IJV")){ 

		        	sql = "SELECT m.doc_no 'Doc No',m.date 'Date',t.description 'Account',m.description 'Remarks',(select GROUP_CONCAT(h.description) from my_jvtran d left join my_head h on d.acno=h.doc_no where d.tr_no=m.tr_no) 'Reference',"
		        			+ "if(d.dramount<0,(d.dramount*-1),d.dramount) 'Amount',c.code 'Currency',if(d.ldramount<0,(d.ldramount*-1),d.ldramount) 'Local Amount' FROM my_jvma m left join my_jvtran d on "
		        			+ "(m.tr_no=d.tr_no  and d.ref_row=1) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='"+dtype+"'"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("COT")){

		        	sql = "select m.doc_no 'Doc No',m.date 'Date',concat(m.type,' To ',m.type_to) 'Trans. Type',t.description 'Account',m.description 'Remarks',t1.description 'Reference',if(m.dramount<0,(m.dramount*-1),m.dramount) 'Amount',c.code 'Curr',if(m.lamount<0,(m.lamount*-1),m.lamount) 'Local Amount',"
		        		+ "case when m.chqno='' then '' when m.chqno='0' then '' when m.chqno is null then '' else concat('No. : ',m.chqno,' Dated ',DATE_FORMAT(m.chqdt,'%m-%b-%Y')) END as 'Cheque' from my_contratrans m "
		        		+ "left join my_head t on m.acno=t.doc_no left join my_head t1 on m.acno_to=t1.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("SEC")){

		        	sql = "select m.doc_no 'Doc No',m.date 'Date',h.description 'Bank',m.chqno 'Cheque No',m.chqdt 'Cheque Date',h1.description 'Paid To',m.remarks 'Remarks',m.amount 'Amount' from my_secchq m left join my_head h on m.acno_from=h.doc_no left join my_head h1 on m.acno_to=h1.doc_no "
		        		+ "where m.status=3"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("FCR")){

		        	sql = "SELECT m.doc_no 'Doc No',m.date 'Date',t.description 'Account',m.desc1 'Remarks',if(d.amount<0,(d.amount*-1),d.amount) 'Amount',c.code 'Currency',if(d.lamount<0,(d.lamount*-1),d.lamount) 'Local Amount' FROM my_fuelcardbm m left join "  
		        		+ "my_fuelcardbd d on (m.tr_no=d.tr_no and d.sr_no=0) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='FCR'"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("UCP")){

		        	sql = "select m.doc_no 'Doc No',m.date 'Date',m.desc1 'Remarks',(select GROUP_CONCAT(h.description) from my_unclrchqbd d left join my_head h on d.acno=h.doc_no where d.sr_no!=0 and d.rdocno=m.doc_no) 'Reference',if(d.amount<0,(d.amount*-1),d.amount) 'Amount',c.code 'Currency',"
		        		+ "if(d.lamount<0,(d.lamount*-1),d.lamount) 'Local Amount',m.chqno 'Cheque No',m.chqdt 'Cheque Date' from my_unclrchqbm m left join my_unclrchqbd d on (m.doc_no=d.rdocno and d.sr_no=0) left join my_unclrchqbd d1 on (m.doc_no=d1.rdocno and d1.sr_no=1) left join "
		        		+ "my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='UCP'"+sql;
		        }
		        
		        if(dtype.equalsIgnoreCase("UCR")){

		        	sql = "select m.doc_no 'Doc No',m.date 'Date',m.desc1 'Remarks',(select GROUP_CONCAT(h.description) from my_unclrchqreceiptd d left join my_head h on d.acno=h.doc_no where d.sr_no!=0 and d.rdocno=m.doc_no) 'Reference',if(d.amount<0,(d.amount*-1),d.amount) 'Amount',c.code 'Currency',"
		        			+ "if(d.lamount<0,(d.lamount*-1),d.lamount) 'Local Amount',m.chqno 'Cheque No',m.chqdt 'Cheque Date' from my_unclrchqreceiptm m left join my_unclrchqreceiptd d "
		        			+ "on (m.doc_no=d.rdocno and d.sr_no=0) left join my_unclrchqreceiptd d1 on (m.doc_no=d1.rdocno and d1.sr_no=1) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype='UCR'"+sql;
		        }
		        ResultSet resultSet = stmtFinance.executeQuery(sql);
	        	RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
		        
		        stmtFinance.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
        return RESULTDATA;
    }
}
