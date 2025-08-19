<%@ page import="com.dashboard.travel.visapricemanagement.ClsVisaPriceManagementDAO" %>  
<%ClsVisaPriceManagementDAO DAO=new ClsVisaPriceManagementDAO(); %> 
 <%
   String id = request.getParameter("id")==null?"0":request.getParameter("id");
 %>
 <script type="text/javascript">
 var data; 
	  data='<%=DAO.pricegriddata(id)%>';   
	  $(document).ready(function () {    
            var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'cldocno', type: 'String'  },
                 			{name : 'acno', type: 'String'  },
     						{name : 'refname', type: 'String'},
     						{name : 'acgrp', type: 'String'  },
     						{name : 'cperson', type: 'String'  },
     						{name : 'mob', type: 'String'  },
     						{name : 'email', type: 'String'  },
     						{name : 'trnno', type: 'String'  },
     						{name : 'taxtype', type: 'String'  },
                          	],
                          	localdata: data,  
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
            $("#jqxpricegrid").jqxGrid(
            { 
            	width: '100%',
                height: 250,  
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                showfilterrow: true,
                sortable:true,
                selectionmode: 'singlerow',
                enabletooltips: true,
                pagermode: 'default',
                editable:false,
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
                             
                            { text: 'Vendor ID', datafield: 'cldocno', width: '5%'},   
							{ text: 'Acno', datafield: 'acno', width: '4%' },
							{ text: 'Name', datafield: 'refname'},  
							{ text: 'Account Group', datafield: 'acgrp', width: '15%' },    
							{ text: 'TRN No.', datafield: 'trnno', width: '7%' },
							{ text: 'Contact Person', datafield: 'cperson', width: '15%' },
							{ text: 'Mobile', datafield: 'mob', width: '12%' },
							{ text: 'Email', datafield: 'email', width: '12%'},       
							{ text: 'Tax Type', datafield: 'taxtype', width: '12%',hidden:true},   
					]   
            });
            $('#jqxpricegrid').on('rowdoubleclick', function (event) {     
  		        var datafield = event.args.datafield; 
  		        var rowindextemp = event.args.rowindex;
  		        var docno=$('#jqxpricegrid').jqxGrid('getcellvalue',rowindextemp, "cldocno");
  		        document.getElementById("cmbtaxtype").value=$('#jqxpricegrid').jqxGrid('getcellvalue',rowindextemp, "taxtype");
              	document.getElementById("docno").value=$('#jqxpricegrid').jqxGrid('getcellvalue',rowindextemp, "cldocno");
              	document.getElementById("refname").value=$('#jqxpricegrid').jqxGrid('getcellvalue',rowindextemp, "refname");
              	$("#btnupdate").attr('disabled',false);
            	$('#btnupdate').val("Edit"); 
        		$("#jqxvisagrid").jqxGrid({ disabled: true});      
              	$("#visadiv").load("visagrid.jsp?docno="+docno+"&id=1");    
            }); 
        });
    </script>
    <div id="jqxpricegrid"></div> 