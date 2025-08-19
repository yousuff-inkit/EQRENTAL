 <%@page import="com.dashboard.travel.travel.ClsTravelDAO"%>
                                       
 <%  ClsTravelDAO sd=new ClsTravelDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>           
 <%
     String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
 %>                
<script type="text/javascript">          
var tsdata;           
 tsdata='<%=sd.tourSubGrid(rdocno) %>';                                       
$(document).ready(function(){  
        var source =
        {
            datatype: "json",            
            datafields: [  
                     	{name : 'height', type: 'number'}, 
                    	{name : 'weight', type: 'number'}, 
						{name : 'age', type: 'number'},     
                       	{name : 'name', type: 'string'},  
                     	{name : 'rowno', type: 'string'},
                     	{name : 'remarks', type: 'string'},
             ],
             localdata: tsdata,
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

        $("#tourSubGrid").jqxGrid(  
                {
                	width: '100%',
                    height: 150,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlecell',  
                    altrows:true,
                    columnsresize: true,
                    enabletooltips:true,  
                    editable:true,
                    //Add row method 
                    columns: [     
                             
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '5%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },  
    					{ text: 'Name',datafield: 'name'},  
    					{ text: 'rowno',datafield: 'rowno',hidden:true},     
    					{ text: 'Age',datafield: 'age', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right'},
    					{ text: 'Height(CM)',datafield: 'height', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right'},
    					{ text: 'Weight(KG)',datafield: 'weight', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right'},
    					{ text: 'Remarks',datafield: 'remarks', width: '7%'},
    	              ]                                         
                }); 
        var adult=document.getElementById("touradult").value;   
        var child=document.getElementById("tourchild").value;
        var count=parseInt(adult)+parseInt(child);
        var rows=$('#tourSubGrid').jqxGrid('getrows'); 
   	    var len=parseInt(count)-parseInt(rows.length);   
         for(var i=0;i<len;i++){          
       	   $("#tourSubGrid").jqxGrid('addrow', null, {});         
            }
	});
</script>
<div id="tourSubGrid"></div>