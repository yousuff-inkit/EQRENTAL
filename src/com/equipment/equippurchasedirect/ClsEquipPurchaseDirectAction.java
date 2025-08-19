package com.equipment.equippurchasedirect;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.equipment.equippurchaseorder.ClsEquipPurchaseOrderDAO;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;


public class ClsEquipPurchaseDirectAction 

{
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn;

	ClsEquipPurchaseDirectDAO purchaseDirectDAO=new ClsEquipPurchaseDirectDAO();
	ClsEquipPurchaseDirectBean pintbean= new ClsEquipPurchaseDirectBean(); 
	ClsEquipPurchaseDirectBean bean;

	
	private String vehpurorderDate,hidvehpurorderDate,vehpurinvDate,hidvehpurinvDate,vehpuraccname,vehdesc,mode,deleted,msg,formdetailcode;
	private Double txttaxamount,txtnetotal;
	private double epocurrate;
	private String lblcomptrn,lblvendtrn,epocmbcurr,hidcmbcurr,reftype,refno,masterrefno,hidreftype,cmbbilltype,hidcmbbilltype;   
	public String getCmbbilltype() {
		return cmbbilltype;
	}
	public void setCmbbilltype(String cmbbilltype) {
		this.cmbbilltype = cmbbilltype;
	}
	public String getHidcmbbilltype() {
		return hidcmbbilltype;
	}
	public void setHidcmbbilltype(String hidcmbbilltype) {
		this.hidcmbbilltype = hidcmbbilltype;
	}

	private String lblcurrency;

	public String getLblcurrency() {
		return lblcurrency;
	}
	public void setLblcurrency(String lblcurrency) {
		this.lblcurrency = lblcurrency;
	}

private String lbltaxamount,lblnettotal,lbltot;

	public String getLbltot() {
	return lbltot;
}
public void setLbltot(String lbltot) {
	this.lbltot = lbltot;
}

	private String lblvendadd;
	public String getLblvendadd() {
		return lblvendadd;
	}
	public void setLblvendadd(String lblvendadd) {
		this.lblvendadd = lblvendadd;
	}
	public String getHidreftype() {
		return hidreftype;
	}
	public void setHidreftype(String hidreftype) {
		this.hidreftype = hidreftype;
	}
	public double getEpocurrate() {
		return epocurrate;
	}
	public void setEpocurrate(double epocurrate) {
		this.epocurrate = epocurrate;
	}
	public String getEpocmbcurr() {
		return epocmbcurr;
	}
	public void setEpocmbcurr(String epocmbcurr) {
		this.epocmbcurr = epocmbcurr;
	}
	public String getHidcmbcurr() {
		return hidcmbcurr;
	}
	public void setHidcmbcurr(String hidcmbcurr) {
		this.hidcmbcurr = hidcmbcurr;
	}
	public String getReftype() {
		return reftype;
	}
	public void setReftype(String reftype) {
		this.reftype = reftype;
	}
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
	}
	public String getMasterrefno() {
		return masterrefno;
	}
	public void setMasterrefno(String masterrefno) {
		this.masterrefno = masterrefno;
	}
	public String getLblcomptrn() {
		return lblcomptrn;
	}
	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}
	public String getLblvendtrn() {
		return lblvendtrn;
	}
	public void setLblvendtrn(String lblvendtrn) {
		this.lblvendtrn = lblvendtrn;
	}
	public String getLbltaxamount() {
		return lbltaxamount;
	}
	public void setLbltaxamount(String lbltaxamount) {
		this.lbltaxamount = lbltaxamount;
	}
	public String getLblnettotal() {
		return lblnettotal;
	}
	public void setLblnettotal(String lblnettotal) {
		this.lblnettotal = lblnettotal;
	}
	public Double getTxtnetotal() {
		return txtnetotal;
	}
	public void setTxtnetotal(Double txtnetotal) {
		this.txtnetotal = txtnetotal;
	}

	
