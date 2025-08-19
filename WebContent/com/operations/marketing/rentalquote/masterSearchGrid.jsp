
<%@page import="com.operations.marketing.rentalquote.*" %>

<%

ClsRentalQuoteDAO viewDAO=new ClsRentalQuoteDAO();

%>


 <%

 
String qutdocno = request.getParameter("qutdocno")==null?"0":request.getParameter("qutdocno");
String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");
 String clmob = request.getParameter("clmob")==null?"0":request.getParameter("clmob");
 String qutdate = request.getParameter("qutdate")==null?"0":request.getParameter("qutdate");
 String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
 String quttype = request.getParameter("quttype")==null?"0":request.getParameter("quttype").trim(); 

%> 

 <script type="text/javascript">
 
 var qutmasterdata=[]; 
 

 qutmasterdata='<%=viewDAO.searchMaster(branch,qutdocno,clientname,clmob,qutdate,quttype,id)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                   	{name : 'docno' , type: 'number' },
                	{name : 'vocno' , type: 'number' },
                	{name : 'enqrefno' , type: 'number' },
                	
                   	{name : 'date' , type: 'date' },
                     {name : 'cldocno' , type: 'String' },
                   	{name : 'refname' , type: 'String' },
                   	{name : 'email' , type: 'String' },
                   	{name : 'contactperson' , type: 'String' },
                 	{name : 'contactnumber' , type: 'String' },
                 	{name : 'ref_no' , type: 'String' },
                 	{name : 'ref_type' , type: 'String'} ,
                    {name : 'remarks' , type: 'String'} ,
                    {name : 'attn_to' , type: 'String'} ,
                    {name : 'glterms' , type: 'String'} 
                    
                    
						
                   	],
          localdata: qutmasterdata,
         
         
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
     $("#qutmasterSearch").jqxGrid(
     {
         width: '100%',
         height: 290,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
         
         selectionmode: 'singlerow',
         pagermode: 'default',
        // sortable: true,
         //Add row method

         columns: [
              
                 
				{ text: 'Doc No', datafield: 'docno', width: '10%' ,hidden:true},
				{ text: 'Doc No', datafield: 'vocno', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'Name', datafield: 'refname', width: '25%' },
				{ text: 'Contact Person', datafield: 'contactperson', width: '35%' },
				{ text: 'Email', datafield: 'email', width: '20%',hidden:true },
				{ text: 'Contact Number', datafield: 'contactnumber', width: '15%' },
				{ text: 'ref_no', datafield: 'ref_no', width: '20%',hidden:true },
				{ text: 'ref_type', datafield: 'ref_type', width: '20%',hidden:true },
				{ text: 'Remarks', datafield: 'remarks', width: '20%',hidden:true },
				{ text: 'attend', datafield: 'attn_to', width: '20%',hidden:true },
				{ text: 'gelterm', datafield: 'glterms', width: '20%',hidden:true },
				{ text: 'enqrefno', datafield: 'enqrefno', width: '20%',hidden:true }
		
				]
     });
  /*    $("#qutmasterSearch").jqxGrid('addrow', null, {}); */
     
     $('#qutmasterSearch').on('rowdoubleclick', function (event) 
     		{ 
 	  		var rowindex1=event.args.rowindex;
    		$('#docno').val($('#qutmasterSearch').jqxGrid('getcellvalue',rowindex1,'docno'));
    		$('#vocno').val($('#qutmasterSearch').jqxGrid('getcellvalue',rowindex1,'vocno'));
    		
         $('#window').jqxWindow('close');
         $('#date').jqxDateTimeInput({ disabled: false});
     	$('#frmRentalQuote select').attr('disabled', false );
     	 funSetlabel();
       document.getElementById("frmRentalQuote").submit();
        
        
     
     		 });	 
     
 });
</script>
<div id="qutmasterSearch"></div>

    
    </body>
</html>
