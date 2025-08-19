<%@page import="com.operations.marketing.rentalquote.*" %>
<%ClsRentalQuoteDAO cvd=new ClsRentalQuoteDAO(); %>

<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String fleetname=request.getParameter("fleetname")==null?"0":request.getParameter("fleetname");
 String fleetno=request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
 String regno = request.getParameter("regno")==null?"0":request.getParameter("regno");
 String date = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
 String id=request.getParameter("id")==null?"0":request.getParameter("id");
 String engine=request.getParameter("engine")==null?"0":request.getParameter("engine");
 String chassis=request.getParameter("chassis")==null?"0":request.getParameter("chassis");
%> 
 <script type="text/javascript">
var temp='<%=id%>';
var loaddata=[];
if(temp==1){
	loaddata='<%=cvd.getEquipData(docno,fleetname,fleetno,regno,date,session,engine,chassis,id)%>';
} 
               
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                       
                         	
							{name : 'doc_no' , type: 'string' },
							{name : 'date' , type:'date'},
							{name : 'fleet_no' , type: 'String' },
     						{name : 'flname', type: 'String'  },
     						{name : 'reg_no', type: 'String'  },
     						{name : 'engine', type: 'String'  },
     						{name : 'chassis', type: 'String'  },
     						{name : 'grpid', type: 'String'  },
     						{name : 'code', type: 'String'  },
     						{name : 'subcatid', type: 'String'  },
     						
      					
      						
      	      						
                          	],
                          	localdata: loaddata,
                          
          
				
                
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
            $("#equipSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,

                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
				
				{ text: 'Doc No', datafield: 'doc_no', width: '10%'},
				{ text: 'Date',  datafield: 'date',  width: '10%',cellsformat:'dd.MM.yyyy'},
				{ text: 'Equip.No',datafield: 'fleet_no', width: '10%' },
				{ text: 'Equip.Name', datafield: 'flname', width: '30%' },
				{ text: 'Engine No', datafield: 'engine', width: '15%' },
				{ text: 'Chassis No', datafield: 'chassis', width: '15%' },
				{ text: 'Asset id', datafield: 'reg_no', width: '10%' },
				{ text: 'Grp Id', datafield: 'grpid', width: '10%',hidden:true },
				{ text: 'Code', datafield: 'code', width: '10%',hidden:true },
				{ text: 'Code Id', datafield: 'subcatid', width: '10%',hidden:true }		 
			
								
					
					]
            });
    
      
				            
			$('#equipSearchGrid').on('rowdoubleclick', function (event) 
			{ 
				var rowindex=event.args.rowindex;
				var gridindex=$('#gridindex').val();
				$('#rentalContractGrid').jqxGrid('setcellvalue',gridindex,'code',$('#equipSearchGrid').jqxGrid('getcellvalue',rowindex,'code'));
				$('#rentalContractGrid').jqxGrid('setcellvalue',gridindex,'subcatid',$('#equipSearchGrid').jqxGrid('getcellvalue',rowindex,'subcatid'));
				$('#rentalContractGrid').jqxGrid('setcellvalue',gridindex,'fleet_no',$('#equipSearchGrid').jqxGrid('getcellvalue',rowindex,'fleet_no'));
				$('#rentalContractGrid').jqxGrid('setcellvalue',gridindex,'flname',$('#equipSearchGrid').jqxGrid('getcellvalue',rowindex,'flname'));
				$('#rentalContractGrid').jqxGrid('setcellvalue',gridindex,'grpid',$('#equipSearchGrid').jqxGrid('getcellvalue',rowindex,'grpid'));
				$('#rentalContractGrid').jqxGrid('addrow',null,{});
				$('#rentalContractGrid').jqxGrid('selectrow', gridindex);
				$('#equipwindow').jqxWindow('close');
			});	 
		}); 
				       
                       
    </script>
    <div id="equipSearchGrid"></div>
    
