<%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO" %>
 <%
 ClsRentalAgreementDAO viewDAO= new ClsRentalAgreementDAO();
   	String docnovalss = request.getParameter("docnovals")==null?"0":request.getParameter("docnovals").trim();

   	%>

<style type="text/css">
        .redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
       
</style> 
<script type="text/javascript">


      
	
var accountsdata;
var tempss='<%=docnovalss%>';
if(tempss>0)
{
accountsdata= '<%=viewDAO.inspectionchecklistSearch(docnovalss)%>';
	
}
else
	{
	accountsdata;
	}
  	
        $(document).ready(function () {
        	
       
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'date' , type: 'date' },
							{name : 'time' , type:'string'},
							{name : 'doc_no' , type:'string'},
							{name : 'type',type:'string'},
							{name : 'user' , type:'string'},
							{name : 'rfleet' , type:'string'},
							{name : 'reftype' , type:'string'},
							{name : 'refdocno',type:'string'}
	                      ],
                          localdata: accountsdata,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
        		if (data.debit != '') {
                    return "redClass";
                } else if (data.credit != '') {
                    return "yellowClass";
                }
                /* else{
                	return "greyClass";
                }; */
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#inspchklist").jqxGrid(
            {
                width: '95%',
                height: 380,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
              	rowsheight:25,
             	statusbarheight:25, 
                editable: false,
              
                //Add row method
                columns: [   
							{ text: 'Date', datafield: 'date', width: '14%', cellsformat: 'dd.MM.yyyy' },
							{ text: 'Time', datafield: 'time', width: '14%' },
							{ text: 'Doc No',  datafield: 'doc_no', width: '10%'   },
							{ text: 'Type',  datafield: 'type', width: '10%' },
							{ text: 'Agreement Type',  datafield: 'reftype', width: '10%'},
							{ text: 'Agreement No',  datafield: 'refdocno', width: '10%'},
							{ text: 'Fleet',  datafield: 'rfleet', width: '12%'  },
							{ text: 'User', datafield:'user', width:'20%'},
							
				 ]
            });
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#inspchklist").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#inspchklist").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       
                   }
                   else {
                       var url=document.URL;
              
                        	 var reurl=url.split("com/");
                        	 //var branch=document.getElementById("brchName").value; 
                        	 var doc=$('#inspchklist').jqxGrid('getcellvalue',rowindex,'doc_no');
                        	 var type=$('#inspchklist').jqxGrid('getcellvalue',rowindex,'reftype');
                        	 var refno=$('#inspchklist').jqxGrid('getcellvalue',rowindex,'refdocno');
                        	 var printdocno="";
                        	 var win= window.open(reurl[0]+"com/operations/vehicletransactions/vehicleinspection/inspectionMobilePrint.action?insp="+doc+"&agmtno="+refno+"&agmtype="+type+"&lblurl="+window.location.origin,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
                           win.focus();	 
                      
                   }
               });
               $("#inspchklist").on('rowclick', function (event) {
                   if (event.args.rightclick) {
                       $("#inspchklist").jqxGrid('selectrow', event.args.rowindex);
                       var rowindex=event.args.rowindex;
                       document.getElementById("printinvno").value=$('#inspchklist').jqxGrid('getcellvalue',rowindex,'transno');
                       document.getElementById("printdoctype").value=$('#inspchklist').jqxGrid('getcellvalue',rowindex,'transtype');
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
               });

       /*      
            var debit1="";var credit1="";var netamount="";
            var debit=$('#inspchklist').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
            debit1=debit.sum;
            var credit=$('#inspchklist').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
            credit1=credit.sum; */
           
        });

</script>
<div id='jqxWidget'>
    <div id="inspchklist"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Print</li>
        </ul>
       </div>
       </div>
       </div>


<input type="hidden" name="printinvo" id="printinvno">
<input type="hidden" name="printdoctype" id="printdoctype">