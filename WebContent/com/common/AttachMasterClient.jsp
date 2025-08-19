 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <jsp:include page="../../includes.jsp"></jsp:include>
 --%>
<meta name="google" content="notranslate">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<link href="../../customerlogin/css/util.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="/js/resample.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
<%
	String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); 
	String formcode = request.getParameter("formCode")==null?"NA":request.getParameter("formCode"); 
	String brchid = request.getParameter("brchid")==null?"0":request.getParameter("brchid"); 
	String frmname = request.getParameter("frmname")==null?"":request.getParameter("frmname"); 
	System.out.println(docNo+"::"+formcode+"::"+brchid+"::"+frmname);
%>
<style type="text/css">
	@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
	@import url(https://fonts.googleapis.com/css?family=Teko:700);
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('../../customerlogin/fonts/poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('../../customerlogin/fonts/poppins/Poppins-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-Medium;
	  	src: url('../../customerlogin/fonts/montserrat/Montserrat-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-SemiBold;
	  	src: url('../../customerlogin/fonts/montserrat/Montserrat-SemiBold.ttf'); 
	}
	* {
		margin: 0px; 
		padding: 0px; 
		box-sizing: border-box;
	}
	html,body{
		width:100%;
		height:100%;
		background-color:#E9E9E9;
		font-family: Poppins-Regular, sans-serif;
	}
	.upload-container{
		background-color:#fff;
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
	}
	.upload-container .upload-part1{
		float: left;
		display: inline-block;
		width: 40%;
	}
	.upload-container .upload-part2 .panel{
		max-height: 315px;
	}
	@media (max-width: 767px) {
	    /* CSS goes here */
		.upload-container .upload-part1{
			clear: both;
			display: block;
			width: 100%;
			padding-bottom: 15px;
			margin-left: 10px;
		}
	}
	.help-block;
 </style>

	<script type="text/javascript">
	$(document).ready(function(){
		 $('#btnAttachDelete').hide(); 
		var masterdocno='<%=docNo%>';
		var formcode='<%=formcode%>';
		
		var brchid='<%=brchid%>';
		var frmname='<%=frmname%>';
		if(masterdocno>0)
			{
			document.getElementById("docno").value=masterdocno;
			}
		if(formcode!='NA')
			{
			document.getElementById("formdetailcode").value=formcode;
			}
		if(brchid>0)
		{
		document.getElementById("brchid").value=brchid;
		}
		if(frmname!="")
			{
			document.getElementById("frmnames").innerText=frmname;
			document.getElementById("formnames").value=frmname;
			
			}
		
		
		getRefType();
		 var indexVal2 = document.getElementById("docno").value;
		 

    	  
         //$("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value+"&brchid="+brchid);
			
	
		$('#file').change(function(){
			var files = $(this)[0].files;
			if(files.length>0){
				$('.help-block').css('display','block').text('You have selected '+$(this).val().split('\\').pop());	
			}
			else{
				$('.help-block').css('display','none').text('');
			}
			
		});
			
	});	
	
	 
	 function ajaxFileUpload()  
	      {  
		   var reftypid=document.getElementById("reftypid").value;
			    //check whether browser fully supports all File API
			    if (window.File && window.FileReader && window.FileList && window.Blob)
			    {
			        //get the file size and file type from file input field
			        var fsize = $('#file')[0].files[0].size;
			        
			         
			    }else{
			    	//$.messager.alert('Message','Please upgrade your browser, because your current browser lacks some new features we need!','warning');
			    	 /*$.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        });*/
	                Swal.fire({
						type: 'warning',
					  	title: 'Please upgrade your browser',
					  	text: 'because your current browser lacks some new features we need!'
					}); 
			        return;
			    }
			
	          $.ajaxFileUpload  
	          (  
	              {  
	                  url:'fileAttachActionmasterClient.action?formCode=<%=request.getParameter("formCode")%>&doc_no=<%=request.getParameter("docno")%>&descpt='+$("#txtdesc").val()+'&reftypid='+$("#reftypid").val()+'&hidchkclientview=1' ,
	                  secureuri:false,//false  
	                  fileElementId:'file',//id  <input type="file" id="file" name="file" />  
	                  dataType: 'json',// json  
	                  success: function (data, status)  //  
	                  {  
	                      //alert(data.message);//jsonmessage,messagestruts2
	                 	
	               //       $('#refreshdiv').load();
	                      <%-- var data='<%= com.common.ClsAttach.reload(docNo) %>';
	                      alert("============="+data); --%>
	                     if(status=='success'){
	                        // funAttachBtn();
	                        /* $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        });*/
	                        Swal.fire({
								type: 'success',
							  	title: 'Successfully Uploaded',
							  	text: 'Attachment Uploaded'
							});
							$('#txtdesc').val('');
	                      }
	                     
	                      $("#testImg").attr("src",data.message);
	                      if(typeof(data.error) != 'undefined')  
	                      {  
	                          if(data.error != '')  
	                          {  
	                              //$.messager.alert('Message',data.error);
	                            /*  $.messager.show({title:'Message',msg: data.error,showType:'show',
	  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	  	                        });*/
	  	                        Swal.fire({
									type: 'error',
								  	title: 'Something went wrong',
								  	text: data.error
								}); 
	                          }else  
	                          {  
	                              //$.messager.alert('Message',data.message);
	                              /*$.messager.show({title:'Message',msg: data.message,showType:'show',
		  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		  	                        });*/
		  	                        Swal.fire({
										type: 'success',
									  	title: data.message
									}); 
	                          }  
	                      }  
	                  },  
	                  error: function (data, status, e)//  
	                  {  
	                      //alert(e);  
	                      //$.messager.alert('Message',e);
	                      Swal.fire({
										type: 'success',
									  	title: e
									}); 
	                  }  
	              }  
	          )  
	          return false;  
	      }
	
	 function reload(){
		$("#jqxDocumentsAttach").jqxGrid('updatebounddata', 'sort');
		
		<%--  $('#jqxDocumentsAttach').jqxGrid('refreshdata');
		 //Thread.sleep(10000);
		 $("#jqxDocumentsAttach").jqxGrid('addrow', null, <%= com.common.ClsAttach.reload(docNo)%>);
		 $("#jqxDocumentsAttach").jqxGrid('addrow', null, <%= com.common.ClsAttach.reload(docNo)%>); --%>
	 }
 
	function SaveToDisk(fileURL, fileName) {
	 // alert(fileURL);
	   //fileName='';
	   var host = window.location.origin;
	   //alert("hooosssst"+host);
	  
	   var splt = fileURL.split("webapps"); 
	  //alert("after split"+splt[1]);
	   var repl = splt[1].replace( /;/g, "/");
	   //alert("repl"+repl);
	   //alert("after replace===="+repl);
	   fileURL=host+repl;
	   //alert("fileURL===="+fileURL);
	    // for non-IE
	    if (!window.ActiveXObject) {
	        var save = document.createElement('a');
	        //alert(save);
	       // alert(fileURL);
	        save.href = fileURL;
	        save.target = '_blank';
	        save.download = fileName || 'unknown';
			
	        window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
	        
	        //var event = document.createEvent('Event');
	       // alert(event);
	        //event.initEvent('click', true, true);
	        //save.dispatchEvent(event);
	        //(window.URL || window.webkitURL).revokeObjectURL(save.href);
	    }

	    // for IE
	    else if ( !! window.ActiveXObject && document.execCommand)     {
	        var _window = window.open(fileURL, '_blank');
	        _window.document.close();
	        _window.document.execCommand('SaveAs', true, fileName || fileURL)
	        _window.close();
	    }
	}
	
	function Delete(){
	    var filename=document.getElementById("filename").value;
	    /* var spltname = filename.split(".");
	    alert("==spltname==="+spltname[0]); */
	    <%-- alert("==filename=="+filename);
	    var dtype=<%=request.getParameter("formCode")%>;
	    alert("==dtype=="+dtype);
	    var doc_no=<%=request.getParameter("docno")%>;
	     --%>
	   
	    //alert("==doc_no=="+doc_no);
	 var x=new XMLHttpRequest();
	 var items,brchItems,currItems,mcloseItems;
	 x.onreadystatechange=function(){
	  if (x.readyState==4 && x.status==200)
	   {
	         items= x.responseText;
	         if(items>0){
	        	 var indexVal2 = document.getElementById("docno").value;
	    		 

	       	  
	             $("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value);
	        	  $.messager.alert('Message','Successfully Deleted');
	        	/*  $.messager.show({title:'Message',msg:'Successfully Deleted',showType:'show',
                     style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                 }); */ 
	         }
	         else{
	  		  $.messager.alert('Message','Not Deleted');
	  	/* 	 $.messager.show({title:'Message',msg:'Not Deleted',showType:'show',
                 style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
             });  */
	  	     }
	      }
	  else
	   {}
	 }
	 x.open("GET",<%=contextPath+"/"%>+"fileAttachDelete.jsp?filename="+filename,true);
	 x.send();
	}
	
	 function saveViaAJAX()
	 {
		 
		
		 var testCanvas =null;
		 var formname=document.getElementById("formdetailcode").value;
		 var docno=document.getElementById("docno").value;
		 var reftypid=document.getElementById("reftype").value;
		 if(docno==""){
			 document.getElementById("errormsg").innerText="Please Select a Document Number";
	  		 return false;
		 }
		 var iscapture=document.getElementById("iscapture").value;
			
			if(iscapture==1){
				 testCanvas = document.getElementById("canvasids"); 
			}
			else{
				testCanvas = document.getElementById("canvasid");  
				
			}
			
		  
		 	var canvasData = testCanvas.toDataURL("image/png");
		 	
		 	var postData = "canvasData="+canvasData;
	 	//var canvasData = testCanvas.toDataURL("image/png");
	 	
	 	
	 	var ajax = new XMLHttpRequest();
	 	ajax.open("POST",<%=contextPath+"/"%>+'saveImages.jsp?formname='+formname+'&docno='+docno+'&descpt='+$("#txtdesc").val()+'&reftypid='+reftypid,true);    
	 	ajax.setRequestHeader('Content-Type', 'canvas/upload');
	 	
	 	ajax.onreadystatechange=function()
	   	{
	 		if (ajax.readyState == 4)
	 		{ 
	 			//document.getElementById("savemsg").innerText="Successfully Attached";
	 			/*  
	 			 $.messager.show({title:'Message',msg:'Successfully Attached',showType:'show',
                     style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                 });
	 			 
	 			 
	 			  */
	 			 var indexVal2 = document.getElementById("docno").value;
	 			   
	 	         $("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value);
	 			 
	    	 $.messager.alert('Message',"Successfully Attached");
	    		 
	 			//alert(ajax.responseText);
	 			// Write out the filename.
	     		
	 		}
	   	}

	 	ajax.send(postData);  
	 }

function upload(){
	var iscapture=document.getElementById("iscapture").value;
	
	if(iscapture==1){
		saveViaAJAX();
	}
	else{
		
		 var path=document.getElementById("file").value;
		 var fsize = $('#file')[0].files[0].size;
		 //alert(fsize);
		 var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
		 //alert(extn);
		 if((extn=='jpg')||(extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='JPG')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP'))
	        {
			 
			 if(fsize>1048576)
				 { 
				 saveViaAJAX();
				 }
			 else{
		        	ajaxFileUpload();	
		        }
			 
			 
	        }
	        else{
	        	ajaxFileUpload();	
	        }
	}
		 
	 }
	 
	 
	 
function loading(){
	document.getElementById("iscapture").value=0;
	var path=document.getElementById("file").value;
	 var fsize = $('#file')[0].files[0].size;
	 //alert(fsize);
	 var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
	
	 if((extn=='jpg')||(extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='JPG')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP'))
       {
		 
		 if(fsize>1048576)
			 {
			 document.getElementById("errormsg").innerText="Please Wait......";
			 }
		 
		 
		 
       }
      
	
	
}

function comonsnapshotWindow()
{

	 document.getElementById("iscapture").value=1;
	 
    window.open(<%=contextPath+"/"%>+"com/common/snapshot.jsp", "CommonCamera",'menubar=0,resizable=1,width=400,height=440, top=50, left=380');
     
    
}


function getRefType()
{	
	
	var dtype=document.getElementById("formdetailcode").value;
	
var x=new XMLHttpRequest();
var items,refname,refcode,refdocno;
x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{  
        items= x.responseText;
        items=items.split('####');

        
        
        refname=items[0].split(",");
        refcode=items[1].split(",");
        refdocno=items[2].split(",");
        	var optionref = '';
        	var optionscurr = '';
       for ( var i = 0; i < refname.length; i++) {
    	   
    	   
    	   getRef(refname[0]);
    	   optionref += '<option value="' + refdocno[i] + '">' + refname[i] + '</option>';
    	  
        }
       $("select#reftype").html(optionref); 
       
        	
        }
	else
		{
		}
}
x.open("GET",<%=contextPath+"/"%>+"com/common/getRefType.jsp?dtype="+dtype,true);
x.send();
}


function getRef(c){

	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText;
		 	items = items.split('####');
		 	
		 		var reftype = items[0].split(",");
		 		var refcode  = items[1].split(",");
		 		var refdocno  = items[2].split(",");
		 		document.getElementById("reftypid").value=refdocno;
		    }
	       else
		  {}
     }
      x.open("GET", <%=contextPath+"/"%>+"com/common/getRef.jsp?reftype="+c,true);
     x.send();
    
   }
function formsub()
{
var iscapture=document.getElementById("iscapture").value;
	
	if(iscapture==1){
		saveViaAJAX();
	}
	else
		{
	
	 
    if (window.File && window.FileReader && window.FileList && window.Blob)
	    {
	         
	        var fsize = $('#file')[0].files[0].size;
	        
	        if(fsize>10380902) //do something if file size more than 1 mb (1048576)
	        {
	        	 
	            $.messager.alert('Message',fsize +' bytes too big ! Maximum Size 9.9 MB!','warning');
	              
	            return false;
	        }
	        else
	        	{
	        	 
	        	  $( "#from1").submit();
	        	}
	        return false;
	    } 
	  
		}
	}
	 
	function setValuess()
	{
		
		if($('#msgs').val()!=""){
	 		   //$.messager.alert('Message',$('#msgs').val());
	 		  Swal.fire({
				type: 'success',
			  	title: $('#msgs').val()
			}); 
	 		  $('#msgs').val('');
	 		  }
		
	}
	function funvalidate(){ 
		if($('#file').val()==''){
			Swal.fire({
				type: 'warning',
			  	title: 'Please Choose a File',
			  	text: 'By clicking on "Upload"'
			}); 
			return false;
		}
		var desc=$('#txtdesc').val();   
		if(desc==""){
			$('.form-group').addClass('has-error');
			$('.help-block').css('display','block').text('Description is mandatory');
			$( "#txtdesc" ).focus();
			//$.messager.alert('Message','Please Enter Description.','warning');
	  		return false;    
		}else{
			if($('.form-group').hasClass('has-error')){
				$('.form-group').removeClass('has-error');
				$('.help-block').text('You have selected '+$('#file').val().split('\\').pop());	
			}
			
			formsub();	
		}              
	}
	
	
	function getClientAttachData(){
		var refdocno='<%=request.getParameter("docno")==null?"0":request.getParameter("docno")%>';
		var reftype='<%=request.getParameter("formCode")==null?"0":request.getParameter("formCode")%>';
		if($('#docno').val()!='' && $('#docno').val()!=null && $('#docno').val()!='undefined'){
			refdocno=$('#docno').val();
			reftype=$('#formdetailcode').val();
		}
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var attachrawdata=x.responseText.trim();
				attachrawdata=JSON.parse(attachrawdata);
				var attachhtml='';
  				$.each(attachrawdata.attachdata, function( index, value ) {
  					attachhtml+='<tr data-path="'+value.split("***")[5]+'" data-filename="'+value.split("***")[4]+'">';
  					attachhtml+='<td>'+value.split("***")[0]+'</td>';
  					attachhtml+='<td>'+value.split("***")[4]+'</td>';
  					attachhtml+='<td>'+value.split("***")[3]+'</td>';
  					attachhtml+='<td align="center"><a href="#"><i class="fa fa-eye"></i></a></td>';
  					attachhtml+='</tr>';
				});
				$('#tblattach tbody').html($.parseHTML(attachhtml));
				document.querySelectorAll('#tblattach tbody tr td a')
					.forEach(e => e.addEventListener("click", clickViewAttachHandler));
					
			}
			else  
			{
			}    
		}
		x.open("GET","getClientAttachData.jsp?refdocno="+refdocno+"&reftype="+reftype,true);
		x.send();
	}
	function funAttachDelete(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::")[0];
				if(items>0){
					  //$('#btnAttachDelete').show();   
				}
				else{
					  $('#btnAttachDelete').hide();     
				}
					
			}
			else  
			{
			}    
		}
		x.open("GET","getAttachDelete.jsp",true);
		x.send();
	}	 
	
	function clickViewAttachHandler(){
		// Here, `this` refers to the element the event was hooked on
		var filename=$(this).closest('tr').attr('data-filename');
		var path=$(this).closest('tr').attr('data-path');
		document.getElementById("filename").value=filename;
		SaveToDisk(path,filename);
		return false;
	}
	function funTriggerUpload(){
		$('#file').trigger('click');
		return false;
	}
	
	
