<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.rentalquote.*" %>
<%

String grpid= request.getParameter("grpid")==null?"0":request.getParameter("grpid").trim();
String cldocno= request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
String branch= request.getParameter("branch")==null?"0":request.getParameter("branch").trim();
String id= request.getParameter("id")==null?"0":request.getParameter("id").trim();
String rentaltype= request.getParameter("rentaltype")==null?"":request.getParameter("rentaltype").trim();

ClsRentalQuoteDAO viewDAO= new ClsRentalQuoteDAO();
%>
<script type="text/javascript">
    
 var tarifdata=[];
 var id='<%=id%>';
 if(id=="1"){
 	tarifdata='<%=viewDAO.getTariffData(session,branch, grpid, cldocno, id,rentaltype)%>';	
 }
  
       // alert(data);
        $(document).ready(function () { 	
        	
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
                            {name : 'doc_no', type: 'string'  },
     						{name : 'validto', type: 'string'    },
     						{name : 'tariftype', type: 'string'    },
     						{name : 'rate', type: 'number'    },
     					   	{name : 'insurexcess', type: 'number'  },                     
    						{name : 'cdwexcess', type: 'number'    },
    						{name : 'scdwexcess', type: 'number'    },
    						{name : 'maxdiscount', type: 'number'    },
                 ],               
                localdata: tarifdata,
             
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

            
            
            $("#jqxbtntarif").jqxGrid(
            {
                width: '100%',
                height: 277,
                source: dataAdapter,
                columnsresize: true,
          
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
               // sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
            /*     handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxgrid2').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'NAME' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxgrid2").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                 */
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                           
                          
               		
                          
                          
							{ text: 'Doc no', datafield: 'doc_no', width: '10%' },
							{ text: 'Name', datafield: 'tariftype', width: '60%' },
							{ text: 'Valid TO', datafield: 'validto', width: '15%' },
							{ text: 'Rate', datafield: 'rate', width: '15%',cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'insurexcess', datafield: 'insurexcess', width: '10%',cellsformat:'d2',hidden:true },
							{ text: 'cdwexcess', datafield: 'cdwexcess', width: '10%',cellsformat:'d2',hidden:true  },
							{ text: 'scdwexcess TO', datafield: 'scdwexcess', width: '10%' ,cellsformat:'d2',hidden:true },
							{ text: 'maxdiscount', datafield: 'maxdiscount', width: '10%' ,cellsformat:'d2',hidden:true },
						
	              ]
            });
            $('#jqxbtntarif').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex=event.args.rowindex;
				var gridindex=$('#gridindex').val();
				$('#rentalContractGrid').jqxGrid('setcellvalue',gridindex,'maxdiscount',$('#jqxbtntarif').jqxGrid('getcellvalue',rowindex,'maxdiscount'));
				$('#rentalContractGrid').jqxGrid('setcellvalue',gridindex,'rate',$('#jqxbtntarif').jqxGrid('getcellvalue',rowindex,'rate'));
				$('#rentalContractGrid').jqxGrid('setcellvalue',gridindex,'tarifdocno',$('#jqxbtntarif').jqxGrid('getcellvalue',rowindex,'doc_no'));
				$('#tariffwindow').jqxWindow('close');
            });
         
        });
    </script>
    <div id="jqxbtntarif"></div>
<!--  <input type="hidden" id="rowindex"/>  -->