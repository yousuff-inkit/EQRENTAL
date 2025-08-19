<%@ page import="com.limousine.jobassignmentmultiplebus.*" %>
<%ClsJobAssignMultipleBusDAO importdao=new ClsJobAssignMultipleBusDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String locationtype=request.getParameter("locationtype")==null?"":request.getParameter("locationtype");
%>
<script type="text/javascript">
	var id='<%=id%>';
	var locationdata=[];
	if(id=="1"){
		locationdata='<%=importdao.getLocations(id)%>';
	}
	$(document).ready(function () { 	
    
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'number'  },
                            {name : 'location', type: 'string'  }
                        ],
                		
                       
                       localdata: locationdata,
                
                
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
		    });
            
            $("#locationSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 338,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                columns: [
							
							 
                            { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '10%',cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  },
                              
                            { text: 'Location #', datafield: 'doc_no', width: '10%',hidden:true },
                            { text: 'Location Name', datafield: 'location', width: '90%'}
							   
						]
            });
            
          $('#locationSearchGrid').on('rowdoubleclick', function (event) {
            	var rowBoundIndex= event.args.rowindex;
            	var locationtype='<%=locationtype%>';
            	if(locationtype=="pickuplocation"){
            		$('#pickuplocation').val($('#locationSearchGrid').jqxGrid('getcellvalue',rowBoundIndex, "location"));
            		$('#hidpickuplocation').val($('#locationSearchGrid').jqxGrid('getcellvalue',rowBoundIndex, "doc_no"));
            		var selectedrows=$('#bookDetailGrid').jqxGrid('getselectedrowindexes');
            		for(var i=0;i<selectedrows.length;i++){
            			$('#bookDetailGrid').jqxGrid('setcellvalue',selectedrows[i],'pickuplocation',$('#pickuplocation').val());
            			$('#bookDetailGrid').jqxGrid('setcellvalue',selectedrows[i],'pickuplocationid',$('#hidpickuplocation').val());
            		}
            	}
            	else if(locationtype=="dropofflocation"){
            		$('#dropofflocation').val($('#locationSearchGrid').jqxGrid('getcellvalue',rowBoundIndex, "location"));
            		$('#hiddropofflocation').val($('#locationSearchGrid').jqxGrid('getcellvalue',rowBoundIndex, "doc_no"));
            		var selectedrows=$('#bookDetailGrid').jqxGrid('getselectedrowindexes');
            		for(var i=0;i<selectedrows.length;i++){
            			$('#bookDetailGrid').jqxGrid('setcellvalue',selectedrows[i],'dropofflocation',$('#dropofflocation').val());
            			$('#bookDetailGrid').jqxGrid('setcellvalue',selectedrows[i],'dropofflocationid',$('#hiddropofflocation').val());
            		}
            	}
              	$('#locationwindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="locationSearchGrid"></div>
 