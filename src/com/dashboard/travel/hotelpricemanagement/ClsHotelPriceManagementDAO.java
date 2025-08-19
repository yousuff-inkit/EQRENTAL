package com.dashboard.travel.hotelpricemanagement;
    
	import com.common.ClsCommon;
import com.connection.ClsConnection;

	import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
	public class ClsHotelPriceManagementDAO {     

		ClsConnection objconn=new ClsConnection();            
		ClsCommon objcommon=new ClsCommon();
		Connection conn ;
		public int insert(int docno,int hotelid,ArrayList<String> termarray,ArrayList<String> instarray,HttpSession session,HttpServletRequest request,String mode) throws SQLException {
				try{   
				int status=3,val=0;    
				String dtype="";   
				conn=objconn.getMyConnection();   
				conn.setAutoCommit(false); 
				Statement stmt = conn.createStatement ();   
				CallableStatement stmt2=null;
				CallableStatement stmt3=null;  
				CallableStatement stmt4=null;
				CallableStatement stmt5=null;  
				 System.out.println("in dao ===="+docno);  
				 System.out.println("in dao ===="+termarray);
				 for(int i=0;i< termarray.size();i++){     
						String[] gridarraydet=((String) termarray.get(i)).split("::");          
						//System.out.println("in==insert");   
						int srno=gridarraydet[13].trim().equalsIgnoreCase("undefined") || gridarraydet[13].trim().equalsIgnoreCase("NaN")|| gridarraydet[13].trim().equalsIgnoreCase("")|| gridarraydet[13].isEmpty()?0:Integer.parseInt(gridarraydet[13].trim()); 
						int rid=gridarraydet[0].trim().equalsIgnoreCase("undefined") || gridarraydet[0].trim().equalsIgnoreCase("NaN")|| gridarraydet[0].trim().equalsIgnoreCase("")|| gridarraydet[0].isEmpty()?0:Integer.parseInt(gridarraydet[0].trim());
						if(rid>0){  
						if(srno>0){    
							//System.out.println("in edit");    
							stmt3 = conn.prepareCall("update tr_prhoteld set roomid=?,  cpbasic=?, cpexbed=?, child=?, hbadult=?, hbchild=?, fbadult=?, fbchild=?, inadult=?, inchild=?, marginper=?, maxdiscount=?, cost=?, name=? where rowno='"+srno+"'");         
							stmt3.setInt(1,(gridarraydet[0].trim().equalsIgnoreCase("undefined") || gridarraydet[0].trim().equalsIgnoreCase("NaN")|| gridarraydet[0].trim().equalsIgnoreCase("")|| gridarraydet[0].isEmpty()?0:Integer.parseInt(gridarraydet[0].trim())));    
							stmt3.setDouble(2,(gridarraydet[1].trim().equalsIgnoreCase("undefined") || gridarraydet[1].trim().equalsIgnoreCase("NaN")|| gridarraydet[1].trim().equalsIgnoreCase("")|| gridarraydet[1].isEmpty()?0.0:Double.parseDouble(gridarraydet[1].trim())));    
							stmt3.setDouble(3,(gridarraydet[2].trim().equalsIgnoreCase("undefined") || gridarraydet[2].trim().equalsIgnoreCase("NaN")|| gridarraydet[2].trim().equalsIgnoreCase("")|| gridarraydet[2].isEmpty()?0.0:Double.parseDouble(gridarraydet[2].trim())));
							stmt3.setDouble(4,(gridarraydet[3].trim().equalsIgnoreCase("undefined") || gridarraydet[3].trim().equalsIgnoreCase("NaN")|| gridarraydet[3].trim().equalsIgnoreCase("")|| gridarraydet[3].isEmpty()?0.0:Double.parseDouble(gridarraydet[3].trim())));
							stmt3.setDouble(5,(gridarraydet[4].trim().equalsIgnoreCase("undefined") || gridarraydet[4].trim().equalsIgnoreCase("NaN")|| gridarraydet[4].trim().equalsIgnoreCase("")|| gridarraydet[4].isEmpty()?0.0:Double.parseDouble(gridarraydet[4].trim())));
							stmt3.setDouble(6,(gridarraydet[5].trim().equalsIgnoreCase("undefined") || gridarraydet[5].trim().equalsIgnoreCase("NaN")|| gridarraydet[5].trim().equalsIgnoreCase("")|| gridarraydet[5].isEmpty()?0.0:Double.parseDouble(gridarraydet[5].trim())));
							stmt3.setDouble(7,(gridarraydet[6].trim().equalsIgnoreCase("undefined") || gridarraydet[6].trim().equalsIgnoreCase("NaN")|| gridarraydet[6].trim().equalsIgnoreCase("")|| gridarraydet[6].isEmpty()?0.0:Double.parseDouble(gridarraydet[6].trim())));
							stmt3.setDouble(8,(gridarraydet[7].trim().equalsIgnoreCase("undefined") || gridarraydet[7].trim().equalsIgnoreCase("NaN")|| gridarraydet[7].trim().equalsIgnoreCase("")|| gridarraydet[7].isEmpty()?0.0:Double.parseDouble(gridarraydet[7].trim())));
							stmt3.setDouble(9,(gridarraydet[8].trim().equalsIgnoreCase("undefined") || gridarraydet[8].trim().equalsIgnoreCase("NaN")|| gridarraydet[8].trim().equalsIgnoreCase("")|| gridarraydet[8].isEmpty()?0.0:Double.parseDouble(gridarraydet[8].trim())));
							stmt3.setDouble(10,(gridarraydet[9].trim().equalsIgnoreCase("undefined") || gridarraydet[9].trim().equalsIgnoreCase("NaN")|| gridarraydet[9].trim().equalsIgnoreCase("")|| gridarraydet[9].isEmpty()?0.0:Double.parseDouble(gridarraydet[9].trim())));
							stmt3.setDouble(11,(gridarraydet[10].trim().equalsIgnoreCase("undefined") || gridarraydet[10].trim().equalsIgnoreCase("NaN")|| gridarraydet[10].trim().equalsIgnoreCase("")|| gridarraydet[10].isEmpty()?0.0:Double.parseDouble(gridarraydet[10].trim())));
							stmt3.setDouble(12,(gridarraydet[11].trim().equalsIgnoreCase("undefined") || gridarraydet[11].trim().equalsIgnoreCase("NaN")|| gridarraydet[11].trim().equalsIgnoreCase("")|| gridarraydet[11].isEmpty()?0.0:Double.parseDouble(gridarraydet[11].trim())));
							stmt3.setDouble(13,(gridarraydet[12].trim().equalsIgnoreCase("undefined") || gridarraydet[12].trim().equalsIgnoreCase("NaN")|| gridarraydet[12].trim().equalsIgnoreCase("")|| gridarraydet[12].isEmpty()?0.0:Double.parseDouble(gridarraydet[12].trim())));
							stmt3.setString(14,(gridarraydet[14].trim().equalsIgnoreCase("undefined") || gridarraydet[14].trim().equalsIgnoreCase("NaN")|| gridarraydet[14].trim().equalsIgnoreCase("")|| gridarraydet[14].isEmpty()?"":gridarraydet[14].trim().toString()));   
							//System.out.println("stmt3"+stmt3);                         
							val = stmt3.executeUpdate();  
							//System.out.println("val==="+val);    
						}else{   
							//System.out.println("in insert"); 
							stmt2 = conn.prepareCall("insert into tr_prhoteld(rdocno, srno, roomid,  cpbasic, cpexbed,child, hbadult, hbchild, fbadult, fbchild, inadult, inchild, marginper, maxdiscount, cost, name) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
						 	stmt2.setInt(1,docno);         
							stmt2.setInt(2,(i+1));  
							stmt2.setInt(3,(gridarraydet[0].trim().equalsIgnoreCase("undefined") || gridarraydet[0].trim().equalsIgnoreCase("NaN")|| gridarraydet[0].trim().equalsIgnoreCase("")|| gridarraydet[0].isEmpty()?0:Integer.parseInt(gridarraydet[0].trim())));    
							stmt2.setDouble(4,(gridarraydet[1].trim().equalsIgnoreCase("undefined") || gridarraydet[1].trim().equalsIgnoreCase("NaN")|| gridarraydet[1].trim().equalsIgnoreCase("")|| gridarraydet[1].isEmpty()?0.0:Double.parseDouble(gridarraydet[1].trim())));    
							stmt2.setDouble(5,(gridarraydet[2].trim().equalsIgnoreCase("undefined") || gridarraydet[2].trim().equalsIgnoreCase("NaN")|| gridarraydet[2].trim().equalsIgnoreCase("")|| gridarraydet[2].isEmpty()?0.0:Double.parseDouble(gridarraydet[2].trim())));
							stmt2.setDouble(6,(gridarraydet[3].trim().equalsIgnoreCase("undefined") || gridarraydet[3].trim().equalsIgnoreCase("NaN")|| gridarraydet[3].trim().equalsIgnoreCase("")|| gridarraydet[3].isEmpty()?0.0:Double.parseDouble(gridarraydet[3].trim())));
							stmt2.setDouble(7,(gridarraydet[4].trim().equalsIgnoreCase("undefined") || gridarraydet[4].trim().equalsIgnoreCase("NaN")|| gridarraydet[4].trim().equalsIgnoreCase("")|| gridarraydet[4].isEmpty()?0.0:Double.parseDouble(gridarraydet[4].trim())));
							stmt2.setDouble(8,(gridarraydet[5].trim().equalsIgnoreCase("undefined") || gridarraydet[5].trim().equalsIgnoreCase("NaN")|| gridarraydet[5].trim().equalsIgnoreCase("")|| gridarraydet[5].isEmpty()?0.0:Double.parseDouble(gridarraydet[5].trim())));
							stmt2.setDouble(9,(gridarraydet[6].trim().equalsIgnoreCase("undefined") || gridarraydet[6].trim().equalsIgnoreCase("NaN")|| gridarraydet[6].trim().equalsIgnoreCase("")|| gridarraydet[6].isEmpty()?0.0:Double.parseDouble(gridarraydet[6].trim())));
							stmt2.setDouble(10,(gridarraydet[7].trim().equalsIgnoreCase("undefined") || gridarraydet[7].trim().equalsIgnoreCase("NaN")|| gridarraydet[7].trim().equalsIgnoreCase("")|| gridarraydet[7].isEmpty()?0.0:Double.parseDouble(gridarraydet[7].trim())));
							stmt2.setDouble(11,(gridarraydet[8].trim().equalsIgnoreCase("undefined") || gridarraydet[8].trim().equalsIgnoreCase("NaN")|| gridarraydet[8].trim().equalsIgnoreCase("")|| gridarraydet[8].isEmpty()?0.0:Double.parseDouble(gridarraydet[8].trim())));
							stmt2.setDouble(12,(gridarraydet[9].trim().equalsIgnoreCase("undefined") || gridarraydet[9].trim().equalsIgnoreCase("NaN")|| gridarraydet[9].trim().equalsIgnoreCase("")|| gridarraydet[9].isEmpty()?0.0:Double.parseDouble(gridarraydet[9].trim())));
							stmt2.setDouble(13,(gridarraydet[10].trim().equalsIgnoreCase("undefined") || gridarraydet[10].trim().equalsIgnoreCase("NaN")|| gridarraydet[10].trim().equalsIgnoreCase("")|| gridarraydet[10].isEmpty()?0.0:Double.parseDouble(gridarraydet[10].trim())));
							stmt2.setDouble(14,(gridarraydet[11].trim().equalsIgnoreCase("undefined") || gridarraydet[11].trim().equalsIgnoreCase("NaN")|| gridarraydet[11].trim().equalsIgnoreCase("")|| gridarraydet[11].isEmpty()?0.0:Double.parseDouble(gridarraydet[11].trim())));
							stmt2.setDouble(15,(gridarraydet[12].trim().equalsIgnoreCase("undefined") || gridarraydet[12].trim().equalsIgnoreCase("NaN")|| gridarraydet[12].trim().equalsIgnoreCase("")|| gridarraydet[12].isEmpty()?0.0:Double.parseDouble(gridarraydet[12].trim())));
							stmt2.setString(16,(gridarraydet[14].trim().equalsIgnoreCase("undefined") || gridarraydet[14].trim().equalsIgnoreCase("NaN")|| gridarraydet[14].trim().equalsIgnoreCase("")|| gridarraydet[14].isEmpty()?"":gridarraydet[14].trim().toString()));                       
							//System.out.println("stmt2"+stmt2);                                   
							val = stmt2.executeUpdate();
						}
						} 
				}
					 for(int i=0;i< instarray.size();i++){        
						String[] countarraydet=((String) instarray.get(i)).split("::");          
						//System.out.println("in==insert 3rd grid");      
						int srno=countarraydet[4].trim().equalsIgnoreCase("undefined") || countarraydet[4].trim().equalsIgnoreCase("NaN")|| countarraydet[4].trim().equalsIgnoreCase("")|| countarraydet[4].isEmpty()?0:Integer.parseInt(countarraydet[4].trim()); 
						//System.out.println("in==insert 3rd grid==="+srno);       
						java.sql.Date stdt=(countarraydet[1].trim().equalsIgnoreCase("undefined") || countarraydet[1].trim().equalsIgnoreCase("NaN")|| countarraydet[1].trim().equalsIgnoreCase("")|| countarraydet[1].isEmpty()?null:objcommon.changetstmptoSqlDate(countarraydet[1].trim()));
						java.sql.Date endt=(countarraydet[2].trim().equalsIgnoreCase("undefined") || countarraydet[2].trim().equalsIgnoreCase("NaN")|| countarraydet[2].trim().equalsIgnoreCase("")|| countarraydet[2].isEmpty()?null:objcommon.changetstmptoSqlDate(countarraydet[2].trim()));							
						int days=(countarraydet[3].trim().equalsIgnoreCase("undefined") || countarraydet[3].trim().equalsIgnoreCase("NaN")|| countarraydet[3].trim().equalsIgnoreCase("")|| countarraydet[3].isEmpty()?0:Integer.parseInt(countarraydet[3].trim().toString()));
						if((stdt!=null && endt!=null) || days!=0){    
						if(srno>0){     
							//System.out.println("in edit count");    
							stmt4 = conn.prepareCall("update tr_prhoteldet set instruction=?, fdate=?, tdate=?, days=?,roomid=? where rowno='"+srno+"'");         
							stmt4.setInt(1,(countarraydet[0].trim().equalsIgnoreCase("undefined") || countarraydet[0].trim().equalsIgnoreCase("NaN")|| countarraydet[0].trim().equalsIgnoreCase("")|| countarraydet[0].isEmpty()?0:Integer.parseInt(countarraydet[0].trim().toString())));    
							stmt4.setDate(2,stdt);
							stmt4.setDate(3,endt);     
							stmt4.setInt(4,days);    
							stmt4.setInt(5,(countarraydet[5].trim().equalsIgnoreCase("undefined") || countarraydet[5].trim().equalsIgnoreCase("NaN")|| countarraydet[5].trim().equalsIgnoreCase("")|| countarraydet[5].isEmpty()?5:Integer.parseInt(countarraydet[5].trim().toString())));
							//System.out.println("stmt3"+stmt3);                         
							val = stmt4.executeUpdate();    
							//System.out.println("val==="+val);      
						}else{   
							//System.out.println("in insert count"); 
							stmt5 = conn.prepareCall("insert into tr_prhoteldet(rdocno, srno, instruction, fdate, tdate, days,roomid) values(?, ?, ?, ?, ?, ?, ?)");
						 	stmt5.setInt(1,hotelid);               
							stmt5.setInt(2,(i+1));       
							stmt5.setInt(3,(countarraydet[0].trim().equalsIgnoreCase("undefined") || countarraydet[0].trim().equalsIgnoreCase("NaN")|| countarraydet[0].trim().equalsIgnoreCase("")|| countarraydet[0].isEmpty()?0:Integer.parseInt(countarraydet[0].trim().toString())));    
							stmt5.setDate(4,stdt);                                             
							stmt5.setDate(5,endt);              
							stmt5.setInt(6,days);    
							stmt5.setInt(7,(countarraydet[5].trim().equalsIgnoreCase("undefined") || countarraydet[5].trim().equalsIgnoreCase("NaN")|| countarraydet[5].trim().equalsIgnoreCase("")|| countarraydet[5].isEmpty()?5:Integer.parseInt(countarraydet[5].trim().toString())));
							//System.out.println("stmt2"+stmt2);                                   
							val = stmt5.executeUpdate();   
						}
					    }
						}    
			  	if(val<=0){             
			  		conn.close();
			        return 0;
			      }
				if (val > 0) {      
					conn.commit();
					conn.close();
					return val;       
				}
			}catch(Exception e){	
				e.printStackTrace();
				conn.close();	
			}
			return 0;
		}
		public JSONArray pricegriddata(String id,String hotelid) throws SQLException{        
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){
				return data;  
			}    
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement();           
			String sqltest="",strsql1="",strsql2=""; 
			ResultSet rs1=null,rs2=null;
			strsql1="select convert(docno,char(50)) docno,DATE_FORMAT(fdate,'%d.%m.%Y') fdate,DATE_FORMAT(tdate,'%d.%m.%Y') tdate,convert(pcat,char(50)) pcat,convert(pcatid,char(50)) pcatid,remarks,save,type,convert(releaseno,char(50)) releaseno,convert(nation,char(50)) nation,convert(nationid,char(50)) nationid from(select m.doc_no docno,fdate,tdate,pcatid,remarks,pcategory pcat,'Edit' save,taxtype type,releaseno,nation,nationid from tr_prhotelm m left join tr_pricecategory c on c.doc_no=m.pcatid where hotelid='"+hotelid+"' union all select '' docno,null fdate,null tdate,0 pcatid,'' remarks,'' pcat,'Save' save,'' type,0 releaseno,'' nation,0 nationid) a";
			System.out.println("price--->>>"+strsql1);         
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
		public JSONArray roomdata(String id,String docno) throws SQLException{        
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){
				return data;  
			}    
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement();           
			String sqltest="",strsql1="",strsql2="";  
			ResultSet rs1=null,rs2=null;              
			strsql1="select d.name,d.rowno,d.roomid,r.name room,r.remarks cat,d.cpbasic cbasic,d.cpexbed cextra,d.child, d.hbadult, d.hbchild, d.fbadult, d.fbchild, d.inadult, d.inchild, d.marginper, d.maxdiscount, d.cost from tr_prhoteld d left join tr_hoteld hd on hd.srno=d.roomid left join TR_ROOMTYPE r on r.doc_no=hd.rtypeid where d.rdocno='"+docno+"'";
			//System.out.println("room--->>>"+strsql1);
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
		public JSONArray countGridLoad(String id,String docno) throws SQLException{        
			JSONArray data=new JSONArray();     
			if(!id.equalsIgnoreCase("1")){
				return data;  
			}    
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement();           
			String sqltest="",strsql1="",strsql2="";  
			ResultSet rs1=null,rs2=null;                 
			strsql1="select d.rowno,d.rdocno,i.name,d.fdate, d.tdate,d.days,d.instruction doc_no,h.name room,d.roomid from tr_prhoteldet d left join tr_prinstruction i on i.doc_no=d.instruction left join TR_hoteld h on d.roomid=h.srno where d.rdocno='"+docno+"'";
			//System.out.println("ins--->>>"+strsql1);  
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
		public JSONArray searchRoomName(String docno) throws SQLException{ 
			JSONArray data=new JSONArray();    
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String strsql="SELECT  name room,srno doc_no from TR_hoteld where rdocno='"+docno+"'";          
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
		public JSONArray searchRoom(String docno) throws SQLException{   
			JSONArray data=new JSONArray(); 
			/*if(!id.equalsIgnoreCase("1")){
				return data;  
			}*/
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String strsql="select r.name room,d.srno doc_no,r.remarks cat,d.name  from tr_hoteld d left join TR_ROOMTYPE r on r.doc_no=d.rtypeid where d.rdocno='"+docno+"';"; 
			//System.out.println("visa search--->>>"+strsql);   
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
		public JSONArray searchInstruction() throws SQLException{   
			JSONArray data=new JSONArray(); 
			/*if(!id.equalsIgnoreCase("1")){
				return data;  
			}*/
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();  
			String strsql="select doc_no,name from tr_prinstruction where status=3"; 
			//System.out.println("visa search--->>>"+strsql);   
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
	public JSONArray searchCategory() throws SQLException{            
		JSONArray data=new JSONArray(); 
		/*if(!id.equalsIgnoreCase("1")){
			return data;  
		}*/
		Connection conn=null;   
		try{
		conn=objconn.getMyConnection();   
		Statement stmt=conn.createStatement();         
		String strsql="select 0 doc_no,'All' name  union all  select doc_no,name from tr_pricecategory where status=3"; 
		//System.out.println("Category search--->>>"+strsql); 
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


