<%@ page import="com.dashboard.travel.tourvendorupdate.ClsTourVendorUpdateDAO" %>  
<%ClsTourVendorUpdateDAO DAO=new ClsTourVendorUpdateDAO(); %> 
 <%    
   String docno = request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno");
 String vndid = request.getParameter("vndid")=="" || request.getParameter("vndid")==null?"0":request.getParameter("vndid");
 %>
       <script type="text/javascript">
       var vdata;
       vdata= '<%=DAO.searchVendor(docno,vndid) %>';      
		$(document).ready(function () { 	     
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'vendorid', type: 'string'  },   
                             {name : 'refname', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: vdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxvendorSearch").jqxGrid(   
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                columns: [
                           { text: 'Vendor', datafield: 'refname', width: '100%' },
                           { text: 'vendorid', datafield: 'vendorid', width: '6%',hidden:true }
						] 
            });
            $('#jqxvendorSearch').on('rowdoubleclick', function (event) {               
                var rowindex2 = event.args.rowindex;  
                document.getElementById("vendor").value=$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "refname");
				document.getElementById("vendorid").value=$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "vendorid");
              	$('#vendorsearchwndow').jqxWindow('close');   
            });    
        });
    </script>
    <div id="jqxvendorSearch"></div>