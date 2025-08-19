<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="net.sf.json.*"%>
<%@page import="java.util.Arrays"%>
 <%

String rdoc=request.getParameter("doc");
String type=request.getParameter("hand");
String userid=request.getParameter("userid");
String fleet=request.getParameter("fleet");
String reg=request.getParameter("regfleet");
String desc=request.getParameter("descp");
System.out.println("reg"+reg);
ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
// int i=0;
String value="";
String str="";
JSONArray jsonArray = new JSONArray();
JSONArray jsonArra = new JSONArray();
/* public  JSONArray convertToJSON(ResultSet resultSet)
		throws Exception {
		JSONArray jsonArray = new JSONArray();
		while (resultSet.next()) {
		int total_rows = resultSet.getMetaData().getColumnCount();
		JSONObject obj = new JSONObject();
		for (int i = 0; i < total_rows; i++) {
			 
			 obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "" : resultSet.getObject(i + 1).toString().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ")));
		
			
		}
		jsonArray.add(obj);
		}
		
		return jsonArray;
		} */
		

try
{
	String sqltest="";
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	if(!fleet.equalsIgnoreCase("")){
		sqltest=" and fleetno='"+fleet+"'";
	}
	if(!reg.equalsIgnoreCase("")){
		sqltest=" and regno='"+reg+"'";
	}
	
		str="select content,className,pos,col from an_imgdetails  where form='"+desc+"'"+sqltest;
	
	System.out.println("str:"+str);
	ResultSet resultSet=stmt.executeQuery(str);
	
	/* JSONArray jsonArray = new JSONArray(); */
	while (resultSet.next()) {
	int total_rows = resultSet.getMetaData().getColumnCount();
	JSONObject obj = new JSONObject();
	JSONObject obj1 = new JSONObject();
	for (int i = 0; i < total_rows; i++) {
		 //System.out.println(resultSet.getMetaData().getColumnLabel(i + 1));
		
		 if(resultSet.getMetaData().getColumnLabel(i + 1).equalsIgnoreCase("pos"))
		 {
			 String p=resultSet.getObject(i + 1).toString();
			 /* System.out.println(p); */
			 String[] s=p.split(":");
			 
			 String s1=s[0];
			 String s2=s[1];
			 
			 obj1.put("x",s1);
			 obj1.put("y",s2);
			 obj.put("pos",obj1);
		 }
		 else{
		 
		 obj.put(resultSet.getMetaData().getColumnLabel(i + 1), ((resultSet.getObject(i + 1)==null) ? "" : resultSet.getObject(i + 1).toString().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ")));
		 }
		
	}
	//System.out.println(obj1);
	/* jsonArra.add(obj1); */
	jsonArray.add(obj);
	}
	
	/* while(rs.next())
	{
		if(i==0){
			value+=rs.getString("content")+"::"+rs.getString("classname")+"::"+rs.getString("pos_x")+"::"+rs.getString("pos_y")+"::"+rs.getString("col");	
		}
		else{
			value+=","+rs.getString("content")+"::"+rs.getString("classname")+"::"+rs.getString("pos_x")+"::"+rs.getString("pos_y")+"::"+rs.getString("col");
		}
		i++;
		
	} */
	/* System.out.println("Syst:"+jsonArra); */
	//System.out.println("array:"+jsonArray);
 
}
catch(Exception e)
{
	e.printStackTrace();

}
finally
{
	conn.close();
}

response.getWriter().write(jsonArray.toString());
%>