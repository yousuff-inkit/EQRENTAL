 <%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Refund Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../../../../travelIncludes.jsp"></jsp:include>        
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />

  <style type="text/css">  
  .hidden-scrollbar {
    overflow: auto; 
    height: 600px;
   }  
    .modal-header,.modal-footer {     
           background-color:#fff091;    
    } 
    .modal-body { 
           background-color:#fcf9c0;         
    }  
  .rowspace { 
        border-collapse:separate; 
        border-spacing:0 5px;       
    } 
  
   @media (min-width: 900px) {  
  .modal-xl {
    width: 100%;  
   max-width:1200px;  
  }
}
   
  .textclient{
   color:blue;
  } 
     .custompanel{ 
      float: left;
      display: inline-block;
      //margin-top: 10px; 
      padding-top: 12px;
      padding-bottom: 10px;    
      border-radius: 8px;
    }
    .textpanel{
    	color: blue;   
  		overflow:auto;
  		width:500px;   
  		height:50px;
  		padding-top: 10px;
      	padding-bottom: 3px;
  	} 
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: #fff;
      clear:both;
      float: right;
      display: block;
      padding-top: 8px;
      padding-bottom: 2px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 12px;
      border-top-right-radius: 0;
      margin-bottom: 8px;
      transition:all 0.5s ease-in;
    }
    .msg-details{  
      text-align: right;
    }
    .comments-container{
      height: 400px;
      overflow-y: auto;
      margin-bottom: 8px;
      padding-right: 5px;
    }
    .comments-outer-container{
      width: 100%;
      height: 100%;
    }
    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
     .datepanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-bottom: 10px;
      padding-right: 10px;
      padding-left: 10px;
    }
     .padding0
    {
    padding:0 !important;
    }
     label{
    font-weight:400;
    }
    .btnStyle{  
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    user-select: none;
	    box-shadow: 0px 2px 3px 0.1px rgba(0, 0, 0, 0.6);              
	    position: relative;
	   -webkit-transition: all 0.3s;
	   -moz-transition: all 0.3s;
	   transition: all 0.3s;
  }
  </style>   
