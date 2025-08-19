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
	String saveval=request.getParameter("saveval");
String uptodate=request.getParameter("uptodate");

ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	 String upsql=null;
	 Date uptosqldate=ClsCommon.changeStringtoSqlDate(uptodate);

	 int val=0;
 	Connection conn = null;

	ArrayList<String> rowValues= new ArrayList<String>();
	
	 try{
	 
		 
		 conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();
			/* 
			   String sqlupd="UPDATE GL_WEBCAT W ,GL_VEHPLATE P SET ITEMNO=P.DOC_NO WHERE W.CODENO=P.CODE_NAME AND P.STATUS=3 AND W.EMIRATE='dubai' AND P.DOC_NO IS NOT NULL";
			   stmt.executeUpdate(sqlupd);
			 */
			 
			 //Getting Config for blocking Replacement Vehicles in Salik
            int blockreplaced=0;
            String strconfig="select method from gl_config where field_nme='blockTrafficReplace'";
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
            		sqlexcludefleets+=" and veh.fleet_no not in "+replacedfleets+"";
            	}
            }
			String sqls="update gl_traffic t,gl_webcat c set pcolor=itemno,fleetno=1 where c.nalias=t.pcolor and c.emirate=t.source and c.type!='PS' and fleetno=0";
	    	stmt.executeUpdate(sqls);
		 

			//String sql="SELECT TICKET_NO,FLEET_NO,cast(concat(TRAFFIC_DATE,' ',TIME) as datetime) TRA_DATE,t.pcolor,t.source FROM GL_TRAFFIC T left JOIN GL_VEHMASTER VEH ON (VEH.REG_NO=T.REGNO and veh.p) left JOIN GL_VEHPLATE PC ON T.PCOLOR=PC.CODE_NAME AND PC.DOC_NO=VEH.PLTID where t.isallocated=0 and trim(t.PCOLOR)<>''  and t.status in (0,3)";				
			String sql=" SELECT TICKET_NO,FLEET_NO,cast(concat(TRAFFIC_DATE,' ',TIME) as datetime) TRA_DATE,t.pcolor,t.source FROM GL_TRAFFIC T left JOIN GL_VEHMASTER VEH ON (trim(VEH.REG_NO)=trim(T.REGNO) and t.pcolor=veh.pltid)"  
			+" where t.traffic_date<='"+uptosqldate+"' and t.isallocated=0 and trim(t.PCOLOR)<>''  and t.status in (0,3) "+sqlexcludefleets;
		//	System.out.println("Selected fleets:"+sql);   
	ResultSet rs = stmt.executeQuery(sql);
		
	
		   
		     while(rs.next()) {
		    	 
		  /*   	String sqls="update gl_traffic t,gl_webcat c set pcolor=itemno where c.codeno=t.pcolor and c.codeno='"+rs.getString("pcolor")+"' and c.emirate='"+rs.getString("source")+"' ";
		    	 stmt.executeUpdate(sqls); */
		    	 rowValues.add(rs.getString("fleet_no")+" :: "+rs.getString("TICKET_NO")+" :: "+rs.getTimestamp("TRA_DATE"));
	
		} 
		     

		     
		 //    System.out.println("rowValues-------"+rowValues);	     
		     
		     
		
	for(int i=0;i<rowValues.size();i++)
	{
		
//System.out.println("rowValues.get(i)"+rowValues.get(i));
		
		 String[] subarray=rowValues.get(i).split("::");	
		  
		 if(subarray[0].trim().equalsIgnoreCase("null"))
				 {
		
			 String sqlup="update GL_TRAFFIC set reason='Fleet Not Recognize' where TICKET_NO='"+subarray[1].trim()+"' ";
			// System.out.println("-----1--"+sqlup);  
			 stmt.executeUpdate(sqlup);
			 
				 }
				 else
				 {
					
					
				Statement stmt1 = conn.createStatement ();
					String sqlup1="select v.fleet_no,trancode,rdocno,rdtype,emp_id,emp_type from gl_vmove m inner join gl_vehmaster v on (m.fleet_no=v.fleet_no) "
							+" where  ('"+subarray[2].trim()+"' <=coalesce(cast(concat(din,' ',tin) as datetime),now())	and '"+subarray[2].trim()+"' >= cast(concat(dout,' ',tout) as datetime)) and rdtype!='VSC' and v.fleet_no='"+subarray[0].trim()+"' "; 

                 //    System.out.println("-----2--"+sqlup1);   
					 ResultSet rs1 = stmt1.executeQuery(sqlup1);
				     while(rs1.next())
				     {
				    	
				    	 
				    		int empid=rs1.getInt("emp_id");	
					    	String	emptype=rs1.getString("emp_type");	 
				      		 int chafid=0;
				      		 int drid=0;
				      		 
				      		 String rtype=rs1.getString("rdtype");
				      		 
				      		 String rdocno=rs1.getString("rdocno");
				      		 String trancode=rs1.getString("trancode");
				      		 
				    		 String fleet_no=rs1.getString("fleet_no");
				    
				    	 
						    	 if(rs1.getString("rdtype").equalsIgnoreCase("RAG") || rs1.getString("rdtype").equalsIgnoreCase("MOV") || rs1.getString("rdtype").equalsIgnoreCase("LAG")  || rs1.getString("rdtype").equalsIgnoreCase("VCU") )
						    	 {
						    		 saveval="11";
						    		 
						    		 
						      	
						    		 if(rtype.equalsIgnoreCase("RAG"))
						    		 {
						    				Statement stmt11 = conn.createStatement (); 
						    		String ragsql="select chif,drid from  gl_ragmt where doc_no='"+rdocno+"'";	 
						           //	 System.out.println("-----ragsql--"+ragsql);  
						    		 ResultSet newone = stmt11.executeQuery(ragsql);
								     while(newone.next())
								     {
								    	 
								    	 chafid=newone.getInt("chif");
								    	if(chafid==1) 
								    	{
								    	
								    		empid=newone.getInt("drid");	
								    		emptype="DRV";
								    	}
								    
						    			 
						    		 }
								     stmt11.close();
						    		 
						    		 }
						    		 
						    		 
						    		 
						    		 else if(rtype.equalsIgnoreCase("LAG"))
						    		 {
						    			 Statement stmt12 = conn.createStatement (); 
						    			 String lagsql="select chif,drid from  gl_lagmt where doc_no='"+rdocno+"'";	 
						              	 //System.out.println("-----lagsql--"+lagsql);  
							    		 ResultSet leasers = stmt12.executeQuery(lagsql);
									     while(leasers.next())
									     {
									    	 
									    	 chafid=leasers.getInt("chif");
									    	if(chafid==1) 
									    	{
									    	
									    		empid=leasers.getInt("drid");	
									    		emptype="DRV";
									    	}
							    	
							    		 }
									     stmt12.close();
									    // System.out.println("---empid--"+empid);
									    // System.out.println("---emptype--"+emptype);
									     
									     
									     
						    		 }
						    		 
						    		 

						      		
						    		 
						    		 Statement stmt2 = conn.createStatement ();
						    		String sqlup2="update GL_TRAFFIC set isallocated=1,reason='Allocated',ra_no='"+rdocno+"',rtype='"+trancode+"',emp_id='"+empid+"',emp_type='"+emptype+"',Fleetno='"+fleet_no+"' where  traffic_date<='"+uptosqldate+"' and  TICKET_NO='"+subarray[1].trim()+"' ";
						           //	 System.out.println("-----3--"+sqlup2);  
						    		stmt2.executeUpdate(sqlup2);
						    		 stmt2.close();
						    		 
						    		 
						    	
						    		 
						    	 }
						    
		
				      } 
				     stmt1.close();
					 
				 } // else close
		 
		 
		
	}// for close
	

            			
		 response.getWriter().print(saveval);
			stmt.close();
	          conn.close();	
	 
	 	
	 
 }catch(Exception e){
	
		e.printStackTrace();

		 response.getWriter().print("12");
			conn.close();
	
	}

	 	
	 	
	 	
%>



