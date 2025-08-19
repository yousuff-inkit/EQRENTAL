<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	ResultSet rs=null;
	ResultSet rs2=null;
	Statement stmt=null;
	try{
		conn = ClsConnection.getMyConnection();
		stmt = conn.createStatement();
		String strSql1 = "select '1 - 10' cat,coalesce(sum(value),0) value,count(*) count from(select round(sum(coalesce(sr.total,0)),2) value from tr_servicereqm m left join tr_srtour sr on sr.rdocno=m.doc_no where status=3  and sr.xodoc=0 and datediff(current_date,m.date) between  1 and 10  group by m.doc_no)a union all select '10 - 20' cat,coalesce(sum(value),0) value,count(*) count from(select round(sum(coalesce(sr.total,0)),2) value from tr_servicereqm m left join tr_srtour sr on sr.rdocno=m.doc_no where status=3  and sr.xodoc=0 and datediff(current_date,m.date) between  10 and 20  group by m.doc_no)a union all select '20 - 30' cat,coalesce(sum(value),0) value,count(*) count from(select round(sum(coalesce(sr.total,0)),2) value from tr_servicereqm m left join tr_srtour sr on sr.rdocno=m.doc_no where status=3  and sr.xodoc=0 and datediff(current_date,m.date) between  20 and 30  group by m.doc_no)a union all select '30 - 40' cat,coalesce(sum(value),0) value,count(*) count from(select round(sum(coalesce(sr.total,0)),2) value from tr_servicereqm m left join tr_srtour sr on sr.rdocno=m.doc_no where status=3  and sr.xodoc=0 and datediff(current_date,m.date) between  30 and 40  group by m.doc_no)a union all select '>40' cat,coalesce(sum(value),0) value,count(*) count from(select round(sum(coalesce(sr.total,0)),2) value from tr_servicereqm m left join tr_srtour sr on sr.rdocno=m.doc_no where status=3  and sr.xodoc=0 and datediff(current_date,m.date)>40  group by m.doc_no)a";  
		System.out.println("strSql1=="+strSql1);  
		rs = stmt.executeQuery(strSql1);
		String cat="",purcount="",purvalue="",invcount="",invvalue="";  
		int i=0;  
		while(rs.next()) {  
			if(i==0){
				    cat+=rs.getString("cat");  
				    purcount+=rs.getString("count");
				    purvalue+=rs.getString("value");
				}else{
					cat+="#"+rs.getString("cat");
					purcount+="#"+rs.getString("count");  
					purvalue+="#"+rs.getString("value");  
			} 
			i++;
			}
		String strSql2 = "select '1 - 10' cat,coalesce(sum(value),0) value,count(*) count from(select round(sum(coalesce(sr.total,0)),2) value from tr_servicereqm m left join tr_srtour sr on sr.rdocno=m.doc_no where status=3  and m.invtrno=0 and datediff(current_date,m.date) between  1 and 10  group by m.doc_no)a union all select '10 - 20' cat,coalesce(sum(value),0) value,count(*) count from(select round(sum(coalesce(sr.total,0)),2) value from tr_servicereqm m left join tr_srtour sr on sr.rdocno=m.doc_no where status=3  and m.invtrno=0 and datediff(current_date,m.date) between  10 and 20  group by m.doc_no)a union all select '20 - 30' cat,coalesce(sum(value),0) value,count(*) count from(select round(sum(coalesce(sr.total,0)),2) value from tr_servicereqm m left join tr_srtour sr on sr.rdocno=m.doc_no where status=3  and m.invtrno=0 and datediff(current_date,m.date) between  20 and 30  group by m.doc_no)a union all select '30 - 40' cat,coalesce(sum(value),0) value,count(*) count from(select round(sum(coalesce(sr.total,0)),2) value from tr_servicereqm m left join tr_srtour sr on sr.rdocno=m.doc_no where status=3  and m.invtrno=0 and datediff(current_date,m.date) between  30 and 40  group by m.doc_no)a union all select '>40' cat,coalesce(sum(value),0) value,count(*) count from(select round(sum(coalesce(sr.total,0)),2) value from tr_servicereqm m left join tr_srtour sr on sr.rdocno=m.doc_no where status=3  and m.invtrno=0 and datediff(current_date,m.date)>40  group by m.doc_no)a";
		System.out.println("strSql2=="+strSql2);  
		rs2 = stmt.executeQuery(strSql2);
		int j=0;
		while(rs2.next()) {  
			if(j==0){
					invcount+=rs2.getString("count");        
					invvalue+=rs2.getString("value");
				}else{
					invcount+="#"+rs2.getString("count");
					invvalue+="#"+rs2.getString("value");  
			} 
			j++;
			}
		response.getWriter().write(cat+"####"+purcount+"####"+purvalue+"####"+invcount+"####"+invvalue);
		stmt.close();
		conn.close();
		rs.close(); 
		rs2.close();   
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}
	finally {
		if (rs != null) try { rs.close(); } catch (SQLException ignore) {} 
		if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
		if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
		}
  %>
  