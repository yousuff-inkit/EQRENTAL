<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.commtransactions.refundrequest.ClsRefundRequestDAO"%>
<% ClsRefundRequestDAO DAO= new ClsRefundRequestDAO(); %> 
<%
 String id = request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id");
 String brhid = request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");   
 String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
 String reftype = request.getParameter("reftype")==null?"":request.getParameter("reftype");
 String trdate = request.getParameter("trdate")==null?"":request.getParameter("trdate");    
%> 
 <script type="text/javascript">       
 var masterdata;          
 masterdata='<%=DAO.searchMaster(session,msdocno,reftype,trdate,id,brhid)%>';              
  $(document).ready(function () {    	
      var num = 0;   
     var source =
     {
         datatype: "json",
         datafields: [
                  	{name : 'voc_no' , type: 'String' },
                   	{name : 'doc_no' , type: 'String' },
                   	{name : 'date' , type: 'date' },
                   	{name : 'refname' , type: 'String' },
                   	{name : 'refdocno' , type: 'String' },
                   	{name : 'refno' , type: 'String' },
                   	{name : 'reftype' , type: 'String' },
                   	{name : 'reftypeid' , type: 'String' },     
                    {name : 'remarks' , type: 'String'},  
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
					{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },
					{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },  
					{ text: 'Customer', datafield: 'refname', width: '20%'},
					{ text: 'reftype', datafield: 'reftype', width: '8%'},
					{ text: 'reftype', datafield: 'reftypeid', width: '8%',hidden:true},     
				    { text: 'refno', datafield: 'refno', width: '7%',hidden:true  },
					{ text: 'refdocno', datafield: 'refdocno', width: '7%',hidden:true  },
					{ text: 'Remarks', datafield: 'remarks' },
				]     
     });
     $('#subSearch').on('rowdoubleclick', function (event){ 
 	       var rowindex1=event.args.rowindex;

	       $('#travelDate').jqxDateTimeInput({ disabled: false});  
	       $('#travelDate').val($("#subSearch").jqxGrid('getcellvalue', rowindex1, "date")) ; 
	       document.getElementById("refdocno").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "refdocno");
           document.getElementById("cmbreftype").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "reftypeid");   
           document.getElementById("masterdoc_no").value= $('#subSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
           document.getElementById("docno").value= $('#subSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
           document.getElementById("txtclientname").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "refname");
           document.getElementById("refno").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "refno");
           document.getElementById("txtremarks").value=$('#subSearch').jqxGrid('getcellvalue', rowindex1, "remarks");       
  		   var indexVal2 = $('#subSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");  
     	   $('#travelDate').jqxDateTimeInput({ disabled: false});     
     	   var serdocno = document.getElementById("refdocno").value;      
			    $('#jqxTicketGrid').jqxGrid('clear');
			    $('#jqxHotelGrid').jqxGrid('clear');  
			    $('#tourGrid').jqxGrid('clear'); 
			    if($('#cmbreftype').val()=="T"){  
			             $('#ticketshow').hide();
						 $('#hotelshow').hide();
						 $('#tourshow').show();
						 $("#tourdiv").load("tourDetails.jsp?rdocno="+serdocno+"&check="+1+"&refund="+1+"&rrdocno="+indexVal2);
			    }else if($('#cmbreftype').val()=="A"){
			    		 $('#ticketshow').show(); 
						 $('#hotelshow').hide();
						 $('#tourshow').hide();
						 $("#ticketdiv").load("ticketGrid.jsp?rdocno="+serdocno+"&id="+1+"&refund="+1+"&rrdocno="+indexVal2);
			    }else if($('#cmbreftype').val()=="V"){       
			             $('#ticketshow').hide();
						 $('#hotelshow').show();      
						 $('#tourshow').hide();
						 $("#hoteldiv").load("hotelGrid.jsp?rdocno="+serdocno+"&id="+1+"&refund="+1+"&rrdocno="+indexVal2);     
			    }else{}   
           $('#window').jqxWindow('close');      
     	});	 
 });
</script>
<div id="subSearch"></div>
    </body>
</html>
