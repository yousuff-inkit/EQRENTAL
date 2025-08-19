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
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	String saveval=request.getParameter("saveval");
	String fleetno = request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
/* 	String tagno = request.getParameter("tagno")==null?"0":request.getParameter("tagno");
	String regno = request.getParameter("regno")==null?"0":request.getParameter("regno");
 */
	Connection conn = null;

 	try{
		conn = ClsConnection.getMyConnection();
	 	Statement stmt = conn.createStatement ();
	 	String tagno ="",regno="";
 		if(!fleetno.equalsIgnoreCase("")){
 			String strgetvehdata="select salik_tag,reg_no from gl_vehmaster where statu=3 and fleet_no="+fleetno;
 			ResultSet rsgetvehdata=stmt.executeQuery(strgetvehdata);
 			while(rsgetvehdata.next()){
 				tagno=rsgetvehdata.getString("salik_tag");
 				regno=rsgetvehdata.getString("reg_no");
 			}
 		}
 		String sqltest="";

		if(!(tagno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and s.tagno='"+tagno+"'";
		}
		if(!(regno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and s.regno='"+regno+"' ";
		}
	 		String upsql=null;

	 		int val=0;

			ArrayList<String> rowValues= new ArrayList<String>();	
  
	            //Getting Config for blocking Replacement Vehicles in Salik
	            int blockreplaced=0;
	            String strconfig="select method from gl_config where field_nme='blockSalikReplace'";
	            ResultSet rsconfig=stmt.executeQuery(strconfig);
	            while(rsconfig.next()){
	            	blockreplaced=rsconfig.getInt("method");
	            }
	            String replacedfleets="(",sqlexcludefleets="";
	            if(blockreplaced==1){
	            	int i=0;
	            	String strgetreplacedfleet="select coalesce(rfleetno,'') rfleetno,coalesce(ofleetno,'') ofleetno from gl_vehreplace where closestatus=0 and status=3";
	            	ResultSet rsgetreplacedfleet=stmt.executeQuery(strgetreplacedfleet);
	            	while(rsgetreplacedfleet.next()){
	            		if(i==0){
		            		if(!rsgetreplacedfleet.getString("rfleetno").equalsIgnoreCase("")){
		            			replacedfleets+=rsgetreplacedfleet.getString("rfleetno");
		            		}
	            		}
	            		else{
	            			if(!rsgetreplacedfleet.getString("rfleetno").equalsIgnoreCase("")){
		            			replacedfleets+=","+rsgetreplacedfleet.getString("rfleetno");
		            		}
	            		}
	            		if(!rsgetreplacedfleet.getString("ofleetno").equalsIgnoreCase("")){
	            			replacedfleets+=","+rsgetreplacedfleet.getString("ofleetno");
	            		}
	            		i++;
	            	}
	            	replacedfleets+=")";
	            	if(i>0){
	            		sqlexcludefleets+=" and v1.fleet_no not in "+replacedfleets+"";
	            	}
	            }
	            	saveval="11";
	            	String sqlup1=" update  gl_salik s left join gl_vehmaster v1 on v1.salik_tag=s.tagno "
	            		+" left join gl_vmove v  on v.fleet_no=v1.fleet_no  and v.rdtype!='vsc' and s.salik_date between cast(concat(v.dout,' ',v.tout) as datetime) and coalesce(cast(concat(din,' ',tin) as datetime),now()) "
	            		+" set isallocated=IF(V.EMP_ID IS NULL,0,1),reason=IF(V.EMP_ID IS NULL,'','Allocated') ,ra_no=v.rdocno,s.rtype=v.trancode,s.emp_id=v.emp_id,s.emp_type=v.emp_type, fleetno=v.fleet_no "
	            		+"  where s.isallocated=0 and s.status in (0,3)  and v1.fleet_no is not null   "+sqltest+" "+sqlexcludefleets;
	        	System.out.println("==== sqlup1 === "+sqlup1);
	            		stmt.executeUpdate(sqlup1);
	            
	 				String sqlup="update gl_salik s  left join gl_vehmaster veh on veh.salik_tag=s.tagno "+
				 				" set reason='Fleet Not Recognize' where isallocated=0 and s.status in (0,3)  and veh.fleet_no is null ";
				 	stmt.executeUpdate(sqlup);
	       			stmt.close();
 	         		conn.close();					
		 			response.getWriter().print(saveval);
	 
 			}
	 	catch(Exception e)
	 		{
				e.printStackTrace();
				conn.close();
				response.getWriter().print("12");
			}

	 	
	 	
	 	
		%>
