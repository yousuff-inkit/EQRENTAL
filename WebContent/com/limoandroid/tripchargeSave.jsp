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
String msg="";
int vals=0,extrahr=0;
double minkm=0,ridechrg=0,extrakmrate=0,totalkm=0,mincharge=0,excesshrsrate=0;	
double nightminkmcharge=0.0,nightmincharge=0.0,nightextrakmrate=0.0 ,nightexcesshrsrate=0.0;
String value="";
int totkm=0,tothrs=0,errorstaus=0,jvtrno=0;
double vat=0.0,taxamount=0.0,extrahrcharges=0.0,total=0.0;

	try{

		ClsConnection  ClsConnection =new ClsConnection();
		ClsCommon   ClsCommon =new ClsCommon();
		String curarr=request.getParameter("curarr")==null?"":request.getParameter("curarr");
		String rdocno=request.getParameter("cinvdocno");
		String jobno=request.getParameter("jobno");
		String userid=request.getParameter("userid");
		String mastertotal=request.getParameter("mastertotal");
		String jvtran1sql=null,jvtran2sql=null,jvtran3sql=null;
		
		ArrayList<String> tarifarray=new ArrayList<String>();
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		ClsCommon comm = new ClsCommon();
		
		System.out.println("00000=="+curarr);
		
		CallableStatement stmtUpdaterent = null;
		Statement stmt=conn.createStatement();
			
		if(!curarr.equalsIgnoreCase("")){
			String temp[]=curarr.split(",");
			for(int i=0;i<temp.length;i++){
				tarifarray.add(temp[i]);
			}	
		}
		String sqls14="select max(trno) trno from my_trno where trtype='CINV'";
		ResultSet rss2=stmt.executeQuery(sqls14);
		while(rss2.next()){
			jvtrno=rss2.getInt("trno");
		}
		String desc="";
		int acno=0,lrate=0,lcurid=0,count=0;
		
		 String sqlinvmod="select description,acno from my_account where description='LIMO INCOME'";
		  ResultSet rsinv_acno=stmt.executeQuery(sqlinvmod);
			 if(rsinv_acno.next())
			 {
				
				 desc=rsinv_acno.getString("description");
				 acno=rsinv_acno.getInt("acno");
				 
			 }
			
			 double nettotal=0.0;
		for(int i=0;i<tarifarray.size();i++){
			//System.out.println(tarifarray.get(i));
			String tariff[]=tarifarray.get(i).split("::");
			double rates=Double.parseDouble((tariff[0].equalsIgnoreCase("undefined") || tariff[0].equalsIgnoreCase("") || tariff[0].trim().equalsIgnoreCase("NaN")|| tariff[0].isEmpty()?"0":tariff[0].trim()));
			double curid=Double.parseDouble((tariff[1].equalsIgnoreCase("undefined") || tariff[1].equalsIgnoreCase("") || tariff[1].trim().equalsIgnoreCase("NaN")|| tariff[1].isEmpty()?"0":tariff[1].trim()));
			double amt=Double.parseDouble((tariff[2].equalsIgnoreCase("undefined") || tariff[2].equalsIgnoreCase("") || tariff[2].trim().equalsIgnoreCase("NaN")|| tariff[2].isEmpty()?"0":tariff[2].trim()));
			double tot=Double.parseDouble((tariff[3].equalsIgnoreCase("undefined") || tariff[3].equalsIgnoreCase("") || tariff[3].trim().equalsIgnoreCase("NaN")|| tariff[3].isEmpty()?"0":tariff[3].trim()));
			double cacno=Double.parseDouble((tariff[4].equalsIgnoreCase("undefined") || tariff[4].equalsIgnoreCase("") || tariff[4].trim().equalsIgnoreCase("NaN")|| tariff[4].isEmpty()?"0":tariff[4].trim()));
			nettotal+=tot;
			String strinserttarif="insert into an_cashinvd(rdocno, rate, curid, amount, total) values"+
			 " ("+rdocno+","+rates+","+curid+","+amt+","+tot+")";
// 			System.out.println(strinserttarif);
			int val=stmt.executeUpdate(strinserttarif);
			System.out.println("val=="+val);
			if(val>0){
				
				msg="1";
				conn.commit();
			}
			 
			/*  lrate=Integer.parseInt(tariff[0]);
			lcurid=Integer.parseInt(tariff[1]);
			double dramount=Double.parseDouble(tariff[2]);
			double ldramount=Double.parseDouble(tariff[3]);  */
			
		 
			
			 
			//cliententry
	   			count++;
			 jvtran2sql="insert into my_jvtran(tr_no, acno, dramount, rate, curId,  trtype, id, ref_row, brhid, description, yrId, date, dTYPE, stkmove, ldramount,doc_no, status) values ('"+jvtrno+"', '"+cacno+"', '"+amt+"',"+rates+", '"+curid+"','4', 1, "+count+", 1, '"+desc+"', 0, curDate(), 'CINV', 0, "+tot+","+rdocno+", 3)";
// 			 System.out.println("jvtran1sql"+jvtran2sql); 
			 stmt.executeUpdate(jvtran2sql); 
			  
			 
				
		}
		int clientacano=0,ccurid=0,crate=0;
		
		String sqls11="select tax.cstper vat,head.doc_no acno,head.curid,head.rate from gl_taxmaster tax left join my_head head on (tax.acno=head.doc_no) where curDate() between tax.fromdate and tax.todate and tax.type=2 and tax.cstper!=0";
		ResultSet res=stmt.executeQuery(sqls11);
		while(res.next()){
				vat=res.getInt("vat");
				clientacano=res.getInt("acno");
				ccurid=res.getInt("curid");
				crate=res.getInt("rate");
				
		}
		
 		double taxamt=nettotal*(vat/100)*-1;
 		System.out.println("taxamt===000==="+taxamt); 
		double taxldramt=taxamt*crate;
		
		int liacno=0,licurid=0,lirate=0;
		
		String sqls12="select codeno,head.doc_no acno,head.curid,head.rate from my_account ac left join my_head head on (ac.acno=head.doc_no) where codeno='LIMO INCOME';";
		ResultSet res1=stmt.executeQuery(sqls12);
		while(res1.next()){
				liacno=res1.getInt("acno");
				licurid=res1.getInt("curid");
				lirate=res1.getInt("rate");
				
		}
		
		double lidramount=(nettotal+taxamt)*-1;
		double lildramount=lirate*lidramount;
		
		
		
		
		
		 //tax entry
		 count++;
		 jvtran3sql="insert into my_jvtran(tr_no, acno, dramount, rate, curId,  trtype, id, ref_row, brhid, description, yrId, date, dTYPE, stkmove, ldramount,doc_no, status) values ('"+jvtrno+"', '"+clientacano+"', '"+taxamt+"',"+crate+", '"+ccurid+"','4', -1, "+count+", 1, '"+desc+"', 0, curDate(), 'CINV', 0, "+taxldramt+","+rdocno+", 3)";
// 		 System.out.println("jvtran2sql"+jvtran3sql); 
		 stmt.executeUpdate(jvtran3sql);	
		
		//jvtran limo insertion
			count++;
			 jvtran1sql="insert into my_jvtran(tr_no, acno, dramount, rate, curId, trtype, id, ref_row, brhid, description, yrId, date, dTYPE, stkmove, ldramount,doc_no, status) values ('"+jvtrno+"', '"+liacno+"', "+lidramount+", "+lirate+", "+licurid+", '4', -1,"+count+" , 1, '"+desc+"', 0, curDate(), 'CINV', 0, "+lildramount+","+rdocno+", 3)";
// 			 System.out.println("jvtran3sql"+jvtran1sql);
			int valss=stmt.executeUpdate(jvtran1sql); 
		 
	if(valss>0){
		String sqls="update an_cashinvm set jvtrno="+jvtrno+" where doc_no="+rdocno+"";
					stmt.executeUpdate(sqls);
	}
		
		
/*ends*****/
				
		 	
		
	}
	catch(Exception e){
		
		conn.close();
	 	e.printStackTrace();
	 	 
	}
	response.getWriter().write(msg);
 	//System.out.println("msg=="+msg);
	
  %>
  
