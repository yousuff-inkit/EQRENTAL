<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO();
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 

<script type="text/javascript">

	    var data5= '<%=DAO.specificationLoad(session,docno) %>'; 
	   
        $(document).ready(function () { 	
        	
     	   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'charctstcs', type: 'string' },
     						{name : 'uom', type: 'string'   },
     						{name : 'desc1', type: 'string'  },
     						{name : 'note', type: 'string'   },
     						{name : 'prr', type: 'string' },
     						{name : 'tstmthd', type: 'string' },
     						{name : 'req', type: 'string' },
     						{name : 'doc_no', type: 'string'  }
     					     					     						  											
                 ],
                 localdata: data5,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            } );

            
            
            $("#specGrid").jqxGrid(
            {
            	width: '100%',
                height: 250,
                source: dataAdapter,
                columnsresize: true,
                editable: true,
                sortable: true,
                selectionmode: 'singlecell',
                handlekeyboardnavigation: function (event) {
                    var rows = $('#specGrid').jqxGrid('getrows');
                       var rowlength= rows.length;
                       var cell = $('#specGrid').jqxGrid('getselectedcell');
                       if (cell != undefined && cell.datafield == 'note' && cell.rowindex == rowlength - 1) {
                           var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                           if (key == 9) {                                                        
                               var commit = $("#specGrid").jqxGrid('addrow', null, {});
                               rowlength++;                           
                           }
                       }
   },      
                columns: [
                	
							{ text: 'Characteristics', datafield: 'charctstcs' },			
							{ text: 'Description ', datafield: 'desc1' },	
							{ text: 'Test Method', datafield: 'tstmthd', width: '8%' },	
							{ text: 'Units', datafield: 'uom', width: '8%' },	
							{ text: 'Requisite', datafield: 'req', width: '8%' },	
							{ text: 'Priority', datafield: 'prr', width: '6%' },	
							{ text: 'Note', datafield: 'note' },
							{ text: 'Docno', datafield: 'doc_no',hidden:true }
							
						 ],
						
            });
            if($('#mode').val()=='view')
	         {
       	$("#specGrid").jqxGrid({
			disabled : true
		});
	         }
           
        });

</script>
<div id="specGrid"></div>
 
 