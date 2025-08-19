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

	String sql = "select sum(dramount) a ,  sum(dramount- out_amount)b,sum(out_amount) ,acno,count(*),h.atype from my_jvtran j left join my_head h on j.acno=h.doc_no where status=3  group by acno having a!=b ";
	ResultSet rs = stmt.executeQuery(sql);
	while (rs.next()) {
		if(rs.getString("atype").equalsIgnoreCase("AR")){
			arAcno.add(rs.getInt("acno"));	
		}else if(rs.getString("atype").equalsIgnoreCase("AP")){
			apAcno.add(rs.getInt("acno"));
		}
		
	}
	System.out.println("AR ="+arAcno);
	System.out.println("AP ="+apAcno);
	String sqlupdate="";

	
	Statement stmtupd=conn.createStatement();
//	ClsApplyDelete appDel = new ClsApplyDelete();
	for(int i=0;i<arAcno.size()-1;i++){
		System.out.println("=== trno ==== "+arAcno.get(i));
		ArrayList<Integer> arrTrno=new ArrayList<Integer>();
		String sqlselect = "select * from my_jvtran where status=7 and acno=" + arAcno.get(i);
		ResultSet rs1 = stmt.executeQuery(sqlselect);
		while (rs1.next()) {
			arrTrno.add(rs1.getInt("tr_no"));
		}

		
		for(int ii=0;ii<=arrTrno.size()-1;ii++){
			System.out.println("=== trno ==== "+arrTrno.get(ii));
			appDel.getFinanceApplyDelete(conn, arrTrno.get(ii));
		}
		
		// 2nd jvtran is missing
		sqlupdate="delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid left join  my_jvtran J1 on j1.tranid=d.AP_trid  and j1.acno="+arAcno.get(i)+"  where J.status=3 and j.acno="+arAcno.get(i)+" and j.dramount<0 and j.out_amount!=0   and j1.tranid is null ";
		stmtupd.execute(sqlupdate);
		sqlupdate="delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid left join  my_jvtran J1 on j1.tranid=d.tranid  and j1.acno="+arAcno.get(i)+"  where J.status=3 and j.acno="+arAcno.get(i)+"  and j.dramount>0 and j.out_amount!=0   and j1.tranid is null ";
		stmtupd.execute(sqlupdate);
		// 2nd jvtran and 1st jvtran both are same
		sqlupdate="delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid left join  my_jvtran J1 on j1.tranid=d.AP_trid  and j1.acno="+arAcno.get(i)+"  where J.status=3 and j.acno="+arAcno.get(i)+" and j.dramount<0 and j.out_amount!=0   and j1.tranid=j.tranid ";
		stmtupd.execute(sqlupdate);
		sqlupdate="delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid left join  my_jvtran J1 on j1.tranid=d.tranid  and j1.acno="+arAcno.get(i)+"  where J.status=3 and j.acno="+arAcno.get(i)+"  and j.dramount>0 and j.out_amount!=0   and j1.tranid=j.tranid ";
		stmtupd.execute(sqlupdate);
		//outd amoutn is -ve 
		sqlupdate="delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid  where J.status=3 and j.acno="+arAcno.get(i)+" and j.dramount<0 and j.out_amount!=0   and d.amount<0 ";
		stmtupd.execute(sqlupdate);
		sqlupdate="delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid where J.status=3 and j.acno="+arAcno.get(i)+"  and j.dramount>0 and j.out_amount!=0   and d.amount<0 ";
		stmtupd.execute(sqlupdate);
		// jvtran outamount 0 if not reference in outd
		sqlupdate="update my_jvtran j left join  my_outd d on j.tranid=d.tranid set out_amount=0 where status=3 and acno="+arAcno.get(i)+"  and dramount<0 and out_amount!=0  and d.tranid is null ";
		stmtupd.execute(sqlupdate);
		sqlupdate="update my_jvtran j left join  my_outd d on j.tranid=d.ap_trid set out_amount=0 where status=3 and acno="+arAcno.get(i)+"  and dramount>0 and out_amount!=0  and d.tranid is null ";
		stmtupd.execute(sqlupdate);
		
		sqlupdate="update my_jvtran j inner join (select d.tranid,sum(d.amount) amt from my_jvtran j inner join my_outd d on j.tranid=d.tranid  where status=3 and acno="+arAcno.get(i)+" and dramount<0 group by d.tranid) o on j.tranid=o.tranid set j.out_amount=o.amt*j.id where status=3 and acno="+arAcno.get(i)+" and dramount<0 and j.out_amount!=o.amt*j.id";
		stmtupd.execute(sqlupdate);
		sqlupdate="update my_jvtran j inner join (select d.ap_trid,sum(d.amount) amt from my_jvtran j inner join my_outd d on j.tranid=d.ap_trid  where status=3 and acno="+arAcno.get(i)+" and dramount>0 group by d.ap_trid) o on j.tranid=o.ap_trid set j.out_amount=o.amt*j.id where status=3 and acno="+arAcno.get(i)+" and dramount>0 and j.out_amount!=o.amt*j.id";
		stmtupd.execute(sqlupdate);
		
	}
	for(int i=0;i<=apAcno.size()-1;i++){
		System.out.println("=== trno ==== "+apAcno.get(i));
		
		ArrayList<Integer> arrTrno=new ArrayList<Integer>();
		String sqlselect = "select * from my_jvtran where status=7 and acno=" + apAcno.get(i);
		ResultSet rs1 = stmt.executeQuery(sqlselect);
		while (rs1.next()) {
			arrTrno.add(rs1.getInt("tr_no"));
		}

		
		for(int ii=0;ii<=arrTrno.size()-1;ii++){
			System.out.println("=== trno ==== "+arrTrno.get(ii));
			appDel.getFinanceApplyDelete(conn, arrTrno.get(ii));
		}
		
		// 2nd jvtran is missing
		sqlupdate="delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid left join  my_jvtran J1 on j1.tranid=d.AP_trid  and j1.acno="+apAcno.get(i)+"  where J.status=3 and j.acno="+apAcno.get(i)+" and j.dramount>0 and j.out_amount!=0   and j1.tranid is null ";
		stmtupd.execute(sqlupdate);
		sqlupdate="delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid left join  my_jvtran J1 on j1.tranid=d.tranid  and j1.acno="+apAcno.get(i)+"  where J.status=3 and j.acno="+apAcno.get(i)+"  and j.dramount<0 and j.out_amount!=0   and j1.tranid is null ";
		stmtupd.execute(sqlupdate);
		// 2nd jvtran and 1st jvtran both are same
		sqlupdate="delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid left join  my_jvtran J1 on j1.tranid=d.AP_trid  and j1.acno="+apAcno.get(i)+"  where J.status=3 and j.acno="+apAcno.get(i)+" and j.dramount>0 and j.out_amount!=0   and j1.tranid=j.tranid ";
		stmtupd.execute(sqlupdate);
		sqlupdate="delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid left join  my_jvtran J1 on j1.tranid=d.tranid  and j1.acno="+apAcno.get(i)+"  where J.status=3 and j.acno="+apAcno.get(i)+"  and j.dramount<0 and j.out_amount!=0   and j1.tranid=j.tranid ";
		stmtupd.execute(sqlupdate);
		//outd amoutn is -ve 
		sqlupdate="delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid  where J.status=3 and j.acno="+apAcno.get(i)+" and j.dramount>0 and j.out_amount!=0   and d.amount<0 ";
		stmtupd.execute(sqlupdate);
		sqlupdate="delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid where J.status=3 and j.acno="+apAcno.get(i)+"  and j.dramount<0 and j.out_amount!=0   and d.amount<0 ";
		stmtupd.execute(sqlupdate);
		// jvtran outamount 0 if not reference in outd
		sqlupdate="update my_jvtran j left join  my_outd d on j.tranid=d.tranid set out_amount=0 where status=3 and acno="+apAcno.get(i)+"  and dramount>0 and out_amount!=0  and d.tranid is null ";
		stmtupd.execute(sqlupdate);
		sqlupdate="update my_jvtran j left join  my_outd d on j.tranid=d.ap_trid set out_amount=0 where status=3 and acno="+apAcno.get(i)+"  and dramount<0 and out_amount!=0  and d.tranid is null ";
		stmtupd.execute(sqlupdate);
	
		sqlupdate="update my_jvtran j inner join (select d.tranid,sum(d.amount) amt from my_jvtran j inner join my_outd d on j.tranid=d.tranid  where status=3 and acno="+apAcno.get(i)+" and dramount>0 group by d.tranid) o on j.tranid=o.tranid set j.out_amount=o.amt*j.id where status=3 and acno="+apAcno.get(i)+" and dramount>0 and j.out_amount!=o.amt*j.id";
		stmtupd.execute(sqlupdate);
		sqlupdate="update my_jvtran j inner join (select d.ap_trid,sum(d.amount) amt from my_jvtran j inner join my_outd d on j.tranid=d.ap_trid  where status=3 and acno="+apAcno.get(i)+" and dramount<0 group by d.ap_trid) o on j.tranid=o.ap_trid set j.out_amount=o.amt*j.id where status=3 and acno="+apAcno.get(i)+" and dramount<0 and j.out_amount!=o.amt*j.id";
		stmtupd.execute(sqlupdate);
		
	}
	conn.close();
}
catch(Exception e){
	
	e.printStackTrace();
	conn.close();
}
%>
