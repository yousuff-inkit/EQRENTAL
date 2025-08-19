package com.dashboard.analysis.budgetvariance;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsBudgetVarianceDAO  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	public JSONArray budgetVarianceSumGridLoading(String branch,String fromdate,String todate,String type,String accdocno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement = conn.createStatement();
				String sql1="",sql2="";
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
			String sql = " select act.months, act.year, inc,  actincome, inc - actincome varincome, exp, actexpense ,exp- actexpense varexp  ,"
					+ " inc-exp bporfit,actincome-actexpense profit,(inc-exp)-(actincome-actexpense) vprofit from  "
					+ " (select yeaR,MONTH,SUM(IF(GRTYPE=5,AMOUNT,0)) inc, SUM(IF(GRTYPE=4,AMOUNT,0)) exp from my_budgetdetail group  by yeaR,MONTH) bud" 
					+ " left join  (select month(j.date) month,year(j.date) year,DATE_FORMAT(LAST_DAY(date(j.date)),'%b %Y') months,acno, sum(if(gr_type=5,dramount,0)) actincome,"
					+ " sum(if(gr_type=4,dramount,0)) actexpense  from my_jvtran j left join my_head m on m.doc_no=j.acno where j.date between '"+sqlFromDate+"' and  '"+sqlToDate+"' "
				    + "group by year(j.date),month(j.date)) act  on bud.month=act.month and bud.year=act.year where  bud.month=act.month and bud.year=act.year";
			
                //System.out.println("-----summarysql-----"+sql); 
				ResultSet resultSet = stmtAccountStatement.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtAccountStatement.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	public JSONArray budgetVarianceGridLoading(String branch,String fromdate,String todate,String type,String accdocno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement = conn.createStatement();
				String sql1="",sql2="";
				
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql1+=" and j.brhId="+branch+"";
	    			sql2+=" and d.brhId="+branch+"";
	    		}
				
				if(!((accdocno.equalsIgnoreCase("")) || (accdocno.equalsIgnoreCase("0")))){
					sql1+=" and j.acno="+accdocno+"";
	    			sql2+=" and d.acno="+accdocno+"";
		        }
				
				if(type.equalsIgnoreCase("4")){
	    			sql1+=" and h.gr_type=4";
	    			sql2+=" and h.gr_type=4";
	    		} else if(type.equalsIgnoreCase("5")){
	    			sql1+=" and h.gr_type=5";
	    			sql2+=" and h.gr_type=5";
	    		} else {
	    			sql1+=" and h.gr_type in (4,5)";
	    			sql2+=" and h.gr_type in (4,5)";
	    		}
            		
			/*	String sql = "select a.account,a.description accountname,a.acno,CONVERT(if(sum(a.budget)=0,' ',round(sum(a.budget),2)),CHAR(100)) budgetamount,CONVERT(if(sum(a.actualamount)=0,' ',round(sum(a.actualamount),2)),CHAR(100)) actualamount,"
					+ "CONVERT(if((sum(a.budget)-sum(a.actualamount))=0,' ',((round(sum(a.budget),2))-round(sum(a.actualamount),2))),CHAR(100)) varianceamount from ( select h.account,h.description,j.acno,0 budget,j.ldramount actualamount,"
					+ "h.gr_type from my_jvtran j left join my_head h on j.acno=h.doc_no where j.status=3 and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql1+" UNION ALL select h.account,h.description,d.acno,d.amount budget,"
					+ "0 actualamount,h.gr_type from my_budgetm m left join my_budgetd d on m.doc_no=d.rdocno left join my_head h on d.acno=h.doc_no where m.status=3 and d.date>='"+sqlFromDate+"' and d.date<='"+sqlToDate+"'"+sql2+") a " 
					+ "group by a.acno order by a.gr_type";
				*/
				String sql="select gr_type,a.account,a.description accountname,a.acno,CONVERT(if(sum(a.budget)=0,' ',round(sum(a.budget),2)),CHAR(100))"
						+ " budgetamount,CONVERT(if(sum(a.actualamount)=0,' ',round(sum(a.actualamount),2)),CHAR(100)) actualamount,"
						+ " CONVERT(if((sum(a.budget)-sum(a.actualamount))=0,' ',((round(sum(a.budget),2))-round(sum(a.actualamount),2))),CHAR(100))"
						+ " varianceamount from (select h.account,h.description,j.acno,0 budget,j.ldramount*-1 actualamount,h.gr_type from my_jvtran j"
						+ " left join my_head h on j.acno=h.doc_no where j.status=3 and j.date>='2018-01-01' and j.date<='2018-09-01' and j.brhId=1 and h.gr_type in (4,5) UNION ALL"
						+ " select h.account,h.description,d.acno,d.amount budget,0 actualamount,h.gr_type from my_budgetm m"
						+ " left join my_budgetdetail d on m.doc_no=d.rdocno left join my_head h on d.acno=h.doc_no where m.status=3"
						+ " and d.month=month('2018-08-01') and d.year=year('2018-08-01')  and h.gr_type in (4,5)) a group by a.acno"
						+ " union all select gr_type,999999 account,if(gr_type=5,'INCOME','EXPENSE') accountname,b.acno,CONVERT(if(sum(b.budget)=0,' ',"
						+ " round(sum(b.budget),2)),CHAR(100)) budgetamount,CONVERT(if(sum(b.actualamount)=0,' ',round(sum(b.actualamount),2)),CHAR(100))"
						+ " actualamount,CONVERT(if((sum(b.budget)-sum(b.actualamount))=0,' ', ((round(sum(b.budget),2))-round(sum(b.actualamount),2))),"
						+ " CHAR(100)) varianceamount from (select h.account,h.description,j.acno,0 budget,j.ldramount*-1 actualamount,h.gr_type from my_jvtran j"
						+ " left join my_head h on j.acno=h.doc_no where j.status=3 and j.date>='2018-01-01' and j.date<='2018-09-01' and j.brhId=1 and"
						+ " h.gr_type in (4,5) UNION ALL select h.account,h.description,d.acno,d.amount budget,0 actualamount,h.gr_type from my_budgetm m"
						+ " left join my_budgetdetail d on m.doc_no=d.rdocno left join my_head h on d.acno=h.doc_no where m.status=3 and"
						+ " d.month=month('2018-08-01') and d.year=year('2018-08-01')  and h.gr_type in (4,5)) b group by b.gr_type order by gr_type,account";
                
				//System.out.println("detailsql--------->>>"+sql);     
				ResultSet resultSet = stmtAccountStatement.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtAccountStatement.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray budgetVariancSumExcelExport(String branch,String fromdate,String todate,String type,String accdocno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;  
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtAccountStatement = conn.createStatement();
			String sql1="",sql2="";
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
            }
			
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			}
			
		String sql = " select act.months 'Month', inc 'Budget Income',  actincome 'Actual Income', inc - actincome 'Variance Income', exp 'Expenditure', actexpense 'Actual Expenditure',exp- actexpense 'Variance Expenditure',"
				+ " inc-exp 'Budget Profit',actincome-actexpense 'Profit',(inc-exp)-(actincome-actexpense) 'Variance Profit' from  "
				+ " (select yeaR,MONTH,SUM(IF(GRTYPE=5,AMOUNT,0)) inc, SUM(IF(GRTYPE=4,AMOUNT,0)) exp from my_budgetdetail group  by yeaR,MONTH) bud" 
				+ " left join  (select month(j.date) month,year(j.date) year,DATE_FORMAT(LAST_DAY(date(j.date)),'%b %Y') months,acno, sum(if(gr_type=5,dramount,0)) actincome,"
				+ " sum(if(gr_type=4,dramount,0)) actexpense  from my_jvtran j left join my_head m on m.doc_no=j.acno where j.date between '"+sqlFromDate+"' and  '"+sqlToDate+"' "
			    + "group by year(j.date),month(j.date)) act  on bud.month=act.month and bud.year=act.year where  bud.month=act.month and bud.year=act.year";
		
              //System.out.println("-----summaryExcelsql-----"+sql); 
			ResultSet resultSet = stmtAccountStatement.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				stmtAccountStatement.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray budgetVarianceExcelExport(String branch,String fromdate,String todate,String type,String accdocno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement = conn.createStatement();
				String sql1="",sql2="";
				
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql1+=" and j.brhId="+branch+"";
	    			sql2+=" and d.brhId="+branch+"";
	    		}
				
				if(!((accdocno.equalsIgnoreCase("")) || (accdocno.equalsIgnoreCase("0")))){
					sql1+=" and j.acno="+accdocno+"";
	    			sql2+=" and d.acno="+accdocno+"";
		        }
				
				if(type.equalsIgnoreCase("4")){
	    			sql1+=" and h.gr_type=4";
	    			sql2+=" and h.gr_type=4";
	    		} else if(type.equalsIgnoreCase("5")){
	    			sql1+=" and h.gr_type=5";
	    			sql2+=" and h.gr_type=5";
	    		} else {
	    			sql1+=" and h.gr_type in (4,5)";
	    			sql2+=" and h.gr_type in (4,5)";
	    		}
            		
				/*String sql = "select a.account 'Account',a.description 'Account Name',CONVERT(if(sum(a.budget)=0,' ',round(sum(a.budget),2)),CHAR(100)) 'Forecast',CONVERT(if(sum(a.actualamount)=0,' ',round(sum(a.actualamount),2)),CHAR(100)) 'Actual',"
					+ "CONVERT(if((sum(a.budget)-sum(a.actualamount))=0,' ',((round(sum(a.budget),2))-round(sum(a.actualamount),2))),CHAR(100)) 'Variance' from ( select h.account,h.description,j.acno,0 budget,j.ldramount actualamount,"
					+ "h.gr_type from my_jvtran j left join my_head h on j.acno=h.doc_no where j.status=3 and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql1+" UNION ALL select h.account,h.description,d.acno,d.amount budget,"
					+ "0 actualamount,h.gr_type from my_budgetm m left join my_budgetd d on m.doc_no=d.rdocno left join my_head h on d.acno=h.doc_no where m.status=3 and d.date>='"+sqlFromDate+"' and d.date<='"+sqlToDate+"'"+sql2+") a " 
					+ "group by a.acno order by a.gr_type";
*/
			String sql="select kk.account 'Account',kk.description 'Account Name',kk.budgetamount 'Forecast',kk.actualamount 'Actual',kk.varianceamount 'Variance' from "
						+ " (select gr_type,a.account,a.description,a.acno,CONVERT(if(sum(a.budget)=0,' ',round(sum(a.budget),2)),CHAR(100))"
						+ " budgetamount,CONVERT(if(sum(a.actualamount)=0,' ',round(sum(a.actualamount),2)),CHAR(100)) actualamount,"
						+ " CONVERT(if((sum(a.budget)-sum(a.actualamount))=0,' ',((round(sum(a.budget),2))-round(sum(a.actualamount),2))),CHAR(100))"
						+ " varianceamount from (select h.account,h.description,j.acno,0 budget,j.ldramount*-1 actualamount,h.gr_type from my_jvtran j"
						+ " left join my_head h on j.acno=h.doc_no where j.status=3 and j.date>='2018-01-01' and j.date<='2018-09-01' and j.brhId=1 and h.gr_type in (4,5) UNION ALL"
						+ " select h.account,h.description,d.acno,d.amount budget,0 actualamount,h.gr_type from my_budgetm m"
						+ " left join my_budgetdetail d on m.doc_no=d.rdocno left join my_head h on d.acno=h.doc_no where m.status=3"
						+ " and d.month=month('2018-08-01') and d.year=year('2018-08-01')  and h.gr_type in (4,5)) a group by a.acno"
						+ " union all select gr_type,999999 account,if(gr_type=5,'INCOME','EXPENSE') accountname,b.acno,CONVERT(if(sum(b.budget)=0,' ',"
						+ " round(sum(b.budget),2)),CHAR(100)) budgetamount,CONVERT(if(sum(b.actualamount)=0,' ',round(sum(b.actualamount),2)),CHAR(100))"
						+ " actualamount,CONVERT(if((sum(b.budget)-sum(b.actualamount))=0,' ', ((round(sum(b.budget),2))-round(sum(b.actualamount),2))),"
						+ " CHAR(100)) varianceamount from (select h.account,h.description,j.acno,0 budget,j.ldramount*-1 actualamount,h.gr_type from my_jvtran j"
						+ " left join my_head h on j.acno=h.doc_no where j.status=3 and j.date>='2018-01-01' and j.date<='2018-09-01' and j.brhId=1 and"
						+ " h.gr_type in (4,5) UNION ALL select h.account,h.description,d.acno,d.amount budget,0 actualamount,h.gr_type from my_budgetm m"
						+ " left join my_budgetdetail d on m.doc_no=d.rdocno left join my_head h on d.acno=h.doc_no where m.status=3 and"
						+ " d.month=month('2018-08-01') and d.year=year('2018-08-01')  and h.gr_type in (4,5)) b group by b.gr_type order by gr_type,account)kk";
                
				
				//System.out.println("detailExcelsql--------->>>"+sql);
				ResultSet resultSet = stmtAccountStatement.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				stmtAccountStatement.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountDetails(String type,String account,String partyname,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    String sql = null;
	    	    String sql1 = "";
	    	    
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement1 = conn.createStatement();

				if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql1=sql1+" and t.account like '%"+account+"%'";
	            }
	            
				if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
	             sql1=sql1+" and t.description like '%"+partyname+"%'";
	            }
	            
				if(type.equalsIgnoreCase("4") || type.equalsIgnoreCase("5")){
					sql = "select t.doc_no,t.account,t.description,c.code curr from my_head t left join my_curr c on t.curid=c.doc_no where t.gr_type='"+type+"'"+sql1;
				}
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet1 = stmtAccountStatement1.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				else{
					stmtAccountStatement1.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtAccountStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
}