</script>   
<body onload="setValuess();funAttachDelete();getClientAttachData();">
<form action="fileAttachActionmasterClient" id="from1" method="post" enctype="multipart/form-data">
	<div class="upload-container img-rounded col-md-8 col-md-offset-2 col-sm-12  m-t-50 container-fluid p-b-5 p-t-5 m-l-10 m-r-10">
		<div class="upload-part1 container-fluid">
			<div class="upload-img-wrap text-center">
				<img src="../../customerlogin/images/upload-bg.jpg" class="img-responsive">
			</div>
			<div class="upload-controls text-center">
				<input type="file" id="file" name="file" onChange="return loading();" style="display:none;"/>
				<p>Lets <a href="#" style="color:rgba(88,103,221,1);" onclick="funTriggerUpload();">Upload</a> your attachments</p>
				<div class="form-group">
					<div class="input-group">
	    				<input type="text" class="form-control" name="txtdesc" id="txtdesc" placeholder="Description" value='<s:property value="txtdesc"/>'>
	    				<div class="input-group-btn">
	      					<button class="btn btn-default" type="button" id="alttachsss" onclick="funvalidate();">
	        					<i class="fa fa-cloud-upload"></i>
	      					</button>
	    				</div>
	  				</div>
	  				<span class="help-block"></span>			
				</div>
			</div>
		</div>
		<div class="upload-part2 container-fluid">
			<div class="panel panel-default table-responsive m-t-10 m-l-10">
				<table class="table table-hover" id="tblattach">
					<thead>
						<tr>
							<th>Sr.No</th>
							<th>File Name</th>
							<th>Description</th>
							<th>View</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="4" align="center">No Results Found</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<label id="frmnames" name="frmnames" style="color:blue;font-weight:bold;font-size:14px;display:none;">
		<s:property value="frmnames"/>
	</label>
	<button class="icon" id="btnDownload" title="Download" onclick="funUrl();" style="display:none;">
		<img alt="dwdDocument" src="<%=contextPath%>/icons/images.png">
	</button>
	<button class="icon" id="btnAttachDelete" title="Delete current Document" onclick="Delete();" style="display:none;">
		<img alt="deleteDocument" src="<%=contextPath%>/icons/attachdelete.png">
	</button>
	<button class="icon" id="click" title="Take SnapShot " onclick="comonsnapshotWindow();" style="display:none;">
		<img alt="deleteDocument" src="<%=contextPath%>/icons/asnapshot.png">
	</button>	
	<select name="reftype" id="reftype" style="display:none;"></select>		
	<input type="hidden" name="formnames" id="formnames" value='<s:property value="formnames"/>'/>
	<input type="hidden" name="filename" id="filename" value='<s:property value="filename"/>'/>
	<input type="hidden" name="msgs" id="msgs" value='<s:property value="msgs"/>'/>
	<input type="hidden" name="formdetailcode" id="formdetailcode" value='<s:property value="formdetailcode"/>'/> 
	<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'/>
	<input type="hidden" name="hidchkclientview" id="hidchkclientview" value='1'/>
	<input type="hidden" name="brchid" id="brchid" value='<s:property value="brchid"/>'/>
	<input id="reftypid" type="hidden"  />									
	<input id="width" type="hidden" value="640" />
	<input id="height" type="hidden" />
	<input id="data" type="hidden" />
	<input id="iscapture" type="hidden" />
	<span id="message"></span>
	<canvas id="canvasid" hidden="true"  height="480" width="640"></canvas>
	<canvas id="canvasids" hidden="true"  height="240" width="320"></canvas>
	<div id="img">
	</div>
