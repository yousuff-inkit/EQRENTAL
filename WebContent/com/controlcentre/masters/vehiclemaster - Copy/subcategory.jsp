<%@page import="com.controlcentre.masters.vehiclemaster.subcategory.ClsSubcategoryAction" %>
<%ClsSubcategoryAction csa=new ClsSubcategoryAction(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
      $(document).ready(function () {          
    	  $("#subcategorydate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
     
    	    document.getElementById("formdet").innerText="Sub category(SCT)";
			document.getElementById("formdetail").value="Sub category";
			document.getElementById("formdetailcode").value="SCT";
			window.parent.formCode.value="SCT";
			window.parent.formName.value="Sub category";
          var data= '<%=csa.searchDetails() %>';
              
              var num = 0; 
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'doc_no' , type: 'int' },
       						    {name : 'name', type: 'String'  },
       						    {name : 'code', type: 'String'  },
                            	{name : 'date', type: 'date'  },
                            	{name : 'catname',type:'String'},
                            	{name : 'catid',type:'int'}
                   ],
                   localdata: data,
                  
                  
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
      


              $("#jqxSubcategorySearch1").jqxGrid(
                      {
                      	width: '100%',
                          height: 350,
                          source: dataAdapter,
                          showfilterrow: true,
                          filterable: true,
                          selectionmode: 'multiplecellsextended',
                        //  pagermode: 'default',
                          sortable: true,
                          //pageable: true,
                          altrows:true,
                          //Add row method
                          columns: [
          					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
          					{ text: 'Date',columntype: 'textbox',filtertype: 'input',datafield:'date',width: '10%',cellsformat:'dd.MM.yyyy'},
          					{ text: 'Code',columntype: 'textbox', filtertype: 'input', datafield: 'code', width: '30%' },
          					{ text: 'Subcategory',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
          					{ text: 'Category Id', filtertype: 'number', datafield: 'catid', width: '10%',hidden:true },
          					{ text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'catname', width: '20%' },
          					

          	              ]
                      });

              $('#jqxSubcategorySearch1').on('rowdoubleclick', function (event) 
              		{
  		            	var rowindex1=event.args.rowindex;
  		                document.getElementById("docno").value= $('#jqxSubcategorySearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
  		                document.getElementById("name").value = $("#jqxSubcategorySearch1").jqxGrid('getcellvalue', rowindex1, "name");
  		              $('#frmSubcategory select').attr('disabled', false);
  		    		$('#subcategorydate').jqxDateTimeInput({disabled: false});
		                document.getElementById("code").value = $("#jqxSubcategorySearch1").jqxGrid('getcellvalue', rowindex1, "code");
  		                $("#subcategorydate").jqxDateTimeInput('val',$("#jqxSubcategorySearch1").jqxGrid('getcellvalue', rowindex1, "date"));
  		               // $('#catid').val($("#jqxSubcategorySearch1").jqxGrid('getcellvalue', rowindex1, "catid")) ;
  		                $('#catname').val($("#jqxSubcategorySearch1").jqxGrid('getcellvalue', rowindex1, "catid")) ;
  		              $('#frmSubcategory select').attr('disabled', true);
  		    		$('#subcategorydate').jqxDateTimeInput({disabled: true});
              		 }); 
              //$("#jqxSubcategorySearch").jqxGrid('hidecolumn', 'brandid'); 

          });
    
      function funSearchLoad(){
			changeContent('subcategorySearch.jsp', $('#window')); 
		 }

	function funReadOnly() {
		$('#frmSubcategory input').attr('readonly', true);
		$('#frmSubcategory select').attr('disabled', true);
		$('#subcategorydate').jqxDateTimeInput({disabled: true});
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
		
	}
	function funRemoveReadOnly() {
		$('#frmSubcategory input').attr('readonly', false);
		$('#frmSubcategory select').attr('disabled', false);
		$('#subcategorydate').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		// $('#subcategorydate').val(new Date());


	}

	function getCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var catnameItems = items[0].split(",");
				var catidItems = items[1].split(",");
				var optionscategory = '<option value="">--Select--</option>';
				for (var i = 0; i < catnameItems.length; i++) {
					optionscategory += '<option value="' + catidItems[i] + '">'
							+ catnameItems[i] + '</option>';
				}
				
				$("select#catname").html(optionscategory);
				$('#catname').val($('#catid').val());
				
				} 
			else
				{
			    }
		}
		x.open("GET", "getCategory.jsp", true);
		x.send();
	}
	
	function funFocus(){
	//	document.getElementById("catname").focus();
	}
	 $(function(){
	        $('#frmSubcategory').validate({
	                 rules: {
	                 catname:{
	                	 "required":true
	                 },
	                 name:{
	                	 "required":true,
	                	 maxlength:20
	                 }
	                 },
	                 messages: {
	                  catname:{
	                	  required:" *"
	                  },
	                  name:{
	                	  required:" *",
	                	  maxlength:"max 20 chars"
	                  }
	                 }
	        });});
	     function funNotify(){
	    	
	    		return 1;
		} 
	     
	function setValues() {
		//$('#brand').val($('#brandid').val());
if ($('#catid').val() != null) {
	//alert("ghcj");
			$('#catname').val($('#catid').val());
}
if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }
	}
	
	 function funExcelBtn(){
		 $("#jqxSubcategorySearch1").excelexportjs({
				containerid: "jqxSubcategorySearch1",
				datatype: 'json',
				dataset: null,
				gridId: "jqxSubcategorySearch",
				columns: getColumns("jqxSubcategorySearch") ,
				worksheetName:"Subategory Details"	});   }
</script>
</head>
<body onLoad="getCategory();setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmSubcategory" action="saveSubcategory"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset><legend>Subcategory Details</legend>
<input type="text" id="catid" name="catid" value='<s:property value="catid"/>' hidden="true">
<table width="100%" >
<tr>
  <td width="14%"><div align="right">Date</div></td>
  <td width="12%"><div id="subcategorydate" name="subcategorydate" value='<s:property value="subcategorydate"/>'></div></td>
  <td width="23%"><div align="right">Doc No</div></td>
  <td width="51%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly"  tabindex="-1"></td>
</tr>
<tr><td><div align="right">Category</div></td>
<td> 
<!-- <option value="">--Select--</option> -->
 <select name="catname" id="catname" style="width:100%;">
</select></td>
<td><div align="right">Code</div></td>
<td><input type="text" name="code" id="code" value='<s:property value="code"/>'>
</td></tr>
<tr><td align="right">Subcategory</td>
<td><input type="text" name="name" id="name" value='<s:property value="name"/>'></td></tr>
</table> 
</fieldset>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

<input type="hidden" id="mode" name="mode"/>
<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>    
</form>
<br/><table width="100%">
<tr><td>
<div id="jqxSubcategorySearch1"></div></td></tr></table>
<%-- <div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="subcategorySearch.jsp"></jsp:include>
	</div></div> --%>
	
</div>
</body>
</html>