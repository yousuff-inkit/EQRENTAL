<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>   
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
    String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	try{
		JSONObject objdata=new JSONObject();
	 	conn = ClsConnection.getMyConnection();
	 	ClsCommon cmn=new ClsCommon();
		Statement stmt = conn.createStatement();
    	Double tourtot=0.00,transfertot=0.00,total=0.00,netamt=0.00;            
			String strSql = "select coalesce(tr.name,'') name,DATE_FORMAT(t.date,'%d-%m-%Y') date,t.time,coalesce(round(infant,0),0) infant,coalesce(round(adult,0),0) adult,coalesce(round(child,0),0) child,coalesce(round(tvltotal,2),0) tvltotal,coalesce(round(total,2),0) trtotal,coalesce(gp.location,'') ploc,coalesce(gd.location,'') dloc from tr_srtour t left join tr_tours tr on tr.doc_no=t.tourid left join gl_cordinates gp on gp.doc_no=t.plocid left join gl_cordinates gd on gd.doc_no=t.dlocid where rdocno='"+rdocno+"'";     
		    //System.out.println("sql====="+strSql);                      
			ResultSet rs1 = stmt.executeQuery(strSql);
			JSONArray dataarray=new JSONArray();
			while(rs1.next()) {  
				tourtot=rs1.getDouble("trtotal");                     
				transfertot=rs1.getDouble("tvltotal");
				total=tourtot+transfertot; 
				netamt+=total;         
				JSONObject temp=new JSONObject();
				temp.put("tourname",rs1.getString("name"));
				temp.put("date",rs1.getString("date"));
				temp.put("time",rs1.getString("time"));
				temp.put("adult",rs1.getString("adult"));
				temp.put("child",rs1.getString("child"));
				temp.put("infant",rs1.getString("infant"));
				temp.put("ploc",rs1.getString("ploc"));  
				temp.put("dloc",rs1.getString("dloc"));
				temp.put("total",cmn.Round(total,2));      
				dataarray.add(temp);	
			}    
			objdata.put("tourdata", dataarray);    
		    //System.out.println("objdata====="+objdata);   
			response.getWriter().print(dataarray+"::"+netamt);                                       
 		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>