</form>
  
</body>
 <script>
	(function ( $width, $height, $file) {
		
		// (C) WebReflection Mit Style License
		
		// simple FileReader detection
		
		
		// async callback, received the
		// base 64 encoded resampled image
		function resampled(data) {
			//$message.innerHTML = "done";
			
		/* 	  ($img.lastChild || $img.appendChild(new Image)
			).src = data; */
			document.getElementById("data").value=data;
			/* var img = document.getElementById('imgid').src;

			alert(img.getAttribute('src')); // foo.jpg
			alert(img.src); */
			
			/* document.getElementById('imgid').src=data; */
			
			var imgid = new Image();
			imgid.src =data;
			
			var temp_paint = $('#canvasid');
			var temp_ctx = temp_paint[0].getContext('2d');
			
			  //var img = document.getElementById('imgid').src;
			//alert(img);
			 document.getElementById("errormsg").innerText=" ";
			  temp_ctx.drawImage(imgid, 0, 0,640, 480);
	     
		}
		
		// async callback, fired when the image
		// file has been loaded
		function load(e) {
			//$message.innerHTML = "resampling ...";
			// see resample.js
			Resample(
					this.result,
					this._width || null,
					this._height || null,
					resampled
			);
			
		}
		
		// async callback, fired if the operation
		// is aborted ( for whatever reason )
		function abort(e) {
			//$message.innerHTML = "operation aborted";
		}
		
		// async callback, fired
		// if an error occur (i.e. security)
		function error(e) {
			//$message.innerHTML = "Error: " + (this.result || e);
		}
		
		// listener for the input@file onchange
		$file.addEventListener("change", function change() {
			var
				// retrieve the width in pixel
				width = parseInt($width.value, 10),
				// retrieve the height in pixels
				height = parseInt($height.value, 10),
				// temporary variable, different purposes
				file
			;
			// no width and height specified
			// or both are NaN
			if (!width && !height) {
				// reset the input simply swapping it
				$file.parentNode.replaceChild(
					file = $file.cloneNode(false),
					$file
				);
				// remove the listener to avoid leaks, if any
				$file.removeEventListener("change", change, false);
				// reassign the $file DOM pointer
				// with the new input text and
				// add the change listener
				($file = file).addEventListener("change", change, false);
				// notify user there was something wrong
				//$message.innerHTML = "please specify width or height";
			} else if(
				// there is a files property
				// and this has a length greater than 0
				($file.files || []).length &&
				// the first file in this list 
				// has an image type, hopefully
				// compatible with canvas and drawImage
				// not strictly filtered in this example
				/^image\//.test((file = $file.files[0]).type)
			) {
				// reading action notification
				//$message.innerHTML = "reading ...";
				// create a new object
				file = new FileReader;
				// assign directly events
				// as example, Chrome does not
				// inherit EventTarget yet
				// so addEventListener won't
				// work as expected
				file.onload = load;
				file.onabort = abort;
				file.onerror = error;
				// cheap and easy place to store
				// desired width and/or height
				file._width = width;
				file._height = height;
				// time to read as base 64 encoded
				// data te selected image
				file.readAsDataURL($file.files[0]);
				// it will notify onload when finished
				// An onprogress listener could be added
				// as well, not in this demo tho (I am lazy)
			} else if (file) {
				// if file variable has been created
				// during precedent checks, there is a file
				// but the type is not the expected one
				// wrong file type notification
				//$message.innerHTML = "please chose an image";
			} else {
				// no file selected ... or no files at all
				// there is really nothing to do here ...
				//$message.innerHTML = "nothing to do";
			}
		}, false);
	}(
	
		// all required fields ...
		document.getElementById("width"),
		document.getElementById("height"),
		document.getElementById("file")
	));
	</script>




</html>
 