 <%@page import="com.dashboard.travel.tourdiscountpaybackapproval.ClsTourDiscountPaybackApprovalDAO"%>
                                       
 <%  ClsTourDiscountPaybackApprovalDAO sd=new ClsTourDiscountPaybackApprovalDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>                   
<%@page import="javax.servlet.http.HttpSession" %>   
 <%       
    String locid=request.getParameter("locid")==null?"0":request.getParameter("locid").toString();
    String check=request.getParameter("check")==null?"0":request.getParameter("check").toString();
 	String todate=request.getParameter("todate")==null?"":request.getParameter("todate").toString();
 	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
 %>      
<script type="text/javascript">          
var unddata;
var dataexcel;
var flchk='<%=check%>';   
       
	if(flchk!='0'){ 
		   unddata='<%=sd.detailGrid(session,check,todate,brhid,locid) %>';                    
		   dataexcel='<%=sd.detailExGrid(session,check,todate,brhid,locid) %>';      
	}      
	else{   
		
	}
	 var rendererstring=function (aggregates){
	    	var value=aggregates['sum'];
	    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	    }
$(document).ready(function(){           
    
    var source =
    {             
            datatype: "json",
            datafields: [ 
                         {name : 'doc_no',type:'string'},
                         {name : 'distype',type:'string'},
                       	{name : 'adultdis', type: 'number'},   
                      	{name : 'childdis', type: 'number'},      
                      	{name : 'time',type:'string'},
                      	{name : 'total', type: 'number'},
 						{name : 'spadult', type: 'number'},
 						{name : 'spchild', type: 'number'},         
                         {name : 'adult', type: 'number'},      
                         {name : 'child', type: 'number'}, 
                         {name : 'adultval', type: 'number'},  
                         {name : 'childval', type: 'number'},  
                       	{name : 'tourname', type: 'string'},  
                       	{name : 'tourid', type: 'string'},
                       	{name : 'remarks', type: 'string'},    
                       	{name : 'date',type:'String'}, 
                     	{name : 'vndid', type: 'string'},
                       	{name : 'vendor', type: 'string'},  
                        {name : 'rowno', type: 'string'},  	
             ],                  
             localdata: unddata,    
              
            
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
        $("#TravelGrid").jqxGrid(
                {
                	width: '100%',
                    height: 500,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    enabletooltips: true,
                    selectionmode: 'singlerow',
                  	editable:false,   
                    altrows:true,
                    sortable: true,  
                    columnsresize: true,  
                    //Add row method
                    columns: [  
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '5%',editable:false,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   }, 
						{ text: 'Doc NO',datafield: 'doc_no',editable:false, width: '7%'},
						{ text: 'Tour name',datafield: 'tourname', width: '22%',editable:false},             
						{ text: 'Tour id',datafield: 'tourid',hidden:true,editable:false},      
						{ text: 'Date',datafield: 'date',cellsformat:'dd.MM.yyyy', width: '5%',editable:false},
						{ text: 'Time',datafield: 'time',cellsformat:'HH:mm:ss', width: '5%',editable:false}, 
						{ text: 'rowno',datafield: 'rowno',hidden:true,editable:false},   
						{ text: 'Vendor',datafield: 'vendor', width: '20%',editable:false},                         
						{ text: 'vnd id',datafield: 'vndid',hidden:true,editable:false},   
						{ text: 'Adult',datafield: 'adult', width: '4%',cellsformat: 'd2',cellsalign:'right',align:'right',editable:false},
						{ text: 'SP Adult',datafield: 'spadult', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right',editable:false},
						{ text: 'Std.Price',datafield: 'adultval',hidden:true,cellsformat: 'd2',cellsalign:'right',align:'right',editable:false},   
						{ text: 'Type',datafield: 'distype', width: '7%',editable:true,columntype:'dropdownlist',
							createeditor: function (row, column, editor) {
						    billlist = ["DISCOUNT",  "PAY BACK"];      
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billlist });
							},
							 initeditor: function (row, cellvalue, editor) {
							var terms = $('#tourGrid').jqxGrid('getcellvalue', row, "distype");
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billlist });   
						 },  
						},     
						{ text: 'Discount(Adult)',datafield: 'adultdis', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right'},
						{ text: 'Child',datafield: 'child', width: '4%',cellsformat: 'd2',cellsalign:'right',align:'right',editable:false},
						{ text: 'SP Child',datafield: 'spchild', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right',editable:false},
						{ text: 'Std.Price',datafield: 'childval',hidden:true,cellsformat: 'd2',cellsalign:'right',align:'right',editable:false},
						{ text: 'Discount(Child)',datafield: 'childdis', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right'},
						{ text: 'Total',datafield: 'total',cellsformat: 'd2',width: '7%',cellsalign:'right',align:'right',editable:false},
						{ text: 'Remarks',datafield: 'remarks', width: '14%',editable:false},                            
					]                                                           
                });    
                   $("#overlay, #PleaseWait").hide();       
                   $('#TravelGrid').on('rowdoubleclick', function (event) {       
                   var rowindex2 = event.args.rowindex; 
                   $('.textpanel p').text('Doc No '+$('#TravelGrid').jqxGrid('getcellvalue',rowindex2,'doc_no')+' - '+$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "tourname"));
                   document.getElementById('hidrowno').value=$('#TravelGrid').jqxGrid('getcellvalue',rowindex2,'rowno');
                   });     
	});      
</script>
<div id="TravelGrid"></div>