<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    Connection conn = null;      
	JSONObject objupload=new JSONObject();
	String refdocno=request.getParameter("refdocno")==null?"0":request.getParameter("refdocno").toString();
	String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype").toString();
	try{	
		ClsConnection ClsConnection=new ClsConnection();
		conn= ClsConnection.getMyConnection();  
		Statement stmt = conn.createStatement ();  
		String strattach="";
		if(!reftype.equalsIgnoreCase("CREG")){
			strattach="select sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.clientview=1 and a.doc_no="+refdocno+" and a.dtype='"+reftype+"' order by sr_no";
		}
		
		System.out.println("======="+strattach);
		ResultSet rsattach=stmt.executeQuery(strattach);
		ArrayList<String> attacharray=new ArrayList();
		int serial=1;
		while(rsattach.next()){
			attacharray.add(serial+"***"+rsattach.getString("sr_no")+"***"+rsattach.getString("extension")+"***"+rsattach.getString("description")+"***"+rsattach.getString("filename")+"***"+rsattach.getString("path")+"***"+rsattach.getString("type"));
			serial++;
		}
		
		objupload.put("attachdata", attacharray);
		stmt.close();
		conn.close();  

		response.getWriter().print(objupload);        
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
%>