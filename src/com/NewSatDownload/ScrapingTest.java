package com.NewSatDownload;

import java.sql.SQLException;
import java.text.ParseException;

import org.openqa.selenium.chrome.ChromeDriver;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import com.opensymphony.xwork2.ActionSupport;

public class ScrapingTest extends ActionSupport{
	public String process() throws ParseException, SQLException{
		System.setProperty("webdriver.chrome.driver", "C:\\Users\\gw-rahis\\Downloads\\chromedriver.exe");    //setup
		try{
			Document doc = Jsoup.connect("https://es.adpolice.gov.ae/TrafficServices/FinesPublic/Inquiry.aspx?Culture=en").userAgent("Mozilla/17.0").get();
			Elements plateid=doc.select("#ctl00_ContentPlaceHolder1_txtByTcf");
			plateid.append("1070028291");
			return "success";
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
}
