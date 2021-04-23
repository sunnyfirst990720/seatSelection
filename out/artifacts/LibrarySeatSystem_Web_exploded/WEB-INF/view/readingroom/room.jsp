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
	<title>阅览室列表</title>
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
			<form id="roomForm" class="layui-form" action="" lay-filter="formTest" style="margin-top:20px">
			  <div class="layui-form-item layui-hide">
			    <label class="layui-form-label">ID</label>
			    <div class="layui-input-block">
			      <input type="text" name="id" lay-verify="" autocomplete="off" placeholder="ID" class="layui-input" readonly>
			    </div>
			  </div>
			  
			  <div class="layui-form-item" id="roomIdhide">
			    <label class="layui-form-label">名称</label>
			    <div class="layui-input-block">
			      <input type="text" name="name" lay-verify="required" autocomplete="off" placeholder="请输入阅览室名称" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			  	<label class="layui-form-label">类型</label>
			  	<div class="layui-input-block">
			  		<select id="typeSel" name="str" lay-verify="required" lay-filter="instituteSel">
						<option value="">--请选择阅览室类型--</option>
					</select>
			  	</div>
			  </div>
			  
			  <!-- <div class="layui-form-item" >
			    <label class="layui-form-label">开放时间</label>
			    <div class="layui-input-block">
			      <input type="text" id="opentime" name="opentime" lay-verify="required" autocomplete="off" placeholder="设置阅览室开放时间" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item" >
			    <label class="layui-form-label">关闭时间</label>
			    <div class="layui-input-block">
			      <input type="text" id="closetime" name="closetime" lay-verify="required" autocomplete="off" placeholder="设置阅览室关闭时间" class="layui-input">
			    </div>
			  </div> -->
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">行数</label>
			    <div class="layui-input-block">
			      <input type="number" name="row" lay-verify="number" autocomplete="off" placeholder="请设置阅览室行数" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">列数</label>
			    <div class="layui-input-block">
			      <input type="number" name="col" lay-verify="number" autocomplete="off" placeholder="请设置阅览室列数" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" lay-submit="" lay-filter="submit">立即提交</button>
			      <button type="reset" class="layui-btn layui-btn-danger" style="margin-left:180px">重置数据</button>
			    </div>
			  </div>
			</form>
    	</div>
    </div>
    <!--行工具样式-->
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
	
	<!-- 头工具栏样式 -->
	<script type="text/html" id="toolbarDemo">
	<div class="layui-form-item">
  		<div class="layui-btn-group layui-inline">
    		<button class="layui-btn layui-btn-sm" lay-event="add" title="添加"><i class="layui-icon"></i>添加阅览室</button>
    		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete" title="批量删除"><i class="layui-icon"></i>批量删除</button>
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
                    { type: 'checkbox', fixed: 'left' }, 
                    { field: 'id', title: 'ID', sort: true, hide:true },
                    { field: 'name', title: '名称', sort: true },
                    { field: 'typeid', title: '类型id', hide:true}, 
                    { field: 'typename', title: '类型'  }, 
                    /* { field: 'opentime', title: '开始时间'  },
                    { field: 'closetime', title: '关闭时间'  }, */
                    { field: 'row', title: '行数', }, 
                    { field: 'col', title: '列数' }, 
                    { field: 'total', title: '总座位数'},
                    { field: 'str', title: 'str', hide:true },
                    { fixed: 'right',title: '操作', width: 256, align: 'center', toolbar: '#barDemo' }
                ]
            ],
	        url: '${path }/room/roomList.htm',
	        method: 'post',
            done: function (res) {
                console.log(res);
                
                //添加表单下拉框选项
                $.ajax({
    				type : "post",
    				url : "${path }/type/comboList.htm",
    				data : {},
    				dataType : "json",
    				success : function(d) {
    					console.log(d);
    					var list=d;
    					 var tmp = '<option value="">--请选择阅览室类型--</option>';
    					 for ( var i in list) {
    						 tmp += '<option value="' + list[i].id +","+ list[i].name + '">' + list[i].name + '</option>';
    					}
    					 $("#typeSel").html(tmp);					
    					 form.render(); 
    				},
    				error:function(){
    					layer.alert('请求失败，稍后再试', {icon: 5});
    				}
    			});
            }
        });

        //监听头工具栏事件
        table.on('toolbar(test)', function(obj) {
            var checkStatus = table.checkStatus(obj.config.id),
            data = checkStatus.data; //获取选中行的数据
            switch(obj.event) {
                case 'add': //添加一行数据
                    document.getElementById("roomForm").reset(); //清空表单数据
                    layer.open({ //显示表单
	                    type: 1,
	                    title: "添加阅览室",
	                    area: ['600px', '420px'],
	                    content: $('#popUpdateTest')//引用的弹出层的页面层的方式加载修改界面表单
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
				                url:'deleteRoom.htm',
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
            if(layEvent === 'del') {
                layer.confirm('确定删除吗？', function(index) {
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
		                url:'deleteRoom.htm',
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
                    title: "修改阅览室信息",
                    area: ['600px', '420px'],
                    content: $('#popUpdateTest')
                });
                form.val("formTest", data)
                setFormValue(obj);
            }
        });
        //修改添加表单的提交操作
        function setFormValue(obj){
	        form.on('submit(submit)', function(massage) {
	        	//修改传回表格的信息
	            var row = massage.field.row;
	            var col = massage.field.col;
	            massage.field.total=row * col;
	            arr=massage.field.str.split(",");
	            massage.field.typeid=arr[0];
	            massage.field.typename=arr[1];
	            
	            $.ajax({
	                url:'reserveRoom.htm',
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
  //时间选择器
  laydate.render({
    elem: '#opentime',
    type: 'time'
  });
  laydate.render({
    elem: '#closetime',
    type: 'time'
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
  
});
</script>
</html>
