<%@ page import="com.dashboard.travel.hotelpricemanagement.ClsHotelPriceManagementDAO" %>  
<%ClsHotelPriceManagementDAO DAO=new ClsHotelPriceManagementDAO(); %> 
       <script type="text/javascript">
       var catdata;
       catdata= '<%=DAO.searchCategory() %>';      
		$(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: catdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxcategorySearch").jqxGrid(   
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
                          { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                          { text: 'Category', datafield: 'name', width: '100%' }  
						]
            });
            $( "#btncatID" ).click(function() {
            	var rows = $("#jqxcategorySearch").jqxGrid('selectedrowindexes');
             	var tempdocno="",tempname="";	  
            	for(var i=0;i<rows.length;i++){   
            		var docno=$('#jqxcategorySearch').jqxGrid('getcellvalue',rows[i],'doc_no');
            		var name=$('#jqxcategorySearch').jqxGrid('getcellvalue',rows[i],'name');
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
                $('#jqxpricegrid').jqxGrid('setcellvalue', rowIndex, "pcat" ,tempname);
                $('#jqxpricegrid').jqxGrid('setcellvalue', rowIndex, "pcatid" ,tempdocno);
                $('#categorysearchwndow').jqxWindow('close');
            });	
        });
    </script>   
    <div align="center" style="padding-bottom:4px;"><button type="button" id="btncatID" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
    <div id="jqxcategorySearch"></div>