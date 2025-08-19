<%@page import="com.controlcentre.masters.vehiclemaster.category.ClsCategoryAction" %>
<%ClsCategoryAction cba=new ClsCategoryAction(); %>


    <script type="text/javascript">
  		var data= '<%=cba.searchDetails() %>';
        $(document).ready(function () { 	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'name', type: 'String'  },
                          	{name : 'date', type: 'date'  },
     						{name : 'code', type: 'String'  },

                 ],
               localdata: data,
                //url: "/searchDetails",
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
            $("#jqxCategorySearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
               filterable:true,
               showfilterrow:true,
               altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
					{ text: 'DOC NO',filtertype:'number', datafield: 'doc_no', width: '10%' },
					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '40%' },
					{ text: 'Code',columntype: 'textbox', filtertype: 'input', datafield: 'code', width: '40%' },

	              ]
            });
            $('#jqxCategorySearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxCategorySearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("category").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "name");
                $("#date_category").jqxDateTimeInput('val', $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "date"));
                //document.getElementById("search").style.display="none";
                document.getElementById("txtcode").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "code");
                $('#window').jqxWindow('hide');
            }); 
         
        });
    </script>
    <div id="jqxCategorySearch"></div>
