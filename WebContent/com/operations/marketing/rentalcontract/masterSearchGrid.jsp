
<%@page import="com.operations.marketing.rentalcontract.*" %>

<%

ClsRentalContractDAO viewDAO=new ClsRentalContractDAO();

%>


 <%

 
String qutdocno = request.getParameter("qutdocno")==null?"":request.getParameter("qutdocno");
String clientname = request.getParameter("clientname")==null?"":request.getParameter("clientname");
 String refno = request.getParameter("refno")==null?"":request.getParameter("refno");
 String qutdate = request.getParameter("qutdate")==null?"":request.getParameter("qutdate");
 String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
 String quttype = request.getParameter("quttype")==null?"":request.getParameter("quttype").trim(); 
 String assetid = request.getParameter("assetid")==null?"0":request.getParameter("assetid");
%> 

 <script type="text/javascript">
 
 var qutmasterdata=[]; 
 var id='<%=id%>';
if(id=="1"){
	qutmasterdata='<%=viewDAO.searchMaster(branch,qutdocno,clientname,refno,qutdate,quttype,id,assetid)%>';	
}
  

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
                 	{name : 'refno' , type: 'String' },
                 	{name : 'reftype' , type: 'String'} ,
                    {name : 'remarks' , type: 'String'} ,
                    {name : 'attn_to' , type: 'String'} ,
                    {name : 'glterms' , type: 'String'} ,
                    {name : 'assetid' , type: 'String'} 

                    
                    
						
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
				{ text: 'Name', datafield: 'refname' },
				{ text: 'Ref Type', datafield: 'reftype', width: '15%' },
				{ text: 'Email', datafield: 'email', width: '20%',hidden:true },
				{ text: 'Ref No', datafield: 'refno', width: '10%' },
				{ text: 'Remarks', datafield: 'remarks', width: '20%',hidden:true },
				{ text: 'attend', datafield: 'attn_to', width: '20%',hidden:true },
				{ text: 'gelterm', datafield: 'glterms', width: '20%',hidden:true },
				{ text: 'enqrefno', datafield: 'enqrefno', width: '20%',hidden:true },
				{ text: 'Asset Id', datafield: 'assetid', width: '8%' },

				]
     });
  /*    $("#qutmasterSearch").jqxGrid('addrow', null, {}); */
     
     $('#qutmasterSearch').on('rowdoubleclick', function (event) 
     		{ 
 	  		var rowindex1=event.args.rowindex;
    		$('#docno').val($('#qutmasterSearch').jqxGrid('getcellvalue',rowindex1,'docno'));
    		$('#vocno').val($('#qutmasterSearch').jqxGrid('getcellvalue',rowindex1,'vocno'));
    		
         $('#window').jqxWindow('close');
         $('#date,#lpodate,#hirefromdate').jqxDateTimeInput({ disabled: false});
     	$('#frmRentalContract select').attr('disabled', false );
     	 funSetlabel();
       document.getElementById("frmRentalContract").submit();
        
        
     
     		 });	 
     
 });
</script>
<div id="qutmasterSearch"></div>

    
    </body>
</html>
