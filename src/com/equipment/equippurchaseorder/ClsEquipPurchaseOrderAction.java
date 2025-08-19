package com.equipment.equippurchaseorder;

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
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.equipment.equippurchaseorder.ClsEquipPurchaseOrderDAO;
import com.equipment.equippurchaserequest.ClsEquipPurchaseRequestDAO;
import com.procurement.purchase.purchaseorder.ClspurchaseorderDAO;

@SuppressWarnings("serial")
public class ClsEquipPurchaseOrderAction extends HttpServlet {
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn;

	ClsEquipPurchaseOrderDAO purchaseorderDAO= new ClsEquipPurchaseOrderDAO(); 
	ClsEquipPurchaseOrderBean pintbean = new ClsEquipPurchaseOrderBean();
	
	private String vehpurorderDate,hidvehpurorderDate,accid,vehpuraccname,headacccode,vehtype,vehrefno,vehpurorderdelDate,hidvehpurorderdelDate,vehdesc;
	private double epocurrate;
	private int  docno,vehoredergridlenght;
	private String masterrefno,brchName,txtdelterms,txtpayterms,txtpaymode;
	private int masterdoc_no;
	private String deleted,mode,msg,formdetailcode,vehtypeval,epocmbcurr,hidcmbcurr,totalamountwords,currency;  
	
	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getTotalamountwords() {
		return totalamountwords;
	}

