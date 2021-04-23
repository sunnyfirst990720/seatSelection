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
	<title>资料列表</title>
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
    <!--表单样式 初始隐藏 -->
    <div class="layui-row" id="popUpdateTest" style="display:none;">
    	<div class="layui-col-md10">
			<form id="userForm" class="layui-form" action="" lay-filter="formTest" style="margin-top:20px">
			  <div class="layui-form-item">
			    <label class="layui-form-label">封面图片</label>
			    <div class="layui-input-block">
			      <img alt="封面图片" src="" id="img_id" height="300" width="200" align="middle">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">资料名称</label>
			    <div class="layui-input-block">
			      <input type="text" name="name" lay-verify="" autocomplete="off" placeholder="" class="layui-input" readonly>
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">作者</label>
			    <div class="layui-input-block">
			      <input type="text" name="author" lay-verify="" autocomplete="off" placeholder="" class="layui-input" readonly>
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">出版社</label>
			    <div class="layui-input-block">
			      <input type="text" name="publish" lay-verify="" autocomplete="off" placeholder="" class="layui-input" readonly>
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">索书号</label>
			    <div class="layui-input-block">
			      <input type="text" name="findnumber" lay-verify="" autocomplete="off" placeholder="" class="layui-input" readonly>
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">简介</label>
			    <div class="layui-input-block">
			      <textarea name="remarks" placeholder="" class="layui-textarea" readonly></textarea>
			    </div>
			  </div>
			  
			</form>
    	</div>
    </div>
    <script type="text/html" id="switchTpl">
  		{{#  if(d.status === 1){ }}
    		<span style="color: #01AAED;">未审核</span>
  		{{#  } else if(d.status == 2) { }}
    		<span style="color: #5FB878;">已通过</span>
  		{{#  } else { }}
    		<span style="color: #FF5722;">未通过</span>
  		{{#  } }}
	</script>
    
    <!--行工具样式-->
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
	
	<!--审核样式-->
    <script type="text/html" id="checkDemo">
        <a class="layui-btn layui-btn-radius layui-btn-xs" lay-event="pass">通过审核</a>
        <a class="layui-btn layui-btn-radius layui-btn-danger layui-btn-xs" lay-event="refuse">不通过</a>
    </script>
	
	<!-- 头工具栏样式 -->
	<script type="text/html" id="toolbarDemo">
	<div class="layui-form-item">
		
  		<div class="layui-inline">
			<div class="layui-input-inline">
    			<input type="text" id="s_name" name="s_name" lay-verify="" placeholder="按书名查询" autocomplete="off" class="layui-input">
			</div>
		</div>

		<div class="layui-inline">
			<div class="layui-input-inline">
    			<input type="text" id="s_author" name="s_author" lay-verify="" placeholder="按作者查询" autocomplete="off" class="layui-input">
			</div>
		</div>		

		<div class="layui-inline">
			<div class="layui-input-inline">
				<select id="s_status" name="s_status" lay-verify="">
  					<option value="">按审核状态查询</option>
  					<option value="1">待审核</option>
  					<option value="2">审核通过</option>
  					<option value="3">审核未通过</option>
				</select>
			</div>
		</div>
		<div class="layui-inline">
			<button class="layui-btn layui-btn-sm" lay-event="search" title="搜索"><i class="layui-icon layui-icon-search"/>搜索</button>
		</div>
	</div>
	</script>
	
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
            title: '用户表',
            page: true, //开启分页
            toolbar: '#toolbarDemo' ,//开启工具栏，此处显示默认图标，可以自定义模板，详见文档,
            limits:[10,20,30,40],
            limit:20,
            cols: [//表头
                [ 
                    { field: 'id', title: '资料id', sort: true, hide:true },
                    { field: 'cover', title: '书籍封面',hide:true },
                    { field: 'name', title: '资料名称', sort: true }, 
                    { field: 'author', title: '作者' }, 
                    { field: 'publish', title: '出版信息', sort: true, hide:true }, 
                    { field: 'findnumber', title: '索书号' },
                    { field: 'remarks', title: '简介',hide:true },
                    { field: 'status', title: '状态', width:128, templet: '#switchTpl'},
                    { fixed: 'right',title: '审核操作', width: 196, align: 'center', toolbar: '#checkDemo' },
                    { fixed: 'right',title: '其他操作', width: 256, align: 'center', toolbar: '#barDemo' }
                ]
            ],
	        url: '${path }/book/bookList.htm',
	        method: 'post',
            done: function (res) {
                //如果是异步请求数据方式，res即为接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                console.log(res);
            }
        });

        //监听头工具栏事件
        table.on('toolbar(test)', function(obj) {
            switch(obj.event) {
                case 'search': //搜索
               		var index = layer.msg('查询中，请稍候...',{icon: 16,time:false,shade:0});
                    setTimeout(function(){
                        table.reload('demo', { //表格的id
                            url:'bookList.htm',
                            where: {
                                'name':$('#s_name').val(),
                                'author':$('#s_author').val(),
                                'status':$('#s_status').val()
                            }
                        });
                        layer.close(index);
                    },800);
                	break;
            };
        });
        //监听行工具事件
        table.on('tool(test)', function(obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data ,//获得当前行数据
                layEvent = obj.event; //获得 lay-event 对应的值
            //查看详情
            if(layEvent === 'detail') {
            	$("#img_id").attr("src",data.cover);
                layer.open({
                    type: 1,
                    title: "资料详情",
                    area: ['720px', '720px'],
                    content: $('#popUpdateTest')
                });
                form.val("formTest", data)
                setFormValue(obj);
            }
            //删除此行
            else if(layEvent === 'del') {
                layer.confirm('确定删除吗？', function(index) {
                	
                    obj.del(); //删除对应行结构
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
		                url:'deleteBook.htm',
		                type:'post',
		                dataType:'json',
		                data:{ids:data.id},
		                success:function (result){
		                    var returnCode = result.returnCode;
		                    if(returnCode == 200){
		                        layer.msg("已成功删除!", {icon: 6});
		                    }else{
		                        layer.msg(returnCode, {icon: 5});
		                    }
		                }
		            })
                });
            }
            //通过审核
            else if(layEvent == 'pass'){
            	data.status=2;
            	$.ajax({
	                url:'reserveBook.htm',
	                type:'post',
	                dataType:'json',
	                data:data,
	                success:function (result){
	                    var returnCode = result.returnCode;
	                    if(returnCode == 200){ 
	                        layer.msg("操作成功", {icon: 6});
                        	obj.update({ //更新表格数据行
                        		status:2
                           });
	                    }else{
	                        layer.msg(returnCode, {icon: 5}); //操作失败
	                    }
	                }
	            })
            }
            //不通过审核
            else if(layEvent == 'refuse'){
            	data.status=3;
            	$.ajax({
	                url:'reserveBook.htm',
	                type:'post',
	                dataType:'json',
	                data:data,
	                success:function (result){
	                    var returnCode = result.returnCode;
	                    if(returnCode == 200){ 
	                        layer.msg("操作成功", {icon: 6});
                        	obj.update({ //更新表格数据行
                        		status:3
                           });
	                    }else{
	                        layer.msg(returnCode, {icon: 5}); //操作失败
	                    }
	                }
	            })
            }
        });
        
    });
</script>
<script>
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
  
  //日期
  laydate.render({
    elem: '#date'
  });
  laydate.render({
    elem: '#date1'
  });
  
  //创建一个编辑器
  var editIndex = layedit.build('LAY_demo_editor');
 
  //自定义验证规则
  form.verify({
    title: function(value){
      if(value.length < 5){
        return '标题至少得5个字符啊';
      }
    }
    ,pass: [
      /^[\S]{6,12}$/
      ,'密码必须6到12位，且不能出现空格'
    ]
    ,content: function(value){
      layedit.sync(editIndex);
    }
  });
  
	//监听性别操作
  form.on('switch(statusDemo)', function(obj){
    layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
  });
});
</script>
</html>