private String invno;
	public String getInvno() {
	return invno;
}
public void setClsCommon(ClsCommon clsCommon) {
	ClsCommon = clsCommon;
}
public void setPurchaseDirectDAO(ClsEquipPurchaseDirectDAO purchaseDirectDAO) {
	this.purchaseDirectDAO = purchaseDirectDAO;
}
public void setPintbean(ClsEquipPurchaseDirectBean pintbean) {
	this.pintbean = pintbean;
}
public void setBean(ClsEquipPurchaseDirectBean bean) {
	this.bean = bean;
}
	public void setInvno(String invno) {
	this.invno = invno;
}


	private int docno,accid,masterdoc_no,headacccode,vehpurchasegridlenght;
	
	public String getVehpurorderDate() {
		return vehpurorderDate;
	}
	public void setVehpurorderDate(String vehpurorderDate) {
		this.vehpurorderDate = vehpurorderDate;
	}
	public String getHidvehpurorderDate() {
		return hidvehpurorderDate;
	}
	public void setHidvehpurorderDate(String hidvehpurorderDate) {
		this.hidvehpurorderDate = hidvehpurorderDate;
	}
	public String getVehpurinvDate() {
		return vehpurinvDate;
	}
	public void setVehpurinvDate(String vehpurinvDate) {
		this.vehpurinvDate = vehpurinvDate;
	}
	public String getHidvehpurinvDate() {
		return hidvehpurinvDate;
	}
	public void setHidvehpurinvDate(String hidvehpurinvDate) {
		this.hidvehpurinvDate = hidvehpurinvDate;
	}
	public String getVehpuraccname() {
		return vehpuraccname;
	}
	public void setVehpuraccname(String vehpuraccname) {
		this.vehpuraccname = vehpuraccname;
	}
	public String getVehdesc() {
		return vehdesc;
	}
	public void setVehdesc(String vehdesc) {
		this.vehdesc = vehdesc;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	
	public int getAccid() {
		return accid;
	}
	public void setAccid(int accid) {
		this.accid = accid;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public int getHeadacccode() {
		return headacccode;
	}
	public void setHeadacccode(int headacccode) {
		this.headacccode = headacccode;
	}
	
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public int getVehpurchasegridlenght() {
		return vehpurchasegridlenght;
	}
	public void setVehpurchasegridlenght(int vehpurchasegridlenght) {
		this.vehpurchasegridlenght = vehpurchasegridlenght;
	}
	
	//--------print--------
	
	private String lbldate,lbltype,lbldesc1,expdeldate,lblvendoeacc,lblvendoeaccName,lbltotal,lblpurchaseDate,lblinvno,amountinwords;
	
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLbltype() {
		return lbltype;
	}
	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}
	public String getLbldesc1() {
		return lbldesc1;
	}
	public void setLbldesc1(String lbldesc1) {
		this.lbldesc1 = lbldesc1;
	}
	public String getExpdeldate() {
		return expdeldate;
	}
	public void setExpdeldate(String expdeldate) {
		this.expdeldate = expdeldate;
	}
	public String getLblvendoeacc() {
		return lblvendoeacc;
	}
	public void setLblvendoeacc(String lblvendoeacc) {
		this.lblvendoeacc = lblvendoeacc;
	}
	public String getLblvendoeaccName() {
		return lblvendoeaccName;
	}
	public void setLblvendoeaccName(String lblvendoeaccName) {
		this.lblvendoeaccName = lblvendoeaccName;
	}
	public String getLbltotal() {
		return lbltotal;
	}
	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}
	public String getLblpurchaseDate() {
		return lblpurchaseDate;
	}
	public void setLblpurchaseDate(String lblpurchaseDate) {
		this.lblpurchaseDate = lblpurchaseDate;
	}
	public String getLblinvno() {
		return lblinvno;
	}
	public void setLblinvno(String lblinvno) {
		this.lblinvno = lblinvno;
	}
	public String getAmountinwords() {
		return amountinwords;
	}
	public void setAmountinwords(String amountinwords) {
		this.amountinwords = amountinwords;
	}
	public int getLbldoc() {
		return lbldoc;
	}
	public void setLbldoc(int lbldoc) {
		this.lbldoc = lbldoc;
	}
	public int getFirstarray() {
		return firstarray;
	}
	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}
	public int getRowdatascount() {
		return rowdatascount;
	}
	public void setRowdatascount(int rowdatascount) {
		this.rowdatascount = rowdatascount;
	}
	public String getLblcompname() {
		return lblcompname;
	}
	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}
	public String getLblcompaddress() {
		return lblcompaddress;
	}
	public void setLblcompaddress(String lblcompaddress) {
		this.lblcompaddress = lblcompaddress;
	}
	public String getLblcomptel() {
		return lblcomptel;
	}
	public void setLblcomptel(String lblcomptel) {
		this.lblcomptel = lblcomptel;
	}
	public String getLblcompfax() {
		return lblcompfax;
	}
	public void setLblcompfax(String lblcompfax) {
		this.lblcompfax = lblcompfax;
	}
	public String getLblbranch() {
		return lblbranch;
	}
	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}
	public String getLbllocation() {
		return lbllocation;
	}
	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	  private Map<String, Object> param=null;
		
		
		public Map<String, Object> getParam() {
			return param;
		}
		public void setParam(Map<String, Object> param) {
			this.param = param;
		}
		String url;
	    public String getUrl() {
			return url;
		}

		public void setUrl(String url) {
			this.url = url;
		} 
		

	private int lbldoc,firstarray,rowdatascount;
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;
	
	public String saveAction() throws ParseException, SQLException{           
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getVehpurorderDate());
		
		java.sql.Date invDate = ClsCommon.changeStringtoSqlDate(getVehpurinvDate());
		String mode=getMode();
		
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getVehpurchasegridlenght() ;i++){
				String temp2=requestParams.get("vehpurchasetest"+i)[0];
			// String temp2=request.getAttribute("enqtest"+i).toString();
			
				descarray.add(temp2); 
			 
			}
			//System.out.println("fdc====="+getFormdetailcode());
			int val=purchaseDirectDAO.insert(sqlStartDate,invDate,getHeadacccode(),getVehdesc(),session,getMode(),getFormdetailcode(),descarray,getInvno(),request,getTxttaxamount(),getTxtnetotal(),getReftype(),getMasterrefno(),getEpocmbcurr(),getEpocurrate(),getCmbbilltype());
			int vdocno=(int) request.getAttribute("vocno");  
			if(val>0){
				 setHidvehpurorderDate(sqlStartDate.toString());
				 setHidvehpurinvDate(invDate.toString());
				 setData();
				 setDocno(vdocno);
				 setMasterdoc_no(val);
				 setMsg("Successfully Saved");
				 return "success";
			}
			else{
				setMsg("Not Saved");
				setHidvehpurorderDate(sqlStartDate.toString());
				setHidvehpurinvDate(invDate.toString());
				setData();
				setDocno(vdocno);
				setMasterdoc_no(val);
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("E")){
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getVehpurchasegridlenght() ;i++){
				String temp2=requestParams.get("vehpurchasetest"+i)[0];
			
				descarray.add(temp2); 
			 
			}
			boolean Status=purchaseDirectDAO.edit(getMasterdoc_no(),getDocno(),sqlStartDate,invDate,getHeadacccode(),getVehdesc(),session,getMode(),getFormdetailcode(),descarray,getInvno(),request,getTxttaxamount(),getTxtnetotal(),getReftype(),getMasterrefno(),getEpocmbcurr(),getEpocurrate(),getCmbbilltype());
			if(Status){
				 setHidvehpurorderDate(sqlStartDate.toString());
				 setHidvehpurinvDate(invDate.toString());
				 setData();
				 setDocno(getDocno());
				 setMasterdoc_no(getMasterdoc_no());
				 setMsg("Updated Successfully");
				 return "success";
			}
			else{
				setMsg("Not Updated");
				setHidvehpurorderDate(sqlStartDate.toString());
				setHidvehpurinvDate(invDate.toString());
				setData();
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("view")){
			setHidvehpurorderDate(sqlStartDate.toString());
			setHidvehpurinvDate(invDate.toString());
		}
	
	else if(mode.equalsIgnoreCase("D")){
		boolean Status=purchaseDirectDAO.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode());
	if(Status){
		 setHidvehpurorderDate(sqlStartDate.toString());
			setHidvehpurinvDate(invDate.toString());
			setData();
		setDeleted("DELETED");
		setMsg("Successfully Deleted");
		return "success";
	}
	else{
		setData();
		setMsg("Not Deleted");
		return "fail";
	}
	}
	return "fail";
	} // method
	
	public void setData() {
		setMode("view");
		setAccid(getAccid());
		setVehpuraccname(getVehpuraccname());
		setHeadacccode(getHeadacccode());
		setVehdesc(getVehdesc());
		setDocno(getDocno());
		setRefno(getRefno());
		setReftype(getReftype());
		setEpocmbcurr(getEpocmbcurr());
		setEpocurrate(getEpocurrate()); 
		setHidcmbcurr(getEpocmbcurr());  
		setMasterrefno(getMasterrefno()); 
		setHidreftype(getReftype());
		setTxttaxamount(getTxttaxamount());
		setTxtnetotal(getTxtnetotal());
		setHidcmbbilltype(getCmbbilltype());  

	}
	public String printAction() throws ParseException, SQLException{
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpServletResponse response=ServletActionContext.getResponse();   
//System.out.println("PRINT ACTION==============");
		  HttpSession session=request.getSession();
			 String user= session.getAttribute("USERID").toString();

		 int doc=Integer.parseInt(request.getParameter("docno"));
		 pintbean=purchaseDirectDAO.getPrint(doc,request);
		// ArrayList<String> arraylist = ClsvehpurchaseDAO.getPrintdetails(doc);
		  //cl details
		 setLblprintname("Equipment Purchase Direct");
		    setLbldoc(pintbean.getLbldoc());
	    setLbldate(pintbean.getLbldate());
	      setLbltype(pintbean.getLbltype());

	    setLbldesc1(pintbean.getLbldesc1());
		 setLblvendoeacc(pintbean.getLblvendoeacc());
		 setLblvendoeaccName(pintbean.getLblvendoeaccName());
		setLblvendtrn(pintbean.getLblvendtrn());
	  setLblbranch(pintbean.getLblbranch());
	   setLblcompname(pintbean.getLblcompname());
	  setLblcompaddress(pintbean.getLblcompaddress());
	   setLblcomptel(pintbean.getLblcomptel());
	  setLblcompfax(pintbean.getLblcompfax());
	   setLbllocation(pintbean.getLbllocation());
	  setLbltotal(pintbean.getLbltotal());
	  setLblcomptrn(pintbean.getLblcomptrn());
	  setLblinvno(pintbean.getLblinvno());
	  setLblpurchaseDate(pintbean.getLblpurchaseDate());
	  setLbltaxamount(pintbean.getLbltaxamount());
	  setLblnettotal(pintbean.getLblnettotal());
		setLblvendadd(pintbean.getLblvendadd());
		setLbltot(pintbean.getLbltot());
		setLblcurrency(pintbean.getLblcurrency());

	//	System.out.println("-------"+pintbean.getAmountinwords());
		setAmountinwords(pintbean.getAmountinwords());
		
		 String brcid = session.getAttribute("BRANCHID").toString();
	      String branch = request.getParameter("branch");
		 String brhid=request.getParameter("brhid");
		 String userid=request.getParameter("userid")==null || request.getParameter("userid")==""?"0":request.getParameter("userid").trim().toString();              
		 String dtype=request.getParameter("dtype");
		 //int header=Integer.parseInt(request.getParameter("header")) ;
		 ClsEquipPurchaseOrderDAO ClsEquipPurchaseOrderDAO=new ClsEquipPurchaseOrderDAO();      
	  	 setUrl(ClsCommon.getPrintPath(dtype));
	  	 conn=ClsConnection.getMyConnection();
	  	Statement stmt=conn.createStatement();
	  	String username="";
	  	String sql3 = "select coalesce(user_name,'') user_name  from my_user where doc_no='"+user+"'";   
		ResultSet resultSet3 = stmt.executeQuery(sql3);                                                
		while(resultSet3.next()){
			username=resultSet3.getString("user_name");                            
		}
		//System.out.println("username----->"+username);
		//System.out.println("vendortrn----->"+pintbean.getLblventrnno());

		
		dtype="EPD";
                      if(ClsCommon.getPrintPath("EPD").contains(".jrxml")==true)
						{				   
						  String lbltel="Tel",lblfax="Fax",lblloc="Loaction",lblbrch="Branch",lbltrno="TRN NO";           
						//System.out.println("in iffff");   
	 						
							 String	strSqldetail2="select @i:=@i+1 as srno,a.* from ("
												+" select desc1 description,round(unitprice,2)  unitprice,round(qty,2) qty,round(total,2) total,round(discount,2)"
												+" discount ,round(nettotal,2) nettotal from my_ordser     where rdocno='"+doc+"') a,(select @i:=0) r";
						    ClsConnection conobj=new ClsConnection();
							
							 param = new HashMap();
							 Connection conn = null;
							 conn = conobj.getMyConnection();
						     
							 String reportFileName = "equippurchasedirect";
							 
							 String brchid=request.getParameter("brhid");
							 try {
						        param.put("serviceqry",strSqldetail2);   
						        param.put("brhid", brchid);
						       
						       String path1="",brhiid="",brchaddress="",brchname="",brchtel="",brchfax="",brchtinno="",branchid=""; 
					       		String strsql2="select imgpath,tinno,branch,branchname,address,tel,fax from my_brch where doc_no='"+brcid+"'";       
						   	    ResultSet rs2=stmt.executeQuery(strsql2);          
						   	    while(rs2.next()){  
						   	    	branchid=rs2.getString("branch");
						   	    	 brchname=rs2.getString("branchname");
						   	    	 path1=rs2.getString("imgpath");  
						   	    	 brchaddress=rs2.getString("address");
						   	    	 brchtel=rs2.getString("tel");
						   	    	 brchfax=rs2.getString("fax");
						   	    	 brchtinno=rs2.getString("tinno");
						   	    }
						   	    param.put("branchaddress", brchaddress); 
					            param.put("brchname",brchname);
					            param.put("brchaddress", brchaddress);
					            param.put("brchtel",brchtel);
					            param.put("brchfax", brchfax);
					            param.put("compnytrno",  brchtinno);
						          
						          String imgpathemirates=request.getSession().getServletContext().getRealPath("/icons/complogo.jpeg");   
						          imgpathemirates=imgpathemirates.replace("\\", "\\\\");    
						          param.put("emirateslogo", imgpathemirates);
						          
						          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
						          imgpath2=imgpath2.replace("\\", "\\\\");    
						          param.put("imgfooterpath", imgpath2);
						          
						          String strSqldetail="";
						  		
						          strSqldetail=("select rq.sr_no srno, rq.fleet_no,coalesce(v.reg_no,'') assetid,vb.brand_name brand,vm.vtype model,coalesce(vc.color,'') color,coalesce(rq.chaseno,'') chasisno,coalesce(rq.enginno,'') engineno,coalesce(v.flname,'') assetdesc ,"
									 		+ " round(rq.puch_cost,2) puch_cost,round(rq.add_cost,2) add_cost,round((rq.puch_cost+rq.add_cost),2) as price,round(rq.tax_perc,2) taxper,round(rq.tax_amt,2) taxamount,round(rq.net_total,2) total from eq_vpurdird rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
									 		+ "left join gl_vehmodel vm on vm.doc_no=rq.MODID left join my_color vc on vc.doc_no=rq.clrid "
									 		+ "left join gl_equipmaster v on v.fleet_no=rq.fleet_no where rq.rdocno="+doc+" ");
				//	  System.out.println("ttotal===="+pintbean.getLbltot());
						          
						          String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
					               imgpath=imgpath.replace("\\", "\\\\");
					              // System.out.println("brchid===="+branchid);
					               if(branchid.equalsIgnoreCase("01")){
										//System.out.println("brhid2==="+brhid);
										String branch1header = request.getSession().getServletContext().getRealPath("/icons/branch1header.jpg");
										branch1header =branch1header.replace("\\", "\\\\");	
										String branch1footer = request.getSession().getServletContext().getRealPath("/icons/branch1footer.jpg");
										branch1footer =branch1footer.replace("\\", "\\\\");
										param.put("branchheader", branch1header);
										param.put("branchfooter", branch1footer);
							//			System.out.println("brhid2==="+brcid);
									}
									
									else if(branchid.equalsIgnoreCase("02")){
										String branch2header = request.getSession().getServletContext().getRealPath("/icons/branch2header.jpg");
										branch2header =branch2header.replace("\\", "\\\\");	
										String branch2footer = request.getSession().getServletContext().getRealPath("/icons/branch2footer.jpg");
										branch2footer =branch2footer.replace("\\", "\\\\");
										param.put("branchheader", branch2header);
										param.put("branchfooter", branch2footer);
									}
									else if(branchid.equalsIgnoreCase("03")){
										String branch3header = request.getSession().getServletContext().getRealPath("/icons/branch3header.jpg");
										branch3header =branch3header.replace("\\", "\\\\");	
										String branch3footer = request.getSession().getServletContext().getRealPath("/icons/branch3footer.jpg");
										branch3footer =branch3footer.replace("\\", "\\\\");
										param.put("branchheader", branch3header);
										param.put("branchfooter", branch3footer);
									} 
					               
						        	  String imgpath111=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
						        	  String imgpath222=imgpath111.replace("\\", "\\\\");    
							          param.put("imgpathemirates", imgpath222); 
							          param.put("lbltel", lbltel); 
							          param.put("lblfax", lblfax); 
							          param.put("lblloc", lblloc); 
							          param.put("lblbrch", lblbrch); 
							          param.put("lbltrno", lbltrno); 
							          param.put("comploc", pintbean.getLbllocation());   
							          param.put("compname", pintbean.getLblcompname()); 
							          param.put("compaddress", pintbean.getLblcompaddress());
							          param.put("comptel", pintbean.getLblcomptel());
							          param.put("compfax", pintbean.getLblcompfax());
							        //  param.put("compnytrno", pintbean.getLblcomptrn());  
							          param.put("compbrch", pintbean.getLblbranch());  
							          param.put("date", pintbean.getLbldate());  
							          param.put("type", pintbean.getLbltype()); 						
							          param.put("invno", pintbean.getLblinvno());  
							          param.put("purdate", pintbean.getLblpurchaseDate());  
							          param.put("description", pintbean.getLbldesc1()); 
							          param.put("docno", pintbean.getLbldoc());  
							          param.put("vendor", pintbean.getLblvendoeaccName());  
							          param.put("vendorno", pintbean.getLblvendoeacc());
							          param.put("vendortrn", pintbean.getLblvendtrn()); 
							          param.put("vendoradd", pintbean.getLblvendadd());
							          param.put("username", username);
							          param.put("imgpath", imgpath);
							          param.put("ttotalamnt", pintbean.getLbltot());
							          param.put("taxamnt", pintbean.getLbltaxamount());  
							          param.put("tnetamount",pintbean.getLblnettotal());
							          param.put("brcid", brcid);
							          param.put("productQuery",  strSqldetail);
							          param.put("currency",pintbean.getLblcurrency());
							          param.put("tamountwords", pintbean.getAmountinwords().replace("AED",pintbean.getLblcurrency()));
										/*
										 * param.put("paymentterms", pintbean.getLblpayterms());
										 * param.put("paymentmode", pintbean.getLblpaymode());
										 * param.put("deliveryterms", pintbean.getLbldelterms());
										 */ 
							          String fire7imgpath=request.getSession().getServletContext().getRealPath("/icons/fire7fullheader.jpg");
						           fire7imgpath=fire7imgpath.replace("\\", "\\\\");
						           param.put("fire7fullheadderpath", fire7imgpath);
							        setUrl(ClsCommon.getPrintPath(dtype));
							  
							        String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/header.jpg");
							        headerimgpath=headerimgpath.replace("\\", "\\\\");
							           param.put("headerpath", headerimgpath); 
							    //    System.out.println(ClsCommon.getPrintPath(dtype));
				              JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/equipment/equippurchasedirect/"+ClsCommon.getPrintPath(dtype)));
				              JasperReport jasperReport = JasperCompileManager.compileReport(design);
				              generateReportPDF(response, param, jasperReport, conn);
							  } catch (Exception e) {  
							       e.printStackTrace();
							   } finally{
											 conn.close();
							  }
					 }	
		
		
		
		
		
		
		 return "print";
		 }
	
	
	private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
		  byte[] bytes = null;
	    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
	      resp.reset();
	    resp.resetBuffer();
	    
	    resp.setContentType("application/pdf");
	    resp.setContentLength(bytes.length);
	    ServletOutputStream ouputStream = resp.getOutputStream();
	    ouputStream.write(bytes, 0, bytes.length);
	   
	    ouputStream.flush();
	    ouputStream.close();
	}  

	
	public Double getTxttaxamount() {
		return txttaxamount;
	}
	public void setTxttaxamount(Double txttaxamount) {
		this.txttaxamount = txttaxamount;
	}
} //class
