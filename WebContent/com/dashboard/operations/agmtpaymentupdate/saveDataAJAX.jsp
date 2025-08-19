<%@page import="com.connection.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
Connection conn=null;
int errorstatus=0;
String strdataarray=request.getParameter("dataarray")==null?"":request.getParameter("dataarray");
String deletedrows=request.getParameter("deletedrows")==null?"":request.getParameter("deletedrows");
String selectedagmtno=request.getParameter("selectedagmtno")==null?"":request.getParameter("selectedagmtno");

ArrayList<String> dataarray=new ArrayList();
String[] temparray=strdataarray.split(",");
for(int i=0;i<temparray.length;i++){
	dataarray.add(temparray[i]);
}
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	if(!deletedrows.equalsIgnoreCase("")){
		String strdeletelease="update gl_leasepytcalc set status=7 where srno in ("+deletedrows+")";
		System.out.println(strdeletelease);
		int deletelease=stmt.executeUpdate(strdeletelease);
		if(deletelease<0){
			System.out.println("Lease Pyt Calc Delete Error");
			errorstatus=1;
		}
		String strgetbranch="select brhid from gl_lagmt where doc_no="+selectedagmtno;
		System.out.println(strgetbranch);
		int brhid=0;
		ResultSet rsgetbranch=stmt.executeQuery(strgetbranch);
		while(rsgetbranch.next()){
			brhid=rsgetbranch.getInt("brhid");
		}
		String strdeletemaster="update my_unclrchqreceiptm set status=7 where doc_no in ("+deletedrows+") and brhid ="+brhid;
		System.out.println(strdeletemaster);
		int deletemaster=stmt.executeUpdate(strdeletemaster);
		if(deletemaster<0){
			System.out.println("Uncleared Cheque Master Delete Error");
			errorstatus=1;
		}
	}
	for(int i=0;i<dataarray.size();i++){
		System.out.println(dataarray.get(i));
		String data[]=dataarray.get(i).split("::");
		String strupdatelease="update gl_leasepytcalc set date='"+objcommon.changeStringtoSqlDate(data[6])+"',amount="+data[1]+" where srno="+data[5];
		System.out.println(strupdatelease);
		int updatelease=stmt.executeUpdate(strupdatelease);
		if(updatelease<0){
			System.out.println("Lease Pyt Calc Update Error");
			errorstatus=1;
			break;
		}
		if(Integer.parseInt(data[4].equalsIgnoreCase("")?"0":data[4])>0){
			String strgetbranch="select brhid from gl_lagmt where doc_no="+selectedagmtno;
			System.out.println(strgetbranch);
			int brhid=0;
			ResultSet rsgetbranch=stmt.executeQuery(strgetbranch);
			while(rsgetbranch.next()){
				brhid=rsgetbranch.getInt("brhid");
			}
			String strdeletemaster="update my_unclrchqreceiptm set totalamount="+data[1]+" where doc_no="+data[4]+" and brhid ="+brhid;
			System.out.println(strdeletemaster);
			int deletemaster=stmt.executeUpdate(strdeletemaster);
			if(deletemaster<0){
				System.out.println("Uncleared Cheque Master Update Error");
				errorstatus=1;
			}
			String strdeletedetail="update my_unclrchqreceiptd set amount="+data[1]+",lamount="+data[1]+"*dr where rdocno="+data[4]+" and brhid ="+brhid;
			System.out.println(strdeletedetail);
			int deletedetail=stmt.executeUpdate(strdeletedetail);
			if(deletedetail<0){
				System.out.println("Uncleared Cheque Detail Update Error");
				errorstatus=1;
			}
		}
	}
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>