<%@page import="com.dashboard.operations.tariffmanagementlist.ClsTariffManagementListDAO" %>
<%ClsTariffManagementListDAO cod=new ClsTariffManagementListDAO(); %>

<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<style type="text/css">
        .salesManClass
        {
            background-color: #FFEBEB;
        }
        .salesAgentClass
        {
            background-color: #FFFFD1;
        }
        .rentalAgentClass
        {
           background-color: #FFFAFA;
        }
         .driverClass
        {
           background-color: #F0FFFF;
        }
         .staffClass
        {
           background-color: #F8E0F7;
        }
         .checkInClass
        {
           background-color: #F7F2E0;
        }
        .whiteClass
        {
           background-color: #fff;
        }
</style>

<script type="text/javascript">
	  	var data1,detExcel;  
	  	var temp='<%=check%>';
	  	
	  	if(temp=='1'){
	  		data1='<%=cod.DetailGridLoading(docno,check)%>';
	  		detExcel='<%=cod.DetailExcelLoading(docno,check)%>';
	  	}
	  	
        $(document).ready(function () {
        	
        	/*$("#btnExcel").click(function() {
    			$("#staffList").jqxGrid('exportdata', 'xls', 'StaffList');
    		});*/
        	
        	var source =
            {
                datatype: "json",
                datafields: [
						{ name : 'docno', type: 'String' },
						{ name : 'gid', type: 'String' },
						{ name : 'rentaltype' , type: 'string' },
                       	{ name : 'rate' , type:'number'},
                       	{ name : 'cdw' , type:'number'},
                       	{ name : 'pai' , type:'number'},
                       	{ name : 'cdw1' , type:'number'},
                       	{ name : 'pai1' , type:'number'},
                       	{ name : 'gps' , type:'number'},
                       	{ name : 'babyseater' , type:'number'},
                       	{ name : 'cooler' , type:'number'}, 
                       	{ name : 'exhrchg' , type:'number'},
                       	{ name : 'chaufchg' , type:'number'},
                       	{ name : 'chaufexchg' , type:'number'},
                       	{ name : 'disclevel1' , type:'number'},
                       	{ name : 'disclevel2' , type:'number'},
                       	{ name : 'disclevel3' , type:'number'},
                       	{ name : 'kmrest' , type:'number'},
                       	{ name : 'exkmrte' , type:'number'},
                       	{ name : 'oinschg' , type:'number'},
   						{ name : 'securityamt', type: 'String' },
   						{ name : 'insurexcess', type: 'String' },
   						{ name : 'cdwexcess', type: 'String' },
   						{ name : 'scdwexcess', type: 'String' }
   						
	            ],
                localdata: data1,
               
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
            
            $("#detailList").jqxGrid(
            {
                width: '98%',
                height: 300,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                showfilterrow:true,
                enabletooltips:true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
                            { text: 'Group Name', datafield: 'gid', width: '8%'},
						    { text: 'Rental Type', datafield: 'rentaltype', width: '8%'},
							{ text: 'Tariff',  datafield: 'rate',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: 'CDW',  datafield: 'cdw',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: 'PAI',  datafield: 'pai',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: 'Super CDW',  datafield: 'cdw1',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: '',  datafield: 'pai1',cellsformat: 'd2',cellsalign:'right',hidden:true},
							{ text: 'GPS',  datafield: 'gps',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: 'Child Seat',  datafield: 'babyseater',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: '',  datafield: 'cooler',cellsformat: 'd2',cellsalign:'right',hidden:true},
							{ text: 'KM Restrict',  datafield: 'kmrest',cellsalign:'right', width: '8%'},
							{ text: 'Excess KM Rate',  datafield: 'exkmrte',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: '',  datafield: 'oinschg',cellsformat: 'd2',cellsalign:'right',hidden:true},
							{ text: '',  datafield: 'exhrchg',cellsformat: 'd2',cellsalign:'right',hidden:true},
							{ text: 'Chauffer',  datafield: 'chaufchg',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: '',  datafield: 'chaufexchg',cellsformat: 'd2',cellsalign:'right',hidden:true},
							{ text: 'Disc Level1',  datafield: 'disclevel1',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: 'Disc Level2',  datafield: 'disclevel2',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: 'Disc Level3',  datafield: 'disclevel3',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: 'Security Amount',  datafield: 'securityamt',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: 'Insurance Excess',  datafield: 'insurexcess',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: 'CDW Excess',  datafield: 'cdwexcess',cellsformat: 'd2',cellsalign:'right', width: '8%'},
							{ text: 'Super CDW Excess',  datafield: 'scdwexcess',cellsformat: 'd2',cellsalign:'right', width: '8%'},
					   
					 ]
            });
            
            $("#overlay, #PleaseWait").hide();
             
        });

</script>
<div id="detailList"></div>
