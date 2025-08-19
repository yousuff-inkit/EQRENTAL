<%@page import="java.sql.Statement"%>
<%@page import ="com.connection.ClsConnection"%>
<%@page import ="com.connection.ClsConnectionMSSQL" %>
<%@page import ="com.common.ClsCommon"%>
<%@page import ="com.dashboard.humanresource.timesheet.*" %>
<%@page import ="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.ArrayList" %>


<%
Connection conn =null;
Connection connms=null; 
		try{
		ClsConnectionMSSQL objconnmssql = new ClsConnectionMSSQL();
		ClsConnection objconn = new ClsConnection();
		
		 conn = objconn.getMyConnection();
		connms = objconnmssql.getMyConnection();
		Statement stmtins = conn.createStatement();
		Statement stmt = connms.createStatement();

		session.setAttribute("BRANCHID",1);
		session.setAttribute("USERID",1);
			String inssql="",selsql="";
			String sql="select * from [dbo].[iclock_transaction] order by punch_time";
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				System.out.println("result = "+rs.getString("punch_time"));
				selsql="select * from an_attenance where id='"+rs.getString("id")+"'";
				ResultSet rssel =stmtins.executeQuery(selsql);
				if(rssel.next()){
					
				}else{
				inssql="insert into an_attenance( id, empcode, punch_time, upload_time, emp_id) value "
						+"('"+rs.getString("id")+"','"+rs.getString("emp_code")+"','"+rs.getString("punch_time")+"','"+rs.getString("upload_time")+"','"+rs.getString("emp_id")+"') ";
				stmtins.execute(inssql);
				}
			} 
			
			ClsCommon ClsCommon=new ClsCommon();
			ClsTimeSheetDAO timeSheetDAO=new ClsTimeSheetDAO();
			ArrayList timesheetarray=new ArrayList();
			ArrayList<String> attarray=new ArrayList<String>();
			String sqlatt="select id,emp_id,date_format(date(punch_time),'%d.%m.%Y') dt,substring(time(punch_time),1,5) time from an_attenance where punch_time >'2020-01-01' and date(punch_time)='2020-02-24'  order by emp_id,punch_time ;";
			// 
			ResultSet rs1=stmtins.executeQuery(sqlatt);
			while(rs1.next()){
				attarray.add(rs1.getString(1)+"::"+rs1.getString(2)+"::"+rs1.getString(3)+"::"+rs1.getString(4));
			}
			int insert=0,count=0;
			String id="",empid="",dt="",time="",otime="",sqlupdate="",sqltime="",enteredtime="";
			for(String value:attarray){
				count=count+1;
				System.out.println(" array list ="+value);
				String val[]=value.split("::");
				if(empid.equalsIgnoreCase("") && dt.equalsIgnoreCase("") && time.equalsIgnoreCase("")) {
					System.out.println(" Case 1 : ");
					id=val[0];empid=val[1];dt=val[2];time=val[3];
					insert=0;
				}
				else if(empid.equalsIgnoreCase(val[1]) && dt.equalsIgnoreCase(val[2]) && !time.equalsIgnoreCase("") && count==2) {
					otime=val[3];
					id=id+","+val[0];
					sqltime="select substring(timediff('"+otime+"','"+time+"'),1,5) etime;";
					rs1=stmtins.executeQuery(sqltime);
					while(rs1.next()){
						enteredtime=rs1.getString("etime");
					}
					timesheetarray.add(empid+"::"+dt+":: 1:: 2:: "+enteredtime+":: 0:00:: 0:00:: "+time+":: "+otime+":: 0.00");
					System.out.println(" Case 2 insert : "+timesheetarray+",id="+id);
					insert=1;
					
					// insert  and update in an_attendance 
					timeSheetDAO.insert("1","2020","1",timesheetarray,session,request,"A");
					sqlupdate="update an_attenance set uploaded=1 where id in ("+id+")";
					stmtins.execute(sqlupdate);
					
					timesheetarray=new ArrayList();
					id="";empid="";dt="";time="";otime="";
					id=val[0];empid=val[1];dt=val[2];time=val[3];
					count=0;
					
				}else if(empid.equalsIgnoreCase(val[1]) && !dt.equalsIgnoreCase(val[2]) && count==2) {
					
					timesheetarray.add(empid+"::"+dt+":: 1:: 2:: 0:00:: 0:00:: 0:00:: "+time+":: 0.00:: 0.00");
					System.out.println(" Case 3 insert : "+timesheetarray+",id="+id);
					insert=1;
					// insert  and update in an_attendance 
					timeSheetDAO.insert("1","2020","1",timesheetarray,session,request,"A");
					sqlupdate="update an_attenance set uploaded=1 where id in ("+id+")";
					stmtins.execute(sqlupdate);
					
					timesheetarray=new ArrayList();
					id="";empid="";dt="";time="";otime="";
					id=val[0];empid=val[1];dt=val[2];time=val[3];
					count=1;
				} else if(!empid.equalsIgnoreCase(val[1]) && count==2){
					
					timesheetarray.add(empid+"::"+dt+":: 1:: 2:: 0:00:: 0:00:: 0:00:: "+time+":: 0.00:: 0.00");
					System.out.println(" Case 4 insert : "+timesheetarray+",id="+id);
					insert=1;
					// insert  and update in an_attendance 
					timeSheetDAO.insert("1","2020","1",timesheetarray,session,request,"A");
					sqlupdate="update an_attenance set uploaded=1 where id in ("+id+")";
					stmtins.execute(sqlupdate);
					
					timesheetarray=new ArrayList();
					id="";empid="";dt="";time="";otime="";
					id=val[0];empid=val[1];dt=val[2];time=val[3];
					insert=0;
					count=1;
				}else{
				
				
					id=val[0];empid=val[1];dt=val[2];time=val[3];insert=0;
					System.out.println(" else  : "+id+",empid="+empid+",dt="+dt+",time="+time);
				}
			}
				// timesheetarray.add(empid+"::"+dt+":: 1:: 2:: 0:00:: 0:00:: 0:00:: "+time+":: "+time+":: 0.00");
				// 8::15.01.2020:: 1:: 2:: 9:00:: 0:00:: 0:00:: 8:00:: 17:00:: 0.00
			
			// timeSheetDAO.insert("1","2020","1",timesheetarray,session,request,"A");
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
			connms.close();
		}
		%>