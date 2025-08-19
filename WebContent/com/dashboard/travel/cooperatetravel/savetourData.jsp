<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>  
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>  
<%@page import="com.common.*"%>   
<%@page import="com.limousine.limobooking.ClsLimoBookingDAO"%>             
<%   
	String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray"); 
	String guest=request.getParameter("guest")==null?"":request.getParameter("guest"); 
	String agentid=request.getParameter("agentid")==null || request.getParameter("agentid")==""?"0":request.getParameter("agentid").trim().toString();	
	String limodocno=request.getParameter("limodocno")==null || request.getParameter("limodocno")==""?"0":request.getParameter("limodocno").trim().toString();
	String nationid=request.getParameter("nationid")==null || request.getParameter("nationid")==""?"0":request.getParameter("nationid").trim().toString();
	int type=request.getParameter("type") ==null || request.getParameter("type")==""?0:Integer.parseInt(request.getParameter("type").trim().toString());
	String locid=request.getParameter("locid")==null || request.getParameter("locid")==""?"0":request.getParameter("locid").trim().toString();
	String sacno=request.getParameter("sacno")==null || request.getParameter("sacno")==""?"0":request.getParameter("sacno").trim().toString();
	String sadocno=request.getParameter("sadocno")==null || request.getParameter("sadocno")==""?"0":request.getParameter("sadocno").trim().toString();
	int rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?0:Integer.parseInt(request.getParameter("rdocno").trim().toString());
	String edate=request.getParameter("edate") ==null || request.getParameter("edate")==""?"0":request.getParameter("edate");
	String mobno=request.getParameter("mob") ==null || request.getParameter("mob")==""?"":request.getParameter("mob");
	String email=request.getParameter("mail") ==null || request.getParameter("mail")==""?"":request.getParameter("mail");  
	String client=request.getParameter("client") ==null || request.getParameter("client")==""?"":request.getParameter("client"); 
	String clientid=request.getParameter("clientid")==null || request.getParameter("clientid")==""?"0":request.getParameter("clientid");  
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");
	String salid=request.getParameter("salid")==null || request.getParameter("salid")==""?"0":request.getParameter("salid");
	int servocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?0:Integer.parseInt(request.getParameter("vocno").trim().toString());
	String userid=session.getAttribute("USERID").toString();      
	java.sql.Date sqldate=null;       
	String airport="",flight="",roomno="",hotel="",locationtype="",sername="";   
	boolean test=false;
	int vocno=0; 
	ClsConnection objconn=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn=null;
	String msg="";
	int dat=0,clacno=0,docno=0;
	try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		ClsLimoBookingDAO DAO=new ClsLimoBookingDAO();      
		if(!edate.equalsIgnoreCase("undefined") && !edate.equalsIgnoreCase("") && !edate.equalsIgnoreCase("0"))
		{
			 sqldate=ClsCommon.changeStringtoSqlDate(edate);
		}
		SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
		java.util.Date curDate=new java.util.Date();
		java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
		Statement stmt=conn.createStatement();  
		Statement stmt2=conn.createStatement(); 
		int val=0,tempval=0;
		boolean tempval2=false;        
		if(rdocno==0){
			String sqlvoc="select coalesce((max(voc_no)+1),1) voc_no from tr_servicereqm where brhid='"+brhid+"'";    
			ResultSet rs7=stmt.executeQuery(sqlvoc);
			if(rs7.next()){
				vocno=rs7.getInt("voc_no");    
			}
			String strsql="insert into tr_servicereqm(voc_no, date, Cldocno, userid, status, brhid, refname, mob, mail, locid, type, nationid, salid, agentid, guest, cooperate) values('"+vocno+"','"+sqldate+"',"+clientid+","+userid+",3,"+brhid+",'"+client+"','"+mobno+"','"+email+"','"+locid+"',"+type+",'"+nationid+"','"+salid+"','"+agentid+"','"+guest+"',1)";   
			//System.out.println(strsql);  
			int insertval=stmt.executeUpdate(strsql);   
			if(insertval>0){ 
				String sql1="select max(doc_no) docno from tr_servicereqm";     
				ResultSet rs=stmt.executeQuery(sql1);        
				if(rs.next()){
					docno=rs.getInt("docno");
				}
			}
		}else{
			docno=rdocno;    
			vocno=servocno;  
		}
		String strcountdata1="select coalesce(limodocno,0) limodocno,coalesce(refname,'') refname  from tr_servicereqm where doc_no='"+docno+"'";     
		//System.out.println("strcountdata1--->>>"+strcountdata1);                                   
		ResultSet rs12=stmt.executeQuery(strcountdata1);                             
		while(rs12.next()){               
			limodocno=rs12.getString("limodocno"); 
			sername=rs12.getString("refname");    
		}  
		String strcountdata="select h.doc_no clacno from my_head h inner join my_acbook a on h.cldocno=a.cldocno and a.dtype='CRM' and h.atype='AR' where a.cldocno='"+clientid+"' ";
		//System.out.println("strcountdata--->>>"+strcountdata);                                   
		ResultSet rss=stmt.executeQuery(strcountdata);                             
		while(rss.next()){          
			clacno=rss.getInt("clacno");  
		}  
		if(clacno==0){  
			strcountdata="select ac.cldocno from my_account acc left join my_acbook ac on ac.acno=acc.acno where acc.codeno='CASHACSALES'";         
			ResultSet rs1=stmt.executeQuery(strcountdata);                             
			while(rs1.next()){          
				clientid=rs1.getString("cldocno");                    
			}     
		}
		//System.out.println("in=="+docno);
			ArrayList<String> transferarray=new ArrayList();      
			ArrayList<String> hoursarray=new ArrayList();      
			ArrayList<String> newarray=new ArrayList();
			
			String temparray[]=gridarray.split(",");
			for(int i=0;i<temparray.length;i++){
				newarray.add(temparray[i]);
			}
	         		
			int srno=0;
			for(int i=0;i<newarray.size();i++){
				
				String temp[]=newarray.get(i).split("::");
				
				if(!temp[0].trim().equalsIgnoreCase("undefined") && !temp[0].trim().equalsIgnoreCase("NaN") && !temp[0].trim().equalsIgnoreCase("")){
				String tourid = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"0":temp[0].trim()).toString();    
				String date = temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?"":temp[1].trim().toString();
				String remarks = temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().equalsIgnoreCase("NaN") || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().isEmpty()?"0":temp[2].trim().toString();
				int vendor = temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().equalsIgnoreCase("NaN") || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().isEmpty()?0:Integer.parseInt(temp[3].trim().toString());
				int rowsno= temp[4].trim().equalsIgnoreCase("undefined") || temp[4].trim().equalsIgnoreCase("NaN") || temp[4].trim().equalsIgnoreCase("") || temp[4].trim().isEmpty()?0:Integer.parseInt(temp[4].trim().toString());
				String adult = (temp[5].trim().equalsIgnoreCase("undefined") || temp[5].trim().equalsIgnoreCase("NaN") || temp[5].trim().equalsIgnoreCase("") || temp[5].trim().isEmpty()?"0":temp[5].trim()).toString();
				String child = (temp[6].trim().equalsIgnoreCase("undefined") || temp[6].trim().equalsIgnoreCase("NaN") || temp[6].trim().equalsIgnoreCase("") || temp[6].trim().isEmpty()?"0":temp[6].trim()).toString();  
				String spadult = (temp[7].trim().equalsIgnoreCase("undefined") || temp[7].trim().equalsIgnoreCase("NaN") || temp[7].trim().equalsIgnoreCase("") || temp[7].trim().isEmpty()?"0.0":temp[7].trim()).toString();
				String spchild = (temp[8].trim().equalsIgnoreCase("undefined") || temp[8].trim().equalsIgnoreCase("NaN") || temp[8].trim().equalsIgnoreCase("") || temp[8].trim().isEmpty()?"0.0":temp[8].trim()).toString();
				String adultval = (temp[9].trim().equalsIgnoreCase("undefined") || temp[9].trim().equalsIgnoreCase("NaN") || temp[9].trim().equalsIgnoreCase("") || temp[9].trim().isEmpty()?"0.0":temp[9].trim()).toString();
				String childval = (temp[10].trim().equalsIgnoreCase("undefined") || temp[10].trim().equalsIgnoreCase("NaN") || temp[10].trim().equalsIgnoreCase("") || temp[10].trim().isEmpty()?"0.0":temp[10].trim()).toString();
				String total = (temp[11].trim().equalsIgnoreCase("undefined") || temp[11].trim().equalsIgnoreCase("NaN") || temp[11].trim().equalsIgnoreCase("") || temp[11].trim().isEmpty()?"0.0":temp[11].trim()).toString();
				String time = (temp[12].trim().equalsIgnoreCase("undefined") || temp[12].trim().equalsIgnoreCase("NaN") || temp[12].trim().equalsIgnoreCase("") || temp[12].trim().isEmpty()?"0":temp[12].trim()).toString();
				String adultdis = (temp[13].trim().equalsIgnoreCase("undefined") || temp[13].trim().equalsIgnoreCase("NaN") || temp[13].trim().equalsIgnoreCase("") || temp[13].trim().isEmpty()?"0.0":temp[13].trim()).toString(); 
				String childdis = (temp[14].trim().equalsIgnoreCase("undefined") || temp[14].trim().equalsIgnoreCase("NaN") || temp[14].trim().equalsIgnoreCase("") || temp[14].trim().isEmpty()?"0.0":temp[14].trim()).toString();
				String distype = (temp[15].trim().equalsIgnoreCase("undefined") || temp[15].trim().equalsIgnoreCase("NaN") || temp[15].trim().equalsIgnoreCase("") || temp[15].trim().isEmpty()?"":temp[15].trim()).toString();
				String tourdocno = (temp[16].trim().equalsIgnoreCase("undefined") || temp[16].trim().equalsIgnoreCase("NaN") || temp[16].trim().equalsIgnoreCase("") || temp[16].trim().isEmpty()?"0":temp[16].trim()).toString();
				String infant = (temp[17].trim().equalsIgnoreCase("undefined") || temp[17].trim().equalsIgnoreCase("NaN") || temp[17].trim().equalsIgnoreCase("") || temp[17].trim().isEmpty()?"0.0":temp[17].trim()).toString();
				String stdtotal = (temp[18].trim().equalsIgnoreCase("undefined") || temp[18].trim().equalsIgnoreCase("NaN") || temp[18].trim().equalsIgnoreCase("") || temp[18].trim().isEmpty()?"0.0":temp[18].trim()).toString();
				String transferid = temp[19].trim().equalsIgnoreCase("undefined") || temp[19].trim().equalsIgnoreCase("NaN") || temp[19].trim().equalsIgnoreCase("") || temp[19].trim().isEmpty()?"0":temp[19].trim().toString();
				String groupid = temp[20].trim().equalsIgnoreCase("undefined") || temp[20].trim().equalsIgnoreCase("NaN") || temp[20].trim().equalsIgnoreCase("") || temp[20].trim().isEmpty()?"0":temp[20].trim().toString();
				String transfertype = temp[21].trim().equalsIgnoreCase("undefined") || temp[21].trim().equalsIgnoreCase("NaN") || temp[21].trim().equalsIgnoreCase("") || temp[21].trim().isEmpty()?"0":temp[21].trim().toString();
				String qty = temp[22].trim().equalsIgnoreCase("undefined") || temp[22].trim().equalsIgnoreCase("NaN") || temp[22].trim().equalsIgnoreCase("") || temp[22].trim().isEmpty()?"0.0":temp[22].trim().toString();
				String loctype = temp[23].trim().equalsIgnoreCase("undefined") || temp[23].trim().equalsIgnoreCase("NaN") || temp[23].trim().equalsIgnoreCase("") || temp[23].trim().isEmpty()?"0":temp[23].trim().toString();
				String rname = temp[24].trim().equalsIgnoreCase("undefined") || temp[24].trim().equalsIgnoreCase("NaN") || temp[24].trim().equalsIgnoreCase("") || temp[24].trim().isEmpty()?"0":temp[24].trim().toString();
				String refno = temp[25].trim().equalsIgnoreCase("undefined") || temp[25].trim().equalsIgnoreCase("NaN") || temp[25].trim().equalsIgnoreCase("") || temp[25].trim().isEmpty()?"0":temp[25].trim().toString();
				String plocid = temp[26].trim().equalsIgnoreCase("undefined") || temp[26].trim().equalsIgnoreCase("NaN") || temp[26].trim().equalsIgnoreCase("") || temp[26].trim().isEmpty()?"0":temp[26].trim().toString();
				String ploctime = temp[27].trim().equalsIgnoreCase("undefined") || temp[27].trim().equalsIgnoreCase("NaN") || temp[27].trim().equalsIgnoreCase("") || temp[27].trim().isEmpty()?"0":temp[27].trim().toString();
				String dlocid = temp[28].trim().equalsIgnoreCase("undefined") || temp[28].trim().equalsIgnoreCase("NaN") || temp[28].trim().equalsIgnoreCase("") || temp[28].trim().isEmpty()?"0":temp[28].trim().toString();
				String rtripid = temp[29].trim().equalsIgnoreCase("undefined") || temp[29].trim().equalsIgnoreCase("NaN") || temp[29].trim().equalsIgnoreCase("") || temp[29].trim().isEmpty()?"0":temp[29].trim().toString();
				String tvltotal = temp[30].trim().equalsIgnoreCase("undefined") || temp[30].trim().equalsIgnoreCase("NaN") || temp[30].trim().equalsIgnoreCase("") || temp[30].trim().isEmpty()?"0.0":temp[30].trim().toString();
				String rndplocid = temp[31].trim().equalsIgnoreCase("undefined") || temp[31].trim().equalsIgnoreCase("NaN") || temp[31].trim().equalsIgnoreCase("") || temp[31].trim().isEmpty()?"0":temp[31].trim().toString();
				String rndploctime = temp[32].trim().equalsIgnoreCase("undefined") || temp[32].trim().equalsIgnoreCase("NaN") || temp[32].trim().equalsIgnoreCase("") || temp[32].trim().isEmpty()?"0":temp[32].trim().toString();
				String rnddlocid = temp[33].trim().equalsIgnoreCase("undefined") || temp[33].trim().equalsIgnoreCase("NaN") || temp[33].trim().equalsIgnoreCase("") || temp[33].trim().isEmpty()?"0":temp[33].trim().toString();
				String tarifdetaildocno = temp[34].trim().equalsIgnoreCase("undefined") || temp[34].trim().equalsIgnoreCase("NaN") || temp[34].trim().equalsIgnoreCase("") || temp[34].trim().isEmpty()?"0":temp[34].trim().toString();
				String estdistance = temp[35].trim().equalsIgnoreCase("undefined") || temp[35].trim().equalsIgnoreCase("NaN") || temp[35].trim().equalsIgnoreCase("") || temp[35].trim().isEmpty()?"0":temp[35].trim().toString();
				String esttime = temp[36].trim().equalsIgnoreCase("undefined") || temp[36].trim().equalsIgnoreCase("NaN") || temp[36].trim().equalsIgnoreCase("") || temp[36].trim().isEmpty()?"0":temp[36].trim().toString();
				String exdistancerate = temp[37].trim().equalsIgnoreCase("undefined") || temp[37].trim().equalsIgnoreCase("NaN") || temp[37].trim().equalsIgnoreCase("") || temp[37].trim().isEmpty()?"0.0":temp[37].trim().toString();
				String extimerate = temp[38].trim().equalsIgnoreCase("undefined") || temp[38].trim().equalsIgnoreCase("NaN") || temp[38].trim().equalsIgnoreCase("") || temp[38].trim().isEmpty()?"0.0":temp[38].trim().toString();
				String tourtransferrate = temp[39].trim().equalsIgnoreCase("undefined") || temp[39].trim().equalsIgnoreCase("NaN") || temp[39].trim().equalsIgnoreCase("") || temp[39].trim().isEmpty()?"0.0":temp[39].trim().toString();
				String tourtransferratetot = temp[40].trim().equalsIgnoreCase("undefined") || temp[40].trim().equalsIgnoreCase("NaN") || temp[40].trim().equalsIgnoreCase("") || temp[40].trim().isEmpty()?"0.0":temp[40].trim().toString();  
				String rttarifdetaildocno = temp[41].trim().equalsIgnoreCase("undefined") || temp[41].trim().equalsIgnoreCase("NaN") || temp[41].trim().equalsIgnoreCase("") || temp[41].trim().isEmpty()?"0":temp[41].trim().toString();
				String rtestdistance = temp[42].trim().equalsIgnoreCase("undefined") || temp[42].trim().equalsIgnoreCase("NaN") || temp[42].trim().equalsIgnoreCase("") || temp[42].trim().isEmpty()?"0":temp[42].trim().toString();
				String rtesttime = temp[43].trim().equalsIgnoreCase("undefined") || temp[43].trim().equalsIgnoreCase("NaN") || temp[43].trim().equalsIgnoreCase("") || temp[43].trim().isEmpty()?"0":temp[43].trim().toString();
				String rtexdistancerate = temp[44].trim().equalsIgnoreCase("undefined") || temp[44].trim().equalsIgnoreCase("NaN") || temp[44].trim().equalsIgnoreCase("") || temp[44].trim().isEmpty()?"0.0":temp[44].trim().toString();
				String rtextimerate = temp[45].trim().equalsIgnoreCase("undefined") || temp[45].trim().equalsIgnoreCase("NaN") || temp[45].trim().equalsIgnoreCase("") || temp[45].trim().isEmpty()?"0.0":temp[45].trim().toString();
				String rttourtransferrate = temp[46].trim().equalsIgnoreCase("undefined") || temp[46].trim().equalsIgnoreCase("NaN") || temp[46].trim().equalsIgnoreCase("") || temp[46].trim().isEmpty()?"0.0":temp[46].trim().toString();
				String tarifdocno = temp[47].trim().equalsIgnoreCase("undefined") || temp[47].trim().equalsIgnoreCase("NaN") || temp[47].trim().equalsIgnoreCase("") || temp[47].trim().isEmpty()?"0":temp[47].trim().toString();
				String rttarifdocno = temp[48].trim().equalsIgnoreCase("undefined") || temp[48].trim().equalsIgnoreCase("NaN") || temp[48].trim().equalsIgnoreCase("") || temp[48].trim().isEmpty()?"0":temp[48].trim().toString();
				String rowdelete = temp[49].trim().equalsIgnoreCase("undefined") || temp[49].trim().equalsIgnoreCase("NaN") || temp[49].trim().equalsIgnoreCase("") || temp[49].trim().isEmpty()?"0":temp[49].trim().toString();
				String stocktype = temp[50].trim().equalsIgnoreCase("undefined") || temp[50].trim().equalsIgnoreCase("NaN") || temp[50].trim().equalsIgnoreCase("") || temp[50].trim().isEmpty()?"0":temp[50].trim().toString();
				//String refstockid = temp[51].trim().equalsIgnoreCase("undefined") || temp[51].trim().equalsIgnoreCase("NaN") || temp[51].trim().equalsIgnoreCase("") || temp[51].trim().isEmpty()?"0":temp[51].trim().toString();
				if(loctype.equalsIgnoreCase("F")){       
					airport=rname; 
					flight=refno; 
					locationtype="flight";
				}else if(loctype.equalsIgnoreCase("H")){    
					hotel=rname;
					roomno=refno;  
					locationtype="hotel";  
				}
				String emtystr="";
				if(rowdelete.equalsIgnoreCase("0")){             
					srno++;
					transferarray.add("T"+srno+"::"+date+"::"+ploctime+"::"+plocid+"::"+emtystr+"::"+dlocid+"::"+emtystr+"::"+0+"::"+0+"::"+qty+"::"+tarifdocno+"::"+0+"::"+groupid+"::"+tarifdetaildocno+"::"+ transfertype+"::"+ estdistance+"::"+esttime+"::"+ tarifdocno+"::"+ exdistancerate+"::"+extimerate);          
					
					if(rtripid.equalsIgnoreCase("1") && transferid.equalsIgnoreCase("1")){              
						srno++;
						transferarray.add("T"+srno+"::"+date+"::"+rndploctime+"::"+rndplocid+"::"+emtystr+"::"+rnddlocid+"::"+emtystr+"::"+0+"::"+0+"::"+qty+"::"+rttarifdocno+"::"+0+"::"+groupid+"::"+rttarifdetaildocno+"::"+ transfertype+"::"+ rtestdistance+"::"+rtesttime+"::"+ rttarifdocno+"::"+ rtexdistancerate+"::"+rtextimerate);
					}
				}
				if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){               
					 sqldate=ClsCommon.changetstmptoSqlDate(date);                                       
				}      
				if(rowsno>0){
					if(rowdelete.equalsIgnoreCase("1")){
						 String sqls="delete from tr_srtour where rowno="+rowsno+"";         
						 val=stmt.executeUpdate(sqls);   
					}else{
						 String sql="update tr_srtour set srno="+(i+1)+", tourid="+tourid+", date='"+sqldate+"', remarks='"+remarks+"',vendorid="+vendor+",stdtotal="+Double.parseDouble(stdtotal)+",infant="+Double.parseDouble(infant)+",adult="+Double.parseDouble(adult)+",child="+Double.parseDouble(child)+",spadult="+Double.parseDouble(spadult)+",spchild="+Double.parseDouble(spchild)+",adultval="+Double.parseDouble(adultval)+",childval="+Double.parseDouble(childval)+",total="+Double.parseDouble(total)+", time='"+time+"',adultdis="+Double.parseDouble(adultdis)+",childdis="+Double.parseDouble(childdis)+",distype='"+distype+"',tourdocno='"+tourdocno+"',transferid='"+transferid+"', groupid='"+groupid+"', transfertype='"+transfertype+"', qty="+Double.parseDouble(qty)+", loctype='"+loctype+"', rname='"+rname+"', refno='"+refno+"', plocid='"+plocid+"', ploctime='"+ploctime+"', dlocid='"+dlocid+"', rtripid='"+rtripid+"', tvltotal="+Double.parseDouble(tvltotal)+", rndplocid='"+rndplocid+"', rndploctime='"+rndploctime+"', rnddlocid='"+rnddlocid+"', tarifdetaildocno='"+tarifdetaildocno+"', estdistance='"+estdistance+"', esttime='"+esttime+"', exdistancerate="+Double.parseDouble(exdistancerate)+", extimerate="+Double.parseDouble(extimerate)+", tourtransferrate="+Double.parseDouble(tourtransferrate)+", tourtransferratetot="+Double.parseDouble(tourtransferratetot)+", rttarifdetaildocno='"+rttarifdetaildocno+"', rtestdistance='"+rtestdistance+"', rtesttime='"+rtesttime+"', rtexdistancerate="+Double.parseDouble(rtexdistancerate)+", rtextimerate="+Double.parseDouble(rtextimerate)+", rttourtransferrate="+Double.parseDouble(rttourtransferrate)+", tarifdocno='"+tarifdocno+"', rttarifdocno='"+rttarifdocno+"' where rowno="+rowsno+"";   
						 val=stmt.executeUpdate(sql);
					}
				}else{ 
					if(!rowdelete.equalsIgnoreCase("1")){   
						 int srowno=0,adultno=0,childno=0;      
						 String sql="insert into tr_srtour(rdocno, srno, tourid, date, remarks, vendorid, adult, child, spadult, spchild, adultval, childval, total,time, adultdis, childdis, distype, tourdocno, infant, stdtotal, transferid, groupid, transfertype, qty, loctype, rname, refno, plocid, ploctime, dlocid, rtripid, tvltotal, rndplocid, rndploctime, rnddlocid, tarifdetaildocno, estdistance, esttime, exdistancerate, extimerate, tourtransferrate, tourtransferratetot, rttarifdetaildocno, rtestdistance, rtesttime, rtexdistancerate, rtextimerate, rttourtransferrate, tarifdocno, rttarifdocno, confirm) values("+docno+","+(i+1)+","+tourid+",'"+sqldate+"','"+remarks+"',"+vendor+","+Integer.parseInt(adult)+","+Integer.parseInt(child)+","+Double.parseDouble(spadult)+","+Double.parseDouble(spchild)+","+Double.parseDouble(adultval)+","+Double.parseDouble(childval)+","+Double.parseDouble(total)+",'"+time+"',"+Double.parseDouble(adultdis)+","+Double.parseDouble(childdis)+",'"+distype+"','"+tourdocno+"',"+Double.parseDouble(infant)+","+Double.parseDouble(stdtotal)+",'"+transferid+"', '"+groupid+"', '"+transfertype+"',"+Double.parseDouble(qty)+",'"+loctype+"', '"+rname+"', '"+refno+"','"+plocid+"', '"+ploctime+"', '"+dlocid+"','"+rtripid+"', "+Double.parseDouble(tvltotal)+",'"+rndplocid+"', '"+rndploctime+"', '"+rnddlocid+"', '"+tarifdetaildocno+"', '"+estdistance+"','"+esttime+"', "+Double.parseDouble(exdistancerate)+", "+Double.parseDouble(extimerate)+", "+Double.parseDouble(tourtransferrate)+", "+Double.parseDouble(tourtransferratetot)+", '"+rttarifdetaildocno+"', '"+rtestdistance+"', '"+rtesttime+"', "+Double.parseDouble(rtexdistancerate)+","+Double.parseDouble(rtextimerate)+","+Double.parseDouble(rttourtransferrate)+",'"+tarifdocno+"','"+rttarifdocno+"',1)";
						 val=stmt.executeUpdate(sql);    
						 if(val>0){    
							  String sql2="insert into tr_servicereqd(rdocno, srno, servid, pax) values("+docno+",1,5,1)";                    
							  val=stmt.executeUpdate(sql2); 
							  String sql51="select max(rowno) rowno from tr_srtour";       
							  ResultSet rsrowno=stmt.executeQuery(sql51);        
							  if(rsrowno.next()){
									srowno=rsrowno.getInt("rowno");  
							  }

							  if(stocktype.equalsIgnoreCase("stock")){
								  adultno=Integer.parseInt(adult);     
								  childno=Integer.parseInt(child); 
								  //System.out.println(adultno+"==adultno=======before insert========childno=="+childno);   
									  String sql53="select stockid,adult,child from(select stockid,refstockid,tourid,sum(adult) adult,sum(child) child from tr_tourstock where tourid="+tourid+" group by refstockid)a where (a.adult>0 or a.child>0)";          
									  //System.out.println("======sql53======="+sql53);   
									  ResultSet acrs=stmt.executeQuery(sql53);          
									  while(acrs.next()){ 
										  int skadult=0,skchild=0,upadult=0,upchild=0,refstockid=0;     
										  skadult=acrs.getInt("adult"); 
										  skchild=acrs.getInt("child");  
										  refstockid=acrs.getInt("stockid"); 
										  if(skadult>=adultno){
											  upadult=adultno;
											  adultno=0;
										  }else{
											  upadult=skadult;
											  adultno=adultno-skadult;
										  }
										  if(skchild>=childno){
											  upchild=childno; 
											  childno=0;
										  }else{     
											  upchild=skchild;  
											  childno=childno-skchild;       
										  }
										  //System.out.println(upadult+"==upadult=======inside insert========upchild=="+upchild);  
										  if(upadult>0 || upchild>0){   
											  String sql52="insert into  tr_tourstock(tourid, vendorid, refdocno, date, adult, child, locid, brhid, sr_no, cost_price, sellingprice,refstockid, refrowno, cpadult, cpchild, spadult, spchild, userid) values("+tourid+","+vendor+","+docno+",'"+sqldate+"',"+upadult*-1+","+upchild*-1+",'"+locid+"','"+brhid+"',"+(i+1)+","+Double.parseDouble(stdtotal)+","+Double.parseDouble(total)+",'"+refstockid+"','"+srowno+"',"+Double.parseDouble(adultval)+","+Double.parseDouble(childval)+","+Double.parseDouble(spadult)+","+Double.parseDouble(spchild)+",'"+userid+"')";                    
											  //System.out.println("======sql52======="+sql52);   								 
											  val=stmt2.executeUpdate(sql52); 
										  }
										  //System.out.println(adultno+"==adultno=======inside insert========childno=="+childno);
									  }
							  }       
						 }
				     }  
			      }
				}
			/* conn.commit(); */         
		    }  
			//System.out.println("============="+limodocno);                 
			if(val>0){ 
				if(Integer.parseInt(limodocno)==0){                          
				dat=DAO.insert(cdate, clientid, "0",guest, mobno, "1",session, "A","LBK",brhid,"Service Request Tour - "+vocno,airport,flight,hotel,roomno,locationtype);          
				//System.out.println(rdocno+"===Limo insert>>>"+dat); 
				if(dat>0){             
					tempval2=DAO.insertTarif(dat, transferarray, hoursarray,session,"A");                            
				}
				}else{    
					test=DAO.edit(Integer.parseInt(limodocno), cdate, clientid, "0",guest, mobno, "1",session, "E","LBK",brhid,"Service Request Tour - "+vocno,airport,flight,hotel,roomno,locationtype);          
					//System.out.println(limodocno+"===Limo Edit>>>"+test);                           
					if(test){                    
						tempval2=DAO.insertTarif(Integer.parseInt(limodocno), transferarray, hoursarray,session,"E");                                    
					}
					dat=Integer.parseInt(limodocno);     
				}   
				//System.out.println("tempval2---->>>"+tempval2);           
				String tempsql="update tr_servicereqm set satacno='"+sacno+"',satdocno='"+sadocno+"',limodocno='"+dat+"' where doc_no='"+docno+"'";                           
				//System.out.println(tempsql);               
			     tempval=stmt.executeUpdate(tempsql); 
				}
				if(val>0 || tempval>0){
					msg="0";   
					conn.commit();  
			}
				//System.out.println(sername+"------------>>>"+vocno);            
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}   
	response.getWriter().print(msg+"###"+docno+"###"+vocno+"###"+sername);         
%>