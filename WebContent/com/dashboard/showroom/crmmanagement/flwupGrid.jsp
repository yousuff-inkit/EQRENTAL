<%@page import="com.dashboard.showroom.crmmanagement.ClsCrmManagementDAO" %>
     <%
 	ClsCrmManagementDAO DAO= new ClsCrmManagementDAO(); 
     %>
<% String id =request.getParameter("id")==null?"0":request.getParameter("id").toString();
String docno =request.getParameter("docno")==null?"0":request.getParameter("docno").toString();%>
 

 <script type="text/javascript">  
 var flwupdata;
 var id='<%=id%>';
 if(parseInt(id)>0){
 	flwupdata=[ {
 		"date": "11.05.2022",
 		"fdate": "11.05.2022",
 		"user": "super",
 		"remarks": "",
 	}];
 }else{
 	flwupdata;
 }
<%--  var flwupdata ='<%=DAO.loadSubGridData(doc,docno)%>';   --%>   
        $(document).ready(function () { 

         var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'date', type: 'date' },
     						{name : 'user', type: 'String'},
     						{name : 'remarks', type: 'String'},
     						{name : 'fdate' , type : 'date'},
                          	],
                          	localdata: flwupdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#jqxFollowupGrid").jqxGrid({ 
            	width: '100%',
                height: 120,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
                enabletooltips:true,
                columnsresize: true,
                columns: [
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'User', datafield: 'user', width: '20%' },
							{ text: 'Follow-Up Date', datafield: 'fdate', width: '8%',cellsformat:'dd.MM.yyyy'},	
							{ text: 'Remarks', datafield: 'remarks'},
					]
            });
         
           
        });
                       
</script>
<div id="jqxFollowupGrid"></div>  