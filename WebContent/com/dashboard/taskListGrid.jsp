<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO(); %>
 <%
     String userid=request.getParameter("userid")==null?"0":request.getParameter("userid").toString();
 String id=request.getParameter("id")==null?"0":request.getParameter("id").toString();
 %>    
<style>
.redClass{
color: red;
}
.blueClass{
color: blue;
}
</style>
<script type="text/javascript">
	 
        $(document).ready(function () { 
      
            var taskdata = '<%=DAO.taskHistory(userid, id)%>';     
            	  
            var source =
            {
                datatype: "json",
                datafield: [
		                	{name : 'doc_no', type: 'number' },
							{name : 'date', type: 'date' },
							{name : 'edc', type: 'date' },
							{name : 'type', type: 'string' }, 
						    {name : 'description', type: 'String' },
						    {name : 'refno', type: 'String' },
						    {name : 'status', type: 'String' },
     						{name : 'user', type: 'string'},
							{name : 'assuser', type: 'string'}  
                        ],
                         localdata: taskdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
                  
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxTaskGrid").jqxGrid(
            {
                width: '100%',
                height: 190,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlerow',       
                enabletooltips:true,
                columnsresize: true,
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', hidden: true , width: '0%' },
							{ text: 'Date', datafield: 'date' , cellsformat: 'dd.MM.yyyy' , width: '9%' },  
							{ text: 'Type', datafield: 'type' , width: '12%' },
							{ text: 'Ref No', datafield: 'refno' , width: '8%' },
							{ text: 'User', datafield: 'assuser' , width: '12%' },    
							{ text: 'EDC', datafield: 'edc',cellsformat: 'dd.MM.yyyy' , width: '9%' },
							{ text: 'Remarks', datafield: 'description' , width: '28%' },   
							{ text: 'Created User', datafield: 'user' , width: '12%' }, 
							{ text: 'Status', datafield: 'status' , width: '10%' },   
						]
            });
        });
</script>
<div id="jqxTaskGrid"></div>  