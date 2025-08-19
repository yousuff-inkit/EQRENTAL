<%@page import="com.limousine.jobassignmentmultiplebus.*" %>
<%ClsJobAssignMultipleBusDAO jobdao=new ClsJobAssignMultipleBusDAO();
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String chkuptodate=request.getParameter("chkuptodate")==null?"":request.getParameter("chkuptodate");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<style>
.greenClass
{
	/* background-color: #ACF6CB; */
	background-color: #ADD8E6;
}
</style>
<script type="text/javascript">
var id='<%=id%>';
var detaildata;
if(id=="1"){
	detaildata='<%=jobdao.getDetailData(uptodate,id,branch,chkuptodate,fromdate,todate)%>';
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
                       	{name : 'pickuplocationid',type:'int'},
                       	{name : 'pickupaddress',type:'string'},
                       	{name : 'dropofflocation',type:'string'},
                       	{name : 'dropofflocationid',type:'int'},
                       	{name : 'dropoffaddress',type:'string'},
                       	{name : 'brand',type:'string'},
                       	{name : 'model',type:'string'},
                       	{name : 'nos',type:'string'},
                       	{name : 'brandid',type:'string'},
                       	{name : 'modelid',type:'string'},
						{name : 'groupname',type:'string'},
						{name : 'groupid',type:'string'},
                       	{name : 'transfertype',type:'string'},
                       	{name : 'loctype',type:'string'},
                       	{name : 'locrefno',type:'string'},
                       	{name : 'locrefname',type:'string'},
                       	{name : 'guestdetails',type:'string'},
                       	{name : 'pax',type:'string'},
                       	{name : 'vehdetails',type:'string'},
                       	{name : 'otherdetails',type:'string'},
                       	{name : 'tarifdocno',type:'string'},
                       	{name : 'estdistance',type:'number'},
                       	{name : 'esttime',type:'date'},
                       	{name : 'tarif',type:'number'},
                       	{name : 'exdistancerate',type:'number'},
                       	{name : 'extimerate',type:'number'},
                       	{name : 'chkothersrvc',type:'bool'},
                       	{name : 'btnappend',type:'string'},
                       	{name : 'gid',type:'string'},
                       	{name : 'tarifdetaildocno',type:'number'},
                       	{name : 'btnupdate',type:'string'},
                       	{name : 'detailupdate',type:'int'},
                       	{name : 'remarks',type:'string'},
                       	{name : 'drivername',type:'string'},
                       	{name : 'refno',type:'string'}
     				   ],
					localdata:detaildata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
		var cellclassname = function (row, column, value, data) {
        	if(parseInt(data.detailupdate)==1){
            	return "greenClass";
            }
        };
        $("#bookDetailGrid").on("bindingcomplete", function (event) {
        	// your code here.
        	$('#overlay,#PleaseWait').hide();
        }); 
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
               	filterable:true,
              	showfilterrow:true, 
               	selectionmode: 'checkbox',
		enabletooltips: true,
               	handlekeyboardnavigation: function (event) {
									
               	},
            
               
                columns: [
                       		{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '3%',cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
                            { text: 'Pickup date',datafield:'pickupdate',width:'5%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
                            { text: 'Pickup time',datafield:'pickuptime',width:'4%',cellsformat:'HH:mm',cellclassname: cellclassname},

							{ text: 'Other Details',datafield:'otherdetails',width:'10%',cellclassname: cellclassname},
							{ text: 'Vehicle Details',datafield:'vehdetails',width:'10%',cellclassname: cellclassname},
							{ text: 'Driver',datafield:'drivername',width:'8%',cellclassname: cellclassname},
							{ text: 'PAX',datafield:'pax',width:'2%',cellclassname: cellclassname,hidden:true},
							{ text: 'Group',datafield:'groupname',width:'8%',cellclassname: cellclassname},
							{ text: 'Remarks',datafield:'remarks',width:'10%',cellclassname: cellclassname},
							{ text: 'Pickup Address',datafield: 'pickupaddress',width:'10%',cellclassname: cellclassname},
							{ text: 'Dropoff Address',datafield:'dropoffaddress',width:'10%',cellclassname: cellclassname},
							{ text: 'Guest',datafield:'guest',width:'7%',hidden:true,cellclassname: cellclassname},
							{ text: 'Guest Details',datafield:'guestdetails',width:'10%',cellclassname: cellclassname},
							{ text: 'Client',  datafield: 'refname',width:'10%',cellclassname: cellclassname},
							

							{ text: 'Detail Docno',datafield:'detaildocno',width:'4%',hidden:true,cellclassname: cellclassname},
							{ text: 'Book Docno',datafield: 'bookdocno',width:'4%',hidden:false,cellclassname: cellclassname},

							{ text: 'Client ID',datafield:'cldocno',width:'4%',hidden:true,cellclassname: cellclassname},
							{ text: 'Guest ID',datafield:'guestno',width:'4%',hidden:true,cellclassname: cellclassname},
							{ text: 'Type',datafield:'type',width:'5%',cellclassname: cellclassname,hidden:true},
							{ text: 'Transfer Type',datafield:'transfertype',width:'7%',cellclassname: cellclassname,hidden:true},
							{ text: 'Loc. Type',datafield:'loctype',width:'7%',cellclassname: cellclassname,hidden:true},
							{ text: 'Loc. Ref No',datafield:'locrefno',width:'5%',cellclassname: cellclassname,hidden:true},
							{ text: 'Loc. Ref Name',datafield:'locrefname',width:'10%',cellclassname: cellclassname,hidden:true},
							{ text: 'Block Hrs',datafield:'blockhrs',width:'4.5%',cellclassname: cellclassname,hidden:true},
							{ text: 'Pickup Location',datafield:'pickuplocation',width:'10%',cellclassname: cellclassname},
							{ text: 'Pickup Location Id',datafield:'pickuplocationid',width:'10%',hidden:true,cellclassname: cellclassname},
							{ text: 'Dropoff Location',datafield:'dropofflocation',width:'10%',cellclassname: cellclassname},
							{ text: 'Dropoff Location Id',datafield:'dropofflocationid',width:'10%',hidden:true,cellclassname: cellclassname},
							{ text: 'Ref No',datafield:'refno',width:'8%',cellclassname: cellclassname},
							{ text: 'Job Name',datafield:'docname',width:'4.5%',cellclassname: cellclassname},
							{ text: 'Doc No', datafield: 'doc_no',width:'4%',hidden:true,cellclassname: cellclassname},
							{ text: 'Group Id',datafield:'groupid',width:'8%',cellclassname: cellclassname,hidden:true},
							{ text: 'Brand',datafield:'brand',width:'8%',cellclassname: cellclassname,hidden:true},
							{ text: 'Model',datafield:'model',width:'8%',cellclassname: cellclassname,hidden:true},
							{ text: 'Nos',datafield:'nos',width:'4%',cellclassname: cellclassname},
							{ text: 'Brandid',datafield:'brandid',width:'4%',hidden:true,cellclassname: cellclassname},
							{ text: 'Modelid',datafield:'modelid',width:'4%',hidden:true,cellclassname: cellclassname},
							{ text: 'Tarif Doc No', datafield: 'tarifdocno',width:'4%',cellclassname: cellclassname},
							{ text: 'Est.Distance', datafield: 'estdistance',width:'7%',cellsformat:'d2',hidden:true,cellclassname: cellclassname},
							{ text: 'Est.Time', datafield: 'esttime',width:'6%',cellsformat:'HH:mm',cellsalign:'right',hidden:true,cellclassname: cellclassname},
							{ text: 'Tarif', datafield: 'tarif',width:'6%',cellsformat:'d2',hidden:true,cellclassname: cellclassname},
							{ text: 'Ex.Distance Rate', datafield: 'exdistancerate',width:'6%',cellsformat:'d2',hidden:true,cellclassname: cellclassname},
							{ text: 'Ex.Time Rate', datafield: 'extimerate',width:'6%',hidden:true,cellclassname: cellclassname},
							{ text: '', datafield: 'btnappend',width:'5%',columntype: 'button',hidden:true,cellclassname: cellclassname},
							{ text: 'Update', datafield: 'btnupdate',width:'5%',columntype: 'button',cellclassname: cellclassname,hidden:true},
							{ text: '', datafield: 'gid',width:'5%',hidden:true,cellclassname: cellclassname},
							{ text: 'tarifdetaildocno', datafield: 'tarifdetaildocno',width:'5%',hidden:true,cellclassname: cellclassname},
							{ text: 'Detail Update', datafield: 'detailupdate',width:'5%',cellclassname: cellclassname,hidden:true},
							
         	              ]
           
            });
            
        });

            </script>
            <div id="bookDetailGrid"></div>
            <input type="hidden" name="gridrowindex" id="gridrowindex">