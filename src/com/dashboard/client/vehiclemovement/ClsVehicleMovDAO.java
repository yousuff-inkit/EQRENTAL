package com.dashboard.client.vehiclemovement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.client.vehiclemovement.ClsVehicleMovBean;

public class ClsVehicleMovDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray clientsearchmove() throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		        
	        Connection conn =null;
			try {
					conn=ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
			
	            		
            		String sql= "select ac.refname refname,ac.cldocno, convert(concat('Code :',ac.cldocno,'*',ac.refname,'*','A/c :',"
            				+ "head.description, '*','Mobile :',coalesce(ac.per_mob,ac.com_mob),'*','Mail :',ac.mail1),char(1000)) clientinfo  "
            				+ "from my_acbook ac left join my_head head on ac.acno=head.doc_no where ac.dtype='CRM' and ac.status='3';";
            		
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
	
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;	
	
	
	}
	
	
	
	public JSONArray clientMovSearch(String client, String fromdate, String todate, String ready) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();

        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

       
     	
     	Connection conn=null;
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
         if(ready.equalsIgnoreCase("ready"))
         {
        	 
        	 
        	 String sql="select vm.reg_no,if(v.rdtype='','',v.rdtype) rdtype,CONVERT(coalesce(v.rdocno,''),char(15)) rdocno ,coalesce(vm.flname,'') flname ,coalesce(v.status,'') "+
        	 " status,coalesce(s.st_desc,'') trancode,CONVERT(coalesce(v.obrhid,''),char(15)) obrhid,CONVERT(coalesce(v.dout,''),char(20)) dout,coalesce(v.tout,'') tout,"+
        	 " CONVERT(coalesce(round(v.kmout),''),char(30)) kmout,CASE  WHEN coalesce(v.fout,'')='' THEN '' WHEN v.fout='0.000' THEN 'Level 0/8'  WHEN v.fout='0.125' THEN "+
        	 " 'Level 1/8' WHEN v.fout='0.250' THEN 'Level 2/8' WHEN v.fout='0.375'   	THEN 'Level 3/8' WHEN v.fout='0.500' THEN 'Level 4/8' WHEN v.fout='0.625' THEN "+
        	 " 'Level 5/8' WHEN v.fout='0.750' THEN 'Level 6/8'   WHEN v.fout='0.875' THEN 'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8' END as 'Fout' ,"+
        	 " CONVERT(coalesce(v.ibrhid,''),char(15)) ibrhid,CONVERT(coalesce(v.din,''),char(15)) din,coalesce(v.tin,'') tin,CONVERT(coalesce(round(kmin),''),char(30))"+
        	 " kmin,CASE  WHEN coalesce(v.fin,'')='' THEN '' WHEN v.fin='0.000' THEN 'Level 0/8'  WHEN v.fin='0.125'"+
        	 " THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' WHEN v.fin='0.375' 	THEN 'Level 3/8' WHEN v.fin='0.500'"+
        	 " THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' WHEN v.fin='0.750'  THEN 'Level 6/8' WHEN v.fin='0.875'"+
        	 " THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8' END as 'FIN'  from gl_vmove v left join gl_status s"+
        	 " on(v.trancode=s.status) left join gl_vehmaster vm on (vm.fleet_no=v.fleet_no)"+
        	 " where v.emp_id="+client+" and emp_type='CRM' ORDER BY v.doc_no DESC   limit 15";
        
         		ResultSet resultSet = stmtVeh.executeQuery(sql);
         		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
  				stmtVeh.close();
  				conn.close(); 
        	 
        	 
         }
				
         else
         {
				
				String sql="select vm.reg_no,if(v.rdtype='','',v.rdtype) rdtype,CONVERT(coalesce(v.rdocno,''),char(15)) rdocno ,coalesce(vm.flname,'') flname , v.date date, v.repno repno, coalesce(v.status,'') status, "
						+ "coalesce(s.st_desc,'') trancode,CONVERT(coalesce(v.obrhid,''),char(15)) obrhid,CONVERT(coalesce(v.dout,''),char(20)) dout,coalesce(v.tout,'') tout,CONVERT(coalesce(round(v.kmout),''),char(30)) kmout, "
						+ "CASE  WHEN coalesce(v.fout,'')='' THEN '' WHEN v.fout='0.000' THEN 'Level 0/8'  WHEN v.fout='0.125' THEN 'Level 1/8' WHEN v.fout='0.250'  "
						+ "THEN 'Level 2/8' WHEN v.fout='0.375'   	THEN 'Level 3/8' WHEN v.fout='0.500' THEN 'Level 4/8' WHEN v.fout='0.625' THEN 'Level 5/8' "
						+ "	WHEN v.fout='0.750' THEN 'Level 6/8'   WHEN v.fout='0.875' THEN 'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8' "
						+ "   END as 'Fout' ,CONVERT(coalesce(v.ibrhid,''),char(15)) ibrhid,CONVERT(coalesce(v.din,''),char(15)) din,coalesce(v.tin,'') tin,CONVERT(coalesce(round(kmin),''),char(30)) kmin, "
						+ "   CASE  WHEN coalesce(v.fin,'')='' THEN '' WHEN v.fin='0.000' THEN 'Level 0/8'  WHEN v.fin='0.125' "
						+ "   THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' WHEN v.fin='0.375' 	THEN 'Level 3/8' WHEN v.fin='0.500' "
						+ "   THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' WHEN v.fin='0.750'  THEN 'Level 6/8' WHEN v.fin='0.875' "
						+ "   THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8' END as 'FIN'  from gl_vmove v left join gl_status s "
						+ "   on(v.trancode=s.status) left join gl_vehmaster vm on (vm.fleet_no=v.fleet_no) "
						+ "where v.emp_id="+client+" and emp_type='CRM' and  v.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' order by v.doc_no desc ";
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		 
            	
            		 
     				stmtVeh.close();
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
		//System.out.println(RESULTDATA);
        return RESULTDATA;
		
	}
	
	
	public JSONArray vehicleSummary(String client, String fromdate, String todate) throws SQLException{
		
		 JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
			try {
					conn=ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
					  java.sql.Date sqlfromdate = null;
				     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
				     	{
				     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				     		
				     	}
				     	else{
				     
				     	}

				        java.sql.Date sqltodate = null;
				     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
				     	{
				     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				     		
				     	}
				     	else{
				     
				     	}
	            		
	            		String sql="select convert(sum(aa.hourdiff),char(1000)) hourdiff,aa.trancode,convert(aa.st_desc,char(1000)) st_desc,aa.rdtype,convert(sum(aa.tfuel),char(1000)) tfuel,convert(sum(aa.tkm),char(1000)) tkm from("+
	            				" select (TIMESTAMPDIFF(second,dout ,din))/(60*60) hourdiff,kk.st_desc,kk.rdtype,kk.tfuel,kk.tkm,kk.trancode from("+
	            				" select st.st_desc,trancode,rdtype,coalesce(tfuel,0) tfuel,coalesce(tkm,0) tkm,if(dout<'"+sqlfromdate+"',cast(concat('"+sqlfromdate+" 00:00:00') "+
	            				" as datetime),cast(concat(dout,' ',tout) as datetime))dout,tout,if(din>'"+sqltodate+"',cast(concat('"+sqltodate+" 23:59:59') as datetime),"+
	            				" cast(coalesce(concat(din,' ',tin),'"+sqltodate+" 23:59:59') as datetime)) din,tin from gl_vmove mov left join gl_status st on "+
	            				" mov.trancode=st.status where mov.emp_id="+client+" and mov.emp_type='CRM' and (dout between '"+sqlfromdate+"' and '"+sqltodate+"' or "+
	            				" coalesce(din,'"+sqltodate+"')between '"+sqlfromdate+"' and '"+sqltodate+"'))kk)aa group by aa.rdtype,aa.trancode";
	            	
//	            		System.out.println("Summary query:"+sql);
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	            		stmtVeh.close();
	     				conn.close();
	            	
	          

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
//			System.out.println(RESULTDATA);
	        return RESULTDATA;
		
		
	}
	
	
	
	
	
	
	
	
	
	public ClsVehicleMovBean getPrint(HttpServletRequest request,String client,String fromdate,String todate) throws SQLException {
		
		ClsVehicleMovBean bean = new ClsVehicleMovBean();
		
		Connection conn = null;

		String sql="",sql1 = "",sql2 = "",sql3 = "";
		
		
		java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

      	try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				
				
				sql="select 'Vehicle Movement' vouchername,CONCAT('From ',DATE_FORMAT('"+sqlfromdate+"','%D %M  %Y '),'  To  ',DATE_FORMAT('"+sqltodate+"','%D %M  %Y ')) vouchername1,"
						+ "c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_rentreceipt r inner join my_brch b on r.brhid=b.doc_no inner join my_comp c "
						+ "on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc "
						+ "on(lc.loc=l.loc and lc.brhid=b.doc_no) where 1=1  group by r.brhid";
					
					ResultSet resultSet = stmtVeh.executeQuery(sql);
					
					while(resultSet.next()){
						bean.setLblcompname(resultSet.getString("company"));
						bean.setLblcompaddress(resultSet.getString("address"));
						bean.setLblprintname(resultSet.getString("vouchername"));
						bean.setLblprintname1(resultSet.getString("vouchername1"));
						bean.setLblcomptel(resultSet.getString("tel"));
						bean.setLblcompfax(resultSet.getString("fax"));
						bean.setLblbranch(resultSet.getString("branchname"));
						bean.setLbllocation(resultSet.getString("location"));
						bean.setLblcstno(resultSet.getString("cstno"));
						bean.setLblpan(resultSet.getString("pbno"));
						bean.setLblservicetax(resultSet.getString("stcno"));
					}
				 sql2="select ac.cldocno,ac.refname refname,ac.mail1,"+
            				" coalesce(ac.per_mob,ac.com_mob) mobile"+
            				" from my_acbook ac where ac.cldocno="+client+" and ac.dtype='CRM' and ac.status=3";
				 
				 
				 
            		
            		ResultSet resultSet2 = stmtVeh.executeQuery(sql2);
            		while(resultSet2.next()){
            			
            		bean.setLblcode(resultSet2.getString("cldocno"));
					bean.setLblname(resultSet2.getString("refname"));
					bean.setLblmobno(resultSet2.getString("mobile"));
					bean.setLblmail(resultSet2.getString("mail1"));
					
            		}
            		
            		
			 sql1="select vm.reg_no,if(v.rdtype='','',v.rdtype) rdtype,CONVERT(coalesce(v.rdocno,''),char(15)) rdocno ,coalesce(vm.flname,'') flname , v.date date, v.repno repno,coalesce(v.status,'') status, "
						+ "coalesce(s.st_desc,'') trancode,CONVERT(coalesce(v.obrhid,''),char(15)) obrhid,CONVERT(coalesce(v.dout,''),char(20)) dout,coalesce(v.tout,'') tout,CONVERT(coalesce(round(v.kmout),''),char(30)) kmout, "
						+ "CASE  WHEN coalesce(v.fout,'')='' THEN '' WHEN v.fout='0.000' THEN 'Level 0/8'  WHEN v.fout='0.125' THEN 'Level 1/8' WHEN v.fout='0.250'  "
						+ "THEN 'Level 2/8' WHEN v.fout='0.375'   	THEN 'Level 3/8' WHEN v.fout='0.500' THEN 'Level 4/8' WHEN v.fout='0.625' THEN 'Level 5/8' "
						+ "	WHEN v.fout='0.750' THEN 'Level 6/8'   WHEN v.fout='0.875' THEN 'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8' "
						+ "   END as 'Fout' ,CONVERT(coalesce(v.ibrhid,''),char(15)) ibrhid,CONVERT(coalesce(v.din,''),char(15)) din,coalesce(v.tin,'') tin,CONVERT(coalesce(round(kmin),''),char(30)) kmin, "
						+ "   CASE  WHEN coalesce(v.fin,'')='' THEN '' WHEN v.fin='0.000' THEN 'Level 0/8'  WHEN v.fin='0.125' "
						+ "   THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' WHEN v.fin='0.375' 	THEN 'Level 3/8' WHEN v.fin='0.500' "
						+ "   THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' WHEN v.fin='0.750'  THEN 'Level 6/8' WHEN v.fin='0.875' "
						+ "   THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8' END as 'FIN'  from gl_vmove v left join gl_status s "
						+ "   on(v.trancode=s.status) left join gl_vehmaster vm on (vm.fleet_no=v.fleet_no) "
						+ "where v.emp_id="+client+" and emp_type='CRM' and  v.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' order by v.doc_no desc ";
				ResultSet resultSet1 = stmtVeh.executeQuery(sql1);
            		// RESULTDATA=ClsCommon.convertToJSON(resultSet);
       	
		ArrayList<String> printarray= new ArrayList<String>();
		
		while(resultSet1.next()){

			String temp="";
			temp=resultSet1.getString("rdtype")+"::"+resultSet1.getString("rdocno")+"::"+resultSet1.getString("flname")+"::"+resultSet1.getString("reg_no")+"::"+resultSet1.getString("date")+"::"+resultSet1.getString("repno")+"::"+resultSet1.getString("status")+"::"+resultSet1.getString("trancode")+"::"+resultSet1.getString("obrhid")+"::"+resultSet1.getString("dout")+"::"+resultSet1.getString("tout")+"::"+resultSet1.getString("kmout")+"::"+resultSet1.getString("fout")+"::"+resultSet1.getString("ibrhid")+"::"+resultSet1.getString("din")+"::"+resultSet1.getString("tin")+"::"+resultSet1.getString("kmin")+"::"+resultSet1.getString("fin")+"::"+resultSet1.getString("rdocno");
		    printarray.add(temp);
		    
		    
		}
		request.setAttribute("printingarray", printarray);
		
		sql3="select convert(sum(aa.hourdiff),char(1000)) hourdiff,aa.trancode,convert(aa.st_desc,char(1000)) st_desc,aa.rdtype,convert(sum(aa.tfuel),char(1000)) tfuel,convert(sum(aa.tkm),char(1000)) tkm from("+
				" select (TIMESTAMPDIFF(second,dout ,din))/(60*60) hourdiff,kk.st_desc,kk.rdtype,kk.tfuel,kk.tkm,kk.trancode from("+
				" select st.st_desc,trancode,rdtype,coalesce(tfuel,0) tfuel,coalesce(tkm,0) tkm,if(dout<'"+sqlfromdate+"',cast(concat('"+sqlfromdate+" 00:00:00') "+
				" as datetime),cast(concat(dout,' ',tout) as datetime))dout,tout,if(din>'"+sqltodate+"',cast(concat('"+sqltodate+" 23:59:59') as datetime),"+
				" cast(coalesce(concat(din,' ',tin),'"+sqltodate+" 23:59:59') as datetime)) din,tin from gl_vmove mov left join gl_status st on "+
				" mov.trancode=st.status where mov.emp_id="+client+" and mov.emp_type='CRM' and (dout between '"+sqlfromdate+"' and '"+sqltodate+"' or "+
				" coalesce(din,'"+sqltodate+"')between '"+sqlfromdate+"' and '"+sqltodate+"'))kk)aa group by aa.rdtype,aa.trancode";
	
		ResultSet resultSet3 = stmtVeh.executeQuery(sql3);
	
		ArrayList<String> vehsumarray= new ArrayList<String>();
		
		while(resultSet3.next()){

			String temp3="";
			temp3=resultSet3.getString("rdtype")+"::"+resultSet3.getString("st_desc")+"::"+resultSet3.getString("hourdiff")+"::"+resultSet3.getString("tfuel")+"::"+resultSet3.getString("tkm");
			vehsumarray.add(temp3);
		}
		request.setAttribute("vehsumarray", vehsumarray);
				
		stmtVeh.close();
		conn.close();
	}catch(Exception e){
		 e.printStackTrace();
		 conn.close();
	}finally{
		conn.close();
	}
	return bean;
   }
	

}
