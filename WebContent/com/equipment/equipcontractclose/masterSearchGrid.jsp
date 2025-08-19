
<%@page import="com.equipment.equipcontractclose.*" %>

<%

ClsEquipContractCloseDAO viewDAO=new ClsEquipContractCloseDAO();

%>


 <%

 
String docno = request.getParameter("qutdocno")==null?"":request.getParameter("qutdocno");
String clientname = request.getParameter("clientname")==null?"":request.getParameter("clientname");
String contractvocno= request.getParameter("refno")==null?"":request.getParameter("refno");
String date = request.getParameter("qutdate")==null?"":request.getParameter("qutdate");
String branch = request.getParameter("branch")==null?"1":request.getParameter("branch");
String id = request.getParameter("id")==null?"0":request.getParameter("id");
String assetid = request.getParameter("assetid")==null?"0":request.getParameter("assetid");

%> 

 <script type="text/javascript">
 
 var qutmasterdata=[]; 
 var id='<%=id%>';
if(id=="1"){
	qutmasterdata='<%=viewDAO.searchMaster(branch,docno,clientname,contractvocno,date,id,assetid)%>'; 	
}
 

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                   	{name : 'docno' , type: 'number' },
                	{name : 'vocno' , type: 'number' },
                	{name : 'contractvocno' , type: 'number' },
                	
                   	{name : 'date' , type: 'date' },
                     {name : 'contractdocno' , type: 'String' },
                   	{name : 'refname' , type: 'String' },
                   	{name : 'description' , type: 'String' },
                   	{name : 'contractdetails' , type: 'String' },
                 	{name : 'enddate' , type: 'date' },
                 	{name : 'endtime' , type: 'String' },
                 	{name : 'assetid' , type: 'String' },

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
				{ text: 'Contract Doc No', datafield: 'contractdocno', width: '20%',hidden:true },
				{ text: 'Contract Doc No', datafield: 'contractvocno', width: '15%' },
				{ text: 'Name', datafield: 'refname' },
				{ text: 'Description', datafield: 'description', width: '20%',hidden:true },
			//	{ text: 'Client', datafield: 'refname', width: '15%'},
				{ text: 'End Date', datafield: 'enddate', width: '15%',hidden:true },
				{ text: 'End Time', datafield: 'endtime', width: '20%',hidden:true },
				{ text: 'Asset Id', datafield: 'assetid', width: '8%' },

				]
     });
  /*    $("#qutmasterSearch").jqxGrid('addrow', null, {}); */
     
     $('#qutmasterSearch').on('rowdoubleclick', function (event) 
     		{ 
 	  		var rowindex1=event.args.rowindex;
    		$('#docno').val($('#qutmasterSearch').jqxGrid('getcellvalue',rowindex1,'docno'));
    		$('#vocno').val($('#qutmasterSearch').jqxGrid('getcellvalue',rowindex1,'vocno'));
    		$('#enddate').jqxDateTimeInput('val',$('#qutmasterSearch').jqxGrid('getcellvalue',rowindex1,'enddate'));
    		$('#endtime').jqxDateTimeInput('val',$('#qutmasterSearch').jqxGrid('getcellvalue',rowindex1,'endtime'));
    		$('#desc').val($('#qutmasterSearch').jqxGrid('getcellvalue',rowindex1,'description'));
    		$('#contractdocno').val($('#qutmasterSearch').jqxGrid('getcellvalue',rowindex1,'contractdocno'));
    		$('#contractvocno').val($('#qutmasterSearch').jqxGrid('getcellvalue',rowindex1,'contractvocno'));
    		$('#contractdetails').val($('#qutmasterSearch').jqxGrid('getcellvalue',rowindex1,'refname'));
    		funSetlabel();
    		var docno=$('#docno').val();
			$('#rentalcontractgriddiv').load('rentalContractGrid.jsp?docno='+docno+'&id=1');
         	$('#window').jqxWindow('close');
     
     		 });	 
     
 });
</script>
<div id="qutmasterSearch"></div>

    
    </body>
</html>
