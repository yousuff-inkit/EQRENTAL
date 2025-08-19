<%@page import="com.equipment.equipcontractclose.*" %>
<%ClsEquipContractCloseDAO cvd=new ClsEquipContractCloseDAO(); %>

 <%
 String contractno = request.getParameter("contractno")==null?"":request.getParameter("contractno");
 String hiremode = request.getParameter("hiremode")==null?"":request.getParameter("hiremode");
 String id=request.getParameter("id")==null?"0":request.getParameter("id");
 String quoteno=request.getParameter("quoteno")==null?"":request.getParameter("quoteno");
 String contractdate=request.getParameter("contractdate")==null?"":request.getParameter("contractdate");
 String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
 String assetid=request.getParameter("assetid")==null?"":request.getParameter("assetid");
 
%> 
 <script type="text/javascript">
var temp='<%=id%>';
var contractsearchdata=[];
if(temp==1){
	contractsearchdata='<%=cvd.getContractSearchData(contractno,hiremode,quoteno,contractdate,clientname,assetid,id,session)%>';
} 
               
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                       
                         	
							{name : 'doc_no' , type: 'string' },
							{name : 'voc_no' , type: 'string' },
							{name : 'date' , type:'date'},
							{name : 'quotedocno' , type: 'String' },
     						{name : 'quotevocno', type: 'String'  },
     						{name : 'hiremode',type:'string'},
     						{name : 'refname',type:'string'},
     						{name : 'contractdesc',type:'string'},
     						{name : 'assetid',type:'string'},
                          	],
                          	localdata: contractsearchdata,
                          
          
				
                
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
            $("#contractSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,

                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
				
				{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true},
				{ text: 'Doc No', datafield: 'voc_no', width: '10%'},
				{ text: 'Date',  datafield: 'date',  width: '10%',cellsformat:'dd.MM.yyyy'},
				{ text: 'Quote No', datafield: 'quotedocno', width: '10%',hidden:true},
				{ text: 'Quote No', datafield: 'quotevocno', width: '10%'},
				{ text: 'Client Name', datafield: 'refname'},
				{ text: 'Asset Id', datafield: 'assetid',width:'8%'},
				{ text: 'Hire Mode', datafield: 'hiremode',width:'8%'},
				{ text: 'Contract Description', datafield: 'contractdesc',width:'8%',hidden:true},				
					
					]
            });
    
      
				            
			$('#contractSearchGrid').on('rowdoubleclick', function (event) 
			{ 
				var rowindex=event.args.rowindex;
				$('#contractvocno').val($('#contractSearchGrid').jqxGrid('getcellvalue',rowindex,'voc_no'));
				$('#contractdocno').val($('#contractSearchGrid').jqxGrid('getcellvalue',rowindex,'doc_no'));
				$('#contractdetails').val($('#contractSearchGrid').jqxGrid('getcellvalue',rowindex,'refname'));
				
				var contractdocno=$('#contractdocno').val();
				$('#rentalcontractgriddiv').load('rentalContractGrid.jsp?id=2&contractdocno='+contractdocno);
				$('#contractwindow').jqxWindow('close');
			});	 
		}); 
				       
                       
    </script>
    <div id="contractSearchGrid"></div>
    
