<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.commtransactions.travelinvoice.ClsTravelInvoiceDAO"%>
<% ClsTravelInvoiceDAO DAO= new ClsTravelInvoiceDAO(); %>
<%
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
 String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
 String Cl_names = request.getParameter("Cl_names")==null?"":request.getParameter("Cl_names");
 String reftype = request.getParameter("reftype")==null?"":request.getParameter("reftype");
 String trdate = request.getParameter("trdate")==null?"":request.getParameter("trdate");    
 String types = request.getParameter("types")==null?"":request.getParameter("types").trim(); 
%> 
 <script type="text/javascript">       
 var masterdata;          
 masterdata='<%=DAO.searchMaster(session,msdocno,Cl_names,reftype,trdate,types,id)%>';
  $(document).ready(function () {    	
      var num = 0; 
     var source =
     {
         datatype: "json",
         datafields: [
                  	{name : 'serdocno' , type: 'String' },
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'cldocno' , type: 'String' },
                   	{name : 'refname' , type: 'String' },
                   	{name : 'refno' , type: 'String' },
                   	{name : 'reftype' , type: 'String' },
                 	{name : 'types' , type: 'String' },
                    {name : 'remarks' , type: 'String'},  
                    {name : 'voc_no' , type: 'number'},  	
                   	],
          localdata: masterdata,
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
     };
     
     var dataAdapter = new $.jqx.dataAdapter(source,
     		 {
         		loadError: function (xhr, status, error) {
                 alert(error);    
                 }
	            }		
     );
     $("#subSearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
         selectionmode: 'singlerow',
         pagermode: 'default',
         columns: [ 
					{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
					{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },  
					{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
					{ text: 'serdocno', datafield: 'serdocno', width: '20%',hidden:true },
					{ text: 'Name', datafield: 'refname'},
					{ text: 'reftype', datafield: 'reftype', width: '8%',hidden:true },
					{ text: 'refno', datafield: 'refno', width: '7%',hidden:true },
					{ text: 'types', datafield: 'types', width: '8%',hidden:true  },
					{ text: 'Remarks', datafield: 'remarks', width: '20%',hidden:true },
					{ text: 'docno', datafield: 'doc_no', width: '20%',hidden:true }   
				]     
     });
     
     $('#subSearch').on('rowdoubleclick', function (event){ 
 	        var rowindex1=event.args.rowindex;

	       $('#travelDate').jqxDateTimeInput({ disabled: false});  
	       $('#travelDate').val($("#subSearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
	       document.getElementById("serdocno").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "serdocno");
           document.getElementById("cmbreftype").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "reftype"); 
           document.getElementById("masterdoc_no").value= $('#subSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
           document.getElementById("docno").value= $('#subSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
           document.getElementById("cmbclient").value= $('#subSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
           document.getElementById("txtclientname").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "refname");
           document.getElementById("refno").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "refno");
           document.getElementById("txttype").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "types");   
           document.getElementById("txtremarks").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "remarks");
  		   var indexVal2 = $('#subSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
  		   var serdocno =$('#subSearch').jqxGrid('getcellvalue', rowindex1, "serdocno");
  	       $("#accdiv").load("accountingDetails.jsp?docNo="+indexVal2+"&check="+1);            
           $('#window').jqxWindow('close');            
     	   $('#travelDate').jqxDateTimeInput({ disabled: false});     
     	   if($('#txttype').val()=="tour"){
             $('#ticketshow').hide();
			 $('#hotelshow').hide();
			 $('#tourshow').show();
			 $("#tourdiv").load("tourDetails.jsp?rdocno="+serdocno+"&check="+1);    
           }else if($('#txttype').val()=="ticket"){
             $('#ticketshow').show();
			 $('#hotelshow').hide();
			 $('#tourshow').hide();
			 $("#ticketdiv").load("ticketGrid.jsp?rdocno="+serdocno+"&id="+1);  
           }else if($('#txttype').val()=="hotel"){   
             $('#ticketshow').hide();
			 $('#hotelshow').show();      
			 $('#tourshow').hide();
			 $("#hoteldiv").load("hotelGrid.jsp?rdocno="+serdocno+"&id="+1);      
           }else{  
            
           }
     	});	 
 });
</script>
<div id="subSearch"></div>
    </body>
</html>
