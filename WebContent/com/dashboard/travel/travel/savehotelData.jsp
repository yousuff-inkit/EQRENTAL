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
String todate=request.getParameter("todate")==null || request.getParameter("todate")==""?"0":request.getParameter("todate").trim().toString();
String extrabed=request.getParameter("extrabed")==null || request.getParameter("extrabed")==""?"0":request.getParameter("extrabed").trim().toString();
String mealplan=request.getParameter("mealplan")==null || request.getParameter("mealplan")==""?"0":request.getParameter("mealplan").trim().toString();
String roomid=request.getParameter("roomidhl")==null || request.getParameter("roomidhl")==""?"0":request.getParameter("roomidhl").trim().toString();
String roomtypeid=request.getParameter("roomtypeidhl")==null || request.getParameter("roomtypeidhl")==""?"0":request.getParameter("roomtypeidhl").trim().toString();
String rating=request.getParameter("txtrating")==null || request.getParameter("txtrating")==""?"0":request.getParameter("txtrating").trim().toString();
String hotelid=request.getParameter("hotelid")==null || request.getParameter("hotelid")==""?"0":request.getParameter("hotelid").trim().toString();
String adult=request.getParameter("txtadult")==null || request.getParameter("txtadult")==""?"0":request.getParameter("txtadult").trim().toString();
String child=request.getParameter("txtchild")==null || request.getParameter("txtchild")==""?"0":request.getParameter("txtchild").trim().toString();
String fromdate=request.getParameter("fromdate")==null || request.getParameter("fromdate")==""?"0":request.getParameter("fromdate").trim().toString();
String nationid=request.getParameter("nationid")==null || request.getParameter("nationid")==""?"0":request.getParameter("nationid").trim().toString();
String txtage1=request.getParameter("txtage1")==null || request.getParameter("txtage1")==""?"0":request.getParameter("txtage1").trim().toString();
String txtage2=request.getParameter("txtage2")==null || request.getParameter("txtage2")==""?"0":request.getParameter("txtage2").trim().toString();
String txtage3=request.getParameter("txtage3")==null || request.getParameter("txtage3")==""?"0":request.getParameter("txtage3").trim().toString();
String txtage4=request.getParameter("txtage4")==null || request.getParameter("txtage4")==""?"0":request.getParameter("txtage4").trim().toString();
String txtage5=request.getParameter("txtage5")==null || request.getParameter("txtage5")==""?"0":request.getParameter("txtage5").trim().toString();
String txtage6=request.getParameter("txtage6")==null || request.getParameter("txtage6")==""?"0":request.getParameter("txtage6").trim().toString();
String locid=request.getParameter("locid")==null || request.getParameter("locid")==""?"0":request.getParameter("locid").trim().toString();      
String areaid=request.getParameter("areaid")==null || request.getParameter("areaid")==""?"0":request.getParameter("areaid").trim().toString();
String locationid=request.getParameter("locationid")==null || request.getParameter("locationid")==""?"0":request.getParameter("locationid").trim().toString();
int type=request.getParameter("clienttype") ==null || request.getParameter("clienttype")==""?0:Integer.parseInt(request.getParameter("clienttype").trim().toString());    
int rdocno=request.getParameter("rdocno") ==null || request.getParameter("rdocno")==""?0:Integer.parseInt(request.getParameter("rdocno").trim().toString());
String gridarray=request.getParameter("gridarray")==null || request.getParameter("gridarray")==""?"0":request.getParameter("gridarray");
String edate=request.getParameter("edate") ==null || request.getParameter("edate")==""?"0":request.getParameter("edate");
String mobno=request.getParameter("mobno") ==null || request.getParameter("mobno")==""?"":request.getParameter("mobno");
String email=request.getParameter("email") ==null || request.getParameter("email")==""?"":request.getParameter("email");  
String client=request.getParameter("refname") ==null || request.getParameter("refname")==""?"":request.getParameter("refname"); 
String clientid=request.getParameter("clientid")==null || request.getParameter("clientid")==""?"0":request.getParameter("clientid");  
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");
String userid=session.getAttribute("USERID").toString();      
java.sql.Date tosqldate=null;
java.sql.Date fromsqldate=null;
java.sql.Date sqldate=null;

ClsConnection objconn=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;
String msg="0";
int vocno=0,docno=0,val=0;   

