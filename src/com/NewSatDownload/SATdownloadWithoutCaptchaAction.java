package com.NewSatDownload;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

import javax.imageio.ImageIO;
import javax.script.ScriptEngineManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.apache.struts2.ServletActionContext;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeDriverService;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.FluentWait;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.NewSatDownload.SATdownloadDAO;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;


public class SATdownloadWithoutCaptchaAction extends ActionSupport {

	private static final Logger log = Logger.getLogger( SATdownloadWithoutCaptchaAction.class.getName() );
	ClsCommon objcommon=new ClsCommon();
	SATdownloadDAO dao=new SATdownloadDAO();
	private static final String JAVASCRIPT_SRC = 
			" var impl = { " +
					"     run: function() { " +
					"         println ('Hello, World!'); " +
					"     } " +
					" }; ";
	private String hidchkblackpoints;
	private String salikcounter;
	private String category="";
	private String hiddencategory="";
	private String chck_salikautomatic="";
	private String cmbsaliksite="";
	private String hidcmbsaliksite="";
	private String cmbtype="ldays";
	private String hidcmbtype="";
	private String jqxStartDate="";
	private String jqxEndDate="";
	private String hidjqxStartDate="";
	private String hidjqxEndDate="";
	private String txtusername="";
	private String txtsalikfleetno="";
	private String txtsalikregno="";
	private String txtsaliktagno="";
	private String docs="0";
	private String captcha="";
	//private boolean radio_traffic=false;
	private String chck_trafficautomatic="";
	private String cmbtrafficsite="";
	private String hidcmbtrafficsite="";
	private String chck_trafficfileno="";
	private String txttrafficplateno="";
	private String txtsalikplatecode="";
	private String txttrafficcategory="";
	private String txttrafficauthority="";
	private String captchapath="";
	private int captchacount=0;
	private int iscaptcha=0;
	private String txtdescription="";
	private String captchatxt;
	private String msg;
	private int iscaptchaloaded=0;
	private String hidChck_trafficfileno="";
	private String txttrafficpsource;
	private String txttrafficpsourceid;
	private String txttrafficpcolor;
	private String txttrafficpcolorid;
	private String txttrafficptype;
	private String txttrafficptypeid;
	private String txttrafficpno;
	private int chck_salikpdata;
	private String cmbyear;
	private int itemcount;
	private int itemtotalcount;
	private String itemtype;
	private String cmbmonthname,hidcmbmonthname;
	
	
	public String getCmbmonthname() {
		return cmbmonthname;
	}
	public void setCmbmonthname(String cmbmonthname) {
		this.cmbmonthname = cmbmonthname;
	}
	public String getHidcmbmonthname() {
		return hidcmbmonthname;
	}
	public void setHidcmbmonthname(String hidcmbmonthname) {
		this.hidcmbmonthname = hidcmbmonthname;
	}
	public String getHidchkblackpoints() {
		return hidchkblackpoints;
	}
	public void setHidchkblackpoints(String hidchkblackpoints) {
		this.hidchkblackpoints = hidchkblackpoints;
	}
	public int getItemcount() {
		return itemcount;
	}
	public void setItemcount(int itemcount) {
		this.itemcount = itemcount;
	}
	public int getItemtotalcount() {
		return itemtotalcount;
	}
	public void setItemtotalcount(int itemtotalcount) {
		this.itemtotalcount = itemtotalcount;
	}
	
	public String getItemtype() {
		return itemtype;
	}
	public void setItemtype(String itemtype) {
		this.itemtype = itemtype;
	}
	
	public String getSalikcounter() {
		return salikcounter;
	}
	public void setSalikcounter(String salikcounter) {
		this.salikcounter = salikcounter;
	}
	public String getCmbyear() {
		return cmbyear;
	}
	public void setCmbyear(String cmbyear) {
		this.cmbyear = cmbyear;
	}
	public int getChck_salikpdata() {
		return chck_salikpdata;
	}
	public void setChck_salikpdata(int chck_salikpdata) {
		this.chck_salikpdata = chck_salikpdata;
	}
	public String getTxttrafficpno() {
		return txttrafficpno;
	}
	public void setTxttrafficpno(String txttrafficpno) {
		this.txttrafficpno = txttrafficpno;
	}
	public String getTxttrafficpsource() {
		return txttrafficpsource;
	}
	public void setTxttrafficpsource(String txttrafficpsource) {
		this.txttrafficpsource = txttrafficpsource;
	}
	public String getTxttrafficpsourceid() {
		return txttrafficpsourceid;
	}
	public void setTxttrafficpsourceid(String txttrafficpsourceid) {
		this.txttrafficpsourceid = txttrafficpsourceid;
	}
	public String getTxttrafficpcolor() {
		return txttrafficpcolor;
	}
	public void setTxttrafficpcolor(String txttrafficpcolor) {
		this.txttrafficpcolor = txttrafficpcolor;
	}
	public String getTxttrafficpcolorid() {
		return txttrafficpcolorid;
	}
	public void setTxttrafficpcolorid(String txttrafficpcolorid) {
		this.txttrafficpcolorid = txttrafficpcolorid;
	}
	public String getTxttrafficptype() {
		return txttrafficptype;
	}
	public void setTxttrafficptype(String txttrafficptype) {
		this.txttrafficptype = txttrafficptype;
	}
	public String getTxttrafficptypeid() {
		return txttrafficptypeid;
	}
	public void setTxttrafficptypeid(String txttrafficptypeid) {
		this.txttrafficptypeid = txttrafficptypeid;
	}
	public String getHidChck_trafficfileno() {
		return hidChck_trafficfileno;
	}
	public void setHidChck_trafficfileno(String hidChck_trafficfileno) {
		this.hidChck_trafficfileno = hidChck_trafficfileno;
	}
	public int getIscaptchaloaded() {
		return iscaptchaloaded;
	}
	public void setIscaptchaloaded(int iscaptchaloaded) {
		this.iscaptchaloaded = iscaptchaloaded;
	}
	public String getTxtsalikregno() {
		return txtsalikregno;
	}
	public void setTxtsalikregno(String txtsalikregno) {
		this.txtsalikregno = txtsalikregno;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getIscaptcha() {
		return iscaptcha;
	}
	public void setIscaptcha(int iscaptcha) {
		this.iscaptcha = iscaptcha;
	}
	public int getCaptchacount() {
		return captchacount;
	}
	public void setCaptchacount(int captchacount) {
		this.captchacount = captchacount;
	}
	public String getCaptchapath() {
		return captchapath;
	}
	public void setCaptchapath(String captchapath) {
		this.captchapath = captchapath;
	}
	public String getCaptchatxt() {
		return captchatxt;
	}
	public void setCaptchatxt(String captchatxt) {
		this.captchatxt = captchatxt;
	}
	public String getCaptcha() {
		return captcha;
	}
	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}
	public String getHiddencategory() {
		return hiddencategory;
	}
	public void setHiddencategory(String hiddencategory) {
		this.hiddencategory = hiddencategory;
	}
	public String getDocs() {
		return docs;
	}
	public void setDocs(String docs) {
		this.docs = docs;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}
	//	public boolean isCategory() {
	//		return category;
	//	}
	//	public void setCategory(boolean category) {
	//		this.category = category;
	//	}

