<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
<%@page import="com.sales.Sales.salesInvoiceReturn.ClsSalesInvoiceReturnDAO"%>
<%ClsSalesInvoiceReturnDAO DAO= new ClsSalesInvoiceReturnDAO();%>

<% 
String qotdoc=request.getParameter("qotdoc")==null?"0":request.getParameter("qotdoc").trim();

String enqdoc=request.getParameter("enqdoc")==null?"0":request.getParameter("enqdoc").trim();

String chk=request.getParameter("chk")==null?"NA":request.getParameter("chk").trim();

String cond=request.getParameter("cond")==null?"0":request.getParameter("cond").trim();

String from=request.getParameter("from")==null?"0":request.getParameter("from").trim();

String reftype=request.getParameter("reftype")==null?"NA":request.getParameter("reftype").trim();

String enqmasterdocno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();


String locaid=request.getParameter("locaid")==null?"0":request.getParameter("locaid").trim();

//System.out.println("==reftype==="+reftype);
%>

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

<script type="text/javascript">
var qotgriddata;
$(document).ready(function () {
	//chkfoc();
	//chktax();
	//chkbrand();
var temp2='<%=enqdoc%>';
var temp='<%=qotdoc%>';
var cond='<%=cond%>';

<%--  if(temp2>0 && cond=="0")
{

	qotgriddata='<%=DAO.qotgridreload(enqdoc,reftype)%>';  
 
}

  else --%> if(cond=="1")
 {
	 
 	qotgriddata='<%=DAO.prdGridReload(session,enqdoc,reftype,locaid)%>';  

 }
 else if(temp>0  && cond=="2")
{
	
	qotgriddata='<%=DAO.prdGridReload(session,qotdoc,enqdoc,reftype,locaid)%>';  

} 
 
else
 
{   
	qotgriddata;

 } 
             

 
 var rendererstring2=function (aggregates){
  	var value=aggregates['sum2'];
  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
  }    



	  var rendererstring1=function (aggregates){
    	var value=aggregates['sum1'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
    }
	  
	  var cellclassname = function (row, column, value, data) {
    		if (data.qty==0) {
    			document.getElementById("errormsg").innetText="Quantity Should not Be Zero";
                return "redClass";
            }
    		else{
    			//document.getElementById("errormsg").innetText="";
    		}
    		
    		  var ss= $('#jqxInvoiceReturn').jqxGrid('getcellvalue', row, "qty");
	          if(parseInt(ss)<=0)
	  		{
	  		
	  		return "redClass";
	  	
	  		}
   
    		
    		};
 
var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
	   {
		value=0.0;
	   }
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
}
 
            /*  $('#gridtext').keyup(function(){
             	

 			      $("#prosearch").jqxGrid('clearfilters');
       		  
             
                 $('#part_no').val($(this).val());
                 var dataField = "part_no";
          applyFilter(dataField,$(this).val());  
                 
                 
                 
             });
             
         
             $('#gridtext1').keyup(function(){
             	

 			      $("#prosearch").jqxGrid('clearfilters');
     		  
           
               $('#productname').val($(this).val());
               var dataField = "productname";
    		   applyFilter(dataField,$(this).val());  
               
               
               
           });          */   
           	 /* var cellclassname =  function (row, column, value, data) {


            	  var ss= $('#jqxDeliveryNote').jqxGrid('getcellvalue', row, "qty");
            		          if(parseInt(ss)<=0)
            		  		{
            		  		
            		  		return "yellowClass";
            		  	
            		  		}
            	   

            		} */
           	 
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'productid', type: 'string' }, 
     						{name : 'productname', type: 'string'},
     						{name : 'unit', type: 'string'  },
     						{name : 'size', type: 'number'   },
     						{name : 'totqty', type: 'number'   },
     						{name : 'qty', type: 'number'   },
     						{name : 'outqty', type: 'number'   },
     						{name : 'oldqty', type: 'number'   },
     						{name : 'balqty', type: 'number'   },
     						{name : 'foc', type: 'number' },
     						{name : 'refqty', type: 'int'  },
							{name : 'totwtkg', type: 'number' },
							{name : 'kgprice', type: 'number'  },
     						{name : 'unitprice', type: 'number' },
     						{name : 'total', type: 'number' },
     						{name : 'discper', type: 'number' },
     						{name : 'dis', type: 'number' },
     						{name : 'fintot', type: 'number' },
     						{name : 'proid', type: 'string'    },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'prodoc', type: 'number'    },
                    		{name : 'specid', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						{name : 'stkid', type: 'number'    },
     						
     						{name : 'refstkid', type: 'number'    },
     						{name : 'brandname', type: 'string'    },
     						{name : 'rdocno', type: 'number'    },
     						
     						{name : 'detdocno', type: 'number'    },
     						{name : 'oldfoc', type: 'number'    },
     						
     					    
        					 {name : 'taxper', type: 'number'  }, 

        					{name : 'taxperamt', type: 'number'  }, 
        					 
        					 {name : 'taxamount', type: 'number'  }, 
        					 {name : 'balfoc', type: 'number'  }, 
        					 {name : 'taxchng', type: 'number'  }, 
        					 {name : 'netsss', type: 'number'  },
        					 {name : 'vatype', type: 'string'    },
        					 
        					 
        					 
     						
                        ],
                        
                        
                       
                         localdata: qotgriddata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            		
            		
            		
            		
             		
                   
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxInvoiceReturn").jqxGrid(
            {
                width: '99.5%',
                height: 240,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                disabled:true,
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
               
                	
///alert("in keyboard nav");
                   
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '10%',cellclassname: cellclassname,editable:false
	                          	  
  							   /*  createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    },   */
  							 
							},
  							 
                            { text: 'Product Name', datafield: 'productname',  cellclassname: cellclassname ,columntype: 'custom',editable:false
								

  								
  								/* createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  */ 
							
							},	
							
							{text: 'Brand Name', datafield: 'brandname', width: '10%' , editable:false,cellclassname: cellclassname  },
							
							{ text: 'Unit', datafield: 'unit', width: '5%',editable:false,cellclassname: cellclassname },	
							{ text: 'Size', datafield: 'size', width: '7%',editable:false,cellclassname: cellclassname,hidden:true },
							{ text: 'Quantity', datafield: 'qty', width: '5%',cellclassname: cellclassname },
							{ text: 'oldqty', datafield: 'oldqty', width: '7%',cellclassname: cellclassname ,hidden:true },
							{ text: 'TOT. Qty', datafield: 'totqty', width: '7%',cellclassname: cellclassname,hidden:true },
							{ text: 'FOC', datafield: 'foc', width: '5%',cellclassname: cellclassname,hidden:true},
							{ text: 'old', datafield: 'oldfoc', width: '7%',cellclassname: cellclassname,hidden:true },
							{ text: 'balfoc', datafield: 'balfoc', width: '7%',cellclassname: cellclassname ,hidden:true},
							 
							{ text: 'OUT. Qty', datafield: 'outqty', width: '7%',cellclassname: cellclassname,hidden:true  },
							{ text: 'Bal. Qty', datafield: 'balqty', width: '7%',cellclassname: cellclassname ,hidden:true},
							{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,editable:false},
							{ text: 'KG Price', datafield: 'kgprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,editable:false },
							{ text: 'Unit price', datafield: 'unitprice', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,editable:false },
							{ text: 'Total', datafield: 'total', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname },
							{ text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,editable:false },
							{ text: 'Discount', datafield: 'dis', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname,editable:false},
							{ text: 'Net Total', datafield: 'netsss', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
						
							
							
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false},
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Total Amount', datafield: 'fintot', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring  },
						
							
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'stockid', datafield: 'stkid', width: '10%',cellclassname: cellclassname ,hidden:true },
							{text: 'refstkid', datafield: 'refstkid', width: '10%',cellclassname: cellclassname ,hidden:true  },
							{text: 'rdocno', datafield: 'rdocno', width: '10%',cellclassname: cellclassname  ,hidden:true  },
							{text: 'deldocno', datafield: 'detdocno', width: '10%',cellclassname: cellclassname  ,hidden:true  },
							{text: 'vatype', datafield: 'vatype', width: '10%',cellclassname: cellclassname,hidden:true  },
						]
            });
            
       	 $('#jqxInvoiceReturn').on('cellclick', function (event) {
			 
			 document.getElementById("errormsg").innerText="";	 
			 
		 });    
            
            
            
            
            
            
            function valchange(rowBoundIndex,datafield)
            {
            	
         
            	//alert("in val change");
            	var qty=0;
            	var oldqty=0;
            	var totqty=0;
            	var tmpqty=0;
            	var tmpqty1=0;
            	var outqty=0;
            	var balqty=0;
            	var unitprice=0;
            	var totwtkg=0;
            	var kgprice=0;
            	var unitprice=0;
            	var total=0;
            	var discper=0;
            	var discount=0;
            	var fintot=0;
            	var warning;
            	var searchtype=document.getElementById("prodsearchtype").value;
            	 qty= $('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	 oldqty= $('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "oldqty");
            	 totqty= $('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "totqty");
            	 outqty= $('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "outqty");
            	 balqty= $('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "balqty");
            	 unitprice=	$('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 totwtkg=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "totwtkg");
            	 kgprice=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "kgprice");
            	 unitprice=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 total=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "total");
            	 discper=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            	 discount=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            	 fintot=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "fintot");
            	
            	 
            	 
            	/*  if(datafield=='foc'){
            		 
            		var foc= $('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "foc");	
                	var  balfoc= $('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "balfoc");
                	 
                	 
                  	if($('#mode').val()=="A" || $('#mode').val()=="E" ){
                  		 if(foc>balfoc){
                    		 document.getElementById("errormsg").innerText="Foc should not be greater than available  Foc "+balfoc;
                    	 
                    	 $('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowBoundIndex, "foc",balfoc);
                        	 
                    	 }
                  		
                  	}
                	 
            	 } */
            		 
            		 
            		 
            	 
            	 
            	 
            	 
             	if($('#mode').val()=="E"){
     				
            	 if(qty>balqty){
            		 document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+balqty;
            	// $("#jqxInvoiceReturn").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+balqty);
            	 //$('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
            	 $('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowBoundIndex, "qty",balqty);
                	 qty=balqty;
            	 }
            	 
            	 else{
            		 
            		// document.getElementById("errormsg").innerText="";
            		// $("#jqxInvoiceReturn").jqxGrid('hidevalidationpopups');
            	 }
             		 }
             	else if($('#mode').val()=="A"){
             		if(qty>totqty){
             			document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+totqty;
                   	// $("#jqxInvoiceReturn").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+totqty);
                   	 //$('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
                    $('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowBoundIndex, "qty",totqty);
                    	 qty=totqty;
                   	 }
                   	 
                   	 else{
                   	// $("#jqxInvoiceReturn").jqxGrid('hidevalidationpopups');
                   	//	document.getElementById("errormsg").innerText="";
                   	 }
             	}
            	 
            	
            	  
            	 /* if(datafield=='totwtkg' || datafield=='kgprice'){
            		 if(!(totwtkg==""||typeof(totwtkg)=="undefined"|| typeof(totwtkg)=="NaN" || kgprice==""||typeof(kgprice)=="undefined"|| typeof(kgprice)=="NaN"))
           		   {
            			 unitprice=(parseFloat(kgprice)*parseFloat(totwtkg))/qty;
           		   }
            		
                 	}
            	 
            	total=parseFloat(qty)*parseFloat(unitprice);
            	
           	  if(datafield=='qty'){
            		
            		if(parseFloat(discper)>0)
            			{
            		   
            			
            			discount=(parseFloat(total)*parseFloat(discper))/100;
            		             			
            			}
            		
            	         }
            	
            	
            	if(datafield=='dis'){
            		
            		if(!(discper==""||typeof(discper)=="undefined"|| typeof(discper)=="NaN"))
          		   {
            			discper=(100/parseFloat(total))*parseFloat(discount);
          		   }
            		
            	}
            	
            	
            	
            	if(datafield=='discper'){
            	discount=(parseFloat(total)*parseFloat(discper))/100;
            	}
            	if(discount==""||typeof(discount)=="undefined"|| typeof(discount)=="NaN")
     		   {
            		discount=0.0;
     		   }
            	fintot=parseFloat(total)-parseFloat(discount);
            	
            	
            	$('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",unitprice);
            	$('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
            	$('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
            	$('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            	$('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowBoundIndex, "netsss",fintot); */
            	
 
            	      
            		
            		/* var summaryData1= $("#jqxInvoiceReturn").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            		var summaryData= $("#jqxInvoiceReturn").jqxGrid('getcolumnaggregateddata', 'netsss', ['sum'],true);
	        		var summaryData2= $("#jqxInvoiceReturn").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
	        		  
           document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
          document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
          document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
          document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,'');  */
          
          
         
            	   }
            
            
            
            $("#jqxInvoiceReturn").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = event.args.rowindex;
            		    var tsk=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "taxper");
                		var calfix="100";
                		var cal=parseFloat(calfix)+parseFloat(tsk);
            		            	   
            	  
            	  
            	  	 if(datafield=='qty'){
            	  		 var vattype=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', rowBoundIndex, "vatype");
               		  alert("vatype========="+vattype);
               		 var rows = $("#jqxInvoiceReturn").jqxGrid('getrows');   
                     
                   	//var vattype=document.getElementById("cmbvatype").value;
      	             	  for(var i=0;i<rows.length;i++){
      	             	   		
            	  		 var qty=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', i, "qty");
                    		 var uprice=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', i, "unitprice");
                    		 var tot=parseFloat(qty)*parseFloat(uprice);
                    		 $('#jqxInvoiceReturn').jqxGrid('setcellvalue', i, "total",tot);
                        	 if(parseFloat(qty)>0){
            		            	  if(vattype=="exclusive"){
            		            			discper=(100/parseFloat(total))*parseFloat(discount);
            		            			var total=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', i, "total");
         	            				var discount=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', i, "dis");
         	            				var val1=parseFloat(total)-parseFloat(discount);
         	            				
         	            				$('#jqxInvoiceReturn').jqxGrid('setcellvalue', i, "netsss",val1);
         	            				var taxper=(parseFloat(val1)/100)*parseFloat(tsk);
         	            				$('#jqxInvoiceReturn').jqxGrid('setcellvalue', i, "taxperamt",taxper);
         	            				var tot1=parseFloat(val1)+parseFloat(taxper);
         	            				$('#jqxInvoiceReturn').jqxGrid('setcellvalue', i, "fintot",tot1);
         	            				funRoundAmt2(tot1,"orderValue");
         	            				funRoundAmt2(val1,"txtnettotal");

            		            			
            		            	 }	
                        			
                        			if(vattype=="inclusive"){
                        				//alert("=====in incl======");
                        				var total=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', i, "total");
                        				var discount=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', i, "dis");
                        				var val1=parseFloat(total)-parseFloat(discount);
                        				$('#jqxInvoiceReturn').jqxGrid('setcellvalue', i, "fintot",val1);
                        				var val2=(parseFloat(val1)/parseFloat(cal))*100;
                        				$('#jqxInvoiceReturn').jqxGrid('setcellvalue', i, "netsss",val2);
                        				var val3=parseFloat(val1)-parseFloat(val2);
                        				$('#jqxInvoiceReturn').jqxGrid('setcellvalue', i, "taxperamt",val3);
                        				funRoundAmt2(val1,"orderValue");
                        				funRoundAmt2(val2,"txtnettotal");
                        			} 
                        			if(vattype=="export"){
                        				$('#jqxInvoiceReturn').jqxGrid('setcellvalue', i, "taxper",0);
                        				$('#jqxInvoiceReturn').jqxGrid('setcellvalue', i, "taxperamt",0);
                        				discper=(100/parseFloat(total))*parseFloat(discount);
                        				var total=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', i, "total");
                        				var discount=$('#jqxInvoiceReturn').jqxGrid('getcellvalue', i, "dis");
                        				var val1=parseFloat(total)-parseFloat(discount);
                        				$('#jqxInvoiceReturn').jqxGrid('setcellvalue', i, "fintot",val1);
                        				$('#jqxInvoiceReturn').jqxGrid('setcellvalue', i, "netsss",val1);
                        				funRoundAmt2(val1,"orderValue");
                        				funRoundAmt2(val1,"txtnettotal");
                        			}        			
                        		}
            	  		
      	             	  }
           			
            	  		 
            	  		 }
            	  	 
           	 
            	  	 
           		    	 
                    		});
            
            
            
            
            
             if($('#mode').val()!="view"){
            	$("#jqxInvoiceReturn").jqxGrid('disabled', false);
            	   if($('#cmbreftype').val()=='INV'){
                   	
            	          
                  	 if(!($('#rrefno').val()==""||$('#rrefno').val()=="undefined"|| $('#rrefno').val()=="NaN")){
                  	
                  		 var summaryData1= $("#jqxInvoiceReturn").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                   		var summaryData= $("#jqxInvoiceReturn").jqxGrid('getcolumnaggregateddata', 'netsss', ['sum'],true);
       	        		var summaryData2= $("#jqxInvoiceReturn").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
       	        		var summaryData3= $("#jqxInvoiceReturn").jqxGrid('getcolumnaggregateddata', 'fintot', ['sum'],true);
               			
                  document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
                 document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
                 funRoundAmt2(summaryData.sum.replace(/,/g,''),"txtnettotal");
                 funRoundAmt2(summaryData3.sum.replace(/,/g,''),"orderValue"); 

        
              	  
                  	 }
                  }
            } 
            
            
        });
   
   
        
        function chkbrand()
        {
         
           var x=new XMLHttpRequest();
           x.onreadystatechange=function(){
           if (x.readyState==4 && x.status==200)
            {
              var items= x.responseText.trim();
             
              if(parseInt(items)>0)
               {
             
            	  
            	  $('#jqxInvoiceReturn').jqxGrid('showcolumn', 'brandname');
            
            	  
            	  
                }
                  else
              {
              
                	  $('#jqxInvoiceReturn').jqxGrid('hidecolumn', 'brandname');
              
              }
              
               }}
           x.open("GET","checkbrand.jsp?",true);
        	x.send();
         
              
                
        	
        } 
        function chktax()
        {
         
           var x=new XMLHttpRequest();
           x.onreadystatechange=function(){
           if (x.readyState==4 && x.status==200)
            {
              var items= x.responseText.trim();
          
              if(parseInt(items)>0)
               {
            	 
            	  
            	  
            	  $('#billname').show();
            	  $('#cmbbilltype').show();
            	  
            	  $('#jqxInvoiceReturn').jqxGrid('showcolumn', 'taxper');
            	  $('#jqxInvoiceReturn').jqxGrid('showcolumn', 'fintot');
            
            	  
            	  
                }
                  else
              {
                	  
                	  $('#billname').hide();
                	  $('#cmbbilltype').hide();
                	  $('#jqxInvoiceReturn').jqxGrid('hidecolumn', 'taxper');
                	  $('#jqxInvoiceReturn').jqxGrid('hidecolumn', 'fintot');
              
              }
              
               }}
           x.open("GET","checktax.jsp?",true);
        	x.send();
         
              
                
        	
        }              
               
</script>
<div id="jqxInvoiceReturn"></div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">
