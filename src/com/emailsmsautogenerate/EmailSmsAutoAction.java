package com.emailsmsautogenerate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.TimerTask;
import java.util.logging.Logger;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.vehicle.readytorent.ClsReadyToRentAction;
import com.mailwithpdf.SendEmailAction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

public class EmailSmsAutoAction extends TimerTask {

	private static final Logger log = Logger.getLogger( EmailSmsAutoAction.class.getName() );

	private static final String JAVASCRIPT_SRC = 
			" var impl = { " +
					"     run: function() { " +
					"         println ('Hello, World!'); " +
					"     } " +
					" }; ";
	
	ClsConnection connobj=new  ClsConnection();
	ClsCommon com= new ClsCommon();
	ClsReadyToRentAction rtraction=new ClsReadyToRentAction();
	SendEmailAction sendmail=new SendEmailAction();
	
	public String process() throws ParseException, SQLException{
		
		Connection conn = connobj.getMyConnection();
		boolean result=false;

		//HttpServletRequest request=ServletActionContext.getRequest();
		//HttpSession session=request.getSession();
			
			try{
				
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpSession session=request.getSession();
			    HttpServletResponse response = ServletActionContext.getResponse();
			    Statement stmt = conn.createStatement();
			    
			    String userid=session.getAttribute("USERID").toString();
			    
			    String strSql = "select dtype,loadcond,emails from  gl_prjemail where status=3";
				ResultSet rs = stmt.executeQuery(strSql);
				
				String loadCondQuery="",email="";
				while(rs.next()) {
					loadCondQuery=rs.getString("loadcond");
					email=rs.getString("emails");
					
					Statement stmt1 = conn.createStatement();
					
					String strSql1 = loadCondQuery;
					ResultSet rs1 = stmt1.executeQuery(strSql1);
					
					String docno="",branch="",voucherno="",formdetailcode="",refid="";
					while(rs1.next()) {
						docno=rs1.getString("docno");
						branch=rs1.getString("brhid");
						voucherno=rs1.getString("voucherno");
						formdetailcode=rs1.getString("dtype");
						
						String msg="<html>"
								+ "	<table >"
								+ "		<tr>"
								+ "			<td> Dear Sir <br><br>"
								+ "			     Please Check this Voucher <<Vocher>>."
								+ "			</td>"
								+ "		</tr>"
								+ "	</table>"
								+ "</html>";
						msg = msg.replace("<<Vocher>>", voucherno);
												
					//	File saveFile;
					//	sendmail.AutoSendMailwithHTML( null ,formdetailcode, email ,  docno,  branch ,  userid ,  refid ,  msg);
						
						stmt1.close();
					} 
				}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return "success";
	}

	@Override
	public void run() {
		
		Connection conn = connobj.getMyConnection();
		String result="";

		//HttpServletRequest request=ServletActionContext.getRequest();
		//HttpSession session=request.getSession();
			
		try{
			rtraction.emailAction();
		}
		catch(Exception e){
			e.printStackTrace();
			result="fail";
		}
		finally{
		}

		result="success";
		
	}
	
	

}