</head>       
<body onload="getBranch();">              
  <form autocomplete="off" id="frmrefundmanagement" action="saveRefundManagement" method="POST">            
  <div class="container-fluid">
        <div class="row">   
	      <div class="col-md-4 padding0" style=" border: 1px solid #ccc; margin: 5px; border-radius: 10px; ">        
	        <div class="datepanel">
				   <div class="col-md-6 padding0">  
						<label for="cmbtype" class="col-md-3">Branch</label>    
						<div class="col-md-9">
							<select id="cmbbranch" name="cmbbranch"  value='<s:property value="cmbbranch"/>' onchange="funsessionbrchset();" class="form-control input-sm" style="height:27px;"></select>    
							<input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/>        
						</div>      
				  </div>
				  <div class="col-md-6 padding0">       
						<label for="cmbtype" class="col-md-4">Up To</label>        
						<div class="col-md-7">
						   <div id="todate"></div>    
						</div>      
				  </div>
			</div>   
		 </div>  
         <div class="col-md-3 padding0">    
             <div class="primarypanel custompanel">                          
	  			&nbsp;<button type="button" class="btn btn-default  btnStyle" id="btnsubmit" data-tooltip="tooltip"  title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>       
	          	<button type="button" class="btn btn-default  btnStyle" id="btnexcel" data-tooltip="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
	            <button type="button" class="btn btn-default  btnStyle" id="btnsave"  data-tooltip="tooltip" title="Save" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
	            <button type="button" class="btn btn-default  btnStyle" id="btncreditnote"  data-tooltip="tooltip" title="Tax Credit Note Create" data-placement="bottom"><i class="fa fa-file-text-o " aria-hidden="true"></i></button>
                <button type="button" class="btn btn-default  btnStyle" id="btndebitnote"  data-tooltip="tooltip" title="Tax Debit Note Create" data-placement="bottom"><i class="fa fa-file-text " aria-hidden="true"></i></button>
                <button type="button" class="btn btn-default  btnStyle" id="btnconfirm"  data-tooltip="tooltip" title="Confirm" data-placement="bottom"><i class="fa fa-check-circle " aria-hidden="true"></i></button>
            </div>        
          </div>   
    </div>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 padding0">                                               
        <div id="rrdiv" style="padding-bottom:3px;"><jsp:include page="refundGrid.jsp"></jsp:include></div>  
        <div id="rrsubdiv"><jsp:include page="refundSubGrid.jsp"></jsp:include></div>    
      </div>
    </div>   
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>             
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>    
<input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'/>  
<input type="hidden" name="rrdocno" id="rrdocno"  value='<s:property value="rrdocno"/>'/>  
<input type="hidden" name="reftype" id="reftype"  value='<s:property value="reftype"/>'/>        
</div>
</form>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){ 
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
		 $("#todate").jqxDateTimeInput({ width: '102px', height: '25px',formatString:"dd.MM.yyyy"});
    	 $('[data-toggle="tooltip"]').tooltip(); 
         //$('.cmbbaymovupdate,.cmbbaystatus,.cmbbaystatusupdate').select2();
        document.getElementById("mode").value="VIEW";
        $('#btnsubmit').click(function(){    
        	 $('#rrdocno').val(''); 
        	 $('#jqxrefundSubGrid').jqxGrid('clear');  
		     $('#jqxrefundGrid').jqxGrid('clear');   
		     funload();
        }); 
        $('#btnexcel').click(function(){                
	        $("#rrdiv").excelexportjs({
	        	containerid: "rrdiv", 
	        	datatype: 'json',
	        	dataset: null,
	        	gridId: "jqxrefundGrid",
	        	columns: getColumns("jqxrefundGrid") ,
	        	worksheetName:"Refund Management"
	          });
        });        
        $('#btnconfirm').click(function(){ 
             if($('#rrdocno').val()==''){   
                 swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document'               
					});
					return false;
             }  
		     funconfirm();  
        });
        $('#btnsave').click(function(){ 
		     funUpdate();
        });
        $('#btncreditnote').click(function(){ 
        funsessionbrchset();    
		     funCreateTCN();    
        });
        $('#btndebitnote').click(function(){ 
        funsessionbrchset();       
		     funCreateTDN();    
        });
        if($("#msg").val()=="Successfully Saved"){  
                swal({
						type: 'success',
						title: 'Success',
						text: ''+$('#msg').val()            
					});
					//funload();
                $('#jqxrefundSubGrid').jqxGrid('clear');    
   		        $('#jqxrefundGrid').jqxGrid('clear'); 
	     }else if($("#msg").val()=="Not Saved") {   
	           swal({
						type: 'error',   
						title: 'Error',
						text: ''+$('#msg').val()         
					});
					//funload();
	            $('#jqxrefundSubGrid').jqxGrid('clear');  
			    $('#jqxrefundGrid').jqxGrid('clear'); 
	     }else{}
         $('.warningpanel div button').click(function(){
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
        	}
        	else{   
        		$('#jqxrefundGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
    function SearchContent(url,id){   
	    $.get(url).done(function (data) {
	  	$('#'+id).jqxWindow('setContent', data);
		}); 
	} 
    
    function addGridFilters(filtervalue,datafield){
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	var filtercondition = 'equal';
    	var filter1 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);
    	/*filtervalue = 'Andrew';
    	filtercondition = 'starts_with';
    	var filter2 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);*/

    	filtergroup.addfilter(filter_or_operator, filter1);
    	//filtergroup.addfilter(filter_or_operator, filter2);
    	// add the filters.
    	$("#jqxrefundGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.        
    	$("#jqxrefundGrid").jqxGrid('applyfilters');
 	}
	 function funload(){   
		 $("#overlay, #PleaseWait").show();                        
      	 var brhid=document.getElementById("cmbbranch").value; 
    	 var todate=$('#todate').jqxDateTimeInput('val');   
         $('#rrdiv').load('refundGrid.jsp?check=1'+'&brhid='+brhid+'&todate='+todate);   
	 }
	  function funreload(){      
		 $("#overlay, #PleaseWait").show();                            
      	 var rrdocno=document.getElementById("rrdocno").value;  
      	 var reftype=document.getElementById("reftype").value;  
         $('#rrsubdiv').load('refundSubGrid.jsp?check=1'+'&docno='+rrdocno+'&reftype='+encodeURIComponent(reftype));                  
	 }
	 function getBranch() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var branchIdItems  = items[0].split(",");
				var branchItems = items[1].split(",");
				var perm = items[2];
				var optionsbranch;
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
							+ branchItems[i] + '</option>';
				}
				$("select#cmbbranch").html(optionsbranch);  
				if ($('#hidcmbbranch').val() != null && $('#hidcmbbranch').val() != "") {
					$('#cmbbranch').val($('#hidcmbbranch').val());   
				}
				funsessionbrchset(); 
			} else {
			}  
		}
		x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);  
		x.send();
	}
	
