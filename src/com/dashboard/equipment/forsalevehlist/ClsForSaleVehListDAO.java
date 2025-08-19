package com.dashboard.equipment.forsalevehlist;

import com.connection.*;
import com.common.*;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsForSaleVehListDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getVehListData(String branch,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest+=" and m.a_br="+branch;
			}
			String sqldata=("select 'Security Pass' securitypass,convert((SELECT DATEDIFF(m.ins_exp,"+
			" curdate())),char(20)) AS days,m.doc_no,m.a_br branchid,m.VGRPID groupid,br.branchname,m.FLEET_NO,m.FLNAME,m.REG_NO,v.kmin,"+
			" m.SRVC_KM+m.lst_srv SRVC_KM,y.YOM,m.renttype renttype,    CASE WHEN v.fin='0.000' THEN 'Level 0/8' WHEN v.fin='0.125' THEN"+
			" 'Level 1/8' WHEN v.fin='0.250'  THEN 'Level 2/8' WHEN v.fin='0.375' 	THEN 'Level 3/8' WHEN v.fin='0.500' THEN 'Level 4/8' WHEN"+
			" v.fin='0.625' THEN 'Level 5/8'  WHEN v.fin='0.750' THEN 'Level 6/8' WHEN v.fin='0.875' THEN 'Level 7/8' WHEN v.fin='1.000' THEN"+
			" 'Level 8/8'  END as 'fin',l.LOC_NAME,g.gname,c.color,b.brand_name, round(TIMESTAMPDIFF(hour,cast(concat(din,' ',tin)as datetime),"+
			" cast(now() as datetime))/24,2) idealdys from"+
			" gl_vehmaster m  inner join gl_vmove v on v.fleet_no=m.fleet_no and m.tran_code='FS'  inner  join   (select max(doc_no) maxd,fleet_no"+
			" from gl_vmove group by fleet_no) a  on v.doc_no=a.maxd and v.fleet_no=a.fleet_no 	left join my_locm l on l.doc_no=m.A_LOC  left"+
			" join gl_vehgroup g on g.doc_no=m.VGRPID  	left join my_color c on(m.clrid=c.doc_no)  left join gl_vehbrand b on(m.brdid=b.doc_no)"+
			" left join my_brch br on br.doc_no=m.a_br left join gl_yom y on y.doc_no=m.yom  where m.statu=3 and m.tran_code='FS' and m.fstatus<>'Z'"+sqltest+" "); 
			System.out.println(sqldata);
			ResultSet rs=stmt.executeQuery(sqldata);
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
	
	public JSONArray getVehListDataExcel(String branch,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest+=" and m.a_br="+branch;
			}
			String sqldata=("select br.branchname 'Avail.Br',l.LOC_NAME 'Location',g.gname 'Group',b.brand_name 'Brand',m.FLEET_NO 'Fleet No',"+
			" m.FLNAME 'Fleet Name',y.YOM 'Yom',c.color 'Color',m.REG_NO 'Asset id',v.kmin 'Curr.Km',m.SRVC_KM+m.lst_srv 'Due Serv.Km',"+
			" CASE WHEN v.fin='0.000' THEN 'Level 0/8' WHEN v.fin='0.125' THEN"+
			" 'Level 1/8' WHEN v.fin='0.250'  THEN 'Level 2/8' WHEN v.fin='0.375' 	THEN 'Level 3/8' WHEN v.fin='0.500' THEN 'Level 4/8' WHEN"+
			" v.fin='0.625' THEN 'Level 5/8'  WHEN v.fin='0.750' THEN 'Level 6/8' WHEN v.fin='0.875' THEN 'Level 7/8' WHEN v.fin='1.000' THEN"+
			" 'Level 8/8'  END as 'Fuel',m.renttype 'Rent Type',round(TIMESTAMPDIFF(hour,cast(concat(din,' ',tin)as datetime),"+
			" cast(now() as datetime))/24,2) 'Idle Days' from"+
			" gl_vehmaster m  inner join gl_vmove v on v.fleet_no=m.fleet_no and m.tran_code='FS'  inner  join   (select max(doc_no) maxd,fleet_no"+
			" from gl_vmove group by fleet_no) a  on v.doc_no=a.maxd and v.fleet_no=a.fleet_no 	left join my_locm l on l.doc_no=m.A_LOC  left"+
			" join gl_vehgroup g on g.doc_no=m.VGRPID  	left join my_color c on(m.clrid=c.doc_no)  left join gl_vehbrand b on(m.brdid=b.doc_no)"+
			" left join my_brch br on br.doc_no=m.a_br left join gl_yom y on y.doc_no=m.yom  where m.statu=3 and m.tran_code='FS'  and m.fstatus<>'Z'"+sqltest+" "); 
			System.out.println(sqldata);
			ResultSet rs=stmt.executeQuery(sqldata);
			data=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	public JSONArray getVehData(String id) throws SQLException{
		JSONArray data=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select pl.code_name,m.fleet_no,m.flname,m.reg_no,convert(concat(' Fleet ',"+
			" coalesce(m.FLEET_NO,''),'  ',coalesce(m.FLNAME,''),'  ',coalesce(REG_NO,''),   ' * ', au.authname,'  ',"+
			" coalesce(pl.code_name,''),' * ', 'YOM  ',coalesce(y.YOM,''),'   ',coalesce(c.color,''), ' * ','Salik Tag   ',"+
			" coalesce(m.SALIK_TAG,''),' * ',   'Exp ',' ','Reg : ',coalesce(m.REG_EXP,''),'  ' ,"+
			" 'Ins :' ,coalesce(m.INS_EXP,''),' * ', 'Insured at  ' ,coalesce(i.inname,''),' * ',    'Last Service  ', 'Date : ',"+
			" coalesce(m.SRVC_DTE,''),' ',' KM :',coalesce(m.SRVC_KM,''),' * ' ,"+
			" 'Warranty ', 'Date :' ,coalesce(m.WAR,''),'     ',   'KM :',coalesce(m.WAR_KM,''),' * ',   'Engine NO  ' ,coalesce(m.ENG_NO,''),"+
			" ' * ','Chassis NO ',coalesce(m.CH_NO,''),' * '),char(1000)) vehinfo"+
			" from gl_vehmaster m left join gl_vehgroup g on g.doc_no=m.VGRPID   left join my_color c on(m.clrid=c.doc_no) left join gl_yom y on y.doc_no=m.yom"+
			" left join gl_vehauth au on au.doc_no=m.authid  left join  gl_vehplate pl  on pl.doc_no=m.pltid left join gl_vehin i on i.doc_no=m.ins_comp where m.statu=3  order by  m.fleet_no";
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
