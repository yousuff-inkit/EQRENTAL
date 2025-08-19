<%@page import="com.operations.marketing.rentalquote.ClsRentalQuoteDAO" %>
<%ClsRentalQuoteDAO DAO=new ClsRentalQuoteDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 String contactpersonsname = request.getParameter("contactpersonsname")==null?"0":request.getParameter("contactpersonsname");
 String contactpersonsmobile = request.getParameter("contactpersonsmobile")==null?"0":request.getParameter("contactpersonsmobile");
 String contactpersonsdocno = request.getParameter("contactpersonsdocno")==null?"0":request.getParameter("contactpersonsdocno");
 String clientdocno = request.getParameter("clientdocno")==null?"0":request.getParameter("clientdocno");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">
        
       var cadata= '<%=DAO.contactPersonDetailsSearch(clientdocno, contactpersonsname, contactpersonsmobile, contactpersonsdocno, chk)%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'cprowno', type: 'String'  },
     						{name : 'cperson', type: 'String'  },
     						{name : 'tel', type: 'String'  },
     						{name : 'area', type: 'String'  },
     						{name : 'mob', type: 'String'  },
     						{name : 'email', type: 'String'  },
                        ],
                		 localdata: cadata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxcpsearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
							},
							{ text: 'Doc No', datafield: 'cprowno', width: '10%' },
							{ text: 'Name', datafield: 'cperson', width: '40%' },
							{ text: 'Mobile', datafield: 'mob', width: '20%' },
							{ text: 'Area', datafield: 'area', width: '25%' },
							{ text: 'tele', datafield: 'tele', hidden:true},
							{ text: 'Email', datafield: 'email', hidden:true },
						]
            });
            
             $('#jqxcpsearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
               
          	   /*  var temp="";
          	    var chktele=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex1, "tele");
          	  	if(typeof(chktele) != "undefined" && typeof(chktele) != "NaN" && chktele != ""){
          	    	temp=temp+"Tele - "+$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex1, "tele")+",";
          	  	}
          	    var chkarea=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex1, "area");
          	  	if(typeof(chkarea) != "undefined" && typeof(chkarea) != "NaN" && chkarea != ""){
                	temp=temp+"Area - "+$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex1, "area");
          	  	} */
	            document.getElementById("cptrno").value=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex1, "cprowno");
                document.getElementById("contactperson").value=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex1, "cperson");
	            document.getElementById("contactnumber").value=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex1, "mob");
	            $('#cpinfowindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="jqxcpsearch"></div>
  