<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.ClsCommon"%>  
<%@page import="java.sql.*"%>     
<%
        String rowno=request.getParameter("rowno")==null?"":request.getParameter("rowno");    
        String bkdocno=request.getParameter("bookdocno")==null?"0":request.getParameter("bookdocno");  
        String detdocno=request.getParameter("detaildocno")==null?"0":request.getParameter("detaildocno");  
        String brch=request.getParameter("brch")==null?"0":request.getParameter("brch");
		String typess=request.getParameter("type")==null?"":request.getParameter("type");       
		String date=request.getParameter("date")==null?"":request.getParameter("date");
		String process=request.getParameter("cmbprocess")==null?"0":request.getParameter("cmbprocess");          
		String driver=request.getParameter("hiddriver")==null?"0":request.getParameter("hiddriver");
		String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
		String transferbranch=request.getParameter("cmbtransferbranch")==null?"0":request.getParameter("cmbtransferbranch");
	    String mode="A",dtype="BMG";                         
		ClsConnection  ClsConnection=new ClsConnection();            
		ClsCommon objcommon=new ClsCommon();
    	Connection conn=null;
		int temp=1,val=1,docno=0,vocno=0;           
		String msg="";
		String doc="";
		int errorstatus=0;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
		    String brhid=session.getAttribute("BRANCHID")==null?"0":session.getAttribute("BRANCHID").toString();
		    String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
		    String username=session.getAttribute("USERNAME")==null?"0":session.getAttribute("USERNAME").toString();
			Statement stmtassign=conn.createStatement();  
			java.sql.Date sqldate=null;
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);                
			}
			if(brch.equalsIgnoreCase("a")){  
				brch="0";                            
			}
			String[] rownoarray = rowno.split(",");
			String[] bookarray = bkdocno.split(",");
			String[] detailarray = detdocno.split(",");
			String[] typearray = typess.split(",");
			for (int i = 0; i < rownoarray.length; i++) {                         
			String rownoss=rownoarray[i];	
			String bookdocno=bookarray[i];	
			String detaildocno=detailarray[i];	
			String type=typearray[i];	  
			if(!(rownoss.equalsIgnoreCase(""))){
				CallableStatement stmtJob =conn.prepareCall("{call limoJobAssignDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				stmtJob.registerOutParameter(14, java.sql.Types.INTEGER);     
				stmtJob.registerOutParameter(15, java.sql.Types.INTEGER);
				stmtJob.setDate(1, sqldate);
				stmtJob.setInt(2, bookdocno==null || bookdocno.equalsIgnoreCase("")?0:Integer.parseInt(bookdocno));
				stmtJob.setInt(3, detaildocno==null || detaildocno.equalsIgnoreCase("")?0:Integer.parseInt(detaildocno));
				stmtJob.setString(4, process);    
				stmtJob.setString(5, driver==null || driver.equalsIgnoreCase("")?"0":driver);
				stmtJob.setString(6, fleetno==null || fleetno.equalsIgnoreCase("")?"0":fleetno);
				stmtJob.setString(7, transferbranch==null || transferbranch.equalsIgnoreCase("")?"0":transferbranch);
				stmtJob.setString(8, "0");
				stmtJob.setString(9, mode);
				stmtJob.setString(10, dtype);   
				stmtJob.setString(11, brch);
				stmtJob.setString(12, session.getAttribute("USERID").toString());
				stmtJob.setString(13, session.getAttribute("COMPANYID").toString());
				stmtJob.executeQuery();    
				docno=stmtJob.getInt("docNo");
				vocno=stmtJob.getInt("voc");
				if(docno<=0){
					temp=0;
				}
				else{
					String strassignupdate="";
					String strbranchtran="";
					/*  1-Branch Transfer
			    	2-Assignment
			    	3-External Vendors  */
					if(process.equalsIgnoreCase("1")){
						if(type.equalsIgnoreCase("Transfer")){
							strbranchtran="update gl_limobooktransfer set transferbranch="+transferbranch+" where doc_no="+detaildocno;
						}
						else if(type.equalsIgnoreCase("Limo")){
							strbranchtran="update gl_limobookhours set transferbranch="+transferbranch+" where doc_no="+detaildocno;
						}
						int updatebranch=stmtassign.executeUpdate(strbranchtran);
						if(updatebranch<0){
							val=0;
						}
					}
					else if(process.equalsIgnoreCase("2")){
						
						if(type.equalsIgnoreCase("Transfer")){
							strassignupdate="update gl_limobooktransfer set assignstatus=1,masterstatus=3,assignedfleet="+fleetno+",assigneddriver="+driver+" where doc_no="+detaildocno;
						}
						else if(type.equalsIgnoreCase("Limo")){
							strassignupdate="update gl_limobookhours set assignstatus=1,masterstatus=3,assignedfleet="+fleetno+",assigneddriver="+driver+" where doc_no="+detaildocno;
						}
						int assignval=stmtassign.executeUpdate(strassignupdate);
						if(assignval<=0){
							val=0;                            
						}
						else{
							
						}
					
					}
					String strgetfleet="select veh.fleet_no,veh.flname,brd.brand_name brand,model.vtype model from gl_vehmaster veh left join "+
					" gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no where veh.statu=3 and "+
					" veh.fleet_no="+fleetno;
					ResultSet rsgetfleet=stmtassign.executeQuery(strgetfleet);
					String fleetname="",brand="",model="";
					while(rsgetfleet.next()){
						fleetname=rsgetfleet.getString("flname");
						brand=rsgetfleet.getString("brand");
						model=rsgetfleet.getString("model");
					}
					String strgetdriver="select sal_name from my_salesman where sal_type='DRV' and status=3 and doc_no="+driver;
					ResultSet rsgetdriver=stmtassign.executeQuery(strgetdriver);
					String drivername="";
					while(rsgetdriver.next()){
						drivername=rsgetdriver.getString("sal_name");
					}
					String strsqlss="update gl_limomanagement set bstatus=3,fname='"+fleetname+"',fno='"+fleetno+"',brand='"+brand+"',model='"+model+"',drivername='"+drivername+"' where rowno='"+rownoss+"'";	
					stmtassign.executeUpdate(strsqlss);  
					
					String strgetdetail="select docno,job from gl_limomanagement where rowno='"+rownoss+"'";
					int bookingdocno=0;
					String jobname="";
					ResultSet rs=stmtassign.executeQuery(strgetdetail);
					while(rs.next()){
						bookingdocno=rs.getInt("docno");
						jobname=rs.getString("job");
					}
					String systemnote="Job Assignment of "+bookingdocno+" - "+jobname+" by "+username;
					String strinsertlog="insert into gl_limomgmtlog(bookdocno, jobname, brhid, userid, logdate,systemremarks)values("+
					""+bookingdocno+",'"+jobname+"',"+brhid+","+userid+",now(),'"+systemnote+"')";
					int insertlog=stmtassign.executeUpdate(strinsertlog);
					if(insertlog<=0){
						errorstatus=1;
					}
					
					
				} 
			}
			} 
			if(errorstatus==0){
				conn.commit();
			}
			  response.getWriter().print(val);
	 		  conn.close();
			}catch(Exception e){      
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
%>