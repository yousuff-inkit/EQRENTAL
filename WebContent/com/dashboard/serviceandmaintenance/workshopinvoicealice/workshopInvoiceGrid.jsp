<%@page import="com.dashboard.serviceandmaintenance.workshopinvoicealice.ClsWorkshopInvoiceAlice"%>
<%
ClsWorkshopInvoiceAlice DAO= new ClsWorkshopInvoiceAlice();
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
String contextPath=request.getContextPath();
%>

<script type="text/javascript">
      var invdata;
      var invexceldata;
      var id = '<%= id%>';
      if(id=='1'){ 
	  		invdata='<%=DAO.wsinvGridLoad(fromdate,todate,id)%>';
	  		invexceldata='<%=DAO.wsinvExcelLoad(fromdate,todate,id)%>';
	  	}
        $(document).ready(function () {
        	
        	var rendererstring1=function (aggregates){
       		 
             	 return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> Total </div>';
        	}
        	 var rendererstring=function (aggregates){
        		 var value=aggregates['sum'];
              	 if(typeof(value) == "undefined"){
              		 value=0.00;
              	 }
              	 return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
        	 }
        	 
        	var source =
            {
                datatype: "json",
                datafields: [
                           
							{name : 'invno' , type: 'string' },
							{name : 'invdate' , type: 'date' },
							{name : 'jobcardno' , type:'string'},
							{name : 'regno' , type:'string'},
							{name : 'make' , type:'string'},
							{name : 'totalinv' , type:'number'},
							{name : 'sparetot' , type:'number'},
							{name : 'labourtot' , type:'number'},
							{name : 'refno' , type:'string'},
							{name : 'fleet' , type:'string'},
							{name : 'pltid' , type:'string'},
							{name : 'acno' , type:'string'},
							{name : 'acnolab' , type:'string'},
							{name : 'acnosp' , type:'string'},
							{name : 'insurcldocno' , type:'string'},
							{name : 'invoicetoacno' , type:'string'}
					      ],
                          localdata: invdata,
               
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
            $("#workshopInvGrid").jqxGrid(
            {
                width: '99%',
                height: 550,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize:true,
                theme: 'energyblue',
                showaggregates:true,
                showstatusbar: true,
                showfilterrow: true,
                columns: [
						{ text: 'SL#', sortable: false, filterable: false, editable: false,draggable: false, 
							resizable: false,datafield: 'sl', columntype: 'number', width: '4%',
							cellsrenderer: function (row, column, value) {
								return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							}  
						},
						{ text: 'Inv No',  datafield: 'invno',  width: '7%' },
						{ text: 'Inv Date', datafield: 'invdate', width: '7%',cellsformat:'dd.MM.yyyy' },
						{ text: 'Jobcard No',  datafield: 'jobcardno',  width: '7%' },
						{ text: 'Reg No.',  datafield: 'regno',  width: '9%' },
						{ text: 'Make',  datafield: 'make',   width: '21%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1  },
						
						{ text: 'Total Invoice', datafield:'totalinv', width:'12%',cellsformat: 'd2', align: 'right', cellsalign: 'right',
							aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Spare Total', datafield:'sparetot', width:'12%',cellsformat: 'd2', align: 'right', cellsalign: 'right',
								aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Labour Total', datafield:'labourtot', width:'12%',cellsformat: 'd2', align: 'right', cellsalign: 'right',
									aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Reference No.', datafield:'refno', width:'9%' },
						
						{ text: 'plate', datafield:'pltid',hidden:true, width:'5%' },
						{ text: 'Fleet No', datafield:'fleet',hidden: true, width:'5%' },
						{ text: 'acno', datafield:'acno',hidden:true, width:'5%' },
						{ text: 'acnosp', datafield:'acnosp',hidden:true, width:'5%' },
						{ text: 'acnolab', datafield:'acnolab',hidden:true, width:'5%' },
						{ text: 'insurcldocno', datafield:'insurcldocno',hidden:false, width:'5%' },
						{ text: 'invoicetoacno', datafield:'invoicetoacno',hidden:true, width:'5%' }
						
						]
            });
            
            $("#overlay, #PleaseWait").hide();
            $('#workshopInvGrid').on('rowdoubleclick', function (event){ 
        	  	var rowindex1=event.args.rowindex;
        	  	document.getElementById("hidinvno").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "invno");
        	  	// alert($("#workshopInvGrid").jqxGrid('getcelltext', rowindex1, "invdate"));
        	  	$('#hidinvdate').jqxDateTimeInput('val',$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "invdate"));
        	  	document.getElementById("hidjobcardno").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "jobcardno");
        	  	document.getElementById("hidregno").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "regno");
        	  	document.getElementById("hidmake").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "make");
        	  	document.getElementById("hidtotalinv").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "totalinv");
        	  	document.getElementById("hidsparetot").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "sparetot");
        	  	document.getElementById("hidlabourtot").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "labourtot");
        	  	document.getElementById("hidrefno").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "refno");
        	  	
        	  	document.getElementById("hidplate").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "pltid");
        	  	document.getElementById("hidfleetno").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "fleet");
        	  	document.getElementById("hidacno").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "acno");
        	  	document.getElementById("hidacnosp").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "acnosp");
        	  	document.getElementById("hidacnolab").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "acnolab");
        	  	document.getElementById("hidinsurcldocno").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "insurcldocno");
        	  	document.getElementById("hidinvoicetoacno").value=$("#workshopInvGrid").jqxGrid('getcellvalue', rowindex1, "invoicetoacno");
        	  	
        	  	$('#nipurinsertbtn').attr('disabled', false);
             });	
            

        });

</script>
<div id="workshopInvGrid"></div>
