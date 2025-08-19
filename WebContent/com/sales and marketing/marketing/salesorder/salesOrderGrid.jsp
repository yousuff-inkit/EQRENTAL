 <%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
<%@page import="com.sales.marketing.salesorder.ClsSalesOrderDAO"%>
<%ClsSalesOrderDAO DAO= new ClsSalesOrderDAO();%>

<%
String qotdoc=request.getParameter("qotdoc")==null?"0":request.getParameter("qotdoc").trim();

String enqdoc=request.getParameter("enqdoc")==null?"0":request.getParameter("enqdoc").trim();

String chk=request.getParameter("chk")==null?"NA":request.getParameter("chk").trim();

String cond=request.getParameter("cond")==null?"0":request.getParameter("cond").trim();

String from=request.getParameter("from")==null?"0":request.getParameter("from").trim();

String reftype=request.getParameter("reftype")==null?"NA":request.getParameter("reftype").trim();

String enqmasterdocno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();

String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();
String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
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
      
  .advanceClass
  {
      
     background-color: #ffdead;     
      	
  }  
 /*  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        
        } */
 
    
              
</style>

<script type="text/javascript">
var qotgriddata;
$(document).ready(function () {
	chkfoc();
	chkbrand();
	chktax();
	//chkbatch();
var temp2='<%=enqdoc%>';
var temp='<%=qotdoc%>';
var cond='<%=cond%>';

   if(cond=="0")
{

	qotgriddata='<%=DAO.qotgridreload(enqdoc)%>';  
 
}
  
  if(cond=="1") 
 {
	
 	qotgriddata='<%=DAO.prdGridReload(session,enqdoc,dates,cmbbilltype,clientid)%>';  

 }
 else if(temp>0  && cond=="2")
{
	
	qotgriddata='<%=DAO.prdGridReload(session,qotdoc,enqdoc,reftype,dates,cmbbilltype)%>';  
 
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
    		//	document.getElementById("errormsg").innetText="Quantity Should not Be Zero";
              //  return "redClass";
            }
    		else{
    			//document.getElementById("errormsg").innetText="";
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
 
             $('#gridtext').keyup(function(){
             	

 			      $("#prosearch").jqxGrid('clearfilters');
       		  
             
                 $('#part_no').val($(this).val());
                 
                // alert($(this).val());
                 var dataField = "part_no";
          applyFilter(dataField,$(this).val());  
                 
                 
                 
             });
             
         
             $('#gridtext1').keyup(function(){
             	

 			      $("#prosearch").jqxGrid('clearfilters');
     		  
           
               $('#productname').val($(this).val());
               var dataField = "productname";
    		   applyFilter(dataField,$(this).val());  
               
               
               
           });            
             var cellclassname =  function (row, column, value, data) {


          	  var ss= $('#jqxSalesOrder').jqxGrid('getcellvalue', row, "qty");
            		          if(parseInt(ss)<=0)
            		  		{
            		  		
            		  		//return "redClass";
            		  	
            		  		}
            	   
              	if ($("#mode").val() == "E") {    
       		   	  var clstatus= $('#jqxSalesOrder').jqxGrid('getcellvalue', row, "clstatus");
   		          if(parseInt(clstatus)==1)
   		  		{
   		  		
   		  		return "advanceClass";
   		  	
   		  	      }  
   		                    
       		       	} 
            		}  
           	 
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
     						{name : 'refqty', type: 'numbernumber'  },
							{name : 'totwtkg', type: 'number' },
							{name : 'kgprice', type: 'number'  },
     						{name : 'unitprice', type: 'number' }, 
     						{name : 'total', type: 'number' },
     						{name : 'discper', type: 'number' },
     						{name : 'dis', type: 'number' },
     						{name : 'netotal', type: 'number' },
     						{name : 'proid', type: 'string'    },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'prodoc', type: 'number'    },
                    		{name : 'specid', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						{name : 'stkid', type: 'number'    },
     						{name : 'method', type: 'number'    },
     						{name : 'clstatus', type: 'number'    },
							{name : 'unitprice1', type: 'string'  }, 
     						{name : 'disper1', type: 'string'  },
     						{name : 'brandname', type: 'string'},
     					    {name : 'allowdiscount', type: 'number'  },
       					 	{name : 'taxper', type: 'number'  },  
       					 	{name : 'taxamount', type: 'number'  },
       						{name : 'taxperamt', type: 'number'  }, 
       						{name : 'collectqty', type: 'string'  }, 
	       					{name : 'oldfoc', type: 'number'  }, 
	       					{name : 'totsqty', type: 'number'  }, 
       						{name : 'weight', type: 'number'  },
                    		{name : 'totweight', type: 'number'  },
                    		{name : 'vattype', type: 'string'},
       		 
                        ],
                        
                        
                       
                         localdata: qotgriddata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            
            $("#jqxSalesOrder").on("bindingcomplete", function (event) { 
            	//alert("vattype========start");
    			
                if($('#mode').val()=="A"){
             var ref=$('#cmbreftype').val();
             //alert("vattype========start"+ref);
              if($('#cmbreftype').val()=='SQOT'){
            	
             	 var rows = $("#jqxSalesOrder").jqxGrid('getrows');   
 
             	 for(var i=0;i<rows.length;i++){
           		  var vattype=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "vattype"); 
           		//alert("vattype========"+vattype);
     			/* if(vattype==2){
     				$('#cmbvatype').val(2);
     			}
     			if(vattype==1){
     				$('#cmbvatype').val(1);
     			}
     			if(vattype==3){
     				$('#cmbvatype').val(3);
     			} */
     			if(vattype=="exclusive"){
    				$('#cmbvatype').val("exclusive");
    			}
    			if(vattype=="inclusive"){
    				$('#cmbvatype').val("inclusive");
    			}
    			if(vattype=="export"){
    				$('#cmbvatype').val("export");
    			}
           		 // costprice=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "cost_price");
                  	//$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "cost_price", costprice);
           		// alert("in binding complete==========="+vattype+"====costprice====="+costprice);
                /* 	var quanty=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "qty");   
           		     var weight=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "weight");  
           		  	 var totweight=parseFloat(quanty)*parseFloat(weight);
           		     $('#jqxSalesOrder').jqxGrid('setcellvalue', i, "totweight", totweight); */
           		//  $('#jqxSalesOrder').jqxGrid('setcellvalue', i, "totweight", 0);
           		//  $('#jqxSalesOrder').jqxGrid('setcellvalue', i, "weight", 0);
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
                	 var netotal=0;
                	var taxpers=0;
                 	 var foc=0;
                	 var warning;
                	 //var searchtype=document.getElementById("prodsearchtype").value;
                	 qty= $('#jqxSalesOrder').jqxGrid('getcellvalue', i, "qty");	
                	 foc= $('#jqxSalesOrder').jqxGrid('getcellvalue', i, "foc");	
                	 oldqty= $('#jqxSalesOrder').jqxGrid('getcellvalue', i, "oldqty");
                	 totqty= $('#jqxSalesOrder').jqxGrid('getcellvalue', i, "totqty");
                	 outqty= $('#jqxSalesOrder').jqxGrid('getcellvalue', i, "outqty");
                	 balqty= $('#jqxSalesOrder').jqxGrid('getcellvalue', i, "balqty");
                	 unitprice=	$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "unitprice");
                	 totwtkg=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "totwtkg");
                	 kgprice=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "kgprice");
                	 unitprice=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "unitprice");
                	 total=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "total");
                	 discper=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "discper");
                	 discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "dis");
                	 netotal=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "netotal");
                	 taxpers=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "taxper"); 
                     var psrno=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "psrno");
                     var unitdocno=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "unitdocno");
                     if(typeof(taxpers)==="undefined"){
                    	 taxpers=0;
                     }
                    // alert("taxpers====="+taxpers);
                     /* if(datafield=='discper'){
                 		
             	 		//alert("in dis======");
                     
             		 var  allowdiscount=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "discper");
             		 var amnt=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "total");
             		 //alert("in dis======222discper"+allowdiscount+"===="+"======total====="+amnt);
             		 var dso=(parseFloat(allowdiscount)/100)*parseFloat(amnt);
             		// alert("in dis======222"+dso);
             		 $('#jqxSalesOrder').jqxGrid('setcellvalue', i, "dis",dso);     
             		// alert("in dis======222");
             } */
             
                 		if(parseFloat(discper)>0)
                 			{
                 			
                 		 	discount=(parseFloat(total)*(parseFloat(discper.toFixed(2))/100));
                 			$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "dis",discount);
                 			}
                 		var qty=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "qty");
                   		 var uprice=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "unitprice");
                   		 var tot=parseFloat(qty)*parseFloat(uprice);
                   		 $('#jqxSalesOrder').jqxGrid('setcellvalue', i, "total",tot);
                       	 if(parseFloat(qty)>0){
                       		 if(vattype=="exclusive"){
           		            			discper=(100/parseFloat(total))*parseFloat(discount);
           		            			var total=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "total");
        	            				var discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "dis");
        	            				if(parseFloat(discount)>0){
        	            				var val1=parseFloat(total)-parseFloat(discount);
        	            				
        	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "netotal",val1);
        	            				var taxper=(parseFloat(val1)/100)*parseFloat(taxpers);
        	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxperamt",taxper);
        	            				var tot1=parseFloat(val1)+parseFloat(taxper);
        	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxamount",tot1);
        	            			   var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
        	        	      		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
        	        		        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        	        		        		var summaryData3= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
        	        		        		
        	        		        	    document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
        	                         	    document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
        	                         	    document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
        	                         	    document.getElementById("st").value=summaryData3.sum.replace(/,/g,'');
        	                         	    document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,'');
        	                         	    document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
        	                         	  
        	                         	   
        	                         	    var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);         	        		funRoundAmt(orderValue,"orderValue");
        	        		funRoundAmt(orderValue,"orderValuefinal");
        	            				}
        	            				else{
        	            					$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "netotal",total);
            	            				var taxper=(parseFloat(total)/100)*parseFloat(taxpers);
            	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxperamt",taxper);
            	            				var tot1=parseFloat(total)+parseFloat(taxper);
            	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxamount",tot1);
            	            			   var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            	        	      		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
            	        		        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
            	        		        		var summaryData3= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
            	        		        		
            	        		        	    document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
            	                         	    document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
            	                         	    document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
            	                         	    document.getElementById("st").value=summaryData3.sum.replace(/,/g,'');
            	                         	    document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,'');
            	                         	    document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
            	                         	    
            	                         	    var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);             	        		funRoundAmt(orderValue,"orderValue");
            	        		funRoundAmt(orderValue,"orderValuefinal");
        	            				}
           		            			
           		            	 }	
                       			
                       		if(vattype=="inclusive"){
                       				var total=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "total");
                       				var discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "dis");
                       				if(parseFloat(discount)>0){
                       				var val1=parseFloat(total)-parseFloat(discount);
                       				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxamount",val1);
                       				var val2=(parseFloat(val1)/(100+parseFloat(taxpers)))*100;
                       				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "netotal",val2);
                       				var val3=parseFloat(val1)-parseFloat(val2);
                       				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxperamt",val3);
                       			   var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                    	      		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                    		        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                                    var summaryData3= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
        	        		        		
        	        		        	    document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
        	                         	    document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
        	                         	    document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
        	                         	    document.getElementById("st").value=summaryData3.sum.replace(/,/g,'');
                                    	    document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,'');
                                    	    document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                                    	    
                                    	    var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);                     		funRoundAmt(orderValue,"orderValue");
                    		funRoundAmt(orderValue,"orderValuefinal");
                       				}
                       				else{
                       					$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxamount",total);
                           				var val2=(parseFloat(total)/(100+parseFloat(taxpers)))*100;
                           				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "netotal",val2);
                           				var val3=parseFloat(total)-parseFloat(val2);
                           				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxperamt",val3);
                           			   var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                        	      		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                        		        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                        		        		var summaryData3= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
            	        		        		
            	        		        	    document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
            	                         	    document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
            	                         	    document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
            	                         	    document.getElementById("st").value=summaryData3.sum.replace(/,/g,'');
                                        	    document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,'');
                                        	    document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                                        	    
                                        	    var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);                         		funRoundAmt(orderValue,"orderValue");
                        		funRoundAmt(orderValue,"orderValuefinal");
                       				}
                       			} 
                       		if(vattype=="export"){
                       				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxper",0);
                       				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxperamt",0);
                       				discper=(100/parseFloat(total))*parseFloat(discount);
                       				var total=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "total");
                       				var discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "dis");
                       				if(parseFloat(discount)>0){
                       				var val1=parseFloat(total)-parseFloat(discount);
                       				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxamount",val1);
                       				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "netotal",val1);
                       			   var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                    	      		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                    		        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                                    var summaryData3= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
        	        		        		
        	        		        	    document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
        	                         	    document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
        	                         	    document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
        	                         	    document.getElementById("st").value=summaryData3.sum.replace(/,/g,'');
                                    	    document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,'');
                                    	    document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                                    	    
                                    	    var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);                     		funRoundAmt(orderValue,"orderValue");
                    	   funRoundAmt(orderValue,"orderValuefinal");
                       				}
                       				else{
                       					$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxamount",total);
                           				$('#jqxSalesOrder').jqxGrid('setcellvalue', i, "netotal",total);
                           			   var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                        	      		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                        		        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                        		        		var summaryData3= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
            	        		        		
            	        		        	    document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
            	                         	    document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
            	                         	    document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
            	                         	    document.getElementById("st").value=summaryData3.sum.replace(/,/g,'');
                        	    document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,'');
                        	    document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                        	    
                        	    var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
                        		funRoundAmt(orderValue,"orderValue");
                        		funRoundAmt(orderValue,"orderValuefinal");
                       				}
                       			}
                      	 }
           		  
             		
           	                         }
                                    }
                               } 
         	         
     
    			
    			
    		}); 
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxSalesOrder").jqxGrid(
            {
                width: '99.5%',
                height: 400,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                disabled:true,
                statusbarheight: 21,
                selectionmode: 'singlerow',
                pagermode: 'default',
                handlekeyboardnavigation: function (event) {
                	

                    var cell4 = $('#jqxSalesOrder').jqxGrid('getselectedcell');
                    var cell1 = $('#jqxSalesOrder').jqxGrid('getselectedcell');
                   
                	 if (cell1 != undefined && cell1.datafield == 'qty') {  
                		 
                		 
                		 if(document.getElementById("cmbreftype").value=="DIR" && ( parseInt(document.getElementById("batchno").value)==1 || parseInt(document.getElementById("expdate").value)==1))
         				{	
                			 
                		 
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                       	 
               			 
                          var rowindextemp=cell1.rowindex;
                     	    document.getElementById("rowvalss").value = cell1.rowindex;   
                         	  $('#jqxInvoiceGrid').jqxGrid('clearselection');
                         	batchinfoSearchContent('qtySearch.jsp?psrno='+$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindextemp, "psrno")+
                         			"&mode="+document.getElementById("mode").value+"&value="+document.getElementById("masterdoc_no").value);
                         	
                        	 
                        }
                        
         				}
                        
                        
                        }
        			 
        			 
                    if (cell4 != undefined && (cell4.datafield == 'productid' || cell4.datafield == 'productname'  )) 
                    
                   {	 
                   	 
                   	 
                   	 
  	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
  	                 
  	                  if (key == 9) { 
  	                	  
  	                	  
  	               	  if(cell4.datafield == 'productid')
            		  {
            		var aa= $('#part_no').val();
            		  }
            	  else if(cell4.datafield == 'productname')
            		  {
            		var aa= $('#productname').val();  
            		  }
            	 
			            if(typeof(aa)=="undefined")
			            
			            	{
			             
			            	return 0;
			            	}
			               
  	                	  
  	                	  
  	                	  
  	                	$('#sidesearchwndow').jqxWindow('close');
  	                	  
  	                	
  	                	
  	             	 if(document.getElementById("cmbreftype").value=="SQOT")
	                	{
	             	   
	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
	                	  
	   	     
	   	              
	   	              
	                   var unitprice=rows[0].unitprice;
	   	              
	   	              var prdid=rows[0].doc_no;
	   	                var disper=rows[0].discper;
	   
	              	  
		  	            		var rows1 = $("#jqxSalesOrder").jqxGrid('getrows');
		  	          	    var aa=0;
		  	          	    for(var i=0;i<rows1.length;i++){
		  	          	 
		  	          	    	
		  	          	    	 
		  	          		   if(parseInt(rows1[i].prodoc)==parseInt(prdid))
		  	          			   {
		  	          			   
		  	           		   if(parseFloat(rows1[i].unitprice)==parseFloat(unitprice))
		  	           			  {
		  	           			   
		  	           		 
		  	           		   if(parseFloat(rows1[i].discper)==parseFloat(disper))
		  	           			  {
		  	          		   var munit=rows[0].unitdocno;
			      				 if((parseInt(document.getElementById("multimethod").value)==1))
			          				{	
			      					   
			  	        			   if(parseInt(rows1[i].unitdocno)==parseInt(munit))
			  	        			   {
			  	        				   
			  	        				   aa=1;
			  	            			   break;
			  	        			   }
			          				}
			      				 else
			      					 {
		  	           			   
		  	           			   aa=1;
		  	          			   break;
			      					 }
		  	           			   
		  	           			  }
		  	          			   }
		  	          			   
		  	          			   }
		  	          		   else{
		  	          			   
		  	          			   aa=0;
		  	          		       } 

	          	 
	          	                     }
	          	   
	          	   
	          	   
			  	          	   if(parseInt(aa)==1)
			  	          		   {
			  	          		   
			  	          			document.getElementById("errormsg").innerText="You have already select this product";
			  	          		   
			  	          		   return 0;
			  	          		   
			  	          		   }
			  	          	   else
			  	          		   {
			  	          		   document.getElementById("errormsg").innerText="";
			  	          		   }
	          	   
	            	  
	              	   } 
  	             	 else
  	             		 {
  	                	
  	             	   
	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
  	                	  
  	                	  
  	                   var prodocs=rows[0].doc_no;
  	                
  	         
  	              	  
  	            		var rows1 = $("#jqxSalesOrder").jqxGrid('getrows');
  	          	    var aa=0;
  	          	    for(var i=0;i<rows1.length;i++){
  	          	 
  	          	    	
  	          	    	 
  	          		   if(parseInt(rows1[i].prodoc)==parseInt(prodocs))
  	          			   {
  	          		   var munit=rows[0].unitdocno;
	      				 if((parseInt(document.getElementById("multimethod").value)==1))
	          				{	
	      					   
	  	        			   if(parseInt(rows1[i].unitdocno)==parseInt(munit))
	  	        			   {
	  	        				   
	  	        				   aa=1;
	  	            			   break;
	  	        			   }
	          				}
	      				 else
	      					 {
 	           			   
  	          			   aa=1;
  	          			   break;
	      					 }
  	          			   }
  	          		   else{
  	          			   
  	          			   aa=0;
  	          		       } 

  	          	 
  	          	   
  	          	                         }
  	          	   
  	          	   
  	          	   
  	          	   if(parseInt(aa)==1)
  	          		   {
  	          		   
  	          			document.getElementById("errormsg").innerText="You have already select this product";
  	          		   
  	          		   return 0;
  	          		   
  	          		   }
  	          	   else
  	          		   {
  	          		   document.getElementById("errormsg").innerText="";
  	          		   }
  	          	   
  	            	  
  	            	    }
  	                	    
  	                	  
  	                	  
  	     
  	                	  
  	                	   
  	               	 var rows = $("#prosearch").jqxGrid('getrows');
  	  		    
  	                	
  	                	   $('#jqxSalesOrder').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	               $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	            
  	            $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
  	               
  	          $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "allowdiscount" ,rows[0].allowdiscount);
  	          
  	          
  		      $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "taxper" ,rows[0].taxper);
	  	        

                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "unitprice" ,rows[0].unitprice);
                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "eidtprice" ,rows[0].eidtprice);
                
                
                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
  	 
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].unitdocno);
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno ); 
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowindex1, "qty" ,rows[0].qty );
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "outqty" ,rows[0].outqty );
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "balqty" ,rows[0].balqty );
  	                
  	              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "totsqty" ,rows[0].balqty );
  	                
  	               
  	                
  	              document.getElementById("stockmsg").innerText="";
  	               document.getElementById("stockmsg").innerText="Stock : "+rows[0].balqty;
  	                
  	              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
  	            $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "stkid" ,rows[0].stkid );
  	            $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "totqty" ,rows[0].totqty );
  	          $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "collectqty" ,0);
  	            
  	          
  	            
  	            
  	            
  	            
  	            
  	          $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "method" ,rows[0].method);
  	          
  	          
        	  document.getElementById("datas2").value="0";
        	  if(document.getElementById("cmbreftype").value=="DIR")
        		  
        		  
        		  {  
        	  if(parseInt(rows[0].discountset)>0)
        		  {
        		
        		   var dscper=document.getElementById("dscper").value;
        		 	if(dscper>0)
		      		{
        		  
        		 	var allowdiscount=rows[0].allowdiscount;
		      		var  discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100);  
		      	 
		          document.getElementById("datas2").value="1";
		            $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "disper1" ,discallowper);
	        		  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "discper" ,discallowper);
	        		  
		      		}
        		 	else
        		 		{
        		 		  document.getElementById("datas2").value="1";
        		 		  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "disper1" ,rows[0].allowdiscount);
                		  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "discper" ,rows[0].allowdiscount);
        		 		}
        		  
        		  
        		  }
        

		      
		     	      
        		  }
		     	 
        	  document.getElementById("datas2").value="0";
  	          
  	          
  	          
  	          
  	        if(document.getElementById("cmbreftype").value=="SQOT")
        	{
  	        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "total" ,rows[0].total);
		    $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "discper" ,rows[0].discper);
  	    	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "dis" ,rows[0].dis);
  	   		$('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "netotal" ,rows[0].netotal);
  	  		$('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "unitprice1" ,rows[0].unitprice);
 	  		$('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "disper1" ,rows[0].discper);
        	}
  	          
         /* 	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "total" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "total"));
        	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "discper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper"));
        	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "dis" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "dis"));
        	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "netotal" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "netotal"));
  	           */
  	                
  	     // $("#jqxSalesOrder").jqxGrid('selectcell',rowindex1, "qty" ); 
  	        //  $("#jqxSalesOrder").jqxGrid('begincelledit', rowindex1, 'qty');
  	        
  	       
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#jqxSalesOrder').jqxGrid('getrows');
               var rowlength= rows.length;
               if(rowindex1 == rowlength - 1)
               	{  
               $("#jqxSalesOrder").jqxGrid('addrow', null, {});
               	} 
               
               $("#jqxSalesOrder").jqxGrid('ensurerowvisible', parseInt(rowindex1)+1);
               
               
  	        	            } 
  	                   
  	                if (key != 13) {           
            if (cell4 != undefined && cell4.datafield == 'productid') {
       
       		 
       		   document.getElementById("gridtext").focus();
       		 
            }
            if (cell4 != undefined && cell4.datafield == 'productname') {
    	        
       		 
       		   document.getElementById("gridtext1").focus();
       		 
          }}
              
            
                   } 
       		 
            
                    },
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Product', datafield: 'productid',cellclassname: cellclassname,editable:false
								/* ,columntype: 'custom' 
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"/>' ); 
  							   
  							        
  							    },   */
  							 
							},
  							 
                       { text: 'Product Name', datafield: 'productname'   ,cellclassname: cellclassname ,editable:false
								

								/* ,columntype: 'custom'
  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    }, */   
							
							},	
							{text: 'Brand Name', datafield: 'brandname', width: '10%' , editable:false ,cellclassname: cellclassname },
							{ text: 'Unit', datafield: 'unit', width: '4%',editable:false,cellclassname: cellclassname },	
							{ text: 'Size', datafield: 'size', width: '7%',editable:false,cellclassname: cellclassname,hidden:true },
							{ text: 'Quantity', datafield: 'qty', width: '5%',cellclassname: cellclassname, cellsformat: 'd2',
								cellbeginedit: function (row) {
									
									
				               		  
				               	
									if(document.getElementById("cmbreftype").value=="DIR" && ( parseInt(document.getElementById("batchno").value)==1 || parseInt(document.getElementById("expdate").value)==1))
									{
										var str=$('#jqxSalesOrder').jqxGrid('getcellvalue', row, "collectqty");
										
										if(str==0 || str=="0.00"|| str=="" ||str==null || typeof(str)=="undefiend") 
								  	 	   {
					               			str=0;
					               			 
								  	 	   }
									
									if(str!=0)
			               			{
			               		 return false;
			               			}
									else
										{
										 
										 return true;
										}
									}
									else
										{
										 return true;
										}
								    	 
								},},
								
							//{ text: 'Weight', datafield: 'weight', width: '5%' ,editable:false,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2'},
								
							{ text: 'oldqty', datafield: 'oldqty', width: '7%',cellclassname: cellclassname ,hidden:true     },
							
							
							{ text: 'oldfoc', datafield: 'oldfoc', width: '7%',cellclassname: cellclassname  ,hidden:true    },
							
							
							
							{ text: 'TOT. Qty', datafield: 'totqty', width: '7%',cellclassname: cellclassname  ,hidden:true   },
							{ text: 'FOC', datafield: 'foc', width: '7%',editable:true,cellclassname: cellclassname,hidden:true,cellsformat: 'd2',
								cellbeginedit: function (row) {
									
									
				               		  
					               	
									if(document.getElementById("cmbreftype").value=="DIR" && ( parseInt(document.getElementById("batchno").value)==1 || parseInt(document.getElementById("expdate").value)==1))
									{
										var str=$('#jqxSalesOrder').jqxGrid('getcellvalue', row, "collectqty");
										
										if(str==0 || str=="0.00"|| str=="" ||str==null || typeof(str)=="undefiend") 
								  	 	   {
					               			str=0;
					               			 
								  	 	   }
									
									if(str!=0)
			               			{
			               		 return false;
			               			}
									else
										{
										 
										 return true;
										}
									}
									else
										{
										 return true;
										}
								    	 
								},  },
							{ text: 'OUT. Qty', datafield: 'outqty', width: '7%',cellclassname: cellclassname,hidden:true   },
							{ text: 'Bal. Qty', datafield: 'balqty', width: '7%',cellclassname: cellclassname ,hidden:true },
							{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname},
							{ text: 'KG Price', datafield: 'kgprice', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname },
							{ text: 'Unit price', datafield: 'unitprice', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,
								cellbeginedit: function (row) {
									var temp=$('#jqxSalesOrder').jqxGrid('getcellvalue', row, "eidtprice");
								     if (parseInt(temp)==0)
								    	 {
								    			    	 
								       return false; 
								    	 }
							         if (document.getElementById("cmbreftype").value=="SQOT")
		                             {
		                                  return false;
		                             } 
								   
								  },
								  
								 
							
							
							
							},
							{ text: 'Total', datafield: 'total', width: '7%', cellsformat: 'd2', cellsalign: 'right' , align: 'right',editable:false,cellclassname: cellclassname,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							
							{ text: 'allowdiscount', datafield: 'allowdiscount', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname  ,hidden:true  },
							
							{ text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2' , cellsalign: 'right', align: 'right',cellclassname: cellclassname,
								
								 cellbeginedit: function (row) {
	                                    if (document.getElementById("cmbreftype").value=="SQOT")
	                             {
	                                  return false;
	                             } 
	                                    
								 }, 
							
							},
							{ text: 'Discount', datafield: 'dis', width: '7%', cellsformat: 'd2', cellsalign: 'right' , align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname,
								
								 cellbeginedit: function (row) {
	                                    if (document.getElementById("cmbreftype").value=="SQOT")
	                             {
	                                  return false;
	                             } 
	                                    
								 }, 
							
							},
							{ text: ' Net Total', datafield: 'netotal', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname ,hidden:true},
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true  },
							{text: 'stockid', datafield: 'stkid', width: '10%',cellclassname: cellclassname ,hidden:true  },
							{text: 'method', datafield: 'method', width: '10%',cellclassname: cellclassname,hidden:true  },
							{text: 'eidtprice', datafield: 'eidtprice', width: '10%' ,hidden:true },
							{text: 'clstatus', datafield: 'clstatus', width: '10%',cellclassname: cellclassname,hidden:true  },
							{text: 'unitprice1', datafield: 'unitprice1', width: '10%'   ,hidden:true },
							{text: 'disper1', datafield: 'disper1', width: '10%',hidden:true  },
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false},
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Net Total', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							//{ text: 'Total Weight', datafield: 'totweight', editable:false,cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							
							{text: 'qtysaves', datafield: 'collectqty', width: '15%' ,hidden:true    },
							{text: 'totsqty', datafield: 'totsqty', width: '15%'    ,hidden:true },
							
							
							
							
						]
            });
          
         	 var rval=$("#jqxSalesOrder").jqxGrid('getrows');
            
            if(rval=="" && (($('#mode').val()=='A')||($('#mode').val()=='E')))
		       
     	   {
         $("#jqxSalesOrder").jqxGrid('addrow', null, {});

       
     	   }
            
            
         	 
         	 $('#jqxSalesOrder').on('cellclick', function (event) {
         		
    			 document.getElementById("errormsg").innerText="";	
    			 
    				var df=event.args.datafield;

                   
    			
	               	
    				
    				
               	  if(df == "qty")
               		  { 
               		  
               	  	
    					
           			
               		 if(document.getElementById("cmbreftype").value=="DIR" && ( parseInt(document.getElementById("batchno").value)==1 || parseInt(document.getElementById("expdate").value)==1) && document.getElementById("mode").value=="E")
 					{	 var rowindextemp = event.args.rowindex; 
               			var str=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "collectqty");
               		 
               		 if(str==0 || str=="0.00"|| str=="" ||str==null || typeof(str)=="undefiend") 
			  	 	   {
               			str=0;
			  	 	   }
               		 
                   	   
        				if(str!=0)
               			{  
        				
   			
          	    document.getElementById("rowvalss").value = rowindextemp;   
          	  $('#jqxSalesOrder').jqxGrid('clearselection');
          	batchinfoSearchContent('qtySearch.jsp?psrno='+$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "psrno")+
          			 "&mode="+document.getElementById("mode").value+"&value="+document.getElementById("masterdoc_no").value+"&unit="+$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "unitdocno"));
          	
 					}
   			 
               			 
           			  }  
               		  
               		  
  		
  			 
  			 
               		  }
    			 
    			 
    			 
  			 if(document.getElementById("cmbreftype").value=="DIR")
         		{
    							 
    			
    							  
    			             	  if(df == "unit")
    			             		  { 
    			             		 
    						 if(parseInt(document.getElementById("multimethod").value)==1)
    							{	 
    						 
    						 var rowindextemp = event.args.rowindex;
    			       	    document.getElementById("rowindex").value = rowindextemp;   
    			       	  $('#jqxSalesOrder').jqxGrid('clearselection');
    			      	qtyinfoSearchContent('searchunit.jsp?psrno='+$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "psrno")+
    			      			"&mode="+document.getElementById("mode").value+"&oldqty="+$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "oldqty")+"&unitdocno="+$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "unitdocno"));
    							}
    						 
    						 
    						 
    			             		  }
    			       	
         		}  
    			 
    		 }); 
         	
           	$('#jqxSalesOrder').on('rowdoubleclick', function (event) {
              	 var rowindextempg = event.args.rowindex;
      		   //alert("rowindextempg=="+rowindextempg);
   	    document.getElementById("rowindexg").value = rowindextempg;
   	   var productd=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "productid");
   	    if(productd!="" && !(productd==null) && !(productd=="undefiend")){
   	   document.getElementById("jqxInput").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "productid");
        document.getElementById("jqxInput1").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "productname");
        document.getElementById("temppsrno").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "psrno");
        document.getElementById("tempspecid").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "specid");
        getunit($('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "psrno"));
        document.getElementById("unit").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "unitdocno");
        document.getElementById("brand").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "brandname");
        
        funRoundAmt($('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "taxper"),"taxpers");
        funRoundAmt($('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "unitprice"),"uprice");
        document.getElementById("errormsg").innerText="";
        document.getElementById("quantity").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "qty");             
        document.getElementById("dispers").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "discper");
        document.getElementById("dict").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "dis");
        document.getElementById("taxpers").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "taxper");
        document.getElementById("taxamountstotal").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "taxamount");
        document.getElementById("totalstock").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "balqty");
        document.getElementById("hidpsrno").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "psrno");
        document.getElementById("totamt").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "total");
        funRoundAmt2($('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "taxperamt"),"taxamounts");
        funRoundAmt2($('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "netotal"),"amounts");
       // document.getElementById("wght").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "weight");
        //document.getElementById("totwght").value=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextempg, "totweight");

        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "productid","");
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "productname","");
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "unit","");
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "brandname","");
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "qty",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "total",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "unitprice",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "discper",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "dis",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "taxper",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "taxperamt",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "netotal",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "taxamount",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "psrno",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "specid",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "proid","");
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "proname","");
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "prodoc",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "unitdocno",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "allowdiscount",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "weight",0);
        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextempg, "totweight",0);
   	    }
              	});
         	 
            $('#jqxSalesOrder').on('cellbeginedit', function (event) {
               
            	
            	var columnindex1=event.args.columnindex;
            	 var prodsearchtype=$("#prodsearchtype").val();
            	 var refmasterdocno=$("#refmasterdocno").val();
            	 
              	
              	var df=event.args.datafield;

               
              	  if(df == "productid")
              		  { 
              		var clientid=document.getElementById("clientid").value;
              		var cmbprice=document.getElementById("cmbprice").value;
              		
              		
              	  if(document.getElementById("clientid").value=="")
        		  {

        		   document.getElementById("errormsg").innerText="Search Customer";  
        		   document.getElementById("txtclient").focus();
        		     
        		      return 0;
        		  }
           		  
             	 var clientcaid=document.getElementById("clientcaid").value; 
           		 var dates=document.getElementById("date").value;
           		 
           		 var cmbbilltype=document.getElementById("cmbbilltype").value; 
              		
              		 
                	 /* productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&cmbprice='+cmbprice+'&clientid='+clientid+'&reftypes='+document.getElementById("cmbreftype").value+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype); */
                	 var rowindextemp = event.args.rowindex;
            	    document.getElementById("rowindex").value = rowindextemp;  
            	    
           var temp= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "productid"); 
           


           if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
           { 
          	 $('#gridtext').val("");  
          	 $('#part_no').val("");  
           }
           else
          	 {
          	 
          	   
               $('#part_no').val($('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               $('#gridtext').val($('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               
              
               $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "proid"));

               
          	 }
            
               
            		  } 
            	  
            	  
              	 if(df == "productname")
         		  { 
              		var clientid=document.getElementById("clientid").value;
              		var cmbprice=document.getElementById("cmbprice").value;
              		
              		
               		
              		
                	  if(document.getElementById("clientid").value=="")
          		  {

          		   document.getElementById("errormsg").innerText="Search Customer";  
          		   document.getElementById("txtclient").focus();
          		     
          		      return 0;
          		  }
             		  
                  	 var clientcaid=document.getElementById("clientcaid").value; 
               		 var dates=document.getElementById("date").value;
               		 
               		 var cmbbilltype=document.getElementById("cmbbilltype").value; 
               		 
                	 /* productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&cmbprice='+cmbprice+'&clientid='+clientid+'&reftypes='+document.getElementById("cmbreftype").value+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype); */
        	 		 var rowindextemp = event.args.rowindex;
        	   		 document.getElementById("rowindex").value = rowindextemp;  
        	    
        	      	 var temp= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "productname"); 
                
        	      
                // alert(temp);
                 if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
        		   { 
              	   $('#gridtext1').val(""); 
              	   $('#productname').val("");  
        		   }
                 else
                	 {
        	    

              	   $('#productname').val($('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
              	   $('#gridtext1').val($('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
                     
                     $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "proname"));

                     
                	 }
                  

         
        		  } 
            	 
                   
                   });
            
            
            

            function valchange(rowBoundIndex,datafield)
            {
            	//alert("in valchange");
            	var vattype=document.getElementById("cmbvatype").value;
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
            	var netotal=0;
            	var taxp=0;
            	var warning;
            	var searchtype=document.getElementById("prodsearchtype").value;
            	 qty= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	 oldqty= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "oldqty");
            	 totqty= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "totqty");
            	 outqty= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "outqty");
            	 balqty= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "balqty");
            	 unitprice=	$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 totwtkg=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "totwtkg");
            	 kgprice=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "kgprice");
            	 unitprice=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
            	 discper=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            	 discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            	 netotal=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "netotal");
            	 taxp=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "taxper");
            var	 method1=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "method");
         	var weight=	$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "weight");
         	if(typeof(taxp)==="undefined"){
           	 taxp=0;
            }
           	var totweight=parseFloat(qty)*parseFloat(weight);
          		
   		   
   		    //$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "totweight",totweight);
            	 if(datafield=='qty'){
            		 tmpqty=qty+outqty;
            		 /* -oldqty */
                	 tmpqty1=oldqty+balqty;
                	 //$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "oldqty",qty);
             		//$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "outqty",tmpqty);
            //   alert(method1) ; 
             //  alert($('#cmbreftype').val()) ; 
          	if((method1=="0" && $('#cmbreftype').val()!='DIR') || method1=="1"){ 
          		
          	// alert("1");
          		
             	if($('#mode').val()=="E"){
     
            	 if(qty>totqty){
            		
           // 	 $("#jqxSalesOrder").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+totqty);
            	 //$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
            	 
            	 document.getElementById("errormsg").innerText="Quantity should not be greater than available quantity "+totqty ;
            	 	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "qty",totqty);
                   	qty=totqty;
            	 
            	 }
            	 
            	 else{
            		// $("#jqxSalesOrder").jqxGrid('hidevalidationpopups');
            		 document.getElementById("errormsg").innerText="";
            	 }
             		 }
             	
             	else if($('#mode').val()=="A"){
               
             		if(qty>balqty){
                		
                   	// $("#jqxSalesOrder").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+balqty);
                   	 //$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
                   	  	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "qty",balqty);
                   		qty=balqty;
                   	 document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+balqty;
                   	 
                   	 }
                   	 
                   	 else{
                   		// $("#jqxSalesOrder").jqxGrid('hidevalidationpopups');
                   		 document.getElementById("errormsg").innerText="";
                   	 }
               	}
             	 
             	}
            	 }
            	
            	  
            	 if(datafield=='totwtkg' || datafield=='kgprice'){
            		 unitprice=(parseFloat(kgprice)*parseFloat(totwtkg))/qty;
                 	}
            	 
            	total=parseFloat(qty)*parseFloat(unitprice);
            	
            	
      
            	
            	
            	
            	if(datafield=='discper'){
            		
            	 		//alert("in dis======");
                   	var pmgtval=$('#pmgt').val();
        	 		//alert("in dis======"+pmgtval);
                  if(parseInt(pmgtval)>0)
        	   {
                	 // alert("in dis======inside");
                	  var  allowdiscount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "allowdiscount");
                	  var  allowdiscount2=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "discper");
             		 var amnt=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
             		 //alert("in dis======222discper"+allowdiscount+"===="+"======total====="+amnt);
             		 if(parseFloat(allowdiscount2)<parseFloat(allowdiscount)){
             			  dso=(parseFloat(allowdiscount2)/100)*parseFloat(amnt);
             		 }
             		 else{
             			 $('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "discper",allowdiscount); 
             			  dso=(parseFloat(allowdiscount)/100)*parseFloat(amnt);
             		 }
             		
             		// alert("in dis======222"+dso);
             		 $('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "dis",dso); 
        	   }
                  else{
            		 var  allowdiscount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            		 var amnt=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
            		 //alert("in dis======222discper"+allowdiscount+"===="+"======total====="+amnt);
            		 var dso=(parseFloat(allowdiscount)/100)*parseFloat(amnt);
            		 //alert("in dis======222"+dso);
            		 $('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "dis",dso);     
            		 //alert("in dis======222");
                  }
            }
            	  if(datafield=='qty'){
                	//	alert("in qty========1========");
                		if(parseFloat(discper)>0)
                			{
                			
                		 	discount=(parseFloat(total)*(parseFloat(discper.toFixed(2))/100));
                			$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
                			}
                		var qty=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                  		 var uprice=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
                  		 var tot=parseFloat(qty)*parseFloat(uprice);
                  		 $('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "total",tot);
                      	 if(parseFloat(qty)>0){
                      		 if(vattype=="exclusive"){
          		            			discper=(100/parseFloat(total))*parseFloat(discount);
          		            			var total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
       	            				var discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "dis");
       	            				if(parseFloat(discount)>0){
       	            				var val1=parseFloat(total)-parseFloat(discount);
       	            				
       	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",val1);
       	            				var taxper=(parseFloat(val1)/100)*parseFloat(taxp);
       	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxper);
       	            				var tot1=parseFloat(val1)+parseFloat(taxper);
       	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",tot1);
       	            			  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
       	                  		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
       	       	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
       	              			
       	                 document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
       	                document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
       	                document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
       	                document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
       	                document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
       	                
       	                var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
       	            	funRoundAmt(orderValue,"orderValue");
       	            	funRoundAmt(orderValue,"orderValuefinal");
       	            				}
       	            				else{
       	            					$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",total);
           	            				var taxper=(parseFloat(total)/100)*parseFloat(taxp);
           	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxper);
           	            				var tot1=parseFloat(total)+parseFloat(taxper);
           	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",tot1);
           	            			  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
           	                  		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
           	       	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
           	              			
           	                 document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
           	                document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
           	                document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
           	                document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
           	                document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
           	                
           	                var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
           	            	funRoundAmt(orderValue,"orderValue");
           	            	funRoundAmt(orderValue,"orderValuefinal");
       	            				}
          		            			
          		            	 }	
                      			
                      		if(vattype=="inclusive"){
                      				var total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
                      				var discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                      				if(parseFloat(discount)>0){
                      				var val1=parseFloat(total)-parseFloat(discount);
                      				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",val1);
                      				var val2=(parseFloat(val1)/(100+parseFloat(taxp)))*100;
                      				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",val2);
                      				var val3=parseFloat(val1)-parseFloat(val2);
                      				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",val3);
                      			  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                             		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                  	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                         			
                            document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
                           document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
                           document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
                           document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
                           document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                           
                           var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
                       	funRoundAmt(orderValue,"orderValue");
                       	funRoundAmt(orderValue,"orderValuefinal");
                      				}
                      				else{
                      					$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",total);
                          				var val2=(parseFloat(total)/(100+parseFloat(taxp)))*100;
                          				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",val2);
                          				var val3=parseFloat(total)-parseFloat(val2);
                          				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",val3);
                          			  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                                 		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                      	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                             			
                                document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
                               document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
                               document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
                               document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
                               document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                               
                               var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
                           	funRoundAmt(orderValue,"orderValue");
                           	funRoundAmt(orderValue,"orderValuefinal");
                      				}
                      			} 
                      		if(vattype=="export"){
                      				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxper",0);
                      				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",0);
                      				discper=(100/parseFloat(total))*parseFloat(discount);
                      				var total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
                      				var discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                      				if(parseFloat(discount)>0){
                      				var val1=parseFloat(total)-parseFloat(discount);
                      				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",val1);
                      				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",val1);
                      			  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                             		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                  	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                         			
                            document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
                           document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
                           document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
                           document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
                           document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                           
                           var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
                       	funRoundAmt(orderValue,"orderValue");
                       	funRoundAmt(orderValue,"orderValuefinal");
                      				}
                      				else{
                      					$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",total);
                          				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",total);
                          			  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                                 		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                      	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                             			
                                document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
                               document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
                               document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
                               document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
                               document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                               
                               var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
                           	funRoundAmt(orderValue,"orderValue");
                           	funRoundAmt(orderValue,"orderValuefinal");
                      				}
                      			}
                     	 }
          		  }
            		if(datafield=='dis'){
            			 var qty=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                    	 if(parseFloat(qty)>0){
                    		  if(vattype=="exclusive"){
        		            			discper=(100/parseFloat(total))*parseFloat(discount);
        		            			var total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
        	            				var discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "dis");
        	            				if(parseFloat(discount)>0){
        	            				var val1=parseFloat(total)-parseFloat(discount);
        	            				
        	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",val1);
        	            				var taxper=(parseFloat(val1)/100)*parseFloat(taxp);
        	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxper);
        	            				var tot1=parseFloat(val1)+parseFloat(taxper);
        	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",tot1);
        	            				  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
        	            	           		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
        	            		        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        	            	       			
        	            	          document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
        	            	         document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
        	            	         document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
        	            	         document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
        	            	         document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
        	            	         
        	            	         var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
        	            	     	funRoundAmt(orderValue,"orderValue");
        	            	     	funRoundAmt(orderValue,"orderValuefinal");
        	            				}
        	            				else{
        	            					$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",total);
            	            				var taxper=(parseFloat(total)/100)*parseFloat(taxp);
            	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxper);
            	            				var tot1=parseFloat(total)+parseFloat(taxper);
            	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",tot1);
            	            				  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            	            	           		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
            	            		        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
            	            	       			
            	            	          document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
            	            	         document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
            	            	         document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
            	            	         document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
            	            	         document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
            	            	         
            	            	         var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
            	            	     	funRoundAmt(orderValue,"orderValue");
            	            	     	funRoundAmt(orderValue,"orderValuefinal");
        	            				}
        		            	 }	
                    			
                    		  if(vattype=="inclusive"){
                    				var total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
                    				var discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                    				if(parseFloat(discount)>0){
                    				var val1=parseFloat(total)-parseFloat(discount);
                    				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",val1);
                    				var val2=(parseFloat(val1)/(100+parseFloat(taxp)))*100;
                    				//alert("inc netotal==="+val2)
                    				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",val2);
                    				var val3=parseFloat(val1)-parseFloat(val2);
                    				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",val3);
                    				  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                    	           		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                    		        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                    	       			
                    	          document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
                    	         document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
                    	         document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
                    	         document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
                    	         document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                    	         
                    	         var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
                    	     	funRoundAmt(orderValue,"orderValue");
                    	     	funRoundAmt(orderValue,"orderValuefinal");
                    				}
                    				else{
                    					$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",val1);
                        				var val2=(parseFloat(total)/(100+parseFloat(taxp)))*100;
                        				//alert("inc netotal==="+val2)
                        				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",val2);
                        				var val3=parseFloat(total)-parseFloat(val2);
                        				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",val3);
                        				  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                        	           		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                        		        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                        	       			
                        	          document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
                        	         document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
                        	         document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
                        	         document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
                        	         document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                        	         
                        	         var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
                        	     	funRoundAmt(orderValue,"orderValue");
                        	     	funRoundAmt(orderValue,"orderValuefinal");
                    				}
                    			} 
                    		  if(vattype=="export"){
                    				
                    				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxper",0);
                    				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",0);
                    				discper=(100/parseFloat(total))*parseFloat(discount);
                    				var total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
                    				var discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                    				if(parseFloat(discount)>0){
                    				var val1=parseFloat(total)-parseFloat(discount);
                    				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",val1);
                    				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",val1);
                    				  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                    	           		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                    		        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                    	       			
                    	          document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
                    	         document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
                    	         document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
                    	         document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
                    	         document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                    	         
                    	         var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
                    	     	funRoundAmt(orderValue,"orderValue");
                    	     	funRoundAmt(orderValue,"orderValuefinal");
                    				}
                    				else{
                    					$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",total);
                        				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",total);
                        				  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                        	           		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                        		        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                        	       			
                        	          document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
                        	         document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
                        	         document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
                        	         document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
                        	         document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                        	         
                        	         var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
                        	     	funRoundAmt(orderValue,"orderValue");
                        	     	funRoundAmt(orderValue,"orderValuefinal");
                    				}
                    			}
                    		
                    	}
            			
            			
            			
            		}
            		if(datafield=='unitprice'){
            			var qty=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "qty");
               		 var uprice=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
               		 var sprice=document.getElementById("hidsellprice").value;
             			if(parseFloat(uprice)>0 && parseFloat(sprice)>0){
             			if(parseFloat(uprice)<parseFloat(sprice)){
             				//document.getElementById("errormsg").innerText="Enter Unit Price Greater Than Last Selling Price ";
             				 $.messager.alert('Message','Enter Unit Price Greater Than Last Selling Price ');
             				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",0);
             				 $('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "total",0);
                           
                           
                            $('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "dis",0);
                          
                            $('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",0);
                            $('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",0);
                            $('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",0);
             				//$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",0);
             			}
             			}
               		 var tot=parseFloat(qty)*parseFloat(uprice);
               		 $('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "total",tot);
                   	 if(parseFloat(qty)>0){
                   		 if(vattype=="exclusive"){
       		            			discper=(100/parseFloat(total))*parseFloat(discount);
       		            			var total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
       	            				var discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "dis");
       	            				if(parseFloat(discount)>0){
       	            				var val1=parseFloat(total)-parseFloat(discount);
       	            				
       	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",val1);
       	            				var taxper=(parseFloat(val1)/100)*parseFloat(taxp);
       	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxper);
       	            				var tot1=parseFloat(val1)+parseFloat(taxper);
       	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",tot1);
       	            			  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
       	                  		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
       	       	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
       	              			
       	                 document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
       	                document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
       	                document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
       	                document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
       	                document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
       	                
       	                var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
       	            	funRoundAmt(orderValue,"orderValue");
       	            	funRoundAmt(orderValue,"orderValuefinal");
       	            				}
       	            				else{
       	            					$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",total);
           	            				var taxper=(parseFloat(total)/100)*parseFloat(taxp);
           	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxper);
           	            				var tot1=parseFloat(total)+parseFloat(taxper);
           	            				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",tot1);
           	            			  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
           	                  		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
           	       	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
           	              			
           	                 document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
           	                document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
           	                document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
           	                document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
           	                document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
           	                
           	                var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
           	            	funRoundAmt(orderValue,"orderValue");
           	            	funRoundAmt(orderValue,"orderValuefinal");
       	            				}
       		            			
       		            	 }	
                   			
                   		if(vattype=="inclusive"){
                   				var total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
                   				var discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                   				if(parseFloat(discount)>0){
                   				var val1=parseFloat(total)-parseFloat(discount);
                   				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",val1);
                   				var val2=(parseFloat(val1)/(100+parseFloat(taxp)))*100;
                   				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",val2);
                   				var val3=parseFloat(val1)-parseFloat(val2);
                   				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",val3);
                   			  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                         		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
              	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                     			
                        document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
                       document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
                       document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
                       document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
                       document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                       
                       var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
                   	funRoundAmt(orderValue,"orderValue");
                   	funRoundAmt(orderValue,"orderValuefinal");
                   				}
                   				else{
                   					$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",total);
                       				var val2=(parseFloat(total)/(100+parseFloat(taxp)))*100;
                       				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",val2);
                       				var val3=parseFloat(total)-parseFloat(val2);
                       				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",val3);
                       			  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                             		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                  	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                         			
                            document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
                           document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
                           document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
                           document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
                           document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                           
                           var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
                       	funRoundAmt(orderValue,"orderValue");
                       	funRoundAmt(orderValue,"orderValuefinal");
                   				}
                   			} 
                   		if(vattype=="export"){
                   				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxper",0);
                   				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",0);
                   				discper=(100/parseFloat(total))*parseFloat(discount);
                   				var total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
                   				var discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                   				if(parseFloat(discount)>0){
                   				var val1=parseFloat(total)-parseFloat(discount);
                   				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",val1);
                   				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",val1);
                   			  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                         		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
              	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                     			
                        document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
                       document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
                       document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
                       document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
                       document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                       
                       var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
                   	funRoundAmt(orderValue,"orderValue");
                   	funRoundAmt(orderValue,"orderValuefinal");
                   				}
                   				else{
                   					$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",total);
                       				$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",total);
                       			  var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
                             		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
                  	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
                         			
                            document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
                           document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
                           document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
                           document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
                           document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,'');
                           
                           var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
                       	funRoundAmt(orderValue,"orderValue");
                       	funRoundAmt(orderValue,"orderValuefinal");
                   				}
                   			}
                   		
                   	}
            		}
            		
    	 
            	   }
            
            
            
            $("#jqxSalesOrder").on('cellvaluechanged', function (event) 
                    {
            	
            	 if(parseInt($('#datas3').val())==1)
	       		  {
	       	   return 0;
	       		  }
            	
            	
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = args.rowindex;
            		    
            	 
              		
         			 
            		    
            		    if(datafield=='discper' && document.getElementById("cmbreftype").value=="DIR")
            		    	
            		    {
            		    	  if(parseInt($('#datas2').val())==1)
                    		  {
                    	   return 0;
                    		  }
            		    }
            		    
            	
            	  
            	  if(datafield=='qty' || datafield=='dis' || datafield=='discper' || datafield=='unitprice' || datafield=='foc'){	 
            		  
            		 
            		  var load=document.getElementById("hidload").value;
                	  //alert("load"+load);
                	  if(parseFloat(load)==1){
                		  //alert(" inload"+load);
               			
                	  }else{
                		  //alert(" inload"+load);
            		  valchange(rowBoundIndex,datafield);
                	  }
                	 
            	  }
            	  
            	  
             		
           		    	 
                    		});
            
            
            var applyFilter = function (datafield,value) {
                
                var filtertype = 'stringfilter';
              
              
                if (datafield == 'part_no' || datafield == 'productname') filtertype = 'stringfilter';
                var filtergroup = new $.jqx.filter();
         
                    var filter_or_operator = 1;

                    var filtervalue = value;
    	            var filtercondition = 'starts_with';
                    
                    var filter = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
                    filtergroup.addfilter(filter_or_operator, filter);
               
                
                if (datafield == 'part_no') 
                	{
               
                $("#prosearch").jqxGrid('addfilter', 'part_no' , filtergroup);
              //  document.getElementById("part_no").focus();
                	}
                else  if (datafield == 'productname') 
            	         {
                    
                    $("#prosearch").jqxGrid('addfilter', 'productname' , filtergroup);
                  //  document.getElementById("productname").focus();
                    	}
                
                
           
                $("#prosearch").jqxGrid('applyfilters');
                
        
            }
            
            if($('#mode').val()!="view"){
            	$("#jqxSalesOrder").jqxGrid('disabled', false);
            }
            
            if($('#cmbreftype').val()=='SQOT' ){
            	
            	if($('#mode').val()=="A"){	
            	
            var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
    		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
    		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
			
        document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
        document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
        document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
        document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
        document.getElementById("orderValuefinal").value=summaryData.sum.replace(/,/g,''); 
    
        
       	var summaryData10= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
        
      	var aa1=summaryData10.sum.replace(/,/g,'');
  	   	
     	/*   
    	 var aa1 =parseFloat(aa)-parseFloat(document.getElementById("txtnettotal").value);
    	  */
    	 funRoundAmt4(aa1,"st");
    	 funRoundAmt4(aa1,"taxtotal");
		  funcalutax();
            }
            }
            
            
            
            
         $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#jqxSalesOrder").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#jqxSalesOrder").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#jqxSalesOrder").offset();
                       $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#jqxSalesOrder").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#jqxSalesOrder").jqxGrid('getrowid', rowindex);
                       $("#jqxSalesOrder").jqxGrid('deleterow', rowid);
               
                 	var rows = $("#jqxSalesOrder").jqxGrid('getrows');
                 	var rowlength=rows.length;
                 	
                	if(parseInt(rowlength)>1){
                   		rowlength=parseInt(rowlength)-1;
                   	}
                 	
                 	if(parseInt(rowlength)==0){
                 		 document.getElementById("txtproductamt").value=0; 
                         document.getElementById("txtdiscount").value=0; 
                         //document.getElementById("txtnettotal").vaue="0";
                         document.getElementById("orderValue").value=0; 
                         document.getElementById("orderValuefinal").value=0; 
                         funRoundAmt4(0,"txtnettotal");
                         funRoundAmt4(0,"st");
                       	 funRoundAmt4(0,"taxtotal");
                   		 funcalutax();
                 	}
                 	else{
                 		var totalsum=0,discountsum=0,taxamountsum=0,taxpersum=0;
                 		for(var i=0;i<rowlength;i++){
                 			var totalchk=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "total");
                 			var discountchk=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "dis");
                 			var taxamountchk=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "taxamount");
                 			var taxpersumchk=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "taxperamt");
                 			totalsum=parseFloat(totalsum)+parseFloat(totalchk);
                 			discountsum=parseFloat(discountsum)+parseFloat(discountchk);
                 			taxamountsum=parseFloat(taxamountsum)+parseFloat(taxamountchk);
                 			taxpersum=parseFloat(taxpersum)+parseFloat(taxpersumchk);
                 		}
                 		//alert("totalsum=="+totalsum+"==discountsum=="+discountsum+"==taxamountsum=="+taxamountsum);
                 		funRoundAmt4(discountsum,"txtdiscount");
                 		funRoundAmt4(totalsum,"txtproductamt");
                 		funRoundAmt4(taxamountsum,"txtnettotal");
                 		funRoundAmt4(taxamountsum,"orderValue");
                 		funRoundAmt4(taxamountsum,"orderValuefinal");
                         funRoundAmt4(taxpersum,"st");
                       	 funRoundAmt4(taxpersum,"taxtotal");
                 	}
           		  
                   }
               });
               
               $("#jqxSalesOrder").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		  
                       $("#jqxSalesOrder").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   
        		   }
               });
 
         
          
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
     
    	  
    	  $('#jqxSalesOrder').jqxGrid('showcolumn', 'brandname');
    
    	  
    	  
        }
          else
      {
      
        	  $('#jqxSalesOrder').jqxGrid('hidecolumn', 'brandname');
      
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
    	 
    	  
    	  $('#tax').hide();
    	  
    	  
    	  $('#billname').show();
    	  $('#cmbbilltype').show();
    	  
    	 
    	  
    	  
    	  $('#jqxSalesOrder').jqxGrid('showcolumn', 'taxper');
    	  $('#jqxSalesOrder').jqxGrid('showcolumn', 'taxamount');
    
    	  
    	  
        }
          else
      {
        	  $('#tax').hide();
        	  
        	  $('#billname').hide();
        	  $('#cmbbilltype').hide();
        	  
        	  
        	  $('#jqxSalesOrder').jqxGrid('hidecolumn', 'taxper');
        	  $('#jqxSalesOrder').jqxGrid('hidecolumn', 'taxamount');
      
      }
      
       }}
   x.open("GET","checktax.jsp?",true); 
	x.send();
} 
      
