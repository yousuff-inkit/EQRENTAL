<%@page import="com.operations.marketing.rentalcontract.*" %>
<%ClsRentalContractDAO cvd=new ClsRentalContractDAO(); %>

 <%
 
 String docno = request.getParameter("docno")==null?"":request.getParameter("docno");
 String date = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
 String id=request.getParameter("id")==null?"0":request.getParameter("id");
 String attention=request.getParameter("attention")==null?"":request.getParameter("attention");
 String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
%> 
 <script type="text/javascript">
var temp='<%=id%>';
var quotedata=[];
if(temp==1){
	quotedata='<%=cvd.getQuoteData(docno,date,attention,cldocno,id)%>';
} 
               
        $(document).ready(function () { 
         
        	
            var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                                                   	
							{name : 'doc_no' , type: 'string' },
							{name : 'voc_no' , type: 'string' },
							{name : 'date' , type:'date'},
							{name : 'attention' , type: 'String' },
     						{name : 'description', type: 'String'  },
     						{name : 'delcharges',type:'number'},		
     						{name : 'collcharges',type:'number'},		
     						{name : 'vatamt',type:'number'},		
     						{name : 'totalamt',type:'number'},	
     						{name : 'delremark',type:'string'},	
     						{name : 'srvcharges',type:'number'},	
     						{name : 'srvdesc',type:'string'},	
                          	],
                          	localdata: quotedata,
                          
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#quoteSearchGrid").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,

                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
				
				{ text: 'Doc No', datafield: 'doc_no', width: '8%',hidden:true},
				{ text: 'Doc No', datafield: 'voc_no', width: '10%'},
				{ text: 'Date',  datafield: 'date',  width: '10%',cellsformat:'dd.MM.yyyy'},
				{ text: 'Attention',datafield: 'attention', width: '20%' },
				{ text: 'Description', datafield: 'description' , width: '60%' },
				{ text: 'Del Charges', datafield: 'delcharges',hidden:true},
				{ text: 'collcharges', datafield: 'collcharges',hidden:true},
				{ text: 'vatamt', datafield: 'vatamt',hidden:true},
				{ text: 'totalamt', datafield: 'totalamt',hidden:true},
				{ text: 'delremark', datafield: 'delremark',hidden:true},
				{ text: 'srvcharges', datafield: 'srvcharges',hidden:true},
				{ text: 'srvdesc', datafield: 'srvdesc',hidden:true},
								
					]
            });
    
      
				            
			$('#quoteSearchGrid').on('rowdoubleclick', function (event) 
			{ 
				var rowindex=event.args.rowindex;
				$('#refno').val($('#quoteSearchGrid').jqxGrid('getcellvalue',rowindex,'voc_no'));
				$('#hidrefno').val($('#quoteSearchGrid').jqxGrid('getcellvalue',rowindex,'doc_no'));
				$('#delcharges').val($('#quoteSearchGrid').jqxGrid('getcellvalue',rowindex,'delcharges'));
				$('#collcharges').val($('#quoteSearchGrid').jqxGrid('getcellvalue',rowindex,'collcharges'));
				$('#vatamt').val($('#quoteSearchGrid').jqxGrid('getcellvalue',rowindex,'vatamt'));
				$('#totalamt').val($('#quoteSearchGrid').jqxGrid('getcellvalue',rowindex,'totalamt'));
				$('#delremark').val($('#quoteSearchGrid').jqxGrid('getcellvalue',rowindex,'delremark'));
				$('#srvcharges').val($('#quoteSearchGrid').jqxGrid('getcellvalue',rowindex,'srvcharges'));
				$('#srvdesc').val($('#quoteSearchGrid').jqxGrid('getcellvalue',rowindex,'srvdesc'));
				$('#qotwindow').jqxWindow('close');
			});	 
		}); 
		
    </script>
    <div id="quoteSearchGrid"></div>
    
