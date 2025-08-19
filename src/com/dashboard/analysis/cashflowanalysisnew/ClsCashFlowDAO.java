package com.dashboard.analysis.cashflowanalysisnew;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCashFlowDAO  { 
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();    
	
	public JSONArray cashflowGridLoading(String fromdate,String todate, String cmbfrequency,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();  
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		 try {  
			 conn = ClsConnection.getMyConnection(); 
			 Statement stmtCashFlowAnalysis = conn.createStatement();
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        java.sql.Date analysisDate=null;
			     java.sql.Date analysisFromDate=null;
			     java.sql.Date analysisToDate=null;
			     String analysingDate="",analysingToDate="";
			     int amountLength=0,txtfrequency=0;
			 if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
             }
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			 }
				 String xsqls="",xsql="";  
				 String sql7="",sql8="",sql9="",sql10="",sql3="";
			     String monthDiff=""; 
			     String per="";
			     ArrayList<String> analysiscolumnarray= new ArrayList<String>();
			     
			     if(cmbfrequency.equalsIgnoreCase("1")){
			    	 
			    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			    	    ResultSet rs1 = stmtCashFlowAnalysis.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("monthdiff");
						} 
						xsqls=1 + (cmbfrequency.equalsIgnoreCase("1")?" Month ":" Year ");
			     }
			     if(txtfrequency>=5){
			    	per="10%"; 
			     }else{
			    	 per="";   
			     }
			       
			     analysiscolumnarray.add("Id::id::center::center::true:: :: :: ");
			     analysiscolumnarray.add("Parent Id::parentid::center::center::true:: :: :: ");
			     analysiscolumnarray.add("Description::description::left::left:: ::30% :: ::headClass");
				 analysiscolumnarray.add("Total::total::right::right:: ::"+per+" ::d2::violetClass");
			    
			     
			     if(cmbfrequency.equalsIgnoreCase("1")){
				     	
				     	analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   if(i==0){
							   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
							   ResultSet rs = stmtCashFlowAnalysis.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
								     sql3+="0 amount"+i+",";
								     sql7+="coalesce(amount"+i+",0) amount"+i+",";
								     sql8+="sum(if(date>='"+sqlFromDate+"' and date<='"+analysisDate+"',coalesce(round(amount,2),0),0))*-1 amount"+i+",";
								     sql9+="sum(if(date>='"+sqlFromDate+"' and date<='"+analysisDate+"',coalesce(round(amount,2),0),0)) amount"+i+",";
								     sql10+="sum(if(date>='"+sqlFromDate+"' and date<='"+analysisDate+"',IF(dtype in ('OPP','BPV','CPV','UCP'),coalesce(round(amount,2),0)*-1,coalesce(round(amount,2),0)),0))	amount"+i+",";		
								     amountLength=amountLength+1;
								     
								     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::10%::d2::yellowClass");
							     }  
							}else{      
								   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
								   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
								   
								   ResultSet rs = stmtCashFlowAnalysis.executeQuery(xsql);
								   
								   while(rs.next()){
									     analysisFromDate=rs.getDate("analysisFromDate");
									     analysisToDate=rs.getDate("analysisToDate");
									     analysingDate=rs.getString("analysisDates");
									     analysingToDate=rs.getString("analysingDate");
				
									     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
									    	   analysisToDate=sqlToDate;
									    	   analysingDate=analysingToDate;
									      } 
									         sql3+="0 amount"+i+",";  
									         sql7+="coalesce(amount"+i+",0) amount"+i+",";
									         sql8+="sum(if(date>='"+analysisFromDate+"' and date<='"+analysisToDate+"',coalesce(round(amount,2),0),0))*-1 amount"+i+",";
									         sql9+="sum(if(date>='"+analysisFromDate+"' and date<='"+analysisToDate+"',coalesce(round(amount,2),0),0)) amount"+i+",";  
									         sql10+="sum(if(date>='"+analysisFromDate+"' and date<='"+analysisToDate+"',IF(dtype in ('OPP','BPV','CPV','UCP'),coalesce(round(amount,2),0)*-1,coalesce(round(amount,2),0)),0))	amount"+i+",";		
									         amountLength=amountLength+1;
										     
										     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::10%::d2::yellowClass");
									     
									         analysisDate=analysisToDate;
								     }
							   }
						   
						     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	 break;
						     }
						}
						
				     }
			     if(check.equalsIgnoreCase("1")){
			     
				 String sql="select seq,c.type,a.head,h1.description mainacname,h.description acname,c.mainden,c.mainacno,"+sql7+"sum(c.amt) amt from"
						 +" (select 1 seq,'OPENING' type,mainden,mainacno,"+sql8+"sum(amount)*-1 amt from my_cashtran c"    
						 +" where c.date<'"+sqlFromDate+"' and pdc=0 group by mainacno union all select 2 seq,'INFLOW' type,tranden,tranacno,"+sql8+"sum(amount)*-1 amt from my_cashtran c"
						 +" where date>='"+sqlFromDate+"' and date<='"+sqlToDate+"' and amount<0 and bank=0  and pdc=0  group by tranacno union all select 5 seq,'INFLOW PDC' type,"
						 +" tranden,tranacno,"+sql3+"(amount) amt from my_cashtran where pdc=1  and date<='"+sqlToDate+"' and dtype in ('OPR','BRV','CRV','UCR')"
						 +" union all select 3 seq,'OUTFLOW' type,tranden,tranacno,"+sql9+"sum(amount) amt from my_cashtran c left join my_agrp a on c.tranden=a.fi_id"
						 +" where date>='"+sqlFromDate+"' and date<='"+sqlToDate+"' and amount>0  and bank=0  and pdc=0 group by tranacno"
						 +" union all select 6 seq,'OUTFLOW PDC' type,tranden,tranacno,"+sql3+"(amount) amt from my_cashtran where pdc=1 and date<='"+sqlToDate+"' and dtype in ('OPP','BPV','CPV','UCP')"
						 +" union all select 4 seq,'NET FLOW' type,mainden,mainacno,"+sql8+"sum(amount)*-1 amt from my_cashtran c left join my_agrp a on c.mainden=a.fi_id"
						 +" where date>='"+sqlFromDate+"' and date<='"+sqlToDate+"' and bank=0 union all select 8 seq,'CLOSING' type,mainden,mainacno,"+sql3+"sum(amount)*-1 amt from my_cashtran c left join my_agrp a on c.mainden=a.fi_id"
						 +" where date<='"+sqlToDate+"' AND PDC=0  group by mainacno UNION ALL select 7 seq,'NET PDC' type,tranden,tranacno,"+sql3+"SUM(IF(dtype in ('OPP','BPV','CPV','UCP'),amount*-1,AMOUNT)) amt from my_cashtran where pdc=1 and  date<='"+sqlToDate+"'  and bank=0  ) c"
						 +" left join my_head h on c.mainacno=h.doc_no left join my_head h1 on h.grpno=h1.doc_no left join my_agrp a on c.mainden=a.fi_id where c.amt is not null group by seq,c.mainden,c.mainacno";  	 
				        
System.out.println("sql--------->>>"+sql);                     
			ResultSet rs = stmtCashFlowAnalysis.executeQuery(sql);
			ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
			String mainacno="",head="",mainacname="",acname="",amt="",type="";  
			String mainacnosrno="",headsrno="",typesrno="",acnamesrno="";
			String mainacnoparent="",headparent="",typeparent="",acnameparent="";
			int i=0,parent=0,typeid=0,mainacnoid=0,headid=0;  
			double mainacamt=0,headamt=0,typeamt=0,accountamt=0,acamt=0;
			double mainacamount[]=new double[amountLength];   
			double headamount[]=new double[amountLength];
			double typeamount[]=new double[amountLength];
			double accountamount[]=new double[amountLength];
			ArrayList<String> temp1=new ArrayList<String>();	
			ArrayList<String> temp2=new ArrayList<String>();
	    	ArrayList<String> temp3=new ArrayList<String>();      
	    	ArrayList<String> temp4=new ArrayList<String>();         
	    	ArrayList<ArrayList<String>> headarray= new ArrayList<ArrayList<String>>();
	    	ArrayList<ArrayList<String>>  mainarray= new ArrayList<ArrayList<String>>();
	    	ArrayList<ArrayList<String>> accountarray= new ArrayList<ArrayList<String>>();
	    	   
	    	 while(rs.next()){ 
			    	
			    	if(!type.equalsIgnoreCase(rs.getString("type"))){  
	    				if(!headarray.isEmpty()){
	    				temp1.add(typesrno);
	    				temp1.add(typeparent);
	    				temp1.add(type);
	    				temp1.add(typeamt+"");    
	    				 for (int l = 0; l < amountLength; l++) {
	  				    	temp1.add(typeamount[l]+"");  
	  				    }
	    				analysisrowarray.add(temp1);
	    				analysisrowarray.addAll(headarray);
	    				headarray=new ArrayList<>();
	    				temp1=new ArrayList<>();
	    				}
	    				typesrno=++i+"";
	    				typeparent=0+"";
	    				type=rs.getString("type");
	    			    	 parent=i;
	    				    typeid=i;
	    				    typeamt=0;
	    				    for (int l = 0; l < amountLength; l++) {
	        					typeamount[l]=0;         	
	        			    }
	    				    if(rs.getString("type").equalsIgnoreCase("NET FLOW") || rs.getString("type").equalsIgnoreCase("NET PDC")){
	    				    	temp1.add(typesrno);
	    	    				temp1.add(typeparent);
	    	    				temp1.add(type);
	    	    				temp1.add(rs.getString("amt")+"");
	    	    				for (int l = 0; l < amountLength; l++) {   
	    					    	temp1.add(rs.getString("amount"+l+"").equalsIgnoreCase("") || rs.getString("amount"+l+"")==null?"0":rs.getString("amount"+l+""));
	    					    }
	    	    				analysisrowarray.add(temp1);  
	    	    				temp1=new ArrayList<>();     
	    				    	continue;
	    				    } 
	    			}else{       
	    				parent=typeid;  
	    				} 
			    	   
	    			if(!head.equalsIgnoreCase(rs.getString("HEAD"))){
	   	    				if(!accountarray.isEmpty()){
	    					temp3.add(mainacnosrno+"");
	        				temp3.add(mainacnoparent+"");
	        				temp3.add(mainacno+"");
	        				temp3.add(mainacamt+"");  
	        				 for (int l = 0; l < amountLength; l++) {
	      				    	temp3.add(mainacamount[l]+"");   
	      				    }
	        				mainarray.add(temp3);
	        				mainarray.addAll(accountarray);
	        				accountarray=new ArrayList<>();
	        				temp3=new ArrayList<>();
	    				}
	    				if(!mainarray.isEmpty()){  
					    	temp2.add(headsrno+"");
		    				temp2.add(headparent+"");
		    				temp2.add(head+"");
		    				temp2.add(headamt+"");
		    				for (int l = 0; l < amountLength; l++) {
		 				    	temp2.add(headamount[l]+"");   
		 				    }
		    				headarray.add(temp2);
		    				headarray.addAll(mainarray); 
		    				mainarray=new ArrayList<>();
		    				temp2=new ArrayList<>();
					    }
	    				
	    				i=i+1;
					    headsrno=i+"";
	    				headparent=parent+"";
	    				head=rs.getString("head");
				    	typeamt=typeamt+ rs.getDouble("amt");
				    	for (int l = 0; l < amountLength; l++) {
	    					typeamount[l]=typeamount[l]+rs.getDouble("amount"+l+"");       	
	    			    }
				    	parent=i;headid=i;
				    	headamt=0; 
				    	for (int l = 0; l < amountLength; l++) {
							headamount[l]=0;	
					    }
	    			}else{  
	    				typeamt=typeamt+rs.getDouble("amt");
	    				for (int l = 0; l < amountLength; l++) {
	    					typeamount[l]=typeamount[l]+rs.getDouble("amount"+l+"");       	
	    			    }
	    				parent=headid;
	    				}

	    		if(!mainacname.equalsIgnoreCase(rs.getString("mainacname"))){

					if(!accountarray.isEmpty()){
						temp3.add(mainacnosrno+"");
	    				temp3.add(mainacnoparent+"");  
	    				temp3.add(mainacno+"");
	    				temp3.add(mainacamt+"");
	    				 for (int l = 0; l < amountLength; l++) {
	 				    	temp3.add(mainacamount[l]+"");   
	 				    }
	    				mainarray.add(temp3);
	    				mainarray.addAll(accountarray);
	    				accountarray=new ArrayList<>();
	    				temp3=new ArrayList<>();
					}
				    i=i+1;
				    mainacnosrno=i+"";
				    mainacnoparent=parent+"";
				    mainacno=rs.getString("mainacname");
				    headamt=headamt+rs.getDouble("amt");                
				    for (int l = 0; l < amountLength; l++){
						headamount[l]=rs.getDouble("amount"+l+"");   	
				    }
				    parent=i;
				    mainacnoid=i;
				    mainacamt=0;
				    for (int l = 0; l < amountLength; l++) {  
				    	mainacamount[l]=0;	
				    }
				}else{
					headamt=headamt+rs.getDouble("amt");
					for (int l = 0; l < amountLength; l++) {
						headamount[l]=headamount[l]+rs.getDouble("amount"+l+"");	
				    }
					parent=mainacnoid;     
					}
	    			
	    		if(!acname.equalsIgnoreCase(rs.getString("acname"))){

				    i=i+1;  
				    mainacamt=mainacamt+rs.getDouble("amt");
				    for (int l = 0; l < amountLength; l++) {
				    	mainacamount[l]=mainacamount[l]+rs.getDouble("amount"+l+"");	
				    }        
				    temp4.add(i+"");  
				    temp4.add(parent+"");
				    temp4.add(rs.getString("acname"));
				    temp4.add(rs.getString("amt"));
				    for (int l = 0; l < amountLength; l++) {
				    	temp4.add(rs.getString("amount"+l+"").equalsIgnoreCase("") || rs.getString("amount"+l+"")==null?"0":rs.getString("amount"+l+""));
				    }  
					accountarray.add(temp4);
				    temp4=new ArrayList<>();
    			}
				    
				    type=rs.getString("type");
			    	head=rs.getString("head");
			    	mainacname=rs.getString("mainacname");
			    	acname=rs.getString("acname");
				}
	    	    acnamesrno=i+1+"";
				acnameparent=parent+"";
				
			    mainacamt=mainacamt+accountamt;
			    for (int l = 0; l < amountLength; l++) {
			    	mainacamount[l]=mainacamount[l]+accountamount[l];	
			    }        
			    temp4.add(acnamesrno+"");    
			    temp4.add(acnameparent+"");
			    temp4.add(acname);
			    temp4.add(accountamt+"");
			    for (int l = 0; l < amountLength; l++) {
			    	temp4.add(accountamount[l]+"");
			    }  
				
			    
				accountarray.add(temp4);
			    
				temp3.add(mainacnosrno+"");
				temp3.add(mainacnoparent+"");  
				temp3.add(mainacno+"");
				temp3.add(mainacamt+"");
				 for (int l = 0; l < amountLength; l++) {
				    	temp3.add(mainacamount[l]+"");   
				    }
				mainarray.add(temp3);
			    mainarray.addAll(accountarray);
			    
			    temp2.add(headsrno+"");  
				temp2.add(headparent+"");
				temp2.add(head+"");
				temp2.add(headamt+"");
				for (int l = 0; l < amountLength; l++) {
				    	temp2.add(headamount[l]+"");   
				    }
			    headarray.add(temp2);
				headarray.addAll(mainarray); 
			    
				temp1.add(typesrno);
				temp1.add(typeparent);
				temp1.add(type);
				temp1.add(typeamt+"");    
				 for (int l = 0; l < amountLength; l++) {
				    	temp1.add(typeamount[l]+"");  
				    }
				analysisrowarray.add(temp1);
				analysisrowarray.addAll(headarray);
				analysisrowarray.remove(analysisrowarray.size()-1);

			//System.out.println("sql--------->>>"+sql);  
			//System.out.println("analysisrowarray=="+analysisrowarray);
		     COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
			 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
			 JSONArray analysisarray=new JSONArray();
			 //System.out.println("COLUMNDATA=="+COLUMNDATA);  
			 analysisarray.addAll(COLUMNDATA);
			 analysisarray.addAll(ROWDATA);      
			 RESULTDATA=analysisarray;
			 }
			 stmtCashFlowAnalysis.close();  
			 conn.close();     

			} catch(Exception e){  
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
       }
	  
	public JSONArray cashflowExcelExport(String fromdate,String todate, String cmbfrequency) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCashFlowAnalysis = conn.createStatement();
				String sql1="",sql2="";
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        java.sql.Date analysisDate=null;
			     java.sql.Date analysisFromDate=null;
			     java.sql.Date analysisToDate=null;
			     String analysingDate="",analysingToDate="";
			     int amountLength=0,txtfrequency=0;
			 if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
             }
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			 }
				String xsqls="",xsql="";
				 String sql7="",sql8="",sql9="",sql10="",sql3="";
			     String monthDiff="";  
			     if(cmbfrequency.equalsIgnoreCase("1")){
			    	 
			    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			    	    ResultSet rs1 = stmtCashFlowAnalysis.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("monthdiff");
						} 
						xsqls=1 + (cmbfrequency.equalsIgnoreCase("1")?" Month ":" Year ");
			     }
			     if(cmbfrequency.equalsIgnoreCase("1")){
				     	
				     	analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   if(i==0){
							   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
							   ResultSet rs = stmtCashFlowAnalysis.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
								     sql3+="0 amount"+i+",";
								     sql7+="coalesce(amount"+i+",0) amount"+i+",";
								     sql8+="sum(if(date>='"+sqlFromDate+"' and date<='"+analysisDate+"',coalesce(round(amount,2),0),0))*-1 amount"+i+",";
								     sql9+="sum(if(date>='"+sqlFromDate+"' and date<='"+analysisDate+"',coalesce(round(amount,2),0),0)) amount"+i+",";
								     sql10+="sum(if(date>='"+sqlFromDate+"' and date<='"+analysisDate+"',IF(dtype in ('OPP','BPV','CPV','UCP'),coalesce(round(amount,2),0)*-1,coalesce(round(amount,2),0)),0))	amount"+i+",";		
								     amountLength=amountLength+1;
							     }   
							}else{
								   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
								   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
								   
								   ResultSet rs = stmtCashFlowAnalysis.executeQuery(xsql);
								   
								   while(rs.next()){
									     analysisFromDate=rs.getDate("analysisFromDate");
									     analysisToDate=rs.getDate("analysisToDate");
									     analysingDate=rs.getString("analysisDates");
									     analysingToDate=rs.getString("analysingDate");
				
									     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
									    	   analysisToDate=sqlToDate;
									    	   analysingDate=analysingToDate;
									      }  
									         sql3+="0 amount"+i+",";
									         sql7+="coalesce(amount"+i+",0) amount"+i+",";
									         sql8+="sum(if(date>='"+analysisFromDate+"' and date<='"+analysisToDate+"',coalesce(round(amount,2),0),0))*-1 amount"+i+",";
									         sql9+="sum(if(date>='"+analysisFromDate+"' and date<='"+analysisToDate+"',coalesce(round(amount,2),0),0)) amount"+i+",";  
									         sql10+="sum(if(date>='"+analysisFromDate+"' and date<='"+analysisToDate+"',IF(dtype in ('OPP','BPV','CPV','UCP'),coalesce(round(amount,2),0)*-1,coalesce(round(amount,2),0)),0))	amount"+i+",";		
									         amountLength=amountLength+1;
									     
									         analysisDate=analysisToDate;
								     }
							   }
						   
						     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	 break;
						     }
						}
						
				     } 
			     
				 String sql="select c.type 'Type',a.head 'Head',h1.description 'Main Account Name',h.description 'Account Name',"+sql7+"c.amt 'Amount' from"
								 +" (select 1 seq,'OPENING' type,mainden,mainacno,"+sql8+"sum(amount)*-1 amt from my_cashtran c"    
								 +" where c.date<'"+sqlFromDate+"' and pdc=0 group by mainacno union all select 2 seq,'INFLOW' type,tranden,tranacno,"+sql8+"sum(amount)*-1 amt from my_cashtran c"
								 +" where date>='"+sqlFromDate+"' and date<='"+sqlToDate+"' and amount<0 and bank=0 group by tranacno union all select 5 seq,'INFLOW PDC' type,"
								 +" tranden,tranacno,"+sql3+"(amount) amt from my_cashtran where pdc=1  and date<='"+sqlToDate+"' and dtype in ('OPR','BRV','CRV','UCR')"
								 +" union all select 3 seq,'OUTFLOW' type,tranden,tranacno,"+sql9+"sum(amount) amt from my_cashtran c left join my_agrp a on c.tranden=a.fi_id"
								 +" where date>='"+sqlFromDate+"' and date<='"+sqlToDate+"' and amount>0  and bank=0 group by tranacno"
								 +" union all select 6 seq,'OUTFLOW PDC' type,tranden,tranacno,"+sql3+"(amount) amt from my_cashtran where pdc=1 and date<='"+sqlToDate+"' and dtype in ('OPP','BPV','CPV','UCP')"
								 +" union all select 4 seq,'NET FLOW' type,mainden,mainacno,"+sql8+"sum(amount)*-1 amt from my_cashtran c left join my_agrp a on c.mainden=a.fi_id"
								 +" where date>='"+sqlFromDate+"' and date<='"+sqlToDate+"' and bank=0 union all select 8 seq,'CLOSING' type,mainden,mainacno,"+sql3+"sum(amount)*-1 amt from my_cashtran c left join my_agrp a on c.mainden=a.fi_id"
								 +" where date<='"+sqlToDate+"' AND PDC=0 group by mainacno UNION ALL select 7 seq,'NET PDC' type,tranden,tranacno,"+sql3+"SUM(IF(dtype in ('OPP','BPV','CPV','UCP'),amount*-1,AMOUNT)) amt from my_cashtran where pdc=1 and  date<='"+sqlToDate+"'  and bank=0  ) c"
								 +" left join my_head h on c.mainacno=h.doc_no left join my_head h1 on h.grpno=h1.doc_no left join my_agrp a on c.mainden=a.fi_id where c.amt is not null order by seq,c.mainden,c.mainacno";	 
						          
		  		//System.out.println("Excelsql--------->>>"+sql);      
				ResultSet resultSet = stmtCashFlowAnalysis.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				    
				stmtCashFlowAnalysis.close();  
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();  
		}
        return RESULTDATA;
    }
	
	
	public  JSONArray convertColumnAnalysisArrayToJSON(ArrayList<String> columnsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		for (int i = 0; i < columnsAnalysisList.size(); i++) {
			JSONObject obj = new JSONObject();
			  
			String[] analysisColumnArray=columnsAnalysisList.get(i).split("::");
			
			obj.put("text",analysisColumnArray[0]);
			obj.put("datafield",analysisColumnArray[1]);
			obj.put("cellsAlign",analysisColumnArray[2]);
			obj.put("align",analysisColumnArray[3]);
			if(!(analysisColumnArray[4].trim().equalsIgnoreCase(""))){
				obj.put("hidden",analysisColumnArray[4]);
		    }
			if(!(analysisColumnArray[5].trim().equalsIgnoreCase(""))){
				obj.put("width",analysisColumnArray[5]);
		    }
			if(!(analysisColumnArray[6].trim().equalsIgnoreCase(""))){
			    obj.put("cellsFormat",analysisColumnArray[6]);
			}
			if(!(analysisColumnArray[7].trim().equalsIgnoreCase(""))){
			    obj.put("cellclassname",analysisColumnArray[7]);
			}  
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columns",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
	public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			  
			JSONObject obj = new JSONObject();
			
			ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);       
			
			int length = analysisRowArray.size();
			
			obj.put("id",analysisRowArray.get(0));  
			obj.put("parentid",analysisRowArray.get(1));
			obj.put("description",analysisRowArray.get(2));
			obj.put("total",analysisRowArray.get(3));
			for (int j = 4,k=0; j < length; j++,k++) {
				if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put("amount"+k,analysisRowArray.get(j));   
				}
			}
			
			jsonArray.add(obj);    
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
}
