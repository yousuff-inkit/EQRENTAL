<%@page import="com.dashboard.operations.agmtpaymentupdate.*"%>
<%ClsAgmtPaymentupdateDAO updatedao=new ClsAgmtPaymentupdateDAO();%>
<%
String agmttype=request.getParameter("agmttype")==null?"":request.getParameter("agmttype");
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
%>
 <script type="text/javascript">
 var id='<%=id%>';
 var data;
 if(id=='1'){
	 data='<%=updatedao.getAgmtData(fromdate,todate,agmttype,agmtno,branch,id)%>';
 }
 $(document).ready(function () { 	
    
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'cldocno', type: 'int' },
     						{name : 'refname', type: 'string'    },
     						{name : 'agmtno',type: 'string'},
     						{name : 'agmtvocno',type:'string'},
     						{name : 'amount',type:'number'},
     						{name : 'date', type: 'date'   },
     						{name : 'fleet_no',type:'string'},
     						{name : 'flname',type:'number'},
     						{name : 'reg_no',type:'number'}
     						
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#agmtGrid").on("bindingcomplete", function (event) {
            	$("#overlay, #PleaseWait").hide();
            	
            });  
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#agmtGrid").jqxGrid(
            {
                width: '98%',
                height: 250,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                editable: true,
                
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
							{ text: 'Agmt Original No',datafield:'agmtno',width:'6%',hidden:true,editable:false},
							{ text: 'Agmt No', datafield: 'agmtvocno', width: '6%' ,editable:false},
							{ text: 'Date', datafield: 'date', width: '10%' ,cellsformat:'dd.MM.yyyy',editable:false},
							{ text: 'Client #',datafield:'cldocno',width:'10%',editable:false},
							{ text: 'Client Name', datafield: 'refname', width: '20%' ,editable:false},
							{ text: 'Fleet No',datafield:'fleet_no',width:'10%',cellsformat:'dd.MM.yyyy',editable:false},
							{ text: 'Reg No',datafield:'reg_no',width:'10%',editable:false},
							{ text: 'Fleet Name',datafield:'flname',width:'20%',editable:false},
							{ text: 'Amount',datafield:'amount',width:'10%',cellsformat:'d2',align:'right',cellsalign:'right',editable:false},
	              ]
            });
            $('#agmtGrid').on('rowdoubleclick', function (event) 
            		{ 
            		    var args = event.args;
            		    // row's bound index.
            		    var boundIndex = args.rowindex;
            		    // row's visible index.
            		    var visibleIndex = args.visibleindex;
            		    // right click.
            		    var rightclick = args.rightclick; 
            		    // original event.
            		    var ev = args.originalEvent;
            		    $('#selectedagmtno,#selectedtotal,#deletedrows').val('');
            		    var agmtno=$('#agmtGrid').jqxGrid('getcellvalue',boundIndex,'agmtno');
            		    var amount=$('#agmtGrid').jqxGrid('getcellvalue',boundIndex,'amount');
            		    $('#selectedagmtno').val(agmtno);
            		    $('#selectedtotal').val(amount);
            		    $('#agmtpaymentdiv').load('agmtPaymentGrid.jsp?agmtno='+agmtno+'&amount='+amount+'&id=1');
            		});
 });

    </script>
    <div id="agmtGrid"></div>
    