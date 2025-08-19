<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="com.connection.*" %>
<%@page import="com.sayaraInternal.*" %>
  
<%	
	
Connection conn=null;
	try{
 //System.out.println("======aa==== ");		
		ClsAndroid and=new ClsAndroid();
		ClsConnection  ClsConnection =new ClsConnection();
		 ClsCommon   ClsCommon =new ClsCommon();
		//String dtype=session.getAttribute("Code").toString();
		String fleet=request.getParameter("fleet"); 
		String regno=request.getParameter("reg_no")==null?"0":request.getParameter("reg_no"); 
		String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
		String del_KM=request.getParameter("del_KM"); 
		String de_Fuel=request.getParameter("Del_Fuel");
		String deldateOut=request.getParameter("del_Date");
		String deltimeOut=request.getParameter("Del_Time");
		String repno=request.getParameter("repno");
		String drvid=request.getParameter("drid");
		System.out.println("======aa==== "+fleet+":"+regno+":"+mode+":"+del_KM+":"+de_Fuel+":"+deldateOut+":"+deltimeOut+"==delivery:repno==="+repno+"==:drvid==="+drvid);
		
		conn=ClsConnection.getMyConnection();
		ClsCommon comm = new ClsCommon();
		
		 int val=0;
		 String docno="";
		 int aa=0;
		 int weekend=0;
		 String rentaldoc="";
		 java.sql.Date sqlrentaldate=null;
		 int cldoc=0;
		 String del_Driverid="",branchval="",vlocation="",group="",detail="";
		 
		 int chkupdate=0;
		 int delstatus=0;
		 java.sql.Date sqloutdate=null;
		 
		 String outtime="",XSQL="";
		 double outkm=0;
	 
	 
	 
	 CallableStatement stmtUpdaterent = null;
	 if(mode.equalsIgnoreCase("1")){
		XSQL=" and V.fleet_no= "+fleet;
	}
	if(mode.equalsIgnoreCase("2")){
		XSQL=" and v.reg_no= "+regno;
	}
	
	System.out.println("=====deldateOut==== ");
				
			Statement stmt=conn.createStatement();
			Statement stmt1=conn.createStatement();
			String sql="";
			if(!(repno.equalsIgnoreCase("0"))){
				sql="select r.ofleetno fleet_no,concat(case when r.rtype='RAG' then 'RA-' when r.rtype='LAG' then 'LA-' end,coalesce(r2.voc_no,l2.voc_no),' - ',a.refname) detail,"
						+ "r2.weekend,r.date,coalesce(r2.drid,l2.drid)drid,r.obrhid brhid,r.olocid locid,r.doc_no,v.vgrpid,r2.cldocno,r.odate,r.otime,r.okm,r.delstatus from gl_vehreplace r left join  gl_ragmt r2 on r.rdocno=r2.doc_no and r.rtype='RAG' left join  gl_lagmt l2 on r.rdocno=l2.doc_no and r.rtype='LAG' " 
						+ "left join gl_vehmaster v on r.ofleetno=v.fleet_no left join my_acbook a on r2.cldocno=a.cldocno and a.dtype='CRM' "
						+ "where r.status=3 and r.reptype='collection' and r.closestatus=0 and r.clstatus=1 and r.delstatus=0 and r.doc_no="+repno+""+XSQL ;
			}else{
			sql="select r.fleet_no,concat('RA-',r.voc_no,' - ',a.refname) detail,r.weekend,r.date,r.drid,r.brhid,r.locid,r.doc_no,v.vgrpid,r.cldocno,r.odate,r.otime,r.okm,r.delstatus from  gl_ragmt r  "+
					"left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM'"+ 
					" where r.clstatus=0   and r.delivery=1 "+XSQL ;
			}
 			System.out.println("-asdsa-111--"+sql);
    		ResultSet resultSet = stmt.executeQuery(sql);
    		if(resultSet.next())
    		{
    			System.out.println("-IN--");
    			rentaldoc=resultSet.getString("doc_no");
    			sqlrentaldate=resultSet.getDate("date");
    			
    			del_Driverid=resultSet.getString("drid");
    			branchval=resultSet.getString("brhid");
    			vlocation=resultSet.getString("locid");
    			group=resultSet.getString("vgrpid");
    			cldoc=resultSet.getInt("cldocno");
    			
    			weekend=resultSet.getInt("weekend");	
    			sqloutdate=resultSet.getDate("odate");
    			outtime=resultSet.getString("otime");
    			outkm=resultSet.getDouble("okm");
    			
    			delstatus=resultSet.getInt("delstatus");
    			fleet=resultSet.getString("fleet_no");
    			detail=resultSet.getString("detail")+"::"+fleet;
    			
    			chkupdate=1;
    		}
    		
    		System.out.println("result:"+rentaldoc+":"+sqlrentaldate+":"+del_Driverid+":"+branchval+":"+vlocation+":"+group+":"+cldoc);
    		System.out.println("sssvsv::"+weekend+":"+sqloutdate+":"+outtime+":"+outkm+":"+delstatus+":"+fleet+":"+detail);
    		
    		
    		System.out.println("delkm:"+del_KM+":outkm:"+outkm);
    		
  		
    		if(rentaldoc.trim().equalsIgnoreCase(""))
    		{
    			System.out.println("aa");
				response.getWriter().write("Fleet Not Available For Delivery");
              	conn.close();
			return ;
			}
    		if(delstatus==0 && del_KM==null )
			{
    			System.out.println("bb");
                response.getWriter().write(detail);
                conn.close();
				
				return ;
			}
    		
    		if(delstatus==1)
			{
    			System.out.println("cc");
                response.getWriter().write("Already Updated");
                conn.close();
				
				return ;
			}
    		 
			if(chkupdate==1 && delstatus==0)
			{
			
				if(Double.parseDouble(del_KM)<outkm)
				{
					System.out.println("dd");
					//response.getWriter().write("Delivery KM Less Than Out KM");
					response.getWriter().write("Delivery KM Must be greater than Out KM (Out KM:"+outkm+")");
					conn.close();
					
					return ;
					 
					
				}
				System.out.println(de_Fuel);
				String del_Fuel=and.getFuelvalue(de_Fuel);
	  		  
	  			System.out.println(del_Fuel);
	  			java.sql.Date sqldeldate=ClsCommon.changeStringtoSqlDate(deldateOut);
	  			System.out.println("deldateOut:"+deldateOut+":sqldeldate:"+sqldeldate);
				int date=0;
				int time=0;
				String sql11=" select  if((cast('"+sqldeldate+"' as date)>=cast('"+sqloutdate+"' as date)),1,0) date ";
				System.out.println("-asdsa-12--"+sql11);
				ResultSet resultSet1 = stmt.executeQuery(sql11);
	    		if(resultSet1.next())
	    		{
	    			date=resultSet1.getInt("date");
	    		}
	    		
	    		
	    		if(date==0)
	    		{
	    			System.out.println("ee");
	    			  response.getWriter().write("Delivery Date Cannot be Less than Out Date");
	    			  conn.close();
	    			  return ;
	    		}
	    		
				
				String sql12=" select  if((cast('"+deltimeOut+"' as time)>=cast('"+outtime+"' as time)),1,0) time ";
				System.out.println("-timechk-12--"+sql12);
				ResultSet resultSet12 = stmt1.executeQuery(sql12);
	    		if(resultSet12.next())
	    		{
	    			
	    			time=resultSet12.getInt("time");
	    			
	    		}
	    		
	    		/* if(time==0)
	    		{
	    			  response.getWriter().write("Delivery Time Cannot be Less than Out Time");
	    			  conn.close();
	    			  return ;
	    		}
	    		 */
				stmtUpdaterent = conn.prepareCall("{ CALL renAgmtupdatebiDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
	    		
				
				stmtUpdaterent.setString(1, fleet);
				stmtUpdaterent.setString(2,del_Driverid); 
				stmtUpdaterent.setString(3,del_KM);
				System.out.println("===2==del_Fuel==== "+del_Fuel);
				System.out.println("===2==sqldeldate==== "+sqldeldate);
				System.out.println("===2==deltimeOut==== "+deltimeOut);
				stmtUpdaterent.setString(4,del_Fuel);
				stmtUpdaterent.setDate(5,sqldeldate);
				stmtUpdaterent.setString(6,deltimeOut);
				stmtUpdaterent.setString(7,branchval.trim());
			    stmtUpdaterent.setString(8,vlocation);
				stmtUpdaterent.setString(9,group);
			    stmtUpdaterent.setString(10,rentaldoc);
			    stmtUpdaterent.setInt(11,cldoc);
			   	stmtUpdaterent.setString(12,"ADD");
			 	stmtUpdaterent.setInt(13,weekend);
			 	stmtUpdaterent.setDate(14,sqlrentaldate);
				stmtUpdaterent.executeUpdate();
				aa=stmtUpdaterent.getInt("docNo");
				stmtUpdaterent.close();
				
				if(aa>0){
					Statement stmtnw=conn.createStatement();
					System.out.println("ff");
					
					if(!repno.equalsIgnoreCase("0")){
						String tst="update gl_vehreplace set deldrvid="+drvid+",deldate='"+sqldeldate+"',deltime='"+deltimeOut+"',delkm="+del_KM+",delfuel="+del_Fuel+",delstatus=1 where doc_no="+repno+"";
						System.out.println("RPLdeliveryupdate===="+tst);
						int val1=stmtnw.executeUpdate(tst);
						if(val1>0){
							response.getWriter().write("Updated Successfully");
						}else{
							response.getWriter().write("Not Updated");
						}
						}else{
							response.getWriter().write("Updated Successfully");
						}
					conn.close();
					return ;
				}
				else{
					System.out.println("gg");
					response.getWriter().write("Not Updated");
					conn.close();
					return ;
					}
		 	
		}
		else
		{
				System.out.println("hh");
				response.getWriter().write("Fleet Not Available For Delivery");
				conn.close();
				return ;
		}
			 
			
			
			 
			 
		     
		
	}
	catch(Exception e){
		
		conn.close();
	 	e.printStackTrace();
	 	 
	 	 response.getWriter().write("Not Updated");
	}
	
	
  %>
  
