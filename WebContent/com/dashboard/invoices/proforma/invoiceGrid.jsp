 <%@page import="com.dashboard.invoices.proforma.*"%>
 <%ClsProformaInvDAO invoicedao=new ClsProformaInvDAO();
 String mode=request.getParameter("mode")==null?"":request.getParameter("mode");
 String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
 String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
 %>
 <style>
 .greenClass
        {
            background-color: #ACF6CB;
        }
 .greyClass
        {
           background-color: #D8D8D8;
        }
 .redClass
   		{
   		   background:#FFEBEB;
   		}
 </style>

<script type="text/javascript">
var invoicedata;
var mode='<%=mode%>';
if(mode=="1"){
	invoicedata='<%=invoicedao.getInvoiceData(uptodate,branch,mode)%>';
}
else if(mode=="2"){
	<%-- invoicedata='<%=invoicedao.getTotalData(uptodate,branch,mode)%>'; --%>
}
else{
	invoicedata=[];
}
$(document).ready(function(){
	var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
        if(typeof(value) == "undefined"){
        	value=0.00;
        }
        return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
	}
        	


    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

						{name:'agmtno',type:'number'},
						{name:'agmtvocno',type:'number'},
						{name:'rentaltype',type:'number'},
						{name:'clientacno',type:'number'},
						{name:'clientaccount',type:'number'},
						{name:'clientacname',type:'string'},
						{name:'cldocno',type:'number'},
						{name:'totalamt',type:'number'},
						{name:'rentalamt',type:'number'},
						{name:'accamt',type:'number'},
						{name:'insuramt',type:'number'},
						{name:'moredays',type:'number'},
						{name:'fromdate',type:'date'},
						{name:'todate',type:'date'},
						{name:'salikamt',type:'number'},
						{name:'trafficamt',type:'number'},
						{name:'saliksrvc',type:'number'},
						{name:'datediff',type:'string'},
						{name:'brhid',type:'String'},
						{name:'curid',type:'String'},
						{name:'insurchg',type:'String'},
						{name:'invtype',type:'String'},
						{name:'salikcount',type:'String'},
						{name:'trafficcount',type:'String'},
						{name:'salamount',type:'string'},
						{name:'salrate',type:'string'},
						{name:'account',type:'number'},
						{name:'duedatecal',type:'number'},
						{name:'trafficsrvc',type:'number'},
						{name:'outstanding',type:'number'},
						{name:'creditlimit',type:'number'}
						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#invoiceGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
//    	$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
    	});
    
    var cellclassname = function (row, column, value, data) {
     if(typeof(data.amount)=="undefined" || data.amount=="" ){
        	if(data.moredays==1){
            	return "redClass";
            }
        	else{
        		return "greyClass";	
        	};
        	 
        }
        else{
        	//alert(data.amount);
        	if(data.moredays==1){
            	return "redClass";
            }
        	else{
        		return "greenClass";	
        	};
        	
        };
       
          };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#invoiceGrid").jqxGrid(
    {
        width: '98%',
        height: 510,
        source: dataAdapter,
        showaggregates:true,
	showstatusbar:true,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        pagermode: 'default',
       sortable:false,
        columns: [
						{ text: 'Sr No.',datafield: '',columntype:'number', width: '4%',cellclassname: cellclassname, cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						{ text: 'Agreement No', datafield: 'agmtvocno', width: '8%'  ,cellclassname: cellclassname},
						{ text: 'Agreement No Original', datafield: 'agmtno', width: '4%'  ,cellclassname: cellclassname,hidden:true},
						{ text: 'Rental Type', datafield: 'rentaltype', width: '6%' ,cellclassname: cellclassname},
						{ text: 'Start/Last Invoiced', datafield: 'fromdate', width: '7%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
						{ text: 'To Date', datafield: 'todate', width: '7%',cellsformat:'dd.MM.yyyy'  ,cellclassname: cellclassname},
						{ text: 'Ac No Original', datafield: 'clientacno', width: '5%'   ,cellclassname: cellclassname,hidden:true},
						{ text: 'Ac No', datafield: 'clientaccount', width: '5%'   ,cellclassname: cellclassname},
						{ text: 'Ac Name', datafield: 'clientacname', width: '18%'  ,cellclassname: cellclassname},
						{ text: 'Outstanding', datafield: 'outstanding', width: '7%'  ,cellclassname: cellclassname,cellsalign:'right',align:'right',cellsformat:'d2'},
						{ text: 'Credit Limit', datafield: 'creditlimit', width: '7%'  ,cellclassname: cellclassname,cellsalign:'right',align:'right',cellsformat:'d2'},
						{ text: 'Amount', datafield: 'totalamt', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Cldocno', datafield: 'cldocno', width: '12%',cellsformat:'d2',hidden:true},
						{ text: 'Rental Sum', datafield: 'rentalamt', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Acc Sum', datafield: 'accamt', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Insurance Charges',datafield: 'insuramt', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'More Days',datafield: 'moredays', width: '7%',cellsalign:'right',align:'right' ,cellclassname: cellclassname,hidden:true},
						{ text: 'salik Amt', datafield: 'salikamt', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Traffic Amt', datafield: 'trafficamt', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Salik Srvc', datafield: 'saliksrvc', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Traffic Srvc', datafield: 'trafficsrvc', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'DateDifference', datafield: 'datediff', width: '17%',hidden:true},
						{ text: 'Brhid', datafield: 'brhid', width: '17%',hidden:true},
						{ text: 'CurId', datafield: 'curid', width: '17%',hidden:true},
						{ text: 'Invtype', datafield: 'invtype', width: '17%',hidden:true},
						{ text: 'Salik Count', datafield: 'salikcount', width: '17%',hidden:true},
						{ text: 'Traffic Count', datafield: 'trafficcount', width: '17%',hidden:true},
						{ text: 'Salik Amount', datafield: 'salamount', width: '17%',hidden:true},
						{ text: 'Salik Rate', datafield: 'salrate', width: '17%',hidden:true},
						{ text: 'duedatecal', datafield: 'duedatecal', width: '17%',hidden:true,cellclassname: cellclassname}
						/* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });


});

	
	
</script>
<div id="invoiceGrid"></div>