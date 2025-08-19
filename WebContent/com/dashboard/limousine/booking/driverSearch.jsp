<%@page import="com.dashboard.limousine.booking.ClsLimoBookingDAO" %>
<% ClsLimoBookingDAO dao=new ClsLimoBookingDAO();%>
<script type="text/javascript">

var driverdata1;

	driverdata1='<%=dao.getDriverData()%>';    

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
					localdata:driverdata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
        var dataAdapter = new $.jqx.dataAdapter(source);
        // Create a jqxInput  
         
        $("#jqxInputUser").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", items: 20 ,width: '100%', height: 20});
        $("#jqxInputUser").on('select', function (event) {      
        	  if (event.args) {
                  var item = event.args.item;                
                  if (item) {
                      for (var i = 0; i < dataAdapter.records.length; i++) {           
                          if (item.value == dataAdapter.records[i].doc_no) {   
                        	  document.getElementById("driver").value=dataAdapter.records[i].doc_no;
                        	  getDriverFleet(document.getElementById("driver").value);
                        	  /*select fleet_no from gl_lvehassign where srno=(select max(srno) maxsrno from gl_lvehassign where drid=2 and clstatus=0);*/
                        	  break;       
                          }
                      }
                  }
              }   
            }); 
            });
            </script>
       <input type="text" id="jqxInputUser" class="form-control"/>