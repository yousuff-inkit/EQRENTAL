<%@page import="com.workshop.gateinpass.*" %>
<%ClsGateInPassDAO gatedao=new ClsGateInPassDAO();%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
String Driver = request.getParameter("Driver")==null?"0":request.getParameter("Driver");
String date = request.getParameter("date")==null?"0":request.getParameter("date");
String regno = request.getParameter("regno")==null?"0":request.getParameter("regno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%> 

<script type="text/javascript">

var searchdata; 
var id='<%=id%>';

$(document).ready(function () { 
		 
		searchdata='<%=gatedao.getSearchData(session,msdocno,fleetno,Driver,date,regno,id)%>';

      var source =
     {
         datatype: "json",
         datafields: [
                {name : 'doc_no',type:'number'},
                {name : 'branchname',type:'string'},
                {name : 'drivermobile',type:'string'},
				{name : 'date',type:'date'},
                {name : 'fleet_no', type: 'number'  },
				{name : 'fleetdetails', type: 'string'   },
				{name : 'chkdriver',type:'string'},
				{name : 'hiddriver',type:'string'},
				{name : 'driver',type:'string'},
				{name : 'indate',type:'date'},
				{name : 'intime',type:'string'},
     			{name : 'inkm',type:'number'},
     			{name : 'infuel',type:'string'},
     			{name : 'remarks',type:'string'},
     			{name : 'serviceduekm',type:'number'},
     			{name : 'agmtno',type:'number'},
     			{name : 'cldocno',type:'number'},
     			{name : 'clientdetails',type:'string'},
     			{name : 'reg_no',type:'string'}
				
          ],
          localdata: searchdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
                                 
     };
     
     var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
    			loadComplete: function () {
            		 /* $("#loadingImage").css("display", "none");  */
        		},
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
	            
            }		
    );


            
            
            $("#searchGrid").jqxGrid(
            {
            	
            	 width: '100%',
                 height: 280,
                 source: dataAdapter,
                 columnsresize: true,
                 altRows: true,
                 selectionmode: 'singlerow',
                 pagermode: 'default',
                //Add row method
                
                handlekeyboardnavigation: function (event) {
                    /* var cell = $('#jqxSpecification').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'DESCRIPTION' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxSpecification").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                    
                },
                
                       
                columns: [
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '7%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							     return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							  					}    
							},
                            { text:'Doc No',datafield:'doc_no',width:'10%'},
                            { text:'Date',datafield:'date',cellsformat:'dd.MM.yyyy',width:'10%'},
                            { text:'Branch',datafield:'branchname',width:'20%',hidden:true},
                            { text:'Fleet No',datafield:'fleet_no',width:'10%'},
                            { text:'Asset id',datafield:'reg_no',width:'10%'},
                            { text:'Fleet Details',datafield:'fleetdetails',width:'10%',hidden:true},
                            { text:'Driver',datafield:'driver',width:'35%'},
                            { text:'New Driver',datafield:'chkdriver',width:'10%',hidden:true},
                            { text:'Driver Id',datafield:'hiddriver',width:'10%',hidden:true},
                            { text:'In Date',datafield:'indate',width:'10%',cellsformat:'dd.MM.yyyy',hidden:true},
                            { text:'In Time',datafield:'intime',width:'10%',hidden:true},
                            { text:'In Km',datafield:'inkm',width:'10%',hidden:true,cellsformat:'d2'},
                            { text:'In Fuel',datafield:'infuel',width:'10%',hidden:true},
                            { text:'Remarks',datafield:'remarks',width:'10%',hidden:true},
                            { text:'service due km',datafield:'serviceduekm',width:'10%',hidden:true},
                            { text:'Agmtno',datafield:'agmtno',hidden:true},
                            { text:'Cldocno',datafield:'cldocno',hidden:true},
                            { text:'Client Details',datafield:'clientdetails',hidden:true},
                            { text:'Driver Mobile',datafield:'drivermobile',width:'18%'}
							
			              ]
            });
            
            $("#searchGrid").on("rowdoubleclick", function (event) {
                var rowindex=event.args.rowindex;
                $('#date').jqxDateTimeInput('val',$('#searchGrid').jqxGrid('getcellvalue',rowindex,'date'));
                $('#drivernumber').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'drivermobile'));
                $('#docno').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'doc_no'));
                $('#fleetno').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'fleet_no'));
                $('#fleetdetails').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'fleetdetails'));
                $('#hiddriver').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'hiddriver'));
                $('#driver').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'driver'));
                $('#hidchkdriver').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'chkdriver'));
                $('#remarks').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'remarks'));
                $('#serviceduekm').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'serviceduekm'));
                $('#indate').jqxDateTimeInput('val',$('#searchGrid').jqxGrid('getcellvalue',rowindex,'indate'));
                $('#intime').jqxDateTimeInput('val',$('#searchGrid').jqxGrid('getcellvalue',rowindex,'intime'));
                $('#inkm').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'inkm'));
                $('#cmbinfuel').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'infuel'));
                $('#agmtno').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'agmtno'));
                $('#cldocno').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'cldocno'));
                $('#clientdetails').val($('#searchGrid').jqxGrid('getcellvalue',rowindex,'clientdetails'));
                if($('#agmtno').val()!='' && $('#agmtno').val()!='0'){
                	$('#agmtexist').val('1');
                }
                else{
                	$('#agmtexist').val('0');
                }
                
            	setValues(); 
            	$("#searchGrid").jqxGrid('clear');

            	$('#window').jqxWindow('close');
            	
            });
            
        });

    </script>
    <div id="searchGrid"></div>