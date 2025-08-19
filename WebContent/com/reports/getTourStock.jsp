<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	ResultSet rs=null;
	Statement stmt=null;
	try{
		conn = ClsConnection.getMyConnection();
		stmt = conn.createStatement();
		String strSql1 = "select adult,child,name from(select tr.name,sum(coalesce(st.adult,0)) adult,sum(coalesce(st.child,0)) child from tr_tourstock st left join tr_tours tr on tr.doc_no=st.tourid group by tourid) a where (a.adult!=0 and a.child!=0)";  
		System.out.println("strSql1=="+strSql1);  
		rs = stmt.executeQuery(strSql1);
		String cat="",purcount="",purvalue="";  
		int i=0;  
		while(rs.next()) {  
			if(i==0){
				    cat+=rs.getString("name");
				    purcount+=rs.getString("adult");
				    purvalue+=rs.getString("child");
				}else{
					cat+="#"+rs.getString("name");
					purcount+="#"+rs.getString("adult");  
					purvalue+="#"+rs.getString("child");  
			  } 
			i++;
			}
		response.getWriter().write(cat+"####"+purcount+"####"+purvalue);   
		stmt.close();
		conn.close();
		rs.close(); 
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
  