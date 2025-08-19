package com.operations.marketing.leasecalculatoralmariah;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.marketing.leasecalculator.ClsLeaseCalculatorBean;

public class ClsLeaseCalcAlMariahDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	 public JSONArray getReqSearchData(String reqbranch,String reqdocno,String reqname,String reqmob,String reqdate,String reqtype,String id) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
	        String sqltest="";
	        java.sql.Date sqldate=null;
	        
			try {
					conn = objconn.getMyConnection();
					Statement stmt=conn.createStatement();
					if(!reqdate.equalsIgnoreCase("")){
						sqldate=objcommon.changeStringtoSqlDate(reqdate);
					}
					if(!reqbranch.equalsIgnoreCase("")){
						sqltest+=" and req.brhid="+reqbranch;
					}
					if(!reqdocno.equalsIgnoreCase("")){
						sqltest+=" and req.voc_no like "+reqdocno;
					}
					if(!reqname.equalsIgnoreCase("")){
						sqltest+=" and if(req.reqtype=1,ac.refname like '%"+reqname+"%',req.name like '%"+reqname+"%')";
					}
					if(!reqmob.equalsIgnoreCase("")){
						sqltest+=" and if(req.reqtype=1,ac.com_mob like '%"+reqmob+"%',req.mob like '%"+reqmob+"%')";
					}
					if(sqldate!=null){
						sqltest+=" and req.date='"+sqldate+"'";
					}
					if(!reqtype.equalsIgnoreCase("")){
						sqltest+=" and req.reqtype="+reqtype;
					}
					String strsql="select req.voc_no,req.doc_no,req.date,req.remarks,if(req.reqtype=1,ac.cldocno,req.cldocno) cldocno,if(req.reqtype=1,ac.refname,req.name) "+
					" name,if(req.reqtype=1,ac.address,req.com_add1) address,if(req.reqtype=1,ac.com_mob,req.mob) mobile,if(req.reqtype=1,ac.mail1,req.email)"+
					" email,req.reqtype from gl_lprm req left join my_acbook ac on (req.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_almariahleasecalcm m on "+
					" (req.doc_no=m.reqdoc) where req.status=3  and m.reqdoc is null"+sqltest;
					System.out.println(strsql);
					ResultSet resultSet = stmt.executeQuery(strsql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					
					stmt.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	 
	 public JSONArray getRequestData(String reqdocno,String id,String docno) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(reqdocno.equalsIgnoreCase("0") || reqdocno.equalsIgnoreCase("")){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
			try {
					conn = objconn.getMyConnection();
					Statement stmt=conn.createStatement();
					String strsql="";
					System.out.println("Inside Request Function");
					if(id.equalsIgnoreCase("1")){
						strsql="select 'Load' loadgrid,1 fsavestatus,confirmstatus,savestatus,0 rowcolor,req.leasereqdocno,lcg.doc_no grpid,grp.gname,req.sr_no srno,brd.brand_name brand,model.vtype model,brd.doc_no brdid,model.doc_no modelid,"
							+" req.leasemonths,req.kmpermonth,req.driver,req.security_pass,req.fuel,req.salik,req.safety_acsrs safetyaccessories,req.leasefromdate,req.ddiw,req.dhpd,req.rateperexhour,req.exkmcharge,req.ratepermonth,'Quotation' quotbtn"
							+" from gl_almariahleasecalcreq req left join gl_vehbrand brd on req.brdid=brd.doc_no"
							+" left join gl_vehmodel model on req.modid=model.doc_no"
							+" left join gl_lcgm lcg on (req.brdid=req.brdid and req.modid=lcg.modid)"
							+" left join gl_vehgroup grp on (lcg.grpid=grp.doc_no)"
							+" where req.status=3 and req.rdocno="+docno+" and req.leasereqdocno="+reqdocno;
					}
					else{
						strsql="select 'Load' loadgrid,0 fsavestatus,0 confirmstatus,0 savestatus,0 rowcolor,brd.brand_name brand,model.vtype model,lcg.doc_no grpid,grp.gname,brd.doc_no brdid,model.doc_no modelid,det.ldur leasemonths,det.kmusage kmpermonth,det.driver,det.security_pass,det.fuel,det.salik,det.safety_acsrs safetyaccessories,det.frmdate leasefromdate,'Quotation' quotbtn"
							+" from gl_lprd det left join gl_vehbrand brd on det.brdid=brd.doc_no"
							+" left join gl_vehmodel model on det.modid=model.doc_no"
							+" left join gl_lcgm lcg on (det.brdid=lcg.brdid and det.modid=lcg.modid)"
							+" left join gl_vehgroup grp on (lcg.grpid=grp.doc_no)"
							+" where det.rdocno="+reqdocno;						
					}
					System.out.println("Request Query: "+strsql);
					ResultSet resultSet = stmt.executeQuery(strsql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					
					stmt.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	 
	 public int insert(Date sqldate, String hidleasereqdoc,
				ArrayList<String> reqarray, HttpSession session,String brchName,String mode,String formdetailcode) throws SQLException {
			// TODO Auto-generated method stub
			System.out.println("inside save action dao");
			Connection conn=null;
			int val=0;
			int voc=0;
			try{
				conn=objconn.getMyConnection();
				conn.setAutoCommit(false);
				CallableStatement stmtReq = conn.prepareCall("{call almariahLeaseCalcDML(?,?,?,?,?,?,?,?)}");
				stmtReq.registerOutParameter(3, java.sql.Types.INTEGER);
				stmtReq.registerOutParameter(8, java.sql.Types.INTEGER);
				stmtReq.setDate(1,sqldate);
				stmtReq.setString(2, hidleasereqdoc);
				stmtReq.setString(4, brchName);
				stmtReq.setString(5, session.getAttribute("USERID").toString());
				stmtReq.setString(6, mode);
				stmtReq.setString(7, formdetailcode);
				stmtReq.executeQuery();
				val=stmtReq.getInt("docNo");
				voc=stmtReq.getInt("vocNo");
				System.out.println("Doc No:"+val);
				System.out.println("Voc No:"+voc);
				if(val<=0){
					return 0;
				}
				int reqval=reqinsert(reqarray,hidleasereqdoc,val,conn);
				System.out.println("Req Val"+reqval);
				if(reqval<=0){
					return 0;
				}
				conn.commit();
				return val;
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
				return 0;
			}
			finally{
				conn.close();
			}
			
		}
	 
	 private int reqinsert(ArrayList<String> reqarray, String hidleasereqdoc,int val,Connection conn) throws SQLException {
			// TODO Auto-generated method stub
			int reqval=0;
			int j=0;
			try{
				Statement stmt=conn.createStatement();
				//System.out.println("Arraysize:"+reqarray.size());
				for(int i=0;i<reqarray.size();i++){
					java.sql.Date sqlfromdate=null;
					//System.out.println("Checking Array:"+reqarray.get(i));
					String req[]=reqarray.get(i).split("::");
					if(!req[0].equalsIgnoreCase("") && !req[0].equalsIgnoreCase("undefined")){
						sqlfromdate=objcommon.changeStringtoSqlDate(req[0]);
					}
					String brdid=req[1].equalsIgnoreCase("undefined") || req[1].isEmpty()?"0":req[1];
					String modelid=req[2].equalsIgnoreCase("undefined") || req[2].isEmpty()?"0":req[2];
					String leasemonths=req[3].equalsIgnoreCase("undefined") || req[3].isEmpty()?"0":req[3];
					String kmpermonth=req[4].equalsIgnoreCase("undefined") || req[4].isEmpty()?"0":req[4];
					
					String driver=req[5].equalsIgnoreCase("undefined") || req[5].isEmpty()?"0":req[5];
					String securitypass=req[6].equalsIgnoreCase("undefined") || req[6].isEmpty()?"0":req[6];
					String fuel=req[7].equalsIgnoreCase("undefined") || req[7].isEmpty()?"0":req[7];
					String salik=req[8].equalsIgnoreCase("undefined") || req[8].isEmpty()?"0":req[8];
					String safetyaccessories=req[9].equalsIgnoreCase("undefined") || req[9].isEmpty()?"0":req[9];
					
					j=i+1;
/*					String strsql="insert into gl_almariahleasecalcreq(rdocno,leasereqdocno,leasefromdate,brdid,modid,leasemonths,kmpermonth,driver,security_pass,fuel,salik,safety_acsrs,status)"
							+ "values("+val+","+hidleasereqdoc+",'"+sqlfromdate+"',"+brdid+","+modelid+","+leasemonths+","+kmpermonth+",'"+driver+"','"+securitypass+"','"+fuel+"','"+salik+"','"+safetyaccessories+"',3)";
*/
					String strsql="insert into gl_almariahleasecalcreq(rdocno,leasereqdocno,brdid,modid,leasemonths,kmpermonth,driver,security_pass,fuel,salik,safety_acsrs,sr_no,status)"
							+ "values("+val+","+hidleasereqdoc+","+brdid+","+modelid+","+leasemonths+","+kmpermonth+",'"+driver+"','"+securitypass+"','"+fuel+"','"+salik+"','"+safetyaccessories+"','"+j+"',3)";

					System.out.println("Req Insert Query:"+strsql);
					reqval=stmt.executeUpdate(strsql);
					if(reqval<=0){
						return 0;
					}
				}
				
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
				return 0;
			}
			return reqval;
			
		}

	 public JSONArray getSearchData(String docno,String leasereqdocno,String date,String id,String client,String mobile) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
	        String sqltest="";
	        java.sql.Date sqldate=null;
	        
			try {
					conn = objconn.getMyConnection();
					Statement stmt=conn.createStatement();
					if(!date.equalsIgnoreCase("")){
						sqldate=objcommon.changeStringtoSqlDate(date);
					}
					if(!docno.equalsIgnoreCase("")){
						sqltest+=" and calc.doc_no="+docno;
					}
					if(!leasereqdocno.equalsIgnoreCase("")){
						sqltest+=" and reqdoc="+leasereqdocno;
					}
					if(sqldate!=null){
						sqltest+=" and calc.date='"+sqldate+"'";
					}
					if(!client.equalsIgnoreCase("")){
						sqltest+=" and if(req.reqtype=1,ac.refname like '%"+client+"%',req.name like '%"+client+"%')";
					}
					if(!mobile.equalsIgnoreCase("")){
						sqltest+=" and if(req.reqtype=1,ac.com_mob like '%"+mobile+"%',req.mob like '%"+mobile+"%')";
					}
					String strsql="select if(req.reqtype=1,ac.com_mob,req.mob) mobile,if(req.reqtype=1,ac.refname,req.name) refname,calc.voc_no,calc.doc_no,calc.date,calc.reqdoc"+
					" leasereqdocno from gl_almariahleasecalcm calc left join gl_lprm req on (calc.reqdoc=req.doc_no) left join my_acbook ac on "+
					" (req.cldocno=ac.cldocno and ac.dtype='CRM') where calc.status=3"+sqltest;
					System.out.println(strsql);
					ResultSet resultSet = stmt.executeQuery(strsql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					
					stmt.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	 
	 public JSONArray getDetailData(String id) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
			try {
					conn = objconn.getMyConnection();
					Statement stmt=conn.createStatement();
			
					String	strsql=" select details,type,doc_no from gl_almariahleasecalc where type=1 order by seqno;";					
					//System.out.println(strsql);
					ResultSet resultSet = stmt.executeQuery(strsql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					
					stmt.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	 
	 public JSONArray getAuthority() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	        
			try {
					conn = objconn.getMyConnection();
					Statement stmt = conn.createStatement();
	            	
					ResultSet resultSet = stmt.executeQuery ("select doc_no,authname,authid from gl_vehauth where status=3");

					RESULTDATA=objcommon.convertToJSON(resultSet);
					
					stmt.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
 
	 
	 public JSONArray calculate(String srno,String leasemonths,String kmpermonth,String id,String grpid,String leasereqdocno,String docno) throws SQLException {
		 ClsLeaseCalcAlMariahBean bean1 = new ClsLeaseCalcAlMariahBean();
		 JSONArray RESULTDATA=new JSONArray();
	    	System.out.println("Srno"+srno);
	    	if(!id.equalsIgnoreCase("1")){
	    		return RESULTDATA;
	    	}
	    	Connection conn=null;
	    	try{
	    		System.out.println("--------------grpid"+grpid+"--reqdocno--"+leasereqdocno+"--docno--"+docno);
	    		conn=objconn.getMyConnection();
	    		Statement  stmt=conn.createStatement();
//	    		double months=Integer.parseInt(leasemonths)/12 > 12 ? 12  :  (Integer.parseInt(leasemonths)/12);
	    		System.out.println("Lease Months:"+leasemonths);
	    		double months = Integer.parseInt(leasemonths)/12;
	    		double mininsur=0.0,costpermonth=0.0;
	    		double depryear1=0.0,depryear2=0.0,depryear3=0.0,depryear4=0.0,depryear5=0.0,insurper=0.0,srvkm=0.0,tyrechangekm=0.0,tyrecost=0.0,maintcost=0.0,replacecost=0.0,
	    				carwashcost=0.0,auhcost=0.0,dxbcost=0.0,shjcost=0.0,fujcost=0.0,rakcost=0.0,regcost=0.0;
	    		double vehvalueyear1=0.0,vehvalueyear2=0.0,vehvalueyear3=0.0,vehvalueyear4=0.0,vehvalueyear5=0.0,vehvaluetotal=0.0;
	    		double deprcost1=0.0,deprcost2=0.0,deprcost3=0.0,deprcost4=0.0,deprcost5=0.0,deprtotalcost=0.0;
	    		double insurcost1=0.0,insurcost2=0.0,insurcost3=0.0,insurcost4=0.0,insurcost5=0.0,insurtotalcost=0.0;
	    		double carwashcost1=0.0,carwashcost2=0.0,carwashcost3=0.0,carwashcost4=0.0,carwashcost5=0.0,carwashtotalcost=0.0;
	    		double maintcost1=0.0,maintcost2=0.0,maintcost3=0.0,maintcost4=0.0,maintcost5=0.0,mainttotalcost=0.0;
	    		double replacecost1=0.0,replacecost2=0.0,replacecost3=0.0,replacecost4=0.0,replacecost5=0.0,replacetotalcost=0.0;
	    		double tyrecost1=0.0,tyrecost2=0.0,tyrecost3=0.0,tyrecost4=0.0,tyrecost5=0.0,tyretotalcost=0.0;
	    		double regcost1=0.0,regcost2=0.0,regcost3=0.0,regcost4=0.0,regcost5=0.0,regtotalcost=0.0;
	    		double totalcost1=0.0,totalcost2=0.0,totalcost3=0.0,totalcost4=0.0,totalcost5=0.0;
	    		double extrainsurperyear=0.0,extrainsurperyear1=0.0,extrainsurperyear2=0.0,extrainsurperyear3=0.0,extrainsurperyear4=0.0,extrainsurperyear5=0.0;
	    		double majorsrvckm=0.0,majorsrvckm1=0.0,majorsrvckm2=0.0,majorsrvckm13=0.0,majorsrvckm14=0.0,majorsrvckm15=0.0;
	    		double majorsrvccost=0.0,majorsrvccost1=0.0,majorsrvccost2=0.0,majorsrvccost3=0.0,majorsrvccost4=0.0,majorsrvccost5=0.0;
	    		double trackidexp=0.0,trackidexp1=0.0,trackidexp2=0.0,trackidexp3=0.0,trackidexp4=0.0,trackidexp5=0.0;
	    		double interestcost1=0.0,interestcost2=0.0,interestcost3=0.0,interestcost4=0.0,interestcost5=0.0,interesttotalcost=0.0;
	    		double mastertotal=0.0,overheadpertotal=0.0,profittotal=0.0,rentabletotal=0.0,permonthtotal=0.0,credittotal=0.0,rentpermonthtotal=0.0,
	    				discounttotal=0.0,netrentaltotal=0.0,rentalcollecttotal=0.0,residualtotal=0.0,inflowtotal=0.0,expensetotal=0.0,overheadtotal=0.0,
	    				loanrepaytotal=0.0,outflowtotal,surplustotal=0.0,investtotal=0.0,netinvesttotal=0.0,irrtotal=0.0,netprofittotal=0.0,salesprofittotal=0.0,
	    				extrainsurperyeartotal=0.0,majorsrvckmtotal=0.0,majorsrvccosttotal=0.0,trackidexptotal=0.0;
	    		double drivercost=0.0,fuelcost=0.0,salikd=0.0,securitypassd=0.0,accessories=0.0,nettotalcost=0.0;
	    		//System.out.println("========== "+months months+"".split(".")[0]);
	    		
	    	Statement stmtdet=conn.createStatement();
	    	String strdet="select coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=25),0) vehcost,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=1),0) downpytper,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=2),0) interestper,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=3),0) authority,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=4),0) profitper,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=5),0) overheadper,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=6),0) others,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=7),0) dsalarymonth,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=8),0) endofservice,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=9),0) uniform,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=10),0) food,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=11),0) accomodation,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=12),0) milageprltr,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=13),0) fuelcostprltr,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=14),0) salik,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=15),0) securitypass,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=16),0) sparkarrestor,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=17),0) chalwynvalve,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=18),0) seatbelts,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=19),0) curtains,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=20),0) reversalarm,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=21),0) camara,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=22),0) rolloverprotection,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=23),0) ivms,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=24),0) others,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=96),0) sticker,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=97),0) cartracky,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=98),0) gps,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=99),0) parking,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=95),0) replacepercent,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=114),0) totaldrivercost,"
						+" coalesce((select coalesce(amount,0) from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno=115),0) driverreliver";
	    		System.out.println("detail qry---"+strdet);
	    		ResultSet detrs=stmt.executeQuery(strdet);
	    		double sticker=0.0,cartracky=0.0,gps=0.0,parking=0.0,replacepercent=0.0,totaldrivercost=0.0,driverreliver=0.0;
	    		String downpytper="",interestper="",profitper="",overheadper="",others="",purchcost="",authid="",dsalarymonth="",endofservice="",
	    				uniform="",food="",accomodation="",milageprltr="",fuelcostprltr="",salik="",securitypass="",sparkarrestor="",chalwynvalve="",
	    				seatbelts="",curtains="",reversalarm="",camara="",rolloverprotection="",ivms="";
	    		while(detrs.next()){
	    			sticker=detrs.getDouble("sticker");
	    			cartracky=detrs.getDouble("cartracky");
	    			gps=detrs.getDouble("gps");
	    			parking=detrs.getDouble("parking");
	    			replacepercent=detrs.getDouble("replacepercent");
	    			totaldrivercost=detrs.getDouble("totaldrivercost");
	    			driverreliver=detrs.getDouble("driverreliver");
	    			
	    			downpytper=detrs.getString("downpytper");
	    			interestper=detrs.getString("interestper");
	    			profitper=detrs.getString("profitper");
	    			overheadper=detrs.getString("overheadper");
	    			others=detrs.getString("others");
	    			purchcost=detrs.getString("vehcost");
	    			authid=detrs.getString("authority");
	    			
	    			dsalarymonth=detrs.getString("dsalarymonth");
	    			endofservice=detrs.getString("endofservice");
	    			uniform=detrs.getString("uniform");
	    			food=detrs.getString("food");
	    			accomodation=detrs.getString("accomodation");
	    			
	    			milageprltr=detrs.getString("milageprltr");
	    			fuelcostprltr=detrs.getString("fuelcostprltr");
	    			
	    			salik=detrs.getString("salik");
	    			securitypass=detrs.getString("securitypass");
	    			
	    			sparkarrestor=detrs.getString("sparkarrestor");
	    			chalwynvalve=detrs.getString("chalwynvalve");
	    			seatbelts=detrs.getString("seatbelts");
	    			curtains=detrs.getString("curtains");
	    			reversalarm=detrs.getString("reversalarm");
	    			camara=detrs.getString("camara");
	    			rolloverprotection=detrs.getString("rolloverprotection");
	    			ivms=detrs.getString("ivms");
	    			
	    			
	    			System.out.println("profitper"+profitper);
	    		}
	    		
	    		double vehiclevalue=Double.parseDouble(purchcost);
	    		String strdepr="select coalesce(l.extrainsurperyear,0) extrainsurperyear,coalesce(l.majorsrvckm,0) majorsrvckm,coalesce(l.majorsrvccost,0) majorsrvccost,coalesce(l.trackidexp,0) trackidexp,coalesce(l.dy1,0) depryear1, coalesce(l.dy2,0) depryear2, coalesce(l.dy3,0) depryear3, coalesce(l.dy4,0) depryear4, coalesce(l.dy5,0) depryear5, "+
	      " coalesce(l.ins_per,0) insurper,coalesce(l.mininsur,0) mininsur, coalesce(l.srv_km,0) srvkm, coalesce(l.tyrechg_km,0) tyrechangekm,coalesce(l.tyre_cost,0) tyrecost, coalesce(l.maint_cost,0) maintcost, "+
	      " coalesce(l.repl_cost,0) replacecost, coalesce(l.carwash_cost,0) carwashcost, coalesce(l.AUH,0) AUH, coalesce(l.DXB,0) DXB, coalesce(l.SHJ,0) SHJ, coalesce(l.FUJ,0) FUJ, "+
	      " coalesce(l.RAK,0) RAK from gl_leasecost l left join gl_lcgm lg on l.grpid=lg.grpid where lg.status=3 and lg.doc_no="+grpid;
	    		System.out.println("grpid qry"+strdepr);
	    		ResultSet rsdepr=stmt.executeQuery(strdepr);
	    		while(rsdepr.next()){
	    			depryear1=objcommon.Round(rsdepr.getDouble("depryear1"), 2);
	    			depryear2=objcommon.Round(rsdepr.getDouble("depryear2"), 2);
	    			depryear3=objcommon.Round(rsdepr.getDouble("depryear3"), 2);
	    			depryear4=objcommon.Round(rsdepr.getDouble("depryear4"), 2);
	    			depryear5=objcommon.Round(rsdepr.getDouble("depryear5"), 2);
	    			insurper=objcommon.Round(rsdepr.getDouble("insurper"), 2);
	    			mininsur=objcommon.Round(rsdepr.getDouble("mininsur"), 2);
	    			extrainsurperyear=objcommon.Round(rsdepr.getDouble("extrainsurperyear"), 2);
	    			majorsrvckm=objcommon.Round(rsdepr.getDouble("majorsrvckm"), 2);
	    			majorsrvccost=objcommon.Round(rsdepr.getDouble("majorsrvccost"), 2);
	    			trackidexp=objcommon.Round(rsdepr.getDouble("trackidexp"), 2);
	    			srvkm=objcommon.Round(rsdepr.getDouble("srvkm"), 2);
	    			tyrechangekm=objcommon.Round(rsdepr.getDouble("tyrechangekm"), 2);
	    			tyrecost=objcommon.Round(rsdepr.getDouble("tyrecost"), 2);
	    			maintcost=objcommon.Round(rsdepr.getDouble("maintcost"), 2);
	    			//replacecost=objcommon.Round(rsdepr.getDouble("replacecost"), 2);
	    			replacecost=objcommon.Round((Double.parseDouble(purchcost)*(replacepercent/100))*(Double.parseDouble(leasemonths)/12), 2);
	    			carwashcost=objcommon.Round(rsdepr.getDouble("carwashcost"), 2);
	    			auhcost=objcommon.Round(rsdepr.getDouble("AUH"), 2);
	    			dxbcost=objcommon.Round(rsdepr.getDouble("DXB"), 2);
	    			shjcost=objcommon.Round(rsdepr.getDouble("SHJ"), 2);
	    			fujcost=objcommon.Round(rsdepr.getDouble("FUJ"), 2);
	    			rakcost=objcommon.Round(rsdepr.getDouble("RAK"), 2);
	    		}
	    		System.out.println(majorsrvckm+"///"+majorsrvccost+"///"+srvkm+"///"+tyrechangekm+"///"+tyrecost+"///"+maintcost+"///"+replacecost+"///"+carwashcost);
	    		if(majorsrvckm==0 || majorsrvccost==0 || srvkm==0 || tyrechangekm==0 || tyrecost==0 || maintcost==0 || carwashcost==0)
	    		{
	    			JSONArray MSG=new JSONArray();
	    			JSONObject obj = new JSONObject();
	    			obj.put("msg", "1");
	    			MSG.add(obj);
	    			return MSG;
	    		}
	    	 
	    		
	    		if(!authid.equalsIgnoreCase("")){
					if(authid.equalsIgnoreCase("AUH")){
						regcost=auhcost;
					}
					else if(authid.equalsIgnoreCase("DXB")){
						regcost=dxbcost;
					}
					else if(authid.equalsIgnoreCase("SHJ")){
						regcost=shjcost;
					}
					else if(authid.equalsIgnoreCase("FUJ")){
						regcost=fujcost;
					}
					else if(authid.equalsIgnoreCase("RAK")){
						regcost=rakcost;
					}
					else{
						
					}
				}
	    		int curmonth=Integer.parseInt(leasemonths);
	    		ArrayList<String> temparray=new ArrayList<>();
	    		int i=1;
	    		//System.out.println("Total Months:"+curmonth);
	    		double mnthfac=0.0;
	    		double trackexppermonth=trackidexp/12;
	    		while(curmonth>0){
	    			/*double mnthfac = curmonth  > 12 ? 12  :  curmonth/12;*/
//	    			System.out.println("Monthcalc:"+curmonth);
	    			if(curmonth>=12){
	    				mnthfac=12;
	    			}
	    			else{
	    				mnthfac=curmonth;
//	    				System.out.println("Else:"+curmonth/12);
	    			}
//	    			System.out.println("Months:"+mnthfac);
	    		//	System.out.println("====mnthfac = "+mnthfac+"curmnth = "+curmonth);	
	    			
	    			if(i==1){
	    				
			    				carwashcost1=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*carwashcost,2);
			    				//System.out.println(kmpermonth+"::"+mnthfac+"::"+srvkm+"::"+carwashcost);
			    				maintcost1=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*maintcost,2);
			    				replacecost1=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*replacecost,2);
			    				tyrecost1=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/tyrechangekm*tyrecost,2);
			    				regcost1=objcommon.Round(regcost,2);
			    				vehvalueyear1=objcommon.Round(vehiclevalue,2);
			        			deprcost1=objcommon.Round(vehiclevalue*(depryear1*0.01),2);
			        			insurcost1=objcommon.Round(vehiclevalue*(insurper*0.01),2);
			        			
			        			//--------------------//
			        			drivercost=objcommon.Round((Double.parseDouble(dsalarymonth)+Double.parseDouble(endofservice)+Double.parseDouble(uniform)+Double.parseDouble(food)+Double.parseDouble(accomodation))*Integer.parseInt(leasemonths),2);
			        			salikd=objcommon.Round(Double.parseDouble(salik),2);
			        			securitypassd=objcommon.Round(Double.parseDouble(securitypass),2);
			        			System.out.println("Checking Fuel:"+kmpermonth+"///"+fuelcostprltr);
			        			//fuelcost=objcommon.Round(Double.parseDouble(kmpermonth)*Double.parseDouble(fuelcostprltr),2);
			        			System.out.println(kmpermonth+"//"+leasemonths+"//"+milageprltr+"//"+fuelcostprltr);
			        			if(Double.parseDouble(milageprltr)!=0.0 && Double.parseDouble(fuelcostprltr)!=0.0){
			        				fuelcost=objcommon.Round(((Double.parseDouble(kmpermonth)*Double.parseDouble(leasemonths))/(Double.parseDouble(milageprltr)))*Double.parseDouble(fuelcostprltr),2);
			        			}
			        			
			        			accessories=objcommon.Round((Double.parseDouble(sparkarrestor)+Double.parseDouble(chalwynvalve)+Double.parseDouble(seatbelts)+Double.parseDouble(curtains)+Double.parseDouble(reversalarm)+Double.parseDouble(camara)+Double.parseDouble(rolloverprotection)+Double.parseDouble(ivms))*Integer.parseInt(leasemonths),2);
			        			
			        			if(mininsur>insurcost1){
			        				insurcost1=mininsur;
			        			}
			        			extrainsurperyear1=extrainsurperyear*mnthfac;
			        			/*trackidexp1=trackidexp*mnthfac;*/
			        			if(mnthfac==12){
			        				trackidexp1=trackidexp;
			        			}
			        			else if(mnthfac<12){
			        				trackidexp1=trackexppermonth*mnthfac;
			        			}
			        			majorsrvccost1=(Double.parseDouble(kmpermonth)*mnthfac)/majorsrvckm*majorsrvccost;
			        			/*interestcost1=objcommon.Round(vehvalueyear1*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);*/
			        			interestcost1=objcommon.Round(vehiclevalue*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);
		//	        			System.out.println(kmpermonth+"::"+mnthfac+"::"+majorsrvckm+"::"+majorsrvccost);
	    				
	    			}
	    			else if(i==2){
	    				carwashcost2=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*carwashcost,2);
	    				maintcost2=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*maintcost,2);
	    				replacecost2=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*replacecost,2);
	    				tyrecost2=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/tyrechangekm*tyrecost,2);
	    				regcost2=objcommon.Round(regcost,2);
	        			vehvalueyear2=objcommon.Round(vehvalueyear1-deprcost1,2);
	        			deprcost2=objcommon.Round(vehvalueyear2*(depryear2*0.01),2);
	        			insurcost2=objcommon.Round(vehvalueyear2*(insurper*0.01),2);
	        			if(mininsur>insurcost2){
	        				insurcost2=mininsur;
	        			}
	        			/*interestcost2=objcommon.Round(vehvalueyear2*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);*/
	        			interestcost2=objcommon.Round(vehiclevalue*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);
	        			extrainsurperyear2=extrainsurperyear*mnthfac;
	        			/*trackidexp2=trackidexp*mnthfac;*/
	        			if(mnthfac==12){
	        				trackidexp2=trackidexp;
	        			}
	        			else if(mnthfac<12){
	        				trackidexp2=trackexppermonth*mnthfac;
	        			}
	        			System.out.println(kmpermonth+"-"+mnthfac+"-"+majorsrvckm+"-"+majorsrvccost);
	        			majorsrvccost2=(Double.parseDouble(kmpermonth)*mnthfac)/majorsrvckm*majorsrvccost;
	    			}
	    			else if(i==3){
	    				carwashcost3=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*carwashcost,2);
	    				maintcost3=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*maintcost,2);
	    				replacecost3=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*replacecost,2);
	    				tyrecost3=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/tyrechangekm*tyrecost,2);
	    				regcost3=objcommon.Round(regcost,2);
	    				vehvalueyear3=objcommon.Round(vehvalueyear2-deprcost2,2);	
	    				deprcost3=objcommon.Round(vehvalueyear3*(depryear3*0.01),2);
	    				insurcost3=objcommon.Round(vehvalueyear2*(insurper*0.01),2);
	    				if(mininsur>insurcost3){
	    					insurcost3=mininsur;
	        			}
	    				/*interestcost3=objcommon.Round(vehvalueyear3*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);*/
	    				interestcost3=objcommon.Round(vehiclevalue*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);
	    				extrainsurperyear3=extrainsurperyear*mnthfac;
	        			/*trackidexp3=trackidexp*mnthfac;*/
	    				if(mnthfac==12){
	    					trackidexp3=trackidexp;
	        			}
	        			else if(mnthfac<12){
	        				trackidexp3=trackexppermonth*mnthfac;
	        			}
	        			majorsrvccost3=(Double.parseDouble(kmpermonth)*mnthfac)/majorsrvckm*majorsrvccost;
	    			}
	    			else if(i==4){
	    				carwashcost4=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*carwashcost,2);
	    				maintcost4=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*maintcost,2);
	    				replacecost4=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*replacecost,2);
	    				tyrecost4=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/tyrechangekm*tyrecost,2);
	    				regcost4=objcommon.Round(regcost,2);
	    				vehvalueyear4=objcommon.Round(vehvalueyear3-deprcost3,2);
	    				deprcost4=objcommon.Round(vehvalueyear4*(depryear4*0.01),2);
	    				insurcost4=objcommon.Round(vehvalueyear2*(insurper*0.01),2);
	    				if(mininsur>insurcost4){
	    					insurcost4=mininsur;
	        			}
	    				/*interestcost4=objcommon.Round(vehvalueyear4*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);*/
	    				interestcost4=objcommon.Round(vehiclevalue*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);
	    				extrainsurperyear4=extrainsurperyear*mnthfac;
	        			/*trackidexp4=trackidexp*mnthfac;*/
	    				if(mnthfac==12){
	    					trackidexp4=trackidexp;
	        			}
	        			else if(mnthfac<12){
	        				trackidexp4=trackexppermonth*mnthfac;
	        			}
	    				
	        			majorsrvccost4=(Double.parseDouble(kmpermonth)*mnthfac)/majorsrvckm*majorsrvccost;
	    			}
	    			else if(i==5){
	    				carwashcost5=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*carwashcost,2);
	    				maintcost5=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*maintcost,2);
	    				replacecost5=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*replacecost,2);
	    				tyrecost5=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/tyrechangekm*tyrecost,2);
	    				regcost5=objcommon.Round(regcost,2);
	    				vehvalueyear5=objcommon.Round(vehvalueyear4-deprcost4,2);
	    				deprcost5=objcommon.Round(vehvalueyear5*(depryear5*0.01),2);
	    				insurcost5=objcommon.Round(vehvalueyear4*(insurper*0.01),2);
	    				if(mininsur>insurcost5){
	    					insurcost5=mininsur;
	        			}
	    				/*interestcost5=objcommon.Round(vehvalueyear5*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);*/
	    				
	    				interestcost5=objcommon.Round(vehiclevalue*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);
	    				extrainsurperyear5=extrainsurperyear*mnthfac;
	        			/*trackidexp5=trackidexp*mnthfac;*/
	    				if(mnthfac==12){
	    					trackidexp5=trackidexp;
	        			}
	        			else if(mnthfac<12){
	        				trackidexp5=trackexppermonth*mnthfac;
	        			}
	    				
	        			majorsrvccost5=(Double.parseDouble(kmpermonth)*mnthfac)/majorsrvckm*majorsrvccost;
	    			}
	    			
	    			curmonth=curmonth-12;
	    			i++;
	    			
	    		}
	    			System.out.println(deprcost1+"-"+interestcost1+"-"+insurcost1+"-"+regcost+"-"+carwashcost1+"-"+maintcost1+"-"+replacecost1+"-"+tyrecost1+"-"+insurcost2+"-"+majorsrvccost2+"-"+trackidexp2);
	    			
	    			vehvaluetotal=objcommon.Round(vehvalueyear1+vehvalueyear2+vehvalueyear3+vehvalueyear4+vehvalueyear5,2);
	    			totalcost1=objcommon.Round(deprcost1+interestcost1+insurcost1+regcost+carwashcost1+maintcost1+replacecost1+tyrecost1+insurcost2+majorsrvccost2+trackidexp2,2);
	    			totalcost2=objcommon.Round(deprcost2+interestcost2+insurcost2+regcost+carwashcost2+maintcost2+replacecost2+tyrecost2,2);
	    			totalcost3=objcommon.Round(deprcost3+interestcost3+insurcost3+regcost+carwashcost3+maintcost3+replacecost3+tyrecost3,2);
	    			totalcost4=objcommon.Round(deprcost4+interestcost4+insurcost4+regcost+carwashcost4+maintcost4+replacecost4+tyrecost4,2);
	    			totalcost5=objcommon.Round(deprcost5+interestcost5+insurcost5+regcost+carwashcost5+maintcost5+replacecost5+tyrecost5,2);
	    			extrainsurperyeartotal=objcommon.Round(extrainsurperyear1+extrainsurperyear2+extrainsurperyear3+extrainsurperyear4+extrainsurperyear5, 2);
	    			majorsrvccosttotal=objcommon.Round(majorsrvccost1+majorsrvccost2+majorsrvccost3+majorsrvccost4+majorsrvccost5,2);
	    			trackidexptotal=objcommon.Round(trackidexp1+trackidexp2+trackidexp3+trackidexp4+trackidexp5,2);
	    			deprtotalcost=objcommon.Round(deprcost1+deprcost2+deprcost3+deprcost4+deprcost5,2);
	    			interesttotalcost=objcommon.Round(interestcost1+interestcost2+interestcost3+interestcost4+interestcost5,2);
	    			insurtotalcost=objcommon.Round(insurcost1+insurcost2+insurcost3+insurcost4+insurcost5,2);
	    			carwashtotalcost=objcommon.Round(carwashcost1+carwashcost2+carwashcost3+carwashcost4+carwashcost5,2);
	    			mainttotalcost=objcommon.Round(maintcost1+maintcost2+maintcost3+maintcost4+maintcost5,2);
	    			//replacetotalcost=objcommon.Round(replacecost1+replacecost2+replacecost3+replacecost4+replacecost5,2);
	    			replacetotalcost=objcommon.Round(replacecost, 2);
	    			tyretotalcost=objcommon.Round(tyrecost1+tyrecost2+tyrecost3+tyrecost4+tyrecost5,2);
	    			regtotalcost=objcommon.Round(regcost1+regcost2+regcost3+regcost4+regcost5,2);
	    			mastertotal=objcommon.Round(deprtotalcost+interesttotalcost+insurtotalcost+carwashtotalcost+mainttotalcost+replacetotalcost+tyretotalcost+(Double.parseDouble(others))+regtotalcost+extrainsurperyeartotal+majorsrvccosttotal+trackidexptotal+sticker+cartracky+gps+parking,2);
	    			drivercost=objcommon.Round(totaldrivercost+driverreliver, 2);
	    			//nettotalcost=objcommon.Round(mastertotal+(drivercost*Double.parseDouble(leasemonths))+fuelcost+salikd+securitypassd+accessories,2);
	    			nettotalcost=objcommon.Round(mastertotal+(drivercost*Double.parseDouble(leasemonths))+fuelcost+salikd+securitypassd+accessories, 2);
	    			double nettotalcostpermonth=objcommon.Round(nettotalcost/Double.parseDouble(leasemonths),2);
	    			overheadpertotal=objcommon.Round(mastertotal*((Double.parseDouble(overheadper))*0.01),2);
	    			profittotal=objcommon.Round((mastertotal+overheadpertotal)*(Double.parseDouble(profitper)*0.01), 2);
	    			rentabletotal=objcommon.Round(mastertotal+overheadpertotal+profittotal, 2);
	    			permonthtotal=objcommon.Round(rentabletotal/Integer.parseInt(leasemonths), 2);
	    			//credittotal=objcommon.Round((permonthtotal*(1+(Double.parseDouble(creditper))*0.01))*Double.parseDouble(creditper)*0.01,2);
	    			rentpermonthtotal=objcommon.Round(permonthtotal+credittotal, 2);
	    			//discounttotal=objcommon.Round(Double.parseDouble(discount), 2);
	    			netrentaltotal=objcommon.Round(rentpermonthtotal-discounttotal, 2);
	    			rentalcollecttotal=objcommon.Round(netrentaltotal*Double.parseDouble(leasemonths), 2);
	    			residualtotal=objcommon.Round(vehiclevalue-deprtotalcost, 2);
	    			inflowtotal=objcommon.Round(rentalcollecttotal+residualtotal,2);
	    			expensetotal=objcommon.Round(mastertotal-deprtotalcost, 2);
	    			overheadtotal=objcommon.Round(overheadpertotal, 2);
	    			loanrepaytotal=objcommon.Round(vehiclevalue*(100-(Double.parseDouble(downpytper)))*0.01,2);
	    			outflowtotal=objcommon.Round(expensetotal+overheadtotal+loanrepaytotal,2);
	    			surplustotal=objcommon.Round((rentalcollecttotal+residualtotal)-(expensetotal+overheadtotal+loanrepaytotal),2);
	    			investtotal=objcommon.Round(vehiclevalue*Double.parseDouble(downpytper)*0.01,2);
	    			netinvesttotal=objcommon.Round(surplustotal-investtotal, 2);
	    			irrtotal=objcommon.Round((netinvesttotal/investtotal)*100, 2);
	    			netprofittotal=objcommon.Round(rentalcollecttotal-mastertotal-overheadpertotal, 2);
	    			salesprofittotal=objcommon.Round(netprofittotal/rentalcollecttotal, 2);
	    			costpermonth=mastertotal/Integer.parseInt(leasemonths);
	    			
	    			double drivercostpermonth=objcommon.Round(drivercost/Double.parseDouble(leasemonths), 2);
	    			//	status=3;
	    			//srno="1";
	    			System.out.println(mastertotal+"//"+drivercost*Double.parseDouble(leasemonths)+"//"+fuelcost+"//"+salikd+"//"+securitypassd+"//"+accessories);
