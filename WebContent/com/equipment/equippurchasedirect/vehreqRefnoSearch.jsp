<%@page import="com.equipment.equippurchasedirect.ClsEquipPurchaseDirectDAO" %>
<%ClsEquipPurchaseDirectDAO vpd=new ClsEquipPurchaseDirectDAO(); %>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%-- <%

String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");



%>
 --%>
<script type="text/javascript"> 

var vahReqmaster= '<%=vpd.reqSearchMasters(session) %>';   
            	
        $(document).ready(function () { 	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'voc_no', type: 'int'},  
     		 				 {name : 'doc_no', type: 'int'},
     						 {name : 'date', type: 'date'  },
     						 {name : 'expdeldt', type: 'date'   },
     						 {name : 'desc1', type: 'string'  },
     						 {name : 'acdocno', type: 'int'   },
     						 {name : 'account', type: 'string'   },
     						 {name : 'description', type: 'string'   },
     						 {name : 'curid', type: 'int'  },
     						 {name : 'currency', type: 'string'  },
     						 {name : 'rate', type: 'number'  },
     						 {name : 'tax', type: 'String'  },
     						 {name : 'actype', type: 'String'  }
                 ],
                 localdata: vahReqmaster,
                
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

            
            
            $("#vehreqMastersearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                columns: [
                            { text: 'masterDoc NO', datafield: 'doc_no', width: '10%' ,hidden:true},	
							{ text: 'Doc NO', datafield: 'voc_no', width: '10%' },	
							{ text: 'Date', datafield: 'date', width: '15%' ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Description', datafield: 'desc1' },	
							{ text: 'expdeldt', datafield:'expdeldt', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true},
							{ text: 'acdocno', datafield: 'acdocno', width: '5%', hidden : true },
							{ text: 'Account', datafield: 'account', width: '20%', hidden : true },
							{ text: 'Account Name', datafield: 'description', width: '55%', hidden : true },
							{ text: 'Currency Id', datafield: 'curid', width: '5%', hidden : true},
							{ text: 'Currency', datafield: 'currency', width: '15%', hidden : true },
							{ text: 'Rate', hidden : true, datafield: 'rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%'  },
							{ text: 'tax', hidden: true, datafield: 'tax', width: '0%'},
							{ text: 'actype', hidden: true, datafield: 'actype', width: '0%'},     
							]
               
            });
            
            $('#vehreqMastersearch').on('rowdoubleclick', function (event) {
                var rowindex2 = event.args.rowindex;
                document.getElementById("headacccode").value = $('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "acdocno"); 
                document.getElementById("accid").value = $('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "account");
            	document.getElementById("vehpuraccname").value = $('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "description");
        		document.getElementById("epocmbcurr").value = $('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "curid");
            	funRoundRate($('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "rate"),"epocurrate");

            	console.log($('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "tax")+"=="+$('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "actype"));
        	    
            	var tax = $('#txttaxpercentage').val();
            	if(($('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "tax")=="0") || 
       	    		($('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "actype")=="3")){
        	    				$('#txttaxpercentage').val("0");
        	    }
        	    else{
        	    	$('#txttaxpercentage').val(tax);
        	    }
            	
                var indexval3=$('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                document.getElementById("masterrefno").value=indexval3;
            	document.getElementById("refno").value=$('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "voc_no"); 
            	$("#vehpuchase").load("vehpurchaseDetails.jsp?refdoc="+indexval3+"&taxperc="+$('#txttaxpercentage').val());      
                //$("#vehoredergrid").jqxGrid({ disabled: false});
                $('#refnosearchwindow').jqxWindow('close');   
            }); 
        });
    </script>
    <div id=vehreqMastersearch></div>
