<%@ page import="com.dashboard.leaseagreement.lacreate.*"%>
 <%
String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
String uptodate = request.getParameter("uptodate")==null?"":request.getParameter("uptodate").trim();
String cldocno = request.getParameter("cldocno")==null?"":request.getParameter("cldocno").trim();
String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
ClsLACreateDAO ladao=new ClsLACreateDAO();
%> 
 <script type="text/javascript">
 var id='<%=id%>';
 var ladata=[];
 if(id=="1"){
 	ladata='<%=ladao.getLAData(uptodate,cldocno,branch,id)%>';
 }
$(document).ready(function () { 
	
	var source = 
    	{
        	datatype: "json",
            datafields: [
				{name : 'doc_no', type: 'String'  },
				{name : 'voc_no', type: 'String'  },
				{name : 'refname', type: 'String'},     						
				{name : 'po', type: 'String'}, 
				{name : 'refno', type: 'String'}, 
				{name : 'brand', type: 'string'  },
				{name : 'model', type: 'String'  },
				{name : 'spec', type: 'String'  },
				{name : 'duration', type: 'String'  },
				{name : 'qty', type: 'string'  },
				{name : 'cldocno',type:'string'},
				{name : 'masterrefsrno',type:'string'}
  			
  				],
            localdata: ladata,
            
            pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            $("#detailsgrid").on("bindingcomplete", function (event) {$("#overlay, #PleaseWait").hide();}); 
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#detailsgrid").jqxGrid(
            { 
            
            	width: '99%',
                height: 340,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:true,
                columnsresize:true,
     					
                columns: [
                          
      
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
                          
							{ text: 'Master Agmt No', datafield: 'doc_no', width: '4%',hidden:true, editable: false }, 
							{ text: 'Master Agmt No', datafield: 'voc_no', width: '7%' , editable: false},             
							{ text: 'Client Name', datafield: 'refname', width: '20%' , editable: false},
							{ text: 'PO', datafield: 'po', width: '12%', editable: false},
							{ text: 'Ref No', datafield: 'refno', width: '10%', editable: false},
							{ text: 'Brand', datafield: 'brand', width: '12%', editable: false },
							{ text: 'Model', datafield: 'model', width: '12%', editable: false },
							{ text: 'Specification', datafield: 'spec', width: '13%', editable: false},
							{ text: 'Duration', datafield: 'duration', width: '6%', editable: false},
							{ text: 'Qty', datafield: 'qty', width: '5%' , editable: false},
							{ text: 'Client No', datafield: 'cldocno', width: '5%' , editable: false,hidden:true},
							{ text: 'Ref Sr No', datafield: 'masterrefsrno', width: '5%' , editable: false,hidden:true},
					]
            });

        });
        
        $("#detailsgrid").on("rowdoubleclick", function (event) 
        		{
        		    // event arguments.
        		    var args = event.args;
        		    // row's bound index.
        		    var rowBoundIndex = args.rowindex;
        		   	$('#hidmasterrefno').val($('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no'));
        		    $('#duration').val($('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'duration'));
        		    $('#cldocno').val($('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'cldocno'));
        		    $('#clientname').val($('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'refname'));
        		    var cldocno=$('#cldocno').val();
        		    $('#hidmasterrefsrno').val($('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'masterrefsrno'));
        		    //$('#driverdiv').load('driverGrid.jsp?cldocno='+cldocno+'&id=1');
        		});    
		
    </script>
    <div id="detailsgrid"></div>
    