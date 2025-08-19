<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO(); %>
 <%
     String userid=request.getParameter("userid")==null?"0":request.getParameter("userid").toString();
 String id=request.getParameter("id")==null?"0":request.getParameter("id").toString();
 %>                
<script type="text/javascript">          
var pdata;         
  pdata='<%=DAO.pendingGrid(userid, id) %>';                                           
 
$(document).ready(function(){  

        var source =
        {
            datatype: "json",            
            datafields: [   
                        {name : 'crtuser', type: 'string'},     
                        {name : 'userid', type: 'string'},      
                        {name : 'ass_user', type: 'string'},  
                      	{name : 'doc_no', type: 'string'},
 						{name : 'ref_type', type: 'string'},
 						{name : 'ref_no', type:'string'},
 						{name : 'edcdate',type:'date'},   
 						{name : 'strt_date',type:'date'},
 						{name : 'strt_time',type:'string'},
                      	{name : 'description', type: 'string'},      
                      	{name : 'status',type:'string'}, 
                      	{name : 'user',type:'string'},  
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

        var clickedRow;

        var cellclass = function (row, columnfield, value) {
            if (clickedRow == row) {
                return "green";
            }
        }

        $("#pendingGrid").jqxGrid(  
                {
                	width: '100%',
                    height: 150,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    enabletooltips:true,
                    columnsresize: true, 
                    columns: [            
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '4%', cellclassname: cellclass,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },             
    					{ text: 'Doc No',datafield: 'doc_no', width: '0%',hidden:true},            
    					{ text: 'Type',datafield: 'ref_type', width: '6%', cellclassname: cellclass},            
    					{ text: 'Ref.No',datafield: 'ref_no', width: '4%', cellclassname: cellclass},     
    					{ text: 'Created User',datafield: 'crtuser', width: '12%', cellclassname: cellclass},  
    					{ text: 'EDC',datafield: 'edcdate', width: '6%',cellsformat:'dd.MM.yyyy', cellclassname: cellclass},
    					{ text: 'St.Date',datafield: 'strt_date', width: '6%',cellsformat:'dd.MM.yyyy', cellclassname: cellclass},
    					{ text: 'St.Time',datafield: 'strt_time', width: '6%',cellsformat:'dd.MM.yyyy HH:mm:ss', cellclassname: cellclass},         
    					{ text: 'Description',datafield: 'description', width: '36%', cellclassname: cellclass},       
    					{ text: 'User',datafield: 'user', width: '12%', cellclassname: cellclass}, 
    					{ text: 'Status',datafield: 'status', width: '8%', cellclassname: cellclass},   
    					{ text: 'Assignuser',datafield: 'ass_user', width: '0%',hidden:true},  
    					{ text: 'createuser',datafield: 'userid', width: '0%',hidden:true},
    	              ]                                         
                }); 
        
	        $('#pendingGrid').on('rowdoubleclick', function (event) {    
	            var rowindex2 = event.args.rowindex;                      
	            document.getElementById("txtpendocno").value=$('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
	            document.getElementById("txtasgnuser").value=$('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "ass_user");
	            document.getElementById("txtcrtuser").value=$('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "userid");
	            document.getElementById("txtoldstatus").value=$('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "status");
	            funstatusval();     
	            subLoad();
	            funChangeStatus();
	            clickedRow = rowindex2;
                $("#pendingGrid").jqxGrid('refresh');   
	        });          
	});
</script>
<div id="pendingGrid"></div>