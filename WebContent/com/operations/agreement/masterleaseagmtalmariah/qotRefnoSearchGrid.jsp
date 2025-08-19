<%@ page import="com.operations.agreement.masterleaseagmtalmariah.*" %>
<%ClsMasterLeaseAgmtAlmariahDAO masterdao=new ClsMasterLeaseAgmtAlmariahDAO();
String id=request.getParameter("id")==null?"1":request.getParameter("id");
String cmbreftype=request.getParameter("cmbreftype")==null?"0":request.getParameter("cmbreftype");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript">
var id='<%=id%>';

var qotrefnodata;

if(id=="1"){
	qotrefnodata='<%=masterdao.getQotRefData(id,cmbreftype)%>';
	
}
	$(document).ready(function () { 
		
    	var source = 
       	{
        	datatype: "json",
           	datafields: [
 						
				{name : 'doc_no', type: 'number'  },
				{name : 'date',type:'date'},
				{name : 'project', type: 'String'  },
				{name : 'refname',type:'string'},
				{name : 'cldocno', type: 'String'  },
				{name : 'address', type: 'String'  }, 
				{name : 'per_mob', type: 'String'  },
				{name : 'contactperson', type: 'String'},
				{name : 'mail1', type: 'String'  },
				{name : 'per_tel', type: 'String'  },
          ],
          localdata: qotrefnodata,
           
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
            
            $("#qotRefnoSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Client', datafield: 'refname', width: '80%' },
					{ text: 'CLIENT NO', datafield: 'cldocno', width: '7%' ,hidden:true},
					{ text: 'MOB', datafield: 'per_mob', width: '9%' ,hidden:true},
					{ text: 'TEL', datafield: 'per_tel', width: '8%' ,hidden:true},
					{ text: 'ADDRESS', datafield: 'address', width: '21%' ,hidden:true}, 
					{ text: 'contactPerson', datafield: 'contactperson', width: '20%',hidden:true },
					{ text: 'mail1', datafield: 'mail1', width: '20%',hidden:true }
					
				]
            });
            
            $("#qotRefnoSearchGrid").on("rowdoubleclick", function (event)
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // row's bound index.
            		    var rowBoundIndex = args.rowindex;
            		    // row's visible index.
            		    var rowVisibleIndex = args.visibleindex;
            		    // right click.
            		    var rightClick = args.rightclick; 
            		    // original event.
            		    var ev = args.originalEvent;
            		    // column index.
            		    var columnIndex = args.columnindex;
            		    // column data field.
            		    var dataField = args.datafield;
            		    // cell value
            		    var value = args.value;
            		    var temp="";
		            	temp+=$('#qotRefnoSearchGrid').jqxGrid('getcellvalue', rowBoundIndex, "refname");
		            	temp=temp+" Contact Person : "+$('#qotRefnoSearchGrid').jqxGrid('getcellvalue', rowBoundIndex, "contactperson");
		                temp=temp+","+" MOB : "+$('#qotRefnoSearchGrid').jqxGrid('getcellvalue', rowBoundIndex, "per_mob");
		                temp=temp+","+" Email : "+$('#qotRefnoSearchGrid').jqxGrid('getcellvalue', rowBoundIndex, "mail1");
		                temp=temp+","+" ADDRESS : "+$('#qotRefnoSearchGrid').jqxGrid('getcellvalue', rowBoundIndex, "address");
		                temp=temp+","+" Tel NO : "+$('#qotRefnoSearchGrid').jqxGrid('getcellvalue', rowBoundIndex, "per_tel");
		            	document.getElementById("clientdetails").value=temp; 
		               document.getElementById("cldocno").value=$('#qotRefnoSearchGrid').jqxGrid('getcellvalue', rowBoundIndex, "cldocno");
            		    $('#qotrefno').val($('#qotRefnoSearchGrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no'));
            		    $('#hidqotrefno').val($('#qotRefnoSearchGrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no'));
            		    $('#masterleasegriddiv').load('masterLeaseGrid.jsp?id=2&refno='+$('#qotrefno').val());
            			$('#searchwindow').jqxWindow('close');
            		});
    
});
</script><div id="qotRefnoSearchGrid"></div>
