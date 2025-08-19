<%-- <%@page import="com.dashboard.limousine.importdata.ClsLimoImportDataDAO"%>
<%@page import="org.apache.pdfbox.pdmodel.PDDocument"%>
<%@page import="org.apache.pdfbox.text.PDFTextStripper"%>
<%@page import="org.apache.pdfbox.text.PDFTextStripperByArea"%>

<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%
	ClsLimoImportDataDAO importdao=new ClsLimoImportDataDAO();
try{
	PDDocument document = PDDocument.load(new File("C:\\QUICK.pdf"));

    document.getClass();

    if (!document.isEncrypted()) {
	
        PDFTextStripperByArea stripper = new PDFTextStripperByArea();
        stripper.setSortByPosition(true);

        PDFTextStripper tStripper = new PDFTextStripper();

        String pdfFileInText = tStripper.getText(document);
        //System.out.println("Text:" + st);

		// split by whitespace
        String lines[] = pdfFileInText.split("\\r?\\n");
        for (String line : lines) {
            System.out.println(line);
        }

    }

}
catch(IOException e){
	System.out.println("IOEXCEption");
}
	System.out.println("Import PDF Ajax");
	//importdao.importPDF();
%> --%>