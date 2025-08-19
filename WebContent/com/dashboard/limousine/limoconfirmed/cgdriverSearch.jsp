<%@page import="com.dashboard.limousine.booking.ClsLimoBookingDAO" %>
<% ClsLimoBookingDAO dao=new ClsLimoBookingDAO();%>
<script type="text/javascript">

var driverdata2;

	driverdata2='<%=dao.getDriverData()%>';          

$(document).ready(function () { 
	
       
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'doc_no' , type: 'int' },
                       	{name : 'name' , type:'string'},
                       	{name : 'mobile',type:'string'},
                       	{name : 'license',type:'string'},
                       	{name : 'date',type:'date'}
     				   ],
					localdata:driverdata2,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
        var dataAdapter = new $.jqx.dataAdapter(source);
        // Create a jqxInput  
         
        $("#jqxInputdriver2").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", items: 20 ,width: 250, height: 20});
        $("#jqxInputdriver2").on('select', function (event) {      
        	  if (event.args) {
                  var item = event.args.item;                
                  if (item) {
                      for (var i = 0; i < dataAdapter.records.length; i++) {             
                          if (item.value == dataAdapter.records[i].doc_no) {   
                        	  document.getElementById("cgdriver").value=dataAdapter.records[i].doc_no;
                        	  break;       
                          }
                      }
                  }
              }   
            }); 
            });
            </script>
       <input type="text" id="jqxInputdriver2"/>