<%@page import="com.dashboard.travel.cooperatetravel.ClsCooperateTravelDAO"%>
<% ClsCooperateTravelDAO DAO=new ClsCooperateTravelDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<script type="text/javascript">
var sdata;
 <%
     String gridrowindex=request.getParameter("gridrowindex")==null?"0":request.getParameter("gridrowindex").toString();
 %> 
var gridrowindex='<%=gridrowindex%>';

	sdata='<%=DAO.servicetypeGrid(session)%>';

$(document).ready(function () { 

     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'doc_no', type: 'number'  },
				{name : 'name', type: 'string'   },
          ],
          localdata: sdata,
         
         
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


            
            
            $("#serTypeGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
               
                
                       
                columns: [
								
                            { text:'Doc No',datafield:'doc_no'},
							{ text:'Service type', datafield: 'name' },			
			              ]
            });
            
            $("#serTypeGrid").on("rowdoubleclick", function (event) {
                var row1=event.args.rowindex;
                
				var docno=$('#serTypeGrid').jqxGrid('getcellvalue',row1,'doc_no');
				var sertype=$('#serTypeGrid').jqxGrid('getcellvalue',row1,'name');
				$('#serviceReqGrid').jqxGrid('setcellvalue',gridrowindex,'serdocno',docno);
				$('#serviceReqGrid').jqxGrid('setcellvalue',gridrowindex,'servicetype',sertype);
				$("#serviceReqGrid").jqxGrid("addrow", null, {});
            	$('#sertypewindow').jqxWindow('close');
                });
        });
    </script>
    <div id="serTypeGrid"></div>