function funUpdate(){  
	var docno=document.getElementById("rrdocno").value;  
	//alert("docno==="+docno);                    
	if(docno=="" || docno=="0"){    
		swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select documents..'            
					});
			  return false;
	}     
   //$("#overlay, #PleaseWait").show();           
		   var rows = $("#jqxrefundSubGrid").jqxGrid('getrows');   
		   var rowindex=0,val=0;    
		   for(var i=0;i<rows.length;i++){   
			   var chks=rows[i].dtype; 
			   var ctrno=rows[i].ctrno;
			   var dtrno=rows[i].dtrno;
			   if(parseInt(ctrno)>0 || parseInt(dtrno)>0){
			      val=1;
			      break;
			   }   
			   var id1=0,id2=0,id3=0;
			   if(rows[i].sinclusive){
			     id1=1;
			   }else{
			     id1=0;
			   }
			   if(rows[i].pinclusive){    
			     id2=1;
			   }else{
			     id2=0;
			   }
			   if(rows[i].pstock){        
			     id3=1;
			   }else{
			     id3=0;
			   }
			   if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){  
					newTextBox = $(document.createElement("input"))
				       .attr("type", "dil")
				       .attr("id", "test"+i)  
				       .attr("name", "test"+i)      
				       .attr("hidden", "true");  
			   newTextBox.val(rows[i].rowno+" :: "+ rows[i].dtype+" :: "+ rows[i].srvalue +" :: "+id1+" :: "+rows[i].svalue+" :: "+rows[i].svat+" ::"+rows[i].stotal+" :: "+rows[i].prvalue+" :: "+id2+" :: "+rows[i].pvalue+" :: "+rows[i].pvat+" :: "+rows[i].ptotal+" :: "+id3+" :: "+rows[i].refrowno+" :: "+rows[i].expdate+" :: ");  
			   newTextBox.appendTo('form');                            
			   rowindex++;         
			   $('#gridlength').val(rowindex);      
		 	   }               
		   }
		   if(val==1){
		      swal({
						type: 'warning',
						title: 'Warning',
						text: 'Tax credit note or tax debit note already created. You cannot change values again!'                 
					});
			  return false;
		   }
		   document.getElementById("mode").value="A";             
		   document.getElementById("frmrefundmanagement").submit();         
   }
   function funCreateTCN(){ 
                var docno=document.getElementById("rrdocno").value;  
				var gridarray=new Array(); 
				var gridarray2=new Array();  
			    var gridarray3=new Array();     
				if(docno==''){  
					swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
					 return 0;
				 }
				var val=0,rowval=0;
				var total=0.0;    
				var rows = $("#jqxrefundSubGrid").jqxGrid('getrows'); 
				   for(var i=0 ; i < rows.length ; i++){ 
				       var ctrno=rows[i].ctrno;  
				       var chks=rows[i].rowno;
				       var stotal=rows[i].stotal;
				       if(typeof(stotal) != "undefined" && typeof(stotal) != "NaN" && stotal != "" && stotal != null){     
				         total=total+stotal;        
				       }
				       if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){
				         rowval=1;   
				       }
				       if(parseInt(ctrno)>0){
					      val=1;
					      break;
					   } 
					   var id1=0;   
					   if(rows[i].sinclusive){
					     id1=1;
					   }else{
					     id1=0;
					   }   
					   gridarray2.push(rows[i].rowno);
					   gridarray3.push(rows[i].srvalue +" :: "+id1+" :: "+rows[i].svalue+" :: "+rows[i].svat+" ::"+rows[i].stotal+" ::"+rows[i].rowno);                                
					   gridarray.push(rows[i].accdocno+"::"+1+"::"+1+"::"+true+"::"+rows[i].svalue+"::"+rows[i].remarks+"::"+rows[i].svalue+":: "+""+":: "+""+":: "+5+":: "+rows[i].svat+":: "+rows[i].stotal+":: "+rows[i].taxacno+":: "+rows[i].svat);  
				   }
				   if(rowval==0){
					   swal({ 
							type: 'warning',
							title: 'Warning',
							text: 'Please save before creating tax credit note!'    
						});
						return false;   
					}   
				  if(val==1){           
				        swal({
								type: 'warning',
								title: 'Warning',
								text: 'Tax credit note already created!'                 
							});
					  return false;
				   } 
				   if(total==0 || total==0.0 || total==0.00){                  
				        swal({
								type: 'warning',
								title: 'Warning',
								text: 'Sales return total is zero!!!'                    
							});
					  return false;
				   }         
			   $.messager.confirm('Message', 'Do you want to create Tax Credit Note?', function(r){            
					     	if(r==false)
					     	  {
					     		return false; 
					     	  }  
					     	else {
					    	     saveCreditGridData(docno,gridarray,gridarray2,gridarray3);           
					     	}  
					 });      
			}
			function saveCreditGridData(docno,gridarray,gridarray2,gridarray3){         
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.split('###');       
				   if(parseInt(items[0])>=1)
					{
					   swal({
							type: 'success',
							title: 'Success',  
							text: 'TCN- '+items[1]+' Successfully Created '  
						});
						$('#jqxrefundSubGrid').jqxGrid('clear');  
						$('#jqxrefundGrid').jqxGrid('clear');      
						funload();
						funreload(); 
					}
					else
					{
						swal({
							type: 'error',
							title: 'Error',  
							text: ' Not Created '             
						});
					}
				}   
				}   
				x.open("GET","createCreditNote.jsp?rowarray="+gridarray2+"&gridarray="+gridarray+"&docno="+docno+"&updatearray="+gridarray3+"&reftype="+$('#reftype').val()+"&brhid="+$('#cmbbranch').val(),true);                                              
				x.send();
			}
			function funCreateTDN(){ 
                var docno=document.getElementById("rrdocno").value;  
				var mainarray1=new Array();    
				var mainarray2=new Array(); 
				var rownoarray1=new Array();     
				var rownoarray2=new Array(); 
				var gridarray3=new Array();         
				if(docno==''){  
					swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
					 return 0;
				 }  
				var rows = $("#jqxrefundSubGrid").jqxGrid('getrows'); 
				var val=0,rowval=0;   
				var total=0.0;                   
				   for(var i=0 ; i < rows.length ; i++){
				       var dtrno=rows[i].dtrno;
				       var chks=rows[i].rowno;
				       var ptotal=rows[i].ptotal;  
				       if(typeof(ptotal) != "undefined" && typeof(ptotal) != "NaN" && ptotal != "" && ptotal != null){   
				         total=total+ptotal;        
				       }
				       if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){
				         rowval=1;   
				       }  
				       if(parseInt(dtrno)>0){     
					      val=1;
					      break;
					   }
					   var id1=0,id3=0;   
					   if(rows[i].pinclusive){     
					     id1=1;
					   }else{
					     id1=0;
					   }   
					   if(rows[i].pstock){        
					     id3=1;
					   }else{
					     id3=0;
					   } 
					   gridarray3.push(rows[i].prvalue +" :: "+id1+" :: "+rows[i].pvalue+" :: "+rows[i].pvat+" ::"+rows[i].ptotal+" ::"+rows[i].rowno+" ::"+id3+" ::"+rows[i].expdate+" ::");              
					   if(rows[i].pstock){     
					   		mainarray2.push(rows[i].accdocno+"::"+1+"::"+1+"::"+true+"::"+rows[i].pvalue*-1+"::"+rows[i].remarks+"::"+rows[i].pvalue*-1+":: "+""+":: "+""+":: "+5+":: "+rows[i].pvat*-1+":: "+rows[i].ptotal+":: "+rows[i].taxacno+":: "+rows[i].pvat*-1);    
				            rownoarray2.push(rows[i].rowno);
				       }else{
				            mainarray1.push(rows[i].accdocno+"::"+1+"::"+1+"::"+true+"::"+rows[i].pvalue*-1+"::"+rows[i].remarks+"::"+rows[i].pvalue*-1+":: "+""+":: "+""+":: "+5+":: "+rows[i].pvat*-1+":: "+rows[i].ptotal+":: "+rows[i].taxacno+":: "+rows[i].pvat*-1);
				       		rownoarray1.push(rows[i].rowno);         
				       }       
				   }
				   if(rowval==0){
					   swal({
							type: 'warning',
							title: 'Warning',
							text: 'Please save before creating tax debit note!'    
						});
						return false;
					}  
				  if(val==1){           
				        swal({
								type: 'warning',
								title: 'Warning',
								text: 'Tax Debit note already created!'                
							});
					  return false;
				   }  
				     if(total==0 || total==0.0 || total==0.00){                    
				        swal({
								type: 'warning',
								title: 'Warning',
								text: 'Purchase return total is zero!!!'                      
							});
					  return false;
				   }     
			   $.messager.confirm('Message', 'Do you want to create Tax Debit Note?', function(r){                     
					     	if(r==false)
					     	  {
					     		return false; 
					     	  }  
					     	else {
					    	     saveDebitGridData(docno,mainarray1,mainarray2,rownoarray1,rownoarray2,gridarray3);              
					     	}  
					 });      
			}
			function saveDebitGridData(docno,mainarray1,mainarray2,rownoarray1,rownoarray2,gridarray3){              
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.split('###');       
				   if(parseInt(items[0])>=1)
					{
					   swal({
							type: 'success',
							title: 'Success',  
							text: 'TDN- '+items[1]+' Successfully Created '  
						});
						$('#jqxrefundSubGrid').jqxGrid('clear');  
						$('#jqxrefundGrid').jqxGrid('clear');      
						funload();
						funreload();    
					}
					else
					{
						swal({
							type: 'error',
							title: 'Error',  
							text: ' Not Created '                               
						});
					}
				}   
				}   
				x.open("GET","createDebitNote.jsp?rownoarray1="+rownoarray1+"&rownoarray2="+rownoarray2+"&mainarray1="+mainarray1+"&mainarray2="+mainarray2+"&docno="+docno+"&updatearray="+gridarray3+"&reftype="+$('#reftype').val()+"&brhid="+$('#cmbbranch').val(),true);                                          
				x.send();
			}   
			function funsessionbrchset(){   
			  var branch=$('#cmbbranch').val();  
			  $.ajax({
				  url: "setBranch.jsp",
				  type: "post",
				  data: {branch:branch},
				  success: function(){
				  },
				  error:function(){
				  }   
				}); 
			}
			function funconfirm(){   
			  var rrdocno=$('#rrdocno').val();    
			  $.ajax({
				  url: "saveConfirm.jsp",  
				  type: "post",
				  data: {docno:rrdocno},  
				  success: function(v){
				  if(parseInt(v)>0){  
				     swal({
							type: 'success',  
							title: 'Success',  
							text: ' Successfully Confirmed '               
						});
						$('#jqxrefundSubGrid').jqxGrid('clear');  
						$('#jqxrefundGrid').jqxGrid('clear');      
						funload();  
				  }else{
				     swal({
							type: 'error',
							title: 'Error',  
							text: ' Not Confirmed '               
						});
				  }
				  },
				  error:function(){  
				  }     
				}); 
			}
			
  </script>
</body>
</html>
