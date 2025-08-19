<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.showroom.showroomtransaction.ClsShowroomTransactionDAO" %>
<%
        ClsShowroomTransactionDAO DAO= new ClsShowroomTransactionDAO();  
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());
%>   
<script type="text/javascript">
  
var vatdata;
var id='<%=id%>';
if(parseInt(id)>0){
	vatdata=[ {
		"refname": "Ravin K Madhu",
		"cldocno": "1",
		"mobile": "0581404505 ",
		"whatsappno": "0581404505 ",
		"sal_name": "RABIN MUKHERJEE BAIDYA NATH MUKHERJEE",
		"address": "Jubail  ",
		"email": "mailto:info@gatewayerp.com"
	}, {
		"refname": "M C Paul",
		"cldocno": "2",
		"mobile": "055 2203247",
		"whatsappno": "0581404505 ",
		"sal_name": "MD WASHIM ASHRAF",
		"address": "PO BOX 1969 - Dammam-31952, K.S.A  ",
		"email": "mailto:info@gatewayerp.com"
	}, {
		"refname": "Shankar",
		"cldocno": "3",
		"mobile": "0598848524",
		"whatsappno": "0581404505 ",
		"sal_name": "UBAYDULLA HAMEED SOORINJE",
		"address": "Jubail  ",
		"email": "mailto:info@gatewayerp.com"
	}, {
		"refname": "AWAN",
		"cldocno": "4",
		"mobile": "0504968970",
		"whatsappno": "0581404505 ",
		"sal_name": "RABIN MUKHERJEE BAIDYA NATH MUKHERJEE",
		"address": "Al Jubail  ",
		"email": "mailto:info@gatewayerp.com"
	}, {
		"refname": "Joseph Mathews",
		"cldocno": "5",
		"mobile": "0508254825",
		"whatsappno": "0581404505 ",
		"sal_name": "MANSOOR ALI",
		"address": "Al Dahran  ",
		"email": "mailto:info@gatewayerp.com"
	}, {
		"refname": "Issam Kabbani",
		"cldocno": "6",
		"mobile": "+966 565297348 ",
		"whatsappno": "0581404505 ",
		"sal_name": "RABIN MUKHERJEE BAIDYA NATH MUKHERJEE",
		"address": "Riyadh  ",
		"email": "mailto:info@gatewayerp.com"
	}, {
		"refname": "Vikram",
		"cldocno": "7",
		"mobile": "0545611875",
		"whatsappno": "0581404505 ",
		"sal_name": "MD WASHIM ASHRAF",
		"address": "Al Jubail  ",
		"email": "mailto:info@gatewayerp.com"
	}, {
		"refname": "Sophiya jeorge",
		"cldocno": "8",
		"mobile": "0502457904",
		"whatsappno": "0581404505 ",
		"sal_name": "MD WASHIM ASHRAF",
		"address": "Al Jubail  ",
		"email": "mailto:info@gatewayerp.com"
	}, {
		"refname": "Remiliya",
		"cldocno": "9",
		"mobile": "0533685249",
		"whatsappno": "0581404505 ",
		"sal_name": "MANSOOR ALI",
		"address": "Jubail  ",
		"email": "mailto:info@gatewayerp.com"
	}];
}else{
	vatdata;
}
$(document).ready(function () {      	
             var num = 1; 
        		<%--  vatdata='<%=DAO.maintGridLoad(session,id)%>'; --%>            
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'cldocno', type: 'String'  },   
                	{name : 'refname', type: 'String'  }, 
                	{name : 'email', type: 'String'  }, 
                	{name : 'sal_name', type: 'String'  }, 
                	{name : 'address', type: 'String'  }, 
                	{name : 'whatsappno', type: 'String'  }, 
                	{name : 'mobile', type: 'String'  },  
                 ],
                 localdata: vatdata,  
                
                
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

            
            $("#jqxVAGrid").jqxGrid(  
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                editable: false,
                altRows: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
            	//showaggregates: true,
             	//showstatusbar:true,
             	//statusbarheight:25,
       
                columns: [
	                	 { text: 'SL#', sortable: false, filterable: false, editable: false,
	                         groupable: false, draggable: false, resizable: false,  
	                         datafield: 'sl', columntype: 'number', width: '4%',
	                         cellsrenderer: function (row, column, value) {
	                             return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	                         }  
	                       },	
	                       { text: 'Doc No', datafield: 'cldocno',editable:false,width:'6%'},  
	                       { text: 'Name', datafield: 'refname',editable:false},  
	                       { text: 'Mobile', datafield: 'mobile', width: '11%' ,editable:false},
	                   	   { text: 'Email', datafield: 'email', width: '12%' ,editable:false},
	                   	   { text: 'Address', datafield: 'address', width: '18%' ,editable:false},
	                   	   { text: 'Whatsapp No', datafield: 'whatsappno', width: '11%' ,editable:false},
	                   	   { text: 'Salesman', datafield: 'sal_name', width: '14%' ,editable:false},     
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxVAGrid').on('rowdoubleclick', function (event) {       
             	  var rowindex1=event.args.rowindex;    
             	  document.getElementById("hiddocno").value=$('#jqxVAGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
             	  document.getElementById("lblname").value=$('#jqxVAGrid').jqxGrid('getcellvalue', rowindex1, "cldocno")+" - "+$('#jqxVAGrid').jqxGrid('getcellvalue', rowindex1, "refname");  
            	  $('.textpanel p').text($('#jqxVAGrid').jqxGrid('getcellvalue', rowindex1, "cldocno")+' - '+$('#jqxVAGrid').jqxGrid('getcellvalue', rowindex1, "refname"));
             	  $('.comments-container').html('');    
            });
        });
    </script>
    <div id="jqxVAGrid"></div>   