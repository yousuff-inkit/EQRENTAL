 <%@page import="com.operations.agreement.leaseagmt_alfahim.*"%>
<%@page import="com.operations.agreement.leaseclose_alfahim.*"%>
<%@page import="com.common.ClsCommon"%>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
ClsCommon objcommon=new ClsCommon();
ClsLeaseCloseAlFahimDAO leasedao=new ClsLeaseCloseAlFahimDAO();
ClsLeaseAgmtAlFahimDAO agmtdao=new ClsLeaseAgmtAlFahimDAO();
String agmtno=request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").toString();
String tarif=request.getParameter("tarif")==null?"0":request.getParameter("tarif").toString();
String cdwtotal=request.getParameter("cdwtotal")==null?"0":request.getParameter("cdwtotal").toString();
String acctotal=request.getParameter("acctotal")==null?"0":request.getParameter("acctotal").toString();
String chauffer=request.getParameter("chauffer")==null?"0":request.getParameter("chauffer").toString();
String excesskmchg=request.getParameter("excesskmchg")==null?"0":request.getParameter("excesskmchg").toString();
String excesshrchg=request.getParameter("excesshrchg")==null?"0":request.getParameter("excesshrchg").toString();
String temp=request.getParameter("temp")==null?"0":request.getParameter("temp").toString();
String usedhours=request.getParameter("usedhours")==null?"0":request.getParameter("usedhours").toString();
String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();
String fuel=request.getParameter("fuel")==null?"0":request.getParameter("fuel").toString();
String termamt=request.getParameter("termamt")==null?"0":request.getParameter("termamt").toString();
String deliverychg=request.getParameter("deliverychg")==null?"0":request.getParameter("deliverychg").toString();
String collectchg=request.getParameter("collectchg")==null?"0":request.getParameter("collectchg").toString();
String outdate=request.getParameter("outdate")==null?"0":request.getParameter("outdate").toString();
String indate=request.getParameter("indate")==null?"0":request.getParameter("indate").toString();
String cmbinfuel=request.getParameter("cmbinfuel")==null?"0":request.getParameter("cmbinfuel").toString();
String exkm=request.getParameter("exkm")==null?"0":request.getParameter("exkm").toString();
String termmonth=request.getParameter("termmonth")==null?"0":request.getParameter("termmonth").toString();
String calctype=request.getParameter("calctype")==null?"0":request.getParameter("calctype").toString();
java.sql.Date closeinvdate=(request.getParameter("closeinvdate")==null || request.getParameter("closeinvdate")=="")?null:objcommon.changeStringtoSqlDate(request.getParameter("closeinvdate"));
String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
String rentaldoc=request.getParameter("rentaldoc")==null?"0":request.getParameter("rentaldoc").toString();
String apc=request.getParameter("apc")==null?"0":request.getParameter("apc").toString();
%>