	public String getChck_salikautomatic() {
		return chck_salikautomatic;
	}
	public void setChck_salikautomatic(String chck_salikautomatic) {
		this.chck_salikautomatic = chck_salikautomatic;
	}
	public String getCmbsaliksite() {
		return cmbsaliksite;
	}
	public void setCmbsaliksite(String cmbsaliksite) {
		this.cmbsaliksite = cmbsaliksite;
	}
	public String getHidcmbsaliksite() {
		return hidcmbsaliksite;
	}
	public void setHidcmbsaliksite(String hidcmbsaliksite) {
		this.hidcmbsaliksite = hidcmbsaliksite;
	}
	public String getCmbtype() {
		return cmbtype;
	}
	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}
	public String getHidcmbtype() {
		return hidcmbtype;
	}
	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}
	public String getJqxStartDate() {
		return jqxStartDate;
	}
	public void setJqxStartDate(String jqxStartDate) {
		this.jqxStartDate = jqxStartDate;
	}
	public String getJqxEndDate() {
		return jqxEndDate;
	}
	public void setJqxEndDate(String jqxEndDate) {
		this.jqxEndDate = jqxEndDate;
	}
	public String getHidjqxStartDate() {
		return hidjqxStartDate;
	}
	public void setHidjqxStartDate(String hidjqxStartDate) {
		this.hidjqxStartDate = hidjqxStartDate;
	}
	public String getHidjqxEndDate() {
		return hidjqxEndDate;
	}
	public void setHidjqxEndDate(String hidjqxEndDate) {
		this.hidjqxEndDate = hidjqxEndDate;
	}
	public String getTxtusername() {
		return txtusername;
	}
	public void setTxtusername(String txtusername) {
		this.txtusername = txtusername;
	}
	public String getTxtsalikfleetno() {
		return txtsalikfleetno;
	}
	public void setTxtsalikfleetno(String txtsalikfleetno) {
		this.txtsalikfleetno = txtsalikfleetno;
	}
	public String getTxtsaliktagno() {
		return txtsaliktagno;
	}
	public void setTxtsaliktagno(String txtsaliktagno) {
		this.txtsaliktagno = txtsaliktagno;
	}
	public void setChck_trafficautomatic(String chck_trafficautomatic) {
		this.chck_trafficautomatic = chck_trafficautomatic;
	}
	private String getChck_trafficautomatic() {
		// TODO Auto-generated method stub
		return  chck_trafficautomatic;
	}
	public String getCmbtrafficsite() {
		return cmbtrafficsite;
	}
	public void setCmbtrafficsite(String cmbtrafficsite) {
		this.cmbtrafficsite = cmbtrafficsite;
	}
	public String getHidcmbtrafficsite() {
		return hidcmbtrafficsite;
	}
	public void setHidcmbtrafficsite(String hidcmbtrafficsite) {
		this.hidcmbtrafficsite = hidcmbtrafficsite;
	}
	public String getChck_trafficfileno() {
		return chck_trafficfileno;
	}
	public void setChck_trafficfileno(String chck_trafficfileno) {
		this.chck_trafficfileno = chck_trafficfileno;
	}
	public String getTxttrafficplateno() {
		return txttrafficplateno;
	}
	public void setTxttrafficplateno(String txttrafficplateno) {
		this.txttrafficplateno = txttrafficplateno;
	}
	public String getTxtsalikplatecode() {
		return txtsalikplatecode;
	}
	public void setTxtsalikplatecode(String txtsalikplatecode) {
		this.txtsalikplatecode = txtsalikplatecode;
	}
	public String getTxttrafficcategory() {
		return txttrafficcategory;
	}
	public void setTxttrafficcategory(String txttrafficcategory) {
		this.txttrafficcategory = txttrafficcategory;
	}
	public String getTxttrafficauthority() {
		return txttrafficauthority;
	}
	public void setTxttrafficauthority(String txttrafficauthority) {
		this.txttrafficauthority = txttrafficauthority;
	}


	static String url="",urldet="",tcno1="";
	String ts="",pass="";
	static String browser="chrome";
	WebDriver driver=null;
	private static ChromeDriverService service;
	String defaultwindow = "";
	String popupwindow = "";
	Document docDet,doc;
	boolean flag=false;
	String fineno="",dat="0",time="",curPage="0",timeappend="",salik_fdate="" ;
	String [] tformat=new String[10];
	int txtStPage=1;
	int rollno=1;
    int srno=0,xsasrno,xsadoc=0,serno=0,xdoc=0;
	int dno=0,excaptcha=0,rtalogin=0;
	String xdocs="0";
	String branch="";
	String SATEXCELCONFIG="0",SATEXCEL="";
	
	ClsConnection connobj=new  ClsConnection();
	Connection conn = connobj.getMyConnection();
	ClsCommon com= new ClsCommon();

	public String process() throws ParseException, SQLException{

		boolean result=false;

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		try{

			String qryapnd="";

			txtusername=getTxtusername();
			category=getCategory();
			cmbsaliksite=getCmbsaliksite();
			setHiddencategory(getCategory());
			// chck_salikautomatic=getChck_salikautomatic();

			//System.out.println("Category ====="+getCategory());
			
			/*Checking Category*/
			
			if(getCategory().equalsIgnoreCase("salik"))
			{

				/*if(getChck_salikautomatic().equalsIgnoreCase("salikautomatic"))
			 {*/
								if(getCmbsaliksite().equalsIgnoreCase("AUH")){
					if(txtusername!=null && !txtusername.equalsIgnoreCase("")){
						qryapnd="and t.username='"+txtusername+"'";
					}
					
					ResultSet rssalikuser = conn.createStatement().executeQuery("Select * from gl_webid t where t.TYPE='U' and t.Desc1='Salik' and t.site='AUH' "+qryapnd+"");
					
					while(rssalikuser.next())
					{	
						ts=rssalikuser.getString("username");
						pass=rssalikuser.getString("password");
						excaptcha=rssalikuser.getInt("iscaptcha");
						setIscaptcha(excaptcha);
						
						/* VISHAKH.V.P*/
						rtalogin=rssalikuser.getInt("rta");
						/* VISHAKH.V.P ENDS*/
						
						//url="https://customers.salik.ae/default.aspx?ReturnUrl=%2fModuleCustomer%2fDefault.aspx%3fculture%3deng&culture=eng";
						url="https://darb.itc.gov.ae?lang=en";

					}
					try {

						Statement stmtsalikcaptcha = conn.createStatement();
						
						String strsalikcaptcha = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";
						ResultSet rssalikcaptcha = stmtsalikcaptcha.executeQuery(strsalikcaptcha);
						
						while(rssalikcaptcha.next ()) {
							setCaptchapath(rssalikcaptcha.getString("captchaPath")+"/captcha.png");
						}

						
						result=loadfresh();
						if(result==true)
						{
							request.setAttribute("resultdata", result);	

						}
						setHiddencategory(getCategory());
					}
					catch(Exception e){
						e.printStackTrace();
					}
				/*if(getChck_salikautomatic().equalsIgnoreCase("salikautomatic"))
			 {*/
				}
				if(cmbsaliksite.equalsIgnoreCase("DXB")&&getCategory().equalsIgnoreCase("salik"))
				{
					setHidcmbsaliksite(getCmbsaliksite());
					if(txtusername==null ||txtusername.equalsIgnoreCase(""))
					{
						qryapnd="and 1=1" ;
					}
					else
					{
						qryapnd="and t.username='"+txtusername+"'";
					}
					ResultSet rssalik;
					try {
						//System.out.println("Select * from gl_webid t where t.TYPE='U' and t.Desc1='Salik' "+qryapnd+"");
						rssalik = conn.createStatement().executeQuery("Select * from gl_webid t where t.TYPE='U' and t.Desc1='Salik' and t.site='DXB' "+qryapnd+"");
							
						while(rssalik.next())
						{	
							ts=rssalik.getString("username");
							pass=rssalik.getString("password");
							excaptcha=rssalik.getInt("iscaptcha");
							setIscaptcha(excaptcha);
							
							/* VISHAKH.V.P*/
							rtalogin=rssalik.getInt("rta");
							/* VISHAKH.V.P ENDS*/
							
							//url="https://customers.salik.ae/default.aspx?ReturnUrl=%2fModuleCustomer%2fDefault.aspx%3fculture%3deng&culture=eng";
							url="https://customers.salik.ae/connect/login?lang=en";

						}
						try {

							Statement stmt1 = conn.createStatement();
							
							String strSql1 = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";
							ResultSet rs1 = stmt1.executeQuery(strSql1);
							
							while(rs1.next ()) {
								setCaptchapath(rs1.getString("captchaPath")+"/captcha.png");
							}

							result=loadfresh();
							if(result==true)
							{
								request.setAttribute("resultdata", result);	

							}
							setHiddencategory(getCategory());
						} catch (IOException e) {
							conn.close();
							e.printStackTrace();
						} catch (InterruptedException e) {
							conn.close();
							e.printStackTrace();
						}
					} catch (SQLException e) {
						conn.close();
						e.printStackTrace();
					}



				}

				//}


			}
			else if(getCategory().equalsIgnoreCase("traffic"))
			{
				//				System.out.println("=getChck_trafficautomatic==="+getChck_trafficautomatic());

				//				System.out.println("==getChck_trafficfileno==="+getChck_trafficfileno());
				
				int evmconfig=1;
				String strevmconfig="select method from gl_config where field_nme='EVGConfig'";
				ResultSet rsevmconfig=conn.createStatement().executeQuery(strevmconfig);
				while(rsevmconfig.next()){
					evmconfig=rsevmconfig.getInt("method");
				}
				//Please change to zero for Progress
				if(evmconfig==1 && getCmbtrafficsite().equalsIgnoreCase("AUH")){
					url="https://evg.ae/default.aspx?ReturnUrl=%2f";
					java.util.logging.Logger.getLogger("com.gargoylesoftware.htmlunit").setLevel(java.util.logging.Level.OFF);
					java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);
					String chromepath="";
					Statement stmt=conn.createStatement();
					ResultSet rsgetchromepath=stmt.executeQuery("select chromedriverpath from my_comp where doc_no=1");
					while(rsgetchromepath.next()){
						chromepath=rsgetchromepath.getString("chromedriverpath");
					}
					String stramountconfig="select method from gl_config where field_nme='trafficdownloadupdated'";
					ResultSet rsamountconfig=stmt.executeQuery(stramountconfig);
					int amountconfig=0;
					while(rsamountconfig.next()){
						amountconfig=rsamountconfig.getInt("method");
					}
					/*FirefoxProfile profile = new FirefoxProfile();
					profile.setPreference( "pdfjs.disabled", true );
					profile.setPreference("browser.cache.disk.enable", false);
					profile.setPreference("browser.cache.memory.enable", false);
					profile.setPreference("browser.cache.offline.enable", false);
					profile.setPreference("network.http.use-cache", false);
					profile.setEnableNativeEvents(true);
					profile.setPreference("network.proxy.http", "localhost");
					profile.setPreference("network.proxy.http_port", "3128");
					driver = new FirefoxDriver();*/
					System.setProperty("webdriver.chrome.driver",chromepath);  
		            // Instantiate a ChromeDriver class.     
				    driver=new ChromeDriver();
					//driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
					Thread.sleep(10000);
					driver.get(url);
					defaultwindow = driver.getWindowHandle();
					//driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
					Thread.sleep(10000);
					
					
					driver.findElement(By.xpath("//*[@id='popservices-ul']/a[2]")).click();
					Thread.sleep(10000);
					//driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
					System.out.println("getTxttrafficplateno === "+getTxttrafficplateno());
					driver.findElement(By.id("ctl00_cphScrollMenu_ctl00_ctl00_txtSearchTcfNo")).sendKeys(getTxttrafficplateno());
					driver.findElement(By.id("ctl00_cphScrollMenu_ctl00_ctl00_btnSearchTCF")).click();
					//Thread.sleep(3000);
					
					//driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
					Thread.sleep(10000);
					Document doc=Jsoup.parse(driver.getPageSource());
					Elements finerows=doc.select("table[id=ctl00_cphScrollMenu_gettickets1_ctl00_gvTickets]").select("tbody").get(0).select("tr");
					ArrayList<String> evmtrafficarray=new ArrayList<>();
					ResultSet rs = conn.createStatement().executeQuery("Select coalesce((max(doc_no)+1),1) max from gl_traffic");
					if(rs.next())
					{	
						dno=rs.getInt("max");
						xdoc=dno;
						xdocs=xdocs+","+xdoc;

					}
					/*request.setAttribute("trxdocs", xdocs);*/
					setDocs(String.valueOf(xdocs));
					session.setAttribute("ITEMCURRENTDOCNO",xdoc);
					String strrawcount=driver.findElement(By.xpath("//*[@id='ctl00_cphScrollMenu_gettickets1_ctl00_lblFinesCount']")).getText().trim();
					session.setAttribute("TOTALITEMCOUNT", strrawcount);
					for(int i=finerows.size()-1,j=1;i>0;i--,j++){
						String tickethtml=finerows.get(i).select("td").get(1).select("a").first().outerHtml();
						//String ticketno=finerows.get(i).select("td").get(1).select("a").first().text();
						String ticketno=tickethtml.split("TicketNo=")[1].split("'")[0];
						String amount="";
						if(amountconfig==1){
							amount=finerows.get(i).select("td").get(5).select("span").first().text();
						}
						else{
							amount=finerows.get(i).select("td").get(7).select("span").first().text();
						}
						
						driver.get("https://evg.ae/_layouts/EVG/ticketdetails.aspx?language=en&Type=Tickets&Page=0&TicketNo="+ticketno);
//						System.out.println("Sub Url:"+"https://evg.ae/_layouts/EVG/ticketdetails.aspx?language=en&Type=Tickets&Page=0&TicketNo="+ticketno);
						Thread.sleep(5000);
						while(!(driver.getPageSource().contains("maroonTable"))){
							System.out.println("Inside Extra Wait");
							Thread.sleep(5000);
						}
						Document subdoc=Jsoup.parse(driver.getPageSource());
						
						String trafficdate=subdoc.select("table[class=maroonTable]").first().select("tr").get(2).select("td").get(1).select("span").first().text();
						String traffictime=subdoc.select("table[class=maroonTable]").first().select("tr").get(3).select("td").get(1).select("span").first().text();
						String location=subdoc.select("table[class=maroonTable]").first().select("tr").get(7).select("td").get(1).select("span").first().text();
						String regno=subdoc.select("table[class=maroonTable]").first().select("tr").get(8).select("td").get(1).select("span").first().text();
						String source=subdoc.select("table[class=maroonTable]").first().select("tr").get(10).select("td").get(1).select("span").first().text();
						String platecolor=subdoc.select("table[class=maroonTable]").first().select("tr").get(11).select("td").get(1).select("span").first().text();
						String description=subdoc.select("table[id=ticketdetails1_ctl00_gvMaterialList]").first().select("tr").get(1).select("td").get(0).text();
//						System.out.println("1:"+ticketno+"::"+trafficdate+"::"+traffictime+"::"+location+"::"+regno+"::"+source+"::"+platecolor+"::"+amount+"::"+description);
						evmtrafficarray.add(ticketno+"::"+trafficdate+"::"+traffictime+"::"+location+"::"+regno+"::"+source+"::"+platecolor+"::"+amount+"::"+description);
						SimpleDateFormat datedisplayFormat = new SimpleDateFormat("dd-MM-yyyy");
						java.util.Date date = datedisplayFormat.parse(trafficdate);
						java.sql.Date sqltrafficdate = new java.sql.Date(date.getTime());
						
						SimpleDateFormat timedisplayFormat = new SimpleDateFormat("HH:mm");
					    SimpleDateFormat timeparseFormat = new SimpleDateFormat("hh:mm:ss a");
					    Date strtime = timeparseFormat.parse(traffictime);
					    @SuppressWarnings("deprecation")
					    String strhour=(strtime.getHours()<10?"0"+strtime.getHours():strtime.getHours())+"";
					    String strminutes=(strtime.getMinutes()<10?"0"+strtime.getMinutes():strtime.getMinutes())+"";
						String time=strhour+":"+strminutes;
					    tcno1=getTxttrafficplateno();
//						System.out.println("2:"+ticketno+"::"+trafficdate+"::"+traffictime+"::"+location+"::"+regno+"::"+source+"::"+platecolor+"::"+amount+"::"+description);
					     //Fine Source was inserted same as plate source,cuz fine source is not available in EVG site.So inserting as "" on 03-08-2019 onwards(Progress Request)
					    dao.trafficInsert(ticketno,sqltrafficdate,time+"","",regno,"",platecolor,"","","",
								Double.parseDouble(amount),location,amount,description,sqltrafficdate,"TRF",category,j,tcno1,xdoc,sqltrafficdate,branch,source,
								getCmbtrafficsite(),"",xdocs);
					}
				
					/*for(int i=0;i<evmtrafficarray.size();i++){
						String ticketno=evmtrafficarray.get(i).split("::")[0];
						String strtrafficdate=evmtrafficarray.get(i).split("::")[1];
						String strtraffictime=evmtrafficarray.get(i).split("::")[2];
						String location=evmtrafficarray.get(i).split("::")[3];
						String regno=evmtrafficarray.get(i).split("::")[4];
						String source=evmtrafficarray.get(i).split("::")[5];
						String platecolor=evmtrafficarray.get(i).split("::")[6];
						String amount=evmtrafficarray.get(i).split("::")[7];
						String description=evmtrafficarray.get(i).split("::")[8];
						SimpleDateFormat datedisplayFormat = new SimpleDateFormat("dd-MM-yyyy");
						java.util.Date date = datedisplayFormat.parse(strtrafficdate);
						java.sql.Date sqltrafficdate = new java.sql.Date(date.getTime());
						
						SimpleDateFormat timedisplayFormat = new SimpleDateFormat("HH:mm");
					    SimpleDateFormat timeparseFormat = new SimpleDateFormat("hh:mm:ss a");
					    Date time = timeparseFormat.parse(strtraffictime);
						dao.trafficInsert(ticketno,sqltrafficdate,time+"",source,regno,"",platecolor,"","","",
								Double.parseDouble(amount),location,amount,description,sqltrafficdate,"TRF",category,i+1,tcno1,xdoc,sqltrafficdate,branch,source,
								getCmbtrafficsite(),"",xdocs);
						
						result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,null,null,null,
								Double.parseDouble(Amount),location,Amount,DESC1,null,type,category,srno+n,tcno1,xdoc,date,branch,plate_source,
								getCmbtrafficsite(),"",xdocs);
					}*/
					
					driver.quit();
					setItemcount(getItemcount());
					setItemtotalcount(getItemtotalcount());
					setItemtype(getItemtype());
					return "success";
				}
				
				
				
				
				
				
				if(!(getChck_trafficfileno()==null))
				{
					setHidChck_trafficfileno(getChck_trafficfileno());
					if(getChck_trafficfileno().equalsIgnoreCase("trafficfileno")){
						//						System.out.println("==getCmbtrafficsite()==="+getCmbtrafficsite());
						if(getCmbtrafficsite().equalsIgnoreCase("DXB")&&getCategory().equalsIgnoreCase("traffic")){
							try{
								String fileno="";


								//								System.out.println("=getTxttrafficplateno()==="+getTxttrafficplateno());

								if(!(getTxttrafficplateno().equals(""))){
									fileno="and t.username='"+getTxttrafficplateno()+"'";
								}
								else{
									fileno="and 1=1";

								}

								//url="http://traffic.rta.ae/trfesrv/public_resources/ffu/fines-payment.do?actionParam=doSearch&searchMethod=3&trafficFileNo="+rstraffic.getString("username")+"";
								//url="https://traffic.rta.ae/trfesrv/public_resources/revamp/ffu/public-fines-payment.do?serviceCode=301&entityId=-1&trafficFileNo="+rstraffic.getString("username")+"&searchMethod=4";
								
								//url="https://www.rta.ae/";
								//Overridden on 03-07-2018
								//url="https://traffic.rta.ae/trfesrv/public_resources/revamp/ffu/public-fines-payment.do?serviceCode=301&entityId=-1";
								if(getTxttrafficpno()!=null && Integer.parseInt(getTxttrafficpno())>0){
									//url="http://traffic.rta.ae/trfesrv/public_resources/ffu/fines-payment.do?serviceCode=301&entityId=-1&searchMethod=1&plateNo="+getTxttrafficpno()+"&plateSource="+getTxttrafficpsourceid()+"&plateCategory=2&plateCodeId="+getTxttrafficpcolorid()+"";
									//url="https://www.rta.ae/";
									//url="https://traffic.rta.ae/trfesrv/public_resources/revamp/ffu/public-fines-payment.do?serviceCode=301&entityId=-1";
									//url="https://www.rta.ae/wps/portal/rta/ae/home?lang=en";
								}
								
								// url="https://www.rta.ae/wps/portal/rta/ae/home?lang=en";
								url="https://www.rta.ae/wps/myportal/rta/ae/home/dashboard?lang=en";
								try{
									//	MyApp.frmMain.descriptionPane.setText(MyApp.frmMain.descriptionPane.getText()+"\n"+"Loading...\n\nURL:"+url+"\n");
									loadfresh();
								}catch (Exception ec) {
									conn.close();
									ec.printStackTrace();
									}					   

								//boolean sveflg= SaveFormData(1, con);
								//									if(sveflg)
								//									{
								//										
								//									}
							}catch(Exception ex){
								conn.close();
								ex.printStackTrace();
							}



						}
						else if(getCmbtrafficsite().equalsIgnoreCase("AUH")&&getCategory().equalsIgnoreCase("traffic")){

							try{
								String fileno="";

								if(!(getTxttrafficplateno().equals(""))){
									fileno="and t.username='"+getTxttrafficplateno()+"'";
								}
								else{
									fileno="and 1=1";

								}

								ResultSet rstraffic = conn.createStatement().executeQuery("Select * from gl_webid t where t.site='AUH' "+fileno+"");

								//								System.out.println("Select * from gl_webid t where t.site='AUH' "+fileno+"");

								while(rstraffic.next())
								{
									ts=rstraffic.getString("username");
									//System.out.println("ts in ResultSet="+ts);
									
									//Vishakh Starts
									excaptcha=rstraffic.getInt("iscaptcha");
									setIscaptcha(excaptcha);
									//Vishakh Ends
									//url="https://es.adpolice.gov.ae/trafficservices/FinesPublic/InquiryResult.aspx?TS="+rstraffic.getString("username")+"&IT=TS&Culture=en";

									url="https://es.adpolice.gov.ae/TrafficServices/FinesPublic/Inquiry.aspx?Culture=en";
									
									if(getTxttrafficpno()!=null && Integer.parseInt(getTxttrafficpno())>0){
										url="https://es.adpolice.gov.ae/trafficservices/FinesPublic/InquiryResult.aspx?TS="+rstraffic.getString("username")+"&PN="+getTxttrafficpno()+"&PS="+getTxttrafficpsourceid()+"&PC="+getTxttrafficpcolorid()+"&PK=1&IT=PI&Culture=en";
									}

									//																			System.out.println("==url=111=="+url);
									try{
										//	MyApp.frmMain.descriptionPane.setText(MyApp.frmMain.descriptionPane.getText()+"\n"+"Loading...\n\nURL:"+url+"\n");
										loadfresh();
									}catch (Exception ec) {
										conn.close();
										ec.printStackTrace();										
									}					   

								}
								rstraffic.close();
								//boolean sveflg= SaveFormData(1, con);
								//									if(sveflg)
								//									{
								//										
								//									}
							}catch(Exception ex){
								conn.close();
								ex.printStackTrace();
							}

						}

					}}


				/*}*/

			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			reloaddata();
			setCmbsaliksite(getCmbsaliksite());
			setCmbtype(getCmbtype());
			String  path="";

			Statement stmt1 = conn.createStatement();
			String strSql1 = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";
			//System.out.println("==strSql1===="+strSql1);
			ResultSet rs1 = stmt1.executeQuery(strSql1);
			while(rs1.next ()) {
				path=rs1.getString("captchaPath");

			}

			String imgPath = path+"/captcha.png";

			try
			{
				File temp=new File(imgPath);
				if (temp.exists()){


					temp.delete();

				}
			}
			catch(Exception e){
				conn.close();
				e.printStackTrace();

			}
			conn.close();
			driver.quit();
		}
		setItemcount(getItemcount());
		setItemtotalcount(getItemtotalcount());
		setItemtype(getItemtype());
		return "success";
	}



	public boolean loadfresh() throws IOException, InterruptedException, SQLException
	{
		boolean result=false;

		try{

			java.util.logging.Logger.getLogger("com.gargoylesoftware.htmlunit").setLevel(java.util.logging.Level.OFF);
			java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);

			/* VISHAKH.V.P */
			String chromepath="";
			ResultSet resultSET = conn.createStatement().executeQuery("select method from gl_config where field_nme='SATSALIKEXCELDOWNLOAD'");

			while(resultSET.next()) {
				SATEXCELCONFIG=resultSET.getString("method");
			}
			
			if(SATEXCELCONFIG.equalsIgnoreCase("2") && getCategory().equalsIgnoreCase("salik")){
				
				ResultSet rsconfig = conn.createStatement().executeQuery("Select sitecheck from gl_webid t where t.username='"+getTxtusername()+"' ");
				while(rsconfig.next()){
					SATEXCELCONFIG=rsconfig.getString("sitecheck");
				}
				System.out.println("   case value 2  "+SATEXCELCONFIG);
			}
			
			ResultSet rsgetchromepath=conn.createStatement().executeQuery("select chromedriverpath from my_comp where doc_no=1");
			while(rsgetchromepath.next()){
				chromepath=rsgetchromepath.getString("chromedriverpath");
			}
			//Gettin local chrome path
			if(ts!=null && !ts.trim().equalsIgnoreCase("") && getCmbtrafficsite().equalsIgnoreCase("AUH")){
				ResultSet rsgetlocalchromepath=conn.createStatement().executeQuery("select coalesce(url,'') url from gl_webid where tcno='"+ts+"'");
				while(rsgetlocalchromepath.next()){
					String localchromepath=rsgetlocalchromepath.getString("url");
					if(!localchromepath.trim().equalsIgnoreCase("")){
						chromepath=localchromepath;
					}
				}
			}
			
			if(SATEXCELCONFIG.equalsIgnoreCase("1") && getCategory().equalsIgnoreCase("salik")) {
				
				/* EXCEL DOWNLOAD */
				
				ResultSet resultSET1 = conn.createStatement().executeQuery("Select imgPath from my_comp");
	
				while(resultSET1.next()) {
					SATEXCEL=(resultSET1.getString("imgPath")+"\\SATEXCEL");
				}
				
				//System.out.println("SATEXCEL ="+SATEXCEL);
				
				/*FirefoxProfile profile = new FirefoxProfile();
				profile.setPreference("browser.download.dir", SATEXCEL);
				profile.setPreference("browser.download.folderList", 2);
				profile.setPreference("browser.helperApps.neverAsk.openFile","text/csv,application/x-msexcel,application/excel,application/x-excel,application/vnd.ms-excel,image/png,image/jpeg,text/html,text/plain,application/msword,application/xml");
				profile.setPreference("browser.helperApps.neverAsk.saveToDisk","text/csv,application/x-msexcel,application/excel,application/x-excel,application/vnd.ms-excel,image/png,image/jpeg,text/html,text/plain,application/msword,application/xml");
				profile.setPreference("browser.helperApps.alwaysAsk.force", false);
				profile.setPreference("browser.download.manager.alertOnEXEOpen", false);
				profile.setPreference("browser.download.manager.focusWhenStarting", false);
				profile.setPreference("browser.download.manager.useWindow", false);
				profile.setPreference("browser.download.manager.showAlertOnComplete", false);
				profile.setPreference("browser.download.manager.closeWhenDone", false);
				profile.setPreference( "browser.download.manager.showWhenStarting", false );
				profile.setPreference( "pdfjs.disabled", true );
				driver = new FirefoxDriver(profile);  */
				
				HashMap<String, Object> chromePrefs = new HashMap<String, Object>();
				chromePrefs.put("profile.default_content_settings.popups", 0);
				chromePrefs.put("download.default_directory", SATEXCEL);
				 
				ChromeOptions options = new ChromeOptions();
				options.setExperimentalOption("prefs", chromePrefs);
				DesiredCapabilities cap = DesiredCapabilities.chrome();
				cap.setCapability(CapabilityType.ACCEPT_SSL_CERTS, true);
				cap.setCapability(ChromeOptions.CAPABILITY, options);
				System.setProperty("webdriver.chrome.driver",chromepath); 
				driver = new ChromeDriver(cap);
			
			}
			else if(!SATEXCELCONFIG.equalsIgnoreCase("1") && getCategory().equalsIgnoreCase("salik")){
System.out.println(chromepath);
				System.setProperty("webdriver.chrome.driver",chromepath);  
	            // Instantiate a ChromeDriver class.     
			    driver=new ChromeDriver();
				
				/*FirefoxProfile profile = new FirefoxProfile();
				profile.setPreference( "pdfjs.disabled", true );
				profile.setPreference("browser.cache.disk.enable", false);
				profile.setPreference("browser.cache.memory.enable", false);
				profile.setPreference("browser.cache.offline.enable", false);
				profile.setPreference("network.http.use-cache", false);
				profile.setEnableNativeEvents(true);
				profile.setPreference("network.proxy.http", "localhost");
				profile.setPreference("network.proxy.http_port", "3128");
				driver = new FirefoxDriver();*/
			}
			else {	
				/*FirefoxProfile profile = new FirefoxProfile();
				profile.setPreference( "pdfjs.disabled", true );
				profile.setPreference("browser.cache.disk.enable", false);
				profile.setPreference("browser.cache.memory.enable", false);
				profile.setPreference("browser.cache.offline.enable", false);
				profile.setPreference("network.http.use-cache", false);
				profile.setEnableNativeEvents(true);
				profile.setPreference("network.proxy.http", "localhost");
				profile.setPreference("network.proxy.http_port", "3128");
				driver = new FirefoxDriver();*/
				System.setProperty("webdriver.chrome.driver",chromepath);
				driver=new ChromeDriver();
			/*	//options.setBinary(chromepath);
	            // Instantiate a ChromeDriver class.     
				ChromeOptions options = new ChromeOptions();
				options.addArguments("start-maximized"); // open Browser in maximized mode
				options.addArguments("disable-infobars"); // disabling infobars
				options.addArguments("--disable-extensions"); // disabling extensions
				options.addArguments("--disable-gpu"); // applicable to windows os only
			//	options.addArguments("--disable-dev-shm-usage"); // overcome limited resource problems
				options.addArguments("--no-sandbox"); // Bypass OS security model
				// driver=new ChromeDriver(options);
				URL link=new URL("http://localhost:9515");
				WebDriver driver = new RemoteWebDriver(link, DesiredCapabilities.chrome());
				driver.get("http://www.google.com");*/

			}
			
			/* VISHAKH.V.P ENDS*/
			
			driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
			driver.get(url);
			driver.manage().window().maximize();
			
			defaultwindow = driver.getWindowHandle();
			doc= Jsoup.parse(driver.getPageSource());

			//	    if(getCategory().equalsIgnoreCase("traffic"))
			//	    {
			/*org.openqa.selenium.Dimension screenResolution = new org.openqa.selenium.Dimension(2000,2000);
     	    driver.manage().window().setSize(screenResolution);
    	    driver.manage().window().setPosition(new Point(2000,2000));*/
			//	    }

			if(!(getCmbtrafficsite().equalsIgnoreCase("AUH")))
			{
				result=jsoupGetTableData(1);
			}
			//			System.out.println("=result==="+result);
			//			System.out.println("getCategory()"+getCategory());

			if(getCategory().equalsIgnoreCase("traffic"))
			{
				//driver.manage().window().setPosition(new Point(-2000, 0));

				if(getCmbtrafficsite().equalsIgnoreCase("AUH"))
				{

					/*Vishakh*/
					
					driver.findElement(By.id("ctl00_ContentPlaceHolder1_txtByTcf")).sendKeys(ts);
					//inputCaptchaTrafficAUH("Captcha");
					Thread.sleep(10000);
					/*Vishakh Ends*/
					
					int rowsize=1500;
					String rowsizes=driver.findElement(By.id("ctl00_ContentPlaceHolder1_lblNoTickets")).getText();

					/*Vishakh
					if(rowsizes.contains("-")) {
						rowsizes=rowsizes.substring(9, rowsizes.indexOf("-"));
						rowsizes=(Integer.parseInt(rowsizes)/50)+1+"";
						rowsize=Integer.parseInt(rowsizes);
					} else {
						driver.quit();
						return false;
					}*/
					/*Vishakh Ends*/
					
					//gridViewPager
					/*String  rowsizeWebElement=driver.findElement(By.id("gridViewPager")).getText();
	        		System.out.println("=====rowsizeWebElement======rowsizeWebElement==="+rowsizeWebElement);*/
					rowsize=driver.findElements(By.xpath("//*[@id='ctl00_ContentPlaceHolder1_gvTickets']/tbody/tr[53]/td/table/tbody/tr/td")).size();
					for(int i=1;i<=rowsize;i++)
					{
						//	        			descriptionPane.setText(descriptionPane.getText()+"\n"+"Processing Page :"+i+"");
						//	        			descriptionPane.update(descriptionPane.getGraphics());
						if(i!=1){
							driver.findElement(By.xpath("//*[@id='ctl00_ContentPlaceHolder1_gvTickets']/tbody/tr[53]/td/table/tbody/tr/td["+i+"]/a")).click();
							Thread.sleep(6000);
						}
						//if (driver instanceof JavascriptExecutor) {
							//Thread.sleep(5000);
							//((JavascriptExecutor)driver).executeScript("__doPostBack('ctl00$ContentPlaceHolder1$gvTickets','Page$"+i+"');");
						//}
							


						WebElement we=null;
						int cnt=0;
						do
						{  
							/*Thread.sleep(10000);*///commented by krish
							
							we = driver.findElement(By.id("ctl00_ContentPlaceHolder1_UpdateProgress1"));
							String style = we.getAttribute("style").trim();

							if (!style.equalsIgnoreCase("display: none;"))
								we=null;
							cnt++;
						}while(we==null && cnt<10);

						url=driver.getCurrentUrl();

						doc= Jsoup.parse(driver.getPageSource());
						if(getCategory().equalsIgnoreCase("traffic"))
							//	        			{
							//							 org.openqa.selenium.Dimension screenResolution = new org.openqa.selenium.Dimension(2000,1000);
							//							 driver.manage().window().setSize(screenResolution);
							//							 driver.manage().window().setPosition(new Point(2000,1000));
							//	        			}
							
							result=jsoupGetTableData(i);
					}
				}

				if(getCmbtrafficsite().equalsIgnoreCase("DXB"))
				{

					String data="",disc="",Fees="",remark="";
					String Time="",fine_Source="",regNo="",PlateCategory="",pcolor="",Amount="",Ticket_No="",Tick_violat="",DESC1="",type="",plate_source="",location="";
					String [] dateformat=null;
					java.sql.Date traffic_date=null;
					/*
					 * Overridden on 13-04-2019
					 * */
					
				//	driver.findElement(By.xpath("//*[@class='login-n-register']/a")).click();
				//	driver.findElement(By.xpath("//*[@class='login-dropdown']/a[0]")).click();
					//driver.findElement(By.xpath("//*[@id='set-1']/ul/li[1]/a")).click();

					//driver.findElement(By.id("show_login")).click();

					/*driver.findElement(By.id("switchToEnglishbtn")).click();
					driver.findElement(By.xpath("//*[@class='login-n-register']/a/span")).click();
					driver.findElement(By.xpath("//*[@class='login-dropdown']/a[1]")).click();
					*/
					//Overridden on 03-07-2018
					//driver.findElement(By.id("searchType4")).click();
					//System.out.println("Radio Button Clicked");
					
					String fileno="";
					if(!(getTxttrafficplateno().equals(""))){
						fileno="and t.username='"+getTxttrafficplateno()+"'";
					}
					else{
						fileno="and 1=1";

					}

					ResultSet rstraffic = conn.createStatement().executeQuery("Select * from gl_webid t where t.site='DXB' and type='F' "+fileno+" ");

					while(rstraffic.next())
					{
						//driver.findElement(By.id("userID")).sendKeys(rstraffic.getString("username"));
						driver.findElement(By.id("username")).sendKeys(rstraffic.getString("username"));
						driver.findElement(By.id("password")).sendKeys(rstraffic.getString("password"));
						//Overridden on 03-07-2018
						//driver.findElement(By.id("trafficFileNoId")).sendKeys(rstraffic.getString("tcno"));
						tcno1=rstraffic.getString("tcno");
						//System.out.println("After TCNO");
						excaptcha=rstraffic.getInt("iscaptcha");
						setIscaptcha(excaptcha);

					}
					
					Statement stmt1 = conn.createStatement();
					HttpServletRequest request=ServletActionContext.getRequest();
					HttpSession session=request.getSession();
					
					String strSql1 = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";
					ResultSet rs1 = stmt1.executeQuery(strSql1);
					
					while(rs1.next ()) {
						setCaptchapath(rs1.getString("captchaPath")+"/captcha.png");
					}
					
					String imgPath = getCaptchapath();

					try
					{
						File temp=new File(imgPath);
						if (temp.exists()){


							temp.delete();

						}
					}
					catch(Exception e){
						conn.close();
						e.printStackTrace();

					}
					
					//inputCaptchaDXB("Captcha");
					//System.out.println("After Download Captcha");

					//driver.findElement(By.xpath("//*[@id='loginButtonTD']/input")).click();
					
					/*driver.findElement(By.xpath("//*[@id='loginControl']/div/div[1]/div/input")).click();*/
					/*JavascriptExecutor js = (JavascriptExecutor)driver;
					js.executeScript("window.scrollTo(0,200);");*/
					JavascriptExecutor firstpagescroll = (JavascriptExecutor) driver;
					firstpagescroll.executeScript("window.scrollBy(0,200)");
					//driver.findElement(By.xpath("//*[@id='signupForm']/div[4]/button")).click();
					//Site Changes on 05-12-2021
					driver.findElement(By.xpath("//*[@id='btn_login']")).click();
					//driver.findElement(By.xpath("//*[@id='loginControl']/div/div[1]/div/input")).click();
					
					//WebElement submit = driver.findElement(By.id("LoginForm"));
					//submit.submit();
					Thread.sleep(5000);
					JavascriptExecutor js = (JavascriptExecutor) driver;
					js.executeScript("window.scrollBy(0,150)");
					driver.findElement(By.xpath("//*[@id='widFines']/div/div[2]/a")).click();
					/*Thread.sleep(3000);
					boolean isdashboard=driver.findElements(By.id("returnToDashboardId")).size()>0;
					if(isdashboard){
						driver.findElement(By.id("returnToDashboardId")).click();
					}*/
					
					/*if(driver.findElements(By.xpath("//*[@class='main-dashboard']/div[1]/div[1]/a")).size()>0){
						System.out.println("=======IF==========");
						driver.findElement(By.xpath("//*[@class='main-dashboard']/div[1]/div[1]/a")).click();
					}
					else if(driver.findElements(By.xpath("//*[@class='main-content']/div[9]/div[1]/a")))
					else{
						System.out.println("=======ELSE==========");
						driver.findElement(By.xpath("//*[@class='main-dashboard']/div[1]/div[1]/div[1]/div[2]/p[2]/a")).click();
					}*/
					//	driver.findElement(By.xpath("//*[@class='main-dashboard']/div[1]/div[1]/a")).click();
					//	driver.findElement(By.xpath("//*[@class='main-dashboard']/div[1]/div[1]/div[1]/div[2]/p[2]/a")).click();
					//driver.findElement(By.xpath("//*[@class='gotopage']/a")).click();
					Thread.sleep(1000);
					//Change in site.Licensing Services-New Page Added in between
					boolean islicensingPresent=driver.findElements(By.xpath("//*[@id='readThis']/div[3]/div[2]/div/div/ul/li/a")).size()>0;
					if(islicensingPresent){
						driver.findElement(By.xpath("//*[@id='readThis']/div[3]/div[2]/div/div/ul/li/a")).click();
						Thread.sleep(3000);
					}					
					boolean isDashboardPresent=driver.findElements(By.xpath("//*[@id='returnToDashboardId']")).size()>0;
					if(isDashboardPresent){
						driver.findElement(By.xpath("//*[@id='returnToDashboardId']")).click();
						Thread.sleep(3000);
						
					}
					driver.findElement(By.xpath("//*[@id='readMe']/div[4]/div[1]/div/div/div[2]/p[2]/a")).click();
					Thread.sleep(3000);
					driver.findElement(By.xpath("//*[@id='readMe']/div[5]/div[2]/div[2]/h3/label/a")).click();
					Thread.sleep(3000);
					/*driver.findElement(By.xpath("//*[@class='main-dashboard']/div[1]/div[1]/div[1]/div[2]/p[2]/a")).click();
					Thread.sleep(5000);*/
					/*Site Change-10-06-2019*/
					// driver.findElement(By.id("returnToDashboardId")).click();
//					driver.findElement(By.xpath("//*[@class='main-dashboard']/div[1]/div[1]/div[1]/div[2]/p[2]/a")).click();
					//driver.findElement(By.xpath("//*[@class='breadcrumb']/div[1]/div[1]/div[1]/div[1]/p/a[2]")).click();
					//driver.findElement(By.xpath("//*[@class='myfins']/a")).click();
					//Thread.sleep(2000);
					//System.out.println("Selected Year: "+getCmbyear());
					
					
					//driver.findElement(By.xpath("//*[@id='nav']/ul[2]/li[6]/a")).click();
					
					//driver.findElement(By.xpath("//*[@id='widFines']/div/div[2]/a")).click();
					
					//driver.findElement(By.xpath("//*[@class='srvdatarit fr']/p[2]/a")).click();
					
					//driver.findElement(By.xpath("//*[@class='myfins']/a")).click();
					
					/*Boolean iselementpresent = driver.findElements(By.id("ctl00_ucRtaHeader1_Header_ManageAccount")).size()!= 0;
					if(iselementpresent==true){
						driver.findElement(By.id("ctl00_ucRtaHeader1_Header_ManageAccount")).click();
					}*/

					//driver.findElement(By.id("ctl00_ucRtaHeader1_Header_ManageAccount")).click();

					//driver.findElement(By.xpath("//*[@id='set-2']/ul/li[2]/a/span")).click();
					//driver.findElement(By.xpath("//*[@id='show_manage_account']/span")).click();
					//					Thread.sleep(1000);
					//driver.findElement(By.xpath("//*[@id='layoutContainers']/div[2]/div[2]/div[2]/section/div[2]/table/tbody/tr/td[2]/a")).click();
					//					Thread.sleep(1000);
					//driver.findElement(By.xpath("//*[@id='readMe']/div[4]/div[1]/div/div/div[2]/p[2]/a/strong")).click();
					//					Thread.sleep(1000);
					//driver.findElement(By.xpath("//*[@id='readMe']/div[5]/div[2]/div[2]/h3/label/a")).click();
					//					Thread.sleep(1000);
					//driver.findElement(By.xpath("//*[@id='nav']/ul[2]/li[6]/a")).click();

					//String count=  driver.findElement(By.xpath("//*[@id='readMe']/ul/li[1]/a/p/span/em")).getText();
					//tcno1=driver.findElement(By.xpath("//*[@id='largboxId']/div/ul[2]/li/p[2]/span[2]")).getText();
					/*String count=  driver.findElement(By.xpath("//*[@id='readMe']/div[1]/div[2]/div[0]/div[1]/div[0]/div[0]/span/b")).getText();*/
					try{
					/*String count=  (driver.findElement(By.xpath("//*[@id='readMe']/div[2]/div[3]/div[1]/div[2]/div[1]/div[1]/span/b")).getText()).split(" ")[0];
					//System.out.println("Fine Count :"+count);
					int pagenos=Integer.parseInt(count)/10;
					int qot=Integer.parseInt(count)%10;
					if(qot>0){
						pagenos=pagenos+1;
					}*/

					//System.out.println("====pagenos===="+pagenos);


					// And iterate over them, getting the cells 
					

					int n=0;

					//for(int m=1;m<=pagenos;m++){

						//Overridden on 03-07-2018
						
						//List <WebElement> table=driver.findElements(By.className("fineEntry"));
					//List <WebElement> table=driver.findElements(By.className("regularfines/tbody/tr"));
					//Overridden on 13-04-2019
//					System.out.println("Page Count Text:"+driver.findElement(By.xpath("//*[@class='paginationCounts']")).getText()+"Delimited");
					
					//System.out.println("Fine Count :"+count);
					JavascriptExecutor jsreg = (JavascriptExecutor) driver;
					if(getHidchkblackpoints().trim().equalsIgnoreCase("0")){
						if(!getCmbyear().equalsIgnoreCase("")){
							//System.out.println("Html:"+driver.findElement(By.xpath("//*[@id='SkiDiv1']/div")).getAttribute("innerHTML"));
							Select finedropdown=new Select(driver.findElement(By.xpath("//*[@id='SkiDiv1']/div/ul/li[1]/select")));
							finedropdown.selectByVisibleText("Fine number");
							//driver.findElement(By.xpath("//*[@id='SkiDiv1']/div/ul/li[2]/a")).click();
							//Thread.sleep(1000);
							Select yeardropdown=new Select(driver.findElement(By.xpath("//*[@id='SkiDiv3']/div/ul/li[3]/select")));
							yeardropdown.selectByVisibleText(getCmbyear());
							driver.findElement(By.xpath("//*[@id='SkiDiv3']/div/ul/li[4]/a")).click();
							Thread.sleep(2000);
						}
					
						
						String pagecountarray[]=(driver.findElement(By.xpath("//*[@class='paginationCounts']")).getText()).split(" ");
						String count= pagecountarray[pagecountarray.length-1];
						int pagenos=Integer.parseInt(count)/10;
						int qot=Integer.parseInt(count)%10;
						if(qot>0){
							pagenos=pagenos+1;
						}
						int pagecounter=1;
						int j=0;
						System.out.println("Total Pages: "+pagenos);
						/*int pagenositr=pagenos;
						while(pagenositr>0){
							
							List<WebElement> anchornext1 = driver.findElements(By.xpath("//div[@class='paging'][1]/a"));
							Iterator<WebElement> i1 = anchornext1.iterator();
							while(i1.hasNext()){
								WebElement anchor1 = i1.next();
								if(anchor1.getText().contains("Next")){
									anchor1.click();
									System.out.println("======next click wait === ");
									Thread.sleep(5000);
									break;
								}
							}
							System.out.println("======"+pagenositr);
							pagenositr--;
						}*/
						String strrawcount=driver.findElement(By.xpath("//*[@id='conttab1']/ul/li[1]/strong[2]")).getText().trim();
						session.setAttribute("TOTALITEMCOUNT",strrawcount);
						//pagecounter=9;
						while(pagecounter<=pagenos){
							
//							System.out.println("===== BEFORE LOOP ==========");
							int rowlength=driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr")).size();
							//System.out.println("FineEntry Length:"+rowlength);
							int k=0;
								
//								System.out.println("===== AFTER =========="+rowlength);
								for(int z=1,rowindex=2;z<=rowlength;z++,rowindex++){
									if(rowindex<=rowlength){
										/*if(driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div")).size()==2){
											regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[2]")).getText().trim();
										}
										else if(driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div")).size()==3){
											regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[3]")).getText().trim();
										}
										
//										System.out.println("//table[@class='regularfines']/tbody/tr["+rowindex+"]");
										pcolor="";
										WebElement elmpcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]"));
										if(elmpcolor.getAttribute("innerHTML").contains("div")){
											pcolor=driver.findElement(By.xpath("//table[@class='regul
											
											
											
											arfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[1]")).getText().trim();
										}*/
										pcolor="";
										//System.out.println("Page Counter:"+pagecounter);
										//System.out.println(driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]")).getAttribute("innerHTML").trim());
										String regraw = (String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4)').innerHTML;");
										if(regraw.trim().equalsIgnoreCase("")){
											continue;
										}
										String strregno = (String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4) div:nth-child(1) div').innerHTML;");
										/*if(driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]")).getAttribute("innerHTML").trim().equalsIgnoreCase("")){
											continue;
										}*/
										if(strregno.trim().equalsIgnoreCase("")){
											continue;
										}
										//System.out.println("Reg Container:"+driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]")).getAttribute("innerHTML").trim());
										if(driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div")).size()==2){
											//regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[2]")).getAttribute("innerHTML").trim();
											regNo=((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4) div:nth-child(1) div:nth-child(2)').innerHTML;")).trim();
											if(regNo.trim().equalsIgnoreCase("")){
												regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[2]")).getText();
											}
											pcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[1]")).getText().trim();
											if(pcolor.trim().equalsIgnoreCase("")){
												//pcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[1]")).getAttribute("innerHTML").trim();
												pcolor=((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4) div:nth-child(1) div:nth-child(1)').innerHTML;")).trim();
											}
										}
										else{
											//regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[@class='number']")).getAttribute("innerHTML").trim();
											WebElement regnowrapper=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[1]"));
											if(regnowrapper.getAttribute("class").contains("expo-plate")) {
												regNo=((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4) div:nth-child(1) div:nth-child(1) div.number').innerHTML;")).trim();
												if(regNo.trim().equalsIgnoreCase("")){
													regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[1]/div[@class='number']")).getText();
												}
												pcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[1]/div[@class='code']")).getText().trim();
												if(pcolor.trim().equalsIgnoreCase("")){
													//pcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[@class='code']")).getAttribute("innerHTML").trim();
													pcolor=((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4) div:nth-child(1) div:nth-child(1) div.code').innerHTML;")).trim();
												}
											}
											else {
												regNo=((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4) div:nth-child(1) div.number').innerHTML;")).trim();
												if(regNo.trim().equalsIgnoreCase("")){
													regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[@class='number']")).getText();
												}
												pcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[@class='code']")).getText().trim();
												if(pcolor.trim().equalsIgnoreCase("")){
													//pcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[@class='code']")).getAttribute("innerHTML").trim();
													pcolor=((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4) div:nth-child(1) div.code').innerHTML;")).trim();
												}
											}
											
										}
										
										//System.out.println("Reg No:"+regNo);
										
										//regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[3]")).getText().trim();
										//System.out.println("Rseg No:"+regNo+",Plate:"+pcolor);
										//System.out.println(driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]")).getAttribute("innerHTML"));
										
										String datetime=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[2]")).getText().trim();
										String finenumber=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[7]")).getText().trim();
										Ticket_No=finenumber.replaceAll("[^0-9_-_._;_: ]+", "");
										
										fine_Source=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]")).getText().trim();
										System.out.println("Ticket_No:"+Ticket_No);
										String reasonmain="";
										location="";
										JavascriptExecutor js2 = (JavascriptExecutor) driver;
										js2.executeScript("window.scrollBy(0,200)");
										WebElement reasonhtml=driver.findElement(By.id("actions_div"+(z-1)));
										//System.out.println(reasonhtml.findElement(By.xpath("li[1]/p")).getAttribute("innerHTML").toString());
										//System.out.println(reasonhtml.findElement(By.xpath("li[2]/p")).getAttribute("innerHTML").toString());
										if(reasonhtml.findElement(By.xpath("li[1]/p"))!=null){
											//reasonmain=reasonhtml.findElement(By.xpath("li[1]/p")).getAttribute("innerHTML").trim();
											reasonmain=((String) jsreg.executeScript("return document.querySelector('#actions_div"+(z-1)+" li:nth-child(1) p').innerHTML;")).trim();
										}
										if(reasonhtml.findElements(By.xpath("li")).size()>=2){
											//location=reasonhtml.findElement(By.xpath("li[2]/p")).getAttribute("innerHTML").trim().replaceAll("[^a-zA-Z0-9 ]+", "").trim();
											location=((String) jsreg.executeScript("return document.querySelector('#actions_div"+(z-1)+" li:nth-child(2) p').innerHTML;")).trim().replaceAll("[^a-zA-Z0-9 ]+", "").trim();
										}
										WebElement elm=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/a"));
	/*									//String onclickfunc=elm.getAttribute("onclick");
										js2.executeScript("arguments[0].click();", elm);
										//driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/a")).click();
										if(driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/ul/li[1]/p"))!=null){
											reasonmain=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/ul/li[1]/p")).getText().trim();
										}
										else{
											reasonmain="";
										}
										System.out.println("Reason:"+reasonmain);
	*/									String amount=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[5]")).getText().trim();
//										System.out.println("Amount1:"+amount);
	/*									location="";
										if(driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/ul/li")).size()>=2){
											location=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/ul/li[2]/p")).getText().trim().replaceAll("[^a-zA-Z0-9 ]+", "").trim();
										}
										else{
											location="";
										}
										//driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/a")).click();
										js2.executeScript("arguments[0].click();", elm);
										System.out.println("location === "+location);
	*/									type="TRF";
//										System.out.println("PCOLOR:"+pcolor+"//Reg No:"+regNo+"//DateTime:"+datetime+"//Fine Number"+finenumber+"//ReasonLocation"+reasonmain+"//Amount:"+amount);
										j++;
//										System.out.println("Counter:"+j);
										
										
									      try{
									         /*//Converting the input String to Date
									    	 //Date date= df.parse(input);
									         //Changing the format of date and storing it in String
									    	 String output = outputformat.format(date);
									    	 traffic_date=objcommon.changeStringtoSqlDate(new SimpleDateFormat("dd.MM.yyyy").format(date));
									         Time=new SimpleDateFormat("HH:mm").format(date);
									    	 //Displaying the date
									    	 //System.out.println(output);
			*/						         SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy HH:mm");
											java.util.Date date = sdf1.parse(datetime);
											traffic_date = new java.sql.Date(date.getTime());
											Time=new SimpleDateFormat("HH:mm").format(date);
		//									System.out.println(datetime);
		//									System.out.println(traffic_date);
		//									System.out.println(Time);
									      }catch(ParseException pe){
									         pe.printStackTrace();
									      }
										regNo=regNo.substring(0,regNo.length()).replaceAll("[^0-9]+", "");
										/*String test1[]=reasonmain.split("Location");
										DESC1=((test1[0].replaceAll("[^a-zA-Z0-9 ]+", "").trim()).replace("Reason", "")).trim();
		//								System.out.println("===== "+test1.length);
										if(test1.length>1){
										if(!(test1[1].equalsIgnoreCase(""))){
											location=test1[1].replaceAll("[^a-zA-Z0-9 ]+", "").trim();
										}
										}*/
										DESC1=reasonmain.replaceAll("[^a-zA-Z0-9 ]+", "").trim();
										location=location.replaceAll("[^a-zA-Z0-9 ]+", "").trim();
										Amount=amount.replaceAll("[^0-9_-_._;_: ]+", "");
//										System.out.println("Amount2:"+Amount);
										n++;
										k++;
										if(k!=0){
		
		
											plate_source="Dubai";
		
		
											java.util.Date dates=new  java.util.Date();
		
		
											java.sql.Date date=com.getSqlDate(dates);
		
	/*										System.out.println("==Ticket_No==="+Ticket_No+"==traffic_date==="+traffic_date+"==Time==="+Time+"==fine_Source==="
											+ ""+fine_Source+"==regNo==="+regNo+"PlateCategory"+PlateCategory+"pcolor"+pcolor+""+Double.parseDouble(Amount)+""
											+Double.parseDouble(Amount)+"type"+type+"date"+date);
	*/										 
											
											result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,null,null,null,
													Double.parseDouble(Amount),location,Amount,DESC1,null,type,category,srno+n,tcno1,xdoc,date,branch,plate_source,
													getCmbtrafficsite(),DESC1,xdocs);
										}
									
									}
								Thread.sleep(5000);	
								}
								
								if(pagecounter==pagenos){
									//driver.quit();
									break;
								}
								System.out.println(pagecounter+"::"+pagenos);
								if(pagecounter<=pagenos){
									List<WebElement> anchornext = driver.findElements(By.xpath("//div[@class='paging'][1]/a"));
									Iterator<WebElement> i = anchornext.iterator();
									while(i.hasNext()){
										WebElement anchor = i.next();
										if(anchor.getText().contains("Next")){
											//anchor.click();
											
											js.executeScript("arguments[0].click();", anchor);
											pagecounter++;
											break;
										}
									}
									/*int nextanchor=driver.findElements(By.xpath("//div[@class='paging'][1]/a")).size();
									if(nextanchor==1){
										driver.findElement(By.xpath("//div[@class='paging'][1]/a")).click();
									}
									else{
										driver.findElement(By.xpath("//div[@class='paging'][1]/a[2]")).click();
									}*/
									
									Thread.sleep(2000);
									
								}
								
						}
					}
					
					if(getHidchkblackpoints().equalsIgnoreCase("1")){
						Thread.sleep(2000);
						JavascriptExecutor jsblack = (JavascriptExecutor) driver;
						jsblack.executeScript("window.scrollBy(0,500)");
						WebElement element = driver.findElement(By.xpath("//*[@id='readMe']/ul/li[2]/a"));
						JavascriptExecutor executor = (JavascriptExecutor)driver;
						executor.executeScript("arguments[0].click();", element);
						Thread.sleep(5000);
						if(!getCmbyear().equalsIgnoreCase("")){
							//System.out.println("Html:"+driver.findElement(By.xpath("//*[@id='SkiDiv1']/div")).getAttribute("innerHTML"));
							Select finedropdown=new Select(driver.findElement(By.xpath("//*[@id='SkiDiv11']/div/ul/li[1]/select")));
							finedropdown.selectByVisibleText("Fine number");
							//driver.findElement(By.xpath("//*[@id='SkiDiv1']/div/ul/li[2]/a")).click();
							//Thread.sleep(1000);
							Select yeardropdown=new Select(driver.findElement(By.xpath("//*[@id='SkiDiv33']/div/ul/li[3]/select")));
							yeardropdown.selectByVisibleText(getCmbyear());
							driver.findElement(By.xpath("//*[@id='SkiDiv33']/div/ul/li[4]/a")).click();
							Thread.sleep(2000);
						}
						String blockedpagecountarray[]=(driver.findElement(By.xpath("//*[@class='paginationCounts']")).getText()).split(" ");
						String count= blockedpagecountarray[blockedpagecountarray.length-1];
						int pagenos=Integer.parseInt(count)/10;
						int qot=Integer.parseInt(count)%10;
						if(qot>0){
							pagenos=pagenos+1;
						}
						int pagecounter=1;
						int j=0;
						System.out.println("Total Pages: "+pagenos);
						
						while(pagecounter<=pagenos){
							
//							System.out.println("===== BEFORE LOOP ==========");
							int rowlength=driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr")).size();
							//System.out.println("FineEntry Length:"+rowlength);
								int k=0;
								int scrollcounter=0;
//								System.out.println("===== AFTER =========="+rowlength);
								for(int z=1,rowindex=2;z<=rowlength;z++,rowindex++){
									if(rowindex<=rowlength){
										if(driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]/div[1]/div")).size()==2){
											regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]/div[1]/div[2]")).getText().trim();
										}
										else if(driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]/div[1]/div")).size()==3){
											regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]/div[1]/div[3]")).getText().trim();
										}
										
//										System.out.println("//table[@class='regularfines']/tbody/tr["+rowindex+"]");
										pcolor="";
										WebElement elmpcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]"));
										
										if(((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(3)').innerHTML;")).trim().contains("div")){
											pcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]/div[1]/div[1]")).getText().trim();
										}
										String datetime=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[1]")).getText().trim();
										String finenumber=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[7]")).getText().trim();
										Ticket_No=finenumber.replaceAll("[^0-9_-_._;_: ]+", "");
										fine_Source=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[2]")).getText().trim();
										System.out.println("Fine Source:"+fine_Source);
										String reasonmain="";
										JavascriptExecutor js2 = (JavascriptExecutor) driver;
										js2.executeScript("window.scrollBy(0,200)");
										WebElement elm=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/a"));
										//String onclickfunc=elm.getAttribute("onclick");
										js2.executeScript("arguments[0].click();", elm);
										//driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/a")).click();
										if(driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/ul/li[1]/p"))!=null){
											reasonmain=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/ul/li[1]/p")).getText().trim();
										}
										else{
											reasonmain="";
										}
										System.out.println("Reason:"+reasonmain);
										String amount=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]")).getText().trim();
//										System.out.println("Amount1:"+amount);
										location="";
										if(driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/ul/li")).size()>=2){
											//location=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/ul/li[2]/p")).getAttribute("innerHTML").trim();
											location=((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(8) ul li:nth-child(2) p').innerHTML;")).trim().replaceAll("[^a-zA-Z0-9 ]+", "").trim();
//											System.out.println("1 location === "+location);
										}
										else{
//											System.out.println("blank location === "+location);
											location="";
										}
										//driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/a")).click();
										js2.executeScript("arguments[0].click();", elm);
//										System.out.println("location === "+location);
										type="TRF";
										System.out.println("PCOLOR:"+pcolor+"//Reg No:"+regNo+"//DateTime:"+datetime+"//Fine Number"+finenumber+"//ReasonLocation"+reasonmain+"//Amount:"+amount);
										j++;
//										System.out.println("Counter:"+j);
										
										
									      try{
									         /*//Converting the input String to Date
									    	 //Date date= df.parse(input);
									         //Changing the format of date and storing it in String
									    	 String output = outputformat.format(date);
									    	 traffic_date=objcommon.changeStringtoSqlDate(new SimpleDateFormat("dd.MM.yyyy").format(date));
									         Time=new SimpleDateFormat("HH:mm").format(date);
									    	 //Displaying the date
									    	 //System.out.println(output);
			*/						         SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy HH:mm");
											java.util.Date date = sdf1.parse(datetime);
											traffic_date = new java.sql.Date(date.getTime());
											Time=new SimpleDateFormat("HH:mm").format(date);
		//									System.out.println(datetime);
		//									System.out.println(traffic_date);
		//									System.out.println(Time);
									      }catch(ParseException pe){
									         pe.printStackTrace();
									      }
										regNo=regNo.substring(0,regNo.length()).replaceAll("[^0-9]+", "");
										/*String test1[]=reasonmain.split("Location");
										DESC1=((test1[0].replaceAll("[^a-zA-Z0-9 ]+", "").trim()).replace("Reason", "")).trim();
		//								System.out.println("===== "+test1.length);
										if(test1.length>1){
										if(!(test1[1].equalsIgnoreCase(""))){
											location=test1[1].replaceAll("[^a-zA-Z0-9 ]+", "").trim();
										}
										}*/
										DESC1=reasonmain.replaceAll("[^a-zA-Z0-9 ]+", "").trim();
										//location=location.replaceAll("[^a-zA-Z0-9 ]+", "").trim();
//										System.out.println("after replace "+location);
										Amount=amount.replaceAll("[^0-9_-_._;_: ]+", "");
//										System.out.println("Amount2:"+Amount);
										n++;
										k++;
										if(k!=0){
		
		
											plate_source="Dubai";
		
		
											java.util.Date dates=new  java.util.Date();
		
		
											java.sql.Date date=com.getSqlDate(dates);
		
	/*										System.out.println("==Ticket_No==="+Ticket_No+"==traffic_date==="+traffic_date+"==Time==="+Time+"==fine_Source==="
											+ ""+fine_Source+"==regNo==="+regNo+"PlateCategory"+PlateCategory+"pcolor"+pcolor+""+Double.parseDouble(Amount)+""
											+Double.parseDouble(Amount)+"type"+type+"date"+date);
	*/										 
											
											result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,null,null,null,
													Double.parseDouble(Amount),location,Amount,DESC1,null,type,category,srno+n,tcno1,xdoc,date,branch,plate_source,
													getCmbtrafficsite(),DESC1,xdocs);
										}
									
									}
								Thread.sleep(5000);	
								}
								
								if(pagecounter==pagenos){
									driver.quit();
									break;
								}
								System.out.println(pagecounter+"::"+pagenos);
								if(pagecounter<=pagenos){
									List<WebElement> anchornext = driver.findElements(By.xpath("//div[@class='paging'][1]/a"));
									Iterator<WebElement> i = anchornext.iterator();
									while(i.hasNext()){
										WebElement anchor = i.next();
										if(anchor.getText().contains("Next")){
											//anchor.click();
											
											js.executeScript("arguments[0].click();", anchor);
											pagecounter++;
											break;
										}
									}
									/*int nextanchor=driver.findElements(By.xpath("//div[@class='paging'][1]/a")).size();
									if(nextanchor==1){
										driver.findElement(By.xpath("//div[@class='paging'][1]/a")).click();
									}
									else{
										driver.findElement(By.xpath("//div[@class='paging'][1]/a[2]")).click();
									}*/
									Thread.sleep(2000);
									
								}
								
						}
					}
					
						/*for(int z=1,rowindex=2;z<=rowlength;z++,rowindex++){
							driver.findElement(By.xpath("//div[@class='readMe']/div[1]/div[2]/div[0]/div[1]/div[0]/div[0]/span/b")).getText();
							driver.findElement(By.xpath("//table[@class='fineEntry']/["+z+"]/div[3]/div[2]/div[1]/div[1]/div[2]/div[1]/p/a")).click();
							pcolor=driver.findElement(By.xpath("//div[@class='fineEntry']["+z+"]/div[1]/div[1]/div[1]")).getText().trim();
							//System.out.println("Pcolor:"+pcolor);
							//System.out.println(driver.findElement(By.xpath("//div[@class='fineEntry']["+z+"]/div[1]/div[1]/div[2]")).getText().trim());
							//FOR CAR
							//regNo=driver.findElement(By.xpath("//div[@class='fineEntry']["+z+"]/div[1]/div[1]/div[3]")).getText().trim();
							//FOR BIKE
							//driver.findElement(By.xpath("//div[@class='fineEntry']["+z+"]/div[1]/div[1]/div[2]")).getText().trim();
							WebElement platediv=driver.findElement(By.xpath("//div[@class='fineEntry']["+z+"]/div[1]/div[1]"));
							String plateclass=platediv.getAttribute("class");
							if(plateclass.contains("plate-short")){
								regNo=driver.findElement(By.xpath("//div[@class='fineEntry']["+z+"]/div[1]/div[1]/div[2]")).getText().trim();
								
							}
							else{
								regNo=driver.findElement(By.xpath("//div[@class='fineEntry']["+z+"]/div[1]/div[1]/div[3]")).getText().trim();
							}
							
							if(regNo.equalsIgnoreCase("") || regNo==null){
								driver.findElement(By.xpath("//div[@class='fineEntry']["+z+"]/div[1]/div[1]/div[2]")).getText().trim();
							}
							String datetime=driver.findElement(By.xpath("//div[@class='fineEntry']["+z+"]/div[2]/div[1]/p")).getText();
							String finenumber=driver.findElement(By.xpath("//div[@class='fineEntry']["+z+"]/div[3]/div[1]/div[1]/div[1]/div[1]/div[1]/p/b")).getText();
							finenumber=finenumber.replace("Fine Number", "");
							Ticket_No=finenumber.replaceAll("[^0-9_-_._;_: ]+", "");
							fine_Source=driver.findElement(By.xpath("//div[@class='fineEntry']["+z+"]/div[2]/div[2]/p")).getText().trim().split(":")[1];
							String reasonmain=driver.findElement(By.xpath("//div[@class='fineEntry']["+z+"]/div[4]/div[1]/div[1]/p")).getText().trim();
							String reason=reasonmain[0];
							location=reasonmain[1];
							String amount=driver.findElement(By.xpath("//div[@class='fineEntry']["+z+"]/div[3]/div[3]/p/b")).getText();
							amount=amount.replace(" AED", "");
							type="TRF";
							System.out.println("PCOLOR:"+pcolor+"//Reg No:"+regNo+"//DateTime:"+datetime+"//Fine Number"+finenumber+"//ReasonLocation"+reasonmain+"//Amount:"+amount);
							j++;
							System.out.println("Counter:"+j);
							
							DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
							Time=data.substring( data.lastIndexOf( ' ') + 1);
							System.out.println("==Time==="+Time);
							datetime=(datetime.substring(0,2)+"/"+datetime.substring(3,5) +"/"+ datetime.substring(6,10));
							try {
								java.util.Date date1 = formatter.parse(datetime);
								java.sql.Date dtvalue=new java.sql.Date(date1.getTime());
								//fBrowse.cache.setData("traffic_date", dtvalue);
								traffic_date=dtvalue;
								System.out.println("==traffic_date==="+traffic_date);

							} catch (ParseException e) {e.printStackTrace();}
							
							String input = datetime.substring(15,34);
						    //Format of the date defined in the input String
						    DateFormat df = new SimpleDateFormat("dd-MM-yyyy hh:mm aa");
						    //Desired format: 24 hour format: Change the pattern as per the need
						    DateFormat outputformat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
						      try{
						         //Converting the input String to Date
						    	 Date date= df.parse(input);
						         //Changing the format of date and storing it in String
						    	 String output = outputformat.format(date);
						    	 traffic_date=objcommon.changeStringtoSqlDate(new SimpleDateFormat("dd.MM.yyyy").format(date));
						         Time=new SimpleDateFormat("HH:mm").format(date);
						    	 //Displaying the date
						    	 //System.out.println(output);
						    	 
						      }catch(ParseException pe){
						         pe.printStackTrace();
						       }
							regNo=regNo.substring(0,regNo.length()).replaceAll("[^0-9]+", "");
							String test1[]=reasonmain.split("Location");
							DESC1=((test1[0].replaceAll("[^a-zA-Z0-9 ]+", "").trim()).replace("Reason", "")).trim();
//							System.out.println("===== "+test1.length);
							if(test1.length>1){
							if(!(test1[1].equalsIgnoreCase(""))){
								location=test1[1].replaceAll("[^a-zA-Z0-9 ]+", "").trim();
							}
							}
							Amount=amount.replaceAll("[^0-9_-_._;_: ]+", "");
							n++;
							k++;
							if(k!=0){


								plate_source="Dubai";


								java.util.Date dates=new  java.util.Date();


								java.sql.Date date=com.getSqlDate(dates);

								System.out.println("==Ticket_No==="+Ticket_No+"==traffic_date==="+traffic_date+"==Time==="+Time+"==fine_Source==="
								+ ""+fine_Source+"==regNo==="+regNo+"PlateCategory"+PlateCategory+"pcolor"+pcolor+"Double.parseDouble(Amount)"
								+Double.parseDouble(Amount)+"type"+type+"date"+date);
								 
								
								result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,null,null,null,
										Double.parseDouble(Amount),location,Amount,DESC1,null,type,category,srno+n,tcno1,xdoc,date,branch,plate_source,
										getCmbtrafficsite(),"",xdocs);
							}
							
						}*/
					}
					catch(Exception e){
						e.printStackTrace();
					}
						//System.out.println("after 1st page completed");

/*						if (driver instanceof JavascriptExecutor) {
							System.out.println("goToPage("+m+"-1)");
							((JavascriptExecutor)driver).executeScript("goToPage("+m+"-1);");
						}

						else {
						    throw new IllegalStateException("This driver does not support JavaScript!");
						}
						//						Thread.sleep(1000);
						if(m!=pagenos){
							int a=m+1;
							if(m==1){
								driver.findElement(By.xpath("//*[@id='conttab1']/div[5]/table/tbody/tr[1]/td/div/a")).click();
							}
							else{
								//driver.findElement(By.xpath("//*[@id='conttab1']/div[5]/table/tbody/tr[1]/td/div/a["+m+"]")).click();

								driver.findElement(By.xpath("//*[@id='conttab1']/div[5]/table/tbody/tr[1]/td/div/a[2]")).click();
							}
							//							Thread.sleep(5000);
						}*/


						
/*						WebElement table = driver.findElement(By.className("regularfines")); 

						// Now get all the TR elements from the table 
						List<WebElement> allRows = table.findElements(By.tagName("tr")); 

						int rowlen=allRows.size();

						//						System.out.println("====m====m======"+m);
						int k=0;
						for (WebElement row : allRows) { 
							List<WebElement> cells = row.findElements(By.tagName("td")); 

							int colen=cells.size();	
							//							System.out.println("====colen======"+colen);
							int j=0;
							for (WebElement cell : cells) { 

								//								System.out.println("====datatatatata"+j+"=="+cell.getText());
								data=cell.getText();

								//								System.out.println("==datadatadatadata====="+data);

								if(j==1){
									DateFormat   formatter = new SimpleDateFormat("dd/MM/yyyy");

									Time=data.substring( data.lastIndexOf( ' ') + 1);

									//									System.out.println("==Time==="+Time);

									data=(data.substring(0,2)+"/"+data.substring(3,5) +"/"+ data.substring(6,10));

									try {
										java.util.Date date1 = formatter.parse(data);
										java.sql.Date dtvalue=new java.sql.Date(date1.getTime());
										//fBrowse.cache.setData("traffic_date", dtvalue);
										traffic_date=dtvalue;

										//										System.out.println("==traffic_date==="+traffic_date);

									} catch (ParseException e) {e.printStackTrace();} 


								}
								if(j==2){
									fine_Source=data;
								}

								if(j==3){
									if(!data.equalsIgnoreCase("")){
										pcolor=data.substring(0,1);
										regNo=data.substring(1,data.length()).replaceAll("[^0-9]+", "");
									}
								}
								if(j==4){
									Amount=data.replaceAll("[^0-9_-_._;_: ]+", "");
								}
								if(j==6){
									Ticket_No=data.replaceAll("[^0-9_-_._;_: ]+", "");
								}
								if(j==7){

									int l=k+1;
									int t=k-1;
									driver.findElement(By.xpath("//*[@id='conttab1']/table/tbody/tr["+l+"]/td[8]/a/em")).click();
									String test=driver.findElement(By.xpath("//*[@id='actions_div"+t+"']")).getText().replaceAll("[^a-zA-Z0-9 ]+", "").replaceAll("Violations", "");
									String test1[]=test.split("Location");
									DESC1=test1[0].replaceAll("[^a-zA-Z0-9 ]+", "").trim();
//									System.out.println("===== "+test1.length);
									if(test1.length>1){
									if(!(test1[1].equalsIgnoreCase(""))){
										location=test1[1].replaceAll("[^a-zA-Z0-9 ]+", "").trim();
									}
									}

								}


								j++;
							}
*/
/*							if(k!=0){


								plate_source="Dubai";


								java.util.Date dates=new  java.util.Date();


								java.sql.Date date=com.getSqlDate(dates);

																System.out.println("==Ticket_No==="+Ticket_No+"==traffic_date==="+traffic_date+"==Time==="+Time+"==fine_Source==="
										+ ""+fine_Source+"==regNo==="+regNo+"PlateCategory"+PlateCategory+"pcolor"+pcolor+"Double.parseDouble(Amount)"
										+Double.parseDouble(Amount)+"type"+type+"date"+date);
								 
								
								result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,null,null,null,
										Double.parseDouble(Amount),location,null,DESC1,null,type,category,srno+n,tcno1,xdoc,date,branch,plate_source,
										getCmbtrafficsite(),"",xdocs);
							}
							n++;
							k++;*/
						
/*
						System.out.println("after 1st page completed");

						if (driver instanceof JavascriptExecutor) {
							System.out.println("goToPage("+m+"-1)");
							((JavascriptExecutor)driver).executeScript("goToPage("+m+"-1);");
						}

						else {
						    throw new IllegalStateException("This driver does not support JavaScript!");
						}
						//						Thread.sleep(1000);
						if(m!=pagenos){
							int a=m+1;
							if(m==1){
								driver.findElement(By.xpath("//*[@id='conttab1']/div[5]/table/tbody/tr[1]/td/div/a")).click();
							}
							else{
								//driver.findElement(By.xpath("//*[@id='conttab1']/div[5]/table/tbody/tr[1]/td/div/a["+m+"]")).click();

								driver.findElement(By.xpath("//*[@id='conttab1']/div[5]/table/tbody/tr[1]/td/div/a[2]")).click();
							}
							//							Thread.sleep(5000);
						}
*/


						
					//}


					//					Thread.sleep(1000);
/*					driver.findElement(By.xpath("//*[@id='readMe']/ul/li[2]/a/p")).click();
					//					Thread.sleep(1000);
					count=  driver.findElement(By.xpath("//*[@id='readMe']/ul/li[2]/a/p/span")).getText();



					pagenos=Integer.parseInt(count)/10;
					qot=Integer.parseInt(count)%10;
					if(qot>0){
						pagenos=pagenos+1;
					}

*/					//					System.out.println("====pagenos in second tab==="+pagenos);

				//	for(int m=1;m<=pagenos;m++){
						//						System.out.println("====m====m======"+m);
/*
						WebElement table = driver.findElement(By.className("regularfines")); 

						// Now get all the TR elements from the table 
						List<WebElement> allRows = table.findElements(By.tagName("tr")); 

						int rowlen=allRows.size();

						//						System.out.println("====m====m======"+m);
						//						Thread.sleep(5000);
						int k=0;
						for (WebElement row : allRows) { 
							List<WebElement> cells = row.findElements(By.tagName("td")); 

							int colen=cells.size();	
							//							System.out.println("====colen======"+colen);
							int j=0;
							for (WebElement cell : cells) { 

								//								System/.out.println("====datatatatata"+j+"=="+cell.getText());
								data=cell.getText();

								if(j==0){
									DateFormat   formatter = new SimpleDateFormat("dd/MM/yyyy");

									Time=data.substring( data.lastIndexOf( ' ') + 1);

									//									System.out.println("==Time==="+Time);

									data=(data.substring(0,2)+"/"+data.substring(3,5) +"/"+ data.substring(6,10));

									try {
										java.util.Date date1 = formatter.parse(data);
										java.sql.Date dtvalue=new java.sql.Date(date1.getTime());
										//fBrowse.cache.setData("traffic_date", dtvalue);
										traffic_date=dtvalue;

										//										System.out.println("==traffic_date==="+traffic_date);

									} catch (ParseException e) {e.printStackTrace();} 


								}
								if(j==1){
									fine_Source=data;
								}

								if(j==2){
									pcolor=data.substring(0,1);
									regNo=data.substring(1,data.length()).replaceAll("[^0-9]+", "");
								}
								if(j==3){
									Amount=data.replaceAll("[^0-9_-_._;_: ]+", "");
								}
								if(j==6){
									Ticket_No=data.replaceAll("[^0-9_-_._;_: ]+", "");
								}
								if(j==7){

									int l=k+1;
									int t=k-1;
									driver.findElement(By.xpath("//*[@id='conttab2']/table/tbody/tr["+l+"]/td[8]/a/em")).click();
									String test=driver.findElement(By.xpath("//*[@id='actions_div"+t+"']")).getText().replaceAll("[^a-zA-Z0-9 ]+", "").replaceAll("Violations", "");
									String test1[]=test.split("Location");
									DESC1=test1[0].replaceAll("[^a-zA-Z0-9 ]+", "").trim();

								}

								j++;
							}
*/

						//System.out.println("after 1st page completed");

						/*if (driver instanceof JavascriptExecutor) {
							System.out.println("goToPage("+m+"-1)");
							((JavascriptExecutor)driver).executeScript("goToPage("+m+"-1);");
						}

						else {
						    throw new IllegalStateException("This driver does not support JavaScript!");
						}*/
						//						Thread.sleep(1000);
						/*if(m!=pagenos){
							int a=m+1;
							if(m==1){
								driver.findElement(By.xpath("//*[@id='conttab2']/div[5]/table/tbody/tr[1]/td/div/a")).click();
							}
							else{
								//driver.findElement(By.xpath("//*[@id='conttab2']/div[5]/table/tbody/tr[1]/td/div/a["+m+"]")).click();
								driver.findElement(By.xpath("//*[@id='conttab2']/div[5]/table/tbody/tr[1]/td/div/a[2]")).click();
							}
						}*/
						//						Thread.sleep(5000);


				//	}



				}
			}

			if(getCategory().equalsIgnoreCase("salik"))
			{ 
				if(getCmbsaliksite().equalsIgnoreCase("DXB"))	
				{
					if(flag)
					{
						String k="";
						int d=Integer.parseInt(dat);
						int stpage =txtStPage;
						int count=2,i;

						//int stimer=0;						

						for(i=2;i<=d;i++)
						{
							boolean getdata = true;
							k=String.valueOf((i));
							if(Integer.parseInt(k)<10) k="0"+k;
							WebElement s;
							try
							{

								//	stimer=(i%2==0?30:(i%11==0?6:15));		//15 and 30 for alternate page. for next set of pages 6 seconds.

								if ((i-1)==1){

									//inputCaptcha("Processing "+i+" of "+d+" Pages");
								}


								//Thread.sleep(15*1000);//commented by krish

								if(stpage>d)
								{
									//JOptionPane.showMessageDialog(this.getParent(),MyLib.getUID("Start Page# exceeds total no. of pages - "+d));
									//driver.quit();
									return false;
								}
								else if (stpage>1 && i<stpage)
								{
									if (stpage <= (i+(10-(i%10))))
									{

										s=driver.findElement(By.partialLinkText(String.valueOf(stpage)));
										s.click();
										i=stpage;
									}
									else
									{


										s=driver.findElement(By.xpath("//*[@title='Next pages']"));
										s.click();
										i+=(10-(i%10));

										getdata=false;
									}
								}
								else
								{

									s=driver.findElement(By.linkText(String.valueOf(i)));
									//s=driver.findElement(By.partialLinkText(String.valueOf((i))));   				
									s.click();
								}
							}
							catch (Exception e)
							{
								try
								{
									e.printStackTrace();

									s=driver.findElement(By.xpath("//*[@title='Next page']"));
									s.click();
								}catch(Exception e1)
								{
									conn.close();
									e1.printStackTrace();

									//driver.quit();



									txtStPage=i-1;						             
									loadfresh();
								}
							}
							/*if (driver instanceof JavascriptExecutor) {       		

				       			((JavascriptExecutor)driver).executeScript("AjaxNS.AR('ctl00$WorkSpace$ctlCustAVIHistory$rgResult$ctl01$ctl03$ctl01$ctl"+k+"','', 'WorkSpace_ctlCustAVIHistory_ajxResultPanel', event);");
				       			String s="ctl00$WorkSpace$ctlCustAVIHistory$rgResult$ctl01$ctl03$ctl01$ctl10";

				       		 }*/

							doc=null;


							WebElement we=null;
							int cnt=0;
							do
							{  
								if(count==d)
								{

									Thread.sleep(1000);	
								}
								//Thread.sleep(1000);//--commented by krish
								we = driver.findElement(By.id("ctl00_WorkSpace_ctlCustAVIHistory_RadAjaxPanelPlate"));
								String style = we.getAttribute("style").trim();

								if (!style.isEmpty())
									we=null;
								cnt++;
							}while(we==null && cnt<10);
							count++;
							//	 Thread.sleep(20000);


							url=driver.getCurrentUrl();




							if (getdata)
								result=jsoupGetTableData(i);

							if(count>d)
							{
								//Thread.sleep(5000);
								//loadData();
								Thread.interrupted();
								//driver.quit();
							}
							//  count++;
						}
					}
				}
			}

		}
		catch(Exception e){
			e.printStackTrace();
			//driver.quit();
			conn.close();
			
		}
		return result;
	}

	public boolean jsoupGetTableData(int v) throws IOException, InterruptedException, SQLException, ParseException
	{
		ScriptEngineManager factory = new ScriptEngineManager();

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		boolean result=false;

		Elements tableElements = null;
		Elements rowItems=null;
		Elements roi=null;
		PreparedStatement prepst,iprepst;
		String textdescription="";


		//DXB//
		if(getCategory().equalsIgnoreCase("traffic"))
		{			 

			if(getCmbtrafficsite().trim().equalsIgnoreCase("DXB"))
			{
				tableElements = doc.select("table.srchrsult");//div#pnlResults

			}
			else if(getCmbtrafficsite().equalsIgnoreCase("AUH"))
			{
				tableElements = doc.select("table#ctl00_ContentPlaceHolder1_gvTickets");
				tableElements.size();
			}
			Elements tableHeaderEles = tableElements.select("thead tr th");

			for (int i = 0; i < tableHeaderEles.size(); i++) 
			{


			}


			try{
				ResultSet rs = conn.createStatement().executeQuery("Select coalesce((max(doc_no)+1),1) max from gl_traffic");

				if(rs.next())
				{	

					dno=rs.getInt("max");

					xdoc=dno;
					xdocs=xdocs+","+xdoc;

				}
				/*request.setAttribute("trxdocs", xdocs);*/
				setDocs(String.valueOf(xdocs));
				session.setAttribute("ITEMCURRENTDOCNO",xdoc);
			}catch (Exception e2) {e2.printStackTrace();}



			Elements tableRowElements = tableElements.select(":not(thead) tr");
			String k="";
			for (int i = 0; i < tableRowElements.size(); i++) 
			{


				if(getCmbtrafficsite().equalsIgnoreCase("AUH"))
				{
					k=String.valueOf((i+1));
					if(Integer.parseInt(k)<10)
						k="0"+k;
				}



				String aid="ctl00_ContentPlaceHolder1_gvTickets_ctl"+k+"_HyperLink1";
				Element row = tableRowElements.get(i);

				if(getCmbtrafficsite().equalsIgnoreCase("AUH"))
				{
					Element r=tableRowElements.get(1);
					roi=r.select("td");


					if(row.className().equalsIgnoreCase("")||row.className().equalsIgnoreCase("gridViewFooter")
							||row.className().equalsIgnoreCase("gridViewPager"))
					{
						/* flag=true;
 				    	   dat = rowItems.get(0).text();
 				    	   System.out.println(dat+" - "+curPage+" - "+dat.substring(dat.indexOf("Displaying page")+15, dat.indexOf("of")));
 				    	   dat=dat.substring(dat.indexOf("of")+1);
 				    	   dat=dat.substring(0,dat.indexOf(','));
 				    	   dat=dat.substring(dat.indexOf(' ')+1);
						 */
						continue;
					}
				}

				rowItems = row.select("td");


				if(rowItems.size()>0)
				{
					if(getCmbtrafficsite().equalsIgnoreCase("DXB"))
					{
						rowItems = row.select("td");

					}
				}
				//
				String data="",disc="",Fees="",remark="";
				String Time="",fine_Source="",regNo="",PlateCategory="",pcolor="",Amount="",Ticket_No="",Tick_violat="",DESC1="",type="",plate_source="";
				java.sql.Date date = null,traffic_date=null;
				session.setAttribute("TOTALITEMCOUNT",rowItems.size());
				for (int j = 0; j < rowItems.size(); j++) 
				{	
					Elements rowItemSpan = null;
					//System.out.println("rowItems html===="+rowItems.html());
					if(rowItems.html().contains("span")){
						rowItemSpan=rowItems.select("span");
					}
										
			//		if(rowItems.get(j).text().equalsIgnoreCase("7022300157")){
					System.out.println("rowItems ===="+rowItems.get(j).text());
					//System.out.println("rowItemsSpan ===="+rowItemSpan.get(j).text());
				//	}
					if(j!=rowItems.size()-1){
						data=rowItemSpan.get(j).text();
					}
					



					if(getCmbtrafficsite().equalsIgnoreCase("AUH")){

						if(j==0){
							//Ticketno searching
							//System.out.println("Inside First Column");
							Ticket_No=rowItems.get(j).select("input").val();
							//System.out.println("Ticket No1:"+Ticket_No);
							//System.out.println("Ticket No2:"+rowItems.get(j).html());
							//System.out.println("Ticket No3:"+rowItems.get(j).select("input").html());
						}

						if(j==3){

							Fees=data;
						}
						if(j==5){

							disc=data;

						}

						if(j==4){

							remark=data;
						}

						if(rowItems.get(j).text().equalsIgnoreCase("Details.."))
						{
							new Actions(driver).moveToElement(driver.findElement(By.xpath("//a[@id='"+aid+"']")));
							driver.findElement(By.xpath("//a[@id='"+aid+"']")).click();

							popupwindow=driver.getWindowHandle();
							driver.switchTo().window(popupwindow);
							//driver.switchTo().alert().dismiss();
							

							Thread.sleep(5000);
							detailsNewlyOpenedwindow(disc,Fees,srno+i,remark,i,Ticket_No);

						}
					}  
					String vio="Black Points:";
					if(getCmbtrafficsite().equalsIgnoreCase("DXB")){


						if(j==1){

							data = rowItems.get(j).text();

							data = rowItems.get(j).text().substring(0,rowItems.get(j).text().indexOf(' ') );


							DateFormat   formatter = new SimpleDateFormat("dd/MM/yyyy");

							data=(data.substring(0,2)+"/"+data.substring(3,5) +"/"+ data.substring(6,10));

							try {
								java.util.Date date1 = formatter.parse(data);
								java.sql.Date dtvalue=new java.sql.Date(date1.getTime());
								//fBrowse.cache.setData("traffic_date", dtvalue);
								traffic_date=dtvalue;

							} catch (ParseException e) {e.printStackTrace();} 

							Time=rowItems.get(j).text().substring( rowItems.get(j).text().lastIndexOf( ' ') + 1);

						}
						if(j==2){ 



							fine_Source=rowItems.get(j).text();

						}
						if(j==3){ 

							String s = rowItems.get(j).text().trim();
							//System.out.println("==s====="+s.length());
							if(s.length()>1){

								s = s.substring(s.indexOf(' ') + 1);

								//System.out.println("===sssssss====="+s);

								s = s.substring(0, s.indexOf(' ')); 
								String plc="",plcat="";
								if(s.length()>3){
									plc=rowItems.get(j).text().substring( rowItems.get(j).text().lastIndexOf( ' ') + 1);
									plcat=s;

								}  else{
									plc=s;
									plcat=rowItems.get(j).text().substring( rowItems.get(j).text().lastIndexOf( ' ') + 1);

								}
								regNo=rowItems.get(j).text().substring(0,rowItems.get(j).text().indexOf(' ') );
								PlateCategory=plcat;

								pcolor=plc;

							}
							else{
								PlateCategory="";
								pcolor="";
							}
						}
						if(j==4){ 

							Amount=rowItems.get(j).text();

						}
						if(j==5){ 

							vio=vio+rowItems.get(j).text();

						}
						if(j==6){ 

							//Ticket_No=rowItems.get(j).text();

						}

						if(j==7){ 

							vio=vio+rowItems.get(5).text()+"  "+rowItems.get(j).text();
							Tick_violat=vio;

							DESC1=vio;

						}
						java.util.Date dates=new  java.util.Date();


						date=com.getSqlDate(dates);

						type="TRF";

						if(j==20){


						}

					}

				}

				if(rowItems!=null&&rowItems.size()>0&&getCmbtrafficsite().equalsIgnoreCase("DXB"))
				{
					plate_source="Dubai";
					SATdownloadDAO dao=new SATdownloadDAO();
					if(regNo.length()>1)
					{
						regNo=regNo.substring(1,regNo.length());
					}
					else{
						regNo="0";
					}
					System.out.println("Ticket No before passed: "+Ticket_No);
					result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,null,null,null,
							Double.parseDouble(Amount),null,null,DESC1,null,type,category,srno+i,tcno1,xdoc,date,branch,plate_source,
							getCmbtrafficsite(),"",xdocs);

					rollno++;
					//System.out.println("==rollno====="+rollno);
				}

			}
			if(getCmbtrafficsite().equals("AUH"))
			{

				if(!fineno.equalsIgnoreCase(""))
				{
					if(fineno.equalsIgnoreCase(roi.get(0).text()))
					{
						//driver.quit();
					}
					else
					{
						fineno=roi.get(0).text();


					}
				}
				else	
					if(fineno.equalsIgnoreCase(""))
					{
						fineno=roi.get(0).text();

						// driver.quit();
					}
			}
		}
		else if(getCategory().equalsIgnoreCase("salik"))	//salik
		{
			
			if(getCmbsaliksite().equalsIgnoreCase("AUH")){
				int qudraAllSalik=0;
				ResultSet rsallsalik=conn.createStatement().executeQuery("select method from gl_config where field_nme='qudraAllSalik'");
				while(rsallsalik.next()){
					qudraAllSalik=rsallsalik.getInt("method");
				}
				try{
				driver.findElement(By.xpath("//*[@id='language']")).click();
				Thread.sleep(1000);
				driver.findElement(By.xpath("//*[@id='language']/a[1]")).click();
				Thread.sleep(2000);
				driver.findElement(By.xpath("//*[@id='Aber']/main/div/app-login/div/form/div[1]/div[2]/input")).sendKeys(ts);
				driver.findElement(By.xpath("//*[@id='Aber']/main/div/app-login/div/form/div[1]/div[2]/input")).sendKeys(Keys.TAB);
				
				driver.findElement(By.xpath("//*[@id='Aber']/main/div/app-login/div/form/div[1]/div[4]/input")).sendKeys(pass);
				driver.findElement(By.xpath("//*[@id='Aber']/main/div/app-login/div/form/div[1]/div[4]/input")).sendKeys(Keys.TAB);
				driver.findElement(By.xpath("//*[@id='Aber']/main/div/app-login/div/form/div[1]/div[7]/button")).click();
				
				Thread.sleep(2000);
				
				if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-dashboard/p-dialog/div/div/div[2]/div/div[2]/button")).size()>0){
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-dashboard/p-dialog/div/div/div[2]/div/div[2]/button")).click();
					Thread.sleep(1000);
				}
				
				if(driver.findElements(By.xpath("//*[@id='mat-menu-panel-0']/div/mat-card/mat-card-actions/button[3]")).size()>0){
					driver.findElement(By.xpath("//*[@id='mat-menu-panel-0']/div/mat-card/mat-card-actions/button[3]")).click();
					Thread.sleep(2000);
				}
				driver.findElement(By.xpath("//*[@id='language']")).click();
				Thread.sleep(1000);
				driver.findElement(By.xpath("//*[@id='language']/a[1]")).click();
				Thread.sleep(2000);
				
				if(driver.findElements(By.xpath("//*[@id='Aber']/app-in-activity-detector/app-vehicle-registration/p-dialog/div/div")).size()>0){
					WebElement tempalert=driver.findElement(By.xpath("//*[@id='Aber']/app-in-activity-detector/app-vehicle-registration/p-dialog/div/div/div[1]/div/a"));
					JavascriptExecutor executor = (JavascriptExecutor)driver;
					executor.executeScript("arguments[0].click();", tempalert);
					Thread.sleep(2000);
				}
				if(!getCmbmonthname().trim().equalsIgnoreCase("")) {
					//Scrolling Down for Monthwise transaction
					JavascriptExecutor js = (JavascriptExecutor) driver;
					js.executeScript("window.scrollBy(0,250)");
					//Getting Monthwise Saliks-04-09-2021-By Request
					List<WebElement> monthnamelist=driver.findElements(By.xpath("//*[@id='Aber']/main/app-dashboard/div/div[3]/monthly-payments/div/div/div"));
					for(int monthindex=1;monthindex<=monthnamelist.size();monthindex++) {
						if(driver.findElement(By.xpath("//*[@id='Aber']/main/app-dashboard/div/div[3]/monthly-payments/div/div/div["+monthindex+"]/div[1]/div/span")).getText().equalsIgnoreCase(getCmbmonthname())){
							driver.findElement(By.xpath("//*[@id='Aber']/main/app-dashboard/div/div[3]/monthly-payments/div/div/div["+monthindex+"]/div[3]/a")).click();
							break;
						}
					}
					Thread.sleep(4000);
				}
				else {
					driver.findElement(By.xpath("//*[@id='navbarSupportedContent']/div[1]/ul/li[3]/a")).click();
					Thread.sleep(4000);
				}
				if(driver.findElements(By.xpath("//*[@id='mat-menu-panel-0']/div/mat-card/mat-card-actions/button[3]")).size()>0){
					driver.findElement(By.xpath("//*[@id='mat-menu-panel-0']/div/mat-card/mat-card-actions/button[3]")).click();
					Thread.sleep(2000);
				}
				
				if(getCmbtype().equalsIgnoreCase("lhrs")){
					//24 Hrs
				}
				else if(getCmbtype().equalsIgnoreCase("ldays")){
					//Last 7 Days
				}
				else if(getCmbtype().equalsIgnoreCase("l30d")){
					//Last 30 Days
				}
				
				else if(getCmbtype().equalsIgnoreCase("customdates")){
					//Custom Dates
					
				}

				/*
				
				System.out.println("Start Hidden Date:"+getHidjqxStartDate());
				String strsqlfromdate=getHidjqxStartDate().trim().split("/")[2].trim()+"-"+getHidjqxStartDate().trim().split("/")[1].trim()+"-"+getHidjqxStartDate().trim().split("/")[0].trim();
				String strsqltodate=getHidjqxEndDate().trim().split("/")[2].trim()+"-"+getHidjqxEndDate().trim().split("/")[1].trim()+"-"+getHidjqxEndDate().trim().split("/")[0].trim();
				ResultSet rsgetdatemonth=conn.createStatement().executeQuery("select monthname('"+strsqlfromdate+"') startmonthname,monthname('"+strsqltodate+"') endmonthname");
				System.out.println("select monthname('"+strsqlfromdate+"') startmonthname,monthname('"+strsqltodate+"') endmonthname");
				String startmonthname="",endmonthname="";
				while(rsgetdatemonth.next()){
					startmonthname=rsgetdatemonth.getString("startmonthname");
					endmonthname=rsgetdatemonth.getString("endmonthname");
				}
				System.out.println(startmonthname+"::"+endmonthname);
				
				
				
				if(getHidjqxStartDate()!=null && !getHidjqxStartDate().equalsIgnoreCase("undefined")){
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/input")).click();
					//Setting Datepicker year
					WebElement elmfromyear=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/div/div[1]/div[1]/div/select[2]"));
					Select dropdownfromyear = new Select(elmfromyear);
					dropdownfromyear.selectByVisibleText(getHidjqxStartDate().trim().split("/")[2].trim());
					//Setting datepicker month
					WebElement elmfrommonth=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/div/div[1]/div[1]/div/select[1]"));
					Select dropdownfrommonth = new Select(elmfrommonth);
					dropdownfrommonth.selectByVisibleText(startmonthname);
					Document doc=Jsoup.parse(driver.getPageSource());
					System.out.println(driver.getPageSource());
					Element table = doc.select("table[class='ui-datepicker-calendar'").get(0); //select the first table.
					Elements rows = table.select("tr");
					int date1found=0;
					for (int i = 0; i < rows.size() && date1found==0; i++) { //first row is the col names so skip it.
					    Element row = rows.get(i);
					    Elements cols = row.select("td");
					    for(int j=0;j<cols.size()  && date1found==0;j++){
					    	if(cols.get(j).select("a").text().trim().equalsIgnoreCase(getHidjqxStartDate().trim().split("/")[0].trim())){
					    		driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/div/div[1]/div[2]/table/tbody/tr["+(i+1)+"]/td["+(j+1)+"]/a")).click();
					    		date1found=1;
					    		break;
					    	}
					    }
					}
					int trlength=driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/div/div[1]/div[2]/table/tbody/tr")).size();
					for(int trindex=1;trindex<=trlength;trindex++){
						int tdlength=driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/div/div[1]/div[2]/table/tbody/tr["+trindex+"]/td")).size();
						for(int tdindex=1;tdindex<=tdlength;tdindex++){
							//System.out.println("Inside TD loop");
							if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/div/div[1]/div[2]/table/tbody/tr["+trindex+"]/td["+tdindex+"]/a")).size()>0){
								//System.out.println("Inside Present");
								//System.out.println(driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/div/div[1]/div[2]/table/tbody/tr["+trindex+"]/td["+tdindex+"]/a")).getText().trim());
								//System.out.println(getHidjqxStartDate().trim().split("/")[0].trim());
								if(driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/div/div[1]/div[2]/table/tbody/tr["+trindex+"]/td["+tdindex+"]/a")).getText().trim().equalsIgnoreCase(getHidjqxStartDate().trim().split("/")[0].trim())){
									System.out.println("inside truth");
									//WebElement webElement = driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/div/div[1]/div[2]/table/tbody/tr["+trindex+"]/td["+tdindex+"]/a"));
									/*JavascriptExecutor executor = (JavascriptExecutor) driver;
									executor.executeScript("arguments[0].click();", webElement);
									driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/div/div[1]/div[2]/table/tbody/tr["+trindex+"]/td["+tdindex+"]/a")).click();
									Thread.sleep(2000);
									driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/input")).sendKeys(Keys.TAB);
									break;
								}
							}
							
						}
					}
					
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/div/div[2]/div/div[2]/button")).click();
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/input")).sendKeys(getHidjqxStartDate());
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/input")).sendKeys(Keys.ENTER);
					/*driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[1]/p-calendar/span/div/div[2]/div/div[1]/button")).click();
					
					
				}
				
				if(getHidjqxEndDate()!=null && !getHidjqxEndDate().equalsIgnoreCase("undefined")){
					//Setting Datepicker year
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[2]/p-calendar/span/input")).click();
					WebElement elmtoyear=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[2]/p-calendar/span/div/div[1]/div[1]/div/select[2]"));
					Select dropdowntoyear = new Select(elmtoyear);
					dropdowntoyear.selectByVisibleText(getHidjqxEndDate().trim().split("/")[2].trim());
					//Setting datepicker month
					WebElement elmtomonth=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[2]/p-calendar/span/div/div[1]/div[1]/div/select[1]"));
					Select dropdowntomonth = new Select(elmtomonth);
					dropdowntomonth.selectByVisibleText(endmonthname);
					WebElement elmtbody=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[2]/p-calendar/span/div/div[1]/div[2]/table/tbody"));
					int trlength=elmtbody.findElements(By.tagName("tr")).size();
					//("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[2]/p-calendar/span/div/div[1]/div[2]/table/tbody/tr")).size();
					int date2found=0;
					for(int trindex=1;trindex<=trlength && date2found==0;trindex++){
						int tdlength=elmtbody.findElements(By.xpath("//tr["+trindex+"]/td")).size();
						for(int tdindex=1;tdindex<=tdlength  && date2found==0;tdindex++){
							if(elmtbody.findElements(By.xpath("//tr["+trindex+"]/td["+tdindex+"]/a")).size()>0){
								if(elmtbody.findElement(By.xpath("//tr["+trindex+"]/td["+tdindex+"]/a")).getText().trim().equalsIgnoreCase(getHidjqxEndDate().trim().split("/")[0].trim())){
									elmtbody.findElement(By.xpath("//tr["+trindex+"]/td["+tdindex+"]/a")).click();
									WebElement webElement = driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[2]/p-calendar/span/div/div[1]/div[2]/table/tbody/tr["+trindex+"]/td["+tdindex+"]/a"));
									JavascriptExecutor executor = (JavascriptExecutor) driver;
									executor.executeScript("arguments[0].click();", webElement);
									
									date2found=1;
									break;
								}
							}
							
						}
					}
					//Thread.sleep(2000);
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[2]/p-calendar/span/input")).click();
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[2]/p-calendar/span/div/div[2]/div/div[2]/button")).click();
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[2]/p-calendar/span/input")).sendKeys(getHidjqxEndDate());
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[2]/p-calendar/span/input")).sendKeys(Keys.ENTER);
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[2]/p-calendar/span/div/div[2]/div/div[1]/button")).click();
					//Thread.sleep(2000);
					
				}
*/
				Thread.sleep(15000);
				driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[1]/div[2]/form/div[4]/button[2]")).click();
				Thread.sleep(3000);
				
				//Select 100 entries per page
				System.out.println("=====transaction");
				if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/p-paginator")).size()>0){
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/p-paginator/div/p-dropdown/div/div[4]")).click();
					Thread.sleep(1000);
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/p-paginator/div/p-dropdown/div/div[5]/div/ul/p-dropdownitem[4]/li")).click();
					Thread.sleep(6000);
					
				}
//				int tblrowcount=driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div[3]/p-table/div/div/table/tbody/tr")).size();
				System.out.println(driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/div/table/tbody/tr/td")).getText());
				int tblrowcount=0;
				if(!driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/div/table/tbody/tr/td")).getText().equalsIgnoreCase("No Records Found")){
					tblrowcount=driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/div/table/tbody/tr")).size();
				}
				
				int tblrowindex=1;
				int saliksrno=1;
				ResultSet rssalikmax = conn.createStatement().executeQuery("Select coalesce((max(doc_no)+1),1) max from gl_salik");

				if(rssalikmax.next())
				{	
					xsadoc=0;
					xsadoc=rssalikmax.getInt("max");

					xdocs=xdocs+","+xsadoc;	
					xsasrno=0;
				}
				request.setAttribute("xdocs", xdocs);
				session.setAttribute("ITEMCURRENTDOCNO",xsadoc);
				setDocs(String.valueOf(xdocs));
				System.out.println("Row Index"+tblrowindex);
				System.out.println("Row Count"+tblrowcount);
				while(tblrowindex<=tblrowcount){
					/*	String platecode=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[2]/vehicle-plate/div/div[1]/span")).getText().trim();
					String authorityraw=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[2]/vehicle-plate/div/small")).getText().trim();
					//System.out.println("Authority:"+authorityraw);
					String authority=authorityraw.split("\n")[1];
					String regno=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[2]/vehicle-plate/div/div[2]")).getText();
					String locaton=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[3]/span[2]")).getText();
					String datetimeraw=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[4]/span[2]")).getText();
					String amount=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[5]/b")).getText();
					String strdate=datetimeraw.split(" ")[0].replace("/",".");
					*/
					String platecode=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[2]/vehicle-plate/div/div[1]/span")).getText().trim();
					String authorityraw=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[2]/vehicle-plate/div/small")).getText().trim();
					//System.out.println("Authority:"+authorityraw);
					String authority=authorityraw.split("\n")[1];
					String regno=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[2]/vehicle-plate/div/div[2]")).getText();
					String locaton=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[3]/span[2]")).getText();
					String datetimeraw=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[4]/span[2]")).getText();
					String amount=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[5]/b")).getText();
					String strdate=datetimeraw.split(" ")[0].replace("/",".");
				
					SATdownloadDAO dao=new SATdownloadDAO();
					platecode=platecode.trim();
					authority=authority.trim();
					regno=regno.trim();
					
					String strgetsaliktag="select veh.salik_tag from gl_vehmaster veh left join gl_vehplate plt on veh.pltid=plt.doc_no left join "+
					" gl_vehauth auth on veh.authid=auth.doc_no where veh.reg_no="+regno+" and auth.authname='"+authority+"' and plt.code_name='"+platecode+"' and veh.statu=3";
					String saliktag="";
					Statement stmt=conn.createStatement();
					//System.out.println(strgetsaliktag);
					ResultSet rssalik=stmt.executeQuery(strgetsaliktag);
					while(rssalik.next()){
						saliktag=rssalik.getString("salik_tag");
					}
//					System.out.println("Salik Tag:"+saliktag);
					/*
					String ts,String plno,String tag,String Trans,java.sql.Date dtripvalue,String Loc,String Dir,String src,Double Amount,
					String time,java.sql.Date dtvalue,int xsadoc,java.sql.Date sd,int xsasrno,String type,String salik_fdate,String branch*/
					String transaction=(regno+platecode+datetimeraw).replace("/","").replace("-","").replace(":","").replace(" ","").trim();
					if(qudraAllSalik==1){
						boolean salikstatus=dao.salikInsertAUH(ts, regno, saliktag, transaction,objcommon.changeStringtoSqlDate(strdate), locaton, authority+"-"+platecode+"-"+regno,"AUH", Double.parseDouble(amount),
								datetimeraw.split(" ")[1],objcommon.changeStringtoSqlDate(strdate), xsadoc, objcommon.changeStringtoSqlDate(strdate),
								saliksrno, "SLK", datetimeraw, "");
						//if(salikstatus){
							tblrowindex++;
							saliksrno++;
						/*}
						else{
							System.out.println("return 1");
							//return false;
						}*/
					}
					else{
						if(Double.parseDouble(amount)>0.0){
							boolean salikstatus=dao.salikInsertAUH(ts, regno, saliktag, transaction,objcommon.changeStringtoSqlDate(strdate), locaton, authority+"-"+platecode+"-"+regno,"AUH", Double.parseDouble(amount),
									datetimeraw.split(" ")[1],objcommon.changeStringtoSqlDate(strdate), xsadoc, objcommon.changeStringtoSqlDate(strdate),
									saliksrno, "SLK", datetimeraw, "");
							/*System.out.println(ts+"===="+ regno+"===="+  saliktag+"===="+  transaction+"===="+ objcommon.changeStringtoSqlDate(strdate)+"===="+  locaton+"===="+  authority+"-"+platecode+"-"+regno+"===="+ "AUH"+"===="+  Double.parseDouble(amount)+"===="+ 
									datetimeraw.split(" ")[1]+"===="+ objcommon.changeStringtoSqlDate(strdate)+"===="+  xsadoc+"===="+  objcommon.changeStringtoSqlDate(strdate)+"===="+ 
									saliksrno+"===="+  "SLK"+"===="+  datetimeraw);*/
						//	if(salikstatus){
								tblrowindex++;
								saliksrno++;
							/*}
							else{
								System.out.println("return 2");
								return false;
							}*/
						}
						else{
							tblrowindex++;
						}
					}
					
//					System.out.println("Table Row Index2 :"+tblrowindex);
//					System.out.println("Table Row count2 :"+tblrowcount);
					if(tblrowindex>tblrowcount){
						if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/p-paginator")).size()>0){
							String pageclasses = driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/p-paginator/div/a[3]")).getAttribute("class");
						    if(!pageclasses.contains("ui-state-disabled")){
						    	tblrowindex=1;
						    	
					        	driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/p-paginator/div/a[3]")).click();
					        	Thread.sleep(6000);
					        	tblrowcount=driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[3]/p-table/div/div/table/tbody/tr")).size();
						    }
						}
					}
				}
				
				//Select 100 entries per page
				System.out.println("=====unpaid");
				if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[2]/p-table/div/p-paginator")).size()>0){
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[2]/p-table/div/p-paginator/div/p-dropdown/div/div[4]")).click();
					Thread.sleep(1000);
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[2]/p-table/div/p-paginator/div/p-dropdown/div/div[5]/div/ul/p-dropdownitem[4]/li")).click();
					Thread.sleep(6000);
					
				}
				
				int utblrowcount=driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[2]/p-table/div/div/table/tbody/tr")).size();
				int utblrowindex=1;
				// int usaliksrno=1;
