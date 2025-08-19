
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

System.out.println("Hand First");
	
	
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
	String inspdoc=request.getParameter("inspdoc");
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
	
	/* System.out.println("__"+str[0]); */
	
		
		if(rdtype.equalsIgnoreCase("MOV")){
			rdtype="NRM";
		}	
		String rowno="1";
		for (int f = 0; f < strd.length; f++)
		{
            Statement stmt=conn.createStatement();
			
			String strrowno="select max(rowno)+1 rowno from gl_vinspd where rdocno='"+inspdoc+"'";
			ResultSet rs =stmt.executeQuery(strrowno);
			while(rs.next()){
				rowno=rs.getString("rowno");
			}
			System.out.println("ll:"+strd.length);
			String[] tem=strd[f].split("::");
		if(!(tem[5].equalsIgnoreCase("undefined") || tem[5].isEmpty() || tem[5]==null)){
			String strdamage="insert into gl_vinspd(rowno,rdocno,dmid,type,remarks,attach,dm,fleetno)values('"+rowno+"','"+inspdoc+"','"+(tem[5].equalsIgnoreCase("undefined") || tem[5].isEmpty()?0:tem[5])+"',"+
			"'"+(tem[2].equalsIgnoreCase("undefined") || tem[2].isEmpty()?0:tem[2])+"','"+(tem[3].equalsIgnoreCase("undefined") || tem[3].isEmpty()?0:tem[3])+"','"+(tem[4].equalsIgnoreCase("undefined") || tem[4].isEmpty()?0:tem[4])+"',0,'"+fleet+"')";
			
//			System.out.println("Damage SQL"+strdamage);
			int val1=stmt.executeUpdate(strdamage);
			}
		}
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