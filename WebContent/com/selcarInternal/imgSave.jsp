
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.operations.vehicletransactions.vehicleinspection.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="java.text.SimpleDateFormat" %>


<%

System.out.println("Hand");
	
	
	ClsConnection  ClsConnection=new ClsConnection();
	ClsEncrypt objencrypt=new ClsEncrypt();
	Connection conn=null;
	ClsCommon ClsCommon=new ClsCommon();
	ClsVehicleInspectionDAO inspectionDAO=new ClsVehicleInspectionDAO();
	ArrayList<String> damagearray= new ArrayList();
	ArrayList<String> maintenancearray= new ArrayList();
	ArrayList<String> existdamagearray= new ArrayList();
	
	String str1="";
	
	String user="";
	session.setAttribute("AMTDEC",2);
	session.setAttribute("BRANCHID",1);
	session.setAttribute("USERID",1);
	
	int j=0;
	int k=0;
	int rd=0,val=0;
	String doc="";
	String rdoc="";
	String msg="";
	//String rdoc=request.getParameter("doc");
	String arrayobj=request.getParameter("arrayobj");
	String arraydmg=request.getParameter("arraydmg");
	String type=request.getParameter("hand");
	rdoc=request.getParameter("rdocno");
	rd=Integer.parseInt(rdoc);
	System.out.println("rd====="+rd);
	String userid=request.getParameter("userid");
	String fleet=request.getParameter("fleet");
	String reg=request.getParameter("regfleet");
	String details=request.getParameter("details");
	String inspectid=request.getParameter("selectdoc");
	String rdtype=request.getParameter("rdtype");
	String cmbtype="OUT";
	System.out.println(reg+":"+arrayobj+":"+type+":"+userid+":"+details+":"+inspectid);
	try
	{
	SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
	java.util.Date curDate=new java.util.Date();
	java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
	System.out.println("date====="+cdate); 
	conn=ClsConnection.getMyConnection();
	Statement st=conn.createStatement();
			
	String[] str =arrayobj.split(",");
	String[] strd =arraydmg.split(",");
	for(int i=0;i<strd.length;i++){
		String temp=strd[i];
		damagearray.add(temp);
		System.out.println(damagearray.get(i));
	}
	/* System.out.println("__"+str[0]); */
	
		
		if(rdtype.equalsIgnoreCase("MOV")){
			rdtype="NRM";
		}	
		
		val=inspectionDAO.insert(cdate,cmbtype,rdtype,rd,cdate,"0",cdate,"0","0","0","0","VIP","0","0",session,"A",fleet,damagearray,maintenancearray,existdamagearray,"0",rdoc,"1","1");
		for (int i = 0; i < str.length; i++)
		{
			System.out.println("ll:"+str.length);
			String[] temp=str[i].split("::");
			String cnt=temp[0];
			String classname=temp[1];
			String pos=temp[2];
			//String posy=temp[3];
			String col=temp[3];
			String form=temp[4];
			
			
				
				System.out.println("inside...........");
					CallableStatement stmtt=conn.prepareCall("{call an_imgdetailsDML(?,?,?,?,?,?,?,?,?,?,?)}");
					stmtt.registerOutParameter(10, java.sql.Types.INTEGER);
					stmtt.setString(1,rdoc);
					stmtt.setString(2,fleet);
					stmtt.setString(3,reg);
					stmtt.setString(4,cnt);
					stmtt.setString(5,classname);
					stmtt.setString(6,pos);
					//stmt.setString(7,posy);
					stmtt.setString(7,col);
					stmtt.setString(8,type);
					stmtt.setString(9,userid);
					stmtt.setString(11,form);
					stmtt.executeUpdate();
					j=stmtt.getInt("docno");
					if(j>0)
					{
						doc=Integer.toString(i);
						msg="1";
						System.out.println("inside...........out");
						
					}
					
			
				else
				{
					
					msg="0";
					//System.out.println("Incorrectusername...........");
				}
	 
		
		} 
	}
	catch(Exception e)
	{
		e.printStackTrace();
		
	}
	
	finally
	{
		conn.close();
	}
	
	
	
	
    
	response.getWriter().write(msg+"::"+rdoc+"::"+val);  
%>