<%@page import="com.dashboard.audit.attachmentlist.ClsAttachmentListDAO" %>
<% ClsAttachmentListDAO card=new ClsAttachmentListDAO();%>

 <%

   String barchval = request.getParameter("brhid")==null?"NA":request.getParameter("brhid");
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String doc_no = request.getParameter("doc_no")==null?"NA":request.getParameter("doc_no").trim();
  	String dtype = request.getParameter("dtype")==null?"NA":request.getParameter("dtype").trim();
  	String type = request.getParameter("type")==null?"0":request.getParameter("type");%>

 
 
 <style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greyClass
    {
        background-color: #D8D8D8;
    }
        

        
</style>
 
<% String contextPath=request.getContextPath();%> 
 <script type="text/javascript">
 var temp4='<%=barchval%>';
 var apprdata;
 var data;
 
	  apprdata='<%=card.detailsgrid(barchval,fromdate,todate,doc_no,dtype,type)%>';
	  data='<%=card.detailsgridExcel(barchval,fromdate,todate,doc_no,dtype,type)%>';
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'doc_no', type: 'String'  },
                 			{name : 'rowno', type: 'String'  },
     						{name : 'userid', type: 'String'},
     						 {name : 'brhid', type: 'String'}, 
     						 {name : 'user', type: 'String'}, 
     						{name : 'branchname', type: 'String'  },
     						{name : 'dtype', type: 'String'  },
     						{name : 'remarks', type: 'String'  },
     						{name : 'date', type: 'date'  },
     						{name : 'filename', type: 'String'  },
     						{name : 'name', type: 'String'  },
     						{name : 'type', type: 'String'  },
     						{name : 'descr', type: 'String'  },
     						{name : 'path', type: 'String'  },
                          	],
                          	localdata: apprdata,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var cellclassname = function (row, column, value, data) {
//           		if (data.apprlevel==1) {
//                       return "redClass";
//                   } else if (data.apprlevel==2) {
//                       return "yellowClass";
//                   }
//                   else{
//                   	return "greyClass";
//                   };
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
            	
            	
            	width: '100%',
                height: 500,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
				columnsresize:true,
				showfilterrow: true,
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
			         columns: [
			                   { text: 'SRNO', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',cellclassname: cellclassname,
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							  { text: 'userid', datafield: 'userid', width: '4%',hidden:true },
							  { text: 'brhid', datafield: 'brhid', width: '4%',hidden:true },
							//  { text: 'apprstatus', datafield: 'apprstatus', width: '4%',hidden:true },
							{ text: 'BRANCH', datafield: 'branchname', width: '15%',cellclassname: cellclassname },
							{ text: 'DTYPE', datafield: 'dtype', width: '6%',cellclassname: cellclassname },
							{ text: 'DOCNO', datafield: 'doc_no', width: '8%',cellclassname: cellclassname },
							{ text: 'ROWNO', datafield: 'rowno', width: '8%',cellclassname: cellclassname,hidden:true },
							{ text: 'DESCRIPTION', datafield: 'descr', width: '15%',cellclassname: cellclassname },
							{ text: 'TYPE', datafield: 'type', width: '12%',cellclassname: cellclassname},
							{ text: 'NAME', datafield: 'name', width: '10%',cellclassname: cellclassname},
							{ text: 'FILENAME', datafield: 'filename', width: '10%',cellclassname: cellclassname},
							{ text: 'USER', datafield: 'user', width: '19%',cellclassname: cellclassname },
							{ text: 'File Location', datafield: 'path', width: '30%',cellclassname: cellclassname, editable: false,hidden:true },
							{ text: 'DATE', datafield: 'date', width: '12%',cellclassname: cellclassname ,cellsformat:'dd.MM.yyyy'},
							//{ text: 'Transaction Status', datafield: 'remarks', width: '12%'},
				
					
					]
            });
            
            $("#overlay, #PleaseWait").hide(); 
       
            $('#detailsgrid').on('rowdoubleclick', function (event) {
                
                var rowindex3 = event.args.rowindex;
                //document.getElementById("doctype").value=$('#docsearch').jqxGrid('getcellvalue', rowindex2, "dtype");
                //document.getElementById("doc_no").value=$('#detailsgrid').jqxGrid('getcellvalue', rowindex3, "doc_no");
                document.getElementById("brhid").value=$('#detailsgrid').jqxGrid('getcellvalue', rowindex3, "brhid");
                document.getElementById("hidrowno").value=$('#detailsgrid').jqxGrid('getcellvalue', rowindex3, "rowno");
               // document.getElementById("doctype").value=$('#detailsgrid').jqxGrid('getcellvalue', rowindex3, "dtype");
                
                SaveToDisk($('#detailsgrid').jqxGrid('getcellvalue', rowindex3, "path"),$('#detailsgrid').jqxGrid('getcellvalue', rowindex3, "filename"));
                function SaveToDisk(fileURL, fileName) {
              	  //alert(fileURL);
              	   //fileName='';
              	   var host = window.location.origin;
              	   //alert("hooosssst"+host);
              	  
              	   var splt = fileURL.split("webapps"); 
              	  //alert("after split"+splt[1]);
              	   var repl = splt[1].replace( /;/g, "/");
              	   //alert("repl"+repl);
              	   //alert("after replace===="+repl);
              	   fileURL=host+repl;
              	   //alert("fileURL===="+fileURL);
              	    // for non-IE
              	    if (!window.ActiveXObject) {
              	        var save = document.createElement('a');
              	        //alert(save);
              	      //  alert(fileURL);
              	        save.href = fileURL;
              	        save.target = '_blank';
              	        save.download = fileName || 'unknown';
              			
              	        window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
              	        
              	        //var event = document.createEvent('Event');
              	       // alert(event);
              	        //event.initEvent('click', true, true);
              	        //save.dispatchEvent(event);
              	        //(window.URL || window.webkitURL).revokeObjectURL(save.href);
              	    }

              	    // for IE
              	    else if ( !! window.ActiveXObject && document.execCommand)     {
              	        var _window = window.open(fileURL, '_blank');
              	        _window.document.close();
              	        _window.document.execCommand('SaveAs', true, fileName || fileURL)
              	        _window.close();
              	    }
              	} 
                
                

				
            
            
            }); 
            
            
        });
                     
    </script>
    <div id="detailsgrid"></div>