package com.equipment.equippurchasedirect;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsApplyDelete;
import com.common.ClsCommon;
import com.common.ClsVatInsert;
import com.connection.ClsConnection;



public class ClsEquipPurchaseDirectDAO 
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	ClsApplyDelete ClsApplyDelete=new ClsApplyDelete();

	public  JSONArray fleetSearch(HttpSession session,String fleetno,String flname,String regno,String chk) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
	  	    Enumeration<String> Enumeration = session.getAttributeNames();
	  	    int a=0;
	  	    while(Enumeration.hasMoreElements()){
	  	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	  	      a=1;
	  	     }
	  	    }
	  	    if(a==0){
	  	  return RESULTDATA;
	  	     }
	  	        
	   	    	
	  	  String sqltest="";

          
          if(!(fleetno.equalsIgnoreCase("0")) && !(fleetno.equalsIgnoreCase(""))){
              sqltest=sqltest+" and v.fleet_no like '%"+fleetno+"%'";
          }
          if(!(flname.equalsIgnoreCase("0")) && !(flname.equalsIgnoreCase(""))){
           sqltest=sqltest+" and v.flname like '%"+flname+"%'";
          }
          if(!(regno.equalsIgnoreCase("0")) && !(regno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and v.reg_no like '%"+regno+"%'";
       }
	  	    
	  	    
	       String brid=session.getAttribute("BRANCHID").toString();
	    	

	   	 Connection conn=null;
			try {
				
				
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh8 = conn.createStatement ();
	           	
 if(chk.equalsIgnoreCase("Load"))
 {
					String vehsql="select coalesce(v.prch_cost+v.add1,0) price,v.eng_no,v.ch_no,coalesce(v.prch_cost,0) prch_cost,coalesce(v.add1,0) addcost ,v.reg_no,v.fleet_no,v.FLNAME, "
							+ "c.color,v.clrid,g.gname,v.vgrpid,vb.brand_name,v.brdid,vm.vtype model,v.vmodid  from gl_equipmaster v "
							+ "   left join my_color c  on v.clrid=c.doc_no left join gl_vehgroup g  on g.doc_no=v.vgrpid "
							+ "left join gl_vehbrand vb on vb.doc_no=v.brdid left join gl_vehmodel vm on vm.doc_no=v.vmodid where v.statu=3 and v.brhid="+brid+" "+sqltest+ " group by v.fleet_no";
					
					// removed as sudhir need to do multiple purchases for import and puchstatus=0 
				//System.out.println("---------------"+vehsql);
					ResultSet resultSet = stmtVeh8.executeQuery(vehsql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh8.close();
 }		
				
					conn.close();
					 return RESULTDATA;
			}
			catch(Exception e){
				e.printStackTrace();
			}finally {
				conn.close();
			}
			//System.out.println(RESULTDATA);
	       return RESULTDATA;
	   }
	
	
	
	public  JSONArray gridsearchrelode(String masterdocno) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
		try {
			    conn = ClsConnection.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
				String resql=("select rq.tax_perc taxperc,rq.tax_amt taxamt,rq.net_total nettotal,rq.puch_cost prch_cost,rq.add_cost addicost,rq.brdid,rq.modid,rq.clrid,rq.tot_cost price,rq.chaseno,rq.enginno,rq.fleet_no,"
						+ "  vb.brand_name brand,vm.vtype model,vc.color color from eq_vpurdird rq left join eq_vpurdirm vo on vo.doc_no=rq.rdocno left join gl_vehbrand vb on vb.doc_no=rq.BRDID  "
						+ " left join gl_vehmodel vm on vm.doc_no=rq.MODID "
						+ " left join my_color vc on vc.doc_no=rq.clrid   where rq.rdocno='"+masterdocno+"' ");
				//System.out.println("================="+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}finally {
			conn.close();
		}
	    return RESULTDATA;
	}
	public JSONArray purDetailsLoad(String refdocno, Double taxperc) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
		try {
			    conn = ClsConnection.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
				String resql=("select v.eng_no enginno,v.ch_no chaseno,v.reg_no,v.fleet_no,rq.brdid,rq.modid,vb.brand_name brand,vm.vtype model,vc.color color,rq.clrid,rq.price prch_cost,"
						+ "rq.price price,"+taxperc+" taxperc, (price*("+taxperc+"/100)) taxamt, (price+(price*("+taxperc+"/100)))nettotal from eq_vpom m left join eq_vpod rq on m.doc_no=rq.rdocno left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
						+ "left join gl_vehmodel vm on vm.doc_no=rq.MODID left join my_color vc on vc.doc_no=rq.clrid left join gl_equipmaster v on rq.modid=v.vmodid and v.clrid=rq.clrid and rq.brdid=v.brdid where rq.rdocno='"+refdocno+"'");
				//System.out.println("================="+resql); 
				ResultSet resultSet = stmtrelode.executeQuery(resql);  
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}finally {
			conn.close();
		}
	    return RESULTDATA;
	}
	
    Connection conn=null;
	public int insert(Date sqlStartDate, Date invDate, int headacccode,
			String vehdesc, HttpSession session, String mode,
			String formdetailcode, ArrayList<String> descarray, String invno, 
			HttpServletRequest request,Double taxamt,Double nettotal, String reftype, String refno, String curr, Double rate,String cmbbilltype) throws SQLException {
         
   
        try
        {
        	
        conn=ClsConnection.getMyConnection();
        conn.setAutoCommit(false);
    	CallableStatement stmtvehpurchase= conn.prepareCall("{call eqpurchasedirDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
        
    	stmtvehpurchase.registerOutParameter(10, java.sql.Types.INTEGER);
		stmtvehpurchase.registerOutParameter(11, java.sql.Types.INTEGER);
		stmtvehpurchase.setDate(1,sqlStartDate); 
		stmtvehpurchase.setInt(2,headacccode);     
		stmtvehpurchase.setString(3,vehdesc);
		stmtvehpurchase.setString(4,session.getAttribute("USERID").toString());
		stmtvehpurchase.setString(5,session.getAttribute("BRANCHID").toString());
		stmtvehpurchase.setString(6,formdetailcode);
		stmtvehpurchase.setDate(7,invDate);
		stmtvehpurchase.setString(8,invno);
		stmtvehpurchase.setString(9,mode);
		stmtvehpurchase.setDouble(12,taxamt);
		stmtvehpurchase.setDouble(13,nettotal); 
		stmtvehpurchase.setString(14,reftype);
		stmtvehpurchase.setString(15,refno.trim().equalsIgnoreCase("") || refno==null?"0":refno);
		stmtvehpurchase.setString(16,curr);
		stmtvehpurchase.setDouble(17,rate);   
		stmtvehpurchase.setString(18,cmbbilltype);      

	//	System.out.println("------stmtvehpurchase------"+stmtvehpurchase);
		
		stmtvehpurchase.executeQuery();
		int docno=stmtvehpurchase.getInt("docNo");
		int vocno=stmtvehpurchase.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
		if(docno<=0)
		{
			conn.close();
			return 0;
			
		}
		
		String descs="INV-"+""+invno+""+":-Dated :- "+invDate; 
		
	String refdetails="EPD"+""+vocno;
		String vndcurrencytype="";
		double costtotal=0;
		for(int i=0;i< descarray.size();i++){
	    	
 
			
		     String[] vehpurreqarray1=descarray.get(i).split("::");
		     if(!(vehpurreqarray1[0].trim().equalsIgnoreCase("undefined")|| vehpurreqarray1[0].trim().equalsIgnoreCase("NaN")||vehpurreqarray1[0].trim().equalsIgnoreCase("")|| vehpurreqarray1[0].isEmpty()))
		     {
		    String amount=""+(vehpurreqarray1[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray1[8].trim().equalsIgnoreCase("NaN")||vehpurreqarray1[8].trim().equalsIgnoreCase("")|| vehpurreqarray1[8].isEmpty()?0:vehpurreqarray1[8].trim())+"";
		    	 costtotal=costtotal+Double.parseDouble(amount);
		    	 
		    	 
		     }
		}
		
		int tranno=0;
		for(int i=0;i< descarray.size();i++){
	    	
		     String[] vehpurreqarray=descarray.get(i).split("::");
		     if(!(vehpurreqarray[0].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[0].trim().equalsIgnoreCase("NaN")||vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()))
		     {
		    	// rowno, sr_no, rdocno, fleet_no, brdid, modid, clrid, puch_cost, add_cost, tot_cost, chaseno, enginno
		                        //                    0     1      2    3     4      5        6          7       8       9
	     String sql="INSERT INTO eq_vpurdird(sr_no,fleet_no,brdid,modid,clrid,chaseno,enginno,puch_cost,add_cost,tot_cost,tax_perc,tax_amt,net_total,rdocno)VALUES"
			       + " ("+(i+1)+","
			       + "'"+(vehpurreqarray[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray[0].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()?0:vehpurreqarray[0].trim())+"',"
			       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
			       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
			       + "'"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
			       + "'"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
			       + "'"+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")||vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"',"
			       + "'"+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")||vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"',"
			       + "'"+(vehpurreqarray[7].trim().equalsIgnoreCase("undefined") || vehpurreqarray[7].trim().equalsIgnoreCase("NaN")||vehpurreqarray[7].trim().equalsIgnoreCase("")|| vehpurreqarray[7].isEmpty()?0:vehpurreqarray[7].trim())+"',"
			       + "'"+(vehpurreqarray[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray[8].trim().equalsIgnoreCase("NaN")||vehpurreqarray[8].trim().equalsIgnoreCase("")|| vehpurreqarray[8].isEmpty()?0:vehpurreqarray[8].trim())+"',"
			       + "'"+(vehpurreqarray[9].trim().equalsIgnoreCase("undefined") || vehpurreqarray[9].trim().equalsIgnoreCase("NaN")||vehpurreqarray[9].trim().equalsIgnoreCase("")|| vehpurreqarray[9].isEmpty()?0:vehpurreqarray[9].trim())+"',"
			       + "'"+(vehpurreqarray[10].trim().equalsIgnoreCase("undefined") || vehpurreqarray[10].trim().equalsIgnoreCase("NaN")||vehpurreqarray[10].trim().equalsIgnoreCase("")|| vehpurreqarray[10].isEmpty()?0:vehpurreqarray[10].trim())+"',"
			       + "'"+(vehpurreqarray[11].trim().equalsIgnoreCase("undefined") || vehpurreqarray[11].trim().equalsIgnoreCase("NaN")||vehpurreqarray[11].trim().equalsIgnoreCase("")|| vehpurreqarray[11].isEmpty()?0:vehpurreqarray[11].trim())+"',"
			       +"'"+docno+"')";
	     
	 //System.out.println("------sql------"+sql);
			     int resultSet2 = stmtvehpurchase.executeUpdate(sql);
			    
			     if(resultSet2<=0)
					{
						conn.close();
						return 0;
					}
			        
					if(i==0)
					{
								String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
								ResultSet tass = stmtvehpurchase.executeQuery (trsql);
										if (tass.next()) {
											tranno=tass.getInt("trno");		
									     }
								
								String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),3,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
								int dd=stmtvehpurchase.executeUpdate(trnosql);
										 if(dd<=0)
											{
												conn.close();
												return 0;
											}
										 
										  	Statement stmt = conn.createStatement(); 	 
										  int	venderaccount=headacccode;
									double	  pricetottal=costtotal;
										 double venrate=0.00; 
										 String vendorcur = curr;  
									     String currencytype="";
									     String sqlss = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
									        +"where  coalesce(toDate,curdate())>='"+sqlStartDate+"' and frmDate<='"+sqlStartDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
									     //System.out.println("-----2--sqlss----"+sqlss) ;
									     ResultSet resultSet33 = stmt.executeQuery(sqlss);
									      while (resultSet33.next()) {
									    	  venrate=resultSet33.getDouble("rate");
									          currencytype=resultSet33.getString("type");
									          vndcurrencytype = currencytype;   
									       }
									      
										   double dramount=ClsCommon.sqlRound((pricetottal+taxamt)*-1,2);      
										   double ldramount=0;
										   if(currencytype.equalsIgnoreCase("D"))
										   {
								           	 ldramount=dramount/venrate ;  
										   }
										   else
										   {
											    ldramount=dramount*venrate ;  
										   }
										 String sql1="";
										 if(cmbbilltype.equalsIgnoreCase("1"))
										 {
										 sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
										 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+ClsCommon.sqlRound(dramount,2)+","+ClsCommon.sqlRound(ldramount,2)+",0,-1,3,0,0,0,'"+venrate+"',0,0,'EPD','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
										 }
										 else if(cmbbilltype.equalsIgnoreCase("2"))
										 {
											 
							double amt=(dramount*-1)-taxamt;
							double lamt=(ldramount*-1)-taxamt;
							System.out.println("amt---="+amt+"dramount---="+ClsCommon.sqlRound(dramount,2)+"taxamount---="+taxamt);

											    sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
												 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+ClsCommon.sqlRound((amt*-1),2)+","+ClsCommon.sqlRound((lamt*-1),2)+",0,-1,3,0,0,0,'"+venrate+"',0,0,'EPD','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
											 //    System.out.println("-----Inside billtype2----"+sql1) ;

										 }
										   	System.out.println("--jv1----"+sql1);
										 int ss = stmt.executeUpdate(sql1);

									     if(ss<=0)
											{
												conn.close();
											}
									     
									     int acnos=0;
									     String curris="0";
									     double rates=0.00;
									     
									   String sql2="select  acno from my_account where codeno='EVEH'";
									   //System.out.println("-----4--sql2----"+sql2) ;
							           ResultSet tass1 = stmt.executeQuery (sql2);
										if (tass1.next()) {
											acnos=tass1.getInt("acno");		
									        }
										
										 String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
										//   System.out.println("-----5--sqls3----"+sqls3) ;
										   ResultSet tass3 = stmt.executeQuery (sqls3);
											if (tass3.next()) {
												curris=tass3.getString("curid");	
										              }
											
											String currencytype1="";
											 String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
												        +"where  coalesce(toDate,curdate())>='"+sqlStartDate+"' and frmDate<='"+sqlStartDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
											 //System.out.println("-----6--sqlveh----"+sqlveh) ;
												     ResultSet resultSet44 = stmt.executeQuery(sqlveh);
												      while (resultSet44.next()) {
												    	  rates=resultSet44.getDouble("rate");
												      currencytype1=resultSet44.getString("type");
												                 } 
											 
												      
												      double ldramounts=0 ;  
												      pricetottal = ClsCommon.sqlRound(pricetottal,2);
												      if(currencytype1.equalsIgnoreCase("D"))
												      {
										                   ldramounts=pricetottal/venrate ;  
												      }
												      else
												      {
												    	   ldramounts=pricetottal*venrate ;  
												      }
									     
										 String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
											 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+ClsCommon.Round(ldramounts,2)+","+ClsCommon.Round(ldramounts,2)+",0,1,3,0,0,0,'"+rates+"',0,0,'EPD','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
										 System.out.println("---jv2----"+sql11) ; 
											 int ss1 = stmt.executeUpdate(sql11);
										     if(ss1<=0)
												{
													conn.close();
													//return 0;
												}
										 
											String sqlupdatess="update eq_vpurdirm set tr_no='"+tranno+"' where doc_no='"+docno+"' ";	
											int lastvals=stmtvehpurchase.executeUpdate(sqlupdatess);
											if(lastvals<=0)
											{
												conn.close();
												return 0;
											}
									//	 	System.out.println("------sqlupdatess------"+sqlupdatess);	 
								
					}
			     
			     int accnoss=0;     
				   String sql2="select  acno from my_account where codeno='EVEH'";
				    
				   // select  acno  from my_account where codeno='EVEH';
					//System.out.println("-----sql2-----"+sql2);
					

				   ResultSet tass1 = stmtvehpurchase.executeQuery (sql2);
					
					if (tass1.next()) {
				
						accnoss=tass1.getInt("acno");		
						
				     }
				//	System.out.println("------sql2------"+sql2);	 
					int assetdoc=0;
					   String sql99="select coalesce((max(doc_no)+1),1) docno from eq_assettran";
					    
					   // select  acno  from my_account where codeno='EVEH';
						//System.out.println("-----sql2-----"+sql2);
						

					   ResultSet tass99 = stmtvehpurchase.executeQuery (sql99);
						
						if (tass99.next()) {
					
							assetdoc=tass99.getInt("docno");		
							
					     }
				    
/*                        //                    0     1      2    3     4      5        6          7       8       9
     String sql="INSERT INTO eq_vpurd(srno,fleet_no,brdid,modid,clrid,chaseno,enginno,puch_cost,add_cost,tot_cost,rdocno)VALUES"
			     */
			     String fleetnos=""+(vehpurreqarray[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray[0].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()?0:vehpurreqarray[0].trim())+"";
				 int  fleetnoss=Integer.parseInt(fleetnos);
			     String amounts=""+(vehpurreqarray[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray[8].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[8].trim().equalsIgnoreCase("")|| vehpurreqarray[8].isEmpty()?0:vehpurreqarray[8].trim())+"";


			     String chaseno=""+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"";
			     String enginno=""+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"";
			     String purchsecost=""+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"";
			     String addcost=""+(vehpurreqarray[7].trim().equalsIgnoreCase("undefined") || vehpurreqarray[7].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[7].trim().equalsIgnoreCase("")|| vehpurreqarray[7].isEmpty()?0:vehpurreqarray[7].trim())+"";
			     double amount1=rate*Double.parseDouble(amounts);
			     String sqla="INSERT INTO eq_assettran(date,doc_no,fleet_no,acno,dramount,brhid,ttype,ftype,tr_no)VALUES"
					       + " ('"+sqlStartDate+"','"+assetdoc+"',"
					       + "'"+fleetnoss+"',"
					       + "'"+accnoss+"',"
					       + "'"+amount1+"',"
					       + "'"+session.getAttribute("BRANCHID").toString()+"',"
					       +"'FAD',1,'"+tranno+"' )";
			     
			System.out.println("---sqla-------"+sqla);
					     int resultSet3 = stmtvehpurchase.executeUpdate(sqla);
					    
					     if(resultSet3<=0)
							{
								conn.close();
								return 0;
							}					   
			   
					     
				//	     select eng_no,ch_no,,prch_cost,tval from gl_equipmaster;   
					     
					    String strgetvendor="select ac.cldocno from my_acbook ac inner join my_head head on (head.doc_no=ac.acno) where head.account="+headacccode;
					    int vendorid=0;
					    ResultSet rsvendor=stmtvehpurchase.executeQuery(strgetvendor);
					    while(rsvendor.next()){
					    	vendorid=rsvendor.getInt("cldocno");
					    }
					    
					    String strchkasettran="select sr_no from eq_assettran where fleet_no="+fleetnoss+" and sr_no !=(select max(sr_no) from eq_assettran)";
                       System.out.println("strchkasettran==="+strchkasettran);
					    ResultSet rschk=stmtvehpurchase.executeQuery(strchkasettran);
                        if(rschk.next()){
                            System.out.println("Already exist in Eqassettran");
                        }
                        else
                        {
                        
                        
					 	String sqlupdates="update gl_equipmaster set puchstatus='"+docno+"',eng_no='"+enginno+"',ch_no='"+chaseno+"',prch_cost='"+purchsecost+"', add1='"+addcost+"', tval='"+amounts+"',depr_date='"+invDate+"',DLRID="+vendorid+"  where fleet_no='"+fleetnoss+"' ";	
					 	System.out.println("------sqlupdates------"+sqlupdates);	 
						int lastval=stmtvehpurchase.executeUpdate(sqlupdates);
						//System.out.println("------sqlupdates------"+sqlupdates);	 
						if(lastval<=0)
						{
							conn.close();
							return 0;
						}
                        }
		      }//if
		
		   }//for
		
		/////////////////////////////////////////////////////vjtran last insertion//////////////////////////////////////////////////
		if(cmbbilltype.equalsIgnoreCase("1")) {
		String strsql12="select t.doc_no docno,acno,per,cstper,h.rate,h.curid from gl_taxmaster t left join my_head h on t.acno=h.doc_no"
						+" where type=1 and '"+sqlStartDate+"' between fromdate and todate and per>0";
		
		//System.out.println("SELECTION FOR vjtran---------"+strsql12);
		
		int acnos=0,currid=0;
		double rates=0.0;
		
		Statement stmt12 = conn.createStatement();
		ResultSet rs12=stmt12.executeQuery(strsql12);
		while(rs12.next()){
			 acnos=rs12.getInt("acno");
			 rates=rs12.getDouble("rate");
			 currid=rs12.getInt("curid");
		}

		if(taxamt!=0){
				      double ldrtaxamt=0.0; 
				      taxamt = ClsCommon.sqlRound(taxamt,2);     
				      if(vndcurrencytype.equalsIgnoreCase("D")) {
				    	  ldrtaxamt=taxamt/rate ;
				      } else {
				    	  ldrtaxamt=taxamt*rate ;   
				      }
		 String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS) "   
				 +"values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+currid+"','"+rates+"',"+ClsCommon.Round(ldrtaxamt,2)+","+ClsCommon.Round(ldrtaxamt,2)+",0,1,3,0,0,0,'"+rates+"',0,0,'EPD','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
		 System.out.println("jv3---------"+sql11);  
		 int xx = stmt12.executeUpdate(sql11);

	     if(xx<=0)
			{
				conn.close();	
			}
		}
		 }
        else if(cmbbilltype.equalsIgnoreCase("2")) 
		{
		     System.out.println("-----Inside billtype2----") ;
				Statement stmt13 = conn.createStatement();

		   
		  
		 if(taxamt>0){
			 System.out.println("----taxinsert----");
		     String sqlt2="select t.doc_no docno,acno,per,cstper,coalesce(h.rate,0) rate,coalesce(h.curid,0) curid from gl_taxmaster t left join my_head h on t.acno=h.doc_no"+
		     				" where type=1 and '"+sqlStartDate+"' between fromdate and todate and per>0";
		   	 ResultSet resultSetTax2=stmt13.executeQuery(sqlt2);
		   	
		     int acnotax=0;
		     String curidtax="0";
		     double ratetax=0.00;
		    		 while(resultSetTax2.next()){
		    			 acnotax=resultSetTax2.getInt("acno");
		    			 curidtax=resultSetTax2.getString("curid");
		    			 ratetax=resultSetTax2.getInt("rate");
		    		 }
		    		 
		    		 if(acnotax>0){
		    			
		    			 // System.out.println("sql2---"+taxamount);
 		    			 String sqltax2="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
 				 			 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acnotax+"','"+descs+"','"+curidtax+"','"+ratetax+"',"+ClsCommon.sqlRound(taxamt,2)+","+ClsCommon.sqlRound(taxamt,2)+",0,1,3,0,0,0,'"+ratetax+"',0,0,'EPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)"; 
 		    			// System.out.println("-=-=-=-=-"+sqltax);
 		    			int st = stmt13.executeUpdate(sqltax2);
 		    			if(st<=0)
						{
							conn.close();
						 
							
						}
		    		 }
		    		 
		    		 
		    		  String sqlt3="select t.doc_no docno,acno,per,cstper,coalesce(h.rate,0) rate,coalesce(h.curid,0) curid from gl_taxmaster t left join my_head h on t.acno=h.doc_no"+
			     				" where type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0";
			   	 ResultSet resultSetTax3=stmt13.executeQuery(sqlt3);
			   	
			     int acnotax2=0;
			     String curidtax2="0";
			     double ratetax2=0.00;
			    		 while(resultSetTax3.next()){
			    			 acnotax2=resultSetTax3.getInt("acno");
			    			 curidtax2=resultSetTax3.getString("curid");
			    			 ratetax2=resultSetTax3.getInt("rate");
			    		 }
			    		 
			    		/*    
					      double	dramount2=pricetottal*-1; 
						   
							 
						   double ldramount2=0;
						   if(currencytype.equalsIgnoreCase("D"))
						   {
						   
				           	
				           	 ldramount2=dramount2/ratetax2 ;  
						   }
						   
						   else
						   {
							    ldramount2=dramount2*ratetax2 ;  
						   }
						 */   
			 		 
			    		 if(acnotax2>0){
			    			
			    			 // System.out.println("sql2---"+taxamount);
	 		    			 String sqltax3="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
	 				 			 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acnotax2+"','"+descs+"','"+curidtax2+"','"+ratetax2+"',"+ClsCommon.sqlRound((taxamt*-1),2)+","+ClsCommon.sqlRound((taxamt*-1),2)+",0,-1,3,0,0,0,'"+ratetax+"',0,0,'EPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)"; 
	 		    			// System.out.println("-=-=-=-=-"+sqltax);
	 		    			int st2 = stmt13.executeUpdate(sqltax3);
	 		    			if(st2<=0)
							{
								conn.close();
							 stmt13.close();
								
							}
			    		 }
		    		 
		    		 
		    		 
		  }
		    		 
			} 
	    
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
		ArrayList<String> arr=new ArrayList<String>(); 
		ClsVatInsert ClsVatInsert=new ClsVatInsert();
		Statement newStatement=conn.createStatement();
		String selectsqls= "select venid,rate,round(sum(a.nettaxamount),2) nettaxamount,round(sum(a.total1),2) total1,round(sum(a.total2),2) total2, " + 
				"round(sum(a.total3),2) total3, round(sum(a.total4),2) total4,round(sum(a.total5),2) total5,round(sum(a.total6),2) total6, " + 
				"round(sum(a.total7),2) total7,round(sum(a.total8),2) total8, round(sum(a.total9),2) total9,round(sum(a.total10),2) total10,  " + 
				"round(sum(a.tax1),2) tax1,round(sum(a.tax2),2) tax2,round(sum(a.tax3),2) tax3,round(sum(a.tax4),2) tax4,round(sum(a.tax5),2) tax5, " + 
				"round(sum(a.tax6),2) tax6, round(sum(a.tax7),2) tax7,round(sum(a.tax8),2) tax8,round(sum(a.tax9),2) tax9,round(sum(a.tax10),2) tax10  " + 
				"from (select m.venid,m.rate,d.tot_cost+coalesce(d.tax_amt,0) nettaxamount,if(coalesce(d.tax_amt,0)>0,d.tot_cost,0) total1,  " + 
				"if(coalesce(d.tax_amt,0)=0,d.tot_cost,0) total2 ,0 total3,  " + 
				"0 total4,0 total5,  " + 
				"0 total6,0 total7,  " + 
				"0 total8,0 total9,  " + 
				"0 total10,  " + 
				"if(d.tax_amt>0,d.tax_amt,0) tax1,  0 tax2,  " + 
				"0 tax3, 0 tax4,  " + 
				"0 tax5, 0 tax6,  " + 
				"0 tax7, 0 tax8,  " + 
				"0 tax9, 0 tax10  " + 
				"from eq_vpurdird d left join eq_vpurdirm m  on d.rdocno=m.doc_no where d.rdocno="+docno+" ) a" ;
		System.out.println("Select sqls==="+selectsqls);
		int venid=0;
		ResultSet rss101=newStatement.executeQuery(selectsqls);
		if(rss101.first()){
			double vndCurRate=rss101.getDouble("rate");
            venid=rss101.getInt("venid");
			arr.add(rss101.getDouble("nettaxamount")*vndCurRate+"::"+rss101.getDouble("total1")*vndCurRate+"::"+rss101.getDouble("total2")*vndCurRate+"::"+
					rss101.getDouble("total3")*vndCurRate+"::"+rss101.getDouble("total4")*vndCurRate+"::"+rss101.getDouble("total5")*vndCurRate+"::"+
					rss101.getDouble("total6")*vndCurRate+"::"+rss101.getDouble("total7")*vndCurRate+"::"+rss101.getDouble("total8")*vndCurRate+"::"+
					rss101.getDouble("total9")*vndCurRate+"::"+rss101.getDouble("total10")*vndCurRate+"::"+rss101.getDouble("tax1")*vndCurRate+"::"+
					rss101.getDouble("tax2")*vndCurRate+"::"+rss101.getDouble("tax3")*vndCurRate+"::"+rss101.getDouble("tax4")*vndCurRate+"::"+
					rss101.getDouble("tax5")*vndCurRate+"::"+rss101.getDouble("tax6")*vndCurRate+"::"+rss101.getDouble("tax7")*vndCurRate+"::"+
					rss101.getDouble("tax8")*vndCurRate+"::"+rss101.getDouble("tax9")*vndCurRate+"::"+rss101.getDouble("tax10")*vndCurRate+"::"+"0");
		}   
		//System.out.println("formdetailcode="+formdetailcode);
		formdetailcode="EPD";
		int result=ClsVatInsert.vatinsert(1,1,conn,tranno,venid,vocno,sqlStartDate,formdetailcode,session.getAttribute("BRANCHID").toString(),""+invno,1,arr,mode)	;
		if(result==0){
			System.out.println("ClsVatInsert error");
			conn.close();
			return 0;
		}
		
		if(cmbbilltype.equalsIgnoreCase("2")){
			int result1=ClsVatInsert.vatinsert(2,2,conn,tranno,venid,vocno,sqlStartDate,formdetailcode,session.getAttribute("BRANCHID").toString(),""+invno,Integer.parseInt(cmbbilltype),arr,mode)	;
			if(result1==0){
				conn.close();
				return 0;
			}
		}
	

		
		if(docno>0) {
			double jvtotal = 0.0, jvextra = 0.0;
			
			String sql11="select if(sum(ldramount)<0,sum(ldramount)*-1,sum(ldramount)) ldr from my_jvtran where tr_no="+tranno+"";   
			ResultSet rs11 = stmtvehpurchase.executeQuery(sql11);
			 while (rs11.next()) {
				 jvextra = rs11.getDouble("ldr");  
			 }
			 String sql22="update my_jvtran set ldramount=ldramount+"+jvextra+" where tr_no="+tranno+" and acno="+headacccode+"";      
			 //System.out.println("sql22==="+sql22);
			 stmtvehpurchase.executeUpdate(sql22); 
				
			String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+tranno+" ";   
			ResultSet resultSet = stmtvehpurchase.executeQuery(sql1);
			 while (resultSet.next()) {
				 jvtotal = resultSet.getDouble("jvtotal");  
			 }
			 //System.out.println("jvtotal==="+jvtotal);  
			 if(jvtotal == 0){
				conn.commit();
				stmtvehpurchase.close();
				conn.close();
				return docno;
			 }else{
			    //    System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
			        stmtvehpurchase.close();   
				    return 0;
			    }
		}
        }//try
        catch(Exception e)
        {
        	e.printStackTrace();
    		return 0;	
        }finally {
			conn.close();
		}
		return 0;
	}
	   
	public boolean edit(int docno, int vocno, Date sqlStartDate, Date invDate, int headacccode,
			String vehdesc, HttpSession session, String mode,
			String formdetailcode, ArrayList<String> descarray, String invno, 
			HttpServletRequest request,Double taxamt,Double nettotal, String reftype, String refno, String curr, Double rate,String cmbbilltype) throws SQLException {   
        try
        {
        	
        conn=ClsConnection.getMyConnection();
        conn.setAutoCommit(false);
    	CallableStatement stmtvehpurchase= conn.prepareCall("{call eqpurchasedirDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
        
    	stmtvehpurchase.registerOutParameter(10, java.sql.Types.INTEGER);
		stmtvehpurchase.registerOutParameter(11, java.sql.Types.INTEGER);
		stmtvehpurchase.setDate(1,sqlStartDate); 
		stmtvehpurchase.setInt(2,headacccode);     
		stmtvehpurchase.setString(3,vehdesc);
		stmtvehpurchase.setString(4,session.getAttribute("USERID").toString());
		stmtvehpurchase.setString(5,session.getAttribute("BRANCHID").toString());
		stmtvehpurchase.setString(6,formdetailcode);
		stmtvehpurchase.setDate(7,invDate);
		stmtvehpurchase.setString(8,invno);
		stmtvehpurchase.setString(9,mode);
		stmtvehpurchase.setInt(10,docno);
		stmtvehpurchase.setInt(11,vocno);
		stmtvehpurchase.setDouble(12,taxamt);
		stmtvehpurchase.setDouble(13,nettotal); 
		stmtvehpurchase.setString(14,reftype);
		stmtvehpurchase.setString(15,refno.trim().equalsIgnoreCase("") || refno==null?"0":refno);
		stmtvehpurchase.setString(16,curr);
		stmtvehpurchase.setDouble(17,rate);      
		stmtvehpurchase.setString(18,cmbbilltype);      

		int aaa=stmtvehpurchase.executeUpdate();
		
		if(aaa<=0)
		{
			conn.close();
			return false;
		}
		
		int tranno=0;
		String trsql="select tr_no from eq_vpurdirm where doc_no='"+docno+"' ";	
		ResultSet tass = stmtvehpurchase.executeQuery (trsql);
				if (tass.next()) {
					tranno=tass.getInt("tr_no");		
			     }
		ClsApplyDelete.getFinanceApplyDelete(conn,tranno);
		
		String descs="INV-"+""+invno+""+":-Dated :- "+invDate; 
		
		String refdetails="EPD"+""+vocno;
		String vndcurrencytype="";
		double costtotal=0;
		for(int i=0;i< descarray.size();i++){
		     String[] vehpurreqarray1=descarray.get(i).split("::");
		     if(!(vehpurreqarray1[0].trim().equalsIgnoreCase("undefined")|| vehpurreqarray1[0].trim().equalsIgnoreCase("NaN")||vehpurreqarray1[0].trim().equalsIgnoreCase("")|| vehpurreqarray1[0].isEmpty()))
		     {
		    String amount=""+(vehpurreqarray1[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray1[8].trim().equalsIgnoreCase("NaN")||vehpurreqarray1[8].trim().equalsIgnoreCase("")|| vehpurreqarray1[8].isEmpty()?0:vehpurreqarray1[8].trim())+"";
		    	 costtotal=costtotal+Double.parseDouble(amount);
		     }
		}
		
		   String delsql="delete from eq_vpurdird where rdocno="+docno;
		   stmtvehpurchase.executeUpdate(delsql);
		   
		   String delsql1="delete from my_jvtran where tr_no="+tranno;
		   stmtvehpurchase.executeUpdate(delsql1);
		   
		   String delsql2="delete from eq_assettran where tr_no="+tranno;
		   stmtvehpurchase.executeUpdate(delsql2);

		
		for(int i=0;i< descarray.size();i++){
	    	
		     String[] vehpurreqarray=descarray.get(i).split("::");
		     if(!(vehpurreqarray[0].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[0].trim().equalsIgnoreCase("NaN")||vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()))
		     {
		    	// rowno, sr_no, rdocno, fleet_no, brdid, modid, clrid, puch_cost, add_cost, tot_cost, chaseno, enginno
		                        //                    0     1      2    3     4      5        6          7       8       9
	     String sql="INSERT INTO eq_vpurdird(sr_no,fleet_no,brdid,modid,clrid,chaseno,enginno,puch_cost,add_cost,tot_cost,tax_perc,tax_amt,net_total,rdocno)VALUES"
			       + " ("+(i+1)+","
			       + "'"+(vehpurreqarray[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray[0].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()?0:vehpurreqarray[0].trim())+"',"
			       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
			       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
			       + "'"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
			       + "'"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
			       + "'"+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")||vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"',"
			       + "'"+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")||vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"',"
			       + "'"+(vehpurreqarray[7].trim().equalsIgnoreCase("undefined") || vehpurreqarray[7].trim().equalsIgnoreCase("NaN")||vehpurreqarray[7].trim().equalsIgnoreCase("")|| vehpurreqarray[7].isEmpty()?0:vehpurreqarray[7].trim())+"',"
			       + "'"+(vehpurreqarray[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray[8].trim().equalsIgnoreCase("NaN")||vehpurreqarray[8].trim().equalsIgnoreCase("")|| vehpurreqarray[8].isEmpty()?0:vehpurreqarray[8].trim())+"',"
			       + "'"+(vehpurreqarray[9].trim().equalsIgnoreCase("undefined") || vehpurreqarray[9].trim().equalsIgnoreCase("NaN")||vehpurreqarray[9].trim().equalsIgnoreCase("")|| vehpurreqarray[9].isEmpty()?0:vehpurreqarray[9].trim())+"',"
			       + "'"+(vehpurreqarray[10].trim().equalsIgnoreCase("undefined") || vehpurreqarray[10].trim().equalsIgnoreCase("NaN")||vehpurreqarray[10].trim().equalsIgnoreCase("")|| vehpurreqarray[10].isEmpty()?0:vehpurreqarray[10].trim())+"',"
			       + "'"+(vehpurreqarray[11].trim().equalsIgnoreCase("undefined") || vehpurreqarray[11].trim().equalsIgnoreCase("NaN")||vehpurreqarray[11].trim().equalsIgnoreCase("")|| vehpurreqarray[11].isEmpty()?0:vehpurreqarray[11].trim())+"',"
			       +"'"+docno+"')";
	     
			     int resultSet2 = stmtvehpurchase.executeUpdate(sql);
			    
			     if(resultSet2<=0)
					{
						conn.close();
						return false;
					}
			        
					if(i==0)
					{
						
					
										 
										  	Statement stmt = conn.createStatement(); 	 
										  int	venderaccount=headacccode;
									double	  pricetottal=costtotal;
										 double venrate=0.00; 
										 String vendorcur = curr;  
									     String currencytype="";
									     String sqlss = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
									        +"where  coalesce(toDate,curdate())>='"+sqlStartDate+"' and frmDate<='"+sqlStartDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
									     //System.out.println("-----2--sqlss----"+sqlss) ;
									     ResultSet resultSet33 = stmt.executeQuery(sqlss);
									      while (resultSet33.next()) {
									    	  venrate=resultSet33.getDouble("rate");
									          currencytype=resultSet33.getString("type");
									          vndcurrencytype = currencytype;   
									       }
									      
										   double dramount=ClsCommon.sqlRound((pricetottal+taxamt)*-1,2);      
										   double ldramount=0;
										   if(currencytype.equalsIgnoreCase("D"))
										   {
								           	 ldramount=dramount/venrate ;  
										   }
										   else
										   {
											    ldramount=dramount*venrate ;  
										   }
										   String sql1="";
											 if(cmbbilltype.equalsIgnoreCase("1"))
											 {
											 sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
											 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+ClsCommon.sqlRound(dramount,2)+","+ClsCommon.sqlRound(ldramount,2)+",0,-1,3,0,0,0,'"+venrate+"',0,0,'EPD','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
											 }
											 else if(cmbbilltype.equalsIgnoreCase("2"))
											 {
												 
								double amt=(dramount*-1)-taxamt;
								double lamt=(ldramount*-1)-taxamt;
								System.out.println("amt---="+amt+"dramount---="+dramount+"taxamount---="+taxamt);

												    sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
													 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+ClsCommon.sqlRound((amt*-1),2)+","+ClsCommon.sqlRound((lamt*-1),2)+",0,-1,3,0,0,0,'"+venrate+"',0,0,'EPD','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
												 //    System.out.println("-----Inside billtype2----"+sql1) ;

											 }   	System.out.println("--jv1----"+sql1);
										 int ss = stmt.executeUpdate(sql1);

									     if(ss<=0)
											{
												conn.close();
											}
									     
									     int acnos=0;
									     String curris="0";
									     double rates=0.00;
									     
									   String sql2="select  acno from my_account where codeno='EVEH'";
							           ResultSet tass1 = stmt.executeQuery (sql2);
										if (tass1.next()) {
											acnos=tass1.getInt("acno");		
									        }
										
										 String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
										// System.out.println("==========="+sqls3);  
										 ResultSet tass3 = stmt.executeQuery (sqls3);
											if (tass3.next()) {
												curris=tass3.getString("curid");	
										              }
											
											String currencytype1="";
											 String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
												        +"where  coalesce(toDate,curdate())>='"+sqlStartDate+"' and frmDate<='"+sqlStartDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
												     ResultSet resultSet44 = stmt.executeQuery(sqlveh);
												      while (resultSet44.next()) {
												    	  rates=resultSet44.getDouble("rate");
												      currencytype1=resultSet44.getString("type");
												                 } 
											 
												      
												      double ldramounts=0 ;  
												      pricetottal = ClsCommon.sqlRound(pricetottal,2);
												      if(currencytype1.equalsIgnoreCase("D"))
												      {
										                   ldramounts=pricetottal/venrate ;  
												      }
												      else
												      {
												    	   ldramounts=pricetottal*venrate ;  
												      }
									     
										 String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
											 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+ClsCommon.Round(ldramounts,2)+","+ClsCommon.Round(ldramounts,2)+",0,1,3,0,0,0,'"+rates+"',0,0,'EPD','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
										 System.out.println("---jv2----"+sql11) ; 
											 int ss1 = stmt.executeUpdate(sql11);
										     if(ss1<=0)
												{
													conn.close();
													//return 0;
												}
										 
											String sqlupdatess="update eq_vpurdirm set tr_no='"+tranno+"' where doc_no='"+docno+"' ";	
											int lastvals=stmtvehpurchase.executeUpdate(sqlupdatess);
											if(lastvals<=0)
											{
												conn.close();
												return false;
											}
								
					}
			     
			     int accnoss=0;     
				   String sql2="select  acno from my_account where codeno='EVEH'";
				    
				   ResultSet tass1 = stmtvehpurchase.executeQuery (sql2);
					
					if (tass1.next()) {
				
						accnoss=tass1.getInt("acno");		
						
				     }
					int assetdoc=0;
					   String sql99="select coalesce((max(doc_no)+1),1) docno from eq_assettran";
					    

					   ResultSet tass99 = stmtvehpurchase.executeQuery (sql99);
						
						if (tass99.next()) {
					
							assetdoc=tass99.getInt("docno");		
							
					     }
				    
/*                        //                    0     1      2    3     4      5        6          7       8       9
     String sql="INSERT INTO eq_vpurd(srno,fleet_no,brdid,modid,clrid,chaseno,enginno,puch_cost,add_cost,tot_cost,rdocno)VALUES"
			     */
			     String fleetnos=""+(vehpurreqarray[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray[0].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()?0:vehpurreqarray[0].trim())+"";
				 int  fleetnoss=Integer.parseInt(fleetnos);
			     String amounts=""+(vehpurreqarray[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray[8].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[8].trim().equalsIgnoreCase("")|| vehpurreqarray[8].isEmpty()?0:vehpurreqarray[8].trim())+"";


			     String chaseno=""+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"";
			     String enginno=""+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"";
			     String purchsecost=""+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"";
			     String addcost=""+(vehpurreqarray[7].trim().equalsIgnoreCase("undefined") || vehpurreqarray[7].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[7].trim().equalsIgnoreCase("")|| vehpurreqarray[7].isEmpty()?0:vehpurreqarray[7].trim())+"";
			     double amount1=rate*Double.parseDouble(amounts);
			     String sqla="INSERT INTO eq_assettran(date,doc_no,fleet_no,acno,dramount,brhid,ttype,ftype,tr_no)VALUES"
					       + " ('"+sqlStartDate+"','"+assetdoc+"',"
					       + "'"+fleetnoss+"',"
					       + "'"+accnoss+"',"
					       + "'"+amount1+"',"
					       + "'"+session.getAttribute("BRANCHID").toString()+"',"
					       +"'FAD',1,'"+tranno+"' )";
			     
					     int resultSet3 = stmtvehpurchase.executeUpdate(sqla);
					    
					     if(resultSet3<=0)
							{
								conn.close();
								return false;
							}					   
			   
					     
					    String strgetvendor="select ac.cldocno from my_acbook ac inner join my_head head on (head.doc_no=ac.acno) where head.account="+headacccode;
					    int vendorid=0;
					    ResultSet rsvendor=stmtvehpurchase.executeQuery(strgetvendor);
					    while(rsvendor.next()){
					    	vendorid=rsvendor.getInt("cldocno");
					    }
					    
					    String strchkasettran="select sr_no from eq_assettran where fleet_no="+fleetnoss+" and sr_no !=(select max(sr_no) from eq_assettran)";
	                       System.out.println("strchkasettran==="+strchkasettran);
	                        ResultSet rschk=stmtvehpurchase.executeQuery(strchkasettran);
	                        if(rschk.next()){
	                            System.out.println("Already exist in Eqassettran");
	                        }
	                        else
	                        {
	                        
	                        

	                            String sqlupdates="update gl_equipmaster set puchstatus='"+docno+"',eng_no='"+enginno+"',ch_no='"+chaseno+"',prch_cost='"+purchsecost+"', add1='"+addcost+"', tval='"+amounts+"',depr_date='"+invDate+"',DLRID="+vendorid+"  where fleet_no='"+fleetnoss+"' ";  
	                            int lastval=stmtvehpurchase.executeUpdate(sqlupdates);
	                            if(lastval<=0)
	                            {
	                                conn.close();
	                                return false;
	                            }
	                        }
					    
					    
					    
		      }//if
		
		   }//for
		
		/////////////////////////////////////////////////////vjtran last insertion//////////////////////////////////////////////////
		if(cmbbilltype.equalsIgnoreCase("1"))
				{
			String strsql12="select t.doc_no docno,acno,per,cstper,h.rate,h.curid from gl_taxmaster t left join my_head h on t.acno=h.doc_no"
		
						+" where type=1 and '"+sqlStartDate+"' between fromdate and todate and per>0";
		
		int acnos=0,currid=0;
		double rates=0.0;
		
		Statement stmt12 = conn.createStatement();
		ResultSet rs12=stmt12.executeQuery(strsql12);
		while(rs12.next()){
			 acnos=rs12.getInt("acno");
			 rates=rs12.getDouble("rate");
			 currid=rs12.getInt("curid");
		}

		if(taxamt!=0){
				      double ldrtaxamt=0.0; 
				      taxamt = ClsCommon.sqlRound(taxamt,2);     
				      if(vndcurrencytype.equalsIgnoreCase("D")) {
				    	  ldrtaxamt=taxamt/rate ;
				      } else {
				    	  ldrtaxamt=taxamt*rate ;   
				      }
		 String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS) "   
				 +"values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+currid+"','"+rates+"',"+ClsCommon.Round(ldrtaxamt,2)+","+ClsCommon.Round(ldrtaxamt,2)+",0,1,3,0,0,0,'"+rates+"',0,0,'EPD','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
		 System.out.println("jv3---------"+sql11);  
		 int xx = stmt12.executeUpdate(sql11);

	     if(xx<=0)
			{
				conn.close();	
			}
		}
        }
        else if(cmbbilltype.equalsIgnoreCase("2")) 
		{
		     System.out.println("-----Inside billtype2----") ;
				Statement stmt13 = conn.createStatement();

		   
		  
		 if(taxamt>0){
			 System.out.println("----taxinsert----");
		     String sqlt2="select t.doc_no docno,acno,per,cstper,coalesce(h.rate,0) rate,coalesce(h.curid,0) curid from gl_taxmaster t left join my_head h on t.acno=h.doc_no"+
		     				" where type=1 and '"+sqlStartDate+"' between fromdate and todate and per>0";
		   	 ResultSet resultSetTax2=stmt13.executeQuery(sqlt2);
		   	
		     int acnotax=0;
		     String curidtax="0";
		     double ratetax=0.00;
		    		 while(resultSetTax2.next()){
		    			 acnotax=resultSetTax2.getInt("acno");
		    			 curidtax=resultSetTax2.getString("curid");
		    			 ratetax=resultSetTax2.getInt("rate");
		    		 }
		    		 
		    		 if(acnotax>0){
		    			
		    			 // System.out.println("sql2---"+taxamount);
 		    			 String sqltax2="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
 				 			 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acnotax+"','"+descs+"','"+curidtax+"','"+ratetax+"',"+ClsCommon.sqlRound(taxamt,2)+","+ClsCommon.sqlRound(taxamt,2)+",0,1,3,0,0,0,'"+ratetax+"',0,0,'EPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)"; 
 		    			// System.out.println("-=-=-=-=-"+sqltax);
 		    			int st = stmt13.executeUpdate(sqltax2);
 		    			if(st<=0)
						{
							conn.close();
						 
							
						}
		    		 }
		    		 
		    		 
		    		  String sqlt3="select t.doc_no docno,acno,per,cstper,coalesce(h.rate,0) rate,coalesce(h.curid,0) curid from gl_taxmaster t left join my_head h on t.acno=h.doc_no"+
			     				" where type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0";
			   	 ResultSet resultSetTax3=stmt13.executeQuery(sqlt3);
			   	
			     int acnotax2=0;
			     String curidtax2="0";
			     double ratetax2=0.00;
			    		 while(resultSetTax3.next()){
			    			 acnotax2=resultSetTax3.getInt("acno");
			    			 curidtax2=resultSetTax3.getString("curid");
			    			 ratetax2=resultSetTax3.getInt("rate");
			    		 }
			    		 
			    		/*    
					      double	dramount2=pricetottal*-1; 
						   
							 
						   double ldramount2=0;
						   if(currencytype.equalsIgnoreCase("D"))
						   {
						   
				           	
				           	 ldramount2=dramount2/ratetax2 ;  
						   }
						   
						   else
						   {
							    ldramount2=dramount2*ratetax2 ;  
						   }
						 */   
			 		 
			    		 if(acnotax2>0){
			    			
			    			 // System.out.println("sql2---"+taxamount);
	 		    			 String sqltax3="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
	 				 			 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acnotax2+"','"+descs+"','"+curidtax2+"','"+ratetax2+"',"+ClsCommon.sqlRound((taxamt*-1),2)+","+ClsCommon.sqlRound((taxamt*-1),2)+",0,-1,3,0,0,0,'"+ratetax+"',0,0,'EPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)"; 
	 		    			// System.out.println("-=-=-=-=-"+sqltax);
	 		    			int st2 = stmt13.executeUpdate(sqltax3);
	 		    			if(st2<=0)
							{
								conn.close();
							 stmt13.close();
								
							}
			    		 }
		    		 
		    		 
		    		 
		  }
		    		 
			} 
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
		ArrayList<String> arr=new ArrayList<String>(); 
		ClsVatInsert ClsVatInsert=new ClsVatInsert();
		Statement newStatement=conn.createStatement();
		String selectsqls= "select venid,rate,round(sum(a.nettaxamount),2) nettaxamount,round(sum(a.total1),2) total1,round(sum(a.total2),2) total2, " + 
				"round(sum(a.total3),2) total3, round(sum(a.total4),2) total4,round(sum(a.total5),2) total5,round(sum(a.total6),2) total6, " + 
				"round(sum(a.total7),2) total7,round(sum(a.total8),2) total8, round(sum(a.total9),2) total9,round(sum(a.total10),2) total10,  " + 
				"round(sum(a.tax1),2) tax1,round(sum(a.tax2),2) tax2,round(sum(a.tax3),2) tax3,round(sum(a.tax4),2) tax4,round(sum(a.tax5),2) tax5, " + 
				"round(sum(a.tax6),2) tax6, round(sum(a.tax7),2) tax7,round(sum(a.tax8),2) tax8,round(sum(a.tax9),2) tax9,round(sum(a.tax10),2) tax10  " + 
				"from (select m.venid,m.rate,d.tot_cost+coalesce(d.tax_amt,0) nettaxamount,if(coalesce(d.tax_amt,0)>0,d.tot_cost,0) total1,  " + 
				"if(coalesce(d.tax_amt,0)=0,d.tot_cost,0) total2 ,0 total3,  " + 
				"0 total4,0 total5,  " + 
				"0 total6,0 total7,  " + 
				"0 total8,0 total9,  " + 
				"0 total10,  " + 
				"if(d.tax_amt>0,d.tax_amt,0) tax1,  0 tax2,  " + 
				"0 tax3, 0 tax4,  " + 
				"0 tax5, 0 tax6,  " + 
				"0 tax7, 0 tax8,  " + 
				"0 tax9, 0 tax10  " + 
				"from eq_vpurdird d left join eq_vpurdirm m  on d.rdocno=m.doc_no where d.rdocno="+docno+" ) a" ;
		System.out.println("Select sqls==="+selectsqls);
		int venid=0;
		ResultSet rss101=newStatement.executeQuery(selectsqls);
		if(rss101.first()){
			double vndCurRate=rss101.getDouble("rate");
            venid=rss101.getInt("venid");
			arr.add(rss101.getDouble("nettaxamount")*vndCurRate+"::"+rss101.getDouble("total1")*vndCurRate+"::"+rss101.getDouble("total2")*vndCurRate+"::"+
					rss101.getDouble("total3")*vndCurRate+"::"+rss101.getDouble("total4")*vndCurRate+"::"+rss101.getDouble("total5")*vndCurRate+"::"+
					rss101.getDouble("total6")*vndCurRate+"::"+rss101.getDouble("total7")*vndCurRate+"::"+rss101.getDouble("total8")*vndCurRate+"::"+
					rss101.getDouble("total9")*vndCurRate+"::"+rss101.getDouble("total10")*vndCurRate+"::"+rss101.getDouble("tax1")*vndCurRate+"::"+
					rss101.getDouble("tax2")*vndCurRate+"::"+rss101.getDouble("tax3")*vndCurRate+"::"+rss101.getDouble("tax4")*vndCurRate+"::"+
					rss101.getDouble("tax5")*vndCurRate+"::"+rss101.getDouble("tax6")*vndCurRate+"::"+rss101.getDouble("tax7")*vndCurRate+"::"+
					rss101.getDouble("tax8")*vndCurRate+"::"+rss101.getDouble("tax9")*vndCurRate+"::"+rss101.getDouble("tax10")*vndCurRate+"::"+"0");
		}   
		//System.out.println("formdetailcode="+formdetailcode);
		formdetailcode="EPD";
		int result=ClsVatInsert.vatinsert(1,1,conn,tranno,venid,vocno,sqlStartDate,formdetailcode,session.getAttribute("BRANCHID").toString(),""+invno,1,arr,mode)	;
		if(result==0){
			System.out.println("ClsVatInsert error");
			conn.close();
			return false;
		}
		
		if(cmbbilltype.equalsIgnoreCase("2")){
			int result1=ClsVatInsert.vatinsert(2,2,conn,tranno,venid,vocno,sqlStartDate,formdetailcode,session.getAttribute("BRANCHID").toString(),""+invno,Integer.parseInt(cmbbilltype),arr,mode)	;
			if(result1==0){
				conn.close();
				return false;
			}
		}
	
		
		if(docno>0) {
			double jvtotal = 0.0, jvextra = 0.0;
			
			String sql11="select if(sum(ldramount)<0,sum(ldramount)*-1,sum(ldramount)) ldr from my_jvtran where tr_no="+tranno+"";   
			ResultSet rs11 = stmtvehpurchase.executeQuery(sql11);
			 while (rs11.next()) {
				 jvextra = rs11.getDouble("ldr");  
			 }
			 String sql22="update my_jvtran set ldramount=ldramount+"+jvextra+" where tr_no="+tranno+" and acno="+headacccode+"";      
			 //System.out.println("sql22==="+sql22);
			 stmtvehpurchase.executeUpdate(sql22); 
				
			String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+tranno+" ";   
			ResultSet resultSet = stmtvehpurchase.executeQuery(sql1);
			 while (resultSet.next()) {
				 jvtotal = resultSet.getDouble("jvtotal");  
			 }
			 System.out.println("jvtotal==="+jvtotal);  
			 if(jvtotal == 0){
				conn.commit();
				stmtvehpurchase.close();
				conn.close();
				return true;
			 }else{
			        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
			        stmtvehpurchase.close();   
				    return false;
			    }
		}
        }//try
        catch(Exception e)
        {
        	e.printStackTrace();
    		return false;	
        }finally {
			conn.close();
		}
		return false;
	}
	
	
	public  JSONArray searchmaster(HttpSession session,String docnoss,String accountss,String accnamess,String datess ,String aa) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
	    Enumeration<String> Enumeration = session.getAttributeNames();
	    int a=0;
	    while(Enumeration.hasMoreElements()){
	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	      a=1;
	     }
	    }
	    if(a==0){
	  return RESULTDATA;
	     }
	    String brcid=session.getAttribute("BRANCHID").toString();
	    java.sql.Date  sqlStartDate = null;
		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
    	{
    	sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
    	}
    	
    	
	    
		String sqltest="";
	    
	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and vo.voc_no like '%"+docnoss+"%'";
    	}
    	if((!(accountss.equalsIgnoreCase(""))) && (!(accountss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.account like '%"+accountss+"%'  ";
    	}
    	if((!(accnamess.equalsIgnoreCase(""))) && (!(accnamess.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.description like '%"+accnamess+"%'";
    	}
     
    	
    	if(!(sqlStartDate==null)){
    		sqltest=sqltest+" and vo.date='"+sqlStartDate+"'";
    	} 
    	Connection conn = null;
		try {
			 conn = ClsConnection.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{
				
				Statement stmtmain = conn.createStatement ();    
	        	String pySql=("select  round(vo.nettotal,2) nettotal,round(vo.taxamt,2) taxamt,om.voc_no refvocno,vo.reftype,vo.curid,vo.rate,vo.refdocno,vo.voc_no,vo.doc_no,vo.date,vo.billtype,vo.venid, vo.desc1,vo.invno purno,vo.puchdate purdate,h.description,h.account,h.doc_no headdoc "
	        			+ " from eq_vpurdirm vo  left join eq_vpom om on om.doc_no=vo.refdocno and vo.reftype='EPO' left  join my_head h on h.doc_no=vo.venid    where vo.status=3 and vo.brhid='"+brcid+"' "+sqltest );
	 
	        	System.out.println("-----------"+pySql);
	        	
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				
			}
			conn.close();
			 return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
		}finally {
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}



	public boolean delete(int masterdoc_no, HttpSession session, String mode,
			String formdetailcode) throws SQLException {
		try
		{
		
		    conn=ClsConnection.getMyConnection();
 
	    	CallableStatement stmtvehpurchase= conn.prepareCall("{call eqpurchasedirDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
	        
	    	stmtvehpurchase.setInt(10,masterdoc_no);
			stmtvehpurchase.setInt(11, 0);
			stmtvehpurchase.setDate(1,null); 
			stmtvehpurchase.setInt(2,0); 
			stmtvehpurchase.setString(3,null);
			stmtvehpurchase.setString(4,session.getAttribute("USERID").toString());
			stmtvehpurchase.setString(5,session.getAttribute("BRANCHID").toString());
			stmtvehpurchase.setString(6,formdetailcode);
			stmtvehpurchase.setDate(7,null);
			stmtvehpurchase.setInt(8,0);
			stmtvehpurchase.setString(9,"D");
			stmtvehpurchase.setDouble(12,0.0);
			stmtvehpurchase.setDouble(13,0.0);   
			stmtvehpurchase.setString(14,"0");
			stmtvehpurchase.setString(15,"0");
			stmtvehpurchase.setString(16,"0");
			stmtvehpurchase.setDouble(17,0.0);
			
		   int res=stmtvehpurchase.executeUpdate();	   
		
		
				if(res>0)
				{
				int	matertr_no=0;
				
				Statement stmtmain = conn.createStatement ();
					String trsql="select tr_no from eq_vpurdirm where doc_no='"+masterdoc_no+"'";
					ResultSet tass = stmtmain.executeQuery (trsql);
							if (tass.next()) {
								matertr_no=tass.getInt("tr_no");		
						     }
							
						String update="update my_jvtran set status=7 where tr_no='"+matertr_no+"'";	
						stmtvehpurchase.executeUpdate(update);
						
						
						ClsApplyDelete.getFinanceApplyDelete(conn,matertr_no);	
						
					stmtvehpurchase.close();
					conn.close();
					return true;
					
				}
	     }
			catch(Exception e)
				{
				e.printStackTrace();
				return false;
				}finally {
					conn.close();
				}
		       return false;
		 
	}
	
	public  JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String currency,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	  
     //   JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
        
   java.sql.Date sqlDate=null;
      date.trim();
      String sqltest="";
                     if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
                     {
                      sqlDate = ClsCommon.changeStringtoSqlDate(date);
                     }
                     
                     if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
                         sqltest=sqltest+" and t.account like '%"+accountno+"%'";
                     }
                     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                      sqltest=sqltest+" and t.description like '%"+accountname+"%'";
                     }
                     if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
                       sqltest=sqltest+" and c.code like '%"+currency+"%'";
                  }
  try {
     conn = ClsConnection.getMyConnection();
     if(chk.equalsIgnoreCase("1"))
     {
    Statement stmtCPV = conn.createStatement ();
          /*   String sql="select t.doc_no,t.account,t.description,c.code curr from my_head t,"
               + "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
               + "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') ";*/
   
    String  sql= "select t.doc_no,t.account,t.description,t.curid,a.tax,a.type actype,c.code currency,a.cldocno,c.type,coalesce(cb.rate,0) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.doc_no=a.acno and "
            + "a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
            + "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
             
    //System.out.println("--accsql--"+sql);
    ResultSet resultSet = stmtCPV.executeQuery(sql);
    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    
    stmtCPV.close();
     }
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
  }finally {
		conn.close();
	}
return RESULTDATA;
}
	
	
	
	
	public  ClsEquipPurchaseDirectBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		ClsEquipPurchaseDirectBean bean = new ClsEquipPurchaseDirectBean();
		  ClsAmountToWords c = new ClsAmountToWords();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtprint = conn.createStatement ();
				String resql=("  select  format(coalesce(vo.taxamt,0),2) taxamt,format(coalesce(vo.nettotal,0),2) nettotal,vo.nettotal nettotalwords,format(coalesce(SUM(vd.tot_cost),0),2) tot,vo.voc_no,vo.doc_no,c.code currency,DATE_FORMAT(vo.date,'%d.%m.%Y') date,vo.venid, vo.desc1,"
						+ " vo.invno purno,DATE_FORMAT(vo.puchdate,'%d.%m.%Y') purdate,h.description,h.account,h.doc_no headdoc,if(vo.reftype='DIR','Direct',concat('Request (',vo.voc_no,')')) type, "
	        			+ " ac.trnnumber,ac.address from eq_vpurdirm vo  left  join  eq_vpurdird vd on vd.rdocno=vo.doc_no left join  my_head h on h.doc_no=vo.venid left join my_acbook ac on vo.venid=ac.acno and ac.dtype='vnd' and ac.status=3 left join my_curr c on vo.curid=c.doc_no  where vo.doc_no='"+docno+"'" );
	 
	      //System.out.println("==resql=="+resql);
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
			     
			       while(pintrs.next()){
			    	   
			    	    bean.setLblcurrency(pintrs.getString("currency")); 
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLbltype(pintrs.getString("type"));
			    	    bean.setLbldesc1(pintrs.getString("desc1"));
			    	    bean.setLblvendtrn(pintrs.getString("trnnumber"));
			    	    bean.setLblvendadd(pintrs.getString("address"));
			    	    bean.setLblvendoeacc(pintrs.getString("account"));
			    	    bean.setLblvendoeaccName(pintrs.getString("description"));
			    	    
			    	    bean.setLblinvno(pintrs.getString("purno"));
			    	    
			    	    bean.setLblpurchaseDate(pintrs.getString("purdate"));
			    	    bean.setLbltot(pintrs.getString("tot"));

			    	    bean.setLbltaxamount(pintrs.getString("taxamt"));
			    	    bean.setLblnettotal(pintrs.getString("nettotal"));
			    	    bean.setAmountinwords(c.convertAmountToWords(pintrs.getString("nettotalwords")));
			    	    
			    	  }
				

		
				
				String resql1=("select round(sum(rq.puch_cost+rq.add_cost),2) price   from eq_vpurdird rq where rdocno='"+docno+"'" );
	 
			
				ResultSet pintrs1 = stmtprint.executeQuery(resql1);
				
				   if(pintrs1.next()){
			  
			    	    bean.setLbltotal(pintrs1.getString("price"));
			    		/*bean.setAmountinwords(c.convertAmountToWords(pintrs1.getString("price")));	*/
				   }
				
				
					stmtprint.close();
				
				 Statement stmtinvoice10 = conn.createStatement ();
					    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location,b.tinno from eq_vpurdirm r  "
					    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
					    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";
					    //System.out.println("==companysql=="+companysql);
				         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
					       while(resultsetcompany.next()){
					    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
					    	   bean.setLblcompname(resultsetcompany.getString("company"));
					    	   bean.setLblcomptrn(resultsetcompany.getString("tinno"));
					    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
					    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
					    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
					    	   bean.setLbllocation(resultsetcompany.getString("location"));
					       }  
				       stmtinvoice10.close();
				       
				       
				       ArrayList<String> arr=new ArrayList<String>();
					
						
							Statement stmtinvoice1 = conn.createStatement ();
							String strSqldetail1="";
					
							
							
							 strSqldetail1=("select  rq.fleet_no,coalesce(v.reg_no,'') reg_no,vb.brand_name brand,vm.vtype model,coalesce(vc.color,'') color,rq.chaseno,rq.enginno ,"
							 		+ " round(rq.puch_cost,2) puch_cost,round(rq.add_cost,2) add_cost,round((rq.puch_cost+rq.add_cost),2) as price from eq_vpurdird rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
							 		+ "left join gl_vehmodel vm on vm.doc_no=rq.MODID left join my_color vc on vc.doc_no=rq.clrid "
							 		+ "left join gl_equipmaster v on v.fleet_no=rq.fleet_no where rq.rdocno="+docno+" ");
				//System.out.println("------------strSqldetail1----"+strSqldetail1);
						ResultSet rsdetail=stmtinvoice1.executeQuery(strSqldetail1);
						
						int rowcount=1;
				
						while(rsdetail.next()){

								String temp="";
								temp=rowcount+"::"+rsdetail.getString("fleet_no")+"::"+rsdetail.getString("reg_no")+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("chaseno")+"::"+rsdetail.getString("enginno")+"::"+rsdetail.getString("puch_cost")+"::"+rsdetail.getString("add_cost")+"::"+rsdetail.getString("price");

								arr.add(temp);
								rowcount++;
				
						
							
					}
						
						
						request.setAttribute("details",arr); 
						stmtinvoice1.close();
										
				conn.close();
			
		}
		catch(Exception e){
			e.printStackTrace();
		}finally {
			conn.close();
		}
		return bean;
		
	
	}

	public  int getTaxMethod() throws SQLException {
	           Connection conn = null;
	           int x=2;
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
				ResultSet rs = stmt.executeQuery("select method from gl_config where field_nme='tax'");
			    while(rs.next()){
			    	  x=rs.getInt("method") ;
			    }
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			conn.close();  
		}
		return x;
	}
	public  JSONArray reqSearchMasters(HttpSession session) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	    Enumeration<String> Enumeration = session.getAttributeNames();
	    int a=0;
	    while(Enumeration.hasMoreElements()){
	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	      a=1;
	     }
	    }
	    if(a==0){
	  return RESULTDATA;
	     }
        String brcid = session.getAttribute("BRANCHID").toString();
	 
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtmain = conn.createStatement ();  
				String pySql=("select m.voc_no,m.doc_no,m.date,m.expdeldt,m.desc1,t.doc_no acdocno,t.account,t.description,t.curid,a.tax,a.type actype,c.code currency,a.cldocno,c.type,coalesce(cb.rate,0) rate from eq_vpom m left join eq_vpurdirm vp on vp.reftype='EPO' and vp.refdocno=m.doc_no left join my_head t on t.doc_no=m.venid left join my_acbook a on t.doc_no=a.acno and a.dtype='VND' and t.atype='AP' left join my_curr c on m.curid=c.doc_no left join my_curbook cb on m.curid=cb.curid where m.status=3 and m.brhid='"+brcid+"' and vp.doc_no is null" );
//				System.out.println("========"+pySql);   
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
		}finally {
			conn.close();
		}
	    return RESULTDATA;
	}
}
