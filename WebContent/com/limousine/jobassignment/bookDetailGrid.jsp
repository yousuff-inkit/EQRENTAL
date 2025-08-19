<%@page import="com.limousine.jobassignment.*" %>
<%ClsJobAssignDAO jobdao=new ClsJobAssignDAO();
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");

%>
<script type="text/javascript">
var id='<%=id%>';
var detaildata;
if(id=="1"){
	detaildata='<%=jobdao.getDetailData(bookdocno,id,branch)%>';
}
$(document).ready(function () { 
	
       
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'doc_no' , type: 'int' },
                       	{name : 'bookdocno',type:'int'},
                       	{name : 'detaildocno',type:'int'},
                       	{name : 'docname',type:'string'},
                       	{name : 'refname' , type:'string'},
                       	{name : 'cldocno',type:'string'},
                       	{name : 'guestno',type:'string'},
                       	{name : 'guest',type:'string'},
                       	{name : 'type',type:'string'},
                       	{name : 'blockhrs',type:'number'},
                       	{name : 'pickupdate',type:'date'},
                       	{name : 'pickuptime',type:'date'},
                       	{name : 'pickuplocation',type:'string'},
                       	{name : 'pickupaddress',type:'string'},
                       	{name : 'dropofflocation',type:'string'},
                       	{name : 'dropoffaddress',type:'string'},
                       	{name : 'brand',type:'string'},
                       	{name : 'model',type:'string'},
                       	{name : 'nos',type:'string'},
                       	{name : 'brandid',type:'string'},
                       	{name : 'modelid',type:'string'}
     				   ],
					localdata:detaildata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };

          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });

            $("#bookDetailGrid").jqxGrid(
            {
               width: '100%',
               height: 450,
               source: dataAdapter,
               columnsresize: true,
               editable:false,
               selectionmode: 'singlerow',
               
                //Add row method
                 handlekeyboardnavigation: function (event) {
            // var rows = $('#jqxgridtarif').jqxGrid('getrows');
       /*      alert("here");
                  var rowlength= event.args.rowindex;
                  alert(rowlength);
                    var cell = $('#jqxgridtarif').jqxGrid('getselectedcell');
				if (cell != undefined && cell.datafield == 'disclevel3') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {
                            $('#jqxgridtarif').jqxGrid('selectcell',rowlength+1, 'rentaltype');
                   					$('#jqxgridtarif').jqxGrid('focus',rowlength+1, 'rentaltype');
                                       
                        }
				} */
                 },
            
               
                columns: [
                       
							{ text: 'Doc No', datafield: 'doc_no',width:'4%',hidden:true},
							{ text: 'Detail Docno',datafield:'detaildocno',width:'4%',hidden:true},
							{ text: 'Booking Docno',datafield: 'bookdocno',width:'4%',hidden:true},
							{ text: 'Job Name',datafield:'docname',width:'4.5%'},
							{ text: 'Client ID',datafield:'cldocno',width:'4%',hidden:true},
							{ text: 'Guest ID',datafield:'guestno',width:'4%',hidden:true},
							{ text: 'Client',  datafield: 'refname',width:'12%'},
							{ text: 'Guest',datafield:'guest',width:'10%'},
							{ text: 'Type',datafield:'type',width:'5%'},
							{ text: 'Block Hrs',datafield:'blockhrs',width:'4.5%'},
							{ text: 'Pickup date',datafield:'pickupdate',width:'6%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Pickup time',datafield:'pickuptime',width:'5.5%',cellsformat:'HH:mm'},
							{ text: 'Pickup Location',datafield:'pickuplocation',width:'10%'},
							{ text: 'Pickup Address',datafield: 'pickupaddress',width:'10%'},
							{ text: 'Dropoff Location',datafield:'dropofflocation',width:'10%'},
							{ text: 'Dropoff Address',datafield:'dropoffaddress',width:'10%'},
							{ text: 'Brand',datafield:'brand',width:'8%'},
							{ text: 'Model',datafield:'model',width:'8%'},
							{ text: 'Nos',datafield:'nos',width:'4%'},
							{ text: 'Brandid',datafield:'brandid',width:'4%',hidden:true},
							{ text: 'Modelid',datafield:'modelid',width:'4%',hidden:true}
							
         	              ]
           
            });
            
            $("#bookDetailGrid").on("celldoubleclick", function (event)
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // row's bound index.
            		    var rowBoundIndex = args.rowindex;
            		    // row's visible index.
            		    var rowVisibleIndex = args.visibleindex;
            		    // right click.
            		    var rightClick = args.rightclick; 
            		    // original event.
            		    var ev = args.originalEvent;
            		    // column index.
            		    var columnIndex = args.columnindex;
            		    // column data field.
            		    var dataField = args.datafield;
            		    // cell value
            		    var value = args.value;
            		    funRemoveReadOnly();
            		    $('#btndetailsave').show();
            		    document.getElementById("jobname").value=$('#bookDetailGrid').jqxGrid('getcellvalue',rowBoundIndex,'docname');
            			document.getElementById("gridrowindex").value=rowBoundIndex;
            			document.getElementById("type").value=$('#bookDetailGrid').jqxGrid('getcellvalue',rowBoundIndex,'type');
            			document.getElementById("bookdocno").value=$('#bookDetailGrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no');
            			document.getElementById("detaildocno").value=$('#bookDetailGrid').jqxGrid('getcellvalue',rowBoundIndex,'detaildocno');
            			document.getElementById("cldocno").value=$('#bookDetailGrid').jqxGrid('getcellvalue',rowBoundIndex,'cldocno');
            			document.getElementById("guestno").value=$('#bookDetailGrid').jqxGrid('getcellvalue',rowBoundIndex,'guestno');
            		});
            });

	
            </script>
            <div id="bookDetailGrid"></div>
            <input type="hidden" name="gridrowindex" id="gridrowindex">