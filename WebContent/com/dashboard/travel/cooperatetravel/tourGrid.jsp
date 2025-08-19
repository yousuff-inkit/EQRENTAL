<%@page import="com.dashboard.travel.cooperatetravel.ClsCooperateTravelDAO"%>
<% ClsCooperateTravelDAO DAO=new ClsCooperateTravelDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>           
 <%
     String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
 %> 
 <style type="text/css">
    .redClass
    {
        background-color: #A7DA91;
    }
</style>                         
<script type="text/javascript">          
var pdata;         
 pdata='<%=DAO.tourGrid(rdocno) %>';      
 
 var rendererstring=function (aggregates){  
 	var value=aggregates['sum'];
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 }
$(document).ready(function(){  
        var source =
        {      
            datatype: "json",           
            datafields: [
            			{name : 'stockid',type:'string'},    
                        {name : 'stocktype',type:'string'},      
                 		{name : 'tourtaxtype',type:'string'},             
                      	{name : 'adultdismax', type: 'number'},   
                     	{name : 'childdismax', type: 'number'}, 
						{name : 'cldocno',type:'string'},                  
						{name : 'refname',type:'string'}, 
						{name : 'tourdocno',type:'string'},
                        {name : 'clientacno',type:'string'}, 
                        {name : 'satacno',type:'string'},  
                        {name : 'satdocno',type:'string'}, 
                        {name : 'confirm',type:'string'},
                        {name : 'salesagent',type:'string'},
                        {name : 'distype',type:'string'},  
                      	{name : 'adultdis', type: 'number'},   
                     	{name : 'childdis', type: 'number'},      
                     	{name : 'time',type:'string'},
                    	{name : 'stdtotal', type: 'number'},
                     	{name : 'total', type: 'number'},
						{name : 'spadult', type: 'number'},
						{name : 'spchild', type: 'number'},     
						{name : 'infant', type: 'number'},     
                        {name : 'adult', type: 'number'},      
                        {name : 'child', type: 'number'}, 
                        {name : 'adultval', type: 'number'},  
                        {name : 'childval', type: 'number'},  
                      	{name : 'tourname', type: 'string'},  
                      	{name : 'tourid', type: 'string'},
                      	{name : 'remarks', type: 'string'},    
                      	{name : 'date',type:'date'},   
                    	{name : 'vndid', type: 'string'},
                      	{name : 'vendor', type: 'string'},  
                       	{name : 'rowno', type: 'string'},
                       	{name : 'xodocno', type: 'string'},  
                       	{name : 'rowdelete', type: 'string'},  
                       	
                       	{ name: 'transferid',type: 'string'}, 
    					{ name: 'groupid',type: 'string'},                        
    					{ name: 'transfertype',type: 'string'},
    					{ name: 'qty',type: 'string'},
    					{ name: 'loctype',type: 'string'},
    					{ name: 'rname',type: 'string'},   
    					{ name: 'refno',type: 'string'},
    					{ name: 'plocid',type: 'string'},
    					{ name: 'ploctime',type: 'string'},
    					{ name: 'dlocid',type: 'string'},
    					{ name: 'rtripid',type: 'string'},
    					{ name: 'tvltotal',type: 'number'},    
    					{ name: 'rndplocid',type: 'string'},
    					{ name: 'rndploctime',type: 'string'},
    					{ name: 'rnddlocid',type: 'string'}, 
    					{ name: 'tarifdetaildocno', type: 'string' },
    					{ name: 'estdistance',  type: 'string'},
    					{ name: 'esttime',  type: 'string'},
    					{ name: 'exdistancerate', type: 'string' },
    					{ name: 'extimerate', type: 'string' },
    					{ name: 'tourtransferrate',type: 'string'  },
    					{ name: 'tourtransferratetot', type: 'string' },
    					{ name: 'rttarifdetaildocno',  type: 'string'},        
    					{ name: 'rtestdistance',  type: 'string'},
    					{ name: 'rtesttime', type: 'string' },
    					{ name: 'rtexdistancerate',type: 'string'  },
    					{ name: 'rtextimerate', type: 'string' },
    					{ name: 'tarifdocno', type: 'string' },
    					{ name: 'rttarifdocno', type: 'string' },       
    					],
             localdata: pdata,
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        
        var cellclassname = function (row, column, value, data) {
        		 if (data.rowdelete==1) {
                    return "redClass";
                };
            }; 
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );

        $("#tourGrid").jqxGrid(                
                {
                	width: '100%',
                    height: 150,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,   
                    selectionmode: 'singlecell',      
                    altrows:true,
                    showaggregates: true,  
                 	showstatusbar:true,
                    columnsresize: true,
                    enabletooltips:true,  
                    editable:true,    
                    //Add row method 
                    columns: [     
                             
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '5%',cellclassname:cellclassname,editable:false,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },          
    					{ text: 'Tour name',datafield: 'tourname', width: '22%',editable:false,cellclassname:cellclassname},             
    					{ text: 'Tour id',datafield: 'tourid',hidden:true,editable:false,cellclassname:cellclassname}, 
    					{ text: 'tourtaxtype',datafield: 'tourtaxtype',hidden:true,editable:false,cellclassname:cellclassname}, 
    					{ text: 'Tour docno',datafield: 'tourdocno',hidden:true,editable:false,cellclassname:cellclassname}, 
    					{ text: 'refname',datafield: 'refname',hidden:true,editable:false,cellclassname:cellclassname}, 
    					{ text: 'cldocno',datafield: 'cldocno',hidden:true,editable:false,cellclassname:cellclassname},   
    					{ text: 'salesagent',datafield: 'salesagent',hidden:true,editable:false,cellclassname:cellclassname}, 
    					{ text: 'satacno',datafield: 'satacno',hidden:true,editable:false,cellclassname:cellclassname}, 
    					{ text: 'satdocno',datafield: 'satdocno',hidden:true,editable:false,cellclassname:cellclassname},     
    					{ text: 'clientacno',datafield: 'clientacno',hidden:true,editable:false,cellclassname:cellclassname},             
    					{ text: 'confirm',datafield: 'confirm',hidden:true,editable:false,cellclassname:cellclassname},          
    					{ text: 'Date',datafield: 'date',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname, width: '7%', columntype: 'datetimeinput',
    					 createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {  
			               editor.jqxDateTimeInput({ showCalendarButton: true});
			             } },   
						{ text: 'Time',datafield: 'time', width: '7%',cellclassname:cellclassname},   
    					{ text: 'rowno',datafield: 'rowno',hidden:true,editable:false},   
    					{ text: 'Vendor',datafield: 'vendor', width: '20%',editable:false,cellclassname:cellclassname},                            
    					{ text: 'vnd id',datafield: 'vndid',hidden:true,editable:false,cellclassname:cellclassname},     
    					{ text: 'Infant',datafield: 'infant', width: '4%',cellsalign:'right',align:'right',cellclassname:cellclassname,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Adult',datafield: 'adult', width: '4%',cellsalign:'right',align:'right',cellclassname:cellclassname,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'SP Adult',datafield: 'spadult', width: '7%',cellsformat: 'd2',cellsalign:'right',cellclassname:cellclassname,align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Std.Price',datafield: 'adultval',cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:cellclassname,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},   
    					{ text: 'Type',datafield: 'distype', width: '7%',editable:true,cellclassname:cellclassname,columntype:'dropdownlist',
    						createeditor: function (row, column, editor) {    
                            billlist = ["DISCOUNT",  "PAY BACK"];      
    							editor.jqxDropDownList({ autoDropDownHeight: true, source: billlist });   
    						},
    				 	 initeditor: function (row, cellvalue, editor) {
    						var terms = $('#tourGrid').jqxGrid('getcellvalue', row, "distype");
    							editor.jqxDropDownList({ autoDropDownHeight: true, source: billlist });     
                         },cellbeginedit: function (row) {
						     if (parseInt($('#jvtrno').val())>0)     
						       return false;  
						}},      
						{ text: 'Discount(Adult)',datafield: 'adultdis', width: '7%',editable:true,cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellbeginedit: function (row) {
						     if (parseInt($('#jvtrno').val())>0)     
						       return false;  
						}},
    					{ text: 'Child',datafield: 'child', width: '4%',cellsalign:'right',align:'right',cellclassname:cellclassname,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'SP Child',datafield: 'spchild', width: '7%',cellsformat: 'd2',cellsalign:'right',cellclassname:cellclassname,align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Std.Price',datafield: 'childval',cellsformat: 'd2',cellsalign:'right',align:'right',cellclassname:cellclassname,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
    					{ text: 'Discount(Child)',datafield: 'childdis', width: '7%',editable:true,cellsformat: 'd2',cellclassname:cellclassname,cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellbeginedit: function (row) {
						     if (parseInt($('#jvtrno').val())>0)     
						       return false;  
						}},       
    					{ text: 'Total',datafield: 'total',cellsformat: 'd2',width: '7%',cellsalign:'right',align:'right',cellclassname:cellclassname,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'STD Total',datafield: 'stdtotal',cellsformat: 'd2',width: '7%',cellsalign:'right',align:'right',cellclassname:cellclassname,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
    					{ text: 'Remarks',datafield: 'remarks', width: '14%',editable:false,cellclassname:cellclassname},
    					  
    					{ text: 'Transfer id',datafield: 'transferid',hidden:true,editable:false}, 
    					{ text: 'Group id',datafield: 'groupid',hidden:true,editable:false},                        
    					{ text: 'Transfer Type',datafield: 'transfertype',hidden:true,editable:false},
    					{ text: 'Quantity',datafield: 'qty',hidden:true,editable:false},
    					{ text: 'Location Type',datafield: 'loctype',hidden:true,editable:false},
    					{ text: 'Ref Name',datafield: 'rname',hidden:true,editable:false},   
    					{ text: 'Ref No',datafield: 'refno',hidden:true,editable:false},
    					{ text: 'Pickup Location Id',datafield: 'plocid',hidden:true,editable:false},
    					{ text: 'Pickup Location Time',datafield: 'ploctime',hidden:true,editable:false},
    					{ text: 'Droff Location Id',datafield: 'dlocid',hidden:true,editable:false},
    					{ text: 'Roundtrip id',datafield: 'rtripid',hidden:true,editable:false},
    					{ text: 'Travel Total',datafield: 'tvltotal',cellsformat: 'd2',width: '7%',cellclassname:cellclassname,cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Pickup Location Id',datafield: 'rndplocid',hidden:true,editable:false},
    					{ text: 'Pickup Location Time',datafield: 'rndploctime',hidden:true,editable:false},  
    					{ text: 'Droff Location Id',datafield: 'rnddlocid',hidden:true,editable:false},
    					{ text: 'xo docno',datafield: 'xodocno',hidden:true,editable:false}, 
    					{ text: 'rowdelete', datafield: 'rowdelete',width: '34%',hidden:true,cellclassname:cellclassname },   
    	              
    					{ text: 'tarifdetaildocno',datafield: 'tarifdetaildocno',hidden:true,editable:false},
    					{ text: 'estdistance',datafield: 'estdistance',editable:false,hidden:true},
    					{ text: 'esttime',datafield: 'esttime',editable:false,hidden:true},      
    					{ text: 'exdistancerate',datafield: 'exdistancerate',editable:false,hidden:true},
    					{ text: 'extimerate',datafield: 'extimerate',hidden:true,editable:false},   
    					{ text: 'tourtransferrate',datafield: 'tourtransferrate',hidden:true,editable:false},
    					{ text: 'tourtransferratetot',datafield: 'tourtransferratetot',hidden:true,editable:false},
    					{ text: 'rttarifdetaildocno',datafield: 'rttarifdetaildocno',hidden:true,editable:false},
    					{ text: 'rtestdistance',datafield: 'rtestdistance',hidden:true,editable:false},
    					{ text: 'rtesttime',datafield: 'rtesttime',hidden:true,editable:false},
    					{ text: 'rtexdistancerate',datafield: 'rtexdistancerate',hidden:true,editable:false},
    					{ text: 'rtextimerate',datafield: 'rtextimerate',hidden:true,editable:false},
    					{ text: 'rttourtransferrate',datafield: 'rttourtransferrate',hidden:true,editable:false},
    					{ text: 'tarifdocno',datafield: 'tarifdocno',hidden:true,editable:false},
    					{ text: 'rttarifdocno',datafield: 'rttarifdocno',hidden:true,editable:false},
    					{ text: 'adultdismax',datafield: 'adultdismax',hidden:true,editable:false},
    					{ text: 'childdismax',datafield: 'childdismax',hidden:true,editable:false},
    					{ text: 'stocktype',datafield: 'stocktype',hidden:true,editable:false},
    					{ text: 'stockid',datafield: 'stockid',hidden:true,editable:false},       
    					]                                                                  
                });   
    	var rdocno=$('#txtrdocno').val();     
    	if(rdocno!=''){ 
    		 document.getElementById("refnametr").value=$('#tourGrid').jqxGrid('getcellvalue', 0, "refname");
    		 document.getElementById("cldocnotr").value=$('#tourGrid').jqxGrid('getcellvalue', 0, "cldocno");
    		 document.getElementById("clientacno").value=$('#tourGrid').jqxGrid('getcellvalue', 0, "clientacno");
    		 document.getElementById("jqxsalesagent").value=$('#tourGrid').jqxGrid('getcellvalue', 0, "salesagent");   
    	     var satdocno=$('#tourGrid').jqxGrid('getcellvalue', 0, "satdocno");
    		 document.getElementById("salesagentdocno").value=satdocno;    
    		 document.getElementById("salesagentacno").value=$('#tourGrid').jqxGrid('getcellvalue', 0, "satacno");       
    		 if(typeof(satdocno) != "undefined" && typeof(satdocno) != "NaN" && satdocno != "" && satdocno != 0){
    		 document.getElementById("salesagent").value=1;  
    		 document.getElementById('salesagent').checked=true;     
    		 $('#jqxsalesagent').attr('disabled', false);        
    		 }
    	}
       $("#tourGrid").jqxGrid('addrow', null, {});        
       $('#tourGrid').on('celldoubleclick', function (event) {               
           var rowindex2 = event.args.rowindex; 
           document.getElementById("tourrow").value=$('#tourGrid').jqxGrid('getcellvalue', rowindex2, "rowno");
          /*  document.getElementById("touradult").value=$('#tourGrid').jqxGrid('getcellvalue', rowindex2, "adult");    
           document.getElementById("tourchild").value=$('#tourGrid').jqxGrid('getcellvalue', rowindex2, "child");    
           $("#tourSubGrid").jqxGrid('clear'); 
           var rowno=$('#tourGrid').jqxGrid('getcellvalue', rowindex2, "rowno");
           if(rowno>0){        
        	   $('#toursubdiv').load('tourSubGrid.jsp?rdocno='+rowno);  
           } */          
       });          
       $('#tourGrid').on('cellvaluechanged', function (event) {                                                                
	         var datafield = event.args.datafield;
	         var rowindextemp = event.args.rowindex;
	   	     var adultdis=$('#tourGrid').jqxGrid('getcellvalue', rowindextemp, "adultdis");  
	       	 var childdis=$('#tourGrid').jqxGrid('getcellvalue', rowindextemp, "childdis");  
	     	 var child=$('#tourGrid').jqxGrid('getcellvalue', rowindextemp, "child");
	     	 var adult=$('#tourGrid').jqxGrid('getcellvalue', rowindextemp, "adult");
	         var distype=$('#tourGrid').jqxGrid('getcellvalue', rowindextemp, "distype");  
	     	 var spchild=$('#tourGrid').jqxGrid('getcellvalue', rowindextemp, "spchild");            
	     	 var spadult=$('#tourGrid').jqxGrid('getcellvalue', rowindextemp, "spadult");
	         //var admaxdis=$('#admaxdis').val();
	     	 //var chmaxdis=$('#chmaxdis').val();
	         if($('#privatetr').val()=="0"){
	         	 var total=(parseFloat(spadult)*parseFloat(adult))+(parseFloat(spchild)*parseFloat(child)); 
	       	 if(datafield=="adultdis"){
	       	   if(typeof(adultdis) != "undefined" && typeof(adultdis) != "NaN" && adultdis != ""  && adultdis != "0" && adultdis!='0.00'){
	       		/* if(adultdis>admaxdis){
	       			swal({
	       				type: 'warning',
	       				title: 'Warning',     
	       				text: 'Maximum adult discount is '+admaxdis    
	       				});   
	       		} */
					 if(distype=="DISCOUNT"){
						 if(typeof(childdis) != "undefined" && typeof(childdis) != "NaN" && childdis!='' && childdis!='0' && childdis!='0.00'){
							 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child))-(parseFloat(adultdis)*parseFloat(adult));
						 }else{
							 total=parseFloat(total)-(parseFloat(adultdis)*parseFloat(adult));      
						 }
					 }else if(distype=="PAY BACK"){        
						 if(typeof(childdis) != "undefined" && typeof(childdis) != "NaN" && childdis!='' && childdis!='0' && childdis!='0.00'){
							 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child))+(parseFloat(adultdis)*parseFloat(adult));
						 }else{
							 total=parseFloat(total)+(parseFloat(adultdis)*parseFloat(adult));             
						 }
					 }else{   
						 total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));
					 }
				 }
	         	$('#tourGrid').jqxGrid('setcellvalue', rowindextemp, "total",total); 
	       	 }
	       	if(datafield=="childdis"){   
	       	 if(typeof(childdis) != "undefined" && typeof(childdis) != "NaN" && childdis!='' && childdis!='0' && childdis!='0.00'){  
	       		/* if(childdis>chmaxdis){
	       			swal({
	       					type: 'warning',
	       					title: 'Warning',     
	       					text: 'Maximum child discount is '+chmaxdis
	       				});
	       		} */
				 if(distype=="DISCOUNT"){
					 if(typeof(adultdis) != "undefined" && typeof(adultdis) != "NaN" && adultdis != ""  && adultdis != "0" && adultdis!='0.00'){ 
						 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child))-(parseFloat(adultdis)*parseFloat(adult));
					 }else{
						 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child));
					 }
					 }else if(distype=="PAY BACK"){  
						 if(typeof(adultdis) != "undefined" && typeof(adultdis) != "NaN" && adultdis != ""  && adultdis != "0" && adultdis!='0.00'){ 
							 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child))+(parseFloat(adultdis)*parseFloat(adult)); 
					 }else{
						 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child));   
					 }
					 }else{   
						 total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));
					 }
			   }
	     	 $('#tourGrid').jqxGrid('setcellvalue', rowindextemp, "total",total); 
	       	}
	       	if(datafield=="distype"){   
	       	 if(distype=="DISCOUNT"){
				 if((typeof(adultdis) != "undefined" && typeof(adultdis) != "NaN" && adultdis != ""  && adultdis != "0" && adultdis!='0.00') && (typeof(childdis) == "undefined" || typeof(childdis) == "NaN" || childdis=='' || childdis=='0' || childdis=='0.00')){         
					 total=parseFloat(total)-(parseFloat(adultdis)*parseFloat(adult)); 
				 }else if((typeof(adultdis) == "undefined" || typeof(adultdis) == "NaN" || adultdis == ""  || adultdis == "0" || adultdis=='0.00') && (typeof(childdis) != "undefined" && typeof(childdis) != "NaN" && childdis!='' && childdis!='0' && childdis!='0.00')){
					 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child)); 
				 }else if((typeof(adultdis) != "undefined" && typeof(adultdis) != "NaN" && adultdis != ""  && adultdis != "0" && adultdis!='0.00') && (typeof(childdis) != "undefined" && typeof(childdis) != "NaN" && childdis!='' && childdis!='0' && childdis!='0.00')){
					 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child))-(parseFloat(adultdis)*parseFloat(adult)); 
				 }else{}
			 }else if(distype=="PAY BACK"){          
				 if((typeof(adultdis) != "undefined" && typeof(adultdis) != "NaN" && adultdis != ""  && adultdis != "0" && adultdis!='0.00') && (typeof(childdis) == "undefined" || typeof(childdis) == "NaN" || childdis=='' || childdis=='0' || childdis=='0.00')){             
					 total=parseFloat(total)+(parseFloat(adultdis)*parseFloat(adult)); 
				 }else if((typeof(adultdis) == "undefined" || typeof(adultdis) == "NaN" || adultdis == ""  || adultdis == "0" || adultdis=='0.00') && (typeof(childdis) != "undefined" && typeof(childdis) != "NaN" && childdis!='' && childdis!='0' && childdis!='0.00')){
					 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child)); 
				 }else if((typeof(adultdis) != "undefined" && typeof(adultdis) != "NaN" && adultdis != ""  && adultdis != "0" && adultdis!='0.00') && (typeof(childdis) != "undefined" && typeof(childdis) != "NaN" && childdis!='' && childdis!='0' && childdis!='0.00')){
					 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child))+(parseFloat(adultdis)*parseFloat(adult)); 
				 }else{}  
			 }else{      
				 total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));
				 $('#tourGrid').jqxGrid('setcellvalue', rowindextemp, "adultdis",0);   
				 $('#tourGrid').jqxGrid('setcellvalue', rowindextemp, "childdis",0);   
			 }
	       	$('#tourGrid').jqxGrid('setcellvalue', rowindextemp, "total",total);       
	       	}  
	       }else{
	    	 	 var total=parseFloat(spadult);              
	    	     if(datafield=="adultdis"){  
		       	   if(typeof(adultdis) != "undefined" && typeof(adultdis) != "NaN" && adultdis != ""  && adultdis != "0" && adultdis!='0.00'){
						 if(distype=="DISCOUNT"){
								 total=parseFloat(total)-parseFloat(adultdis);        
						 }else if(distype=="PAY BACK"){        
								 total=parseFloat(total)+parseFloat(adultdis);    
						 }else{   
							 total=parseFloat(spadult);          
						 }   
					 }
		         	$('#tourGrid').jqxGrid('setcellvalue', rowindextemp, "total",total); 
		       	 }
		       	if(datafield=="distype"){   
		       	 if(distype=="DISCOUNT"){                     
					 if(typeof(adultdis) != "undefined" && typeof(adultdis) != "NaN" && adultdis != ""  && adultdis != "0" && adultdis!='0.00'){         
						 total=parseFloat(total)-parseFloat(adultdis);        
					 }else{}
				 }else if(distype=="PAY BACK"){          
					 if(typeof(adultdis) != "undefined" && typeof(adultdis) != "NaN" && adultdis != ""  && adultdis != "0" && adultdis!='0.00'){             
						 total=parseFloat(total)+parseFloat(adultdis);     
					 }else{}          
				 }else{        
					 total=parseFloat(spadult);    
					 $('#tourGrid').jqxGrid('setcellvalue', rowindextemp, "adultdis",0);   
					 $('#tourGrid').jqxGrid('setcellvalue', rowindextemp, "childdis",0);          
				 }
		       	$('#tourGrid').jqxGrid('setcellvalue', rowindextemp, "total",total);       
		       	}               
	       }	
          });
           $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#tourGrid").on('contextmenu', function () {
                   return false;
               });
                   
               $("#Menu2").on('itemclick', function (event) {          
            	   var args = event.args;
                   var rowindex = $("#tourGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#tourGrid").offset();
                       $("#popupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#tourGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow2").jqxWindow('show');
                   }
                   else {  
                       var rowid = $("#tourGrid").jqxGrid('getrowid', rowindex);      
                       var xodocno= $('#tourGrid').jqxGrid('getcellvalue', rowid, "xodocno");
                       var rowno= $('#tourGrid').jqxGrid('getcellvalue', rowid, "rowno");
                       if(typeof(rowno) == "undefined" || typeof(rowno) == "NaN" || rowno == "" || rowno == "0" || rowno == null){
                    	   var val=1;
	                       $('#tourGrid').jqxGrid('setcellvalue', rowid, "rowdelete" ,val);  
                       }    
                       if(typeof(xodocno) == "undefined" || typeof(xodocno) == "NaN" || xodocno == "" || xodocno == "0" || xodocno == null){         
                           var val=1;
	                       $('#tourGrid').jqxGrid('setcellvalue', rowid, "rowdelete" ,val);                                                             
                       }                         
                   }
               });
               
               $("#tourGrid").on('rowclick', function (event) {
                   var rowindex = $("#tourGrid").jqxGrid('getselectedrowindex');
                   if (event.args.rightclick) {   
                       $("#tourGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
        		   }
               });
	});
</script>
  <div id='jqxWidget'>
 <div id="tourGrid"></div>
    <div id="popupWindow2">
 
 <div id='Menu2'>
        <ul>
            <li>Delete Selected Row</li>  
        </ul>
       </div>
       </div>
       </div>