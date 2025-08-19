<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO();

String chk=request.getParameter("chk")==null?"0":request.getParameter("chk").trim();
String doc=request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
%>
<script type="text/javascript">
 
     var catsearch= '<%=DAO.alterMainProductSearch(session,chk,doc) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'part_no', type: 'string'  },
                              {name : 'name', type: 'string'  },
                              {name : 'psrno', type: 'string'  },
                              {name : 'doc_no', type: 'string'  }
                            ],
                       localdata: catsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxaltersearch").jqxGrid(
            {
                width: '100%',
                height: 120,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Prod_code', datafield: 'part_no', width: '30%'},
                              { text: 'Name', datafield: 'name' },
                              { text: 'Psrno', datafield: 'psrno',hidden:true },
                              { text: 'Docno', datafield: 'doc_no',hidden:true }
                              
						]
            });
            
             
           $('#jqxaltersearch').on('cellclick', function (event) {
        	
        	   var rowBoundIndex = event.args.rowindex;
           	var datafield = event.args.datafield;
		       if(datafield=="part_no")
		    	   {
		    	  prodSearchContent('altersubsearchGrid.jsp?rowno='+rowBoundIndex+'&chk=y');
		    	   }
		                 	  
                 });
           if($('#mode').val()=='view')
	         {
        	$("#jqxaltersearch").jqxGrid({
 			disabled : true
 		});
	         }
            });  
       
    </script>
    <div id="jqxaltersearch"></div> 