 <%@page import="com.dashboard.travel.hotelvouchercreate.ClsHotelVoucherCreateDAO"%>
 <%  ClsHotelVoucherCreateDAO DAO=new ClsHotelVoucherCreateDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String customer = request.getParameter("customer")==null || request.getParameter("customer")==""?"":request.getParameter("customer");
 String docNo = request.getParameter("docNo")==null || request.getParameter("docNo")==""?"":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String tno = request.getParameter("tno")==null || request.getParameter("tno")==""?"":request.getParameter("tno");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 String branch=request.getParameter("branch")==null || request.getParameter("branch")==""?"0":request.getParameter("branch").toString();
%> 

 <script type="text/javascript">
 			var data1='<%=DAO.mainSearch(session, customer, docNo, date, tno, check,branch)%>';              
			$(document).ready(function () { 

        	var source = 
            {  
                datatype: "json",
                datafields: [
                            {name : 'customer', type: 'String' }, 
                            {name : 'doc_no', type: 'int' },
                            {name : 'voc_no', type: 'int' },
     						{name : 'issuingdate', type: 'date'  },
     						{name : 'suppconfno', type: 'number' },
                          	],
                          	localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {  
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxMainSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},  
     			
                columns: [
                     { text: 'Customer', datafield: 'customer'},
					 { text: 'Doc No', datafield: 'voc_no', width: '15%' }, 
					 { text: 'Doc No', datafield: 'doc_no', width: '15%',hidden:true },        
					 { text: 'Date', datafield: 'issuingdate', cellsformat: 'dd.MM.yyyy' , width: '15%' },
					 { text: 'Supplier Conformation No', datafield: 'suppconfno',  width: '15%' },
					]
            });
            
			  $('#jqxMainSearch').on('rowdoubleclick', function (event) {  
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxMainSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
                document.getElementById("masterdocno").value= $('#jqxMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("frmhotelvouchercreate").submit();  
                $('#mainsearchwndow').jqxWindow('close');     
            });   
}); 
    </script>
    <div id="jqxMainSearch"></div>
    