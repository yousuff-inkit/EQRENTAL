<%@page import="com.dashboard.travel.cooperatetravel.ClsCooperateTravelDAO"%>
<% ClsCooperateTravelDAO DAO=new ClsCooperateTravelDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
 <%
     String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
 %>          
  <% String contextPath=request.getContextPath();%>      
<script type="text/javascript">          
var pdata;         
 pdata='<%=DAO.visaGrid(rdocno) %>';                                         
 
$(document).ready(function(){  

        var source =
        {
            datatype: "json",            
            datafields: [    
                         {name : 'rowno', type: 'string'},  
                        {name : 'visaval', type: 'string'},  
                        {name : 'vdocno', type: 'string'},   
                        {name : 'vtype', type: 'string'},    
                      	{name : 'givenname', type: 'string'},      
                      	{name : 'surname',type:'string'}, 
                      	{name : 'nationality',type:'string'}, 
                      	{name : 'natid',type:'string'}, 
                      	{name : 'passno',type:'string'}, 
                      	{name : 'issuedfrom',type:'string'}, 
                      	{name : 'vupto',type:'string'}, 
                      	{name : 'remarks',type:'string'}, 
                      	{name : 'attach',type:'string'}, 
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



        $("#visaGrid").jqxGrid(  
                {
                	width: '100%',
                    height: 200,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                  	enabletooltips:true,
                    altrows:true,
                     columnsresize: true,
                    //Add row method 
                    columns: [   
                             
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '5%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },  
    					  
						{ text: 'rowno',datafield: 'rowno',hidden:true},                 
    					{ text: 'Given Name',datafield: 'givenname',width:'18%'}, 
    					{ text: 'Surname',datafield: 'surname',width:'18%'},
    					{ text: 'Visa Type',datafield: 'vtype'},
    					{ text: 'Visaid',datafield: 'vdocno',hidden:true},
    					{ text: 'Visa Validity',datafield: 'visaval'},
    					{ text: 'Nationality',datafield: 'nationality'},
    					{ text: 'Natid',datafield: 'natid',hidden:true},
    					{ text: 'Passport No',datafield: 'passno'},
    					{ text: 'Issued From',datafield: 'issuedfrom'},
    					{ text: 'Valid  Upto',datafield: 'vupto'},
    					{ text: 'Remarks',datafield: 'remarks',width:'10%'},
    					{ text: '',datafield: 'attach',columntype:'button',width:'7%',cellsrenderer: function () {
							return "Attach";}
						},
    	              ]                                         
                });
            $("#visaGrid").jqxGrid("addrow", null, {});  
            $('#visaGrid').on('cellclick', function (event) 
		   { 
	   
			   var rowindex1=event.args.rowindex;
			   var datafield=event.args.datafield;
			   if(datafield=="attach"){
				var doc_no=$('#visaGrid').jqxGrid('getcellvalue',rowindex1,"doc_no");
				   var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode=BDCR&docno="+doc_no+"&brchid=1"+"&frmname="+document.getElementById("detailname").value,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
							  myWindow.focus();
	   		}
	   
		   });	
		   
		     
         /*  $('#visaGrid').on('celldoubleclick', function (event) {    
            
            var rowindex2 = event.args.rowindex; 
            var dataField = args.datafield;
            if(dataField=="nationality"){
            
            	 $('#natwindow').jqxWindow('open');
              		$('#natwindow').jqxWindow('focus');
              		SearchContent('nationGridSearch.jsp?gridrowindex='+rowindex2,'natwindow');   
            }                     
        }); */
            
      /*  $('#visaGrid').on('rowdoubleclick', function (event) {    
            
            var rowindex2 = event.args.rowindex;                      
            document.getElementById("txtpendocno").value=$('#miceGrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
            document.getElementById("txtasgnuser").value=$('#miceGrid').jqxGrid('getcellvalue', rowindex2, "ass_user");
            document.getElementById("txtcrtuser").value=$('#miceGrid').jqxGrid('getcellvalue', rowindex2, "userid");
            document.getElementById("txtoldstatus").value=$('#miceGrid').jqxGrid('getcellvalue', rowindex2, "status");
            var crtuser=$('#miceGrid').jqxGrid('getcellvalue', rowindex2, "userid");
            funstatusval(crtuser); 
           
            
        	$('#flwupdiv').load('taskfollowupGrid.jsp?docno='+$('#miceGrid').jqxGrid('getcellvalue', rowindex2, "doc_no"));  
        });  */     
	});
</script>
<div id="visaGrid"></div>