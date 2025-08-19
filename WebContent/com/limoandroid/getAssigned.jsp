<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%

String userid=request.getParameter("userid");

// System.out.println("userid=="+userid);

ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0;
String value="",drvid="";

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	String stst="select driverid from an_userregister where doc_no='"+userid+"'";
	System.out.println("driverfetch::"+stst);
	
	ResultSet rsk=stmt.executeQuery(stst);
	
	while(rsk.next())
	{
	  drvid=rsk.getString("driverid");
	}
// 	String str="select doc_no,ref_type,ref_no,strt_date,strt_time,description,act_status from an_taskcreation t left join an_taskcreationdets a on t.doc_no=a.rdocno where a.userid='"+userid+"' or t.userid='"+userid+"' and t.close_status=0 and utype='app' group by doc_no";
	String str="select * from(select tran.pickupdate,tran.pickuptime,coalesce(tran.remarks,'')remarks,tran.tarifdocno,tran.tarifdetaildocno,'Transfer' type,tran.doc_no,book.brhid,concat(book.doc_no ,'-',tran.docname) jobname,concat(DATE_FORMAT(tran.pickupdate,'%d-%m-%Y') ,' ',tran.pickuptime) pickupdatetime,coalesce(pickup.location,'') pickuplocation,coalesce(dropoff.location,'') dropofflocation,veh.fleet_no fleet,veh.reg_no,sal.sal_name driver,ac.refname,tran.guestdetails guest,tran.pickupadress pickupaddress,tran.dropoffaddress from gl_limobookm book inner join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join my_salesman sal on (tran.assigneddriver=sal.doc_no and sal.sal_type='DRV') left join gl_vehmaster veh on tran.assignedfleet=veh.fleet_no where book.status=3 and tran.masterstatus=3 and tran.assigneddriver='"+drvid+"' union all select hours.pickupdate,hours.pickuptime,'' remarks,hours.tarifdocno,hours.tarifdetaildocno,'Limo' type,hours.doc_no,book.brhid,concat(book.doc_no,'-',hours.docname) jobname,concat(hours.pickupdate, ' ',hours.pickuptime) pickupdatetime,coalesce(pickup.location,'') pickuplocation,'' dropofflocation,fleet_no fleet,veh.reg_no,sal.sal_name driver,ac.refname,'' guest,hours.pickupaddress,null dropoffaddress from gl_limobookm book inner join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no)  left join my_salesman sal on (hours.assigneddriver=sal.doc_no and sal.sal_type='DRV') left join gl_vehmaster veh on hours.assignedfleet=veh.fleet_no where book.status=3 and hours.masterstatus=3 and hours.assigneddriver='"+drvid+"')b order by b.pickupdate,b.pickuptime";
	
System.out.println("QQQQ::"+str);
	
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("jobname")+"::"+rs.getString("pickupdatetime")+"::"+rs.getString("pickuplocation").replace(',',' ')+"::"+rs.getString("dropofflocation")+"::"+rs.getString("guest")+"::"+rs.getString("pickupaddress")+"::"+rs.getString("dropoffaddress")+"::"+rs.getString("brhid")+"::"+rs.getString("doc_no")+"::"+rs.getString("type")+"::"+rs.getString("tarifdocno")+"::"+rs.getString("tarifdetaildocno")+"::"+rs.getString("remarks");	
		}
		else{
			value+=","+rs.getString("jobname")+"::"+rs.getString("pickupdatetime")+"::"+rs.getString("pickuplocation").replace(',',' ')+"::"+rs.getString("dropofflocation")+"::"+rs.getString("guest")+"::"+rs.getString("pickupaddress")+"::"+rs.getString("dropoffaddress")+"::"+rs.getString("brhid")+"::"+rs.getString("doc_no")+"::"+rs.getString("type")+"::"+rs.getString("tarifdocno")+"::"+rs.getString("tarifdetaildocno")+"::"+rs.getString("remarks");
		}
		i++;
		
	}
 	System.out.println("create---:"+value);

}
catch(Exception e)
{
	e.printStackTrace();

}
finally
{
	conn.close();
}

response.getWriter().write(value);
%>