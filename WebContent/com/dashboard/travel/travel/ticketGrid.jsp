 <%@page import="com.dashboard.travel.travel.ClsTravelDAO"%>
                                       
 <%  ClsTravelDAO sd=new ClsTravelDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
 <%
     String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
 %>               
 <% String contextPath=request.getContextPath();%>       
<script type="text/javascript">          
var pdata;         
 pdata='<%=sd.ticketGrid(rdocno) %>';                                         
 
 

$(document).ready(function(){  

        var source =
        {
            datatype: "json",            
            datafields: [    
                        {name : 'ptype', type: 'string'},   
                        {name : 'fromdest', type: 'string'},  
                        {name : 'todest', type: 'string'},  
                        {name : 'date', type: 'string'},    
                      	{name : 'givenname', type: 'string'},        
                      	{name : 'surname',type:'string'}, 
                      	{name : 'nationality',type:'string'}, 
                      	{name : 'passno',type:'string'},
                      	{name : 'nationid',type:'string'}, 
                      	{name : 'issuedfrom',type:'string'}, 
                      	{name : 'vupto',type:'string'}, 
                      	{name : 'attach',type:'string'},
                      	{name : 'remarks',type:'string'}, 
                     	{name : 'rowno',type:'string'}, 
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



        $("#ticketGrid").jqxGrid(  
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
						{ text: 'rowno',datafield: 'rowno',hidden:true},       
    					{ text: 'Given Name',datafield: 'givenname'}, 
    					{ text: 'Surname',datafield: 'surname'},
    					{ text: 'Passportno',datafield: 'passno'},
    					{ text: 'Issued From',datafield: 'issuedfrom'},
    					{ text: 'Valid  Upto',datafield: 'vupto',cellsformat:'dd.MM.yyyy'},
    					{ text: 'From Dest.',datafield: 'fromdest'},  
    					{ text: 'To Dest.',datafield: 'todest',editable:true},
    				    { text: 'Date',datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
    				    { text: 'PassengerType',datafield: 'ptype' },
    				    { text: 'Remarks',datafield: 'remarks' },
    				    { text: '',datafield: 'attach',columntype:'button',width:'7%',cellsrenderer: function () {
							return "Attach";}
						},
    	              ]                                            
                }); 
        $("#ticketGrid").jqxGrid('addrow', null, {});     
        $('#ticketGrid').on('cellclick', function (event) 
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
<div id="ticketGrid"></div>