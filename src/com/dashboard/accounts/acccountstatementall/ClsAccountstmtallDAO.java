package com.dashboard.accounts.acccountstatementall;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAccountstmtallDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	
	public JSONArray accountsStatement(String fromdate,String todate,String type,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
        
       if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				String sqltest="",sql = "";String joins="";String casestatement="",openingsql="";
			
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = cmn.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = cmn.changeStringtoSqlDate(todate);
				}
				
				if(!(type.equalsIgnoreCase("")) && !(type.equalsIgnoreCase(null))){
		       		sqltest+="where a.acctype='"+type+"' ";
		       		  
				}
				//opn bal query
				
				
				/* openingsql="union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate," 
					  		+"'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType "  
					  		+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') "
					  		+ "or (t.date< '"+sqlFromDate+"')) "+ sql +" group by t.acno,t.curId ";
					  System.out.println("sqlloadquery1========="+openingsql);    
					  */
				
				
				joins=cmn.getFinanceVocTablesJoins(conn);
				casestatement=cmn.getFinanceVocTablesCase(conn);  
				
				sql = "select b.username,b.accno,b.accname,b.acctype,date_format(b.trdate,'%d.%m.%Y') trdate,b.brhid,b.transtype,b.description,b.ref_detail,b.tr_no,b. curId,b.currency,b.dramount,b.dr,b.cr,b.ldramount,b.debit,b.credit,convert(b.rate,char)rate,b.account,b.accountname,b.grpno,b.alevel,b.acno,b.nettotal,convert(b.transno,char)transno,b.branchname,b.balance from(select * from(select b.*,coalesce(round(@i:=@i+nettotal,2),0) balance,'First' type from ( select u.user_name username,a.accno,a.accname,a.acctype,a.trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, a.currency, a.dramount, a.dr, a.cr, a.ldramount,"  
                        + "a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),2) nettotal,"+casestatement+"b.branchname from (select date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
                        + "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
                        + "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno,h.atype acctype,h.account accno,h.description accname  from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
                        + "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
                        + "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.yrid=0  )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
                        + "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join datalog dl on (a.transno=dl.doc_no and a.brhid=dl.brhid and a.transType=dl.dtype and dl.entry='A') left join my_user u on u.doc_no=dl.userid  "+joins+" "+sqltest+"  order by a.accno,a.trdate) b,(select @i:=0) as i)a UNION ALL select ''username,accno,accname,'' acctype,'' trdate,'' brhid,'' transtype,'TOTAL:' description,'' ref_detail,'' tr_no,'' curId,'' currency,'' dramount,SUM(dr) dr, SUM(cr) cr,'' ldramount, SUM(debit) debit, SUM(credit) credit,'' rate,'' account,'' accountname,'' grpno,'' alevel,'' acno,'' nettotal,'' transno,'' branchname,'' balance,'Last' type  from (select u.user_name username,a.accno,a.accname,a.acctype,a.trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, a.currency, a.dramount, a.dr, a.cr, a.ldramount,"  
                        + "a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),2) nettotal,"+casestatement+"b.branchname from (select date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
                        + "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
                        + "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno,h.atype acctype,h.account accno,h.description accname  from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
                        + "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
                        + "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.yrid=0  )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
                        + "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join datalog dl on (a.transno=dl.doc_no and a.brhid=dl.brhid and a.transType=dl.dtype and dl.entry='A') left join my_user u on u.doc_no=dl.userid "+joins+" "+sqltest+"  order by a.accno,a.trdate) b GROUP BY accno order by accno)b order by accno,type";
    		//	System.out.println("sqlloadquery2========="+sql);
				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);
				RESULTDATA=cmn.convertToJSON(resultSet);
				
				
				stmtAccountStatement2.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	

}
