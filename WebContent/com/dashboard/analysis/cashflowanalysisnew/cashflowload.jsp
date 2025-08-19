<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>  
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
	Connection conn = null;
    System.out.println("in......");
	try{  
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		//conn.setAutoCommit(false);
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("")){
			sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("")){
			sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		}
		String strjvdatecondition=" and j.date>='"+sqlfromdate+"' and j.date<='"+sqltodate+"'";
		String strmasterdatecondition=" and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"'";
	     String sql="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="";        
	     int val=0;  
	     //sql="truncate table my_cashtran";  
	     sql="delete from my_cashtran where date between '"+sqlfromdate+"' and '"+sqltodate+"'";
	     //System.out.println("sql------>>"+sql);
	     stmt.executeUpdate(sql);  
	     /***
	     *	comented for qaf - same account multiple times in same document   
	     * sql2="insert into my_cashtran(mainacno, mainname, mainden, trno, doc_no, dtype, tranacno, tranname, tranden, date, amount, desc1,bank)"
	    	 + " select a.acno, a.description, a.den, a.tr_no,a.doc_no, a.dtype, b.acno , b.description , b.den , b.date , b.dramount, b.dec1, b.bank from"
	    	 + " (select j.acno,h.description,h.den,j.tr_no,j.doc_no,j.dtype,j.tranid from my_jvtran j left join my_head h on j.acno=h.doc_no"
	    	 + " left join my_chqdet ch on ch.pdcposttrno=j.tr_no where j.status=3 and h. den in (305,604) and ch.tr_no is null) a"
	    	 + " left join (select j.dramount,j.acno,h.description,j.description dec1,h.den,j.date,j.tr_no,j.tranid,if(h.den in (305,604),1,0) bank"
	    	 + " from my_jvtran j left join my_head h on j.acno=h.doc_no where j.status=3 ) b on a.tr_no=b.tr_no where  b.tr_no is not null and a.tranid!=b.tranid group by A.TRANID,b.tranid"
	    	 + " union all  select h.doc_no,h.description,h.den,ch.pdcposttrno,j.doc_no,j.dtype,h1.doc_no,h1.description,h1.den,j.date,d.amount,d.description,0 from " 
	    			 + " my_jvtran j inner join my_chqdet ch on ch.pdcposttrno=j.tr_no  "
	    			 + " left join my_head h on j.acno=h.doc_no left join my_chqbd d on ch.tr_no=d.tr_no and d.sr_no>0 "
	    			 + " left join my_head h1 on d.acno=h1.doc_no where j.status=3 and ch.pdcposttrno!=0 and h. den in (305,604)"; */ 
	    	 
	    	 
	    	/*  select h.doc_no,h.description,h.den,ch.pdcposttrno,m.doc_no,m.dtype,h1.doc_no,h1.description,h1.den,ch.chqdt,d.amount,d.description,0 from"
	    	 + " my_chqbm m inner join my_chqdet ch on ch.tr_no=m.tr_no left join my_chqbd d1 on m.tr_no=d1.tr_no and d1.sr_no=0"
	    	 + " left join my_head h on d1.acno=h.doc_no left join my_chqbd d on m.tr_no=d.tr_no and d.sr_no>0 left join my_head h1 on d.acno=h1.doc_no where m.status=3 and ch.pdcposttrno!=0";
	    	 ; */
	    	 
	    	 sql2="insert into my_cashtran(mainacno, mainname, mainden, trno, doc_no, dtype, tranacno, tranname, tranden, date, amount, desc1,bank)"
	    	    	 + " select a.acno, a.description, a.den, a.tr_no,a.doc_no, a.dtype, b.acno , b.description , b.den , b.date , b.dramount, b.dec1, b.bank from"
	    	    	 + " (select j.acno,h.description,h.den,j.tr_no,j.doc_no,j.dtype,j.tranid from my_jvtran j left join my_head h on j.acno=h.doc_no"
	    	    	 + " left join my_chqdet ch on ch.pdcposttrno=j.tr_no where j.status=3 and h. den in (305,604) and ch.tr_no is null "+strjvdatecondition+" group by j.tr_no,j.acno ) a"
	    	    	 + " left join (select j.dramount,j.acno,h.description,j.description dec1,h.den,j.date,j.tr_no,j.tranid,if(h.den in (305,604),1,0) bank"
	    	    	 + " from my_jvtran j left join my_head h on j.acno=h.doc_no where j.status=3 "+strjvdatecondition+" group by j.tr_no,j.acno ) b on a.tr_no=b.tr_no where  b.tr_no is not null and a.acno!=b.acno  group by A.TRANID,b.tranid"
	    	    	 + " union all  select h.doc_no,h.description,h.den,ch.pdcposttrno,j.doc_no,j.dtype,h1.doc_no,h1.description,h1.den,j.date,d.amount,d.description,0 from " 
   	    			 + " my_jvtran j inner join my_chqdet ch on ch.pdcposttrno=j.tr_no  "
   	    			 + " left join my_head h on j.acno=h.doc_no left join my_chqbd d on ch.tr_no=d.tr_no and d.sr_no>0 "
   	    			 + " left join my_head h1 on d.acno=h1.doc_no where j.status=3 and ch.pdcposttrno!=0 and h. den in (305,604) "+strjvdatecondition; 
   	    	 
	    	 
	    	 System.out.println("sql2------>>"+sql2);
	    	 val+= stmt.executeUpdate(sql2);
	    	System.out.println("Finished First Query");
	    	 sql3= "insert into my_cashtran(mainacno, mainname, mainden, trno, doc_no, dtype, tranacno, tranname, tranden, date, amount, desc1,bank,pdc)"
	          + " select h.doc_no,h.description,h.den,ch.pdcposttrno,m.doc_no,m.dtype,h1.doc_no,h1.description,h1.den,ch.chqdt,d.amount,d.description,0,1"
	    	  + " from my_chqbm m inner join my_chqdet ch on ch.tr_no=m.tr_no left join my_chqbd d1 on m.tr_no=d1.tr_no and d1.sr_no=0"
	    	  + " left join my_head h on d1.acno=h.doc_no left join my_chqbd d on m.tr_no=d.tr_no and d.sr_no>0 left join my_head h1 on d.acno=h1.doc_no where m.status=3 and ch.status='E' and ch.pdc=1"+strmasterdatecondition; 
	    	System.out.println("sql3------>>"+sql3);
	    	val+= stmt.executeUpdate(sql3);
	     sql4="insert into my_cashtran(mainacno, mainname, mainden, trno, doc_no, dtype, tranacno, tranname, tranden, date, amount, desc1,bank,pdc)"
	    		 + " select h.doc_no,h.description,h.den,m.doc_no,m.doc_no,m.dtype,h1.doc_no,h1.description,h1.den,m.chqdt,d.amount,d.description,0,1 from"
	    		 + " my_unclrchqbm m left join my_unclrchqbd d on m.doc_no=d.rdocno and d.sr_no=0"
	    		 + " left join my_head h on d.acno=h.doc_no"
	    		 + " left join my_unclrchqbd d1 on  m.doc_no=d1.rdocno and d1.sr_no>0"
	    		 + " left join my_head h1 on d1.acno=h1.doc_no where status=3"+strmasterdatecondition;
	    System.out.println("sql4------>>"+sql4);
	    val+= stmt.executeUpdate(sql4);
	     sql5="insert into my_cashtran(mainacno, mainname, mainden, trno, doc_no, dtype, tranacno, tranname, tranden, date, amount, desc1,bank,pdc)"
	    		 + " select h.doc_no,h.description,h.den,m.doc_no,m.doc_no,m.dtype,h1.doc_no,h1.description,h1.den,m.chqdt,d.amount,d.description,0,1 from"
	    		 + " my_unclrchqreceiptm m left join my_unclrchqreceiptD d on m.doc_no=d.rdocno and d.sr_no=0"
	    		 + " left join my_head h on d.acno=h.doc_no left join my_unclrchqreceiptD d1 on  m.doc_no=d1.rdocno and d1.sr_no>0"
	    		 + " left join my_head h1 on d1.acno=h1.doc_no where status=3"+strmasterdatecondition;
	     System.out.println("sql5------>>"+sql5);  	
	     val+= stmt.executeUpdate(sql5);
	     sql6="insert into my_cashtran(mainacno, mainname, mainden, trno, doc_no, dtype, tranacno, tranname, tranden, date, amount, desc1,bank)"
	    		 + " select j.acno,h.description,h.den,j.tr_no,j.doc_no,j.dtype,0,'',0,j.date,j.dramount*-1,j.description,0 from my_jvtran j left join my_head h on j.acno=h.doc_no"
	    		 + " where j.status=3 and h. den in (305,604) and j.dtype='opn'"+strjvdatecondition;
	     System.out.println("sql6------>>"+sql6);  	
	     val+= stmt.executeUpdate(sql6);
	       
	    
			// for correcting contra entry 
