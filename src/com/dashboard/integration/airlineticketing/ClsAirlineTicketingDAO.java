package com.dashboard.integration.airlineticketing;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoAlertPresentException;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.support.ui.Select;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAirlineTicketingDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getDownloadData(String docno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and doc_no="+docno;
			}
			String strsql="select doc_no, airline,documentno,issuedate,netamount from gl_limoairlinedata where status=3"+sqltest;
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
	
	public boolean isAlertPresent(WebDriver driver){
		try{
			driver.switchTo().alert();
			return true;
		}
		catch(NoAlertPresentException e){
			return false;
		}
	}
	
	public int downloadData(HttpSession session)throws SQLException,NoAlertPresentException{
		WebDriver driver=null;
		Connection conn=null;
		int docno=0;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strgetdata="select country,username,password from gl_limoiata";
			String country="",username="",password="";
			ResultSet rsgetdata=stmt.executeQuery(strgetdata);
			while(rsgetdata.next()){
				country=rsgetdata.getString("country");
				username=rsgetdata.getString("username");
				password=rsgetdata.getString("password");
			}
			String defaultwindow = "";
			String url="https://www.bsplink.iata.org/bsplink14/default.asp";
			java.util.logging.Logger.getLogger("com.gargoylesoftware.htmlunit").setLevel(java.util.logging.Level.OFF);
			java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);
			FirefoxProfile profile = new FirefoxProfile();
			profile.setPreference( "pdfjs.disabled", true );
			profile.setPreference("browser.cache.disk.enable", false);
			profile.setPreference("browser.cache.memory.enable", false);
			profile.setPreference("browser.cache.offline.enable", false);
			profile.setPreference("network.http.use-cache", false);
			profile.setEnableNativeEvents(true);
			profile.setPreference("network.proxy.http", "localhost");
			profile.setPreference("network.proxy.http_port", "3128");
			driver = new FirefoxDriver();
			//driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
			Thread.sleep(5000);
			driver.get(url);
			defaultwindow = driver.getWindowHandle();
			
			driver.findElement(By.xpath("//*[@id='FORM1']/table/tbody/tr[1]/td[2]/input")).sendKeys(country);
			driver.findElement(By.xpath("//*[@id='FORM1']/table/tbody/tr[1]/td[2]/input")).sendKeys(Keys.TAB);
			driver.findElement(By.xpath("//*[@id='FORM1']/table/tbody/tr[3]/td[2]/input")).sendKeys(username);
			driver.findElement(By.xpath("//*[@id='FORM1']/table/tbody/tr[4]/td[2]/input")).sendKeys(password);
			
			driver.findElement(By.name("B1")).click();
			
			Thread.sleep(10000);
			if(isAlertPresent(driver)){
				Alert alert = driver.switchTo().alert();
				alert.accept();
			}
			
			driver.switchTo().defaultContent();
			driver.switchTo().frame("contenido"); 
			driver.findElement(By.xpath("//*[@id='arrowsidemenuid']/div[8]/a")).click();
			Thread.sleep(2000);
			driver.findElement(By.xpath("//*[@id='arrowsidemenuid']/ul[8]/li[3]/a")).click();
		
			Thread.sleep(10000);
			
			ArrayList<String> dataarray=new ArrayList<>();
			String strlastrecon="select year(curdate()) baseyear,month(curdate()) basemonth,year(date_add(lastairrecondate,interval 1 month)) nextyear,month(date_add(lastairrecondate,interval 1 month)) nextmonth from my_comp where doc_no="+session.getAttribute("COMPANYID").toString();
			int nextyear=0,nextmonth=0,baseyear=0,basemonth=0;
			ResultSet rslastrecon=stmt.executeQuery(strlastrecon);
			while(rslastrecon.next()){
				nextyear=rslastrecon.getInt("nextyear");
				nextmonth=rslastrecon.getInt("nextmonth");
				baseyear=rslastrecon.getInt("baseyear");
				basemonth=rslastrecon.getInt("basemonth");
			}
			int counter=0;
			while(nextyear<=baseyear && nextmonth<=basemonth){
				if(counter!=0){
					System.out.println("Counter:"+counter);
					System.out.println("Year:"+nextyear+"::"+baseyear);
					System.out.println("Month:"+nextmonth+"::"+basemonth);
					driver.switchTo().defaultContent();
					driver.switchTo().frame("contenido"); 	
					driver.findElement(By.xpath("//*[@id='arrowsidemenuid']/div[8]/a")).click();
					System.out.println("condition:"+(counter%2));
					System.out.println("Inside Counter%2");
					driver.switchTo().defaultContent();
					driver.switchTo().frame("contenido");
					driver.findElement(By.xpath("//*[@id='arrowsidemenuid']/div[8]/a")).click();
					String chkselected=driver.findElement(By.xpath("//*[@id='arrowsidemenuid']/div[8]")).getAttribute("class").split(" ")[1];
					do{
						driver.findElement(By.xpath("//*[@id='arrowsidemenuid']/div[8]/a")).click();
						chkselected=driver.findElement(By.xpath("//*[@id='arrowsidemenuid']/div[8]")).getAttribute("class").split(" ")[1];
					}while(chkselected.equalsIgnoreCase("unselected"));
					
					Thread.sleep(2000);
					driver.findElement(By.xpath("//*[@id='arrowsidemenuid']/ul[8]/li[3]/a")).click();
					Thread.sleep(10000);
				}
				driver.switchTo().defaultContent();
				driver.switchTo().frame("principal");
				Thread.sleep(6000);
				Select drpyear=new Select(driver.findElement(By.xpath("//*[@id='periods_table']/tbody/tr/td/table/tbody/tr[2]/td[1]/select")));
				drpyear.selectByVisibleText(nextyear+"");
				String strmonth=nextmonth<10?("0"+nextmonth):(nextmonth)+"";
				Select drpmonth=new Select(driver.findElement(By.xpath("//*[@id='periods_table']/tbody/tr/td/table/tbody/tr[2]/td[2]/select")));
				drpmonth.selectByValue(strmonth);
				Thread.sleep(2000);
				Select drpperiodfrom=new Select(driver.findElement(By.xpath("//*[@id='periods_table']/tbody/tr/td/table/tbody/tr[2]/td[3]/select")));
				drpperiodfrom.selectByIndex(0);
				Select drpperiodto=new Select(driver.findElement(By.xpath("//*[@id='periods_table']/tbody/tr/td/table/tbody/tr[2]/td[4]/select")));
				drpperiodto.selectByIndex(drpperiodto.getOptions().size()-1);
				driver.findElement(By.name("b1")).click();
				
				Thread.sleep(10000);
				
				List<WebElement> tbltotaltickets=driver.findElements(By.tagName("table"));
				System.out.println("Table Size: "+tbltotaltickets.size());
				
				for(int i=1;i<tbltotaltickets.size();i++){
					//System.out.println(tbltotaltickets.get(i).getAttribute("innerHTML"));
					//Airline Name
					try{
						WebElement chktblexist=driver.findElement(By.xpath("//table["+(i+1)+"]"));
					}
					catch(NoSuchElementException ex){
						break;
					}
					int rowindex=5;
					String airline=driver.findElement(By.xpath("//table["+(i+1)+"]/tbody/tr[1]/td[2]/p")).getText().trim();
					System.out.println("Airline: "+airline);
					String documentno="",issuedate="",netamount="",rowcolor="",comments="";
					do{
						if(driver.findElements(By.xpath("//div["+i+"]/center/table/tbody/tr["+rowindex+"]/td[1]/a")).size()>0){
							documentno=driver.findElement(By.xpath("//div["+i+"]/center/table/tbody/tr["+rowindex+"]/td[1]/a")).getText().trim();
						}
						else if(driver.findElements(By.xpath("//div["+i+"]/center/table/tbody/tr["+rowindex+"]/td[1]/p")).size()>0){
							documentno=driver.findElement(By.xpath("//div["+i+"]/center/table/tbody/tr["+rowindex+"]/td[1]/p")).getText().trim();
						}
						
						System.out.println("Document: "+documentno);
						issuedate=driver.findElement(By.xpath("//div["+i+"]/center/table/tbody/tr["+rowindex+"]/td[2]")).getText().trim();
						netamount=driver.findElement(By.xpath("//div["+i+"]/center/table/tbody/tr["+rowindex+"]/td[14]")).getText().trim();
						comments=driver.findElement(By.xpath("//div["+i+"]/center/table/tbody/tr["+rowindex+"]/td[17]")).getText().trim();
						rowindex++;
						rowcolor=driver.findElement(By.xpath("//div["+i+"]/center/table/tbody/tr["+rowindex+"]/td[1]")).getAttribute("class");
						System.out.println("Row Color:"+rowcolor+"::"+rowindex);
						System.out.println(airline+"::"+documentno+"::"+issuedate+"::"+netamount+"::"+comments);
						dataarray.add(airline+" :: "+documentno+" :: "+issuedate+" :: "+netamount+" :: "+comments);
					}while(rowcolor.equalsIgnoreCase("GRAY"));
					
				}
				if(nextmonth==12){
					nextyear++;
					nextmonth=1;
				}
				else{
					nextmonth++;
				}
				counter++;
			}
			
			String strmaxdoc="select coalesce(max(doc_no),0)+1 maxdoc from gl_limoairlinedata";
			ResultSet rsmaxdoc=stmt.executeQuery(strmaxdoc);
			
			while(rsmaxdoc.next()){
				docno=rsmaxdoc.getInt("maxdoc");
			}
			
			String brhid=session.getAttribute("BRANCHID")==null || session.getAttribute("BRANCHID").toString().equalsIgnoreCase("")?"0":session.getAttribute("BRANCHID").toString();
			String userid=session.getAttribute("USERID").toString();
			for(int i=0;i<dataarray.size();i++){
				String issuedate=dataarray.get(i).split("::")[2].trim();
				String airline=dataarray.get(i).split("::")[0].trim();
				String documentno=dataarray.get(i).split("::")[1].trim();
				String netamount=dataarray.get(i).split("::")[3].trim();
				String comments=dataarray.get(i).split("::")[4].trim();
				java.sql.Date sqlissuedate =null;
				if(!issuedate.trim().equalsIgnoreCase("")){
					SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
					java.util.Date date = sdf1.parse(issuedate);
					sqlissuedate = new java.sql.Date(date.getTime());
				}
				netamount=netamount.replaceAll(",", "");
				netamount=netamount.equalsIgnoreCase("")?"0.0":netamount;
				String strcount="select count(*) rowcount from gl_limoairlinedata where airline='"+airline+"' and documentno='"+documentno+"'";
				int rowcount=0;
				ResultSet rscount=stmt.executeQuery(strcount);
				while(rscount.next()){
					rowcount=rscount.getInt("rowcount");
				}
				if(rowcount==0){
					if(sqlissuedate!=null){
						String strinsert="insert into gl_limoairlinedata(doc_no,downloaddate, airline, documentno, issuedate, netamount, status, brhid, userid,comments)values("+docno+",now(),'"+airline+"','"+documentno+"','"+sqlissuedate+"',"+netamount+",3,"+brhid+","+userid+",'"+comments+"')";
						System.out.println(strinsert);
						int insertvalue=stmt.executeUpdate(strinsert);
						if(insertvalue<=0){
							return 0;
						}
					}
					else{
						String strinsert="insert into gl_limoairlinedata(doc_no,downloaddate, airline, documentno, issuedate, netamount, status, brhid, userid,comments)values("+docno+",now(),'"+airline+"','"+documentno+"',"+sqlissuedate+","+netamount+",3,"+brhid+","+userid+",'"+comments+"')";
						System.out.println(strinsert);
						int insertvalue=stmt.executeUpdate(strinsert);
						if(insertvalue<=0){
							return 0;
						}
					}
				}
				
				
			}
			//Logging off
			driver.switchTo().defaultContent();
			driver.switchTo().frame("inferior");
			driver.switchTo().frame("inferior");
			driver.findElement(By.linkText("Log off")).click();
			
		}
		catch(Exception e){
			e.printStackTrace();
			driver.switchTo().defaultContent();
			driver.switchTo().frame("inferior");
			driver.switchTo().frame("inferior");
			driver.findElement(By.linkText("Log off")).click();
			return 0;
		}
		finally{
			driver.quit();
		}
		return docno;
	}
}
