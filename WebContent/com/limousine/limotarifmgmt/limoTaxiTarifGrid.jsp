<%@page import="com.limousine.limotarifmgmt.*" %>
<%ClsLimoTarifDAO tarifdao=new ClsLimoTarifDAO(); 
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String gid=request.getParameter("gid")==null?"0":request.getParameter("gid");
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
%>
<div id="commondiv"><jsp:include page="limoCommonGrid.jsp"></jsp:include></div>
<script type="text/javascript">
var datataxi=[];
var id='<%=id%>';
$(document).ready(function () { 
	
	if(id=="1"){
		datataxi='<%=tarifdao.getTarifTaxi(id,gid,docno)%>';
	}
	else{
		datataxi=[];
	}
	
 var columnsrenderer = function (value) {
        		return '<div style="text-align: right;margin-top: 5px;">' + value + '</div>';
         }

         var num = 1; 
       
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'mincharge' , type: 'number' },
                       	{name : 'minkmcharge' , type:'number'},
                       	{name : 'extrakmrate' , type:'number'},
                       	{name : 'excesshrsrate' , type:'number'},
                       	{name : 'nightmincharge' , type:'number'},
                       	{name : 'nightminkmcharge' , type:'number'},
                       	{name : 'nightextrakmrate' , type:'number'},
                       	{name : 'nightexcesshrsrate' , type:'number'},
     				   ],
					localdata:datataxi,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
           
          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });
            
            $("#limoTaxiTarifGrid").jqxGrid(
            {
               width: '100%',
               height: 70,
               source: dataAdapter,
               columnsresize: true,
               disabled:true,
               editable:true,
               selectionmode: 'singlecell',
                  
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },
							{ text: 'Min.Charge', datafield: 'mincharge',width:'12%',cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'Min. Km Charge',  datafield: 'minkmcharge',width:'12%',cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'Extra Km Rate',  datafield: 'extrakmrate',width:'12%',cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'Excess Hrs Rate',  datafield: 'excesshrsrate',width:'12%',cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'Night Min.Charge',  datafield: 'nightmincharge',width:'12%',cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'Night Min.Km Charge',  datafield: 'nightminkmcharge',width:'12%',cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'Night Extra Km Rate',  datafield: 'nightextrakmrate',width:'12%',cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'Night Excess Hrs Rate', datafield: 'nightexcesshrsrate',width:'12%',cellsformat:'d2',align:'right',cellsalign:'right'},
         	              ]
           
            });
            
            
		});

	
            </script>
            <div id="limoTaxiTarifGrid"></div>
            <input type="hidden" name="transferrowindex" id="transferrowindex">