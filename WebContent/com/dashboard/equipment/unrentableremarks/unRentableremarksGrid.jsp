
<%@ page import="com.dashboard.vehicle.unrentableremarks.ClsUnrentableDAO" %>

<% ClsUnrentableDAO ctrd=new ClsUnrentableDAO();%>



 



 <%
           	String branchval = request.getParameter("branch")==null?"NA":request.getParameter("branch").trim();
 String relodestatus = request.getParameter("relodestatus")==null?"ALL":request.getParameter("relodestatus").trim();
// String RR="RR";
// System.out.println("---------"+descval);
           	  %> 
			             	  
<style type="text/css">

  .yellowClass
     {
        background-color: #A4A4A4; 
     }
</style>

<script type="text/javascript">
 var temp4='<%=branchval%>';
var ssss;
var unrentableexceldata;
var aa;
if(temp4!='NA')
{ 
	unrentableexceldata='<%=ctrd.searchUnrentableexcel(branchval,relodestatus)%>'; 
	ssss='<%=ctrd.searchUnrentable(branchval,relodestatus)%>'; 
	//alert(ssss);
aa=0;
datas='<%=ctrd.statussearch()%>';  

var lists = datas.split(",");
//alert(lists);
}
else
{
	
	ssss;
	unrentableexceldata;
	 aa=1;
	} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		{name : 'branchname' , type: 'string' },
                  		{name : 'st_desc' , type: 'string' },
						{name : 'loc_name', type: 'string'  },
						/* {name : 'branch', type: 'int'    }, */
						{name : 'brand_name', type: 'string'  },
						{name : 'fleet_no', type: 'string'  },
						{name : 'flname', type: 'string'  },
						{name : 'yom', type: 'string'  },
						{name : 'color', type: 'string'  },
						{name : 'reg_no', type: 'int'  },
						{name : 'cur_km', type: 'int'  },
						{name : 'srvc_km', type: 'int'  },
						{name : 'c_fuel', type: 'string'  },
						{name : 'c_fuel', type: 'string'  },
						{name : 'cstatus', type: 'string'  },
						{name : 'gname', type: 'string'  },
						{name : 'vrent', type: 'string'  },
						{name : 'renttype', type: 'string'  },
						{name : 'brhid',type: 'String'},
						{name : 'idledays',type :'int'},
						{name : 'doc_no',type:'number'},
						{name :  'din',type:'date'},
						{name : 'tin',type:'date'},
						{name : 'ofleetno',type:'string'},
						{name : 'remarks',type:'string'},
						{name : 'movdocno',type:'string'},
						{name : 'btnsave',type:'string'}
						],
				    localdata: ssss,
        
        
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
    
      var cellclassname =  function (row, column, value, data) {
    	    
    	var ofleet_no=$('#unRentableGrid').jqxGrid('getcellvalue', row, "ofleetno");
    		          
    	if(parseInt(ofleet_no)>0)
        	  {
        	  return "yellowClass";
        	  }
    		   
    }
    
    $("#unRentableGrid").jqxGrid(
    {
        width: '98%',
        height: 495,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        columnsresize: true,
        editable :true,
        sortable:true,
        selectionmode: 'singlecell',
        pagermode: 'default',
		showfilterrow: true, 

        columns: [
						{ text: 'Org Fleet No', datafield: 'ofleetno', width: '8%'  ,hidden:true,editable:false}, 
						{ text: 'Avail. Br', datafield: 'branchname', width: '10%',cellclassname: cellclassname ,editable:false },
						{ text: 'Location', datafield: 'loc_name', width: '8%',cellclassname: cellclassname ,editable:false},
						{ text: 'Group', datafield: 'gname', width: '8%',cellclassname: cellclassname  ,editable:false},
						{ text: 'Brand', datafield: 'brand_name', width: '12%' ,cellclassname: cellclassname ,editable:false},
						{ text: 'Fleet', datafield: 'fleet_no', width: '5%' ,cellclassname: cellclassname  ,editable:false},
						{ text: 'Fleet Name', datafield: 'flname', width: '17%',cellclassname: cellclassname  ,editable:false},
						{ text: 'Current Status', datafield: 'cstatus', width: '18%',cellclassname: cellclassname  ,editable:false},
						{ text: 'Status',  datafield: 'st_desc',  width: '18%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
		                       editor.jqxDropDownList({autoDropDownHeight: false,  enableBrowserBoundsDetection:true,source: lists });
		                        
							
							}
						 ,cellbeginedit: function (row) {
								var temp=$('#unRentableGrid').jqxGrid('getcellvalue', row, "st_desc");
							     if (parseInt(temp) ==1)
							    	 {
								       return false;
									 }
							    
							    	
							    	 
							  } 
						},
						{ text: 'Remarks', datafield: 'remarks', width: '17%',cellclassname: cellclassname,editable:true },
						{ text: 'Action', datafield: 'btnsave', width: '5%',columntype:'button',editable:false},
						{ text: 'YOM', datafield: 'yom', width: '4%',cellclassname: cellclassname  ,editable:false},
						{ text: 'Color', datafield: 'color', width: '5%' ,cellclassname: cellclassname   ,editable:false},
						{ text: 'Asset id', datafield: 'reg_no', width: '6%',cellclassname: cellclassname    ,editable:false},
						{ text: 'Cur. KM', datafield: 'cur_km', width: '7%' ,cellclassname: cellclassname  ,editable:false},
						{ text: 'Due Serv. KM', datafield: 'srvc_km', width: '7%',cellclassname: cellclassname  ,editable:false},
						{ text: 'Fuel', datafield: 'c_fuel', width: '6%' ,cellclassname: cellclassname  ,editable:false},
						{ text: 'Rent Type', datafield: 'renttype', width: '5%' ,cellclassname: cellclassname ,editable:false},
						{ text: 'BranchId', datafield: 'brhid', width: '5%',hidden:true ,editable:false},
						{ text: 'Idle Days', datafield: 'idledays', width: '5%',cellclassname: cellclassname ,editable:false},
						{ text: 'Doc No', datafield: 'doc_no', width: '5%',hidden:true,editable:false},
						{ text: 'Date In', datafield: 'din', width: '5%',hidden:true,cellsformat:'dd.MM.yyyy',editable:false},
						{ text: 'tin', datafield: 'tin', width: '5%',hidden:true,cellsformat:'HH:mm',editable:false},
						{ text: 'Mov Docno', datafield: 'movdocno', width: '5%',hidden:true,editable:false}
						
						]
    
    });
    
    if(aa==1)
    	{
    	 $("#unRentableGrid").jqxGrid('addrow', null, {});
    	}
    

         var rows = $('#unRentableGrid').jqxGrid('getrows');
	     if(rows.length==0){
	    	 $("#unRentableGrid").jqxGrid('addrow', null, {});
	     }
	     $('#unRentableGrid').on('rowdoubleclick', function (event) {
         	var rowindex1=event.args.rowindex;
			//document.getElementById("temprow").value=         	
         	document.getElementById("fleetno").value=$('#unRentableGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no"); 
				document.getElementById("hidbranch").value=$('#unRentableGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
				document.getElementById("btnUpdate").disabled=false;
				document.getElementById("btnattach").disabled=false;
				document.getElementById("btnmove").disabled=false;
				document.getElementById("hidstatus").value=$('#unRentableGrid').jqxGrid('getcellvalue', rowindex1, "st_desc");
				document.getElementById("docno").value=$('#unRentableGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
				$("#hiddate").jqxDateTimeInput('val',$("#unRentableGrid").jqxGrid('getcellvalue', rowindex1, "din"));
				$("#hidtime").jqxDateTimeInput('val',$("#unRentableGrid").jqxGrid('getcellvalue', rowindex1, "tin"));
				$("#fleetdate").jqxDateTimeInput('val',$("#unRentableGrid").jqxGrid('getcellvalue', rowindex1, "din"));
			    $("#fleettime").jqxDateTimeInput('val',$("#unRentableGrid").jqxGrid('getcellvalue', rowindex1, "tin"));
				document.getElementById("cmbstatus").value="";
	     });
	     //document.getElementById("txttotalvehicles").value=rowscounts;
	     
	     $("#unRentableGrid").on("cellclick", function (event) 
	    		 {
	    		     // event arguments.
	    		     var args = event.args;
	    		     // row's bound index.
	    		     var rowBoundIndex = args.rowindex;
	    		     // row's visible index.
	    		     var rowVisibleIndex = args.visibleindex;
	    		     // right click.
	    		     var rightclick = args.rightclick; 
	    		     // original event.
	    		     var ev = args.originalEvent;
	    		     // column index.
	    		     var columnindex = args.columnindex;
	    		     // column data field.
	    		     var dataField = args.datafield;
	    		     // cell value
	    		     var value = args.value;
	    		     
	    		     if(dataField=="btnsave"){
	    		    	 $.messager.confirm('Message', 'Do you want to Save', function(r){					     	  
			  				       
		 			        	if(r==false)
		 			        	  {
		 			        		return false; 
		 			        	  }
		 			        	else {
	    		    	 var movdocno=$('#unRentableGrid').jqxGrid('getcellvalue',rowBoundIndex,'movdocno');
	    		    	 var fleetno=$('#unRentableGrid').jqxGrid('getcellvalue',rowBoundIndex,'fleet_no');
	    		    	 var remarks=$('#unRentableGrid').jqxGrid('getcellvalue',rowBoundIndex,'remarks');
	    		    	 var gridstatus=$('#unRentableGrid').jqxGrid('getcellvalue',rowBoundIndex,'st_desc');

							if(typeof(gridstatus)=="undefined"|| gridstatus=="" || gridstatus=="undefined"){
					    		    	  $.messager.alert('warning','Select a Status ');
				    		    		 return false;   		    		 
				    		    	 }
				    		    	 if(remarks!=""){
					    		    	 funUpdateRemarks(movdocno,fleetno,remarks,gridstatus);	    		    		 
				    		    	 }
				    		    	 else{
				    		    		 $.messager.alert('warning','Remarks cannot be empty');
				    		    		 return false;
				    		    	 }
		 			     		 }
		    		    	});  
	    		    	/*  if(remarks!=""){
	    		    		 
		    		    	 funUpdateRemarks(movdocno,fleetno,remarks,gridstatus);	    		    		 
	    		    	 }
	    		    	 else{
	    		    		 $.messager.alert('warning','Remarks cannot be empty');
	    		    		 return false;
	    		    	 } */
	    		     }
	    		     
	    		 });  
});

	function funUpdateRemarks(movdocno,fleetno,remarks,gridstatus){
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				if(items.trim()=="1"){
						   $.messager.alert('Message',"Successfully Saved");
							
						   funreload(this);
						   var barchval = document.getElementById("cmbbranch").value;
						   $("#fleetdiv").load("unRentableremarksGrid.jsp?branch="+barchval);
						  
				}
					else{
						$.messager.alert('Message',"Not Saved");
							
					}

			} else {
			}
		}
		x.open("GET", "updateRemarks.jsp?movdocno="+movdocno+"&fleetno="+fleetno+"&gridstatus="+gridstatus+"&remarks="+remarks.replace(/ /g, "%20"), true);
		x.send();
	}
	
</script>
<div id="unRentableGrid"></div>
<input type="hidden" name="hidbranch" id="hidbranch">
<input type="hidden" name="temprow" id="temprow">