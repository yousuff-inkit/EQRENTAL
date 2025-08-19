<%@ page import="com.dashboard.android.checkinout.CheckInOutDAO" %>
<% CheckInOutDAO ciod=new CheckInOutDAO(); %>
 <%
 
String rdoc = request.getParameter("rdoc")==null?"0":request.getParameter("rdoc");
 %>
 <script type="text/javascript">
 
 var temp4='<%=rdoc%>';
 var detailss;
 var aa;

 if(temp4!='0')
 { 
 detailss='<%=ciod.attachDetails(rdoc)%>';
 aa=0;
 }
 else
 {
	 detailss;
 	 aa=1;
 	} 
 
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'srno', type: 'String'  },
                 		
     						{name : 'dtyp', type: 'String'},
     						
     						 {name : 'description', type: 'String'},
     						{name : 'filename' , type : 'String'},
     						 {name : 'path', type: 'string'    }
     						
                          	],
                          	localdata: detailss,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#detailsgrid").jqxGrid(
            { 
            	
            	
            	width: '98%',
                height: 150,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
   
                editable:false,
                
     					
                columns: [
						
							{ text: 'Sr No.', datafield: 'srno', width: '10%'},
							
							 { text: 'Doc Type', datafield: 'dtyp', width: '10%' },
				
							 { text: 'Description', datafield: 'description', width: '50%'},	
							 
							 { text: 'File Name', datafield: 'filename', width: '30%' },
							 { text: 'File Location', datafield: 'path', width: '20%',hidden:true }
							
					
					]
            });
            
            if(aa==1)
        	{
        	 $("#detailsgrid").jqxGrid('addrow', null, {});
        	}
            
             $('#detailsgrid').on('rowdoubleclick', function (event) 
                    { 
                     var rowindexes=event.args.rowindex;
                     SaveToDisk($('#detailsgrid').jqxGrid('getcellvalue', rowindexes, "path"),$('#detailsgrid').jqxGrid('getcellvalue', rowindexes, "filename"));
                    }); 
            
        });
        
        	function SaveToDisk(fileURL, fileName) {
        		   var host = window.location.origin;
        		  
        		   var splt = fileURL.split("webapps"); 
        		  
        		   var repl = splt[1].replace( /;/g, "/");
        		   fileURL=host+repl;
        		    if (!window.ActiveXObject) {
        		        var save = document.createElement('a');
        		        save.href = fileURL;
        		        save.target = '_blank';
        		        save.download = fileName || 'unknown';
        				
        		        window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
        		        
        		    }

        		    // for IE
        		    else if ( !! window.ActiveXObject && document.execCommand)     {
        		        var _window = window.open(fileURL, '_blank');
        		        _window.document.close();
        		        _window.document.execCommand('SaveAs', true, fileName || fileURL)
        		        _window.close();
        		    }
        		} 
        		
                        
    </script>
    <div id="detailsgrid"></div>