//				request.setAttribute("xdocs", xdocs);
//				session.setAttribute("ITEMCURRENTDOCNO",xsadoc);
				setDocs(String.valueOf(xdocs));
				System.out.println("Row Index"+utblrowindex);
				System.out.println("Row Count"+utblrowcount);
				while(utblrowindex<=utblrowcount){
					if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td")).size()==1) {
						//No Rows Present
						break;
					}
					String platecode=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td[2]/vehicle-plate/div/div[1]/span")).getText().trim();
					String authorityraw=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td[2]/vehicle-plate/div/small")).getText().trim();
					//System.out.println("Authority:"+authorityraw);
					String authority=authorityraw.split("\n")[1];
					String regno=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td[2]/vehicle-plate/div/div[2]")).getText();
					String locaton=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td[3]/span[2]")).getText();
					String datetimeraw=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td[4]/span[2]")).getText();
					String amount=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td[5]/b")).getText();
					String strdate=datetimeraw.split(" ")[0].replace("/",".");
					SATdownloadDAO dao=new SATdownloadDAO();
					platecode=platecode.trim();
					authority=authority.trim();
					regno=regno.trim();
					String strgetsaliktag="select veh.salik_tag from gl_vehmaster veh left join gl_vehplate plt on veh.pltid=plt.doc_no left join "+
					" gl_vehauth auth on veh.authid=auth.doc_no where veh.reg_no="+regno+" and auth.authname='"+authority+"' and plt.code_name='"+platecode+"' and veh.statu=3";
					String saliktag="";
					Statement stmt=conn.createStatement();
					//System.out.println(strgetsaliktag);
					ResultSet rssalik=stmt.executeQuery(strgetsaliktag);
					while(rssalik.next()){
						saliktag=rssalik.getString("salik_tag");
					}
