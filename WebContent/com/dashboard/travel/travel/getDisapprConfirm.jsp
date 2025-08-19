<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
    String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	try{
	 	conn = ClsConnection.getMyConnection();   
		Statement stmt = conn.createStatement();
    	int confirm=0,mc=0,adultdismax=0,childdismax=0,childdis=0,adultdis=0,vndid=0,mc2=0,cmode=0;       
			String strSql = "select coalesce(ac.cmode,0) cmode,coalesce(tr.vendorid,0) vndid,coalesce(tr.confirm,0) confirm, coalesce(d.adultdismax,0) adultdismax, coalesce(d.childdismax,0) childdismax,coalesce(tr.childdis,0) childdis,coalesce(tr.adultdis,0) adultdis from tr_srtour tr left join tr_prtourd d on d.rowno=tr.tourdocno left join my_acbook ac on ac.cldocno=tr.vendorid and ac.dtype='VND' where tr.rdocno='"+rdocno+"'";                        
		    //System.out.println("sql====="+strSql);                      
			ResultSet rs1 = stmt.executeQuery(strSql);   
			while(rs1.next()){
				confirm=rs1.getInt("confirm"); 
				cmode=rs1.getInt("cmode"); 
				adultdismax=rs1.getInt("adultdismax");  
				childdismax=rs1.getInt("childdismax");  
				childdis=rs1.getInt("childdis");  
				adultdis=rs1.getInt("adultdis");        
				if(confirm==0){      
					if(childdis!=0 || adultdis!=0){  
						 if(childdis>childdismax || adultdis>adultdismax){
							 mc=1;     
						 }
					}
				}
				vndid=rs1.getInt("vndid");  
				if(vndid==0){ 
					mc2=2;
				}
		  	}  
				response.getWriter().print(mc+"###"+mc2+"###"+cmode);                                                                  
 		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>