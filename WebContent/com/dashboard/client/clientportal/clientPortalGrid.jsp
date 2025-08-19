<%@page import="com.dashboard.client.clientportal.*" %>
<%ClsClientPortalDAO dao=new ClsClientPortalDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id").toString();
%>
<script type="text/javascript">
      var data;
      var id='<%=id%>';
      if(id=="1"){
      	data='<%=dao.getClientData(id)%>';
      }
      var dataExcelExport;
      
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'cldocno' , type: 'number' },
							{name : 'refname' , type:'string'},
							{name : 'address' , type:'string'},
							{name : 'per_mob' , type:'string'},
							{name : 'account' , type:'number'},
							{name : 'mail1',type:'string'},
							{name : 'clientusername' , type:'string'}
	                      ],
                          localdata: data,
               
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
            $("#clientPortalGrid").jqxGrid(
            {
                width: '98%',
                height: 500,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                showfilterrow: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                
                //Add row method
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellclassname: 'whiteClass', pinned: true,
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }    
							},
							{ text: 'Client #', datafield: 'cldocno', width: '7%'},
							{ text: 'Client Name',  datafield: 'refname', width: '15%'  },
							{ text: 'Address', datafield: 'address',  width: '30%' },
							{ text: 'Mobile No',  datafield: 'per_mob',  width: '10%'  },
							{ text: 'Email', datafield:'mail1', width:'16%'},
							{ text: 'Account', datafield:'account', width:'7%'},
							{ text: 'Username',  datafield: 'clientusername',  width: '10%'},
							
						 ]
            });
            
			$("#overlay, #PleaseWait").hide();
			
            $('#clientPortalGrid').on('rowdoubleclick', function (event) { 
          	  var rowindex1=event.args.rowindex;
          	  $('#clientusername,#clientpassword').val('');
          	  $('#cldocno').val($('#clientPortalGrid').jqxGrid('getcellvalue',rowindex1,'cldocno'));
          	}); 
        });  

</script>
<div id="clientPortalGrid"></div>
