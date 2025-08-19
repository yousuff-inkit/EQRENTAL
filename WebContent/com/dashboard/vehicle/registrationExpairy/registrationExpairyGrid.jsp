<%@ page import="com.dashboard.vehicle.regexpiry.*" %>
<% ClsRegExpiryDAO regexpirydao=new ClsRegExpiryDAO();%>
<% String contextPath=request.getContextPath();%>
<%
	String branch = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
    String expdate = request.getParameter("exdate")==null?"0":request.getParameter("exdate").trim();
    String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
    String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    String cldocno = request.getParameter("cldocno")==null?"":request.getParameter("cldocno").trim();
%> 
           	  
           	  
           	  
   <!-- <style type="text/css">
        .redClass
        {
           font-size:15px; 
            background-color: #FFEBEB;
        }
        
        
   
        </style>     -->    	  
<script type="text/javascript">
 var temp4='<%=branch%>';
var expdata;
var id='<%=id%>';
 if(temp4!='NA' && id=="1")
{ 
	expdata='<%=regexpirydao.getRegExpiryData(branch, expdate, fromdate, id, cldocno)%>'; 
} 
else
{ 
	expdata=[];
}  
$(document).ready(function () {
   
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     {name : 'fleet_no', type: 'String'  },
						{name : 'flname', type: 'String'  },
						 {name : 'reg_no', type: 'String'  }, 
						{name : 'reg_exp', type: 'date'  },
						 {name : 'reg_date', type: 'date'  }, 
						{name : 'gname', type: 'String'  },
						{name : 'model', type: 'String'  },
						{name : 'color', type: 'String'  },
						
						{name : 'brand_name', type: 'String'},
		        		{name : 'rem', type: 'string'  },
						{name : 'pno', type: 'string'  },
						
						{name : 'ex_date', type: 'date'  },
						{name : 'btnsave', type: 'String'  },
					
						{name : 'docno', type: 'String'  },
						{name : 'brhid', type: 'String'  },
						{name : 'attachbtn', type: 'String'  },
						{name : 'yearom', type: 'String'  },
						{name : 'platecode', type: 'String'  },
						{name : 'currentkm', type: 'String'  },
						{name : 'cldocno',type:'string'},
						{name : 'refname',type:'string'},
						{name : 'agmtno',type:'string'},
						{name : 'agmttype',type:'string'}
						
						],
				    localdata: expdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#regexpgrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
//    	$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
    	});

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#regexpgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
	showfilterrow: true,
        sortable:true,
        selectionmode: 'singlecell',
        pagermode: 'default',
        editable:true,
        columns: [   

					
				    { text: 'Fleet NO', datafield: 'fleet_no', editable:false, width: '5%' },
				    { text: 'Reg.NO', datafield: 'reg_no', editable:false, width: '5%' },
				    { text: 'Plate Code',datafield: 'platecode',editable:false, width: '10%' },
				    { text: 'Fleet Name',datafield: 'flname',editable:false, width: '14%' },
				    { text: 'Client #', datafield: 'cldocno', editable:false, width: '5%' },
					{ text: 'Client Name', datafield: 'refname', editable:false, width: '12%' },
					{ text: 'Agmt No',datafield: 'agmtno',editable:false, width: '6%' },
					{ text: 'Agmt Type',datafield: 'agmttype',editable:false, width: '5%' },
					{ text: 'Tariff Group', datafield: 'gname', editable:false,width: '6%' },
					{ text: 'Brand',datafield: 'brand_name', editable:false,width: '8%' },
					{ text: 'Model',datafield: 'model',editable:false, width: '8%' },
					{ text: 'Year', datafield: 'yearom',editable:false, width: '4%'},
					{ text: 'Current KM', datafield: 'currentkm',editable:false, width: '6%'},
					{ text: 'Reg_Date', datafield: 'reg_date',editable:false, width: '6%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Reg_Exp', datafield: 'reg_exp', width: '6%',editable:false,cellsformat:'dd.MM.yyyy'},
					{ text: 'Extended Date', datafield: 'ex_date', width: '9%',editable:true,columntype: 'datetimeinput',cellsformat:'dd.MM.yyyy',
						cellbeginedit: function (row) {
							var temp=$('#regexpgrid').jqxGrid('getcellvalue', row, "btnsave");
							if (temp =="Edit")
								return false;
						}
					},
					{ text: 'Remarks', datafield: 'rem', width: '21%',editable:true,
						cellbeginedit: function (row) {
							var temp=$('#regexpgrid').jqxGrid('getcellvalue', row, "btnsave");
							if (temp =="Edit")
								return false;
						}
					},
					{ text: ' ', datafield: 'attachbtn', width: '6%',columntype: 'button',editable:false, filterable: false},
					{ text: ' ', datafield: 'btnsave', width: '6%',columntype: 'button',editable:false, filterable: false},
					{ text: 'docno', datafield: 'docno', width: '6%',hidden:true},
					{ text: 'brhid', datafield: 'brhid', width: '6%',hidden:true},
					
					
					
					]
   
    });

 
     $("#regexpgrid").on('cellclick', function (event) 
    		{
    		 
    		    var datafield = event.args.datafield;

    		    var rowBoundIndex = args.rowindex;
    		    var columnindex = args.columnindex;
  			  
    		  
       		 
  			  if(columnindex>7)
  				  {
  				  if(columnindex!=10 && columnindex!=11)
  					  {
  				  if($('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Edit"){
  					  
  					  
  					 $.messager.alert('Message',' Click Edit Button ','warning');   
 		        	 
  					
  					
  				            }
  				  
  					  }
  				  
  				  
  				  }
  			  
  			 if(datafield=="attachbtn"){
            	
            		 
            		 document.getElementById("docnoss").value=$('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "docno");
            		 
            		 document.getElementById("brh").value=$('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
            		 
            		
            		 funAttachBtn();
            		 
            		 
  			 }
  			  
    		    
              if(datafield=="btnsave"){
            	 if($('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save"){
            		
            		 var regexpdate= $('#regexpgrid').jqxGrid('getcelltext', rowBoundIndex, "reg_exp");
            		 var fleetno= $('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "fleet_no");
            		
            		 var exdate= $('#regexpgrid').jqxGrid('getcelltext', rowBoundIndex, "ex_date");
            		 var renval=$('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "rem");
            		
            	 	 
            		 var docno=$('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "docno");
            		 
            		 var brnchid=$('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
            		 
            		
            		 if(exdate==null||typeof(exdate)=="undefined")
            		 {
            			
            			 $.messager.alert('Message','Enter Extended Date','warning');   
                        
            				return false; 
            			
            		 }
            		 if(renval==""||typeof(renval)=="undefined")
            		 {
            			 
                          
            			 $.messager.alert('Message',' Enter Remarks','warning');   
            			 
            			
            			  
            				return false; 
            		
            		 }  
            		 var nmax = renval.length;
            		
            		
     		           if(nmax>39)
     		        	   {
     		        	  $.messager.alert('Message',' Remarks cannot contain more than 40 characters ','warning');   
     		        	
             				return false; 
     		        	   
     		        	 
     		        	 
     		        	   } 
     		           
     		           
     		          $.messager.confirm('Message', 'Do you want to save changes?', function(r){
     		        	  
     		       
     		        	if(r==false)
     		        	  {
     		        		return false; 
     		        	  }
     		        	else{
     		        	 savegriddata(exdate,renval,fleetno,regexpdate,docno,brnchid);
     		        	}
     			     });
     		 	  
            	 }
            	 else {
            	
            	  $('#regexpgrid').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
            	 }
              }
    		   
    		}); 

   

    
});



function funAttachBtn(){
	
	  $("#windowattach").jqxWindow('setTitle',"VEH - "+document.getElementById("docnoss").value);
		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=VEH&docno="+document.getElementById("docnoss").value+"&barchvals="+document.getElementById("brh").value);		
	
}



function savegriddata(exdate,renval,fleetno,regexpdate,docno,brnchid)
{

	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
		
		 	var items= x.responseText;
		 	
		
		 	 $.messager.alert('Message', 'Record successfully Updated ', function(r){
				     
			     });
		 	funreload(event);
			
		 	 
    }
	}
     x.open("GET","saveGriddate.jsp?exdate="+exdate+"&remarks="+renval+"&fleetno="+fleetno+"&regexpdate="+regexpdate+"&docno="+docno+"&brnchid="+brnchid,true);
    x.send();
   
  
}
</script>

<input type="hidden" id="docnoss">
<input type="hidden" id="brh">

<div id="regexpgrid"></div>