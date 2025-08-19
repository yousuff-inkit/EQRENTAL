<%@page import="com.dashboard.leaseagreement.leaseagmttarifchange.*" %>
<%
	ClsLeaseAgmtTarifChangeDAO tarifchangedao=new ClsLeaseAgmtTarifChangeDAO(); 
	String agmtdocno=request.getParameter("agmtdocno")==null?"":request.getParameter("agmtdocno");
	String id=request.getParameter("id")==null?"":request.getParameter("id");
%>

<style>
	.column{
		background-color: #D6FFEA;
	}
</style> 
<jsp:include  page="..\..\..\common\commonGrid.jsp"></jsp:include> 
<script type="text/javascript">
var tarifdata=[];
var id='<%=id%>';
if(id=="1"){
	tarifdata='<%=tarifchangedao.getTarifData(agmtdocno,id)%>';
}
     $(document).ready(function () { 	
     	var columnsrenderer = function (value) {
        	return '<div style="text-align: center;margin-top: 5px;">' + value + '</div>';
        }
        var source =
        {
                datatype: "json",
                datafields: [
									{name : 'rentaltype' , type: 'string', },
									{name : 'rate' , type:'number'},
									{name : 'cdw' , type:'number'},
									{name : 'pai' , type:'number'},
									{name : 'cdw1' , type:'number'},
									{name : 'pai1' , type:'number'},
									{name : 'gps' , type:'number'},
									{name : 'babyseater' , type:'number'},
									{name : 'cooler' , type:'number'},
									{name : 'exhrchg' , type:'number'},
									{name : 'chaufchg' , type:'number'},
									{name : 'chaufexchg' , type:'number'},
									{name : 'kmrest' , type:'number'},
									{name : 'exkmrte' , type:'number'},
									{name : 'oinschg' , type:'number'}
                 ],
                localdata: tarifdata,
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
            $("#tarifChangeGrid").jqxGrid(
            {
                width: '98%',
                height: 45,
                source: dataAdapter,
                rowsheight:18,
                columnsresize: true,
                pageable: false,
                //disabled:true,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
                editable:true,
                //Add row method
                columns: [
{ text: '   '+document.getElementById("mainrentaltype").value, datafield: 'rentaltype',editable:false,cellclassname:'column',hidden:true},
{ text: '      '+document.getElementById("mainrate").value,  datafield: 'rate',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: '     '+document.getElementById("maincdw").value,  datafield: 'cdw',renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right',cellclassname:'column'},
{ text: '     '+document.getElementById("mainpai").value,  datafield: 'pai',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right',cellclassname:'column'},
{ text: '     '+document.getElementById("maincdw1").value,  datafield: 'cdw1' ,editable:true ,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: '     '+document.getElementById("mainpai1").value,  datafield: 'pai1',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text:  '     '+document.getElementById("maingps").value,  datafield: 'gps', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainbabyseater").value,  datafield: 'babyseater', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("maincooler").value,  datafield: 'cooler', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainkmrest").value,  datafield: 'kmrest',  editable:true,renderer: columnsrenderer,cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainexkmrte").value,  datafield: 'exkmrte', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainoinschg").value,  datafield: 'oinschg',editable:true,renderer: columnsrenderer,cellsformat: 'd2',hidden:true,cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainexhrchg").value,  datafield: 'exhrchg', editable:true,renderer: columnsrenderer,cellsformat: 'd2',hidden:true,cellsalign: 'right', align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainchaufchg").value,  datafield: 'chaufchg',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainchaufexchg").value,  datafield: 'chaufexchg', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right',cellclassname:'column'}
	              ]
            });
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subrentaltype").value);
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subchaufchg").value);
            $('#tarifChangeGrid').jqxGrid('hidecolumn', ''+document.getElementById("subchaufexchg").value);
            
        });
  
            </script>
            <div id="tarifChangeGrid"></div>