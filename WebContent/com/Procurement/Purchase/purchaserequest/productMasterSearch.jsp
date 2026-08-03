<%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

	<script type="text/javascript">
	$(document).ready(function () {
		document.getElementById("txtproductsname").focus();
	/* 	document.getElementById("txtcldocnos").value=$('#clientid').val();
		document.getElementById("txtestdates").value=$('#date').val();
		document.getElementById("txtgridscopeids").value=$('#txtgridscopeid').val();
		document.getElementById("txtgridscopeproducts").value=$('#txtgridscopeproduct').val(); */
	}); 

 	function loadSearch() {
 		var productsname=document.getElementById("txtproductsname").value;
 		var brandsname=document.getElementById("jqxBrandInput").value;
 		var cldocnos=0/* document.getElementById("txtcldocnos").value */;
 		var estdates=0/* document.getElementById("txtestdates").value */;
 		var gridprdname=document.getElementById("txtgridprdname").value;
 		var gridunit=document.getElementById("txtgridunit").value;
 		var gridscategory=document.getElementById("txtgridscategory").value;
		var gridssubcategory=document.getElementById("jqxSubCategoryInput").value;
 		var gridscopeid=0/* document.getElementById("txtgridscopeids").value; */;
 		var gridscopeproduct=0/* document.getElementById("txtgridscopeproducts").value */;
 		
		var id="1";
		getdata(productsname,brandsname,cldocnos,estdates,id,gridprdname,gridunit,gridscategory,gridssubcategory,gridscopeid,gridscopeproduct);
	}
	function getdata(productsname,brandsname,cldocnos,estdates,id,gridprdname,gridunit,gridscategory,gridssubcategory,gridscopeid,gridscopeproduct){
		 $("#refreshProductDiv").load('productSearch.jsp?productsname='+productsname.replace(/ /g, "%20")+'&brandsname='+brandsname.replace(/ /g, "%20")+'&cldocnos='+cldocnos+'&estdates='+estdates+"&id="+id+"&gridprdname="+gridprdname.replace(/ /g, "%20")+"&gridunit="+gridunit+"&gridcategory="+gridscategory.replace(/ /g, "%20")+"&gridssubcategory="+gridssubcategory.replace(/ /g, "%20")+"&scopeid="+gridscopeid+"&scopeproduct="+gridscopeproduct);
		}

	</script>
<style>
*{
    box-sizing:border-box;
}

html,body{
    margin:0;
    padding:0;
    width:100%;
    max-width:100%;
    background:#fff;
    font-family:Segoe UI,Tahoma,sans-serif;
    overflow-x:hidden;
}

#search{
    padding:10px;
    background:#fff;
    width:100%;
    max-width:100%;
}

.search-panel{
    background:#fff;
    border:1px solid #d9d9d9;
    border-radius:4px;
    padding:12px;
    margin-bottom:10px;
    width:100%;
    max-width:100%;
    display:flex;
    flex-wrap:wrap;
    align-items:flex-end;
    gap:10px 14px;
}

.field-group{
    display:flex;
    flex-direction:column;
    flex:1 1 140px;
    min-width:110px;
    max-width:100%;
}

.field-group.grow-2{
    flex:2 1 200px;
}

.lbl-right{
    text-align:left;
    font-size:12px;
    font-weight:500;
    color:#333;
    margin-bottom:4px;
    white-space:nowrap;
}

.search-input{
    height:26px;
    width:100%;
    max-width:100%;
    border:1px solid #cfcfcf;
    border-radius:3px;
    padding:2px 6px;
    font-size:12px;
}

.btn-group{
    flex:0 0 auto;
}

.grid-container{
    background:#fff;
    border:1px solid #d9d9d9;
    border-radius:4px;
    overflow:hidden;
    width:100%;
    max-width:100%;
}
</style>

<body>

<div id="search">

    <div class="search-panel">

        <div class="field-group">
            <span class="lbl-right">Product</span>
            <input type="text"
                   id="txtproductsname"
                   name="txtproductsname"
                   class="search-input"
                   value='<s:property value="txtproductsname"/>'>
        </div>

        <div class="field-group grow-2">
            <span class="lbl-right">Product Name</span>
            <input type="text"
                   id="txtgridprdname"
                   name="txtgridprdname"
                   class="search-input"
                   value='<s:property value="txtgridprdname"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Brand</span>
            <div id="brandDiv">
                <jsp:include page="brandInputSearch.jsp"></jsp:include>
            </div>
            <input type="hidden"
                   id="txtcldocnos"
                   name="txtcldocnos"
                   value='<s:property value="txtcldocnos"/>'>
            <input type="hidden"
                   id="txtestdates"
                   name="txtestdates"
                   value='<s:property value="txtestdates"/>'>
            <input type="hidden"
                   id="txtgridscopeids"
                   name="txtgridscopeids"
                   value='<s:property value="txtgridscopeids"/>'>
            <input type="hidden"
                   id="txtgridscopeproducts"
                   name="txtgridscopeproducts"
                   value='<s:property value="txtgridscopeproducts"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Unit</span>
            <input type="text"
                   id="txtgridunit"
                   name="txtgridunit"
                   class="search-input"
                   value='<s:property value="txtgridunit"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Category</span>
            <input type="text"
                   id="txtgridscategory"
                   name="txtgridscategory"
                   class="search-input"
                   value='<s:property value="txtgridscategory"/>'>
        </div>

        <div class="field-group">
            <span class="lbl-right">Sub Category</span>
            <div id="subCategoryDiv">
                <jsp:include page="subCategoryInputSearch.jsp"></jsp:include>
            </div>
        </div>

        <div class="btn-group">
            <input
                type="button"
                id="btnsearch"
                name="btnsearch"
                class="myButton"
                onclick="loadSearch();"
                value="Search"
                style="
                    width:100px;
                    height:28px;
                    background:#205fd3;
                    color:#fff;
                    border:1px solid #205fd3;
                    border-radius:4px;
                    font-size:12px;
                    font-weight:600;
                    cursor:pointer;">
        </div>

    </div>

    <div class="grid-container">

        <div id="refreshProductDiv">
            <jsp:include page="productSearch.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>
