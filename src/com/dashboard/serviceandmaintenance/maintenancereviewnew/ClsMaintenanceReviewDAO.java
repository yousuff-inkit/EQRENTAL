package com.dashboard.serviceandmaintenance.maintenancereviewnew;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsMaintenanceReviewDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray serviceHistory(String branch,String fromdate,String todate,String fleetNo,String id) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVehicle = conn.createStatement();
				
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
				String sql = "",sql1 = "",sql11 = "";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				/*if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    		}*/    
				
				if(!(fleetNo.equalsIgnoreCase("0")) && !(fleetNo.equalsIgnoreCase(""))){
					sql11+=" and d.fleet_no="+fleetNo+"";
					sql1+=" and m.fleetno="+fleetNo+"";
		        }
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			    }
				
				sql = "select a.*,v.reg_no from (\r\n" + 
						"select m.brhid,m.date,m.fleetno fleet_no,UCASE(m.mtype) mtype,m.currkm servicekm,m.serduekm nextkm,d.type,d.repdesc description,d.labcost lbrcost,\r\n" + 
						"d.partcost partscost,d.total,d.remarks,g.name garage from gl_vmcostm m left join gl_vcostd d on m.doc_no=d.rdocno left join\r\n" + 
						"gl_garrage g on m.gargid=g.doc_no where m.status=3 "+sql+""+sql1+" UNION ALL\r\n" + 
						"\r\n" + 
						"select m.brhid,m.date,d.fleet_no,'SERVICE' mtype,d.currkm servicekm,d.nextduekm nextkm,'QUICK SERVICE UPDATE' type,CONVERT(CONCAT(if(d.washing=1,'WASHING,',''),\r\n" + 
						"if(d.oil=1,'OIL,',''),if(d.oilfilter=1,'OIL FILTER,',''),if(d.fuelfilter=1,'FUEL FILTER,',''),if(d.airfilter=1,'AIR FILTER','')),\r\n" + 
						"CHAR(100)) description,d.labourcost lbrcost,d.partcost partscost,(d.labourcost+d.partcost) total,m.remarks,g.name garage from\r\n" + 
						"gl_quickservicem m left join gl_quickserviced d on m.doc_no=d.rdocno left join gl_garrage g on m.garageid=g.doc_no where 1=1"+sql+""+sql11+" ) a\r\n" + 
						"left join gl_vehmaster v on a.fleet_no=v.fleet_no";
