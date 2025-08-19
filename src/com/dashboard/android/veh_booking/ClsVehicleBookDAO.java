package com.dashboard.android.veh_booking;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehicleBookDAO 
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray bookSearch() throws SQLException
	{
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtreg = conn.createStatement ();
		    
		    String sql = "";
			
			//sql ="select v.doc_no,v.pick_location,v.delivery_request,v.pick_date,v.pick_time,v.drop_location,v.other_location,v.return_date,v.return_time,v.booking_car,v.user_name,v.mobilenumber,v.email,v.cdate,u.name rname,u.email remail,u.mobile_no rmobile from vehicle_book v left join user_register u on v.user_id=u.doc_no where status=0;";
//			sql="select v.doc_no,p.location plocation,v.pk_other other_pickup,d.delivery delivery,DATE_FORMAT(v.pick_date,'%d.%m.%Y') pick_date,"
//				+" v.pick_time,pl.location dlocation,v.drop_other other_dropoff,dr.delivery other,DATE_FORMAT(v.return_date,'%d.%m.%Y') return_date,v.return_time,"
//				+" c.car car,v.user_name,if(code='Whatsapp number',mobile_number,(concat(code,mobile_number)) )mobilenumber,v.email,DATE_FORMAT(v.cdate,'%d.%m.%Y') cdate,u.name rname,u.email remail,"
//				+" u.mobile_no rmobile from vehicle_book v left join user_register u on v.user_id=u.doc_no"
//				+" left join pickup_location p on v.pick_location=p.doc_no left join delivery_request d on v.delivery_request=d.doc_no"
//				+" left join pickup_location pl on v.drop_location=pl.doc_no left join delivery_request dr on v.other_location=dr.doc_no"
//				+" left join car_names c on v.booking_car=c.doc_no left join mobile_code m on v.mobile_code=m.doc_no where status=0;";
		    
//		    sql="select v.doc_no,p.location plocation,v.pk_other other_pickup,d.delivery delivery,DATE_FORMAT(v.pick_date,'%d.%m.%Y') pick_date,"
//					+" v.pick_time,pl.location dlocation,v.drop_other other_dropoff,dr.delivery other,DATE_FORMAT(v.return_date,'%d.%m.%Y') return_date,v.return_time,"
//					+" v.booking_car car,v.user_name,if(code='Whatsapp number',mobile_number,(concat(code,mobile_number)) )mobilenumber,v.email,DATE_FORMAT(v.cdate,'%d.%m.%Y') cdate,u.name rname,u.email remail,"
//					+" u.mobile_no rmobile from vehicle_book v left join user_register u on v.user_id=u.doc_no"
//					+" left join pickup_location p on v.pick_location=p.doc_no left join delivery_request d on v.delivery_request=d.doc_no"
//					+" left join pickup_location pl on v.drop_location=pl.doc_no left join delivery_request dr on v.other_location=dr.doc_no"
//					+" left join mobile_code m on v.mobile_code=m.doc_no where status=0;";
		    sql="select v.doc_no,p.location plocation,v.pk_other other_pickup,d.delivery delivery,DATE_FORMAT(v.pick_date,'%d.%m.%Y') pick_date,"
					+" v.pick_time,pl.location dlocation,v.drop_other other_dropoff,dr.delivery other,DATE_FORMAT(v.return_date,'%d.%m.%Y') return_date,v.return_time,"
					+" v.booking_car car,v.user_name,if(code='Whatsapp number',mobile_number,(concat(code,mobile_number)) )mobilenumber,v.email,DATE_FORMAT(v.cdate,'%d.%m.%Y') cdate,"
					+" u.mobile_no rmobile from vehicle_book v left join user_register u on v.user_id=u.doc_no"
					+" left join pickup_location p on v.pick_location=p.doc_no left join delivery_request d on v.delivery_request=d.doc_no"
					+" left join pickup_location pl on v.drop_location=pl.doc_no left join delivery_request dr on v.other_location=dr.doc_no"
					+" left join mobile_code m on v.mobile_code=m.doc_no where v.status=0;";
			ResultSet rs= stmtreg.executeQuery(sql);
		                
			System.out.println("booksql--"+sql);
		    RESULTDATA=ClsCommon.convertToJSON(rs);
		    stmtreg.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
	}
	

	public JSONArray userSearch() throws SQLException
	{
		JSONArray RESULTDATAA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtreg1 = conn.createStatement ();
		    
		    String sqll = "";
			
			sqll ="select doc_no,user_name from my_user";
			
			ResultSet rss= stmtreg1.executeQuery(sqll);
		                
		    RESULTDATAA=ClsCommon.convertToJSON(rss);
		    stmtreg1.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATAA;
	}


	public JSONArray offerSearch() throws SQLException
	{
		System.out.println("wyugy");

		/*HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.setAttribute("BRANCHID", "1");*/
		JSONArray RESULTDATAA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtreg1 = conn.createStatement ();
		    
		    String sqll = "";
			
			sqll ="select doc_no,fromdate,todate,vehicle_name,monthly,weekly,daily,adult,door,luggage,fuel,wheel,'Attach' attachbtn from an_offers";
			System.out.println("sqll..."+sqll);
			ResultSet rss= stmtreg1.executeQuery(sqll);
		                
		    RESULTDATAA=ClsCommon.convertToJSON(rss);
		    stmtreg1.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATAA;
	}


	public JSONArray vehdetails() throws SQLException
	{
		System.out.println("deferegethgrth");
		JSONArray RESULTDATAA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtreg1 = conn.createStatement ();
		    
		    String sqll = "";
			
			sqll ="select fleetname from an_vehonline";
			System.out.println("sqll..."+sqll);
			ResultSet rss= stmtreg1.executeQuery(sqll);
		                
		    RESULTDATAA=ClsCommon.convertToJSON(rss);
		    stmtreg1.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATAA;
	}
}
