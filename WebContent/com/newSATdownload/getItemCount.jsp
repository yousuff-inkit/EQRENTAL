<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*"%>
<%
	String totalitemcount=session.getAttribute("TOTALITEMCOUNT")==null?"0":session.getAttribute("TOTALITEMCOUNT").toString();
	String itemcurrentdocno=session.getAttribute("ITEMCURRENTDOCNO")==null?"0":session.getAttribute("ITEMCURRENTDOCNO").toString();
	String itemtype=request.getParameter("itemtype")==null?"":request.getParameter("itemtype");
	String finalcount=request.getParameter("finalcount")==null?"0":request.getParameter("finalcount");
	JSONObject objdata=new JSONObject();
	Connection conn=null;
	int itemcount=0;
	try{
		ClsConnection objconn=new ClsConnection();	
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		if(itemtype.equalsIgnoreCase("Salik")){
			if(!totalitemcount.equalsIgnoreCase("0") && !itemcurrentdocno.equalsIgnoreCase("0")){
				String strsql="select count(*) itemcount from gl_salik where doc_no="+itemcurrentdocno;
				// System.out.println(strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				while(rs.next()){
					itemcount=rs.getInt("itemcount");
				}				
			}
		}
		else if(itemtype.equalsIgnoreCase("Traffic")){
			if(!totalitemcount.equalsIgnoreCase("0") && !itemcurrentdocno.equalsIgnoreCase("0")){
				String strsql="select count(*) itemcount from gl_traffic where doc_no="+itemcurrentdocno;
				ResultSet rs=stmt.executeQuery(strsql);
				while(rs.next()){
					itemcount=rs.getInt("itemcount");
				}
				
			}
		}
		objdata.put("itemcurrentdocno",itemcurrentdocno);
		if(finalcount.trim().equalsIgnoreCase("1")){
			objdata.put("totalitemcount",itemcount);	
		}
		else{
			objdata.put("totalitemcount",totalitemcount);
		}
		
		objdata.put("itemcount",itemcount);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(objdata+"");
%>