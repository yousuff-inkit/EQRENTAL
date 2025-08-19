<%@page import="com.operations.commtransactions.refundrequest.ClsRefundRequestDAO"%>
<% ClsRefundRequestDAO DAO= new ClsRefundRequestDAO(); %>  
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>           
 <%
	 String rrdocno=request.getParameter("rrdocno")==null || request.getParameter("rrdocno")==""?"0":request.getParameter("rrdocno").toString();
	 String refund=request.getParameter("refund")==null || request.getParameter("refund")==""?"0":request.getParameter("refund").toString();
     String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
     String check = request.getParameter("check")==null?"0":request.getParameter("check");
 %> 
  <style type="text/css">  
  .AClass
  {
      background-color: #FBEFF5;
  }
  .BClass
  {  
      background-color: #E0F8F1;
  }
  .CClass
  {
     background-color: #f3fab9;    
  }
    .DClass
  {
     background-color: #b3ffff ;  
  }
</style>                       
<script type="text/javascript">          
 var pdata;                                           
  pdata='<%=DAO.tourGrid(rdocno,check,refund,rrdocno) %>';         
      
  var rendererstring=function (aggregates){  
	 	var value=aggregates['sum'];
	 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	 }
$(document).ready(function(){  
        var source =
        {
            datatype: "json",           
            datafields: [
                        {name : 'adultdis', type: 'number'},              
                        {name : 'childdis', type: 'number'},   
                     	{name : 'distype',type:'string'},  
                        {name : 'spadult', type: 'number'},      
                        {name : 'spchild', type: 'number'},
						{name : 'totalnew', type: 'number'},         
                        {name : 'adultnew', type: 'number'},      
                        {name : 'childnew', type: 'number'},   
                     	{name : 'time',type:'string'},
                     	{name : 'total', type: 'number'},
                        {name : 'adult', type: 'number'},      
                        {name : 'child', type: 'number'}, 
                      	{name : 'tourname', type: 'string'},  
                      	{name : 'tourid', type: 'string'},
                      	{name : 'remarks', type: 'string'},    
                      	{name : 'date',type:'String'}, 
                    	{name : 'vndid', type: 'string'},
                      	{name : 'vendor', type: 'string'},
                      	{name : 'chk', type: 'bool'},  
                      	{name : 'rowno', type: 'string'},
                      	{name : 'refund', type: 'string'},
             ],
             localdata: pdata,
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        var cellclassname = function (row, column, value, data) {  
               return "DClass";
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
                    height: 400,
                    source: dataAdapter,   
                    showfilterrow: true,
                    filterable: true,
                    enabletooltips: true,
                    selectionmode: 'singlecell',               
                    altrows:true,
                    columnsresize: true,
                    editable: true,    
                    columns: [       
                        { text: '',datafield: 'chk',columntype:'checkbox',editable: true},       
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '5%',editable:false,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Tour name',datafield: 'tourname',editable:false, width: '25%'},             
    					{ text: 'refund',datafield: 'refund',hidden:true}, 
    					{ text: 'Tour id',datafield: 'tourid',hidden:true}, 
       					//{ text: 'Date',datafield: 'date',cellsformat:'dd.MM.yyyy', width: '5%'},
						//{ text: 'Time',datafield: 'time',cellsformat:'HH:mm:ss', width: '5%'}, 
    					{ text: 'Vendor',datafield: 'vendor', width: '24%',editable:false},                            
    					{ text: 'vnd id',datafield: 'vndid',hidden:true},   
    					{ text: 'Discount Type',hidden:true,datafield: 'distype', width: '8%',editable:false},     
    					{ text: 'Adult',datafield: 'adult', width: '4%',editable:false,cellsalign:'right',align:'right'},
    					{ text: 'SP Adult',datafield: 'spadult', width: '7%',editable:false,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Adult Discount',hidden:true,datafield: 'adultdis', width: '7%',editable:false,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Child',datafield: 'child', width: '4%',editable:false,cellsalign:'right',align:'right'},
						{ text: 'SP Child',datafield: 'spchild', width: '7%',editable:false,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Child Discount',hidden:true,datafield: 'childdis', width: '7%',editable:false,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Total',datafield: 'total',cellsformat: 'd2',editable:false,width: '7%',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Adult',datafield: 'adultnew', width: '4%',cellsalign:'right',align:'right',cellclassname:cellclassname},
    					{ text: 'Child',datafield: 'childnew', width: '4%',cellsalign:'right',align:'right',cellclassname:cellclassname},  
    					{ text: 'Total SP',datafield: 'totalnew',cellsformat: 'd2',editable:false,width: '7%',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname},
    					//{ text: 'Remarks',datafield: 'remarks'},   
    					{ text: 'rowno',datafield: 'rowno', width: '7%',cellclassname:cellclassname,hidden:true},                                           
    	              ]                                                 
                });
                $('#tourGrid').on('cellvaluechanged', function (event) {                                                                  
				         var datafield = event.args.datafield;
				         var rowindextemp = event.args.rowindex;
				     	 var distype=$('#tourGrid').jqxGrid('getcellvalue', rowindextemp, "distype");  
				     	 var childnew=$('#tourGrid').jqxGrid('getcellvalue', rowindextemp, "childnew");  
				     	 var adultnew=$('#tourGrid').jqxGrid('getcellvalue', rowindextemp, "adultnew");
				     	 var spchild=$('#tourGrid').jqxGrid('getcellvalue', rowindextemp, "spchild");            
				     	 var spadult=$('#tourGrid').jqxGrid('getcellvalue', rowindextemp, "spadult");
				     	 var total=0.0;
				       	 if(datafield=="childnew" || datafield=="adultnew"){
				       	    if((typeof(childnew) != "undefined" && typeof(childnew) != "NaN" && childnew != ""  && childnew != "0" && childnew!='0.00') && (typeof(adultnew) != "undefined" && typeof(adultnew) != "NaN" && adultnew != ""  && adultnew != "0" && adultnew!='0.00')){        
				       	       total=(parseFloat(spadult)*parseFloat(adultnew))+(parseFloat(spchild)*parseFloat(childnew));   
				       	    }else if((typeof(childnew) != "undefined" && typeof(childnew) != "NaN" && childnew != ""  && childnew != "0" && childnew!='0.00') && (typeof(adultnew) == "undefined" || typeof(adultnew) == "NaN" || adultnew == ""  || adultnew == "0" || adultnew == '0.00')){     
				       	       total=parseFloat(spchild)*parseFloat(childnew);       
				       	    }else if((typeof(childnew) == "undefined" || typeof(childnew) == "NaN" || childnew == ""  || childnew == "0" || childnew == '0.00') && (typeof(adultnew) != "undefined" && typeof(adultnew) != "NaN" && adultnew != ""  && adultnew != "0" && adultnew!='0.00')){     
				       	       total=parseFloat(spadult)*parseFloat(adultnew);          
				       	    }else{
				       	       total=0.0;
				       	    }                                    
				       	    $('#tourGrid').jqxGrid('setcellvalue', rowindextemp, "totalnew",total);              
				       	 }
			          });     
	});
</script>
<div id="tourGrid"></div>