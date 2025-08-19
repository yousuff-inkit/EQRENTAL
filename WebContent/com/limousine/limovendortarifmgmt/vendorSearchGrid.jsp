<%@page import="com.limousine.limovendortarifmgmt.*" %>
<%ClsLimoVendorTarifDAO tarifdao=new ClsLimoVendorTarifDAO();
String name=request.getParameter("name")==null?"":request.getParameter("name");
String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String tariftype=request.getParameter("tariftype")==null?"":request.getParameter("tariftype");
%>
 <script type="text/javascript">
 var id='<%=id%>';
 var tariftype='<%=tariftype%>'
 var vendordata;
 if(id=="1"){
	 vendordata='<%=tarifdao.getVendor(name,mobile,id,tariftype)%>';
 }
        $(document).ready(function () { 	

        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'cldocno', type: 'int'},
     						{name : 'refname', type: 'string'},
     						{name : 'address',type:'string'},
     						{name : 'per_mob',type:'string'}
     											
                 ],               
               localdata:vendordata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
        	
                                      
            };
            $("#vendorSearchGrid").on("bindingcomplete", function (event) {
            	// your code here.
            	 if(tariftype=="corporate"){
        			 $('#vendorSearchGrid').jqxGrid('hidecolumn','address');
        			 $('#vendorSearchGrid').jqxGrid('hidecolumn','per_mob');
        			 $('#vendorSearchGrid').jqxGrid('setcolumnproperty','cldocno','width','20%');
        			 $('#vendorSearchGrid').jqxGrid('setcolumnproperty','refname','width','80%');
        		 }
        		 else if(tariftype=="vendor"){
        			 $('#vendorSearchGrid').jqxGrid('showcolumn','address');
        			 $('#vendorSearchGrid').jqxGrid('showcolumn','per_mob');
        			 $('#vendorSearchGrid').jqxGrid('setcolumnproperty','cldocno','width','10%');
        			 $('#vendorSearchGrid').jqxGrid('setcolumnproperty','refname','width','30%');
        		 }
            });
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
            			loadComplete: function () {
                    		 $("#loadingImage1").css("display", "none");
                    		 if(tariftype=="corporate"){
                    			 $('#vendorSearchGrid').jqxGrid('hidecolumn','address');
                    			 $('#vendorSearchGrid').jqxGrid('hidecolumn','per_mob');
                    			 $('#vendorSearchGrid').jqxGrid('setcolumnproperty','cldocno','width','20%');
                    			 $('#vendorSearchGrid').jqxGrid('setcolumnproperty','refname','width','80%');
                    		 }
                    		 else if(tariftype=="vendor"){
                    			 $('#vendorSearchGrid').jqxGrid('showcolumn','address');
                    			 $('#vendorSearchGrid').jqxGrid('showcolumn','per_mob');
                    			 $('#vendorSearchGrid').jqxGrid('setcolumnproperty','cldocno','width','10%');
                    			 $('#vendorSearchGrid').jqxGrid('setcolumnproperty','refname','width','30%');
                    		 }
                		},
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#vendorSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                  /*   var cell = $('#invAcSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'description' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#invAcSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                },
                
  
                
                columns: [
                           	{ text:'Doc No',datafield:'cldocno',width:'10%'},
                           	{ text:'Name',datafield:'refname',width:'30%'},
                           	{ text:'Address',datafield:'address',width:'40%'},
                           	{ text:'Mobile',datafield:'per_mob',width:'20%'}
												
	              		]
            });
       	$('#vendorSearchGrid').on('rowdoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	document.getElementById("tarifvendor").value=$('#vendorSearchGrid').jqxGrid('getcellvalue',rowindex,'refname');
            	document.getElementById("hidtarifvendor").value=$('#vendorSearchGrid').jqxGrid('getcellvalue',rowindex,'cldocno');
                $('#vendorwindow').jqxWindow('close');
        });
            
      });
    </script>
    <div id="vendorSearchGrid"></div>
 
