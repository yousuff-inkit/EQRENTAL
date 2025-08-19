<%@page import="com.dashboard.travel.insurancevendorpayment.ClsInsuranceVendorPaymentDAO" %>
<%
	ClsInsuranceVendorPaymentDAO DAO=new ClsInsuranceVendorPaymentDAO();
%>       
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String atype = request.getParameter("atype"); 
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String salesperson = request.getParameter("salesperson")==null?"0":request.getParameter("salesperson").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 
     
<style type="text/css">   
  .advanceClass
  {
      background-color: #FBEFF5;  
  }  
  .balanceClass
  {
      background-color: #E0F8F1;
  }
  .unappliedClass
  {
     color: #FF0000;
  }
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){    
	  		   data='<%=DAO.insvndpayGrid(branchval, upToDate, atype, accdocno, salesperson, check)%>';
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
                            {name : 'tranid', type: 'string'},        
							{name : 'date', type: 'date' },
							{name : 'transno', type: 'int' },
							{name : 'transtype', type: 'string'   },
							{name : 'description', type: 'string' },
							{name : 'vndamt' , type:'number'},
							{name : 'vndrvd' , type:'number'},
							{name : 'vndbl',type:'number'},
							{name : 'profit' , type:'number'},
							{name : 'netpur' , type:'number'},
							{name : 'netsales',type:'number'},
							{name : 'profitper',type:'number'},
							{name : 'client' , type:'String'},
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {  
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#insvndpayGridID").jqxGrid(
            {
                width: '98%',
                height: 490,
                source: dataAdapter,
                rowsheight:25,
                showfilterrow:true,      
                filterable: true,
                sortable: true,
                columnsresize: true,
                enabletooltips: true,      
                selectionmode: 'checkbox',     
                editable: false,
                showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
                
                columns: [
						   { text: 'Sr. No', sortable: false, filterable: false, editable: false,
						       groupable: false, draggable: false, resizable: false,datafield: '',
						       columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
						       cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						     }    
							},
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , editable: false, width: '6%' },
							{ text: 'Type', datafield: 'transtype', editable: false, width: '5%' },	
							{ text: 'Doc No.', datafield: 'transno', editable: false, width: '6%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1  },
							{ text: 'TranId', datafield: 'tranid', editable: false, width: '6%',hidden:true },   
							{ text: 'Account Name', datafield: 'name', width: '19%' ,hidden:true},                    
							{ text: 'Vendor Amount',  datafield: 'vndamt',  width: '7.5%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Vendor Received',  datafield: 'vndrvd',  width: '7.7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Vendor Balance',  datafield: 'vndbl',  width: '7.5%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Client',  datafield: 'client',  width: '12%' },	
							{ text: 'Description',  datafield: 'description',  width: '13%'},
							{ text: 'Net Sales',  datafield: 'netsales',  width: '7.5%'  ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Net Purchase',  datafield: 'netpur',  width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Profit',  datafield: 'profit',  width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Profit %',  datafield: 'profitper',  width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right' },
						 ]              
            });  
              
            if(temp=='NA'){
                $("#insvndpayGridID").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();  
        });

</script>
<div id="insvndpayGridID"></div>
