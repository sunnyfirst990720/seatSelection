<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	//设定context path
	String path = request.getContextPath();
	if("/".equals(path.trim())) path = "";
	pageContext.setAttribute("path",path);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>阅览室余座信息</title>
	<link rel="stylesheet" href="${path }/layui/css/layui.css" media="all">
	<script type="text/javascript" src="${path }/layui/layui.js" charset="utf-8"></script>
    <style>
    	body {
            margin: 20px;
        }
        .layui-form-label{
            width: 100px;
        }
        .layui-input-block {
            margin-left: 130px;
            min-height: 36px
        }
    </style>
</head>
<body>
	<!-- 表格样式 -->
    <table class="layui-hide" id="demo" lay-filter="test"></table>
    
</body>
<script>
    layui.use(['table', 'form', 'layer'], function() {
        var form = layui.form
            , table = layui.table
            , layer = layui.layer
            , vipTable = layui.vip_table
            , $ = layui.jquery;

        //执行一个 table 实例
        table.render({
            elem: '#demo',
            height: 'full-40',
            title: '阅览室余座信息',
            page: false, //开启分页
            toolbar: false,
            limits:[10,20,30,40],
            limit:20,
            cols: [//表头
                [ 
                    { field: 'date', title: '日期', sort: true },
                    { field: 'time', title: '时间', sort: true }, 
                    { field: 'roomname', title: '阅览室名称' }, 
                    { field: 'page', title: '余座', sort: true }
                ]
            ],
	        url: '${path }/block/blockList.htm',
	        method: 'post',
            done: function (res) {
                console.log(res);
            }
        })
	})
</script>
</html>
