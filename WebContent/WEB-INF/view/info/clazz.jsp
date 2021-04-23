<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	/**-====================================================================
	*                               基本常量的设定
	*=====================================================================**/
	//设定context path
	String path = request.getContextPath();
	if("/".equals(path.trim())) path = "";
	pageContext.setAttribute("path",path);
%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>班级列表</title>

    <link rel="shortcut icon" href="favicon.ico"> <link href="${path }/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="${path }/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">

    <!-- jqgrid -->
    <link href="${path }/css/plugins/jqgrid/ui.jqgridffe4.css?0820" rel="stylesheet">

    <link href="${path }/css/animate.min.css" rel="stylesheet">
    <link href="${path }/css/style.min862f.css?v=4.1.0" rel="stylesheet">

    <style>
        /* Additional style to fix warning dialog position */

        #alertmod_table_list_2 {
            top: 900px !important;
        }
    </style>
</head>
 
 
<body class="gray-bg">
    <div class="wrapper wrapper-content  animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox ">
                    <div class="ibox-content">
                        <h4 class="m-t">班级列表</h4>
                        <div class="jqGrid_wrapper">
                            <table id="table_list_2" ></table>
                            <div id="pager_list_2"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${path }/js/jquery.min.js?v=2.1.4"></script>
    <script src="${path }/js/bootstrap.min.js?v=3.3.6"></script>
    <script src="${path }/js/plugins/peity/jquery.peity.min.js"></script>
    <script src="${path }/js/plugins/jqgrid/i18n/grid.locale-cnffe4.js?0820"></script>
    <script src="${path }/js/plugins/jqgrid/jquery.jqGrid.minffe4.js?0820"></script>
    <script src="${path }/js/content.min.js?v=1.0.0"></script>
    <script>
    	$(document).ready
		(
			function()
			{
				$.ajax({
		            url:'${path }/clazz/clazzList.htm'
		            ,data:'pn=1'
		            ,type:'post'
		            ,dataType:'json'
		            ,success:function (result) {
		                $.jgrid.defaults.styleUI="Bootstrap";
						var mydata = result.rows;
						$("#table_list_2").jqGrid
						(
							{
								data:mydata,
								datatype:"local",
								height:600,
								autowidth:true,
								shrinkToFit:true,
								rowNum:20,
								rowList:[10,20,30],
								colNames:["班级id","班级名称","所属学院","专业","辅导员"],
								colModel:
								[
									{name:"id",index:"id",editable:true,width:60,sorttype:"int",search:true,hidden:true},
									{name:"name",index:"name",editable:true,width:90},
									{name:"xueyuan",index:"xueyuan",editable:true,width:100},
									{name:"zhuanye",index:"zhuanye",editable:true,width:80,align:"left"},
									{name:"teachername",index:"teachername",editable:true,width:80,align:"left"}
								],
								pager:"#pager_list_2",
								viewrecords:true,
								caption:"班级列表",
								add:true,
								edit:true,
								addtext:"Add",
								edittext:"Edit",
								hidegrid:false
							}
						);
						$("#table_list_2").setSelection(4,true);
						$("#table_list_2").jqGrid
						(
							"navGrid",
							"#pager_list_2",
							{edit:true,add:true,del:true,search:true},
							{height:400,reloadAfterSubmit:true}
						);
						$(window).bind
						(
							"resize",function()
							{
								var width=$(".jqGrid_wrapper").width();
								$("#table_list_2").setGridWidth(width)
							}
						)
		            }
		        });
				
			}
		);
    </script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
</body>
</html>
