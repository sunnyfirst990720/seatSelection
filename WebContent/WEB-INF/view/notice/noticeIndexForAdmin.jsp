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
	<title>通知管理</title>
	<link rel="stylesheet" href="${path }/layui/css/layui.css" media="all">
	<script type="text/javascript" src="${path }/layui/layui.js" charset="utf-8"></script>
	
	<script type="text/javascript" charset="utf-8" src="${path }/ueditor1.4.3/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${path }/ueditor1.4.3/ueditor.all.min.js"> </script>
	<script type="text/javascript" charset="utf-8" src="${path }/ueditor1.4.3/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript" charset="utf-8" src="${path }/ueditor1.4.3/ueditor.parse.min.js"></script>
	<script type="text/javascript">
		
	</script>
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

	<div class="layui-row" id="popUpdateTest" style="display:none;">
    	<div class="layui-col-md11">
			<form id="noticeForm" class="layui-form" action="" lay-filter="formTest" style="margin-top:20px">
			  <div class="layui-form-item layui-hide">
			    <label class="layui-form-label">ID</label>
			    <div class="layui-input-block">
			      <input type="text" name="id" lay-verify="" autocomplete="off" placeholder="请输入ID" class="layui-input" readonly>
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">标题</label>
			    <div class="layui-input-block">
			      <input type="text" name="title" lay-verify="required" autocomplete="off" placeholder="请输入标题" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">正文</label>
			    <div class="layui-input-block">
			      	<textarea  id="editorContainer" type="text/plain" style="width:700px;height:300px;" name="content"></textarea >
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" lay-submit="" lay-filter="submit">立即提交</button>
			    </div>
			  </div>
			</form>
    	</div>
    </div>
	

	<!-- 表格样式 -->
    <table class="layui-hide" id="demo" lay-filter="test"></table>
    <!--超链接转换  -->
	<script type="text/html" id="titleTpl">
  		<a href="detail.htm?id={{d.id}}" class="layui-table-link" target="_blank">{{ d.title }}</a>
	</script>
	
	<!--行工具样式-->
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
	
	<!-- 头工具栏样式 -->
	<script type="text/html" id="toolbarDemo">
	<div class="layui-form-item">
  		<div class="layui-btn-group layui-inline">
    		<button class="layui-btn layui-btn-sm" lay-event="add" title="添加"><i class="layui-icon"></i>添加通知</button>
    		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete" title="批量删除"><i class="layui-icon"></i>批量删除</button>
  		</div>
	</div>
	</script>