function chkbatch()
{
 
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
   if (x.readyState==4 && x.status==200)
    {
      var items= x.responseText.trim();
      var item = items.split('::');

      var batch=item[0];
      var expdate=item[1];
      var pmgt=item[2];
     // alert("==pmgt==="+pmgt);
      var focvalidate=item[3];
      			
      var multi=item[4];
      if(parseInt(pmgt)>0)
    	{
  	 // alert("==pmgt==="+pmgt);
  	  $('#pmgt').val(1);
  	 // document.getElementById("pmgt").value=1;
     	}
       else
   	{
      	 $('#pmgt').val(0); 
      	 //document.getElementById("pmgt").value=0;	 
   	}
      
      if(parseInt(multi)>0)
      {
    	  
    	  document.getElementById("multichk").value=1;
    	  $('.ff1').show();
    	  
      	 
    	  
       }
         else
     {
        	  $('.ff1').hide();
        	 
        	 document.getElementById("multichk").value=0;
     }
     
      
      
      
      
      if(parseInt(batch)>0)  
       {
    	 
    	  document.getElementById("batchno").value=1;
    	  document.getElementById("batchchk").value=1;
    
        }
          else
      {
        	  $('.ff1').hide();
        	  document.getElementById("batchchk").value=0;
      }
      
      
      
      if(parseInt(focvalidate)>0)  
       {
    	 
    	  document.getElementById("focvalidate").value=1;
    
        }
          else
      {
        	 
        	  document.getElementById("focvalidate").value=0;
      }
      
      
      if(parseInt(expdate)>0)
      {
    	  document.getElementById("expdate").value=1;
    	  document.getElementById("expchk").value=1;
       }
         else
     {
        	 document.getElementById("expchk").value=0;
        	 
     }
     
      
       
      
       }}
   x.open("GET","checkbatch.jsp?",true);
	x.send();
 
      
        
	
} 


 

      
</script>
      <div id='jqxWidget'>
  
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>  
    
<div id="jqxSalesOrder"></div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">r
<input type="hidden" id="batchno">
<input type="hidden" id="expdate">
<input type="hidden" id="focvalidate">
<input type="hidden" id="datas2"><!--  discount set at a time cellvalue change not working; -->

<input type="hidden" id="rowvalss">

<input type="hidden" id="datas3">




 
