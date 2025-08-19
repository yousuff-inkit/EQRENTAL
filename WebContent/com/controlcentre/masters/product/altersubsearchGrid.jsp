<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO();

String chk=request.getParameter("chk")==null?"0":request.getParameter("chk").trim();
%>
<script type="text/javascript">
var uomrow='<%=request.getParameter("rowno") %>';
     var catsearch= '<%=DAO.alterProductSearch(session,chk) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'part_no', type: 'string'  },
                              {name : 'name', type: 'string'  },
                              {name : 'psrno', type: 'string'  },
                            ],
                       localdata: catsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxaltersubsearch").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Prod_code', datafield: 'part_no', width: '30%'},
                              { text: 'Name', datafield: 'name' },
                              { text: 'Psrno', datafield: 'psrno',hidden:true },
                              
						]
            });
            
             
           $('#jqxaltersubsearch').on('rowdoubleclick', function (event) {
        	
        	   var rowindex1= event.args.rowindex;
               
               $('#jqxaltersearch').jqxGrid('setcellvalue', uomrow, 'part_no',$('#jqxaltersubsearch').jqxGrid('getcellvalue', rowindex1, "part_no"));
               $('#jqxaltersearch').jqxGrid('setcellvalue', uomrow, 'name',$('#jqxaltersubsearch').jqxGrid('getcellvalue', rowindex1, "name"));
               $('#jqxaltersearch').jqxGrid('setcellvalue', uomrow, 'psrno',$('#jqxaltersubsearch').jqxGrid('getcellvalue', rowindex1, "psrno"));
               
              
               $("#jqxaltersearch").jqxGrid('addrow', null, {});
               	
               
             
               
               
             $('#prodsearchwindow').jqxWindow('close'); 
		                 	  
                 });
            });  
        
    </script>
    <div id="jqxaltersubsearch"></div> 