<%@page import="java.util.ArrayList"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.limousine.limobooking.*"%>
<%@page import="com.dashboard.limousine.importdata.*" %>
<%
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno").toString();
	String gridarray=request.getParameter("gridarray");
	ClsConnection objconn=new ClsConnection();	
	ClsCommon objcommon=new ClsCommon();
	ClsLimoImportDataDAO importdao=new ClsLimoImportDataDAO();
	Connection conn=null;
	String limobookvocno="";
	int errorstatus=0;
	try{
		conn=objconn.getMyConnection();
		ArrayList<String> basetransferarray=new ArrayList();
		for(int i=0;i<gridarray.split(",").length;i++){
			basetransferarray.add(gridarray.split(",")[i].trim());
		}
		ArrayList<String> transferarray=new ArrayList();
		for(int i=0,j=1;i<basetransferarray.size();i++,j++){
			String docname="T"+j;
			String guestdetails=basetransferarray.get(i).split("::")[0].trim();
			String pax=basetransferarray.get(i).split("::")[1].trim();
			String pickupdate=basetransferarray.get(i).split("::")[2].trim();
			String pickuptime=basetransferarray.get(i).split("::")[3].trim();
			String pickupaddress=basetransferarray.get(i).split("::")[4].trim();
			String dropoffaddress=basetransferarray.get(i).split("::")[5].trim();
			String vehicledetails=basetransferarray.get(i).split("::")[6].trim();
			
			/* docname+"::"+pickupdate+"::"+pickuptime+"::"+transferrows[i].pickuplocationid+"::"+transferrows[i].pickupaddress+"::"+transferrows[i].dropofflocationid+"::"+transferrows[i].dropoffaddress+"::"+transferrows[i].brandid+"::"+transferrows[i].modelid+"::"+transferrows[i].nos+"::"+transferrows[i].tarifdocno+"::"+othersrvcstatus+"::"+transferrows[i].gid+"::"+transferrows[i].tarifdetaildocno+"::"+transferrows[i].transfertype+"::"+transferrows[i].estdistance+"::"+esttime+"::"+transferrows[i].tarif+"::"+transferrows[i].exdistancerate+"::"+transferrows[i].extimerate */
			transferarray.add(docname+"::"+pickupdate+"::"+pickuptime+"::"+0+"::"+pickupaddress+"::"+0+"::"+dropoffaddress+"::"+0+"::"+0+"::"+1+"::"+0+"::"+0+"::"+0+"::"+0+"::"+"Private"+"::"+0+"::"+"00:00"+"::"+0+"::"+0+"::"+0);
		}
		System.out.println("Testing:"+gridarray);
		java.sql.Date sqldate=null;
		String branchid="",cldocno="";
		String strsql="select CURDATE() basedate,brhid,cldocno from gl_limoimportreq where doc_no="+docno;
		Statement stmt=conn.createStatement();
		ResultSet rsmisc=stmt.executeQuery(strsql);
		while(rsmisc.next()){
			sqldate=rsmisc.getDate("basedate");
			branchid=rsmisc.getString("brhid");
			cldocno=rsmisc.getString("cldocno");
		}
		ArrayList<String> newtransferarray=new ArrayList();
		int transferjobserial=1;
		for(int i=0;i<transferarray.size();i++){
			if(!transferarray.get(i).split("::")[9].equalsIgnoreCase("") && !transferarray.get(i).split("::")[9].equalsIgnoreCase("undefined") && transferarray.get(i).split("::")[9]!=null){
				for(int j=0;j<Integer.parseInt(transferarray.get(i).split("::")[9]);j++){
					String temp[]=transferarray.get(i).split("::");
					newtransferarray.add("T"+transferjobserial+"::"+temp[1]+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[7]+"::"+temp[8]+"::"+1+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[13]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]);
					transferjobserial++;
				}
			}
		}
		String note="";
		ClsLimoBookingDAO bookingdao=new ClsLimoBookingDAO();
		String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
		int val=bookingdao.insert(sqldate,cldocno,"0","","","0",session,"A","LBK",branchid,"","","","","","");
		if(val>0){
			ArrayList<String> blankarray=new ArrayList();
			boolean status=bookingdao.insertTarif(val,newtransferarray,blankarray,session,"A");
			if(status){
				for(int i=0,j=1;i<basetransferarray.size();i++,j++){
					String guestdetails=basetransferarray.get(i).split("::")[0].trim();
					String pax=basetransferarray.get(i).split("::")[1].trim();
					String vehdetails=basetransferarray.get(i).split("::")[6].trim();
					String otherdetails="";
					String remarks=basetransferarray.get(i).split("::")[8].trim();
					String refno=basetransferarray.get(i).split("::")[9].trim();
					if(basetransferarray.get(i).split("::").length>7){
						otherdetails=basetransferarray.get(i).split("::")[7].trim();
					}
					else{
						otherdetails="";
					}
					String docname="T"+j;
					String strupdatetransfer="update gl_limobooktransfer set guestdetails='"+guestdetails+"',pax="+pax+",vehdetails='"+vehdetails+"',otherdetails='"+otherdetails+"',remarks='"+remarks+"',refno='"+refno+"' where bookdocno="+val+" and docname='"+docname+"' and status=3";
					int updatetransfer=stmt.executeUpdate(strupdatetransfer);
					if(updatetransfer<=0){
						errorstatus=1;
					}
					String strupdatemgmt="update gl_limomanagement set guest='"+guestdetails+"',pax="+pax+",bookremarks='"+remarks+"',otherdetails='"+otherdetails+"' where docno="+val+" and job='"+docname+"'";
					System.out.println(strupdatemgmt);
					int updatemgmt=stmt.executeUpdate(strupdatemgmt);
					if(updatemgmt<=0){
						errorstatus=1;
					}
				}
				if(errorstatus==0){
					ArrayList<String> billarray=new ArrayList();
					billarray.add("Client"+"::"+"On Account"+"::"+"100");
					int billval=bookingdao.insertBill(val,billarray);
					if(billval>0){
						String strupdate="update gl_limoimportreq set bookdocno="+val+" where doc_no="+docno;
						int updatevalue=stmt.executeUpdate(strupdate);
						if(updatevalue<=0){
							errorstatus=1;
						}
						else{
							limobookvocno=session.getAttribute("LIMOBOOKVOCNO").toString();
							PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
							stmtlog.setInt(1,Integer.parseInt(docno));
							stmtlog.setInt(2,Integer.parseInt(branchid));
							stmtlog.setString(3,"BLID");
							stmtlog.setInt(4, Integer.parseInt(userid));
							stmtlog.setInt(5, 0);
							stmtlog.setInt(6, 0);
							stmtlog.setString(7, "A");
							int log=stmtlog.executeUpdate();
							if(log<=0){
								errorstatus=1;
							}
							else{
								limobookvocno=session.getAttribute("LIMOBOOKVOCNO").toString();
							}
						}
					}
					else{
						limobookvocno=session.getAttribute("LIMOBOOKVOCNO").toString();
						errorstatus=1;	
					}
				}
				else{
					errorstatus=1;
				}
				
			}
			else{
				limobookvocno=session.getAttribute("LIMOBOOKVOCNO").toString();
				errorstatus=1;
			}
		}
		else{
			limobookvocno=session.getAttribute("LIMOBOOKVOCNO").toString();
			errorstatus=1;
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(errorstatus+"::"+limobookvocno);
%>