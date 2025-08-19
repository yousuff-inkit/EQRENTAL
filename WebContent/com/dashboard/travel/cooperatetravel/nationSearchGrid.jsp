<%@page import="com.dashboard.travel.cooperatetravel.ClsCooperateTravelDAO"%>
<% ClsCooperateTravelDAO DAO=new ClsCooperateTravelDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<script type="text/javascript">
var clientdata;
 <%
     String gridrowindex=request.getParameter("gridrowindex")==null?"0":request.getParameter("gridrowindex").toString();
 %> 
var gridrowindex='<%=gridrowindex%>';
if(id=="1"){
	clientdata='<%=DAO.nationGrid(session)%>';
}
$(document).ready(function () { 

     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'doc_no', type: 'number'  },
				{name : 'nation', type: 'string'   },
          ],
          localdata: clientdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
                                 
     };
     
     var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
    			loadComplete: function () {
            		 $("#loadingImage").css("display", "none"); 
        		},
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
	            
            }		
    );


            
            
            $("#natSearchGrid").jqxGrid(
            {
                width: '99%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    /* var cell = $('#jqxSpecification').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'DESCRIPTION' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxSpecification").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                    
                },
                
                       
                columns: [
								
                            { text:'Doc No',datafield:'doc_no',width:'10%'},
							{ text:'Nation', datafield: 'nation' },			
			              ]
            });
            
            $("#natSearchGrid").on("rowdoubleclick", function (event) {
                var row1=event.args.rowindex;
                
				var docno=$('#natSearchGrid').jqxGrid('getcellvalue',row1,'doc_no');
				var nation=$('#natSearchGrid').jqxGrid('getcellvalue',row1,'nation');
				$('#visaGrid').jqxGrid('setcellvalue',gridrowindex,'natid',docno);
				$('#visaGrid').jqxGrid('setcellvalue',gridrowindex,'nationality',nation);
				$("#visaGrid").jqxGrid("addrow", null, {});
            	$('#natwindow').jqxWindow('close');
                });
        });
    </script>
    <div id="natSearchGrid"></div>