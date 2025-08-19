<%@page import="com.dashboard.security.ClsSecurity" %>
<%ClsSecurity cs=new ClsSecurity();
String docno = request.getParameter("cldoc")==null?"0":request.getParameter("cldoc");%>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
</style>


 <script type="text/javascript">

 var data2='<%=cs.agmtSearch(docno)%>';
         
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
                 		
     						{name : 'type', type: 'String'},
     						{name : 'voc', type: 'number'},
     						{name : 'doc', type: 'number'},
     						{name : 'cdate', type: 'date'},
     						{name : 'branch', type: 'String'},
                          	],
                          	localdata: data2,
                
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
            $("#jqxAgmtSearch").jqxGrid(
            {
                width: '100%',
                height: 340,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                columnsresize: true,
                selectionmode: 'singlerow',
               
                columns: [
							{ text: 'Branch', datafield: 'branch', width: '30%' },
							{ text: 'RANO', datafield: 'voc', width: '30%' },
							{ text: 'Date', datafield: 'cdate', cellsformat: 'dd.MM.yyyy' , width: '20%' },
							{ text: 'Type', datafield: 'type' },
							{ text: 'Doc No', datafield: 'doc', hidden: true, width: '10%' },
				
					]
            });
    
            $('#jqxAgmtSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("hiddocno").value = $('#jqxAgmtSearch').jqxGrid('getcellvalue', rowindex1, "doc");
                document.getElementById("txthidtype").value = $('#jqxAgmtSearch').jqxGrid('getcellvalue', rowindex1, "type");
                document.getElementById("txthidvoc").value = $('#jqxAgmtSearch').jqxGrid('getcellvalue', rowindex1, "voc");
                
            });  
				           
 });
function funupdate(){
		$('#agmtDetailsWindow').jqxWindow('close');
	var rtype=document.getElementById("txthidtype").value; 
	var hidvoc=document.getElementById("txthidvoc").value;
	var docno=document.getElementById("hiddocno").value;
	var trno=document.getElementById("txthidtrno").value;
	var type='';
	if(rtype=='Rental'){
	type='RAG-';
	}else{
	type='LAG-';
	}
	  $.messager.confirm('Message', 'Do you want to change Agreement to '+type+' '+hidvoc+' ?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 
		     		 saveGridData(rtype,docno,trno);	
		     	}
		 });
	
	
	}
	
	function saveGridData(rtype,docno,trno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				if(items>0){
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
			  }else{
			  $.messager.alert('Message', '  Not Updated ', function(r){
			  });
		     
		  }
		}
	}	
	x.open("GET","updateData.jsp?rdocno="+docno+"&rtype="+rtype+"&trno="+trno,true);
	x.send();
	}

</script>
  <tr>
  <td align="center">
<button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funupdate();">Update</button></td>
  </tr>

<div id="jqxAgmtSearch"></div>

    
