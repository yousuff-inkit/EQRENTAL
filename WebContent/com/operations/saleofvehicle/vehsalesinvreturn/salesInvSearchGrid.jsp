<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

<%@page import="com.operations.saleofvehicle.vehsalesinvreturn.ClsVehSalesInvReturnDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String searchdate = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
 String name = request.getParameter("name")==null?"0":request.getParameter("name");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
String acno=request.getParameter("acno")==null?"0":request.getParameter("acno");
String mobile=request.getParameter("mobile")==null?"0":request.getParameter("mobile");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
ClsVehSalesInvReturnDAO vehsalesinvretdao=new ClsVehSalesInvReturnDAO();
%> 
<script type="text/javascript">
var salesinvdata;
var id='<%=id%>';
if(id=="1"){
	salesinvdata='<%=vehsalesinvretdao.getSalesInv(searchdate, name, docno, acno, mobile)%>';	
}
else{
	salesinvdata=[];
}
	

		$(document).ready(function () { 	

            var source =
            {
                datatype: "json",
                datafields: [

                          	{name : 'doc_no' , type: 'number' },
     						{name : 'voc_no',type:'number'},
     						{name : 'acno',type:'number'},
     						{name : 'account',type:'number'},
     						{name : 'refname',type :'String'},
     						{name : 'description',type:'String'},
     						{name : 'per_mob',type:'String'},
     						{name : 'cldocno',type:'number'},
     						{name : 'date',type:'date'},
     						{name : 'address',type:'string'},
     						{name : 'mail1',type:'string'},
     						{name : 'salesinvtrno',type:'number'}
     					
                 ],
                localdata: salesinvdata,
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
            $("#salesInvSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No Original', datafield: 'doc_no', width: '25%' ,hidden:true},
							{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Name',datafield:'refname',width:'25%'},
							{ text:'Mobile',datafield:'per_mob',width:'25%'},
							{ text:'Ac No Original',datafield:'acno',width:'25%',hidden:true},
							{ text:'Ac No',datafield:'account',width:'25%'},
							{ text:'Remarks',datafield:'description',width:'16.66%',hidden:true},
							{ text:'Address',datafield:'address',width:'16.66%',hidden:true},
							{ text:'Mail',datafield:'mail1',width:'16.66%',hidden:true},
							{ text:'Sales Inv Trno',datafield:'salesinvtrno',width:'16.66%',hidden:true}
							]
            });
           
          $('#salesInvSearchGrid').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	var temp="";
              
            	document.getElementById("client").value=$('#salesInvSearchGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
            	document.getElementById("salesinvvocno").value=$('#salesInvSearchGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
            	document.getElementById("salesinvdocno").value=$('#salesInvSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	document.getElementById("salesinvremarks").value=$('#salesInvSearchGrid').jqxGrid('getcellvalue', rowindex1, "description");
            	
            	temp=$('#salesInvSearchGrid').jqxGrid('getcellvalue', rowindex1, "refname");
            	temp=temp+",Address: "+$('#salesInvSearchGrid').jqxGrid('getcellvalue', rowindex1, "address");
            	temp=temp+",Mobile: "+$('#salesInvSearchGrid').jqxGrid('getcellvalue', rowindex1, "per_mob");
            	temp=temp+",Mail: "+$('#salesInvSearchGrid').jqxGrid('getcellvalue', rowindex1, "mail1");
              	document.getElementById("clientname").value=temp;
              	document.getElementById("clientacno").value=$('#salesInvSearchGrid').jqxGrid('getcellvalue', rowindex1, "acno");
              	document.getElementById("salesinvtrno").value=$('#salesInvSearchGrid').jqxGrid('getcellvalue', rowindex1, "salesinvtrno");
               $('#salesinvwindow').jqxWindow('close');
                
            }); 
        });
    </script>
    <div id="salesInvSearchGrid"></div>
