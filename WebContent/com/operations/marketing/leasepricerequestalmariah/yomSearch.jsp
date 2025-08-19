<%@page import="com.operations.marketing.leasepricerequestalmariah.ClsLeasepriceRequestDAO" %>
<%ClsLeasepriceRequestDAO viewDAO=new ClsLeasepriceRequestDAO(); %>
<script type="text/javascript">
var yomdata= '<%=viewDAO.searchYom()%>';
$(document).ready(function () { 	
	var source =
	{
	    datatype: "json",
	    datafields: [
	                {name : 'yom', type: 'string'  },
	                {name : 'doc_no', type: 'string'  }
	
	            ],
	    		
	     localdata: yomdata,
	    
	    pager: function (pagenum, pagesize, oldpagenum) {
	        // callback called when a page or page size is changed.
	    }
	                            
	};
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#yomSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                columns: [
	                		{ text: 'DOC NO', datafield: 'doc_no', width: '30%'},
	                		{text: 'YoM', datafield: 'yom', width: '70%' }
						]
            });
            
          $('#yomSearchGrid').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "yom" ,$('#yomSearchGrid').jqxGrid('getcellvalue', rowindex2, "yom"));
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "yomid" ,$('#yomSearchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                document.getElementById("errormsg").innerText="";
              	$('#yomsearchwindow').jqxWindow('close'); 
          }); 
    });
    </script>
    <div id="yomSearchGrid"></div>