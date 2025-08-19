<%@page import="com.dashboard.travel.cooperatetravel.ClsCooperateTravelDAO"%>
<% ClsCooperateTravelDAO DAO=new ClsCooperateTravelDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>           
<%@page import="javax.servlet.http.HttpSession" %>   
<%                 
    String locid=request.getParameter("locid")==null?"0":request.getParameter("locid").toString();
    String check=request.getParameter("check")==null?"0":request.getParameter("check").toString();
 	String todate=request.getParameter("todate")==null?"":request.getParameter("todate").toString();
 	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
%>      
 <style type="text/css">
  .AClass
  {
      background-color: #FBEFF5;
  }
  .BClass
  {
      background-color: #E0F8F1;
  }
  .CClass
  {
     background-color: #f3fab9;
  }
    .DClass
  {
     background-color: #ff9696 ;  
  }
</style>    
<script type="text/javascript">          
var unddata;
var dataexcel;
var flchk='<%=check%>';     
    
	if(flchk!='0'){      
		   unddata='<%=DAO.detailGrid(session,check,todate,brhid,locid) %>';                      
	}      
	else{   
		
	}
	 var rendererstring=function (aggregates){
	    	var value=aggregates['sum'];
	    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	    }
$(document).ready(function(){           
    
    var source =
    {             
            datatype: "json",
            datafields: [ 
                            {name : 'agentid' , type: 'string'}, 
		                 	{name : 'jvtrno' , type: 'string'},    
							{name : 'cldocno' , type: 'string'},  
							{name : 'voc_no' , type: 'string'},   
							{name : 'vndid' , type: 'string'},
							{name : 'doc_no' , type: 'string'},
							{name : 'date', type:'date'},     						
							{name : 'client' , type: 'string'},    
							{name : 'visa' , type: 'number'}, 
							{name : 'ticket' , type: 'number'},  
							{name : 'hotel' , type: 'number'},    
							{name : 'transfer' , type: 'number'},   
							{name : 'tour' , type: 'number'},   
							{name : 'mice' , type: 'number'},   
							{name : 'type' , type: 'string'}, 
							{name : 'total' , type: 'number'},
							{name : 'hotelname' , type: 'string'},   
							{name : 'location' , type: 'string'},  	
							{name : 'mob' , type: 'string'},   
							{name : 'email' , type: 'string'},  
							{name : 'limodocno' , type: 'string'}, 
							{name : 'disper' , type: 'number'}, 
							{name : 'confirm' , type: 'number'},      
							{name : 'adultdismax' , type: 'number'}, 
							{name : 'childdismax' , type: 'number'}, 
							{name : 'childdis' , type: 'number'}, 
							{name : 'adultdis' , type: 'number'},                                           
							{name : 'cstatus' , type: 'string'}, 
             ],                  
             localdata: unddata,    
              
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
    var cellclassname = function (row, column, value, data) {
		 if (data.confirm==0) {           
         //  return "DClass";
       }   
		 if(data.confirm==0 && $('#tourismconfig').val()!=1){         
				if(data.childdis!=0 || data.adultdis!=0){  
					 if(data.childdis>data.childdismax || data.adultdis>data.adultdismax){
						 return "DClass"; 
					 }
				}
			}
   };
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );
        $("#TravelGrid").jqxGrid(
                {
                	width: '100%',
                    height: 500,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    enabletooltips: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    sortable: true,  
                    columnsresize: true,
                    //Add row method
                    columns: [  
						{ text: 'Sr. No.',datafield: '',columntype:'number',cellclassname:cellclassname, width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },  
						    { text: 'Doc No',datafield: 'voc_no', width: '5%',cellclassname:cellclassname}, 
						    { text: 'agentid',datafield: 'agentid', width: '5%',hidden:true},
						    { text: 'limodocno',datafield: 'limodocno', width: '5%',hidden:true},
						    { text: 'confirm',datafield: 'confirm', width: '5%',hidden:true},
						    { text: 'adultdismax',datafield: 'adultdismax', width: '5%',hidden:true},
						    { text: 'childdismax',datafield: 'childdismax', width: '5%',hidden:true},
						    { text: 'childdis',datafield: 'childdis', width: '5%',hidden:true},
						    { text: 'adultdis',datafield: 'adultdis', width: '5%',hidden:true},          
						    { text: 'disper',datafield: 'disper', width: '5%',hidden:true},
						    { text: 'jvtrno',datafield: 'jvtrno', width: '5%',hidden:true},    
	    					{ text: 'Doc No',datafield: 'doc_no', width: '5%',hidden:true},
	    					{ text: 'Hotel',datafield: 'hotelname', width: '5%',hidden:true},
	    					{ text: 'Location',datafield: 'location', width: '5%',hidden:true},
	    					{ text: 'cldocno',datafield: 'cldocno', width: '5%',hidden:true},
	    					{ text: 'VNDID',datafield: 'vndid', width: '5%',hidden:true}, 
	    					{ text: 'Type',datafield: 'type', width: '8%',cellclassname:cellclassname},
	    					{ text: 'Date',datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},
							{ text: 'Client',datafield: 'client',cellclassname:cellclassname}, 
							{ text: 'Mobile',datafield: 'mob', width: '10%',cellclassname:cellclassname},         
							{ text: 'Email',datafield: 'email', width: '10%',cellclassname:cellclassname}, 
							{ text: 'Visa',datafield: 'visa', width: '5%',cellsalign: 'right', align:'right',cellclassname:cellclassname},          
	    					{ text: 'Ticket',datafield: 'ticket', width: '5%',cellsalign: 'right', align:'right',cellclassname:cellclassname},
	    					{ text: 'Hotel', datafield: 'hotel', width: '5%',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname}, 
	    					{ text: 'Transfer', datafield: 'transfer', width: '5%',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname},
							{ text: 'Tours', datafield: 'tour', width: '5%',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname},
							{ text: 'Mice', datafield: 'mice', width: '5%',cellsalign: 'right', align:'right',cellclassname:cellclassname},     
							{ text: 'Total', datafield: 'total', width: '5%',cellsalign: 'right', align:'right',hidden:true},  
							 { text: 'Status',datafield: 'cstatus', width: '7%',cellclassname:cellclassname},
							]                                                         
                });  
                   $("#overlay, #PleaseWait").hide();       
                   $('#TravelGrid').on('rowdoubleclick', function (event){            
                   var rowindex2 = event.args.rowindex;    
                   document.getElementById("agentid").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "agentid");   
                   document.getElementById("jvtrno").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "jvtrno");
                   document.getElementById("disper").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "disper");
                   document.getElementById("limodocno").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "limodocno");                   
                   document.getElementById("hidcldocno").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "cldocno");
                   document.getElementById("hidtype").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "type");
                   document.getElementById("hidhotel").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "hotelname");
                   document.getElementById("hidlocation").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "location");
                   document.getElementById("hidvocno").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "voc_no");
                   document.getElementById("txtrdocno").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
                   document.getElementById("txtrefname").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "client");
                   $('.textpanel p').text('Doc No '+$('#TravelGrid').jqxGrid('getcellvalue',rowindex2,'voc_no')+' - '+$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "client"));
                   $('.textclient p').text(''+$('#TravelGrid').jqxGrid('getcellvalue',rowindex2,'voc_no')+' - '+$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "client"));
                   $('.textclient').show();
                   $('.newclientinfo').hide();
                   $('.comments-container').html('');      
                   $('#jqxsalesagent').attr('disabled', true);            
                   document.getElementById("salesagent").value=0;        
          		   document.getElementById('salesagent').checked=false;     
          		   funMycartLoad();
	          		$('.wizard .nav-tabs li').addClass('disabled');
	 	            $('.wizard .nav-tabs li').removeClass('active');
	 	            $('.wizard .tab-content .tab-pane').removeClass('active');
	 	            $('.wizard-inner .nav-tabs li:nth-child(1)').addClass('active');
	 	            $('.wizard-inner .nav-tabs li:nth-child(1)').removeClass('disabled');
	 	            $('.wizard-inner .nav-tabs li:nth-child(1)').find('a').trigger('click');
	 	            $('.wizard .tab-content .tab-pane:nth-child(1)').addClass('active');
                   });     
	});      
</script>
<div id="TravelGrid"></div>