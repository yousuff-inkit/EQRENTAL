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
<%@page import=" com.dashboard.limousine.jobclose.ClsLimoJobCloseDAO" %>
  
<%	
System.out.println("======in end save==== ");	
Connection conn=null;
String msg="";
int vals=0,extrahr=0;
double minkm=0,ridechrg=0,extrakmrate=0,totalkm=0,mincharge=0,excesshrsrate=0;	
double nightminkmcharge=0.0,nightmincharge=0.0,nightextrakmrate=0.0 ,nightexcesshrsrate=0.0;
String timevalue="",stime="",etime="",totals="";
int totkm=0,tothrs=0,doc=0;
double vat=0.0,taxamount=0.0,extrahrcharges=0.0,total=0.0,totalchrg=0.0;

	try{
 //System.out.println("======aa==== ");		
		/* ClsAndroid and=new ClsAndroid(); */
		ClsConnection  ClsConnection =new ClsConnection();
		ClsCommon   ClsCommon =new ClsCommon();
		ClsLimoJobCloseDAO jobclosedao= new ClsLimoJobCloseDAO();
		String startkm=request.getParameter("startkm");
		String endkm=request.getParameter("endkm"); 
		String startdate=request.getParameter("startdate");
		String enddate=request.getParameter("enddate"); 
		String endtime=request.getParameter("endtime"); 
		String city=request.getParameter("city");
		String docno=request.getParameter("docno");
		String tarifdoc=request.getParameter("tarifdoc");
		String tarifdetdoc=request.getParameter("tarifdetdoc");
		String grpid=request.getParameter("grpid");
		String jobno=request.getParameter("jobno")==""?"0":request.getParameter("jobno").trim();
		String jobdoc=request.getParameter("jobdoc")==""?"0":request.getParameter("jobdoc").trim();
		String userid=request.getParameter("userid");
		String branch=request.getParameter("branch");
		String jobtype=request.getParameter("jobtype");
		String remark=request.getParameter("remark");
 		System.out.println("======aa==== "+endkm+":"+enddate+":"+endtime+":"+city+":"+docno+":"+grpid+":"+jobno);
		String bookdocno=jobno.split("-")[0];
		int docs=Integer.parseInt(bookdocno);
		int jobdocs=Integer.parseInt(jobdoc);
		String jobname=jobno.split("-")[1];
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		ClsCommon comm = new ClsCommon();
		
		 int val=0;
		 int aa=0;
		
		
		CallableStatement stmtUpdaterent = null;
		Statement stmt=conn.createStatement();
			
	  			java.sql.Date sqlenddate=ClsCommon.changeStringtoSqlDate(enddate);

	    		String sql="update an_starttripdet set endkm="+endkm+",enddate='"+sqlenddate+"',endtime='"+endtime+"',endlocation='"+city+"',endremarks='"+remark+"' where rowno="+docno+"";
 	    		System.out.println("sql1update=="+sql);
	    		val=stmt.executeUpdate(sql);
				if(val>0){
					msg="1";
				}
				
				
				String sqls11="select cstper value from gl_taxmaster where curDate() between fromdate and todate and type=2 and cstper!=0";
				System.out.println("sql2select=="+sqls11);
				ResultSet res=stmt.executeQuery(sqls11);
				while(res.next()){
					vat=res.getInt("value");
				}
			 
				
			 
				String sql1="select starttime,endtime,(endkm-startkm) totkm,TIMESTAMPDIFF(hour,concat(startdate,' ',starttime),concat(enddate,' ',endtime)) tothrs from an_starttripdet where rowno="+docno+"";
				System.out.println("sql3select=="+sql1);
				ResultSet rs1=stmt.executeQuery(sql1);
				while(rs1.next()){
					totkm=rs1.getInt("totkm");
					tothrs=rs1.getInt("tothrs");
					stime=rs1.getString("starttime");
					etime=rs1.getString("endtime");
				}
				
				String sqlss="select mincharge,minkmcharge, extrakmrate, excesshrsrate, nightmincharge, nightminkmcharge, nightextrakmrate, nightexcesshrsrate from gl_limotarifm m left join gl_limotariftaxi lt on lt.tarifdocno=m.doc_no where curdate() between validfrom and validto and lt.gid="+grpid+"";
				System.out.println("sql4select=="+sqlss);
				//					System.out.println("QQ=="+sqlss);
				ResultSet rss=stmt.executeQuery(sqlss);
						while(rss.next()){
							minkm=rss.getInt("minkmcharge");
							extrakmrate=rss.getInt("extrakmrate");
							mincharge=rss.getInt("mincharge");
							excesshrsrate=rss.getInt("excesshrsrate");
							
							nightmincharge=rss.getInt("nightmincharge");
							nightminkmcharge=rss.getInt("nightminkmcharge");   
							nightextrakmrate=rss.getInt("nightextrakmrate");
							nightexcesshrsrate=rss.getInt("nightexcesshrsrate");
						}	
		String sqls1="select value from gl_config where field_nme='standardspeed'";
						ResultSet rsss=stmt.executeQuery(sqls1);
						while(rsss.next()){
							vals=rsss.getInt("value");
						}
						
						extrahr=tothrs - (totkm/vals);
						int extrahour=0;
						if(extrahr>0){
							 extrahour=extrahr;
						}
						else
						{
							 extrahour=0;
						}
						
				/*  night trip=== in case of ride charge*/
						
				String sqls="select description from gl_config where field_nme='nightstarttime'";
				ResultSet rs=stmt.executeQuery(sqls);
				while(rs.next()){
					timevalue=rs.getString("description");
				}
				
				String[] ntime=timevalue.split(":");
				int nighthrs=Integer.parseInt(ntime[0]);
				int nightmin=Integer.parseInt(ntime[1]);
				
				String[] starttime=stime.split(":");
				int shrs=Integer.parseInt(starttime[0]);
				int smin=Integer.parseInt(starttime[1]);
				
				String[] entime=etime.split(":");
				int ehrs=Integer.parseInt(entime[0]);
				int emin=Integer.parseInt(entime[1]);
				
				if(shrs>=nighthrs)
				{
					if(shrs==nighthrs)
					{
						if(smin>=nightmin)
						{
							if(totkm<=nightminkmcharge){
								
								ridechrg=nightminkmcharge;
	 							System.out.println("nightridech=="+ridechrg);
							}
							else
							{
								totalkm=totkm-nightminkmcharge;
								ridechrg=(totalkm*nightextrakmrate)+nightmincharge;
								System.out.println("nightcase==tokm="+totalkm+"ridech=="+ridechrg);
								
							}
							extrahrcharges=extrahour*nightexcesshrsrate;
							totalchrg=ridechrg+extrahrcharges;
							taxamount=(ridechrg+extrahrcharges)*(vat/100);
							total=taxamount+ridechrg+extrahrcharges;
							
							
						}
					}
					else{
						if(totkm<=nightminkmcharge){
							
							ridechrg=nightminkmcharge;
 							System.out.println("nightridech=="+ridechrg);
						}
						else
						{
							totalkm=totkm-nightminkmcharge;
							ridechrg=(totalkm*nightextrakmrate)+nightmincharge;
							System.out.println("nightcase==tokm="+totalkm+"ridech=="+ridechrg);
							
						}
						extrahrcharges=extrahour*nightexcesshrsrate;
						totalchrg=ridechrg+extrahrcharges;
						taxamount=(ridechrg+extrahrcharges)*(vat/100);
						total=taxamount+ridechrg+extrahrcharges;
					}
					
				}
				else if(ehrs>=nighthrs){
					if(ehrs==nighthrs)
					{
						if(emin>=nightmin)
						{
							if(totkm<=nightminkmcharge){
								
								ridechrg=nightminkmcharge;
	 							System.out.println("End **nightridech=="+ridechrg);
							}
							else
							{
								totalkm=totkm-nightminkmcharge;
								ridechrg=(totalkm*nightextrakmrate)+nightmincharge;
								System.out.println("End nightcase==tokm="+totalkm+"ridech=="+ridechrg);
								
							}
							extrahrcharges=extrahour*nightexcesshrsrate;
							totalchrg=ridechrg+extrahrcharges;
							taxamount=(ridechrg+extrahrcharges)*(vat/100);
							total=taxamount+ridechrg+extrahrcharges;
						}
					}
					else{
						if(totkm<=nightminkmcharge){
							
							ridechrg=nightminkmcharge;
 							System.out.println("End nightridech=="+ridechrg);
						}
						else
						{
							totalkm=totkm-nightminkmcharge;
							ridechrg=(totalkm*nightextrakmrate)+nightmincharge;
							System.out.println("End nightcase==tokm="+totalkm+"ridech=="+ridechrg);
							
						}
						extrahrcharges=extrahour*nightexcesshrsrate;
						totalchrg=ridechrg+extrahrcharges;
						taxamount=(ridechrg+extrahrcharges)*(vat/100);
						total=taxamount+ridechrg+extrahrcharges;
					}
				}
				else{
						if(totkm<=minkm){
							
							ridechrg=minkm;
// 							System.out.println("ridech=="+ridechrg);
						}
						else
						{
							totalkm=totkm-minkm;
							ridechrg=(totalkm*extrakmrate)+mincharge;
							//System.out.println("tokm="+totalkm+"ridech=="+ridechrg);
						}
				/* extra hour rate */
						extrahrcharges=extrahour*excesshrsrate;
						totalchrg=ridechrg+extrahrcharges;
						taxamount=(ridechrg+extrahrcharges)*(vat/100);
						total=taxamount+ridechrg+extrahrcharges;
						
			  	/*ends******  */
				}
						
	  String sqlss1="insert into my_trno(USERNO, TRTYPE, brhId, edate, transid) values("+userid+",'CINV',1,now(),0)";
	  System.out.println("sql6insert=="+sqlss1);		
	  int vals1=stmt.executeUpdate(sqlss1);
			
				
				
						
						
						
						
			String sql12="insert into an_cashinvm(doc_no,jobid, tripcharge, extrahrschrg, totalchrg, vat, nettotal, userid,bookdocno,jobname)values("+doc+",'"+jobno+"',"+ridechrg+","+extrahrcharges+","+totalchrg+","+taxamount+","+total+","+userid+","+bookdocno+",'"+jobname+"')";
			System.out.println("sql7insert=="+sql12);	 
			int val1=stmt.executeUpdate(sql12);
			if(val1>0){
				msg="1";
				
			}
			
			String sql13="update gl_limomanagement set bstatus=7 where docno="+bookdocno+" and job='"+jobname+"' ";
			System.out.println("sqlupdate=="+sql13);	 
			int val2=stmt.executeUpdate(sql13);
			if(val1>0){
				msg="1";
			}
			
			 int status=0;
			int maxdoc=0;
			String strmaxdoc="select coalesce(max(doc_no)+1,1) maxdoc from gl_limojobclose";
			ResultSet rsmaxdoc=stmt.executeQuery(strmaxdoc);
			while(rsmaxdoc.next()){
				maxdoc=rsmaxdoc.getInt("maxdoc");
			}
			
			jobclosedao.CalculateData(bookdocno, jobdoc, jobname, tarifdoc, tarifdetdoc, startdate, stime, startkm, enddate, endtime, 
					endkm, "0", "0", "0", "0", "0", "0",conn);
			
			System.out.println("input=="+docs+"=="+jobno+"==="+jobname+"==="+total);	
				CallableStatement stmtJobclose = conn.prepareCall("{call limoJobCloseAppDML(?,?,?,?,?,?,?,?,?,?)}");
				stmtJobclose.setInt(1, docs);
				stmtJobclose.setInt(2, jobdocs);
				stmtJobclose.setString(3, jobtype);
				stmtJobclose.setString(4, "A");
				stmtJobclose.setString(5, "BLJC");
				stmtJobclose.setString(6, branch);
				stmtJobclose.setString(7, userid);
				stmtJobclose.setString(8, "1");
				stmtJobclose.setInt(9, maxdoc);
				stmtJobclose.setString(10, "APP");
				stmtJobclose.executeQuery();
				//int docno=stmtJobclose.getInt("docNo");
				if(maxdoc<=0){
					msg="0";
				}
				else{
					msg="1";
					
				} 
			
			String sql14="select max(doc_no) docno from an_cashinvm";
			ResultSet rs2=stmt.executeQuery(sql14);
			while(rs2.next()){
				doc=rs2.getInt("docno");
			}
			
			/* String sql13="insert into an_cashinvm(rdocno, curid, rate, amount, total)values('"+doc+"',"+ridechrg+","+extrahrcharges+","+totalchrg+","+vat+","+total+","+userid+")";
			int val2=stmt.executeUpdate(sql13); */
			
/*ends****  */
			if(msg.equalsIgnoreCase("1")){
				conn.commit();
			}
		 	
		
	}
	catch(Exception e){
		
		conn.close();
	 	e.printStackTrace();
	 	 
	}
	response.getWriter().write(msg+"::"+total+"::"+ridechrg+"::"+extrahrcharges+"::"+vat+"::"+taxamount+"::"+doc);
// 	System.out.println("msg=="+msg);
	
  %>
  