	public void setTotalamountwords(String totalamountwords) {
		this.totalamountwords = totalamountwords;
	}
	public String getHidcmbcurr() {
		return hidcmbcurr;
	}
	public void setHidcmbcurr(String hidcmbcurr) {
		this.hidcmbcurr = hidcmbcurr;
	}
	String url;
    public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	} 
	
	public String getEpocmbcurr() {
		return epocmbcurr;
	}
	public void setEpocmbcurr(String epocmbcurr) {
		this.epocmbcurr = epocmbcurr;
	}
	 


	public double getEpocurrate() {
		return epocurrate;
	}
	public void setEpocurrate(double epocurrate) {
		this.epocurrate = epocurrate;
	}



	private Double nettotal,taxamount;
	

	private String lbltaxamount,lblnettotal;
	private String lblcomptrn; 
	private String lblventrnno;
	public String getLblvenadd() {
		return lblvenadd;
	}

	public void setLblvenadd(String lblvenadd) {
		this.lblvenadd = lblvenadd;
	}
	private String lblvenadd;

	

	public String getLblventrnno() {
		return lblventrnno;
	}
	public void setLblventrnno(String lblventrnno) {
		this.lblventrnno = lblventrnno;
	}
	public String getLblcomptrn() {
		return lblcomptrn;
	}
	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
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
	public Double getTaxamount() {
		return taxamount;
	}
	public void setTaxamount(Double taxamount) {
		this.taxamount = taxamount;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}

	
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
	public String getAccid() {
		return accid;
	}
	public void setAccid(String accid) {
		this.accid = accid;
	}
	public String getVehpuraccname() {
		return vehpuraccname;
	}
	public void setVehpuraccname(String vehpuraccname) {
		this.vehpuraccname = vehpuraccname;
	}
	public String getHeadacccode() {
		return headacccode;
	}
	public void setHeadacccode(String headacccode) {
		this.headacccode = headacccode;
	}
	public String getVehtype() {
		return vehtype;
	}
	public void setVehtype(String vehtype) {
		this.vehtype = vehtype;
	}
	public String getVehrefno() {
		return vehrefno;
	}
	public void setVehrefno(String vehrefno) {
		this.vehrefno = vehrefno;
	}
	public String getVehpurorderdelDate() {
		return vehpurorderdelDate;
	}
	public void setVehpurorderdelDate(String vehpurorderdelDate) {
		this.vehpurorderdelDate = vehpurorderdelDate;
	}
	public String getHidvehpurorderdelDate() {
		return hidvehpurorderdelDate;
	}
	public void setHidvehpurorderdelDate(String hidvehpurorderdelDate) {
		this.hidvehpurorderdelDate = hidvehpurorderdelDate;
	}
	public String getVehdesc() {
		return vehdesc;
	}
	public void setVehdesc(String vehdesc) {
		this.vehdesc = vehdesc;
	}
	public Double getNettotal() {
		return nettotal;
	}
	public void setNettotal(Double nettotal) {
		this.nettotal = nettotal;
	}
	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getVehtypeval() {
		return vehtypeval;
	}
	public void setVehtypeval(String vehtypeval) {
		this.vehtypeval = vehtypeval;
	}
	public int getVehoredergridlenght() {
		return vehoredergridlenght;
	}
	public void setVehoredergridlenght(int vehoredergridlenght) {
		this.vehoredergridlenght = vehoredergridlenght;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	

	public String getMasterrefno() {
		return masterrefno;
	}
	public void setMasterrefno(String masterrefno) {
		this.masterrefno = masterrefno;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	
	//--------------------------------------------------------print-------------------------------------------------------
	
	private String lbldate,lbltype,lbldesc1,expdeldate,lblvendoeacc,lblvendoeaccName,lbltotal;
	
	private int lbldoc;
	
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;
	
	
	public String getLbltotal() {
		return lbltotal;
	}
	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}
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
	public int getLbldoc() {
		return lbldoc;
	}
	public void setLbldoc(int lbldoc) {
		this.lbldoc = lbldoc;
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
	
	public String getTxtdelterms() {
		return txtdelterms;
	}

	public void setTxtdelterms(String txtdelterms) {
		this.txtdelterms = txtdelterms;
	}

	public String getTxtpayterms() {
		return txtpayterms;
	}

	public void setTxtpayterms(String txtpayterms) {
		this.txtpayterms = txtpayterms;
	}

	public String getTxtpaymode() {
		return txtpaymode;
	}

	public void setTxtpaymode(String txtpaymode) {
		this.txtpaymode = txtpaymode;
	}  

	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getVehpurorderDate());
		java.sql.Date sqlpurdeldate = ClsCommon.changeStringtoSqlDate(getVehpurorderdelDate() );
		String mode=getMode();  

	if(mode.equalsIgnoreCase("A")){
		ArrayList<String> descarray= new ArrayList<>();
		for(int i=0;i<getVehoredergridlenght() ;i++){
			String temp2=requestParams.get("vehodrtest"+i)[0];
		// String temp2=request.getAttribute("enqtest"+i).toString();
	
		descarray.add(temp2);
	 
	}
	int val=purchaseorderDAO.insert(sqlStartDate,sqlpurdeldate,getHeadacccode(),getVehtype(),getMasterrefno(),
			getEpocmbcurr(),getEpocurrate(),getNettotal(),getVehdesc(),session,getMode(),getFormdetailcode(),
			descarray,request,getTaxamount(),getTxtpaymode(),getTxtpayterms(),getTxtdelterms());
	int vdocno=(int) request.getAttribute("vocno");  
	if(val>0){
			 setHidvehpurorderDate(sqlStartDate.toString());
			setHidvehpurorderdelDate(sqlpurdeldate.toString());
			setData();
			setDocno(vdocno);
			setMasterdoc_no(val);
			setMsg("Successfully Saved"); 
			return "success";
	}
	else{
		    setHidvehpurorderDate(sqlStartDate.toString());
			setHidvehpurorderdelDate(sqlpurdeldate.toString());
			setData();
			setDocno(vdocno);
			setMasterdoc_no(val);  
			setMsg("Not Saved");
			return "fail";
	}
}


	else if(mode.equalsIgnoreCase("E")){
		ArrayList<String> descarray= new ArrayList<>();
		for(int i=0;i<getVehoredergridlenght();i++){
			String temp2=requestParams.get("vehodrtest"+i)[0];
		// String temp2=request.getAttribute("enqtest"+i).toString();
			descarray.add(temp2);
		}
		boolean Status=purchaseorderDAO.edit(getMasterdoc_no(),sqlStartDate,sqlpurdeldate,getHeadacccode(),getVehtype(),getMasterrefno(),getEpocmbcurr(),getEpocurrate(),getNettotal(),getVehdesc(),session,getMode(),getFormdetailcode(),descarray,getTaxamount(),getTxtpaymode(),getTxtpayterms(),getTxtdelterms());
		if(Status){
			    setHidvehpurorderDate(sqlStartDate.toString());
				setHidvehpurorderdelDate(sqlpurdeldate.toString());
				setData();
				setMsg("Updated Successfully");
				return "success";
		}
		else{
			    setHidvehpurorderDate(sqlStartDate.toString());
				setHidvehpurorderdelDate(sqlpurdeldate.toString());
				setData();
				setMsg("Not Updated");
				return "fail";
		}
	}
else if(mode.equalsIgnoreCase("D")){
		boolean Status=purchaseorderDAO.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode());
	if(Status){
		    setHidvehpurorderDate(sqlStartDate.toString());
			setHidvehpurorderdelDate(sqlpurdeldate.toString());
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
else if(mode.equalsIgnoreCase("view")){
	    setHidvehpurorderDate(sqlStartDate.toString());
		setHidvehpurorderdelDate(sqlpurdeldate.toString());
}
return "fail";	
}
	public void setData() {
		setAccid(getAccid());
		setVehpuraccname(getVehpuraccname());
		setVehtypeval(getVehtype());
		setHeadacccode(getHeadacccode());
		setVehrefno(getVehrefno());
		setNettotal(getNettotal());
		setTaxamount(getTaxamount());
		setVehdesc(getVehdesc());
		setDocno(getDocno());
		setMasterrefno(getMasterrefno());
		setMasterdoc_no(getMasterdoc_no());
		setHidcmbcurr(getEpocmbcurr());  
		setEpocurrate(getEpocurrate());
		setTxtpaymode(getTxtpaymode());  
		setTxtpayterms(getTxtpayterms());
		setTxtdelterms(getTxtdelterms());
	}  
	
		
	
	public String printAction() throws ParseException, SQLException{     
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpServletResponse response=ServletActionContext.getResponse();   
		  HttpSession session=request.getSession();
		  int doc=Integer.parseInt(request.getParameter("docno"));
		 String user= session.getAttribute("USERID").toString();
		  pintbean=purchaseorderDAO.getPrint(doc);
		  ArrayList<String> arraylist = purchaseorderDAO.getPrintdetails(doc);
		  //cl details
		  setLblprintname("Equipment Purchase Order");
		  setLbldoc(pintbean.getLbldoc());
		  setTotalamountwords(pintbean.getTotalamountwords());
  	      setLbldate(pintbean.getLbldate());
  	      setLbltype(pintbean.getLbltype());
  	      setLbldesc1(pintbean.getLbldesc1());
  	      setExpdeldate(pintbean.getExpdeldate());
		  request.setAttribute("details",arraylist); 
		  setLblvendoeacc(pintbean.getLblvendoeacc());
		  setLblvendoeaccName(pintbean.getLblvendoeaccName());
	      setLblbranch(pintbean.getLblbranch());
	      setLblcompname(pintbean.getLblcompname());
	      setLblcompaddress(pintbean.getLblcompaddress());
	      setLblcomptel(pintbean.getLblcomptel());
	      setLblcomptrn(pintbean.getLblcomptrn());
	      setLblventrnno(pintbean.getLblventrnno());
	      setLblcompfax(pintbean.getLblcompfax());
	      setLbllocation(pintbean.getLbllocation());
	      setLbltotal(pintbean.getLbltotal());
	      setLblnettotal(pintbean.getLblnettotal());
	      setLbltaxamount(pintbean.getLbltaxamount());  
	      setCurrency(pintbean.getCurrency());
	      setLblvenadd(pintbean.getLblvenadd());

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

		
		dtype="EPO";
                       if(ClsCommon.getPrintPath("EPO").contains(".jrxml")==true)
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
						     
							 String reportFileName = "equippurchaseorder";
							 
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
						  		
									 strSqldetail=("select rq.srno,rq.brdid,rq.modid,rq.spec ,rq.clrid,round(rq.qty) qty,format(rq.price,2) price, format(rq.total,2) total,"
											+ " vb.brand_name brand,vm.vtype model,coalesce(vc.color,'')color "
											+ " from eq_vpod rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
											+ "left join gl_vehmodel vm on vm.doc_no=rq.MODID   "
											+ "left join my_color vc on vc.doc_no=rq.clrid  where rq.clstatus=0 and rq.rdocno='"+docno+"' ");
							      //System.out.println("resqll===="+strSqldetail);
						          
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
										System.out.println("brhid2==="+brhid);
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
							          param.put("delivery", pintbean.getExpdeldate());  
							          param.put("description", pintbean.getLbldesc1()); 
							          param.put("docno", pintbean.getLbldoc());  
							          param.put("vendor", pintbean.getLblvendoeaccName());  
							          param.put("vendorno", pintbean.getLblvendoeacc());
							          param.put("vendortrn", pintbean.getLblventrnno()); 
							          param.put("vendoradd", pintbean.getLblvenadd());
							          param.put("username", username);
							          param.put("imgpath", imgpath);
							          param.put("ttotalamnt", pintbean.getLbltotal());
							          param.put("taxamnt", pintbean.getLbltaxamount());  
							          param.put("tnetamount",pintbean.getLblnettotal());
							          param.put("brcid", branchid);
							          param.put("productQuery",  strSqldetail);
							          param.put("currency",pintbean.getCurrency());
							          param.put("tamountwords", pintbean.getTotalamountwords().replace("AED",pintbean.getCurrency()));
							          param.put("paymentterms",  pintbean.getLblpayterms()); 
							          param.put("paymentmode",  pintbean.getLblpaymode());
							          param.put("deliveryterms",  pintbean.getLbldelterms());  
						           String fire7imgpath=request.getSession().getServletContext().getRealPath("/icons/fire7fullheader.jpg");
						           fire7imgpath=fire7imgpath.replace("\\", "\\\\");
						           param.put("fire7fullheadderpath", fire7imgpath);
							        setUrl(ClsCommon.getPrintPath(dtype));
							  
							        String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/header.jpg");
							        headerimgpath=headerimgpath.replace("\\", "\\\\");
							           param.put("headerpath", headerimgpath); 
							        System.out.println(ClsCommon.getPrintPath(dtype));
				              JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/equipment/equippurchaseorder/"+ClsCommon.getPrintPath(dtype)));
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
}