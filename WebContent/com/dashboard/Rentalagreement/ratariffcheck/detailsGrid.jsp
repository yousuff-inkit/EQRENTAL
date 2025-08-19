<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
 <%

   String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String cldocno = request.getParameter("cldocno")==null?"NA":request.getParameter("cldocno").trim();

  	
  	String status = request.getParameter("status")==null?"NA":request.getParameter("status").trim();

  	String fleet = request.getParameter("fleet")==null?"NA":request.getParameter("fleet").trim();

  	String group = request.getParameter("group")==null?"NA":request.getParameter("group").trim();
  	String brand = request.getParameter("brand")==null?"NA":request.getParameter("brand").trim();
  	String model = request.getParameter("model")==null?"NA":request.getParameter("model").trim();

  	String type = request.getParameter("type")==null?"NA":request.getParameter("type").trim();
  	String outchk = request.getParameter("outchk")==null?"NA":request.getParameter("outchk").trim();
  	String inchk = request.getParameter("inchk")==null?"NA":request.getParameter("inchk").trim();
  	
 	String catid = request.getParameter("catid")==null?"NA":request.getParameter("catid").trim(); 
 	String salesman = request.getParameter("salesman")==null?"NA":request.getParameter("salesman").trim();
 	String ragent = request.getParameter("ragent")==null?"NA":request.getParameter("ragent").trim();
 	ClsrentalagreementDAO crad=new ClsrentalagreementDAO();
  	
 %> 
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var datasssss;
 var dataildata;
 var exceldata;
 var aa;
  if(temp4!='NA')
 { 	 
	  datasssss='<%=crad.tariffCheckGrid(barchval,fromdate,todate,cldocno,status,fleet,group,brand,model,type,outchk,inchk,catid,salesman,ragent)%>'
	  exceldata='<%=crad.tariffCheckExcel(barchval,fromdate,todate,cldocno,status,fleet,group,brand,model,type,outchk,inchk,catid,salesman,ragent)%>'
	  
	  aa=0;
 }
  
  else
	  {
	  datasssss;
	  exceldata;
	  aa=1;
	  }
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'doc_no', type: 'String'  },   //this is the agreement
     						{name : 'refname', type: 'String'},
     						{name : 'cldocno', type: 'number'},
     						{name : 'fleet_no', type: 'String'}, 
     						{name : 'vehdetails', type: 'String'}, 
     						{name : 'cldocno', type: 'String'  },
     						{name : 'odate', type: 'date'  },
     						{name : 'otime', type: 'String'  },
     						{name : 'rentaltype', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						{name : 'contactperson', type: 'String'  },
     						{name : 'brhid', type: 'string'  },
     						{name : 'reg_no', type: 'string'  },
     						{name : 'rent', type: 'number'  },
     						{name : 'cdw', type: 'number'  },
     						{name : 'refnos', type: 'string'  },
							{name : 'sal_name', type: 'string'  },
							
							{name : 'rentalagent', type: 'string'  },
							{name : 'branchname', type: 'string'  },
     						{name : 'trent', type: 'number'  },
     						{name : 'tcdw', type: 'number'  },
     						{name : 'tother', type: 'number'  },
     						{name : 'drent', type: 'number'  },
     						{name : 'dcdw', type: 'number'  },
     						{name : 'dother', type: 'number'  },
     						{name : 'arent', type: 'number'  },
     						{name : 'acdw', type: 'number'  },
     						{name : 'aother', type: 'number'  },
                          	],
                          	localdata: datasssss, 
                          	       
          
				
                
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
            	
            	
            	width: '100%',
                height: 500,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
			         columns: [
			                   { text: 'SL#', sortable: false, filterable: false, editable: false,   
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							{ text: 'RA NO', datafield: 'doc_no', width: '6%' },   //voc no
							{ text: 'Branch', datafield: 'branchname', width: '12%' },							
							{ text: 'Fleet', datafield: 'fleet_no', width: '4%' },
							{ text: 'Fleet Name', datafield: 'vehdetails', width: '14%'},
							{ text: 'Reg NO', datafield: 'reg_no', width: '5%' },
							{ text: 'Client Name', datafield: 'refname', width: '18%' },
							{ text: 'Rental Type', datafield: 'rentaltype', width: '6%' },
							{ text: 'Out Date', datafield: 'odate', width: '6%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Out Time', datafield: 'otime', width: '5%' }, 
							{ text: 'Salesman', datafield: 'sal_name', width: '15%'},
							{ text: 'Rental Agent', datafield: 'rentalagent', width: '15%'},
							
							{ text: 'Tariff Rent', datafield: 'trent', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Tariff CDW', datafield: 'tcdw', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Tariff Other', datafield: 'tother', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2'},
							
							{ text: 'Discount Rent', datafield: 'drent', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Discount CDW', datafield: 'dcdw', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Discount Other', datafield: 'dother', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2'},
							
							{ text: 'Agreed Rent', datafield: 'arent', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Agreed CDW', datafield: 'acdw', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Agreed Other', datafield: 'aother', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2'},
							
						    { text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
					
								
								
							// regno contract,fleetno contract
					
					]
            });
            $("#overlay, #PleaseWait").hide(); 
       
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>