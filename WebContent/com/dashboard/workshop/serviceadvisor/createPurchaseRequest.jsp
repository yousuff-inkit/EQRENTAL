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
<%@page import="com.procurement.purchase.purchaserequest.ClsPurchaserequestDAO"%> 
<%@page import="java.text.SimpleDateFormat" %>  
<%	

ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	Statement stmt=null;
	ClsPurchaserequestDAO sdao= new ClsPurchaserequestDAO();

	try{
	 	conn = ClsConnection.getMyConnection();
	 	
		stmt = conn.createStatement();
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
		String dt=sdf.format(new java.util.Date());
		java.sql.Date sqlDate= ClsCommon.changeStringtoSqlDate(dt);
		
		String refno=request.getParameter("refno")==null?"":request.getParameter("refno");
		String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
		String purchaserequestarray=request.getParameter("purchaserequestarray")==null?"":request.getParameter("purchaserequestarray");
	
 		String temp="0";
	
		conn.setAutoCommit(false);

		ArrayList<String> descarray= new ArrayList<String>();
		
		String spltpurreq[]=purchaserequestarray.split(","); 
     	for(int i=0;i<spltpurreq.length;i++)
		{
			String tempi=spltpurreq[i];
			descarray.add(tempi);
		}
		
		int reqval=sdao.insert(sqlDate, refno, desc, session, "A", "PR", request, descarray,0,0);
		if(reqval>0)
		{
			 temp=String.valueOf(reqval);
			 conn.commit();
		}
		
		response.getWriter().print(temp);
 	
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   stmt.close();
	   conn.close();
   }
%>
