<%@ page import="com.dashboard.travel.tourvendorupdate.ClsTourVendorUpdateDAO" %>  
<% ClsTourVendorUpdateDAO sd=new ClsTourVendorUpdateDAO(); %>   
<%@page import="javax.servlet.http.HttpServletRequest" %>   
<%@page import="javax.servlet.http.HttpSession" %>           
 <%       
    String id=request.getParameter("id")==null?"0":request.getParameter("id").toString();
 %>                        
<script type="text/javascript">          
var pdata;         
 pdata='<%=sd.detailGrid(id) %>';
 
 var rendererstring=function (aggregates){  
 	var value=aggregates['sum'];  
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 }
$(document).ready(function(){  
        var source =
        {     
            datatype: "json",           
            datafields: [
                        {name : 'vndid',type:'string'},    
                        {name : 'rdocno',type:'string'},      
                        {name : 'doc_no',type:'string'},   
                        {name : 'rowno',type:'string'},      
						{name : 'mobile',type:'string'},             
						{name : 'email',type:'string'},     
						{name : 'refname',type:'string'}, 
                        {name : 'distype',type:'string'},  
                      	{name : 'adultdis', type: 'number'},   
                     	{name : 'childdis', type: 'number'},      
                     	{name : 'time',type:'string'},
                    	{name : 'stdtotal', type: 'number'},
                     	{name : 'total', type: 'number'},
						{name : 'spadult', type: 'number'},
						{name : 'spchild', type: 'number'},     
						{name : 'infant', type: 'number'},     
                        {name : 'adult', type: 'number'},      
                        {name : 'child', type: 'number'}, 
                        {name : 'adultval', type: 'number'},  
                        {name : 'childval', type: 'number'},  
                      	{name : 'tourname', type: 'string'},  
                      	{name : 'remarks', type: 'string'},    
                      	{name : 'date',type:'date'},   
    					{ name: 'tvltotal',type: 'number'},    
    					],
             localdata: pdata,
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

        $("#tourGrid").jqxGrid(                
                {
                	width: '100%',
                    height: 560,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,   
                    selectionmode: 'singlerow',                
                    altrows:true,
                    showaggregates: true,  
                 	showstatusbar:true,
                    columnsresize: true,
                    enabletooltips:true,      
                    editable:false,    
                    //Add row method 
                    columns: [     
                             
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '5%',editable:false,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						{ text: 'Rowno',datafield: 'rowno', width: '22%',editable:false,hidden:true},
						{ text: 'rdocno',datafield: 'rdocno', width: '22%',editable:false,hidden:true},   
						{ text: 'vndid',datafield: 'vndid', width: '22%',editable:false,hidden:true},   
						{ text: 'Doc No',datafield: 'doc_no', width: '6%',editable:false},            
						{ text: 'Client',datafield: 'refname', width: '22%',editable:false},
						{ text: 'Mobile',datafield: 'mobile', width: '8%',editable:false},   
						{ text: 'Email',datafield: 'email', width: '12%',editable:false},
    					{ text: 'Tour name',datafield: 'tourname', width: '20%',editable:false},             
    					{ text: 'Date',datafield: 'date',cellsformat:'dd.MM.yyyy', width: '6%',editable:false},
						{ text: 'Time',datafield: 'time',cellsformat:'HH:mm:ss', width: '4%',editable:false}, 
    					{ text: 'Vendor',datafield: 'vendor', width: '20%',editable:false},                            
    					{ text: 'Infant',datafield: 'infant', width: '5%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Adult',datafield: 'adult', width: '5%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'SP Adult',datafield: 'spadult', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Std.Price',datafield: 'adultval',cellsformat: 'd2',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},   
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
    					{ text: 'Discount(Adult)',datafield: 'adultdis', width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Child',datafield: 'child', width: '5%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'SP Child',datafield: 'spchild', width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Std.Price',datafield: 'childval',cellsformat: 'd2',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
    					{ text: 'Discount(Child)',datafield: 'childdis', width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Total',datafield: 'total',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'STD Total',datafield: 'stdtotal',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
    					{ text: 'Remarks',datafield: 'remarks', width: '18%',editable:false},
       					{ text: 'Travel Total',datafield: 'tvltotal',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
                   ]    
                });      
        $("#overlay, #PleaseWait").hide();  
        $('#tourGrid').on('rowdoubleclick', function (event) {                     
           var rowindex2 = event.args.rowindex; 
           document.getElementById("vndid").value=$('#tourGrid').jqxGrid('getcellvalue', rowindex2, "vndid");
           document.getElementById("rdocno").value=$('#tourGrid').jqxGrid('getcellvalue', rowindex2, "rdocno");
           document.getElementById("tourrow").value=$('#tourGrid').jqxGrid('getcellvalue', rowindex2, "rowno");
           document.getElementById("child").value=$('#tourGrid').jqxGrid('getcellvalue', rowindex2, "child");
           document.getElementById("adult").value=$('#tourGrid').jqxGrid('getcellvalue', rowindex2, "adult");
       });   
	});
</script>
<div id="tourGrid"></div>