<%@ page import="com.dashboard.travel.hotelbookingportal.ClsHotelBookingPortalDAO" %>  
<% ClsHotelBookingPortalDAO DAO=new ClsHotelBookingPortalDAO();%>
       <script type="text/javascript">
       var ndata;
       ndata= '<%=DAO.searchNation() %>';        
		$(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: ndata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxnationSearch").jqxGrid(   
                    {
                        width: '100%',
                        height: 330,
                        source: dataAdapter,
                        columnsresize: true,
                        altRows: true,   
                        showfilterrow: true, 
                        filterable: true, 
                        selectionmode: 'checkbox',     
                        columns: [
                                  { text: 'DOC NO', datafield: 'doc_no', width: '6%',hidden:true},
                                  { text: 'Nation', datafield: 'name', width: '100%' },   
        						]
                    });                   
            $( "#btnnationID" ).click(function() {
            	var rows = $("#jqxnationSearch").jqxGrid('selectedrowindexes');
             	var tempdocno="",tempname="";	  
            	for(var i=0;i<rows.length;i++){   
            		var docno=$('#jqxnationSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
            		var name=$('#jqxnationSearch').jqxGrid('getcellvalue',rows[i],'name');
            		if(i==0){
            			tempdocno=docno;
            			tempname=name;
            		}
            		else{
            			tempdocno+=","+docno;
            			tempname+=","+name;       
            		}
            	}
            	var rowIndex =$('#rowindex2').val();                                
                $('#jqxpricegrid').jqxGrid('setcellvalue', rowIndex, "nation" ,tempname);
                $('#jqxpricegrid').jqxGrid('setcellvalue', rowIndex, "nationid" ,tempdocno);
                $('#nationsearchwndow').jqxWindow('close');           
            });  
        });
            </script>
             <div align="center" style="padding-bottom:4px;"><button type="button" id="btnnationID" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="jqxnationSearch"></div>