</body>
<script>
	//初始化富文本框
	//var ueditor = UE.getEditor('editorContainer');
    layui.use(['table', 'form', 'layer'], function() {
    	//var ue = UE.getEditor('editor');
        var form = layui.form
            , table = layui.table
            , layer = layui.layer
            , vipTable = layui.vip_table
            , $ = layui.jquery;
		
        //执行一个 table 实例
        table.render({
            elem: '#demo',
            height: 'full-40',
            title: '用户表',
            page: true, //开启分页
            toolbar: '#toolbarDemo' ,//开启工具栏，此处显示默认图标，可以自定义模板，详见文档,
            limits:[10,20,30,40],
            limit:20,
            cols: [//表头
                [ 
                	{ type: 'checkbox', fixed: 'left' },
                    { field: 'id', title: 'ID', sort: true, hide:true },
                    { field: 'title', title: '标题',align:'center', templet: '#titleTpl'}, 
                    { field: 'content', title: '内容', hide:true  }, 
                    { field: 'time', title: '时间',align:'center', sort: true }, 
                    { fixed: 'right',title: '操作', width: 256, align: 'center', toolbar: '#barDemo' }
                ]
            ],
	        url: '${path }/notice/noticeList.htm',
	        method: 'post',
            done: function (res) {
                //如果是异步请求数据方式，res即为接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                console.log(res);
            }
        });

      //监听头工具栏事件
        table.on('toolbar(test)', function(obj) {
            var checkStatus = table.checkStatus(obj.config.id),
            data = checkStatus.data; //获取选中行的数据
            switch(obj.event) {
                case 'add': //添加一行数据
    	    		
    	    		document.getElementById("noticeForm").reset(); //清空表单数据
                    layer.open({ //显示表单
	                    type: 1,
	                    title: "添加通知",
	                    area: ['900px', '660px'],
	                    maxmin: true,
	                    shade: 0,
	                    content: $('#popUpdateTest'),//引用的弹出层的页面层的方式加载修改界面表单
	                    success: function(){
	                    	var ue = UE.getEditor('editorContainer',{
	                        	zIndex: "999999999"
	                        });
	                        ue.ready(function () {
	                            ue.execCommand('cleardoc');
	                        })
	                    },end:function () {
	                        UE.getEditor('editorContainer').destroy();
	                        $('#editorContainer').attr('style','width:700px;height:300px;');
	                    }
	                });
                    setFormValue(obj);
                    break;
                case 'delete': //批量删除
                    if(data.length === 0) {
                        layer.msg('请至少选择一行');
                    } else {
                    	layer.confirm('确认删除'+data.length+'条数据吗？', {
                            btn: ['确认','取消'] //按钮
                        }, function(){
			                var ids = '';
			                layui.each(data,function(k,v){
			                    ids += v.id+',';
			                });
			                console.log(ids);
			                $.ajax({
				                url:'deleteNotice.htm',
				                type:'post',
				                dataType:'json',
				                data:{ids:ids},
				                success:function (result){
				                    var returnCode = result.returnCode;
				                    if(returnCode == 200){
				                        layer.msg("已成功删除"+result.delNums+"条数据！", {icon: 6});
				                        table.reload('demo');
				                    }else{
				                        layer.msg(returnCode, {icon: 5});
				                    }
				                }
				            })
                        });
                   }
                   break;
            };
        });
        //监听行工具事件
        table.on('tool(test)', function(obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data ,//获得当前行数据
                layEvent = obj.event; //获得 lay-event 对应的值
            //删除此行
            if(layEvent === 'del') {
                layer.confirm('确定删除吗？', function(index) {
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
		                url:'deleteNotice.htm',
		                type:'post',
		                dataType:'json',
		                data:{ids:data.id},
		                success:function (result){
		                    var returnCode = result.returnCode;
		                    if(returnCode == 200){
		                    	obj.del(); //删除对应行结构
		                        layer.msg("已成功删除!", {icon: 6});
		                    }else{
		                        layer.msg(returnCode, {icon: 5});
		                    }
		                }
		            })
                });
            }
            //编辑
            else if(layEvent === 'edit') {
                layer.open({
                    type: 1,
                    title: "修改通知信息",
                    area: ['900px', '660px'],
                    maxmin: true,
                    shade: 0,
                    content: $('#popUpdateTest'),
                    success: function(){
                        var ue = UE.getEditor('editorContainer',{
                        	zIndex: "999999999"
                        });
                        ue.ready(function () {
                            ue.setContent(data.content)
                        })
                    },end:function () {
                        UE.getEditor('editorContainer').destroy();
                        $('#editorContainer').val("");
                        $('#editorContainer').attr('style','width:700px;height:300px;');
                    }
                });
                form.val("formTest", data);
                setFormValue(obj);
            }
        });
        //修改添加表单的提交操作
        function setFormValue(obj){
        
	        form.on('submit(submit)', function(massage) {
	            $.ajax({
	                url:'reserveNotice.htm',
	                type:'post',
	                dataType:'json',
	                data:massage.field,
	                success:function (result){
	                    var returnCode = result.returnCode;
	                    if(returnCode == 200){ //修改成功
	                        layer.closeAll('loading');
	                        layer.load(2);
	                        layer.msg("修改成功", {icon: 6});
	                        setTimeout(function(){
	                        	obj.update(massage.field);
	                           layer.closeAll();//关闭所有的弹出层
	                        }, 1000);
	                    }else if(returnCode == 300){ //添加成功
	                    	layer.closeAll('loading');
	                        layer.load(2);
	                        layer.msg("添加成功", {icon: 6});
	                        setTimeout(function(){
	                        	table.reload('demo', {
                        		  where: {}
                        		  ,page: {
                        		    curr: 1 //重新从第 1 页开始
                        		  }
                        		});
	                           	layer.closeAll();//关闭所有的弹出层
	                        }, 1000);
	                    }else{
	                        layer.msg(returnCode, {icon: 5}); //操作失败
	                    }
	                }
	            })
	            return false;
	        })  
        };
	  
    });
</script>
</html>
