<% %>
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%@page import="com.mailwithpdf.*" %>

<%
	EmailProcess ep=new EmailProcess();
	/* SendEmailAction se=new SendEmailAction(); */
	System.out.println("hiiiiiiiiiiiiiiiiiiiiiii");

	ClsConnection  ClsConnection=new ClsConnection();
	
	String picklocation=request.getParameter("pk_location");
	String pkother=request.getParameter("pkother");
	String delrequest=request.getParameter("del_rqst");
	String pickdate=request.getParameter("pk_date");
	String picktime=request.getParameter("pk_time");
	String droplocation=request.getParameter("drop_loc");
	String dropother=request.getParameter("dropother");
	String otherlocation=request.getParameter("othr_loc");
	String rtndate=request.getParameter("rtn_date");
	String rtntime=request.getParameter("rtn_time");
	//String duration=request.getParameter("duration");
	String bcar=request.getParameter("car");
	String bname=request.getParameter("bname");
	String mcode=request.getParameter("mob_code");
	String mno=request.getParameter("mob_nmbr");
	String mobile=mcode+mno;
	String email=request.getParameter("email");
	String userid=request.getParameter("userid");
	
	/* System.out.println("pkother......."+pkother);
	System.out.println("dropother....."+dropother);
	
	
	System.out.println(bname);
	 System.out.println(mno);
	System.out.println(email); */
	
	Connection conn=null;
	int i=0;
	String value="";
	String car="";
	String pick="";
	String drop="";
	String code="";
	String mobno="";
	try
	{
		conn=ClsConnection.getMyConnection();
		CallableStatement stmt=conn.prepareCall("{call vehicleBookDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmt.registerOutParameter(18, java.sql.Types.INTEGER);
		stmt.setString(1, picklocation);
		stmt.setString(2, pkother);
		stmt.setString(3 , delrequest);
		stmt.setString(4 , pickdate);
		stmt.setString(5,picktime);
		stmt.setString(6,droplocation);
		stmt.setString(7,dropother);
		stmt.setString(8,otherlocation);
		stmt.setString(9,rtndate);
		stmt.setString(10,rtntime);
		//stmt.setString(9,duration);
		stmt.setString(11,bcar);
		stmt.setString(12,bname);
		stmt.setString(13,mcode);
		stmt.setString(14,mno);
		stmt.setString(15,mobile);
		stmt.setString(16,email);
		stmt.setString(17,userid);

		
		stmt.executeUpdate();
		
		i=stmt.getInt("docno");
	
		Statement st=conn.createStatement();
		String sql= "select car from car_names where doc_no="+bcar;
		ResultSet rs=st.executeQuery(sql);
		while(rs.next())
		{
			car=rs.getString("car");
		}
	
		Statement stt=conn.createStatement();
		String sqll= "select location from pickup_location where doc_no="+picklocation;
		ResultSet rs1=stt.executeQuery(sqll);
		while(rs1.next())
		{
			pick=rs1.getString("location");
		}
		
		Statement stm=conn.createStatement();
		String sqlt= "select location from pickup_location where doc_no="+droplocation;
		ResultSet rs2=stm.executeQuery(sqlt);
		while(rs2.next())
		{
			drop=rs2.getString("location");
		}
		Statement stmt1=conn.createStatement();
		String sqlt1= "select code from mobile_code where doc_no="+mcode;
		ResultSet rs3=stmt1.executeQuery(sqlt1);
		while(rs3.next())
		{
			code=rs3.getString("code");
		}
		System.out.println("code"+code);
		System.out.println("mno"+mno);
		if(code.equalsIgnoreCase("Whatsapp number"))
		{
			mobno=mno+(code);
		}
		else
		{
			mobno=code+mno;
		}
		System.out.println("mmm"+mobno);
		if(i>0)
		{
			if(pick.equalsIgnoreCase("Other Location") &&  !drop.equalsIgnoreCase("Other Location"))
			{
				System.out.println("pickother");
				ep.sendEmailwithpdf("smtp.gmail.com", "587", "gatewayerp55@gmail.com", "gwsupport#321", "selcargate@gmail.com", "BOOKING", 
						"You have new booking from the customer <b>"+bname+"</b><br><b>Mobile No. :</b> "+mobno+"<br><b>Email id :</b> "+email+"<br><b>Vehicle name :</b> "+car+"<br><b>From location :</b> "+pkother+" <b>To</b> "+drop+"'<br><b>Date and Time :</b> "+pickdate+" "+picktime+" <b>To</b> "+rtndate+" "+rtntime,null,"");
			
			}
			if(!pick.equalsIgnoreCase("Other Location") && drop.equalsIgnoreCase("Other Location"))
			{
				System.out.println("dropother");
				ep.sendEmailwithpdf("smtp.gmail.com", "587", "gatewayerp55@gmail.com", "gwsupport#321", "selcargate@gmail.com", "BOOKING", 
						"You have new booking from the customer <b>"+bname+"</b><br><b>Mobile No. :</b> "+mobno+"<br><b>Email id :</b> "+email+"<br><b>Vehicle name :</b> "+car+"<br><b>From location :</b> "+pick+" <b>To</b> "+dropother+"<br><b>Date and Time :</b> "+pickdate+" "+picktime+" <b>To</b> "+rtndate+" "+rtntime,null,"");
			
			}
			if(pick.equalsIgnoreCase("Other Location") &&  drop.equalsIgnoreCase("Other Location") )
			{
				System.out.println("both");
				ep.sendEmailwithpdf("smtp.gmail.com", "587", "gatewayerp55@gmail.com", "gwsupport#321", "selcargate@gmail.com", "BOOKING", 
						"You have new booking from the customer <b>"+bname+"</b><br><b>Mobile No. :</b> "+mobno+"<br><b>Email id :</b> "+email+"<br><b>Vehicle name :</b> "+car+"<br><b>From location :</b> "+pkother+" "+picktime+" <b>To</b> "+dropother+"<br><b>Date and Time :</b> "+pickdate+" "+picktime+" <b>To</b> " +rtndate+" "+rtntime,null,"");
			
			}
			if(!pick.equalsIgnoreCase("Other Location") &&  !drop.equalsIgnoreCase("Other Location") )
			{
				System.out.println("nothing");
				ep.sendEmailwithpdf("smtp.gmail.com", "587", "gatewayerp55@gmail.com", "gwsupport#321", "selcargate@gmail.com", "BOOKING", 
						"You have new booking from the customer <b>"+bname+"</b><br><b>Mobile No. :</b> "+mobno+"<br><b>Email id :</b> "+email+"<br><b>Vehicle name :</b> "+car+"<br><b>From location :</b> "+pick+" <b>To</b> "+drop+"<br><b>Date and Time :</b> "+pickdate+" "+picktime+" <b>To</b> "+rtndate+" "+rtntime,null,"");
				
			}
			//ep.sendEmailwithpdf("smtp.gmail.com", "587", "gatewayerp55@gmail.com", "gwsupport#321", "selcargate@gmail.com", "BOOKING", 
				/* 	"You have new booking from the customer '"+bname+"' with Mobile No. '"+mobno+"', Email id '"+email+"' vehicle name '"+car+"' from location '"+pick+"' to '"+drop+"' pick up date from '"+pickdate+"' to '"+rtndate+"'.",null,""); */
			response.getWriter().write("Thank you for booking and Have a nice Journey!!!");
		}
		else
		{
			response.getWriter().write("Sorry... Try again");
		}
		
	}
	catch(Exception e)
	{
		e.printStackTrace();
		
	}
	finally
	{
		conn.close();
	}
	
%>