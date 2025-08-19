package com.sayaraInternal;



import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAndroid {
	 ClsConnection  ClsConnection =new ClsConnection();
	 ClsCommon   ClsCommon =new ClsCommon();
	 //first fleet
	public JSONArray fleetstatus1(String brnchval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        ClsConnection  ClsConnection =new ClsConnection();
        
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            		//String sql="select ST.ST_DESC,count(*) VALUE,VEH.tran_code from gl_vehmaster VEH LEFT JOIN GL_STATUS ST ON  (VEH.tran_code=ST.STATUS) where VEH.statu=3  and VEH.fstatus<>'Z' GROUP BY VEH.tran_code ";
           
            	/*	String sql="select * from (select ST.ST_DESC,convert(count(*),char(10)) VALUE,VEH.tran_code from gl_vehmaster VEH  	LEFT JOIN GL_STATUS ST ON\r\n" + 
            				"   (VEH.tran_code=ST.STATUS) where VEH.statu=3	and VEH.fstatus<>'Z' GROUP BY VEH.tran_code) aa\r\n" + 
            				" 	union all (select 'All' ST_DESC, convert('',char(10)) VALUE,'KK' tran_code)";
*/

            		String sql="select aa.st_desc,aa.value,aa.tran_code,convert(round((aa.value/bb.value)*100,2),char(10)) per from\r\n" + 
            				"(select ST.ST_DESC,convert(count(*),char(10)) VALUE,VEH.tran_code from gl_vehmaster VEH  	LEFT JOIN GL_STATUS ST ON\r\n" + 
            				"   (VEH.tran_code=ST.STATUS) where VEH.statu=3	and VEH.fstatus<>'Z' GROUP BY VEH.tran_code) aa\r\n" + 
            				",(select 'All' ST_DESC, convert(count(*),char(10)) VALUE,'KK' tran_code from gl_vehmaster where statu=3  and fstatus<>'Z') bb\r\n" + 
            				"union all\r\n" + 
            				"select 'Total' ST_DESC, convert(count(*),char(10)) VALUE,'KK' tran_code, '' per from gl_vehmaster where statu=3  and fstatus<>'Z'\r\n" + 
            				"union all\r\n" + 
            				"select 'Rented' ST_DESC, convert(count(*),char(10)) VALUE,'KK' tran_code, '' per from gl_vehmaster where statu=3  and fstatus<>'Z' and tran_code in ('RA','LA')\r\n" ;
            		
           			System.out.println("--fleet--"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{				 
            		/*String sql= ("select ST.ST_DESC,count(*) VALUE,VEH.tran_code from gl_vehmaster VEH "
					+ "LEFT JOIN GL_STATUS ST ON(VEH.tran_code=ST.STATUS)  where VEH.a_br='"+brnchval+"' and  VEH.statu=3  and VEH.fstatus<>'Z' GROUP BY VEH.tran_code ");*/
            		String sql="select * from (select ST.ST_DESC,convert(count(*),char(10)) VALUE,VEH.tran_code from gl_vehmaster VEH  	LEFT JOIN GL_STATUS ST ON\r\n" + 
            				"   (VEH.tran_code=ST.STATUS) where VEH.statu=3	and VEH.fstatus<>'Z' and VEH.a_br='"+brnchval+"' GROUP BY VEH.tran_code) aa\r\n" + 
            				" 	union all (select 'All' ST_DESC,  convert('',char(10)) VALUE,'KK' tran_code)";
            		
            	/*	String sql="select * from (select 'All' ST_DESC,  count(*) VALUE,'' from gl_vehmaster where statu=3 and fstatus<>'Z' and a_br='"+brnchval+"') aa   "
            				+ "	union all (select ST.ST_DESC,count(*) VALUE,VEH.tran_code from gl_vehmaster VEH  "
            				+ "	LEFT JOIN GL_STATUS ST ON  (VEH.tran_code=ST.STATUS) where VEH.statu=3	and VEH.fstatus<>'Z' and VEH.a_br='"+brnchval+"' GROUP BY VEH.tran_code) ";

            		*/
            	 //	System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            	 
 				stmtVeh.close();
 			
            	}
            	System.out.println("RESULTDATA"+RESULTDATA);
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
//		System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	
public String getFuelvalue(String fuelName) {
	    
	    String fuel="";
	 if(fuelName.equalsIgnoreCase("item 8/8"))
	 {
	  fuel="1.000"; 
	 }
	 else if(fuelName.equalsIgnoreCase("item 7/8"))
	 {
	  fuel="0.875"; 
	 } 
	 else if(fuelName.equalsIgnoreCase("item 6/8"))
	 {
	  fuel="0.750"; 
	 } 
	 else if(fuelName.equalsIgnoreCase("item 5/8"))
	 {
	  fuel="0.625"; 
	 } 
	 else if(fuelName.equalsIgnoreCase("item 4/8"))
	 {
	  fuel="0.500"; 
	 } 
	 else if(fuelName.equalsIgnoreCase("item 3/8"))
	 {
	  fuel="0.375"; 
	 } 
	 else if(fuelName.equalsIgnoreCase("item 2/8"))
	 {
	  fuel="0.250"; 
	 } 
	 
	 else if(fuelName.equalsIgnoreCase("item 1/8"))
	 {
	  fuel="0.125"; 
	 } 
	 
	 else 
	 {
	  fuel="0.000"; 
	 } 
	 return fuel;
	    }






public String gettype(String type) {
    
    String fuel="";
 if(type.equalsIgnoreCase("CASH"))
 {
  fuel="1"; 
 }
 else if(type.equalsIgnoreCase("CARD"))
 {
  fuel="2"; 
 } 
 else if(type.equalsIgnoreCase("CHEQUE"))
 {
  fuel="3"; 
 } 
 
 
 return fuel;
    }


public int randInt(int min, int max) {

    // Usually this can be a field rather than a method variable
    Random rand = new Random();

    // nextInt is normally exclusive of the top value,
    // so add 1 to make it inclusive
    int randomNum = rand.nextInt((max - min) + 1) + min;

    return randomNum;
}



public JSONObject convertToJSON()
		throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		JSONObject obj = new JSONObject();
		
			 /*obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), (resultSet.getObject(i + 1)==null) ? "NA" : ((resultSet.getObject(i + 1).equals("0.0000")) ? " " : (resultSet.getObject(i + 1).toString()).replaceAll("[^a-zA-Z0-9_-_._; ]", " ")));*/
			 obj.put("error",false);
			 obj.put("message","SMS request is initiated! You will be receiving it shortly.");
		//	obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "" : resultSet.getObject(i + 1).toString().replaceAll("[^\\w\\s\\-_]", "")));
			
		
		jsonArray.add(obj);
		

		//System.out.println("ConvertTOJson:   "+jsonArray);
		return obj;
		}


public JSONObject convertTToJSON()
		throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		JSONObject obj = new JSONObject();
		
			 /*obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), (resultSet.getObject(i + 1)==null) ? "NA" : ((resultSet.getObject(i + 1).equals("0.0000")) ? " " : (resultSet.getObject(i + 1).toString()).replaceAll("[^a-zA-Z0-9_-_._; ]", " ")));*/
			 obj.put("error",true);
			 obj.put("message","Sorry! Error occurred in registration.");
		//	obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "" : resultSet.getObject(i + 1).toString().replaceAll("[^\\w\\s\\-_]", "")));
			
		
		jsonArray.add(obj);
		

		//System.out.println("ConvertTOJson:   "+jsonArray);
		return obj;
		}

	
	
	
	
	
	
	
	
	
	
	public JSONArray fleet_search(String branch,String regno) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
	 try {
	  conn=ClsConnection.getMyConnection();
	  
	  Statement stmtmovement = conn.createStatement();
	         String strSql="select fleet_no,reg_no,code_name from gl_vehmaster v inner join gl_vehplate p on v.pltid=p.doc_no where fstatus='L' and statu<>7 and v.status='OUT'and v.reg_no like '%"+regno+"%' and tran_code!='DL';";
	           
	         System.out.println(strSql);
	   ResultSet resultSet = stmtmovement.executeQuery(strSql);
	   RESULTDATA=ClsCommon.convertToJSON(resultSet);
//	   System.out.println(RESULTDATA);
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
	// System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	public JSONArray otpverification(String otp) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
	 try {
	  conn=ClsConnection.getMyConnection();
	  JSONObject obj = new JSONObject();
	  Statement stmtmovement = conn.createStatement();
	         String strSql="SELECT * FROM users where apikey="+otp;
	           
	         System.out.println(strSql);
	   ResultSet resultSet = stmtmovement.executeQuery(strSql);
	   RESULTDATA=ClsCommon.convertToJSON(resultSet);
//	   System.out.println(RESULTDATA);
	    if(RESULTDATA.size()>=1){
	    	
	    	
	    	System.out.println(RESULTDATA.size());
	   String strSqll="insert into usersregistration SELECT * FROM users where apikey="+otp;
	   stmtmovement.executeUpdate(strSqll);
	   
	   
		 RESULTDATA.add(obj);
	    
	    }else{
	    	
	    	JSONObject objj = new JSONObject();
			
	    	
			 objj.put("name","null");
			 objj.put("email","null");
			 objj.put("mobile","null");
		
		
		
			 RESULTDATA.add(objj);
		

		//System.out.println("ConvertTOJson:   "+jsonArray);
		return RESULTDATA;
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
	// System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	   
	    	}
	
	
	
	
	
	
	
	
	
	
	
	public JSONArray fleet_searchh(String branch,String regno) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
	 try {
	  conn=ClsConnection.getMyConnection();
	  
	  Statement stmtmovement = conn.createStatement();
	         String strSql="select fleet_no,reg_no,code_name from gl_vehmaster v inner join gl_vehplate p on v.pltid=p.doc_no where  fstatus='L' and statu<>7 and  v.status='OUT' and  v.Tran_code='RA' and v.reg_no like '%"+regno+"%' order by v.reg_no";
	           
	         System.out.println(strSql);
	   ResultSet resultSet = stmtmovement.executeQuery (strSql);
	   RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	// System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	
	
	
	public JSONArray branchsearch(String branch,String regno) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
	 try {
	  conn=ClsConnection.getMyConnection();
	  
	  Statement stmtmovement = conn.createStatement();
	         String strSql="select branchname,doc_no from my_brch where status=3 and branchname like '%"+regno+"%'";
	           
	         System.out.println(strSql);
	   ResultSet resultSet = stmtmovement.executeQuery (strSql);
	   RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	// System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	
	
	
	public JSONArray branchcollectionsearch(String branch,String regno) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
	 try {
	  conn=ClsConnection.getMyConnection();
	  
	  Statement stmtmovement = conn.createStatement();
	         String strSql="select * from (SELECT 'All' ,0 value union all select branchname,doc_no from my_brch where status=3  ) b;";
	           
	         System.out.println(strSql);
	   ResultSet resultSet = stmtmovement.executeQuery(strSql);
	   RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	// System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}

	
	
	
	
	
	
	
	
	
	//Collection RegNo and Fleet No
	
	public JSONArray collectionsearch(String branch,String regno) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
	 try {
	  conn=ClsConnection.getMyConnection();
	  
	  Statement stmtmovement = conn.createStatement();
	         String strSql="select v.fleet_no,m.reg_no,code_name  from gl_vehpickup v inner join gl_vehmaster m on v.fleet_no=m.fleet_no inner join gl_vehplate p on m.pltid=p.doc_no where fstatus='L' and statu<>7 and m.status='OUT'and m.reg_no like '%"+regno+"%' and tran_code!='DL' and v.clstatus=0;";
	                       
	         System.out.println(strSql);
	   ResultSet resultSet = stmtmovement.executeQuery (strSql);
	   RESULTDATA=ClsCommon.convertToJSON(resultSet);
	   System.out.println("coleection result:"+RESULTDATA);
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
	// System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	//Delivery RegNo and Fleet No
	public JSONArray collectionnsearch(String branch,String regno) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
	 try {
	  conn=ClsConnection.getMyConnection();
	  
	  Statement stmtmovement = conn.createStatement();
//	         String strSql="select aa.* from (select v.fleet_no,v.reg_no,plate.code_name from gl_ragmt r left join gl_vehmaster v on r.fleet_no=v.fleet_no left join gl_vehplate plate on v.pltid=plate.doc_no where r.clstatus=0 and r.delstatus=0 and r.delivery=1 and v.reg_no like '%"+regno+"%' union all select veh.fleet_no,veh.reg_no,plate.code_name from gl_vehcustody c left join gl_vehmaster veh on c.fleet_no=veh.fleet_no left join gl_vehplate plate on veh.pltid=plate.doc_no  where c.rtype='RAG' and c.delivery=1 and c.delstatus is null and veh.reg_no like '%"+regno+"%' ) aa ;";
	  String strSql="select aa.* from ( select v.fleet_no,v.reg_no,plate.code_name from gl_ragmt r left join gl_vehmaster v on r.fleet_no=v.fleet_no left join gl_vehplate plate on v.pltid=plate.doc_no where r.clstatus=0 and r.delstatus=0 and r.delivery=1 and v.reg_no like '%%' union all"
			  +" select veh.fleet_no,veh.reg_no,plate.code_name from gl_vehcustody c left join gl_vehmaster veh on c.fleet_no=veh.fleet_no left join gl_vehplate plate on veh.pltid=plate.doc_no where c.rtype='RAG' and c.delivery=1 and c.delstatus is null and veh.reg_no like '%%' union all"
			  +" select v.fleet_no,v.reg_no,plate.code_name from gl_lagmt r left join gl_vehmaster v on r.perfleet=v.fleet_no or r.tmpfleet=v.fleet_no left join gl_vehplate plate on v.pltid=plate.doc_no where r.clstatus=0 and r.delstatus=0 and r.delivery=1 and v.reg_no like '%%' ) aa  ;"; 
	         System.out.println(strSql);
	   ResultSet resultSet = stmtmovement.executeQuery (strSql);
	   RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	// System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	
	
	
	
	
	
	public JSONArray clientsearch(String branch,String regno) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
	 try {
	  conn=ClsConnection.getMyConnection();
	  
	  Statement stmtmovement = conn.createStatement();
	         String strSql="select refname,doc_no from my_acbook where dtype='CRM' and status=3 and refname like '%"+regno+"%'";
	           
	         System.out.println(strSql);
	   ResultSet resultSet = stmtmovement.executeQuery (strSql);
	   RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	// System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	
	
	public JSONArray cardsearch(String branch,String regno) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
	 try {
	  conn=ClsConnection.getMyConnection();
	  
	  Statement stmtmovement = conn.createStatement();
	         String strSql="select doc_no,mode from my_cardm where dtype='card' and mode like '%"+regno+"%'";
	           
	         System.out.println(strSql);
	   ResultSet resultSet = stmtmovement.executeQuery (strSql);
	   RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	// System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public JSONArray inspection(String name) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(name.equalsIgnoreCase("b"))
            	{
            		//String sql="select ST.ST_DESC,count(*) VALUE,VEH.tran_code from gl_vehmaster VEH LEFT JOIN GL_STATUS ST ON  (VEH.tran_code=ST.STATUS) where VEH.statu=3  and VEH.fstatus<>'Z' GROUP BY VEH.tran_code ";
           
            	/*	String sql="select * from (select ST.ST_DESC,convert(count(*),char(10)) VALUE,VEH.tran_code from gl_vehmaster VEH  	LEFT JOIN GL_STATUS ST ON\r\n" + 
            				"   (VEH.tran_code=ST.STATUS) where VEH.statu=3	and VEH.fstatus<>'Z' GROUP BY VEH.tran_code) aa\r\n" + 
            				" 	union all (select 'All' ST_DESC, convert('',char(10)) VALUE,'KK' tran_code)";
*/

            		String sql="SELECT SR_NO,NAME FROM GL_INSPECTION WHERE STATUS=3";
            		
//            			System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	
            	
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
//		System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	
	/*public JSONArray rentalreport(String name) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(name.equalsIgnoreCase("d"))
            	{
            		//String sql="select ST.ST_DESC,count(*) VALUE,VEH.tran_code from gl_vehmaster VEH LEFT JOIN GL_STATUS ST ON  (VEH.tran_code=ST.STATUS) where VEH.statu=3  and VEH.fstatus<>'Z' GROUP BY VEH.tran_code ";
           
            		String sql="select * from (select ST.ST_DESC,convert(count(*),char(10)) VALUE,VEH.tran_code from gl_vehmaster VEH  	LEFT JOIN GL_STATUS ST ON\r\n" + 
            				"   (VEH.tran_code=ST.STATUS) where VEH.statu=3	and VEH.fstatus<>'Z' GROUP BY VEH.tran_code) aa\r\n" + 
            				" 	union all (select 'All' ST_DESC, convert('',char(10)) VALUE,'KK' tran_code)";


            		String sql="select (select count(*) from gl_ragmt where odate>='2016-02-01' and odate<='2016-02-01' and brhid=3 ) open, (select count(*) from gl_ragmtclosem where indate>='2016-01-01' and indate<='2016-02-01' and brchid=3)close;";
            		
//            			System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	
            	
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
//		System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	*/
	
	
	
	
	
	
	
	
	
	
	
	public JSONArray check(String name) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(name.equalsIgnoreCase(""))
            	{
            		//String sql="select ST.ST_DESC,count(*) VALUE,VEH.tran_code from gl_vehmaster VEH LEFT JOIN GL_STATUS ST ON  (VEH.tran_code=ST.STATUS) where VEH.statu=3  and VEH.fstatus<>'Z' GROUP BY VEH.tran_code ";
           
            	/*	String sql="select * from (select ST.ST_DESC,convert(count(*),char(10)) VALUE,VEH.tran_code from gl_vehmaster VEH  	LEFT JOIN GL_STATUS ST ON\r\n" + 
            				"   (VEH.tran_code=ST.STATUS) where VEH.statu=3	and VEH.fstatus<>'Z' GROUP BY VEH.tran_code) aa\r\n" + 
            				" 	union all (select 'All' ST_DESC, convert('',char(10)) VALUE,'KK' tran_code)";
*/

            		String sql="select if(rdtype='RAG',r.voc_no,if(rdtype='LAG',l.voc_no,v.rdocno)) rdocno,rdtype,obrhid,v.status, if(rdtype='RAG',a.refname,if(rdtype='LAG',a.refname,s.sal_name )) refname from gl_vmove v left join gl_ragmt r on r.doc_no=v.rdocno and v.rdtype='RAG' left join gl_lagmt l on l.doc_no=v.rdocno and v.rdtype='LAG' left join my_acbook a on a.doc_no=r.cldocno or a.doc_no=l.cldocno left join my_salesman s on s.doc_no=v.emp_id and s.sal_type=v.emp_type where v.doc_no = (select max(doc_no) from gl_vmove where rdtype in ('RAG','LAG','MOV') and fleet_no=10666 and status='IN');";
            		
//            			System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	
            	
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
//		System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//Fleet with RegNo and Idle
	public   JSONArray searchVehgrid(String brnchval,String type,String val,String tran) throws SQLException {
		
		System.out.println("???..."+brnchval+"?::::"+type+":::val:::"+val+"::::"+tran);
		
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
				String sql1="";
				String sql2="";
				if(tran.equalsIgnoreCase("GA")){     
					sql2=" if(vm.status='OUT',dateDIFF( curdate(),vm.dout),0) ideal ";
//					System.out.println("=====ga==== "+type);	
						
				}else if(tran.equalsIgnoreCase("GS")){     
					sql2=" if(vm.status='OUT',dateDIFF( curdate(),vm.dout),0) ideal ";
//					System.out.println("========= "+type);	
						
				}else if(tran.equalsIgnoreCase("Gm")){     
					sql2=" if(vm.status='OUT',dateDIFF( curdate(),vm.dout),0) ideal ";
//					System.out.println("========= "+type);	
						
				}else {     
					sql2=" if(vm.status='IN',dateDIFF( curdate(),vm.din),0) ideal ";
//					System.out.println("========= "+type);	
						
				}
				
			
				// brand
				System.out.println("=====type==== "+type);
				if(type.equalsIgnoreCase("1")){     
					sql1=" and m.brdid= '"+val+"' ";
//					System.out.println("========= "+type);	
						
				}
				// model
				else if(type.equalsIgnoreCase("2")){
					sql1=" and m.vmodid= '"+val+"' ";
					
						
				}
				// yom
				else if(type.equalsIgnoreCase("3")){
					sql1=" and m.yom= '"+val+"' ";
				
						
				}
				//ResultSet resultSet ;
				System.out.println("====sql1====="+sql1);
				
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            	
            	//	brn,model,regno,pltid,km age,yom
            		
            		/*String sql="select m.REG_NO,convert(if(vm.status='OUT',round(vm.kmout),if(vm.status='IN',round(vm.kmin),m.cur_km)),char(40)) km   ,y.YOM,b.brand_name,mo.vtype model,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM curdate()),  EXTRACT( YEAR_MONTH FROM vv.din)) age,"+sql2+"from gl_vehmaster m   left join gl_vehbrand b on(m.brdid=b.doc_no) left join gl_vehmodel mo on mo.doc_no=m.vmodid  left join gl_yom y on y.doc_no=m.yom left join gl_vmove vm on(vm.fleet_no=m.fleet_no and vm.doc_no=(select max(doc_no) from gl_vmove  where fleet_no=m.fleet_no )) left join gl_vmove vv on (vv.fleet_no=m.fleet_no and vv.rdtype='VEH' and vv.trancode='"+tran+"' and vv.status='IN') where m.tran_code='"+tran+"' and  m.statu=3 and m.fstatus<>'Z'"+sql1;
            		*/
            		
            		String sql="select m.REG_NO,convert(if(vm.status='OUT',round(vm.kmout),if(vm.status='IN',round(vm.kmin),m.cur_km)),char(40)) km   ,y.YOM,b.brand_name,mo.vtype model,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM curdate()),  EXTRACT( YEAR_MONTH FROM coalesce(vm.din,vm.dout))) age,"+sql2+"from gl_vehmaster m   left join gl_vehbrand b on(m.brdid=b.doc_no) left join gl_vehmodel mo on mo.doc_no=m.vmodid  left join gl_yom y on y.doc_no=m.yom left join gl_vmove vm on(vm.fleet_no=m.fleet_no and vm.doc_no=(select max(doc_no) from gl_vmove  where fleet_no=m.fleet_no )) where m.tran_code='"+tran+"' and  m.statu=3 and m.fstatus<>'Z'"+sql1;
            		
            		           			System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{				 

            		
            		String sql="select m.REG_NO,convert(if(vm.status='OUT',round(vm.kmout),if(vm.status='IN',round(vm.kmin),m.cur_km)),char(40)) km "
            				+ "  ,y.YOM,b.brand_name,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM curdate()),\r\n" + 
							"	EXTRACT( YEAR_MONTH FROM vv.din)) age from gl_vehmaster m  "
    					       + " left join gl_vehbrand b on(m.brdid=b.doc_no)  left join gl_vehmodel mo on mo.doc_no=m.vmodid "
    						   + " left join gl_yom y on y.doc_no=m.yom left join gl_vmove vm on  "
    						   + "(vm.fleet_no=m.fleet_no and vm.doc_no=(select max(doc_no) from gl_vmove  where fleet_no=m.fleet_no ))"
    						   + "left join gl_vmove vv on (vv.fleet_no=m.fleet_no and vv.rdtype='VEH' and vv.trancode='RR' \r\n" + 
							    "   and vv.status='IN')   "
     					     	+ "  where m.tran_code='"+tran+"' and  m.statu=3 and m.fstatus<>'Z' and m.a_br="+brnchval+" "+sql1;
            		
            		
            		            	 	System.out.println("--b--"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 			
            	}
            	conn.close();

		}
		catch(Exception e){
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	//Fleet details with value and %
	public JSONArray searchVehDeatails(String brnchval,String type,String tran) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
				String sql1="";
				String sql2="";
				String sql3="";
				// brand
//				System.out.println("======= "+type);
				if(type.equalsIgnoreCase("1")){
					sql1=" br.brand_name name, br.doc_no doc, ";
					sql2=" LEFT JOIN GL_vehbrand br ON (VEH.brdid=br.doc_no) ";
					sql3=" GROUP BY VEH.brdid";
						
				}
				// model
				else if(type.equalsIgnoreCase("2")){
					sql1=" br.vtype  name, br.doc_no doc, ";
					sql2=" LEFT JOIN GL_vehmodel br ON (VEH.vmodid=br.doc_no) ";
					sql3=" GROUP BY VEH.vmodid";
						
				}
				// yom
				else if(type.equalsIgnoreCase("3")){
					sql1=" br.yom name, br.doc_no doc, ";
					sql2=" LEFT JOIN GL_yom br ON (VEH.yom=br.doc_no)  ";
					sql3=" GROUP BY VEH.yom";
						
				}
				//ResultSet resultSet ;
				System.out.println("========="+brnchval);
				
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            		//String sql="select ST.ST_DESC,count(*) VALUE,VEH.tran_code from gl_vehmaster VEH LEFT JOIN GL_STATUS ST ON  (VEH.tran_code=ST.STATUS) where VEH.statu=3  and VEH.fstatus<>'Z' GROUP BY VEH.tran_code ";
           
            		String sql="select "+type+" type,name, doc, VALUE, tran_code, round((value/tot)*100,2) per from (select  "+sql1+" convert(count(*),char(10)) VALUE,VEH.tran_code from gl_vehmaster VEH "+sql2+" where VEH.statu=3 and VEH.fstatus<>'Z' and VEH.tran_code='"+tran+"' "+sql3+") b, (select count(*) tot from gl_vehmaster VEH "+sql2+" where VEH.statu=3 and VEH.fstatus<>'Z' and VEH.tran_code='"+tran+"')a";
            		
            		
            		
            			System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{				 
            		String sql="select "+sql1+" convert(count(*),"+type+"char(10)) VALUE,VEH.tran_code from gl_vehmaster VEH"
            				+ " "+sql2+" where VEH.statu=3 and VEH.fstatus<>'Z' and VEH.tran_code='"+tran+"' and veh.a_br="+brnchval+" "+sql3;
            		            	 	System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 			
            	}
            	System.out.println("result:"+RESULTDATA);
            	conn.close();

		}
		catch(Exception e){
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	

	public String  del_flchk(String fleet) throws SQLException {
		
		System.out.println("-in-");

		
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();

            		String sql="select 'RAG' chktype,r.voc_no,convert(r.brhid,char(20)) brhid, r.doc_no,r.date,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ofuel,r.ofuel hidfuel,convert(r.drid,char(20)) drid,v.reg_no,v.flname,a.refname,s.sal_name,v.a_loc,g.doc_no gid,g.gname from gl_ragmt r  " + 
            				"  left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' " + 
            				"  left join my_salesman s on s.doc_no=r.drid and s.sal_type='DRV' left join gl_vehgroup g on g.doc_no=v.vgrpid " + 
            				" where r.clstatus=0 and r.delstatus=0 and r.delivery=1 and r.fleet_no='"+fleet+"' " ;
            		
         			System.out.println("-asdsa---"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		
            		
            		if(resultSet.next())
            		{
            			return "true";
            		}
            		
            		 
     				stmtVeh.close();
     				
            	
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
//		System.out.println(RESULTDATA);
        return "false";
    }


}
