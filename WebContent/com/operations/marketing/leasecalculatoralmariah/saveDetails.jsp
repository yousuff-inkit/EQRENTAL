<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
Connection conn = null;
ClsConnection objconn=new ClsConnection();
int returnval=0;
try{
	String list=request.getParameter("list").equalsIgnoreCase("")?null:request.getParameter("list");
	String srno=request.getParameter("srno").equalsIgnoreCase("")?null:request.getParameter("srno");
	String leasereqdocno=request.getParameter("leasereqdocno").equalsIgnoreCase("")?null:request.getParameter("leasereqdocno");
	String docno=request.getParameter("docno").equalsIgnoreCase("")?null:request.getParameter("docno");

	
	ArrayList<String> mainarray= new ArrayList<String>();

	String aa[]=list.split(",");
	for(int i=0;i<aa.length;i++){
		 String bb[]=aa[i].split("::");
		 String temp="";
		 for(int j=0;j<bb.length;j++){
			 temp=temp+bb[j]+"::";
		}
		 mainarray.add(temp);
		// mainarrays.add(mainarray);
	 }
	int val=0;
	int flag=0;
	conn=objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	conn.setAutoCommit(false);
	int val1=stmt.executeUpdate("delete from gl_almariahcalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno);
	System.out.println(val1);
	for(int k=0;k<mainarray.size();k++)
	{
		String[] serarray=mainarray.get(k).split("::");  
	     if(!(serarray[1].trim().equalsIgnoreCase("undefined")|| serarray[1].trim().equalsIgnoreCase("null")|| serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()))
	     {
	     String sql2="INSERT INTO gl_almariahcalcd(rowno, rdocno, leasereqdocno, srno, detaildocno, amount, status)VALUES"
	  	           + " ("+(k+1)+","
	  	           + "'"+docno+"',"
	  	           + "'"+leasereqdocno+"',"
	  	           + "'"+srno+"',"
			       + "'"+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("null") || serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"',"
			       + "'"+(serarray[1].trim().equalsIgnoreCase("undefined") || serarray[1].trim().equalsIgnoreCase("null") || serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()?0:serarray[1].trim())+"',"
			       +"3)";

	      val = stmt.executeUpdate(sql2);
	      if(val<=0){
	    	  flag=1;
	    	  break;
	      }
	      System.out.println(val);
	     System.out.println(sql2);
		}
	} 
	if(flag==1){
		returnval=0;
	}
	else{
		conn.commit();
		returnval=1;
	}
	
stmt.close();

}
catch(Exception e){
	e.printStackTrace();
	returnval=0;	
}
finally{
	conn.close();
}
response.getWriter().write(returnval+"");
 %>