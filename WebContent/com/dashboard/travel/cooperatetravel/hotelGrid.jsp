<%@page import="com.dashboard.travel.cooperatetravel.ClsCooperateTravelDAO"%>
<% ClsCooperateTravelDAO DAO=new ClsCooperateTravelDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
 <%    
     String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
     String type=request.getParameter("type")=="" || request.getParameter("type")==null?"0":request.getParameter("type").toString();
 %>                 
   <% String contextPath=request.getContextPath();%>      
<script type="text/javascript">          
var pdata;         
pdata='<%=DAO.hotelGrid(rdocno,type) %>';                                                 
$(document).ready(function(){     
 
  
        var source =
        {
            datatype: "json",            
            datafields: [ 
                        {name : 'rowno', type: 'string'}, 
                        {name : 'location', type: 'string'}, 
                        {name : 'hotelname', type: 'string'},    
                        {name : 'rtype', type: 'string'}, 
                        {name : 'rtypeid', type: 'string'},  
                        {name : 'package', type: 'string'},  
                        {name : 'packageid', type: 'string'},  
                        {name : 'fromdate', type: 'string'},  
                        {name : 'todate', type: 'string'},  
                      	{name : 'guestname', type: 'string'},              
                      	{name : 'remarks',type:'string'}, 
                      	{name : 'attach',type:'string'}, 
                    	{name : 'vendor',type:'string'}, 
                    	{name : 'vendorid',type:'string'},
                    	{name : 'total' , type: 'number'},

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



        $("#hotelGrid").jqxGrid(  
                {
                	width: '100%',
                    height: 200,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlecell',
                    altrows:true,
                     columnsresize: true,
                     editable:false,
                    //Add row method 
                    columns: [   
                             
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '5%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },  
    					 
    					{ text: 'Guest Name',datafield: 'guestname'},     
    					{ text: 'Room type',datafield: 'rtype'},
    					{ text: 'RowNo',datafield: 'rowno', width: '5%',hidden:true},
    					{ text: 'Room typeid',datafield: 'rtypeid',hidden:true},  
    					{ text: 'Hotel',datafield: 'hotelname',hidden:true}, 
    					{ text: 'Location',datafield: 'location',hidden:true}, 
    					{ text: 'Package',datafield: 'package'},
    					{ text: 'Packageid',datafield: 'packageid',hidden:true},
    					{ text: 'From Date',datafield: 'fromdate',cellsformat:'dd.MM.yyyy'},  
    					{ text: 'To Date',datafield: 'todate',cellsformat:'dd.MM.yyyy'},
    					{ text: 'Remarks',datafield: 'remarks'},
    					{ text: 'Vendor',datafield: 'vendor'},
    					{ text: 'Vendor ID',datafield: 'vendorid',hidden:true},
    					{ text: 'Attach',datafield: 'attach',columntype:'button',width:'7%',cellsrenderer: function () {
							return "Attach"}
						},
						{ text: 'Total', datafield: 'total', width: '10%',cellsalign: 'right', align:'right',hidden:true},
    	              ]                                         
                }); 
        $("#hotelGrid").jqxGrid('addrow', null, {});  
        $('#hotelGrid').on('cellclick', function (event) 
		   { 
	   
			   var rowindex1=event.args.rowindex;
			   var datafield=event.args.datafield;
			   if(datafield=="attach"){
				var doc_no=$('#txtrdocno').val();
				var frmname="TRAVEL";
				   var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode=TRVL&docno="+doc_no+"&brchid=1"+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
							  myWindow.focus();
	   		}
	   
		   });
       
        
         
	});
</script>
<div id="hotelGrid"></div>