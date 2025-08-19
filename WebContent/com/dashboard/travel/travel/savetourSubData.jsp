<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%
String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");    
int rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?0:Integer.parseInt(request.getParameter("rdocno").trim().toString());
    
ClsConnection objconn=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;  
String msg="";  
int val=0;
System.out.println("in==="+gridarray);

try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	
	    Statement stmt=conn.createStatement();  
	    ArrayList<String> newarray=new ArrayList();   
		String temparray[]=gridarray.split(",");
		for(int i=0;i<temparray.length;i++){
			newarray.add(temparray[i]);
		}
		System.out.println("peek========"+newarray);		
		for(int i=0;i<newarray.size();i++){
			
			String temp[]=newarray.get(i).split("::");
			
			if(!temp[0].trim().equalsIgnoreCase("undefined") && !temp[0].trim().equalsIgnoreCase("NaN") && !temp[0].trim().equalsIgnoreCase("")){
				
			String name = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"":temp[0].trim()).toString();    
			int age = temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?0:Integer.parseInt(temp[1].trim().toString());
			int height = temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().equalsIgnoreCase("NaN") || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().isEmpty()?0:Integer.parseInt(temp[2].trim().toString());
			int weight = temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().equalsIgnoreCase("NaN") || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().isEmpty()?0:Integer.parseInt(temp[3].trim().toString());
			String remarks = (temp[4].trim().equalsIgnoreCase("undefined") || temp[4].trim().equalsIgnoreCase("NaN") || temp[4].trim().equalsIgnoreCase("") || temp[4].trim().isEmpty()?"":temp[4].trim()).toString();
			int rowsno= temp[5].trim().equalsIgnoreCase("undefined") || temp[5].trim().equalsIgnoreCase("NaN") || temp[5].trim().equalsIgnoreCase("") || temp[5].trim().isEmpty()?0:Integer.parseInt(temp[5].trim().toString());
			System.out.println("rowsno========"+rowsno);	
			if(rowsno>0){                   
				String sql="update tr_srtourd set srno="+(i+1)+",name='"+name+"', age="+age+", height="+height+", weight="+weight+", remarks='"+remarks+"' where rowno="+rowsno+"";   
				System.out.println(sql);
				 val=stmt.executeUpdate(sql);        
			}else{ 
				String sql="insert into tr_srtourd(rdocno, srno, name, age, height, weight,remarks) values("+rdocno+","+(i+1)+",'"+name+"',"+age+","+height+","+weight+",'"+remarks+"')";
				System.out.println(sql);          
				 val=stmt.executeUpdate(sql);   
			}  
			//System.out.println("val==="+val); 
			if(val>0){
				msg="0";
				conn.commit();
			}
		}
		/* conn.commit(); */
	} 
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(msg);
%>