//	    			System.out.println("Major srvc cost:"+majorsrvccosttotal+"::"+majorsrvccost+"::"+majorsrvccost1+"::"+majorsrvccost2+"::"+majorsrvccost3+"::"+majorsrvccost4+"::"+majorsrvccost5);
	    			ArrayList<String> finalarray=new ArrayList<>();
	    			ResultSet rsdetail=stmt.executeQuery("select doc_no,details from gl_almariahleasecalc where status=3 and type=2 order by seqno ");
	    			while(rsdetail.next()){
//	    				System.out.println("Details:"+rsdetail.getString("details")+"////");
	    				if(rsdetail.getString("details").equalsIgnoreCase("Vehicle Value")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+vehiclevalue+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Depreciation %")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+null+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Depreciation Cost")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+deprtotalcost+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Bank Interest")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+interesttotalcost+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Insurance")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+insurtotalcost+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Registration Cost")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+regtotalcost+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Car Wash")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+carwashtotalcost+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Maintenance Cost")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+mainttotalcost+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Replacement Cost")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+replacetotalcost+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Tyre Cost")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+tyretotalcost+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Others")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+others+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Total Cost")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+mastertotal+"::0.00::"+mastertotal);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Total Cost per month")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+mastertotal/Double.parseDouble(leasemonths)+"::0.00::"+mastertotal/Double.parseDouble(leasemonths));
	    				}
	    				
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Cost Per Month")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+costpermonth+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Overhead %")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+overheadpertotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Profit")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+profittotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Total rentable value")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+rentabletotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Per month")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+permonthtotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Credit card charges")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+credittotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Rental per month")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+rentpermonthtotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Discount")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+discounttotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Net Rental")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+netrentaltotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Rental Collection")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+rentalcollecttotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Residual value")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+residualtotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Cash in flow")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+inflowtotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Expenses")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+expensetotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Over head")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+overheadtotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Loan repayment")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+loanrepaytotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Out flow")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+outflowtotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Surplus/shortage")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+surplustotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Investment")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+investtotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Net flow on investment")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+netinvesttotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("IRR")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+irrtotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Net Profit")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+netprofittotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Profit % on sales")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+salesprofittotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Ext. Insurance Cost")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+extrainsurperyeartotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Major Services Cost")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+majorsrvccosttotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Tracking ID Expense")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+trackidexptotal+"::"+null+"::"+null);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Driver Cost per month")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+drivercost+"::0.00::"+drivercost);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Driver Cost")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+drivercost*Double.parseDouble(leasemonths)+"::0.00::"+drivercost*Double.parseDouble(leasemonths));
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Fuel Cost")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+fuelcost+"::0.00::"+fuelcost);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Salik")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+salikd+"::0.00::"+salikd);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Security Pass")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+securitypassd+"::0.00::"+securitypassd);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Accessories")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+accessories+"::0.00::"+accessories);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Net Total Cost")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+nettotalcost+"::"+null+"::"+nettotalcost);
	    				}
	    				else if(rsdetail.getString("details").equalsIgnoreCase("Net Total Cost per month")){
	    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+nettotalcostpermonth+"::"+null+"::"+nettotalcostpermonth);
	    				}
	    				
	    			}
	    			
	    			
	    			int val=arrayInsert(finalarray,conn,docno,leasereqdocno,srno);
	    			String strgetGridDetails="select req.leasemonths duration,0 view,acd.rdocno,acd.leasereqdocno,alc.flow,acd.srno,acd.detaildocno,acd.margin,if(acd.detaildocno in (94,117),round(acd.total,0),acd.total) total,alc.details,if(acd.detaildocno in (94,117),round(acd.amount,0),acd.amount) amount from gl_almariahleasecalcd acd"
										+" left join gl_almariahleasecalc alc on acd.detaildocno=alc.doc_no and alc.type=2"
										+"  left join gl_almariahleasecalcreq req on (acd.leasereqdocno=req.leasereqdocno and acd.srno=req.sr_no) "+
										" where acd.rdocno="+docno+" and acd.leasereqdocno="+leasereqdocno+" and acd.srno="+srno+" and acd.status=3";
	    			System.out.println("grid load"+strgetGridDetails);
	    			ResultSet rsgriddetails=stmt.executeQuery(strgetGridDetails);
	    			RESULTDATA=objcommon.convertToJSON(rsgriddetails);
	    			System.out.println("resuult dataa--------"+RESULTDATA);
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	 
	 private int arrayInsert(ArrayList<String> finalarray, Connection conn,String docno,String leasereqdocno,String srno) throws SQLException {
			// TODO Auto-generated method stub
			int value=0;
			try{
				Statement stmt=conn.createStatement();
				conn.setAutoCommit(false);
				int val=stmt.executeUpdate("delete from gl_almariahleasecalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno);
				for(int i=0;i<finalarray.size();i++){
					String temp[]=finalarray.get(i).split("::");
				System.out.println(temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+","+temp[5]+","+temp[6]);
				String strinsert="insert into gl_almariahleasecalcd(rdocno, leasereqdocno, srno, detaildocno, amount, margin, total, status)"+
				" values("+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+","+temp[5]+","+temp[6]+",3)";
				System.out.println("insert-----"+strinsert);
				value=stmt.executeUpdate(strinsert);
				if(value<=0){
					return 0;
				}
			
				}
				conn.commit();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
				return 0;
			}
			
			return value;
		}
	 
	 public JSONArray getCalculateView(String docno,String leasereqdocno,String srno,String id) throws SQLException {
		 	System.out.println("inside calculator view");
	        JSONArray RESULTDATA=new JSONArray();
	        if(!id.equalsIgnoreCase("2")){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
			try {
					conn = objconn.getMyConnection();
					Statement stmt=conn.createStatement();
	            	
					String strsql="select req.leasemonths duration,1 view,cd.rdocno,cd.leasereqdocno,cd.srno,cd.detaildocno,det.details,det.flow,cd.amount,cd.margin,cd.total"+
	    			" from gl_almariahleasecalcd cd left join gl_almariahleasecalc det on (cd.detaildocno=det.doc_no and det.type=2) "+
					" left join gl_almariahleasecalcreq req on (cd.leasereqdocno=req.leasereqdocno and cd.srno=req.sr_no) where cd.rdocno="+docno+" and cd.leasereqdocno="+leasereqdocno+""+
	    			" and cd.srno="+srno+" and cd.status=3";
					System.out.println("calculator view----"+strsql);
	    			ResultSet resultSet = stmt.executeQuery(strsql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					stmt.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
				return RESULTDATA;
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	 
	 public JSONArray getDetailViewData(String id,String reqdocno,String docno,String srno) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!id.equalsIgnoreCase("2")){
	        //	return RESULTDATA;
	        }
	        Connection conn = null;
			try {
					conn = objconn.getMyConnection();
					Statement stmt=conn.createStatement();
	            	
					String strsql="select cd.leasereqdocno,det.details,cd.amount,det.type,det.doc_no from gl_almariahcalcd cd  left join gl_almariahleasecalc det on (cd.detaildocno=det.doc_no and det.type=1)"
							+ " where cd.rdocno="+docno+" and cd.leasereqdocno="+reqdocno+""+" and cd.srno="+srno+" and cd.status=3";
					System.out.println(strsql);
					ResultSet resultSet = stmt.executeQuery(strsql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					System.out.println("RESULTDATA "+RESULTDATA.isEmpty()+" resultSet ");
					stmt.close();
					if(RESULTDATA.isEmpty()){
						Statement stmt1=conn.createStatement();
						
						String	strsql1=" select details,type,doc_no,0 amount from gl_almariahleasecalc where type=1 order by seqno;";					
						//System.out.println(strsql);
						ResultSet resultSet1 = stmt1.executeQuery(strsql1);
						RESULTDATA=objcommon.convertToJSON(resultSet1);
						
						stmt1.close();
				
					}
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
				return RESULTDATA;
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	 
	 public   ClsLeaseCalcAlMariahBean getPrintQot(int docno, HttpServletRequest request) throws SQLException {
		 ClsLeaseCalcAlMariahBean bean = new ClsLeaseCalcAlMariahBean();
		  Connection conn = null;
		try {
				 conn = objconn.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				String resql=("select q.voc_no,coalesce(q.glterms,'') glterms, q.DOC_NO,DATE_FORMAT(q.DATE,'%d-%m-%Y') DATE , q.REF_NO, "
						+ "if(q.REF_TYPE='DIR','Direct',concat('Enquiry ','(',q.REF_NO,')')) type,q.CONTACT_NO mob ,if(q.REF_TYPE='DIR',a.refname,e.name) name, "
						+ "if(q.REF_TYPE='DIR',a.address,e.com_add1) com_add1,if(q.REF_TYPE='DIR',a.per_mob,e.mob) mob,if(q.REF_TYPE='DIR',a.mail1,e.email) email from "
						+ "   gl_quotm q left join gl_qenq d on d.rdocno=q.doc_no   left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a  "
						+ "on a.cldocno=q.cldocno and a.dtype='CRM'   where q.DOC_NO="+docno+" ");
				
				
				System.out.println("first -----------cl data----"+resql);
				ResultSet pintrs = stmtprint.executeQuery(resql);
			     
			       while(pintrs.next()){
			    	   // cldatails
			    	   
			    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
			    	   if(!(pintrs.getString("glterms").equalsIgnoreCase("")) && (!(pintrs.getString("glterms").equalsIgnoreCase("NA"))))
			    	   {
			    		   bean.setGeneralterms(pintrs.getString("glterms"));
			    		   
			    		   bean.setTerms1("General Terms And Conditions" );
			    		   
			    	   }
			    	   
			    	   
			    	   
			    	    bean.setLblclient(pintrs.getString("name"));
			    	    bean.setLblclientaddress(pintrs.getString("com_add1"));
			    	    bean.setLblmob(pintrs.getString("mob"));
			    	    bean.setLblemail(pintrs.getString("email"));
			    	    //upper
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLbltypep(pintrs.getString("type"));
			    	   // bean.setDocvals(pintrs.getString("voc_no"));
			    	    
			    	    
			       }
				

				stmtprint.close();
					 Statement stmtinvoice10 = conn.createStatement ();
				  String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno,b.tinno from gl_almariahleasecalcm r inner join my_brch b on  "
				    		+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
				    		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"+docno+"' ";
                      System.out.println("-----company details------"+companysql);

			         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	   bean.setLblcstno(resultsetcompany.getString("cstno"));
					    	  
				    	   bean.setLblservicetax(resultsetcompany.getString("stcno"));
				    	   bean.setLblpan(resultsetcompany.getString("pbno"));
				    	   bean.setLblcomptrn(resultsetcompany.getString("tinno"));
				       } 
				       stmtinvoice10.close();
				       ArrayList<String> arr=new ArrayList<String>();
						Statement stmtinvoice2 = conn.createStatement ();
					
						
					    
						String strSqldetail="select @i:=1 srno, req.leasefromdate,brd.brand_name,brand,model.vtype model,format(req.leasemonths,2) leasemonths,format(req.kmpermonth,2) kmpermonth,grp.gname,"
								+" format(req.ddiw,2) ddiw,format(req.dhpd,2) dhpd,format(exkmcharge,2) exkmcharge,format(rateperexhour,2) rateperexhour,format(ratepermonth,2) ratepermonth"
								+" from gl_almariahleasecalcreq req left join gl_vehbrand brd on req.brdid=brd.doc_no"
								+" left join gl_vehmodel model on req.modid=model.doc_no"
								+" left join gl_lcgm lcg on (req.brdid=req.brdid and req.modid=lcg.modid)"
								+" left join gl_vehgroup grp on (lcg.grpid=grp.doc_no)"
								+" where req.status=3 and req.rdocno="+docno;
				
						System.out.println("grid=-------------------"+strSqldetail);
					ResultSet rsdetail=stmtinvoice2.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
						
							String temp="";
							String spci="";
							bean.setFirstarray(1); 
							/*temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+rsdetail.getString("leasemonths")+"::"+rsdetail.getString("kmpermonth")+"::"+rsdetail.getString("gname")+"::"+rsdetail.getString("ddiw")+"::"+rsdetail.getString("dhpd")+"::"+rsdetail.getString("rateperexhour")+"::"+rsdetail.getString("exkmcharge")+"::"+rsdetail.getString("ratepermonth") ;*/
							temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+rsdetail.getString("leasemonths")+"::"+rsdetail.getString("kmpermonth")+"::"+rsdetail.getString("ddiw")+"::"+rsdetail.getString("dhpd")+"::"+rsdetail.getString("rateperexhour")+"::"+rsdetail.getString("exkmcharge")+"::"+rsdetail.getString("ratepermonth") ;
							arr.add(temp);
							rowcount++;
			
					
						
				              }
					stmtinvoice2.close();  
					request.setAttribute("details",arr); 
					
					// System.out.println("--------------"+arr);	
				       ArrayList<String> descarr=new ArrayList<String>();
								Statement stmtinvoice11 = conn.createStatement ();
							
								
								String stsql="select  concat(c.srno,' .  ',m.description,' ',' ',if(c.descplus='0','',c.descplus)) descplus from gl_quotc c "
										+ " left join gl_qcond m on c.desid=m.doc_no where m.status=3 and c.rdocno='"+docno+"' order by c.rowno";
								
							System.out.println("-------notes-------"+strSqldetail);
					
							ResultSet rsdetails=stmtinvoice11.executeQuery(stsql);
							
						String temp1="";
					String ss="";
							while(rsdetails.next()){
								 bean.setTerms2("Special Notes" );
								
								temp1=ss+"::"+rsdetails.getString("descplus") ;
				
								descarr.add(temp1);
								
							
								
						              }
							stmtinvoice2.close();  
							request.setAttribute("desc",descarr); 
					
							

									
									Statement stmtprint1 = conn.createStatement();
				        	
							String resql1=("select l.brhid,l.doc_no,l.date,coalesce(refname,name) refname, coalesce(address,com_add1) address, "
									+ "coalesce(per_mob,mob) per_mob, coalesce(mail1,email) mail1 from  gl_almariahleasecalcm l left join gl_lprm l1 on reqdoc=l1.voc_no\r\n" + 
									" left join my_acbook a on a.doc_no=l1.cldocno and a.dtype='CRM' where l.doc_no="+docno+" ");
							
							System.out.println("--last one--"+resql1);
							ResultSet pintrs1 = stmtprint1.executeQuery(resql1);
							
						     int brhid=0;
						       while(pintrs1.next()){
						    	   // cldatails
						    	   
						    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
						    	    bean.setLblclient(pintrs1.getString("refname"));
						    	    bean.setLblclientaddress(pintrs1.getString("address"));
						    	    bean.setLblmob(pintrs1.getString("per_mob"));
						    	    bean.setLblemail(pintrs1.getString("mail1"));
						    	    //upper
						    	    bean.setLbldate(pintrs1.getString("date"));
						    	  //  bean.setLbltypep(pintrs1.getString("type"));
						    	    bean.setDocvals(pintrs1.getString("doc_no"));
						    	    brhid=pintrs1.getInt("brhid");
						    	    
						       }
						       ArrayList<String> termsarray=new ArrayList<>();
								termsarray=getTerms(conn,docno,brhid);
								request.setAttribute("TERMSPRINT", termsarray);
							    stmtprint1.close();
							    
							    
					Statement stmtjasper=conn.createStatement();
					String strjasper="select convert(concat('Vehicle Rental Services, Vehicle Only, ',if(crq.driver='Yes','With driver','Without driver'),' , ', if(crq.fuel='Yes','With fuel','Without fuel'),' , ',if(crq.security_pass='Yes','With Security Pass','Without Security Pass')),char(1000)) services,"
									+" m.doc_no,round(crq.dhpd,2) hpd,round(crq.ddiw,2) diw,round(crq.rateperexhour,2) exhr,ac.refName,ac.dtype,crq.leasemonths,crq.kmpermonth"
									+" from gl_almariahleasecalcm m left join gl_almariahleasecalcreq crq on m.doc_no=crq.rdocno"
									+" left join gl_lprm  lpr on m.reqdoc=lpr.doc_no"
									+" left join my_acbook ac on lpr.cldocno=ac.cldocno and ac.dtype='CRM'"
									+" where m.doc_no="+docno;
					System.out.println("jasper print qry ---: "+strjasper);
					ResultSet jaspeRs=stmtjasper.executeQuery(strjasper);
					while(jaspeRs.next()){
						bean.setLblcontractperiod(jaspeRs.getString("leasemonths"));
						bean.setLblservices(jaspeRs.getString("services"));
						bean.setLblhpd(jaspeRs.getString("hpd"));
						bean.setLbldiw(jaspeRs.getString("diw"));
						bean.setLblrateperexhr(jaspeRs.getString("exhr"));
						bean.setLblkmrestrict(jaspeRs.getString("kmpermonth"));
						
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
	 
	 private ArrayList<String> getTerms(Connection conn, int docno,int brhid) throws SQLException {
			// TODO Auto-generated method stub
			ArrayList<String> termsarray=new ArrayList<>();
			try{
				Statement stmt=conn.createStatement();
				String strsql="select distinct @s:=@s+1 sr_no,termsheader terms,m.doc_no, 0 priorno from ("+
				" select distinct  tr.rdocno,termsid from my_trterms tr where  tr.dtype='LEC' and tr.brhid="+brhid+" and tr.rdocno="+docno+" and tr.status=3 ) tr"+
				" inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3"+
				" union all"+
				" select '            *' sr_no ,conditions terms,m.doc_no,priorno from my_trterms tr left join my_termsm m"+
				" on(tr.termsid=m.voc_no) where tr.dtype='LEC' and tr.rdocno="+docno+" and tr.brhid="+brhid+" and tr.status=3 and m.status=3  order by doc_no,priorno";
				System.out.println(strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				while(rs.next()){
					termsarray.add(rs.getString("sr_no")+"::"+rs.getString("terms"));
				}
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			return termsarray;
		}
	 private ArrayList<String> getCalcDetails(String docno, Connection conn) throws SQLException {
			// TODO Auto-generated method stub
			ArrayList<String> reqdetailarray=new ArrayList<>();
			try{
				
				Statement stmt=conn.createStatement();
				/*String str="select srno,det.details,coalesce(round(amount,2),'') amount,coalesce(round(amount1,2),'') amount1,coalesce(round(amount2,2),'') amount2,"+
				" coalesce(round(amount3,2),'') amount3,coalesce(round(amount4,2),'') amount4,coalesce(round(amount5,2),'') amount5 from gl_leasecalcd"+
				" d left join gl_leasecalcdetails det on (d.detaildocno=det.doc_no) where rdocno="+docno;*/
				/*String str="select calc.srno,des.name description,round(calc.amount,2) amount from gl_almariahleasecalcd calc left join gl_almariahleasecalc des on"+
				" (calc.srno=des.srno) where calc.type=2 and calc.calcdocno="+docno+" and calc.status=3 ";*/
				String str="select calc.srno,des.details description,if(detaildocno in (94,117),round(amount,0),round(amount,2)) amount from gl_almariahleasecalcd calc left join"+
				" gl_almariahleasecalc des on (calc.detaildocno=des.doc_no) where des.type=2 and calc.rdocno="+docno+" and calc.status=3";
				System.out.println("2:"+str);
				ResultSet rsdet=stmt.executeQuery(str);
				int i=0;
				int tempsrno=0;
				int rowcount=1;
				while (rsdet.next()) {
					i++;
					if(tempsrno!=rsdet.getInt("srno")){
						i=1;
					}
					//System.out.println(rsdet.getString("srno")+" :: "+rsdet.getString("description")+" :: "+rsdet.getString("amount"));
					reqdetailarray.add(rowcount+" :: "+rsdet.getString("description")+" :: "+rsdet.getString("amount"));
					tempsrno=rsdet.getInt("srno");
					rowcount++;
				}
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			return reqdetailarray;
		}

		private ArrayList<String> getLeaseReqDetails(String docno,Connection conn) throws SQLException {
			// TODO Auto-generated method stub
			ArrayList<String> reqarray=new ArrayList<>();
			try{
				Statement stmt=conn.createStatement();
				/*String str="select req.savestatus,req.sr_no srno,req.rdocno,coalesce(DATE_FORMAT(req.leasefromdate,'%d/%m/%Y'),'') leasefromdate,coalesce(brd.brand_name,'') brand,"+
				" coalesce(model.vtype,'') model,coalesce(clr.color,'') color,coalesce(req.leasemonths,'') leasemonths,"+
				" coalesce(round(req.kmpermonth,2),'') kmpermonth,coalesce(grp.gname,'') gname,coalesce(vnd.name,'') vendor,coalesce(round(prchcost,2),'') prchcost,"+
				" coalesce(round(downpytper,2),'') downpytper,coalesce(round(interestper,2),'') interestper,coalesce(round(creditcardper,2),'')"+
				" creditper,coalesce(auth.authname,'') auth,coalesce(round(req.profitper,2),'') profitper,coalesce(round(overheadper,2),'')"+
				" overheadper,coalesce(round(others,2),'') others,coalesce(round(req.discount,2),'') discount,coalesce(round(req.totalvalue,2),'')"+
				" totalvalue,req.savestatus,req.confirmstatus from gl_almariahleasecalcreq req left join gl_vehbrand brd on req.brdid=brd.doc_no left join gl_vehmodel model on"+
				" req.modid=model.doc_no left join my_color clr on req.clrid=clr.doc_no left join gl_lcgm lcg on req.grpid=lcg.doc_no left"+
				" join gl_vehgroup grp on lcg.grpid=grp.doc_no left join my_vendorm vnd on req.dealerid=vnd.doc_no left join gl_vehauth auth on"+
				" req.authid=auth.doc_no where req.status=3 and req.rdocno="+docno;*/
				String str="select round(coalesce(req.ratepermonth,0),2) ratepermonth,req.savestatus,req.sr_no srno,req.rdocno,coalesce(DATE_FORMAT(req.leasefromdate,'%d/%m/%Y'),'') leasefromdate,"+
				" coalesce(brd.brand_name,'') brand, coalesce(model.vtype,'') model,coalesce(req.leasemonths,'') leasemonths,"+
				" coalesce(round(req.kmpermonth,2),'') kmpermonth,0 prchcost, 0 downpytper,0 interestper,"+
				" 0 creditper,0 profitper,0 overheadper,0 others,0 discount,"+
				" 0 totalvalue,req.savestatus,req.confirmstatus from gl_almariahleasecalcreq req left join"+
				" gl_vehbrand brd on req.brdid=brd.doc_no left join gl_vehmodel model on req.modid=model.doc_no where req.status=3 and req.rdocno="+docno;
				System.out.println("1:"+str);
				ResultSet rsreq=stmt.executeQuery(str);
				int i=0;
				while(rsreq.next()){
					i++;
					/*" :: Sr No :: Details :: Total Amount :: Year1 :: Year2 :: Year3 :: Year4 :: Year5";*/
	/*				reqarray.add(rsreq.getString("srno")+" :: "+rsreq.getString("rdocno")+" :: "+i+" :: "+rsreq.getString("leasefromdate")+" :: "+rsreq.getString("brand")+" :: "+rsreq.getString("model")+" :: "+rsreq.getString("spec")+" :: "+
					rsreq.getString("color")+" :: "+rsreq.getString("leasemonths")+" :: "+rsreq.getString("kmpermonth")+" :: "+rsreq.getString("gname")+" :: "+rsreq.getString("totalvalue")+" :: "+rsreq.getString("savestatus")+" :: "+
					"Dealer :: Purchase Cost :: Down payment % :: Interest % :: Credit card % :: Authority :: Profit % :: Overhead % :: Others :: Discount :: "+rsreq.getString("vendor")+" :: "+rsreq.getString("prchcost")+" :: "+rsreq.getString("downpytper")+" :: "+rsreq.getString("interestper")+" :: "+
					rsreq.getString("creditper")+" :: "+rsreq.getString("auth")+" :: "+rsreq.getString("profitper")+" :: "+rsreq.getString("overheadper")+" :: "+rsreq.getString("others")+" :: "+rsreq.getString("discount"));*/
					
					/*reqarray.add(rsreq.getString("srno")+" :: "+rsreq.getString("rdocno")+" :: "+i+" :: "+rsreq.getString("leasefromdate")+" :: "+rsreq.getString("brand")+" :: "+rsreq.getString("model")+" :: "+
							rsreq.getString("color")+" :: "+rsreq.getString("leasemonths")+" :: "+rsreq.getString("kmpermonth")+" :: "+rsreq.getString("gname")+" :: "+rsreq.getString("totalvalue")+" :: "+rsreq.getString("savestatus"));
					*/
					reqarray.add(rsreq.getString("srno")+" :: "+rsreq.getString("brand")+" :: "+rsreq.getString("model")+" :: "+rsreq.getString("leasemonths")+" :: "+rsreq.getString("kmpermonth")+" :: "+rsreq.getString("ratepermonth"));
					//System.out.println(i+reqarray.get(i-1));
					//reqarray.addAll(getCalcDetails(docno, conn, reqarray, i));
					/*System.out.println(reqarray.get(i-1));*/
				}
				
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			return reqarray;
		}
		
		
		public ClsLeaseCalcAlMariahBean getPrintNormal(String docno, HttpServletRequest request) throws SQLException {
			// TODO Auto-generated method stub
			ClsLeaseCalcAlMariahBean bean=new ClsLeaseCalcAlMariahBean();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="select coalesce(br.tinno,'') comptrn,br.branchname,loc.loc_name,m.reqdoc,if(req.reqtype=1,ac.address,req.com_add1) clientaddress,if(req.reqtype=1,ac.com_mob,req.mob) "+
			" clientmobile,if(req.reqtype=1,ac.refname,req.name) refname,m.doc_no docno,m.reqdoc,DATE_FORMAT(m.date,'%d-%m-%Y') date,comp.company,comp.address,"+
			" comp.tel,comp.fax from gl_almariahleasecalcm m left join my_brch br on m.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no left join gl_lprm req on "+
			" (m.reqdoc=req.doc_no) left join my_acbook ac on (req.cldocno=ac.cldocno and ac.dtype='CRM') left join my_locm loc on (br.doc_no=loc.brhid) where "+
			" m.status=3 and m.doc_no="+docno+" limit 1";
			
			System.out.println("---------strsqlcarqut-------"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				bean.setLbldate(rs.getString("date"));
				bean.setLbldocno(rs.getString("docno"));
				bean.setLblleasereqdocno(rs.getString("reqdoc"));
				bean.setLblcompname(rs.getString("company"));
				bean.setLblcompaddress(rs.getString("address"));
				bean.setLblcompfax(rs.getString("fax"));
				bean.setLblcomptel(rs.getString("tel"));
				bean.setLblclient(rs.getString("refname"));
				bean.setLblclientaddress(rs.getString("clientaddress"));
				bean.setLblmob(rs.getString("clientmobile"));
				bean.setLblleasereqdocno(rs.getString("reqdoc"));
				bean.setLblbranch(rs.getString("branchname"));
				bean.setLbllocation(rs.getString("loc_name"));
				bean.setLblcomptrn(rs.getString("comptrn"));
			}
		/*	ArrayList<String> reqarray=new ArrayList<>();
			reqarray=getLeaseReqDetails(docno,conn);
			request.setAttribute("REQPRINT",reqarray);*/
			
			ArrayList<String> reqarray=new ArrayList<>();
			reqarray=getLeaseReqDetails(docno,conn);
			request.setAttribute("REQPRINT", reqarray);
			ArrayList<String> reqdetailarray=new ArrayList<>();
			reqdetailarray=getCalcDetails(docno,conn);
			request.setAttribute("REQDETAILPRINT", reqdetailarray);
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
}
