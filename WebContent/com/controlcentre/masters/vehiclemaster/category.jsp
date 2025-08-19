<%@page import="com.controlcentre.masters.vehiclemaster.category.ClsCategoryAction" %>
<%ClsCategoryAction cba=new ClsCategoryAction(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date_category").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    
	    document.getElementById("formdet").innerText="Category(CAT)";
		document.getElementById("formdetail").value="Category";
		document.getElementById("formdetailcode").value="CAT";
		window.parent.formCode.value="CAT";
		window.parent.formName.value="Category";
 		var data= '<%=cba.searchDetails() %>';
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'date', type: 'date'  },
     						{name : 'name', type: 'String'  },
     						{name : 'code', type: 'String'  },
                 ],
               localdata: data,
                //url: "/searchDetails",
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
    
            $("#jqxCategorySearch1").jqxGrid(
                    {
                    	width: '100%',
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'multiplecellsextended',
                        //Add row method
                        columns: [
        					{ text: 'Doc_No', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
        					{ text: 'Code',columntype: 'textbox', filtertype: 'input', datafield: 'code', width: '40%' },
        					{ text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '40%' },
        					]
                    });
            $('#jqxCategorySearch1').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxCategorySearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("category").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("txtcode").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "code");
                $("#date_category").jqxDateTimeInput('val', $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "date"));
                //document.getElementById("search").style.display="none";
               // $('#window').jqxWindow('hide');
            }); 
        });
	function funSearchLoad(){
		changeContent('categorySearch.jsp', $('#window')); 
	 }
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmCategory').trigger("reset");
		//document.getElementById("frmCategory").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("category").value="";
	} */
	function funReadOnly() {
		$('#frmCategory input').attr('readonly', true);
		$('#date_category').jqxDateTimeInput({readonly : true});
		
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmCategory input').attr('readonly', false);
		$('#date_category').jqxDateTimeInput({readonly : false});
		$('#docno').attr('readonly', true);
		// $('#date_category').val(new Date());

	}
/* 	function show_image(src, width, height, alt,position,norepeat) {
	    var img = document.createElement("img");
	    img.src = src;
	    img.width = width;
	    img.height = height;
	    img.alt = alt;
	    img.position=position;
	    img.repeat=norepeat;

	    // This next line will just add it to the <body> tag
	    document.body.appendChild(img);
	} */
	function setValues() {
		if($('#datehidden').val()){
			$("#date_category").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	
	 $(function(){
	        $('#frmCategory').validate({
	                 rules: {
	                 category: { required:true, maxlength:40}
	                 },
	                 messages: {
	                  category: {required:" *",maxlength:"max 40 only"}   
	                 }
	        });});
	     function funNotify()
	     {
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("txtcode").focus();
	     }
	  function funExcelBtn(){
		  $("#jqxCategorySearch1").excelexportjs({
				containerid: "jqxCategorySearch1",
				datatype: 'json',
				dataset: null,
				gridId: "jqxCategorySearch",
				columns: getColumns("jqxCategorySearch") ,
				worksheetName:"Category Details"
			}); 
	  }
</script>  
 
</head>
<body onLoad="setValues();">
<form id="frmCategory" action="saveCategory" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<fieldset><legend>Category Details</legend>
	<table width="100%">
		<tr><td width="6%" align="right">Date</td>
			<td width="31%"  align="left"><div id="date_category" name="date_category"></div>
		  	</td>
			<td width="46%" align="right">Doc No.</td>
			<td width="17%">
					<input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="true"  tabindex="-1">
			</td>
		</tr><!-- pattern=".{1,3}" required="required" -->
		<tr><td align="right">Code</td>
			<td><input type="text" name="txtcode" id="txtcode"  value='<s:property value="txtcode"/>' ></td>
			<td align="right">Category</td>
			<td><input type="text" name="category" id="category"  value='<s:property value="category"/>' ></td></tr>
			
			<tr>
				<td><input type="hidden" id="mode" name="mode"/>
				        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/></td>
				
				<td><input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/></td>
				<td><input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/></td>
			</tr>
	</table>
	
	</fieldset>
    	
	</form>
<table width="100%">
      <tr>
        <td width="100%">	 <div id="jqxCategorySearch1"></div>  
</td>
        
      </tr>
    </table>
<br/>
		<%-- 	<div id="window">
				<div id="windowHeader" class="windowHead">
					<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search
					</span>
				</div>
				<div id="windowContent" class="windowCont" style="overflow: hidden;">
					<jsp:include page="categorySearch.jsp"></jsp:include>
				</div></div>
	 --%>
	

</body>
</html>