//					System.out.println("Salik Tag:"+saliktag);
					/*
					String ts,String plno,String tag,String Trans,java.sql.Date dtripvalue,String Loc,String Dir,String src,Double Amount,
					String time,java.sql.Date dtvalue,int xsadoc,java.sql.Date sd,int xsasrno,String type,String salik_fdate,String branch*/
					String transaction=(regno+platecode+datetimeraw).replace("/","").replace("-","").replace(":","").replace(" ","").trim();
					if(qudraAllSalik==1){
						boolean salikstatus=dao.salikInsertAUH(ts, regno, saliktag, transaction,objcommon.changeStringtoSqlDate(strdate), locaton, authority+"-"+platecode+"-"+regno,"AUH", Double.parseDouble(amount),
								datetimeraw.split(" ")[1],objcommon.changeStringtoSqlDate(strdate), xsadoc, objcommon.changeStringtoSqlDate(strdate),
								saliksrno, "SLK", datetimeraw, "");
						//if(salikstatus){
							utblrowindex++;
							saliksrno++;
						/*}
						else{
							System.out.println("return 1");
							//return false;
						}*/
					}
					else{
						if(Double.parseDouble(amount)>0.0){
							boolean salikstatus=dao.salikInsertAUH(ts, regno, saliktag, transaction,objcommon.changeStringtoSqlDate(strdate), locaton, authority+"-"+platecode+"-"+regno,"AUH", Double.parseDouble(amount),
									datetimeraw.split(" ")[1],objcommon.changeStringtoSqlDate(strdate), xsadoc, objcommon.changeStringtoSqlDate(strdate),
									saliksrno, "SLK", datetimeraw, "");
							/*System.out.println(ts+"===="+ regno+"===="+  saliktag+"===="+  transaction+"===="+ objcommon.changeStringtoSqlDate(strdate)+"===="+  locaton+"===="+  authority+"-"+platecode+"-"+regno+"===="+ "AUH"+"===="+  Double.parseDouble(amount)+"===="+ 
									datetimeraw.split(" ")[1]+"===="+ objcommon.changeStringtoSqlDate(strdate)+"===="+  xsadoc+"===="+  objcommon.changeStringtoSqlDate(strdate)+"===="+ 
									saliksrno+"===="+  "SLK"+"===="+  datetimeraw);*/
						//	if(salikstatus){
								utblrowindex++;
								saliksrno++;
							/*}
							else{
								System.out.println("return 2");
								return false;
							}*/
						}
						else{
							utblrowindex++;
						}
					}
					
