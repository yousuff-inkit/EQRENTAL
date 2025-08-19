<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="java.sql.Connection"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="com.common.*"%>

<%
Connection conn=null ;
try{
	//String acno = request.getParameter("accountno").toString();
	int trno = 0;
	ArrayList<Integer> arAcno=new ArrayList<Integer>();
	ArrayList<Integer> apAcno=new ArrayList<Integer>();

	ClsApplyDelete appDel = new ClsApplyDelete();
	ClsConnection connection = new ClsConnection();
	conn = connection.getMyConnection();
	Statement stmt = conn.createStatement();

	String sql = "select sum(amount) a ,  sum(amount- outamount)b,sum(outamount) ,clacno,count(*),h.atype from in_opaccountd j left join my_head h on j.clacno=h.doc_no where status=3  group by clacno having a!=b ";
	ResultSet rs = stmt.executeQuery(sql);
	while (rs.next()) {
		if(rs.getString("atype").equalsIgnoreCase("AR")){
			arAcno.add(rs.getInt("clacno"));	
		}else if(rs.getString("atype").equalsIgnoreCase("AP")){
			apAcno.add(rs.getInt("clacno"));
		}
		
	}
	System.out.println("AR ="+arAcno);
	System.out.println("AP ="+apAcno);
	String sqlupdate="";

	
	Statement stmtupd=conn.createStatement();
//	ClsApplyDelete appDel = new ClsApplyDelete();
	for(int i=0;i<=arAcno.size()-1;i++){
		System.out.println("=== trno ==== "+arAcno.get(i));
		ArrayList<Integer> arrTrno=new ArrayList<Integer>();
		/*String sqlselect = "select * from my_jvtran where status=7 and acno=" + arAcno.get(i);
		ResultSet rs1 = stmt.executeQuery(sqlselect);
		while (rs1.next()) {
			arrTrno.add(rs1.getInt("tr_no"));
		}

		
		for(int ii=0;ii<=arrTrno.size()-1;ii++){
			System.out.println("=== trno ==== "+arrTrno.get(ii));
			appDel.getFinanceApplyDelete(conn, arrTrno.get(ii));
		}*/
		
		// 2nd jvtran is missing
		sqlupdate="delete d.* from in_opaccountd j left join  in_opoutd d on j.ROWNO=d.tranid left join  in_opaccountd J1 on j1.ROWNO=d.optrANid and j1.clacno="+arAcno.get(i)+"  where J.status=3 and j.clacno="+arAcno.get(i)+" and j.amount<0 and j.outamount!=0   and j1.rowno is null ";
		stmtupd.execute(sqlupdate);
		sqlupdate="delete d.* from in_opaccountd j left join  in_opoutd d on j.rowno=d.optrANid left join  in_opaccountd J1 on j1.rowno=d.tranid  and j1.clacno="+arAcno.get(i)+"  where J.status=3 and j.clacno="+arAcno.get(i)+"  and j.amount>0 and j.outamount!=0   and j1.rowno is null ";
		stmtupd.execute(sqlupdate);
		// 2nd jvtran and 1st jvtran both are same
		sqlupdate="delete d.* from in_opaccountd j left join  in_opoutd d on j.rowno=d.tranid left join  in_opaccountd J1 on j1.rowno=d.optrANid  and j1.clacno="+arAcno.get(i)+"  where J.status=3 and j.clacno="+arAcno.get(i)+" and j.amount<0 and j.outamount!=0   and j1.rowno=j.rowno ";
		stmtupd.execute(sqlupdate);
		sqlupdate="delete d.* from in_opaccountd j left join  in_opoutd d on j.rowno=d.optrANid left join  in_opaccountd J1 on j1.rowno=d.tranid  and j1.clacno="+arAcno.get(i)+"  where J.status=3 and j.clacno="+arAcno.get(i)+"  and j.amount>0 and j.outamount!=0   and j1.rowno=j.rowno ";
		stmtupd.execute(sqlupdate);
		//outd amoutn is -ve 
		sqlupdate="delete d.* from in_opaccountd j left join  in_opoutd d on j.rowno=d.tranid  where J.status=3 and j.clacno="+arAcno.get(i)+" and j.amount<0 and j.outamount!=0   and d.amount<0 ";
		stmtupd.execute(sqlupdate);
		sqlupdate="delete d.* from in_opaccountd j left join  in_opoutd d on j.rowno=d.optrANid where J.status=3 and j.clacno="+arAcno.get(i)+"  and j.amount>0 and j.outamount!=0   and d.amount<0 ";
		stmtupd.execute(sqlupdate);
		// jvtran outamount 0 if not reference in outd
		sqlupdate="update in_opaccountd j left join  in_opoutd d on j.rowno=d.tranid set outamount=0 where status=3 and clacno="+arAcno.get(i)+"  and j.amount<0 and outamount!=0  and d.tranid is null ";
		stmtupd.execute(sqlupdate);
		sqlupdate="update in_opaccountd j left join  in_opoutd d on j.rowno=d.optrANid set outamount=0 where status=3 and clacno="+arAcno.get(i)+"  and j.amount>0 and outamount!=0  and d.tranid is null ";
		stmtupd.execute(sqlupdate);
		
		sqlupdate="update in_opaccountd j inner join (select d.tranid,sum(d.amount) amt from in_opaccountd j inner join in_opoutd d on j.rowno=d.tranid  where status=3 and clacno="+arAcno.get(i)+" and j.amount<0 group by d.tranid) o on j.rowno=o.tranid set j.outamount=o.amt*if(j.amount<0,-1,1) where status=3 and clacno="+arAcno.get(i)+" and j.amount<0 and if(j.outamount<0,j.outamount*-1,j.outamount) !=o.amt";
		stmtupd.execute(sqlupdate);
		sqlupdate="update in_opaccountd j inner join (select d.optrANid,sum(d.amount) amt from in_opaccountd j inner join in_opoutd d on j.rowno=d.optrANid  where status=3 and clacno="+arAcno.get(i)+" and j.amount>0 group by d.optrANid) o on j.rowno=o.optrANid set j.outamount=o.amt*if(j.amount<0,-1,1)  where status=3 and clacno="+arAcno.get(i)+" and j.amount>0 and if(j.outamount<0,j.outamount*-1,j.outamount)!=o.amt";
		stmtupd.execute(sqlupdate);
		
	}
	
	conn.close();
}
catch(Exception e){
	
	e.printStackTrace();
	conn.close();
}
%>