<script type="text/javascript">
      var datacalc;
        $(document).ready(function () { 	
        	    var temp1='<%=temp%>';
            // var url="demo.txt"; 
        	var num = 0;
        	
        //	alert("temp:"+temp1=="1"  && document.getElementById("docno").value=='');
        	var mode='<%=mode%>';
        	if(mode=="1"){
        		 datacalc='<%=agmtdao.ralistgridload(rentaldoc)%>';
        	}
        	else{
        	
			if(temp1=="1"  && document.getElementById("docno").value==''){
        		//alert("inside 1");
	        	datacalc='<%=leasedao.getCalcData(agmtno,tarif,cdwtotal,acctotal,chauffer,excesskmchg,excesshrchg,temp,session,usedhours,clientid,fuel,termamt,deliverychg,collectchg,outdate,indate,cmbinfuel,exkm,termmonth,closeinvdate,calctype,apc)%>';
        	}
        	else if(temp1=="2" && document.getElementById("docno").value!=''){
        		//alert("Inside Calculation view");
        		//alert("inside 2");
        		datacalc='<%=leasedao.getCalcData_view(agmtno)%>';
        	}
        	else{
        		
        	}
        	}
        	 var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' +  value + '</div>';
               }
                
        	var source =
            {
                datatype: "json",
                datafields: [
{name : 'description' , type: 'string' },
	{name : 'qty' , type:'string'},
	{name : 'total' , type:'number'},
	{name : 'invoice' , type:'number'},
	{name : 'invoiced',type:'number'},
	{name : 'creditnote' , type:'number'},
	{name :'idno',type:'number'},
	{name :'acno',type:'number'},
	{name : 'salamount',type:'number'},
	{name : 'salikrate',type:'number'},
	{name : 'saliksrvc',type:'number'},
	{name : 'salikamt',type:'number'},
	{name : 'trafficamt',type:'number'},
	{name : 'trafficsrvc',type:'number'},
	
	{name : 'salikauhamt',type:'number'},
{name : 'salikdxbamt',type:'number'},
{name : 'salikauhsrvc',type:'number'},
{name : 'salikdxbsrvc',type:'number'},
{name : 'salikauhcount',type:'number'},
{name : 'salikdxbcount',type:'number'},
{name : 'salikauhrate',type:'number'},
{name : 'salikdxbrate',type:'number'},
{name : 'salikauhsrvcrate',type:'number'},
{name : 'salikdxbsrvcrate',type:'number'},
	
	
                 ],
                
                localdata: datacalc,
                //url: url,
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
           
            $("#calculationgrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                rowsheight:18,
                localization: {thousandsSeparator: ""},
                statusbarheight:25,
                columnsresize: true,
                columnsheight: 15,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
             	showaggregates:true,
                showstatusbar:true,
                
                //Add row method
                columns: [
{ text: 'Rate Description', datafield: 'description', width: '27%',editable:false},
{ text: 'Qty',  datafield: 'qty',  width: '23%',editable:true },
{ text: 'Total',  datafield: 'total',  width: '16%'  ,editable:true ,cellsformat: 'd2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
{ text: 'Invoiced', datafield:'invoiced', width:'14%',editable:true ,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'] ,aggregatesrenderer:rendererstring,hidden:true},
{ text: 'Invoice',  datafield: 'invoice',  width: '17%'  ,editable:true ,cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'Balance',aggregates: ['sum'],aggregatesrenderer:rendererstring},
{ text: 'Revenue',  datafield: 'creditnote',  width: '17%',editable:true,cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'Balance',aggregates: ['sum'],aggregatesrenderer:rendererstring},
{ text: 'Id No',  datafield: 'idno',  width: '17.5%',hidden:true},
{ text: 'Ac No',  datafield: 'acno',  width: '17.5%',hidden:true},
{ text: 'Sal Amount',  datafield: 'salamount',  width: '17.5%',hidden:true},
{ text: 'Salik Rate',  datafield: 'salikrate',  width: '17.5%',hidden:true},
{ text: 'Salik Srvc',  datafield: 'saliksrvc',  width: '17.5%',hidden:true},
{ text: 'Salik Amt',  datafield: 'salikamt',  width: '17.5%',hidden:true},
{ text: 'Traffic Amt',  datafield: 'trafficamt',  width: '17.5%',hidden:true},
{ text: 'Traffic Srvc',  datafield: 'trafficsrvc',  width: '17.5%',hidden:true},

{ text: 'Salik AUH Amt',  datafield: 'salikauhamt',  width: '8%',hidden:true,cellsformat: 'd2',cellsalign:'right',align:'right'},
{ text: 'Salik DXB Amt',  datafield: 'salikdxbamt',  width: '8%',hidden:true,cellsformat: 'd2',cellsalign:'right',align:'right'},
{ text: 'Salik AUH Srvc',  datafield: 'salikauhsrvc',  width: '8%',hidden:true,cellsformat: 'd2',cellsalign:'right',align:'right'},
{ text: 'Salik DXB Srvc',  datafield: 'salikdxbsrvc',  width: '8%',hidden:true,cellsformat: 'd2',cellsalign:'right',align:'right'},
{ text: 'Salik AUH Count',  datafield: 'salikauhcount',  width: '8%',hidden:true,cellsformat: 'd2',cellsalign:'right',align:'right'},
{ text: 'Salik DXB Count',  datafield: 'salikdxbcount',  width: '8%',hidden:true,cellsformat: 'd2',cellsalign:'right',align:'right'},
{ text: 'Salik AUH Rate',  datafield: 'salikauhrate',  width: '8%',hidden:true,cellsformat: 'd2',cellsalign:'right',align:'right'},
{ text: 'Salik DXB Rate',  datafield: 'salikdxbrate',  width: '8%',hidden:true,cellsformat: 'd2',cellsalign:'right',align:'right'},
{ text: 'Salik AUH Srvc Rate',  datafield: 'salikauhsrvcrate',  width: '8%',hidden:true,cellsformat: 'd2',cellsalign:'right',align:'right'},
{ text: 'Salik DXB Srvc Rate',  datafield: 'salikdxbsrvcrate',  width: '8%',hidden:true,cellsformat: 'd2',cellsalign:'right',align:'right'},

], columngroups: 
	                     [
	                       { text: 'Balance', align: 'center', name: 'Balance',width:10 }
	                    
	                     ]
            });
    /*   var rows=$("#calculationgrid").jqxGrid("getrows");
       var rowlength=rows.length;
       if(rowlength==0){
            $("#calculationgrid").jqxGrid("addrow", null, {});
       } */
        });
            </script>
            <div id="calculationgrid"></div>