<%@page import="com.dashboard.operations.reservevehicles.ClsReserveVehicleDAO"%>
<%
ClsReserveVehicleDAO DAO=new ClsReserveVehicleDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var data1;


if(id=='1'){
	data1='<%=DAO.getDetailData(id,cldocno,uptodate)%>';
}
else{
	data1=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                     
						{name : 'doc_no', type: 'String'  },
						{name : 'voc_no', type: 'String'  },
						{name : 'refname', type: 'String'},     						
						{name : 'po', type: 'String'}, 
						{name : 'refno', type: 'String'}, 
						{name : 'brand', type: 'string'  },
						{name : 'model', type: 'String'  },
						{name : 'spec', type: 'String'  },
						{name : 'duration', type: 'String'  },
						{name : 'outqty', type: 'string'  },
						{name : 'date', type: 'date'  },
						{name : 'detdocno', type: 'string'  },
						{name : 'qty', type: 'string'  },
						{name : 'balqty', type: 'string'  },
						
                  		],
				    localdata: data1,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#reserveVehicleGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#reserveVehicleGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Doc No',datafield:'voc_no',width:'8%'},
       				{ text: 'Date',datafield:'date',width:'8%', cellsformat: 'dd.MM.yyyy'},
       				{ text: 'Client',datafield:'refname',width:'17%'},
       				{ text: 'PO',datafield:'po',width:'6%'},
       				{ text: 'Ref No',datafield:'refno',width:'6%'},
       				{ text: 'Brand',datafield:'brand',width:'8%'},
       				{ text: 'Model',datafield:'model',width:'8%'},
       				{ text: 'Specification',datafield:'spec',width:'16%'},
       				{ text: 'Duration',datafield:'duration',width:'6%'},
       				{ text: 'Quantity',datafield:'qty',width:'6%',align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Out Qty',datafield:'outqty',width:'6%',align:'right',cellsalign:'right',cellsformat:'d2'},
					]
    
    });
    $('#reserveVehicleGrid').on('rowdoubleclick', function (event) 
      		{ 
    	var rowindex1=event.args.rowindex;
    	document.getElementById("masterrefno").value=$('#reserveVehicleGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
    	document.getElementById("detailrefno").value=$('#reserveVehicleGrid').jqxGrid('getcellvalue', rowindex1, "detdocno");
    	document.getElementById("hidbalqty").value=$('#reserveVehicleGrid').jqxGrid('getcellvalue', rowindex1, "balqty");
      		});	 
    });

	
	
</script>
<div id="reserveVehicleGrid"></div>