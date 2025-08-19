<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>   
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
    String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	try{
		JSONObject objdata=new JSONObject();         
	 	conn = ClsConnection.getMyConnection();
	 	ClsCommon cmn=new ClsCommon();
		Statement stmt = conn.createStatement();
		String trsnt ="",transport="",childage="",height="",weight="",ageres="";
		String strSql = "select coalesce(name,'') name, coalesce(childmin,0) childmin, coalesce(childmax,0) childmax, coalesce(hghtmin,0) hghtmin, coalesce(hghtmax,0) hghtmax, coalesce(wghtmin,0) wghtmin, coalesce(wghtmax,0) wghtmax, coalesce(agemin,0) agemin, coalesce(agemax,0) agemax, coalesce(description,'') description, coalesce(transport,'') transport from tr_tours where status=3 and doc_no='"+rdocno+"'";        
		    //System.out.println("sql====="+strSql);                      
			ResultSet rs1 = stmt.executeQuery(strSql);
			JSONArray dataarray=new JSONArray();
			while(rs1.next()) {  
				JSONObject temp=new JSONObject();  
				trsnt =rs1.getString("transport");
				if(trsnt.equalsIgnoreCase("1")){
					transport="Transportation is available";
				}else{
					transport="Transportation is not available";      
				}
				childage=rs1.getString("childmin")+" - "+rs1.getString("childmax");
				height=rs1.getString("hghtmin")+" - "+rs1.getString("hghtmax");
				weight=rs1.getString("wghtmin")+" - "+rs1.getString("wghtmax");
				ageres=rs1.getString("agemin")+" - "+rs1.getString("agemax");  
				temp.put("tourname",rs1.getString("name"));
				temp.put("childage",childage);  
				temp.put("height",height);
				temp.put("weight",weight);
				temp.put("ageres",ageres);           
				temp.put("description",rs1.getString("description"));
				temp.put("transport",transport);  
				dataarray.add(temp);	
			} 
			String strimg = "select @i:=@i+1 srno,path from(select replace(path,'\\\\',';') path from my_fileattach where dtype='TOUR' and doc_no='"+rdocno+"' and status<>7) a,(select @i:=-1)c";            
		    //System.out.println("sql====="+strimg);                        
			ResultSet rs2 = stmt.executeQuery(strimg);           
			JSONArray imgaarray=new JSONArray(); 
			int val=0,val2=0,val3=0;
			while(rs2.next()) {      
				JSONObject temp=new JSONObject();
				temp.put("srno",rs2.getString("srno"));
				temp.put("path",rs2.getString("path"));
				val=1;
				temp.put("val",val);      
				imgaarray.add(temp);	
			}
			String strnav = "select coalesce(termsheader,'') terms from tr_prtourterms tr left join my_termsm m on(tr.termsid=m.voc_no) where  tr.dtype='TOUR' and tr.rdocno='"+rdocno+"' group by terms order by termsheader";            
		    //System.out.println("sql====="+strnav);                          
			ResultSet rs3 = stmt.executeQuery(strnav);           
			JSONArray navarray=new JSONArray();    
			while(rs3.next()) {    
				JSONObject temp=new JSONObject();
				temp.put("terms",rs3.getString("terms"));  
				val2=1;
				temp.put("val",val2);
				navarray.add(temp);	
			}
			
			String strmodal = "select coalesce(termsheader,'') terms, coalesce(replace(if(conditions='0','',conditions),',',''),'') conditions from tr_prtourterms tr left join my_termsm m on(tr.termsid=m.voc_no) where  tr.dtype='TOUR' and tr.rdocno='"+rdocno+"' order by termsheader";            
		    //System.out.println("sql====="+strmodal);                          
			ResultSet rs4 = stmt.executeQuery(strmodal);           
			JSONArray modalarray=new JSONArray();    
			while(rs4.next()) {    
				JSONObject temp=new JSONObject();
				temp.put("terms",rs4.getString("terms"));   
				temp.put("conditions",rs4.getString("conditions"));
				val3=1;
				temp.put("val",val3);      
				modalarray.add(temp);	
			}
			//System.out.println("imgaarray====="+imgaarray);   
			response.getWriter().print(dataarray+"::"+imgaarray+"::"+navarray+"::"+modalarray);                                                        
 		  
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>