/* 			sql7="update MY_jvma j left join my_cashtran j1 on j.tr_no=j1.trno left join my_head h on j1.mainacno=h.doc_no set j1.bank=1 WHERE j.refid=8 and j1.tranacno IN (SELECT ACNO FROM MY_ACCOUNT WHERE CODENO='COMMISSION ACCOUNT')  and h.den=305"; */
			sql7="update MY_jvma j left join my_cashtran j1 on j.tr_no=j1.trno left join my_head h on j1.mainacno=h.doc_no set j1.bank=1 WHERE j.refid=8 and j1.tranacno IN (SELECT ACNO FROM MY_ACCOUNT WHERE CODENO='COMMISSION ACCOUNT')  and j1.mainacno in (select acno from my_cardm where mode='card') "+strjvdatecondition;
		     //System.out.println("sql7------>>"+sql7);  	
		     val+= stmt.executeUpdate(sql7);

			/* sql8="update MY_jvma j left join my_cashtran j1 on j.tr_no=j1.trno left join my_head h on j1.mainacno=h.doc_no set j1.bank=1 WHERE j.refid=8 and j1.tranacno  IN (SELECT ACNO FROM GL_TAXMASTER WHERE status=3 and type=1 and per>0) and h.den=305"; */
			sql8="update MY_jvma j left join my_cashtran j1 on j.tr_no=j1.trno left join my_head h on j1.mainacno=h.doc_no set j1.bank=1 WHERE j.refid=8 and j1.tranacno  IN (SELECT ACNO FROM GL_TAXMASTER WHERE status=3 and type=1 and per>0) and j1.mainacno in (select acno from my_cardm where mode='card') "+strjvdatecondition;
	     	//System.out.println("sql8------>>"+sql8);  	
	      	val+= stmt.executeUpdate(sql8);
		
		/* 	sql9="update MY_jvma j left join my_cashtran j1 on j.tr_no=j1.trno left join my_head h on j1.mainacno=h.doc_no set j1.bank=1 WHERE j.refid=8 and j1.tranacno IN (SELECT ACNO FROM MY_ACCOUNT WHERE CODENO='COMMISSION ACCOUNT')  and h.den=305";
		    //System.out.println("sql7------>>"+sql7);  	
		    val+= stmt.executeUpdate(sql9);

			sql10="update MY_jvma j left join my_cashtran j1 on j.tr_no=j1.trno left join my_head h on j1.mainacno=h.doc_no set j1.bank=1 WHERE j.refid=8 and j1.tranacno  IN (SELECT ACNO FROM GL_TAXMASTER WHERE status=3 and type=1 and per>0) and h.den=305";
		    //System.out.println("sql8------>>"+sql8);  	
		    val+= stmt.executeUpdate(sql10);
 */
		    CallableStatement stmtcalflow = conn.prepareCall("{CALL CASHFLOWCHK()}");
		    stmtcalflow.executeQuery();
		    
		     System.out.println("val--->>"+val);
		     if(val>0){    
				//conn.commit();
				}
		     response.getWriter().print(val);
		  
		 	 stmt.close();
		 	 conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
  