//				System.out.println("===== "+sql);
				ResultSet resultSet = stmtVehicle.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVehicle.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accidentHistory(String branch,String fromdate,String todate,String fleetNo,String id) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVehicle = conn.createStatement();
				
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
				String sql = "";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				/*if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    		}*/    
				
				if(!(fleetNo.equalsIgnoreCase("0")) && !(fleetNo.equalsIgnoreCase(""))){
					sql+=" and m.rfleet="+fleetNo+"";
		        }
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			    }
				
				sql = "select m.brhid,m.doc_no,m.date,m.polrep policereport,m.coldate collectiondate,m.place,m.fine,if(m.claim=1,'Own','Third Party') claim,\r\n" + 
						"m.remarks,m.rfleet fleet_no,v.reg_no from gl_vinspm m left join gl_vehmaster v on m.rfleet=v.fleet_no where 1=1"+sql+"";
				
				ResultSet resultSet = stmtVehicle.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVehicle.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	public JSONArray vehicleDetailsSearch() throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVehicle = conn.createStatement();  
	        	
				ResultSet resultSet1 = stmtVehicle.executeQuery ("select m.brhid,m.fleet_no,m.flname,m.reg_no,convert(concat(' Fleet : ',coalesce(m.FLEET_NO,''),'  ',coalesce(m.FLNAME,''),'  ',coalesce(REG_NO,''),' * ', 'Authority : ',au.authname,'  ', "
					     + " coalesce(pl.code_name,''),' * ', 'YOM : ',coalesce(y.YOM,''),'  * ', 'Color : ',coalesce(c.color,''), ' * ','Salik Tag : ',coalesce(m.SALIK_TAG,''),' * ',   'Exp ',' ','Reg : ',coalesce(DATE_FORMAT(m.REG_EXP ,'%d-%m-%Y'),''),' * ' , "
					     + "'Ins :' ,coalesce(DATE_FORMAT(m.INS_EXP ,'%d-%m-%Y'),''),' * ', 'Insured at : ' ,coalesce(i.inname,''),' * ',    'Last Service  ', 'Date : ',coalesce(DATE_FORMAT(m.SRVC_DTE ,'%d-%m-%Y'),''),' * ','KM :',coalesce(m.SRVC_KM,''),' * ' , "
					     + " 'Warranty ', 'Date :' ,coalesce(DATE_FORMAT(m.WAR ,'%d-%m-%Y'),''),' * ',   'KM :',coalesce(m.WAR_KM,''),' * ',   'Engine No : ' ,coalesce(m.ENG_NO,''),' * ','Chassis No : ',coalesce(m.CH_NO,'')),char(1000)) vehinfo  "
					     + " from gl_vehmaster m left join gl_vehgroup g on g.doc_no=m.VGRPID   left join my_color c on(m.clrid=c.doc_no) left join gl_yom y on y.doc_no=m.yom   "
					     + "  left join gl_vehauth au on au.doc_no=m.authid  left join  gl_vehplate pl  on pl.doc_no=m.pltid left join gl_vehin i on i.doc_no=m.ins_comp where m.statu=3  order by  m.fleet_no");
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtVehicle.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public  ClsMaintenanceReviewBean getPrint(HttpServletRequest request,int fleetno,String branch,String fromdate,String todate) throws SQLException {
		 ClsMaintenanceReviewBean bean = new ClsMaintenanceReviewBean();
		 Connection conn = null;
			
	        java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement();
			String mainbranch="";
			
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	        }
			
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	        }
			
			if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	        	mainbranch=branch;        	
			}else{
				mainbranch="1";
			}
			
			String headersql="select b.branchname,'Maintanence Review' vouchername,CONCAT('Period From ',DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"' ,'%d-%m-%Y')) vouchername1,"
					+ "c.company,c.address,c.tel,c.tel2,c.email,c.web,c.fax,b.pbno,b.stcno,b.cstno,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
					+ "b.cmpid=c.doc_no where b.doc_no="+mainbranch+" group by brhid";

					ResultSet resultSetHead = stmtVeh.executeQuery(headersql);
					
					while(resultSetHead.next()){
						bean.setLblcompname(resultSetHead.getString("company"));
						bean.setLblcompaddress(resultSetHead.getString("address"));
						bean.setLblprintname(resultSetHead.getString("vouchername"));
						bean.setLblprintname1(resultSetHead.getString("vouchername1"));
						bean.setLblcomptel(resultSetHead.getString("tel"));
						bean.setLblcompfax(resultSetHead.getString("fax"));
						bean.setLblbranch(resultSetHead.getString("branchname"));
						bean.setLbllocation(resultSetHead.getString("location"));
						bean.setLblcstno(resultSetHead.getString("cstno"));
						bean.setLblpan(resultSetHead.getString("pbno"));
						bean.setLblservicetax(resultSetHead.getString("stcno"));
					}
					
			String sql="";
			
			sql="select coalesce(m.fleet_no,'') fleet_no,coalesce(m.flname,'') flname,coalesce(reg_no,'') reg_no,concat(au.authname,'  ',coalesce(pl.code_name,'')) authority,\r\n" + 
					"coalesce(y.yom,'') yom,coalesce(c.color,'') color,coalesce(m.ENG_NO,'') engineno,coalesce(m.CH_NO,'') chassisno from gl_vehmaster m\r\n" + 
					" left join my_color c on(m.clrid=c.doc_no) left join gl_yom y on y.doc_no=m.yom left join gl_vehauth au on au.doc_no=m.authid  left join \r\n" +
					"gl_vehplate pl  on pl.doc_no=m.pltid where m.statu=3 and m.fleet_no="+fleetno+"";
			
			ResultSet resultSet = stmtVeh.executeQuery(sql);
			
			while(resultSet.next()){
							
				bean.setLblfleetno(resultSet.getString("fleet_no"));
				bean.setLblfleetname(resultSet.getString("flname"));
				bean.setLblfleetregno(resultSet.getString("reg_no"));
				bean.setLblfleetauthority(resultSet.getString("authority"));
				bean.setLblfleetyom(resultSet.getString("yom"));
				bean.setLblfleetcolor(resultSet.getString("color"));
				bean.setLblfleetchassisno(resultSet.getString("engineno"));
				bean.setLblfleetengineno(resultSet.getString("chassisno"));
			}
			
			String sql1 = "",sqls="";
			
			if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				sql1+=" and m.brhId="+branch+"";
			}
			
			if(!(sqlFromDate==null)){
	        	sqls+=" and m.date>='"+sqlFromDate+"'";
		    }
	        
	        if(!(sqlToDate==null)){
	        	sqls+=" and m.date<='"+sqlToDate+"'";
		    }
					
			sql1 = "select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,coalesce(m.polrep,'') policereport,coalesce(DATE_FORMAT(m.coldate,'%d-%m-%Y'),'') collectiondate,coalesce(m.place,'') place,round(m.fine,2) fine,if(m.claim=1,'Own','Third Party') claim,\r\n" + 
					"coalesce(m.remarks,'') remarks from gl_vinspm m where m.rfleet="+fleetno+""+sqls+"";

			ResultSet resultSet1 = stmtVeh.executeQuery(sql1);
			
			ArrayList<String> printaccidentarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp1="";
				temp1=resultSet1.getString("date")+"::"+resultSet1.getString("policereport")+"::"+resultSet1.getString("collectiondate")+"::"+resultSet1.getString("place")+"::"+resultSet1.getString("fine")+"::"+resultSet1.getString("claim")+"::"+resultSet1.getString("remarks");
				printaccidentarray.add(temp1);
			}
			request.setAttribute("printaccidentsarray", printaccidentarray);
			
			
			String sql2 = "";
					
			sql2 = "select a.* from (\r\n" + 
					"select DATE_FORMAT(m.date,'%d-%m-%Y') date,m.fleetno fleet_no,UCASE(m.mtype) mtype,round(m.currkm,2) servicekm,round(m.serduekm,2) nextkm,d.type,d.repdesc description,round(d.labcost,2) lbrcost,\r\n" + 
					"round(d.partcost,2) partscost,round(d.total,2) total,d.remarks,g.name garage from gl_vmcostm m left join gl_vcostd d on m.doc_no=d.rdocno left join\r\n" + 
					"gl_garrage g on m.gargid=g.doc_no where m.fleetno="+fleetno+""+sqls+" UNION ALL\r\n" + 
					"\r\n" + 
					"select DATE_FORMAT(m.date,'%d-%m-%Y') date,d.fleet_no,'SERVICE' mtype,round(d.currkm,2) servicekm,round(d.nextduekm,2) nextkm,'QUICK SERVICE UPDATE' type,CONVERT(CONCAT(if(d.washing=1,'WASHING,',''),\r\n" + 
					"if(d.oil=1,'OIL,',''),if(d.oilfilter=1,'OIL FILTER,',''),if(d.fuelfilter=1,'FUEL FILTER,',''),if(d.airfilter=1,'AIR FILTER','')),\r\n" + 
					"CHAR(100)) description,round(d.labourcost,2) lbrcost,round(d.partcost,2) partscost,round((d.labourcost+d.partcost),2) total,m.remarks,g.name garage from\r\n" + 
					"gl_quickservicem m left join gl_quickserviced d on m.doc_no=d.rdocno left join gl_garrage g on m.garageid=g.doc_no where d.fleet_no="+fleetno+""+sqls+") a";

			ResultSet resultSet2 = stmtVeh.executeQuery(sql2);
			
			ArrayList<String> printservicearray= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setSecarray(2);
				String temp2="";
				temp2=resultSet2.getString("date")+"::"+resultSet2.getString("mtype")+"::"+resultSet2.getString("servicekm")+"::"+resultSet2.getString("garage")+"::"+resultSet2.getString("type")+"::"+resultSet2.getString("description")+"::"+resultSet2.getString("remarks")+"::"+resultSet2.getString("lbrcost")+"::"+resultSet2.getString("partscost")+"::"+resultSet2.getString("total");
				printservicearray.add(temp2);
			}
			request.setAttribute("printservicesarray", printservicearray);
			
			stmtVeh.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	  }
	
}
