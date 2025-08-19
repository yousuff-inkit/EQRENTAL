<%@page import="com.controlcentre.masters.vehiclemaster.subcategory.ClsSubcategoryAction" %>
<%ClsSubcategoryAction csa=new ClsSubcategoryAction(); %>


    <script type="text/javascript">
  		var data= '<%=csa.searchDetails() %>';
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
     						{name : 'catid', type: 'String'  },
     						{name : 'catname', type: 'String'  },



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
            $("#jqxSubcategorySearch").jqxGrid(
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
					{ text: 'Code',columntype: 'textbox', filtertype: 'input', datafield: 'code', width: '30%' },
					{ text: 'Subcategory',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
					{ text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'catname', width: '20%' },
					{ text: 'Category ID',columntype: 'textbox', filtertype: 'input', datafield: 'catid', width: '20%' },

	              ]
            });
            $('#jqxSubcategorySearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxSubcategorySearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("name").value = $("#jqxSubcategorySearch").jqxGrid('getcellvalue', rowindex1, "name");
                $("#subcategorydate").jqxDateTimeInput('val', $("#jqxSubcategorySearch").jqxGrid('getcellvalue', rowindex1, "date"));
                //document.getElementById("search").style.display="none";
                document.getElementById("code").value = $("#jqxSubcategorySearch").jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("catname").value = $("#jqxSubcategorySearch").jqxGrid('getcellvalue', rowindex1, "catid");

                $('#window').jqxWindow('hide');
            }); 
         
        });
    </script>
    <div id="jqxSubcategorySearch"></div>
