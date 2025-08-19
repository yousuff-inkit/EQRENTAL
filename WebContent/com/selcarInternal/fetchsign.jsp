<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="net.sf.json.*"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.common.ClsCommon"%>
 <%
System.out.println("in test jsp");
  
	String rdoc="",tst="";
	String msg="";
	int j=0;
	int k=0;
	
	byte b[]=new byte[1000];
ClsConnection  ClsConnection=new ClsConnection();
ClsCommon   ClsCommon =new ClsCommon();
Connection conn=null;
conn = ClsConnection.getMyConnection();  

Blob blob= conn.createBlob();

JSONArray RESULTDATA=new JSONArray();
try
{

/*File file=new File("C:\\Users\\GW-ALAXY\\Desktop\\new img\\image19.png");
FileOutputStream fos=new FileOutputStream(file);*/
  PreparedStatement ps=conn.prepareStatement("select signature from an_signdetails where row_no=1"); 
  ResultSet rs=ps.executeQuery();
   
  while(rs.next()){
		tst=rs.getString("signature");
		System.out.println("blob========="+tst);
		
		
		/*  InputStream input = rs.getBinaryStream("signature");
         byte[] buffer = new byte[1024];
         while (input.read(buffer) > 0) {
             fos.write(buffer);
             } */
	 /*  InputStream stream = rs.getBinaryStream("signature");
	    ByteArrayOutputStream output = new ByteArrayOutputStream();
	    int a1 = stream.read();
	    while (a1 >= 0) {
	      output.write((char) a1);
	      a1 = stream.read(); */
	      
	     /*  blob = rs.getBlob("signature");
	      System.out.println("blob========="+blob);
          long blobLength = blob.length();

          int pos = 1;   // position is 1-based
          int len = 10;
          byte[] bytes = blob.getBytes(pos, len);
          System.out.println("bytes========="+bytes);
          InputStream is = blob.getBinaryStream();
          int f = is.read();

          
         
          fos.write(f);
 */
	  
		
	}
   
  
  

 
  


	
		
 ps.close();

}
catch(Exception e)
{
	e.printStackTrace();

}
finally
{
	conn.close();
}

response.getWriter().write(tst);
%>