package com.dashboard.travel.hotelbookingportal;
    
	import com.common.ClsCommon;
import com.connection.ClsConnection;

	import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
	public class ClsHotelBookingPortalDAO {     

		ClsConnection objconn=new ClsConnection();         
		ClsCommon objcommon=new ClsCommon();
		Connection conn ;
		public int insert(Date sqlStartDate,Date sqlEndDate,String cldocno,String txtroom,String clienttype,String jqxClient,   
				String client,String mob,String email,String pax,String child,String age1,String age2,String age3,String age4,String age5,   
				String age6,String location,ArrayList<String> termarray,HttpSession session,HttpServletRequest request,String mode) throws SQLException {
				try{   
				  
				System.out.println("==in dao=="+cldocno);      
				int docno;
				String clientname="",dtype="HBP";
				conn=objconn.getMyConnection();
				conn.setAutoCommit(false); 
				if(clienttype.equalsIgnoreCase("1")){       
					 clientname=jqxClient;
				}else{
					 clientname=client;        
				}
				CallableStatement stmtBooking = conn.prepareCall("{call tr_bookingDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");   
				stmtBooking.registerOutParameter(20, java.sql.Types.INTEGER);
				stmtBooking.registerOutParameter(21, java.sql.Types.INTEGER); 
				stmtBooking.setInt(22,cldocno=="" || cldocno==null || cldocno.equalsIgnoreCase("")?0:Integer.parseInt(cldocno));
				stmtBooking.setDate(1,sqlStartDate);
				stmtBooking.setDate(2,sqlEndDate);    
				stmtBooking.setString(3,clientname);
				stmtBooking.setInt(4,clienttype=="" || clienttype==null || clienttype.equalsIgnoreCase("")?0:Integer.parseInt(clienttype));
				stmtBooking.setString(5,mob);
				stmtBooking.setString(6,email);
				stmtBooking.setInt(7,pax=="" || pax==null || pax.equalsIgnoreCase("")?0:Integer.parseInt(pax));
				stmtBooking.setInt(8,child=="" || child==null || child.equalsIgnoreCase("")?0:Integer.parseInt(child));
				stmtBooking.setInt(9,location=="" || location==null || location.equalsIgnoreCase("")?0:Integer.parseInt(location));
				stmtBooking.setString(10,session.getAttribute("USERID").toString());
				stmtBooking.setString(11,session.getAttribute("BRANCHID").toString());
				stmtBooking.setInt(12,age1=="" || age1==null || age1.equalsIgnoreCase("")?0:Integer.parseInt(age1));
				stmtBooking.setInt(13,age2=="" || age2==null || age2.equalsIgnoreCase("")?0:Integer.parseInt(age2));
				stmtBooking.setInt(14,age3=="" || age3==null || age3.equalsIgnoreCase("")?0:Integer.parseInt(age3));
				stmtBooking.setInt(15,age4=="" || age4==null || age4.equalsIgnoreCase("")?0:Integer.parseInt(age4));
				stmtBooking.setInt(16,age5=="" || age5==null || age5.equalsIgnoreCase("")?0:Integer.parseInt(age5));
				stmtBooking.setInt(17,age6=="" || age6==null || age6.equalsIgnoreCase("")?0:Integer.parseInt(age6));
				stmtBooking.setString(18,mode);      
				stmtBooking.setString(19,dtype);  
				stmtBooking.executeQuery();
				docno=stmtBooking.getInt("docNo");
				int vocno=stmtBooking.getInt("vocNo");
				request.setAttribute("vocno", vocno);
				if(docno<=0)
				{
					conn.close();
					return 0;
				}
				if(docno>0)  
				{
				//System.out.println("docno==="+docno);
				for(int i=0;i< termarray.size();i++){       

					String[] booking=termarray.get(i).split("::");    
					if(!(booking[3].trim().equalsIgnoreCase("undefined")|| booking[3].trim().equalsIgnoreCase("NaN")||booking[3].trim().equalsIgnoreCase("")|| booking[3].isEmpty()))
					{
						String sql="insert into tr_bookingd(rdocno, srno, roomname, basic, extrabed, child, teenage, totalval, hotelid, roomtype) values( "
								+" "+docno+" "+","  
								+ (i+1)+","
								+" '"+txtroom+"' "+","    
								+ " "+(booking[0].trim().equalsIgnoreCase("undefined") || booking[0].trim().equalsIgnoreCase("NaN")|| booking[0].trim().equalsIgnoreCase("")|| booking[0].isEmpty()?0.0:Double.parseDouble(booking[0].trim().toString()))+","  
								+ " "+(booking[1].trim().equalsIgnoreCase("undefined") || booking[1].trim().equalsIgnoreCase("NaN")|| booking[1].trim().equalsIgnoreCase("")|| booking[1].isEmpty()?0.0:Double.parseDouble(booking[1].trim().toString()))+","
								+ " "+(booking[2].trim().equalsIgnoreCase("undefined") || booking[2].trim().equalsIgnoreCase("NaN")|| booking[2].trim().equalsIgnoreCase("")|| booking[2].isEmpty()?0.0:Double.parseDouble(booking[2].trim().toString()))+","
								+ " "+(booking[3].trim().equalsIgnoreCase("undefined") || booking[3].trim().equalsIgnoreCase("NaN")|| booking[3].trim().equalsIgnoreCase("")|| booking[3].isEmpty()?0.0:Double.parseDouble(booking[3].trim().toString()))+","
								+ " "+(booking[4].trim().equalsIgnoreCase("undefined") || booking[4].trim().equalsIgnoreCase("NaN")|| booking[4].trim().equalsIgnoreCase("")|| booking[4].isEmpty()?0.0:Double.parseDouble(booking[4].trim().toString()))+","
								+ " "+(booking[5].trim().equalsIgnoreCase("undefined") || booking[5].trim().equalsIgnoreCase("NaN")|| booking[5].trim().equalsIgnoreCase("")|| booking[5].isEmpty()?0:Integer.parseInt(booking[5].trim().toString()))+","
								+ " "+(booking[6].trim().equalsIgnoreCase("undefined") || booking[6].trim().equalsIgnoreCase("NaN")|| booking[6].trim().equalsIgnoreCase("")|| booking[6].isEmpty()?0:Integer.parseInt(booking[6].trim().toString()))+")";       
				        //System.out.println("insert into tr_bookingd==="+sql);	
						int resultSet2 = stmtBooking.executeUpdate (sql);   
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}	
					}
				}
				}
				if (docno > 0) {
					conn.commit();
					stmtBooking.close();
					conn.close();
					return docno;
				}
			}catch(Exception e){	
				e.printStackTrace();
				conn.close();	
			}
			return 0;
		}
		public JSONArray bookinggriddata(String fromdate,String todate,String locid,String nationid,String hotelid,int npax,int chd,String rtype,String id,int childage1,int childage2,int childage3,int childage4,int childage5,int childage6) throws SQLException{        
			JSONArray data=new JSONArray();       
			if(!id.equalsIgnoreCase("1")){
				return data;  
			}    
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement();           
			String sqltest="",strsql1="",sql1="";               
			ResultSet rs1=null,rs2=null;
			java.sql.Date sqlfromdate = null;
			java.sql.Date sqltodate = null;
		        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		     	}
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=objcommon.changeStringtoSqlDate(todate);
		     	}
		     	else{
		     
		     	}                     
		     	if(sqlfromdate!=null){
		     		sqltest+=" and '"+sqlfromdate+"' between m.fdate and m.tdate";  
		     	}      
			  if(!(locid.equalsIgnoreCase("") || locid.equalsIgnoreCase("0"))){
        		sqltest+=" and a.doc_no='"+locid+"'";
        	   }
			  if(!(nationid.equalsIgnoreCase("") || nationid.equalsIgnoreCase("0"))){
				  sqltest+=" and m.pcatid='"+nationid+"'";
	        	   }
			  if(!(hotelid.equalsIgnoreCase("") || hotelid.equalsIgnoreCase("0"))){
				  sqltest+=" and m.hotelid='"+hotelid+"'";
	        	   }
			    if(chd!=0 && npax==0){   
				  sqltest+=" and "+chd+"<=hd.adult";       
	        	   }else if(chd==0 && npax!=0){
				  sqltest+=" and "+npax+"<=hd.adult";       
	        	   }else if(chd!=0 && npax!=0){   
				  sqltest+=" and ("+npax+"-"+chd+")<=hd.adult";       
	        	   }    
			  if(chd!=0){
				  sqltest+=" and "+chd+"<=hd.child";               
	        	   }
			  if(!(rtype.equalsIgnoreCase("") || rtype.equalsIgnoreCase("0"))){  
				  sqltest+=" and d.roomid='"+rtype+"'";  
	        	   }
			  
			  if(childage1!=0){  
	        		sql1+=" +(if("+childage1+" between h.childmin and childmax,cpoth1, if("+childage1+" between h.teenmin and teenmax,cpoth2,0)))";
	        	   }
			  if(childage2!=0){  
				    sql1+=" +(if("+childage2+" between h.childmin and childmax,cpoth1, if("+childage2+" between h.teenmin and teenmax,cpoth2,0)))";
	        	   }
			  if(childage3!=0){  
				    sql1+=" +(if("+childage3+" between h.childmin and childmax,cpoth1, if("+childage3+" between h.teenmin and teenmax,cpoth2,0)))";
	        	   }
			  if(childage4!=0){  
				    sql1+=" +(if("+childage4+" between h.childmin and childmax,cpoth1, if("+childage4+" between h.teenmin and teenmax,cpoth2,0)))";
	        	   }
			  if(childage5!=0){  
				    sql1+=" +(if("+childage5+" between h.childmin and childmax,cpoth1, if("+childage5+" between h.teenmin and teenmax,cpoth2,0)))";
	        	   }
			  if(childage6!=0){     
				    sql1+=" +(if("+childage6+" between h.childmin and childmax,cpoth1, if("+childage6+" between h.teenmin and teenmax,cpoth2,0)))";
	        	   }          
			  
			  strsql1="select coalesce(hd.srno,0) roomid,coalesce(h.doc_no,0) hotelid,h.name hotel,a.area loc,rt.name rtype,rt.remarks cat,coalesce(hd.name,'') name,"  
					+ "  convert(concat(rating , ' ',adult ,' Adult,',child , ' Child,', extrabed ,' Extrabed.'),char(50)) details"
					+ " ,spbasic"+sql1+" price from tr_prhotelm M left join tr_prhoteld d on d.rdocno=m.doc_no "
					+ " LEFT join tr_hotel h on m.hotelid=h.doc_no left join tr_hoteld hd on h.doc_no=hd.rdocno"
					+ " and d.roomid=hd.SRNO left join my_area a on h.areaid=a.doc_no left join tr_roomtype rt on hd.rtypeid=rt.doc_no where 1=1 "+sqltest+"";
			System.out.println("price--->>>"+strsql1);  
			rs1=stmt.executeQuery(strsql1);
			data=objcommon.convertToJSON(rs1);           
			}
			catch(Exception e){
			e.printStackTrace();
			}
			finally{
			conn.close(); 
			}
			return data;
			}
		public JSONArray subgriddata(String hotelid,String roomid,String id,int childage1,int childage2,int childage3,int childage4,int childage5,int childage6) throws SQLException{        
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){
				return data;  
			}    
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement();           
			String sqltest="",strsql1="",strsql2="",sql1="" , sqlchild="0", sqlteenage="0";            
			ResultSet rs1=null,rs2=null;
			if(childage1!=0){  
        		sql1+=" +(if("+childage1+" between h.childmin and childmax,cpoth1, if("+childage1+" between h.teenmin and teenmax,cpoth2,0)))";
        		sqlchild+=  " + if("+childage1+" between h.childmin and childmax,cpoth1,0) " ;
        		sqlteenage+=" + if("+childage1+" between h.teenmin and teenmax,cpoth2,0) " ;
        	   }
		  if(childage2!=0){  
			    sql1+=" +(if("+childage2+" between h.childmin and childmax,cpoth1, if("+childage2+" between h.teenmin and teenmax,cpoth2,0)))";
        		sqlchild+=  " + if("+childage2+" between h.childmin and childmax,cpoth1,0) " ;
        		sqlteenage+=" + if("+childage2+" between h.teenmin and teenmax,cpoth2,0) " ;
        	   }
		  if(childage3!=0){  
			    sql1+=" +(if("+childage3+" between h.childmin and childmax,cpoth1, if("+childage3+" between h.teenmin and teenmax,cpoth2,0)))";
        		sqlchild+=  " + if("+childage3+" between h.childmin and childmax,cpoth1,0) " ;
        		sqlteenage+=" + if("+childage3+" between h.teenmin and teenmax,cpoth2,0) " ;
        	   }
		  if(childage4!=0){  
			    sql1+=" +(if("+childage4+" between h.childmin and childmax,cpoth1, if("+childage4+" between h.teenmin and teenmax,cpoth2,0)))";
        		sqlchild+=  " + if("+childage4+" between h.childmin and childmax,cpoth1,0) " ;
        		sqlteenage+=" + if("+childage4+" between h.teenmin and teenmax,cpoth2,0) " ;
        	   }
		  if(childage5!=0){  
			    sql1+=" +(if("+childage5+" between h.childmin and childmax,cpoth1, if("+childage5+" between h.teenmin and teenmax,cpoth2,0)))";
        		sqlchild+=  " + if("+childage5+" between h.childmin and childmax,cpoth1,0) " ;
        		sqlteenage+=" + if("+childage5+" between h.teenmin and teenmax,cpoth2,0) " ;
        	   }
		  if(childage6!=0){     
			    sql1+=" +(if("+childage6+" between h.childmin and childmax,cpoth1, if("+childage6+" between h.teenmin and teenmax,cpoth2,0)))";
        		sqlchild+=  " + if("+childage6+" between h.childmin and childmax,cpoth1,0) " ;
        		sqlteenage+=" + if("+childage6+" between h.teenmin and teenmax,cpoth2,0) " ;
        	   }          

			strsql1="select rt.doc_no roomid,h.doc_no hotelid,concat(coalesce(h.name,''),', ',coalesce(a.area,''),', ',coalesce(hd.name,'')) name,d.spbasic basic,d.spexbed exbed,"+sqlchild+" child,"+sqlteenage+" teenage,(coalesce(d.spbasic,0)+coalesce(d.spexbed,0)) total from tr_prhotelm M left join tr_prhoteld d on d.rdocno=m.doc_no  LEFT join tr_hotel h on m.hotelid=h.doc_no left join tr_hoteld hd on h.doc_no=hd.rdocno and d.roomid=hd.srno left join my_area a on h.areaid=a.doc_no left join tr_roomtype rt on hd.rtypeid=rt.doc_no where h.doc_no in("+hotelid.substring(0, hotelid.length()-1)+") and hd.srno in ("+roomid.substring(0, roomid.length()-1)+")";
			
			 System.out.println("subgrid--->>>"+strsql1);  
			rs1=stmt.executeQuery(strsql1);
			//if(rs1.next()){
			data=objcommon.convertToJSON(rs1);            
			}
			catch(Exception e){
			e.printStackTrace();
			}
			finally{
			conn.close(); 
			}
			return data;
			}
		public JSONArray searchclient(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();
				        
				String strsql="select trim(refname) user,cldocno doc_no,per_mob mob,mail1 mail  from my_acbook";  
				ResultSet rs=stmt.executeQuery(strsql);
				data=objcommon.convertToJSON(rs);  
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}
		public JSONArray searchRoom() throws SQLException{ 
			JSONArray data=new JSONArray(); 
			/*if(!id.equalsIgnoreCase("1")){
				return data;  
			}*/
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String strsql="select name,doc_no,remarks cat from TR_ROOMTYPE where status=3"; 
			//System.out.println("Room search--->>>"+strsql); 
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);   
			} 
			catch(Exception e){
			e.printStackTrace();
			}
			finally{
			conn.close(); 
			}
			return data;  
			}
	public JSONArray searchHotel() throws SQLException{ 
		JSONArray data=new JSONArray(); 
		/*if(!id.equalsIgnoreCase("1")){
			return data;  
		}*/
		Connection conn=null; 
		try{  
		conn=objconn.getMyConnection();   
		Statement stmt=conn.createStatement();
		String strsql="select h.name,h.doc_no,ac.refname,h.vendorid from tr_hotel h left join my_acbook ac on(ac.doc_no=h.vendorid and ac.dtype='vnd') where h.status=3"; 
		//System.out.println("Hotel search--->>>"+strsql); 
		ResultSet rs=stmt.executeQuery(strsql);
		data=objcommon.convertToJSON(rs);   
		} 
		catch(Exception e){
		e.printStackTrace();
		}
		finally{
		conn.close(); 
		}
		return data;  
		}  
	public JSONArray searchNation() throws SQLException{ 
		JSONArray data=new JSONArray(); 
		/*if(!id.equalsIgnoreCase("1")){
			return data;  
		}*/
		Connection conn=null; 
		try{
		conn=objconn.getMyConnection();   
		Statement stmt=conn.createStatement();
		String strsql="select catid,nation name from my_natm where status=3;"; 
		//System.out.println("Nation search--->>>"+strsql); 
		ResultSet rs=stmt.executeQuery(strsql);
		data=objcommon.convertToJSON(rs);   
		} 
		catch(Exception e){
		e.printStackTrace();
		}
		finally{
		conn.close(); 
		}
		return data;  
		}  
	public JSONArray searchLocation() throws SQLException{ 
		JSONArray data=new JSONArray(); 
		/*if(!id.equalsIgnoreCase("1")){
			return data;  
		}*/
		Connection conn=null; 
		try{
		conn=objconn.getMyConnection();   
		Statement stmt=conn.createStatement();
		String strsql="select doc_no,area name from my_area where status=3;"; 
		//System.out.println("Location search--->>>"+strsql); 
		ResultSet rs=stmt.executeQuery(strsql);
		data=objcommon.convertToJSON(rs);   
		} 
		catch(Exception e){
		e.printStackTrace();
		}
		finally{
		conn.close(); 
		}
		return data;  
		}  
}