package com.dashboard.limousine.importdata;
import java.io.File;
import java.io.FileInputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;





/*import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
*/
import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsApplyDelete;
import com.connection.ClsConnection;

import java.io.*;
import java.util.*;

import org.xml.sax.*;

import javax.xml.parsers.*;
import javax.xml.transform.*;

import org.xml.sax.helpers.*;

import javax.xml.transform.sax.*;
import javax.xml.transform.stream.*;

import com.limousine.limobooking.ClsLimoBookingDAO;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
public class ClsLimoImportDataDAO {
	static StreamResult streamResult;
	static TransformerHandler handler;
	static AttributesImpl atts;
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public int ExcelImport(String docNo,String cldocno) throws SQLException {
		Connection conn = null;
		try{
			// System.out.println("===excel action=="+docNo);
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			int errorstatus=0;
			Statement stmt = conn.createStatement();
			String path="";
			String sqltest="",sqltest2="";
			int indid=0,sid=0;
			String strSql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='BLID'";
			ResultSet rs = stmt.executeQuery(strSql);
			while(rs.next()) {
				path=rs.getString("path");
			}
			path = path.replace("\\", "//");

			/*FileInputStream input = new FileInputStream(path);
			POIFSFileSystem fs = new POIFSFileSystem( input );
			HSSFWorkbook wb = new HSSFWorkbook(fs);

			OPCPackage pkg = OPCPackage.open(input);
			XSSFWorkbook wb = new XSSFWorkbook(pkg);
			XSSFSheet sheet = wb.getSheetAt(0);
			//XSSFSheet sheet = wb.getSheetAt(0);
*/	
			/*//Loading an existing document
		      File file = new File(path);
		      PDDocument document = PDDocument.load(file);

		      //Instantiate PDFTextStripper class
		      PDFTextStripper pdfStripper = new PDFTextStripper();

		      //Retrieving text from PDF document
		      String text = pdfStripper.getText(document);
		      System.out.println(text);

		      //Closing the document
		      document.close();*/
			FileInputStream input = new FileInputStream(path);
			POIFSFileSystem fs=null;
			int excelconfig=0;
			//String strexcelconfig="select method from gl_config where field_nme='limoExcelImport'";
			String strexcelconfig="select if(refname='M/S Alpha Tours L.L.C',1,0) method from my_acbook where cldocno="+cldocno+" and dtype='CRM' and status=3";
			ResultSet rsexcelconfig=stmt.executeQuery(strexcelconfig);
			while(rsexcelconfig.next()){
				excelconfig=rsexcelconfig.getInt("method");
			}
			int temprowindex=3;
			int activerowindex=0;
			int exceltype=0;
			System.out.println("Path: "+path);
			if(path.contains("xlsx")){
				exceltype=1;
			}
			else{
				exceltype=2;
				fs = new POIFSFileSystem( input );
			}
			if(excelconfig==1){
				int sheetcount=0;
				int imageFound=0;
				XSSFWorkbook wb1=null;
				HSSFWorkbook wb2=null;
				XSSFSheet sheet1=null;
				HSSFSheet sheet2=null;
				if(exceltype==1){
					OPCPackage pkg = OPCPackage.open(input);
					wb1 = new XSSFWorkbook(pkg);
					sheetcount=wb1.getNumberOfSheets();
				}
				else{
					wb2 = new HSSFWorkbook(fs);
					sheetcount=wb2.getNumberOfSheets();
				}
				
				
				for(int sheetindex=0;sheetindex<sheetcount;sheetindex++){
					if(exceltype==1){
						sheet1= wb1.getSheetAt(sheetindex);
					}
					else{
						sheet2= wb2.getSheetAt(sheetindex);
					}
					 
					Row row;
					temprowindex=3;
					String guestdetails="",pax="",pickupdate="",pickuptime="",pickupaddress="",dropoffaddress="",vehdetails="",otherdetails="",remarks="",refno="",bookingcode="";
					for(int i=1; i<=(exceltype==1?sheet1:sheet2).getLastRowNum(); i++){
						//Clearing the fields
						guestdetails="";
						pax="";
						pickupdate="";
						pickuptime="";
						pickupaddress="";
						dropoffaddress="";
						vehdetails="";
						otherdetails="";
						remarks="";
						refno="";
						bookingcode="";
						row = (exceltype==1?sheet1:sheet2).getRow(i);
						System.out.println("Sheet Index:"+sheetindex);
						System.out.println("Row Index:"+temprowindex);
						if(sheetindex==0 || sheetindex%2==0){
							row = (exceltype==1?sheet1:sheet2).getRow(0);
							if(row.getCell(0)!=null){
								row.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
								refno = row.getCell(0)==null?"":row.getCell(0).getStringCellValue()==""?"":row.getCell(0).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
								refno=refno.trim().split(" ")[0];
							}
						}
						else{
							if(imageFound==0){
								row = (exceltype==1?sheet1:sheet2).getRow(4);
								imageFound++;
								activerowindex=4;
							}
							else{
								//System.out.println("First Cell Type:"+(exceltype==1?sheet1:sheet2).getRow(0).getCell(0).getCellType());
								if((exceltype==1?sheet1:sheet2).getRow(0).getCell(0)==null){
									temprowindex++;
									if((exceltype==1?sheet1:sheet2).getRow(1).getCell(0).getStringCellValue().equalsIgnoreCase("Date meeting")){
										temprowindex--;
									}
								}
								else{
									if((exceltype==1?sheet1:sheet2).getRow(0).getCell(0).getStringCellValue().equalsIgnoreCase("Date meeting")){
										temprowindex--;
									}
								}
								
								row = (exceltype==1?sheet1:sheet2).getRow(temprowindex);
								activerowindex=temprowindex;
							}
							
							if(row.getCell(0)!=null){
								if(DateUtil.isCellDateFormatted(row.getCell(0))){
									SimpleDateFormat pickupdateformat=new SimpleDateFormat("dd-MM-yyyy");
									pickupdate=pickupdateformat.format(row.getCell(0).getDateCellValue());
									if(pickupdate.contains("-")){
										pickupdate=pickupdate.replace("-", ".");
									}
								}
								else{
									row.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
									pickupdate = row.getCell(0)==null?"":row.getCell(0).getStringCellValue()==""?"":row.getCell(0).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
									if(pickupdate.contains("-")){
										pickupdate=pickupdate.replace("-", ".");
									}
								}
							}
							if(row.getCell(1)!=null){
								row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
								pickuptime = row.getCell(1)==null?"":row.getCell(1).getStringCellValue()==""?"":row.getCell(1).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
							}
							if(row.getCell(2)!=null){
								row.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
								pickupaddress = row.getCell(2)==null?"0":row.getCell(2).getStringCellValue()==""?"":row.getCell(2).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
							}
							if(row.getCell(3)!=null){
								row.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
								dropoffaddress = row.getCell(3)==null?"":row.getCell(3).getStringCellValue()==""?"":row.getCell(3).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
							}
							if(row.getCell(4)!=null){
								row.getCell(4).setCellType(Cell.CELL_TYPE_STRING); 
								otherdetails = row.getCell(4)==null?"":row.getCell(4).getStringCellValue()==""?"":row.getCell(4).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
							}
							if(row.getCell(5)!=null){
								row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
								pax  = row.getCell(5)==null?"":row.getCell(5).getStringCellValue()==""?"0":row.getCell(5).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
							}
							if(row.getCell(6)!=null){
								row.getCell(6).setCellType(Cell.CELL_TYPE_STRING); 
								vehdetails = row.getCell(6)==null?"":row.getCell(3).getStringCellValue()==""?"":row.getCell(3).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
							}
							if(row.getCell(8)!=null){
								row.getCell(8).setCellType(Cell.CELL_TYPE_STRING); 
								bookingcode = row.getCell(8)==null?"":row.getCell(8).getStringCellValue()==""?"":row.getCell(8).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
							}
							if(row.getCell(11)!=null){
								row.getCell(11).setCellType(Cell.CELL_TYPE_STRING); 
								remarks = row.getCell(11)==null?"":row.getCell(11).getStringCellValue()==""?"":row.getCell(11).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
							}
							if(row.getCell(12)!=null){
								row.getCell(12).setCellType(Cell.CELL_TYPE_STRING); 
								remarks = ","+row.getCell(12)==null?"":row.getCell(12).getStringCellValue()==""?"":row.getCell(12).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
							}
							if(row.getCell(13)!=null){
								row.getCell(13).setCellType(Cell.CELL_TYPE_STRING); 
								remarks = ","+row.getCell(13)==null?"":row.getCell(13).getStringCellValue()==""?"":row.getCell(13).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
							}
							if(row.getCell(14)!=null){
								row.getCell(14).setCellType(Cell.CELL_TYPE_STRING);
								guestdetails = row.getCell(14)==null?"":row.getCell(14).getStringCellValue()==""?"":row.getCell(14).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
							}
							
							String sql="INSERT INTO gl_limoimportreqdata(rdocno, srno, guestdetails, pax, pickupdate, pickuptime, pickupaddress, dropoffaddress, vehdetails, status,otherdetails,remarks,refno)VALUES"
								       + " ("+docNo+","+(i)+",'"+guestdetails+"',"+pax+",'"+pickupdate+"','"+pickuptime+"','"+pickupaddress+"','"+dropoffaddress+"','"+vehdetails+"',3,'"+otherdetails+"','"+remarks+"','"+refno+"')";
							System.out.println(sql);
							int insertval=stmt.executeUpdate(sql);
							if(insertval<=0){
								errorstatus=1;
							}
							Row temprow=(exceltype==1?sheet1:sheet2).getRow(activerowindex+1);
							if(temprow==null){
								temprowindex=3;
								break;
							}
							else if(temprow!=null){
								if(temprow.getCell(0)==null){
									temprowindex=3;
									break;
								}
								else{
									temprowindex++;
								}
							}
							
						}
					}
				}
				
			}
			else{
				HSSFWorkbook wb = new HSSFWorkbook(fs);
				HSSFSheet sheet = wb.getSheetAt(0);
				Row row;
				String guestdetails="",pax="",pickupdate="",pickuptime="",pickupaddress="",dropoffaddress="",vehdetails="",otherdetails="",remarks="",refno="";
				for(int i=1; i<=sheet.getLastRowNum(); i++){
					//Clearing the fields
					guestdetails="";
					pax="";
					pickupdate="";
					pickuptime="";
					pickupaddress="";
					dropoffaddress="";
					vehdetails="";
					otherdetails="";
					remarks="";
					refno="";
					row = sheet.getRow(i);
					if(i==1){
						for(int j=0;j<=9;j++){
							System.out.println("Index "+j+"::"+row.getCell(j));
						}
					}
					if(row.getCell(0)!=null){
						if(row.getCell(0).getCellType()==Cell.CELL_TYPE_NUMERIC && DateUtil.isCellDateFormatted(row.getCell(0))){
							SimpleDateFormat pickupdateformat=new SimpleDateFormat("dd-MM-yyyy");
							pickupdate=pickupdateformat.format(row.getCell(0).getDateCellValue());
							if(pickupdate.contains("-")){
								pickupdate=pickupdate.replace("-", ".");
							}
						}
						else{
							row.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
							pickupdate = row.getCell(0)==null?"":row.getCell(0).getStringCellValue()==""?"":row.getCell(0).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
							if(pickupdate.contains("-")){
								pickupdate=pickupdate.replace("-", ".");
							}
						}
					}
					if(row.getCell(1)!=null){
						if(row.getCell(1).getCellType()==Cell.CELL_TYPE_NUMERIC && DateUtil.isCellDateFormatted(row.getCell(1))){
							SimpleDateFormat pickuptimeformat=new SimpleDateFormat("HH:mm:ss");
							pickuptime=pickuptimeformat.format(row.getCell(1).getDateCellValue());
							if(pickuptime.trim().length()>5){
								pickuptime=pickuptime.substring(0,5);
							}
						}
						else{
							row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
							pickuptime = row.getCell(1)==null?"":row.getCell(1).getStringCellValue()==""?"":row.getCell(1).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
						}
					}
					if(row.getCell(2)!=null){
						row.getCell(2).setCellType(Cell.CELL_TYPE_STRING); 
						otherdetails = row.getCell(2)==null?"":row.getCell(2).getStringCellValue()==""?"":row.getCell(2).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
					}
					if(row.getCell(3)!=null){
						row.getCell(3).setCellType(Cell.CELL_TYPE_STRING); 
						vehdetails = row.getCell(3)==null?"":row.getCell(3).getStringCellValue()==""?"":row.getCell(3).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
					}
					if(row.getCell(4)!=null){
						row.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
						pax  = row.getCell(4)==null?"":row.getCell(4).getStringCellValue()==""?"0":row.getCell(4).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
					}
					if(row.getCell(5)!=null){
						row.getCell(5).setCellType(Cell.CELL_TYPE_STRING); 
						remarks = row.getCell(5)==null?"":row.getCell(5).getStringCellValue()==""?"":row.getCell(5).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
					}
					if(row.getCell(6)!=null){
						row.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
						pickupaddress = row.getCell(6)==null?"0":row.getCell(6).getStringCellValue()==""?"":row.getCell(6).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
					}
					if(row.getCell(7)!=null){
						row.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
						dropoffaddress = row.getCell(7)==null?"":row.getCell(7).getStringCellValue()==""?"":row.getCell(7).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
					}
					if(row.getCell(8)!=null){
						row.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
						guestdetails = row.getCell(8)==null?"":row.getCell(8).getStringCellValue()==""?"":row.getCell(8).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
					}
					if(row.getCell(9)!=null){
						row.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
						refno = row.getCell(9)==null?"":row.getCell(9).getStringCellValue()==""?"":row.getCell(9).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
					}
					System.out.println("select count(*) rowcount from gl_limoimportreq m left join gl_limoimportreqdata d on (m.doc_no=d.rdocno) where m.cldocno="+cldocno+" and d.refno='"+refno+"' and m.status=3 and m.doc_no<>"+docNo);
					ResultSet rscheckrefno=stmt.executeQuery("select count(*) rowcount from gl_limoimportreq m left join gl_limoimportreqdata d on (m.doc_no=d.rdocno) where m.cldocno="+cldocno+" and d.refno='"+refno+"' and m.status=3 and m.doc_no<>"+docNo);
					
					int refcount=0;
					while(rscheckrefno.next()){
						refcount=rscheckrefno.getInt("rowcount");
					}
					/*if(refcount>0){
						Connection conn2=objconn.getMyConnection();
						int deletemaster=conn2.createStatement().executeUpdate("delete from gl_limoimportreq where doc_no="+docNo);
						int deletefileattach=conn2.createStatement().executeUpdate("delete from my_fileattach where dtype='BLID' and doc_no="+docNo);
						errorstatus=1;
						conn2.close();
						return 0;
					}*/
					String sql="INSERT INTO gl_limoimportreqdata(rdocno, srno, guestdetails, pax, pickupdate, pickuptime, pickupaddress, dropoffaddress, vehdetails, status,otherdetails,remarks,refno)VALUES"
						       + " ("+docNo+","+(i)+",'"+guestdetails+"',"+pax+",'"+pickupdate+"','"+pickuptime+"','"+pickupaddress+"','"+dropoffaddress+"','"+vehdetails+"',3,'"+otherdetails+"','"+remarks+"','"+refno+"')";
					System.out.println(sql);
					int insertval=stmt.executeUpdate(sql);
					if(insertval<=0){
						errorstatus=1;
					}
				}
			}
			
			if(errorstatus==0){
				conn.commit();
				input.close();
				return 1;
			}
			input.close();
			
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
			return 0;
		}
		finally{
			conn.close();
		}
		return 0;
	}
	
	
	public JSONArray getClient(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select refname,cldocno from my_acbook where status=3 and dtype='CRM'";
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	
	public JSONArray getImportedGridData(String docno,String id,String type,String cldocno,String fromdate,String todate,String branch) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="";
			if(type.equalsIgnoreCase("1")){
				String sqltest="";
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
					sqltest+=" and reqm.date>='"+sqlfromdate+"'";
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=objcommon.changeStringtoSqlDate(todate);
					sqltest+=" and reqm.date<='"+sqltodate+"'";
				}
				if(!cldocno.equalsIgnoreCase("")){
					sqltest+=" and reqm.cldocno="+cldocno;
				}
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqltest+=" and reqm.brhid="+branch;
				}
				strsql="select reqd.* from gl_limoimportreq reqm inner join gl_limoimportreqdata reqd on (reqm.doc_no=reqd.rdocno) where reqm.status=3 and reqm.bookdocno=0"+sqltest;
			}
			else{
				strsql="select * from gl_limoimportreqdata where rdocno="+docno+" and status=3";
			}
			System.out.println(strsql);
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
	
	
	public  JSONArray getLocations(String id) throws SQLException {
	    JSONArray locdata=new JSONArray();
	    Connection conn = null;
		try {
			conn=objconn.getMyConnection();
			Statement stmtTarif = conn.createStatement ();
			String strSql="select doc_no,location from gl_cordinates where status=3";
	    	ResultSet resultSet = stmtTarif.executeQuery (strSql);
	    	locdata=objcommon.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return locdata;
	}


	public String createLimoBooking(ArrayList<String> basetransferarray,String docno, HttpSession session, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int errorstatus=0;
		String limobookvocno="";
		try{
			conn=objconn.getMyConnection();
			ArrayList<String> transferarray=new ArrayList();
			for(int i=0,j=1;i<basetransferarray.size();i++,j++){
				System.out.println("Base Transfer Row "+i+" : with size "+basetransferarray.get(i).split("::").length+" "+basetransferarray.get(i));
				String docname="T"+j;
				String guestdetails=basetransferarray.get(i).split("::").length>=0?basetransferarray.get(i).split("::")[0].trim():"";
				String pax=basetransferarray.get(i).split("::").length>1?basetransferarray.get(i).split("::")[1].trim():"0";
				String pickupdate=basetransferarray.get(i).split("::").length>2?basetransferarray.get(i).split("::")[2].trim():"";
				String pickuptime=basetransferarray.get(i).split("::").length>3?basetransferarray.get(i).split("::")[3].trim():"";
				String pickupaddress=basetransferarray.get(i).split("::").length>4?basetransferarray.get(i).split("::")[4].trim():"";
				String dropoffaddress=basetransferarray.get(i).split("::").length>5?basetransferarray.get(i).split("::")[5].trim():"";
				String vehicledetails=basetransferarray.get(i).split("::").length>6?basetransferarray.get(i).split("::")[6].trim():"";
				
				/* docname+"::"+pickupdate+"::"+pickuptime+"::"+transferrows[i].pickuplocationid+"::"+transferrows[i].pickupaddress+"::"+transferrows[i].dropofflocationid+"::"+transferrows[i].dropoffaddress+"::"+transferrows[i].brandid+"::"+transferrows[i].modelid+"::"+transferrows[i].nos+"::"+transferrows[i].tarifdocno+"::"+othersrvcstatus+"::"+transferrows[i].gid+"::"+transferrows[i].tarifdetaildocno+"::"+transferrows[i].transfertype+"::"+transferrows[i].estdistance+"::"+esttime+"::"+transferrows[i].tarif+"::"+transferrows[i].exdistancerate+"::"+transferrows[i].extimerate */
				transferarray.add(docname+"::"+pickupdate+"::"+pickuptime+"::"+0+"::"+pickupaddress+"::"+0+"::"+dropoffaddress+"::"+0+"::"+0+"::"+1+"::"+0+"::"+0+"::"+0+"::"+0+"::"+"Private"+"::"+0+"::"+"00:00"+"::"+0+"::"+0+"::"+0);
			}
			java.sql.Date sqldate=null;
			String branchid="",cldocno="";
			String strsql="select CURDATE() basedate,brhid,cldocno from gl_limoimportreq where doc_no="+docno;
			Statement stmt=conn.createStatement();
			ResultSet rsmisc=stmt.executeQuery(strsql);
			while(rsmisc.next()){
				sqldate=rsmisc.getDate("basedate");
				branchid=rsmisc.getString("brhid");
				cldocno=rsmisc.getString("cldocno");
			}
			ArrayList<String> newtransferarray=new ArrayList();
			int transferjobserial=1;
			for(int i=0;i<transferarray.size();i++){
				if(!transferarray.get(i).split("::")[9].equalsIgnoreCase("") && !transferarray.get(i).split("::")[9].equalsIgnoreCase("undefined") && transferarray.get(i).split("::")[9]!=null){
					for(int j=0;j<Integer.parseInt(transferarray.get(i).split("::")[9]);j++){
						String temp[]=transferarray.get(i).split("::");
						newtransferarray.add("T"+transferjobserial+"::"+temp[1]+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[7]+"::"+temp[8]+"::"+1+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[13]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]);
						transferjobserial++;
					}
				}
			}
			String note="";
			ClsLimoBookingDAO bookingdao=new ClsLimoBookingDAO();
			String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
			int val=bookingdao.insert(sqldate,cldocno,"0","","","0",session,"A","LBK",branchid,"","","","","","");
			if(val>0){
				ArrayList<String> blankarray=new ArrayList();
				boolean status=bookingdao.insertTarif(val,newtransferarray,blankarray,session,"A");
				if(status){
					for(int i=0,j=1;i<basetransferarray.size();i++,j++){
						String guestdetails=basetransferarray.get(i).split("::")[0].trim();
						String pax=basetransferarray.get(i).split("::")[1].trim();
						String vehdetails=basetransferarray.get(i).split("::").length>6?basetransferarray.get(i).split("::")[6].trim():"";
						String otherdetails="";
						String remarks=basetransferarray.get(i).split("::").length>8?basetransferarray.get(i).split("::")[8].trim():"";
						String refno=basetransferarray.get(i).split("::").length>9?basetransferarray.get(i).split("::")[9].trim():"";
						if(basetransferarray.get(i).split("::").length>7){
							otherdetails=basetransferarray.get(i).split("::").length>7?basetransferarray.get(i).split("::")[7].trim():"";
						}
						else{
							otherdetails="";
						}
						String docname="T"+j;
						String strupdatetransfer="update gl_limobooktransfer set guestdetails='"+guestdetails+"',pax="+pax+",vehdetails='"+vehdetails+"',otherdetails='"+otherdetails+"',remarks='"+remarks+"',refno='"+refno+"' where bookdocno="+val+" and docname='"+docname+"' and status=3";
						int updatetransfer=stmt.executeUpdate(strupdatetransfer);
						if(updatetransfer<=0){
							errorstatus=1;
						}
						String strupdatemgmt="update gl_limomanagement set guest='"+guestdetails+"',pax="+pax+",bookremarks='"+remarks+"',otherdetails='"+otherdetails+"',refno='"+refno+"' where docno="+val+" and job='"+docname+"'";
						System.out.println(strupdatemgmt);
						int updatemgmt=stmt.executeUpdate(strupdatemgmt);
						if(updatemgmt<=0){
							errorstatus=1;
						}
					}
					if(errorstatus==0){
						ArrayList<String> billarray=new ArrayList();
						billarray.add("Client"+"::"+"On Account"+"::"+"100");
						int billval=bookingdao.insertBill(val,billarray);
						if(billval>0){
							String strupdate="update gl_limoimportreq set bookdocno="+val+" where doc_no="+docno;
							int updatevalue=stmt.executeUpdate(strupdate);
							if(updatevalue<=0){
								errorstatus=1;
							}
							else{
								limobookvocno=session.getAttribute("LIMOBOOKVOCNO").toString();
								PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
								stmtlog.setInt(1,Integer.parseInt(docno));
								stmtlog.setInt(2,Integer.parseInt(branchid));
								stmtlog.setString(3,"BLID");
								stmtlog.setInt(4, Integer.parseInt(userid));
								stmtlog.setInt(5, 0);
								stmtlog.setInt(6, 0);
								stmtlog.setString(7, "A");
								int log=stmtlog.executeUpdate();
								if(log<=0){
									errorstatus=1;
								}
								else{
									limobookvocno=session.getAttribute("LIMOBOOKVOCNO").toString();
								}
							}
						}
						else{
							limobookvocno=session.getAttribute("LIMOBOOKVOCNO").toString();
							errorstatus=1;	
						}
					}
					else{
						errorstatus=1;
					}
					
				}
				else{
					limobookvocno=session.getAttribute("LIMOBOOKVOCNO").toString();
					errorstatus=1;
				}
			}
			else{
				limobookvocno=session.getAttribute("LIMOBOOKVOCNO").toString();
				errorstatus=1;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return errorstatus+"::"+limobookvocno;
	}
	
/*	
	public void importPDF(){
		try{
			System.out.println("Inside Import PDF");
			Document document = new Document();
			document.open();
			PdfReader reader = new PdfReader("C:\\QUICK.pdf");
			PdfDictionary page = reader.getPageN(1);
			//PRIndirectReference objectReference = (PRIndirectReference) page
			//		.get(PdfName.CONTENTS);
			PRIndirectReference objectReference = (PRIndirectReference) page
					.get(PdfName.CONTENTS);
			PRStream stream = (PRStream) PdfReader
					.getPdfObject(objectReference);
			byte[] streamBytes = PdfReader.getStreamBytes(stream);
			PRTokeniser tokenizer = new PRTokeniser(streamBytes);
		
			StringBuffer strbufe = new StringBuffer();
			while (tokenizer.nextToken()) {
				if (tokenizer.getTokenType() == PRTokeniser.TK_STRING) {
					strbufe.append(tokenizer.getStringValue());
				}
			}
			String test = strbufe.toString();
			streamResult = new StreamResult("data.xml");
			initXML();
			process(test);
			closeXML();
			document.add(new Paragraph(".."));
			document.close();
		}
		catch(Exception e){   //if title element isn't found, handle JauntiumException.
			System.err.println(e);          
		}
	}
	
	public static void initXML() throws ParserConfigurationException,
	TransformerConfigurationException, SAXException {
SAXTransformerFactory tf = (SAXTransformerFactory) SAXTransformerFactory
		.newInstance();

handler = tf.newTransformerHandler();
Transformer serializer = handler.getTransformer();
serializer.setOutputProperty(OutputKeys.ENCODING, "ISO-8859-1");
serializer.setOutputProperty(
		"{http://xml.apache.org/xslt}indent-amount", "4");
serializer.setOutputProperty(OutputKeys.INDENT, "yes");
handler.setResult(streamResult);
handler.startDocument();
atts = new AttributesImpl();
handler.startElement("", "", "Roseindia", atts);
}

public static void process(String s) throws SAXException {
String[] elements = s.split("\\|");
atts.clear();
handler.startElement("", "", "Message", atts);
handler.characters(elements[0].toCharArray(), 0, elements[0].length());
handler.endElement("", "", "Message");
}

public static void closeXML() throws SAXException {
handler.endElement("", "", "Roseindia");
handler.endDocument();
}*/
}