//					System.out.println("Table Row Index2 :"+tblrowindex);
//					System.out.println("Table Row count2 :"+tblrowcount);
					if(utblrowindex>utblrowcount){
						if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[2]/p-table/div/p-paginator")).size()>0){
							String pageclasses = driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[2]/p-table/div/p-paginator/div/a[3]")).getAttribute("class");
						    if(!pageclasses.contains("ui-state-disabled")){
						    	tblrowindex=1;
					        	driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[2]/p-table/div/p-paginator/div/a[3]")).click();
					        	Thread.sleep(6000);
					        	utblrowcount=driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/div[2]/p-table/div/div/table/tbody/tr")).size();
						    }
						}
						
					}
				}

				//driver.quit();
				return true;
				
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(!getCmbsaliksite().equalsIgnoreCase("AUH")){
			Elements tabEl = null;
			Elements tableRowElements=null;
			if(v<=1)
			{


				/* VISHAKH.V.P */
				if(rtalogin==1) {
					
					driver.findElement(By.xpath("//*[@id='main']/section/div/div/div/div/form/div[7]/a")).click();
					
					driver.findElement(By.id("username")).sendKeys(ts);
					driver.findElement(By.id("password")).sendKeys(pass);
					
					/*driver.findElement(By.xpath("//*[@id='loginControl']/div[1]/div[1]/div[1]/input")).click();*/
					JavascriptExecutor js = (JavascriptExecutor) driver;
					js.executeScript("window.scrollBy(0,150)");
					//Checking if old button is present - Login button changed in site 07-12-2021
					if(driver.findElements(By.xpath("//*[@id='signupForm']/div[4]/button")).size()>0){
						driver.findElement(By.xpath("//*[@id='signupForm']/div[4]/button")).click();
					}
					else{
						driver.findElement(By.xpath("//*[@id='btn_login']")).click();
					}
					//driver.findElement(By.xpath("//*[@id='signupForm']/div[4]/button")).click();
					
				} else {
					
					driver.findElement(By.id("username")).sendKeys(ts);
					driver.findElement(By.id("password")).sendKeys(pass);
					
					driver.findElement(By.xpath("//*[@id='main']/section/div/div/div/div/form/div[4]/input")).click();
					
				}
				/* VISHAKH.V.P ENDS*/

				//driver.findElement(By.xpath("//*[@id='main']/div/section[1]/div/div/div[2]/div[2]/div[2]/a")).click();
				//Thread.sleep(120500);
				Thread.sleep(2000);
				driver.findElement(By.xpath("/html/body/div[1]/section/div/nav/ul/li[5]/a")).click();
				/*driver.findElement(By.xpath("//*[@id='main']/div[1]/section[1]/div[1]/div[1]/div[2]/div[2]/div[2]/a")).click();
				driver.findElement(By.xpath("//*[@id='FormTrips']/div/div[1]/div/div[1]")).click();*/
				Thread.sleep(2000);
				JavascriptExecutor jsfilter = (JavascriptExecutor) driver;
				jsfilter.executeScript("window.scrollBy(0,200)");
				if(!getCmbtype().equalsIgnoreCase("lhrs")){
					driver.findElement(By.xpath("//*[@id='FormTrips']/div/div[1]/div")).click();
				}
				if(getCmbtype().equalsIgnoreCase("lhrs")){
			
					// driver.findElement(By.xpath("//*[@id='Range_24Hours']")).click();
					 driver.findElement(By.xpath("//*[@id='Range_24Hours']")).isSelected();
					
				}
				else if(getCmbtype().equalsIgnoreCase("ldays")){
					driver.findElement(By.xpath("//*[@id='Range_7days']")).click();
					//driver.findElement(By.xpath("//*[@id='Range_7days']")).isSelected();
					
				}
				else if(getCmbtype().equalsIgnoreCase("l30d")){
					driver.findElement(By.xpath("//*[@id='Range_30Days']")).click();
					//driver.findElement(By.xpath("//*[@id='Range_30Days']")).isSelected();
					
				}
				/* VISHAKH.V.P */
				else if(getCmbtype().equalsIgnoreCase("customdates")){
//					Thread.sleep(2000);
					/*WebDriverWait wait = new WebDriverWait(driver,30);
					wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//*[@id='StartDate']")));*/
					driver.findElement(By.xpath("//*[@id='StartDate']")).click();
					driver.findElement(By.id("StartDate")).sendKeys(getJqxStartDate());
					
					/*wait = new WebDriverWait(driver,30);
					wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//*[@id='EndDate']")));
					*/
					Thread.sleep(1000);
					driver.findElement(By.id("StartDate")).sendKeys(Keys.ENTER);
					Thread.sleep(1000);
					driver.findElement(By.xpath("//*[@id='EndDate']")).click();
					driver.findElement(By.id("EndDate")).sendKeys(getJqxEndDate());
					Thread.sleep(2000);
				}
				/* VISHAKH.V.P ENDS*/
				int qudraAllSalik=0;
				ResultSet rsallsalik=conn.createStatement().executeQuery("select method from gl_config where field_nme='qudraAllSalik'");
				while(rsallsalik.next()){
					qudraAllSalik=rsallsalik.getInt("method");
				}
				if(qudraAllSalik!=1){
					driver.findElement(By.xpath("//*[@id='TripeType']/option[text()='Charged trips']")).click();
				}
				
				
				if(!(getTxtsaliktagno().equalsIgnoreCase(""))){
					
					driver.findElement(By.xpath("//*[@id='FormTrips']/div/div[3]/div[1]")).click();
					driver.findElement(By.xpath("//*[@id='ByTag']")).click();
					driver.findElement(By.id("Tag_TagNumber")).sendKeys(getTxtsaliktagno().trim());

				}
				

				driver.findElement(By.xpath("//*[@id='FormTrips']/div/div[4]/button")).click();
				Thread.sleep(3000);
				String strrawcount=driver.findElement(By.xpath("//*[@id='total-items-count']")).getText();
				
				strrawcount=strrawcount.trim();
				if(strrawcount.contains(":")){
				strrawcount=strrawcount.split(":")[1].trim();
				}
				else{ strrawcount="0";}
				System.out.println("Total Items Count:"+strrawcount);
					/* VISHAKH.V.P */
				session.setAttribute("TOTALITEMCOUNT", strrawcount);
					Boolean iselementpresent=true;
					int pagecount=1;
					
					do{
	
						if(SATEXCELCONFIG.equalsIgnoreCase("1") && pagecount==1){
							if(driver.findElements(By.xpath("//*[@id='RenderBody']/section/div/div/div/div/div[1]/div[2]/a[2]")).size()>0){
								driver.findElement(By.xpath("//*[@id='RenderBody']/section/div/div/div/div/div[1]/div[2]/a[2]")).click();
								pagecount++;
								Thread.sleep(150000);
								break;
							}
							iselementpresent = driver.findElements(By.xpath("//*[@id='loadMore']")).size()!= 0;
							
							if(iselementpresent==true){
								Thread.sleep(50000);
								driver.findElement(By.xpath("//*[@id='loadMore']")).click();
							}
							
							
							
						} else if(SATEXCELCONFIG.equalsIgnoreCase("0")) {
						
							iselementpresent = driver.findElements(By.xpath("//*[@id='loadMore']")).size()!= 0;
		
							if(iselementpresent==true){
								Thread.sleep(3000);
								driver.findElement(By.xpath("//*[@id='loadMore']")).click();
								pagecount++;
							}
						}
	
					} while(iselementpresent==true);
					/* VISHAKH.V.P ENDS*/
				
				
				
				try{
					ResultSet rs = conn.createStatement().executeQuery("Select coalesce((max(doc_no)+1),1) max from gl_salik");

					if(rs.next())
					{	
						xsadoc=0;
						xsadoc=rs.getInt("max");

						xdocs=xdocs+","+xsadoc;	
						xsasrno=0;
					}
					request.setAttribute("xdocs", xdocs);
					session.setAttribute("ITEMCURRENTDOCNO",xsadoc);
					setDocs(String.valueOf(xdocs));

				}catch (Exception e2) {
					conn.close();
					e2.printStackTrace();
				}

				/* VISHAKH.V.P */
				if(SATEXCELCONFIG.equalsIgnoreCase("1")){
					
					SATEXCEL = SATEXCEL.replace("\\", "//");
					
		            FileInputStream input = new FileInputStream(SATEXCEL+"//ExportTrips.xls");
		            POIFSFileSystem fs = new POIFSFileSystem( input );
		            HSSFWorkbook wb = new HSSFWorkbook(fs);
		            HSSFSheet sheet = wb.getSheetAt(0);
		            Row excelRow;
		            session.setAttribute("TOTALITEMCOUNT",sheet.getLastRowNum()-15);
		            for(int i=15; i<(sheet.getLastRowNum()); i++){
		            	
		            	String transactionID="",tagNumber="",plate="";
		            	java.sql.Date tripsDate=null;
						java.sql.Date sd = null;
						double amount=0.00;
		            	
		            	SimpleDateFormat formatDate = new SimpleDateFormat("dd MMMM yyyy");
		            	excelRow = sheet.getRow(i);
		                
		                if(excelRow.getCell(2).getCellType()==1){
		                	transactionID = excelRow.getCell(2).getStringCellValue()=="" || excelRow.getCell(2).getStringCellValue()==null?"0":excelRow.getCell(2).getStringCellValue().replace("'", " ");
		                	System.out.println("Transaction ID:"+transactionID);
		                } else {
		                	transactionID = String.valueOf((int) excelRow.getCell(2).getNumericCellValue());	
		                	System.out.println("Transaction ID:"+transactionID);
		                }
		                if(transactionID.equalsIgnoreCase("") || transactionID==null || transactionID.equalsIgnoreCase("0")){
		                	continue;
		                }
		                java.util.Date tripDate = formatDate.parse(excelRow.getCell(3).getStringCellValue()=="" || excelRow.getCell(3).getStringCellValue()==null?"0":excelRow.getCell(3).getStringCellValue());
		                tripsDate = new java.sql.Date(tripDate.getTime());
		                
		                String tripTime = excelRow.getCell(5).getStringCellValue()=="" || excelRow.getCell(5).getStringCellValue()==null?"0":excelRow.getCell(5).getStringCellValue();
		                
		                time=tripTime;
						tformat=time.split(" ");
						timeappend=tformat[0].trim().substring(2,tformat[0].length());
						time=time.substring(0,time.indexOf(' '));

						if(tformat[1].trim().equalsIgnoreCase("PM")) {
							if(!tformat[0].substring(0,2).equals("12")) { 
								time=(Integer.parseInt(tformat[0].trim().substring(0,2))+12)+"";
								time=time+timeappend;
							}
						}

						if(tformat[1].trim().equalsIgnoreCase("AM")) {
							if(tformat[0].substring(0,2).equals("12")) { 
								time=(Integer.parseInt(tformat[0].trim().substring(0,2))-12)+"";
								time=time+timeappend;
							}
						}
						
		                String transactionPostDate = excelRow.getCell(6).getStringCellValue()=="" || excelRow.getCell(6).getStringCellValue()==null?"0":excelRow.getCell(6).getStringCellValue();
		                String tollGate = excelRow.getCell(7).getStringCellValue()==""  || excelRow.getCell(7).getStringCellValue()==null?"0":excelRow.getCell(7).getStringCellValue();
		                String direction = excelRow.getCell(9).getStringCellValue()==""  || excelRow.getCell(9).getStringCellValue()==null?"0":excelRow.getCell(9).getStringCellValue();
		                
		                if(excelRow.getCell(14).getCellType()==1){
		                	tagNumber = excelRow.getCell(14).getStringCellValue()=="" || excelRow.getCell(14).getStringCellValue()==null?"0":excelRow.getCell(14).getStringCellValue().replace("'", " ");
		                } else {
		                	tagNumber = String.valueOf((int) excelRow.getCell(14).getNumericCellValue());	
		                }
		                
		                if(excelRow.getCell(15).getCellType()==1){
		                	plate = excelRow.getCell(15).getStringCellValue()=="" || excelRow.getCell(15).getStringCellValue()==null?"0":excelRow.getCell(15).getStringCellValue().replace("'", " ");
		                } else {
		                	plate = String.valueOf((int) excelRow.getCell(15).getNumericCellValue());	
		                }
		                
		                if(excelRow.getCell(16).getCellType()==1){
		                	amount = Double.parseDouble(excelRow.getCell(16).getStringCellValue()=="" || excelRow.getCell(16).getStringCellValue()==null?"0":excelRow.getCell(16).getStringCellValue().replace("'", " "));
		                } else {
		                	amount = (double) excelRow.getCell(16).getNumericCellValue();
		                }
		                
		                xsasrno++;
						SATdownloadDAO dao=new SATdownloadDAO();
						if(qudraAllSalik==1){
							result=dao.salikInsert(ts,plate,tagNumber,transactionID,tripsDate,"",direction,tollGate,amount,time,tripsDate,xsadoc,sd,xsasrno,"",salik_fdate,branch);
						}
						else{
							if(amount>0){
								result=dao.salikInsert(ts,plate,tagNumber,transactionID,tripsDate,"",direction,tollGate,amount,time,tripsDate,xsadoc,sd,xsasrno,"",salik_fdate,branch);
							}
						}
		            }
		            
		            /*File currentFile = new File(SATEXCEL,"ExportTrips.xls");
		            currentFile.delete();*/
		            
		            File currentFolder = new File(SATEXCEL);
		            FileUtils.deleteDirectory(currentFolder);
		            
				} else {
					Thread.sleep(5000);
					WebElement  mytable = driver.findElement(By.xpath("//*[@id='trips-container']/div[1]/table"));
	
					List<WebElement> rows_table = mytable.findElements(By.tagName("tr"));
	
					int rows_count = rows_table.size();
	
					int i=0;
	
					String Trans="";
					String Loc="";
					String Dir="";
					Double Amount=0.0;
					java.sql.Date dtvalue=null,dtripvalue=null;
					java.sql.Date sd = null;
					String plno="",tag="",src="";
					session.setAttribute("TOTALITEMCOUNT",rows_count);
					int salikcounter=0;
					if(!getSalikcounter().trim().equalsIgnoreCase("")){
						salikcounter=Integer.parseInt(getSalikcounter());
					}
					for (int row=salikcounter; row<rows_count; row++){
	
	
						List<WebElement> Columns_row = rows_table.get(row).findElements(By.tagName("td"));
	
						int columns_count = Columns_row.size();
						
						
						/*	List<WebElement> th_column = rows_table.get(row).findElements(By.tagName("th"));
	
						int th_count = th_column.size();
						*/
						//System.out.println("Number of cells In Row "+row+" are "+columns_count);
						/* for (int th=0; th<th_count; th++){
							String celtext1 = th_column.get(th).getText();
							
							System.out.println("==celtext1===="+celtext1);
							
							SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMMM yyyy");
							try{
	
								java.util.Date date = sdf1.parse(celtext1);
								dtvalue = new java.sql.Date(date.getTime());
	
	
							}
							catch(Exception e){
								e.printStackTrace();
							}
	
	
							try {
								java.util.Date dat = sdf1.parse(celtext1);
	
								dtripvalue=new java.sql.Date(dat.getTime());
	
							} catch (ParseException e) {e.printStackTrace();}
	
						}*/
						if(row%2!=0){
						String celtext1 =driver.findElement(By.xpath("//*[@id='trips-container']/div[1]/table/tbody/tr["+row+"]/th/span")).getText();
						
	//					System.out.println("==celtext1===="+celtext1);
	//					System.out.println("==celtext1===="+driver.findElement(By.xpath("//*[@id='trips-container']/div[1]/table/tbody/tr["+row+"]/th")).getText());
						
						SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMMM yyyy");
						try{
	
							java.util.Date date = sdf1.parse(celtext1);
							dtvalue = new java.sql.Date(date.getTime());
	
	
						}
						catch(Exception e){
							conn.close();
							e.printStackTrace();
						}
	
	
						try {
							java.util.Date dat = sdf1.parse(celtext1);
	//						System.out.println("==== "+dat);
							dtripvalue=new java.sql.Date(dat.getTime());
	// System.out.println("==== "+dtripvalue);
						} catch (ParseException e) {
							conn.close();
							e.printStackTrace();
						}
						
	//					System.out.println("==celtext1===="+celtext1);
						}
						
						
	
						for (int column=0; column<columns_count; column++){
	
							//Thread.sleep(5000);
							if(row>0){
	
								String celtext = Columns_row.get(column).getText();
								//System.out.println("Cell Value Of row number "+row+" and column number "+column+" Is "+celtext);
								if(row%2!=0){
									if(column==0){
										time=celtext;
	
										tformat=time.split(" ");
										timeappend=tformat[0].trim().substring(2,tformat[0].length());
	
										time=time.substring(0,time.indexOf(' '));
	
										if(tformat[1].trim().equalsIgnoreCase("PM"))
										{
	//									 System.out.println("TAKING THE FIRST TIME"+(Integer.parseInt(tformat[0].substring(0,2))+12));
											if(!tformat[0].substring(0,2).equals("12"))
											{ 
												time=(Integer.parseInt(tformat[0].trim().substring(0,2))+12)+"";
												time=time+timeappend;
	
											}
										}
	
	
										if(tformat[1].trim().equalsIgnoreCase("AM"))
										{
											//System.out.println("Time.parse(((((((((((((("+Time.parse(time)+12);
	
											if(tformat[0].substring(0,2).equals("12"))
											{ 
												time=(Integer.parseInt(tformat[0].trim().substring(0,2))-12)+"";
												time=time+timeappend;
	
											}
										}
	
	
	
	//									System.out.println("===time===="+time);
									}
									if(column==1){
									//	System.out.println("==celtext.length()===="+celtext.length());
										if(!celtext.equalsIgnoreCase("") && celtext!=null){
											plno=celtext.substring(celtext.length()-5, celtext.length());
										}
										else{
											plno="";
										}

	//									System.out.println("===plno===="+plno);
	
									}
									if(column==2){
	
										src=celtext;
	//									System.out.println("===src===="+src);
	
									}
									if(column==3){
	
										Dir=celtext;
	//									System.out.println("===Dir===="+Dir);
	
									}
									if(column==4){
	
										Amount=Double.parseDouble(celtext);
	//									System.out.println("===Amount===="+Amount);
	
									}
								}
								if(row%2==0){
	
									if(column==2){
										tag=celtext.replaceAll("[^0-9]", "").trim();
	//									System.out.println("===tag===="+tag);
									}
									if(column==3){
										Trans=celtext.replaceAll("[^0-9]", "").trim();
	//									System.out.println("===Trans===="+Trans);
	
									}
	
	/*								if(column==4){
										String	 data = celtext;//.substring(0,rowItems.get(j).text().indexOf(' ') );
	
										SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMMM yyyy");
										try{
	
											java.util.Date date = sdf1.parse(data);
											dtvalue = new java.sql.Date(date.getTime());
	
	
										}
										catch(Exception e){
											e.printStackTrace();
										}
	
	
										try {
											java.util.Date dat = sdf1.parse(data);
	
											dtripvalue=new java.sql.Date(dat.getTime());
	
										} catch (ParseException e) {e.printStackTrace();}
	
	
	
									}*/
	
								}
	
								if(column==5){
	
									if(row%2!=0){
										JavascriptExecutor js = (JavascriptExecutor) driver;
										js.executeScript("window.scrollBy(0,1000)");
										driver.findElement(By.xpath("//*[@id='trips-container']/div[1]/table/tbody/tr["+(row)+"]/td[6]/button")).click();
										Thread.sleep(5000);
	
									}
	
								}
	
	
	
	
	
							}
	
						}
	
						if(row%2==0 && row>0){
							xsasrno++;
							SATdownloadDAO dao=new SATdownloadDAO();
							if(qudraAllSalik==1){
								result=dao.salikInsert(ts,plno,tag,Trans,dtripvalue,Loc,Dir,src,Amount,time,dtvalue,xsadoc,sd,xsasrno,"",salik_fdate,branch);
							}
							else{
								if(Amount>0){
									result=dao.salikInsert(ts,plno,tag,Trans,dtripvalue,Loc,Dir,src,Amount,time,dtvalue,xsadoc,sd,xsasrno,"",salik_fdate,branch);
								}
							}
							
						}
	
	
	
					}
					
				  }
				  /* VISHAKH.V.P. ENDS*/	

			}
		}
		}
		return  result;


	}

	private void detailsNewlyOpenedwindow(String disc, String fees, int k, String remark,int srno,String Ticket_No) 
	{
		System.out.println("Opened Window Parameters:"+disc+"::"+fees+"");
		//		disc="";
		//		fees="";
		String plate_source="",Time="",fine_Source="",regNo="",PlateCategory="",pcolor="",Tick_violat="",DESC1="",type="",LicenseNo="",LicenseFrom="",NotPayReason="",location="",fine="",remarks="",tcno="";
		java.sql.Date traffic_date=null,sd = null;
		Double Amount=0.0;

		try{


			Set<String> windowHandles1 = driver.getWindowHandles();
			int size = windowHandles1.size();

			for (String string : windowHandles1) 
			{
				driver.switchTo().window(string);

				if(string.equals(defaultwindow))
				{ //driver.manage().window().setPosition(new Point(0, 0));
					//System.out.println("On Main Window");
					//Reporter.log("On Main Window");

				}
				else
				{
					//	        	   org.openqa.selenium.Dimension screenResolution = new org.openqa.selenium.Dimension(-2000,-2000);
					//	        	   driver.manage().window().setSize(screenResolution);
					//	        	   driver.manage().window().setPosition(new Point(-2000, -2000));
					((JavascriptExecutor)driver).executeScript("window.resizeTo(0, 0);");
					docDet= Jsoup.parse(driver.getPageSource());
					
					//20-04-2021-Window Popup structure changed
					
					String strtrafficauhdate=driver.findElement(By.xpath("//*[@id='divContainer']/div[6]/div[2]")).getAttribute("innerHTML");
					traffic_date=com.getSqlDate(strtrafficauhdate);
					Time=driver.findElement(By.xpath("//*[@id='divContainer']/div[7]/div[2]")).getAttribute("innerHTML");
					fine_Source=driver.findElement(By.xpath("//*[@id='divContainer']/div[5]/div[2]")).getText();
					//.getAttribute("innerHTML");
					location=driver.findElement(By.xpath("//*[@id='divContainer']/div[12]/div[2]")).getAttribute("innerHTML");
					regNo=driver.findElement(By.xpath("//*[@id='divContainer']/div[13]/div[2]")).getAttribute("innerHTML");
					plate_source=driver.findElement(By.xpath("//*[@id='divContainer']/div[17]/div[2]")).getAttribute("innerHTML");
					PlateCategory=driver.findElement(By.xpath("//*[@id='divContainer']/div[15]/div[2]")).getAttribute("innerHTML");
					pcolor=PlateCategory;
					LicenseNo=driver.findElement(By.xpath("//*[@id='divContainer']/div[20]/div[2]")).getAttribute("innerHTML");
					LicenseFrom=driver.findElement(By.xpath("//*[@id='divContainer']/div[21]/div[2]")).getAttribute("innerHTML");
					NotPayReason=driver.findElement(By.xpath("//*[@id='divContainer']/div[10]/div[2]")).getAttribute("innerHTML");
					Amount=Double.parseDouble(driver.findElement(By.xpath("//*[@id='divContainer']/div[22]/div/table/tbody/tr/td[3]")).getAttribute("innerHTML"));
					fine=driver.findElement(By.xpath("//*[@id='divContainer']/div[22]/div/table/tbody/tr/td[3]")).getAttribute("innerHTML");
					remarks=driver.findElement(By.xpath("//*[@id='divContainer']/div[22]/div/table/tbody/tr/td[1]")).getAttribute("innerHTML");
					java.util.Date date=new java.util.Date();
					//*[@id="divContainer"]/div[22]/div/table/tbody/tr/td[3]
					sd=com.getSqlDate(date);
					type="TRF";
					//*[@id="divContainer"]/div[22]/div/table/tbody/tr/td[1]
					/*Elements tabEl = null;
					tabEl = docDet.select("table#dtTicDetails");


					Elements tableHeaderEles = tabEl.select("thead tr th");

					for (int i = 0; i < tableHeaderEles.size(); i++) {

					}
					//System.out.println();

					Elements tableRowElements = tabEl.select("tr");
*/
					tcno=tcno1;
					/*for (int j = 0; j < tableRowElements.size(); j++) {

						Element row = tableRowElements.get(j);
						Elements rowItems = row.select("span");
						String tddata="";
						int a=0;
						for (Element nextTurn : rowItems) {


							tddata=nextTurn.text();

							//System.out.println("===jjj========"+j+"====aaaaaa===="+a+"=tddatatddatatddatatddata==="+tddata);
							if((j==18)&&(a==0)){
								DESC1=tddata;
							}
							a=a+1;


						}

						//System.out.println("Data in the detail window"+j+"daaaatttaaaa"+tddata);
						if(j==0)
							//		ck      	
							//		      		  descriptionPane.setText(descriptionPane.getText()+"Fine# "+tddata);		      		
							//descriptionPane.update(descriptionPane.getGraphics());
						{
							//Ticket_No=tddata;
							continue;
						}
						//System.out.println("===="+tddata);
						if(j==3){
							String tddatadate = tddata;

							traffic_date=com.getSqlDate(tddatadate);
							//System.out.println("===="+traffic_date);							
						}
						if(j==4)
						{
							Time=tddata;
						}
						if(j==2)
						{
							fine_Source=tddata;
						}
						if(j==8)
						{
							location=tddata;
						}
						if(j==9){
							//pcolor=tddata;
							regNo=tddata;
						}

						if(j==13){
							plate_source=tddata;

						}



						if(j==13){
							plate_source=tddata;

						}

						if(j==11){

							String cat="";
							try{
								//Connection conn = ClsConnection.getMyConnection();
								String z="";

							}catch (Exception e) {
								e.printStackTrace();
							}
							finally{
								cat=tddata;
							}
							PlateCategory=tddata;
							pcolor=cat;
						}


						if(j==16)
						{
							LicenseNo=tddata;
						}
						if(j==17)
						{
							LicenseFrom=tddata;
						}
						if(j==7)
						{
							NotPayReason=" ";
						}
						if(j==3)
						{
							Amount=Double.parseDouble(disc);
						}
						if(j==10){
							regNo=tddata;
						}
						if(j==12){
							pcolor=tddata;
						}
						if(j==14){
							plate_source=tddata;
						}
						fine=fees;
						remarks=remark;


						java.util.Date date=new java.util.Date();

						sd=com.getSqlDate(date);
						type="TRF";

					}*/

					//System.out.println("====Ticket_No====="+Ticket_No+"==DESC1======"+DESC1);
					
					if(getCmbtrafficsite().equalsIgnoreCase("AUH")&& getCategory().equalsIgnoreCase("traffic")){
						tcno=ts;
					}
					
					SATdownloadDAO dao=new SATdownloadDAO();
					boolean result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,LicenseNo,
							LicenseFrom,NotPayReason,Amount,location,fine,remarks,sd,type,category,srno,tcno,xdoc,sd,branch,
							plate_source,getCmbtrafficsite(),DESC1,xdocs);
					setDocs(String.valueOf(xdocs));

					serno=k;
					srno=srno+k;



					driver.close();

					docDet=null;
				}

				driver.switchTo().window(defaultwindow);

			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	public void loadData() throws IOException, InterruptedException
	{
		ArrayList list =new ArrayList();
		HashMap map =new HashMap();

		try{





			ResultSet rsload = conn.createStatement().executeQuery("Select Salik_User,Trans,salik_date,salik_time,sal_date,regNo,Source,TagNo,Location,Direction,Amount,date from gl_salik where Doc_no in ("+xdocs+")");


			while(rsload.next())
			{	


			}	
		}catch (Exception e2) {e2.printStackTrace();}




	}

	public boolean inputCaptcha(String xPmsg) throws UnsupportedEncodingException, SQLException
	{


		boolean flag=true;
		HttpServletRequest request=ServletActionContext.getRequest();
		String realPath = request.getRealPath("/captcha.png");
		HttpSession session=request.getSession();
		String code="";

		String fname=code+'-'+doc+'-'+srno;
		String fname2=fname;

		String dirname =code==null?"Default":code;
		String path ="";

		Statement stmt1 = conn.createStatement();
		String strSql1 = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";

		ResultSet rs1 = stmt1.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("captchaPath");
			setCaptchapath(path);
		}

		String imgPath = getCaptchapath()+"/captcha.png";

		try
		{
			File temp=new File(imgPath);
			if (temp.exists()){

			}
			temp.delete();

			Thread.sleep(2000);
			DownloadImage(By.xpath("//img[contains(@src,'CaptchaImage')]"),imgPath);

			Thread.sleep(30000);

			do{ 

				setCaptcha(SATdownloadDAO.loadCaptcha()+"");

				/*WebElement txtcaptcha=driver.findElement(By.xpath("//img[contains(@src,'CaptchaImage')]"));
			 System.out.println("=====txtcaptcha==txtcaptcha==txtcaptcha=="+txtcaptcha);*/
				//setCaptchatxt(SATdownloadDAO.loadCaptchatext(getCaptchatxt()));		
				driver.findElement(By.id("SearchCapthcaControl")).sendKeys(getCaptcha().trim());
				doc= Jsoup.parse(driver.getPageSource()); 
				Elements tabEl = doc.select("table#WorkSpace_ctlCustAVIHistory_rgResult_ctl01");
				boolean xSrch = (tabEl.isEmpty()); 
				Thread.sleep(5000);
				if (xSrch){

					driver.findElement(By.id("btnSearch")).click();

				}

			}while(getCaptcha()==null);

			try
			{
				WebElement we=null;
				int count=0;
				int cnt=0;
				//Thread.sleep(8000);
				do
				{  

					////--commented by krish
					we = driver.findElement(By.id("ctl00_WorkSpace_ctlCustAVIHistory_RadAjaxPanelPlate"));
					setCaptchacount(0);
					String style = we.getAttribute("style").trim();

					if (!style.isEmpty())
						we=null;
					cnt++;
				}while(we==null && cnt<10);
				count++;

				Thread.sleep(5000);

				we = driver.findElement(By.id("ctl00_WorkSpace_ctlCustAVIHistory_lblErrorMessage"));
				String errMsg = we.getText().trim();


				if (!(errMsg.isEmpty() || errMsg.equals("") ||errMsg=="" || errMsg==null  ))
				{	
					setCaptchacount(1);
					driver.quit();
					flag=false;
					setMsg("Captcha Entered is wrong,Please Try Again!!");
					return flag;

					/*System.out.println("errMsg.isEmpty - "+errMsg);
							inputCaptcha("The code you typed has expired after 90 seconds.");*/
					//return;
				}

			}catch(Exception e){e.printStackTrace();}



		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return flag;
	}

	public boolean inputCaptchaDXB(String xPmsg) throws UnsupportedEncodingException, SQLException
	{


		boolean flag=true;
		HttpServletRequest request=ServletActionContext.getRequest();
		String realPath = request.getRealPath("/captcha.png");
		HttpSession session=request.getSession();
		String code="";

		String fname=code+'-'+doc+'-'+srno;
		String fname2=fname;

		String dirname =code==null?"Default":code;
		String path ="";

		Statement stmt1 = conn.createStatement();
		String strSql1 = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";

		ResultSet rs1 = stmt1.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("captchaPath");
			setCaptchapath(path);
		}

		String imgPath = getCaptchapath()+"/captcha.png";

		try
		{
			File temp=new File(imgPath);
			if (temp.exists()){

			}
			temp.delete();

			Thread.sleep(2000);
			DownloadImage(By.xpath("//img[contains(@src,'captchaGenerator')]"),imgPath);

			Thread.sleep(30000);


			do{ 

				setCaptcha(SATdownloadDAO.loadCaptcha()+"");

				/*WebElement txtcaptcha=driver.findElement(By.xpath("//img[contains(@src,'CaptchaImage')]"));
			 System.out.println("=====txtcaptcha==txtcaptcha==txtcaptcha=="+txtcaptcha);*/
				//setCaptchatxt(SATdownloadDAO.loadCaptchatext(getCaptchatxt()));		
				driver.findElement(By.id("securityCodeId")).sendKeys(getCaptcha().trim());
				doc= Jsoup.parse(driver.getPageSource());

				driver.findElement(By.id("btnSearchByPlate")).click();
				/*Elements tabEl = doc.select("table#WorkSpace_ctlCustAVIHistory_rgResult_ctl01");
				boolean xSrch = (tabEl.isEmpty()); 

				if (xSrch){

					driver.findElement(By.id("btnSearchByPlate")).click();

				}*/

			}while(getCaptcha()==null);





		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return flag;
	}
	
	//Vishakh Starts
	public boolean inputCaptchaTrafficAUH(String xPmsg) throws UnsupportedEncodingException, SQLException
	{


		boolean flag=true;
		HttpServletRequest request=ServletActionContext.getRequest();
		String realPath = request.getRealPath("/captcha.png");
		HttpSession session=request.getSession();
		String code="";

		String fname=code+'-'+doc+'-'+srno;
		String fname2=fname;

		String dirname =code==null?"Default":code;
		String path ="";

		Statement stmt1 = conn.createStatement();
		String strSql1 = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";

		ResultSet rs1 = stmt1.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("captchaPath");
			setCaptchapath(path);
		}

		String imgPath = getCaptchapath()+"/captcha.png";

		try
		{
			File temp=new File(imgPath);
			if (temp.exists()){

			}
			temp.delete();

			Thread.sleep(2000);
			
			DownloadImage(By.id("ctl00_ContentPlaceHolder1_imgCaptcha"),imgPath);
			
			Thread.sleep(30000);

			do{ 

				setCaptcha(SATdownloadDAO.loadCaptcha()+"");
				
				driver.findElement(By.id("ctl00_ContentPlaceHolder1_txtCaptcha")).sendKeys(getCaptcha().trim());

			    driver.findElement(By.id("ctl00_ContentPlaceHolder1_Btn_Submit")).click();

			}while(getCaptcha()==null);

			try
			{
				WebElement we=null;
				int count=0;
				int cnt=0;
				//Thread.sleep(8000);
				do
				{  

					we = driver.findElement(By.id("ctl00_ContentPlaceHolder1_lblError"));
					
					setCaptchacount(0);
					String style = we.getAttribute("style").trim();

					if (!style.isEmpty())
						we=null;
					cnt++;
				}while(we==null && cnt<10);
				count++;

				Thread.sleep(5000);
				
				we = driver.findElement(By.id("ctl00_ContentPlaceHolder1_lblError"));
				
				String errMsg = we.getText().trim();
				
				if (!(errMsg.isEmpty() || errMsg.equals("") ||errMsg=="" || errMsg==null  ))
				{	
					setCaptchacount(1);
					driver.quit();
					flag=false;
					setMsg("Captcha Entered is wrong,Please Try Again!!");
					return flag;

				}

			}catch(Exception e){e.printStackTrace();}



		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return flag;
	}
	//Vishakh Ends

	public void DownloadImage(By by,String loc)
	{
		try
		{


			HttpServletRequest request=ServletActionContext.getRequest();

			WebElement Image=driver.findElement(by);



			File screen=((TakesScreenshot)driver).getScreenshotAs(OutputType.FILE);
			//File screen=driver.save_screenshot('screenie.png');

			int width=Image.getSize().getWidth();
			int height=Image.getSize().getHeight();
			BufferedImage img=ImageIO.read(screen);

			BufferedImage dest=img.getSubimage(Image.getLocation().getX(), Image.getLocation().getY(), width, height);
			ImageIO.write(dest, "png", screen);
			request.setAttribute("image",screen);
			File temp=new File(loc);
			copyFile(screen,temp);
			setIscaptchaloaded(1);


		}catch(Exception e){e.printStackTrace();}


	}

	public  void copyFile(File source, File dest)
			throws IOException {
		Files.copy(source.toPath(), dest.toPath());
	}

	public void reloaddata(){
		setCategory(getCategory());
		setChck_salikautomatic(getChck_salikautomatic());
		setChck_trafficautomatic(getChck_trafficautomatic());
		setCmbsaliksite(getCmbsaliksite());
		setHidcmbtype(getCmbtype());
		setHidcmbsaliksite(getCmbsaliksite());
		setHidcmbtrafficsite( getCmbtrafficsite());
		setCmbtrafficsite(getCmbtrafficsite());
		setHidChck_trafficfileno(getChck_trafficfileno());
	}


}
