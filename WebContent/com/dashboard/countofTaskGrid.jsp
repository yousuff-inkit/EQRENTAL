<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO(); %>
<% String userid = request.getParameter("userid")==null || request.getParameter("userid").equals("")?"0":request.getParameter("userid").trim();
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
      
            var countdata = '<%=DAO.taskCount(userid, id)%>';      
            	  
            var source =
            {
                datatype: "json",
                datafield: [
			                     {name : 'status', type: 'string'},
			                  	 {name : 'issued', type: 'string'},
			                  	 {name : 'received', type: 'string'},	        
                        ],  
                         localdata: countdata,     
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
                  
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxTaskCount").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlerow',  
                       
                columns: [
								{ text: '',datafield: 'status', width: '30%'},  
								{ text: 'Issued',datafield: 'issued', width: '35%'}, 
								{ text: 'Received',datafield: 'received', width: '35%'},  
						]             
            });
        });
</script>
<div id="jqxTaskCount"></div>  