try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	if(!(edate.equalsIgnoreCase("undefined"))&&!(edate.equalsIgnoreCase(""))&&!(edate.equalsIgnoreCase("0")))
	{
		 sqldate=ClsCommon.changeStringtoSqlDate(edate);   
	}  
	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	{
		 fromsqldate=ClsCommon.changeStringtoSqlDate(fromdate);
	} 
	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	{
		 tosqldate=ClsCommon.changeStringtoSqlDate(todate);    
	}
	
	ArrayList<String> newarray=new ArrayList();
	String temparray[]=gridarray.split(",");
	for(int i=0;i<temparray.length;i++){    
		newarray.add(temparray[i]);
	}
	if(rdocno==0){
		String sqlvoc="select coalesce((max(voc_no)+1),1) voc_no from tr_servicereqm where brhid='"+brhid+"'";    
		ResultSet rs7=stmt.executeQuery(sqlvoc);
		if(rs7.next()){
			vocno=rs7.getInt("voc_no");    
		}
		String strsql="insert into tr_servicereqm(voc_no, date, Cldocno, userid, status, brhid, refname, mob, mail, locid, type) values('"+vocno+"','"+sqldate+"',"+clientid+","+userid+",3,"+brhid+",'"+client+"','"+mobno+"','"+email+"','"+locid+"',"+type+")";
		//System.out.println("strsql===="+strsql);                                       
		int insertval=stmt.executeUpdate(strsql);                  
		if(insertval>0){    
			String sql="select max(doc_no) docno from tr_servicereqm";    
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next()){
				docno=rs.getInt("docno");
			}
		}
		String strsql2="insert into TR_srhotel(rdocno, adult, child, locid, areaid, hotelid, roomid, roomtypeid, child1age, child2age, child3age, child4age, child5age, child6age, fromdt, todt, extrabed, mealplan, star) values("+docno+",'"+adult+"','"+child+"','"+locationid+"','"+areaid+"','"+hotelid+"','"+roomid+"','"+roomtypeid+"','"+txtage1+"','"+txtage2+"','"+txtage3+"','"+txtage4+"','"+txtage5+"','"+txtage6+"','"+fromsqldate+"','"+tosqldate+"','"+extrabed+"','"+mealplan+"','"+rating+"')";
		//System.out.println("strsql2===="+strsql2);                                                  
		int val2=stmt.executeUpdate(strsql2);       
		}else{
			docno=rdocno;  
		String strsql2="update TR_srhotel set adult='"+adult+"', child='"+child+"', locid='"+locationid+"', areaid='"+areaid+"', hotelid='"+hotelid+"', roomid='"+roomid+"', roomtypeid='"+roomtypeid+"', child1age='"+txtage1+"', child2age='"+txtage2+"', child3age='"+txtage3+"', child4age='"+txtage4+"', child5age='"+txtage5+"', child6age='"+txtage6+"', fromdt='"+fromsqldate+"', todt='"+tosqldate+"', extrabed='"+extrabed+"', mealplan='"+mealplan+"', star='"+rating+"' where rdocno='"+docno+"'";
		//System.out.println("strsql2===="+strsql2);                                                       
		int val2=stmt.executeUpdate(strsql2);  	
		}
		if(docno>0){          
			for(int i=0;i<newarray.size();i++){  
				String temp[]=newarray.get(i).split("::");
				if(!temp[0].trim().equalsIgnoreCase("undefined") && !temp[0].trim().equalsIgnoreCase("NaN") && !temp[0].trim().equalsIgnoreCase("")){
					
				String name = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"0":temp[0].trim()).toString();
				String total = (temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?"0.0":temp[1].trim()).toString();
				int rowsno= temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().equalsIgnoreCase("NaN") || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().isEmpty()?0:Integer.parseInt(temp[2].trim().toString());        
				if(rowsno>0){    
					String sql="update TR_srhoteld set  name='"+name+"', total="+Double.parseDouble(total)+"  where rowno="+rowsno+"";    
					//System.out.println(sql);
					 val=stmt.executeUpdate(sql);                      
				}else{
					String sql="insert into TR_srhoteld(rdocno, name, total) values("+docno+",'"+name+"',"+Double.parseDouble(total)+")";   
					//System.out.println(sql);       
				    val=stmt.executeUpdate(sql);   
				}      
				if(val>0){      
					msg="1";
					conn.commit();
					}
				}
			}
		}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(msg+"###"+docno);
%>