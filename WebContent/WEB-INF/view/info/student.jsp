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
	<title>学生列表</title>
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
			<form id="studentForm" class="layui-form" action="" lay-filter="formTest" style="margin-top:20px">
			  <div class="layui-form-item layui-hide">
			    <label class="layui-form-label">ID</label>
			    <div class="layui-input-block">
			      <input type="text" name="id" lay-verify="" autocomplete="off" placeholder="自动生成，无需填写！" class="layui-input" readonly>
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">学号</label>
			    <div class="layui-input-block">
			      <input type="text" name="no" lay-verify="required" autocomplete="off" placeholder="请输入学号" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">姓名</label>
			    <div class="layui-input-block">
			      <input type="text" name="name" lay-verify="required" autocomplete="off" placeholder="请输入姓名" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">性别</label>
			    <div class="layui-input-block">
			      <input type="radio" name="sex" value="男" title="男" checked="">
			      <input type="radio" name="sex" value="女" title="女">
			    </div>
			  </div>
			  
			  <div class="layui-form-item layui-hide">
			    <label class="layui-form-label">班级id</label>
			    <div class="layui-input-block">
			      <input type="text" name="clazzid" lay-verify="required" autocomplete="off" placeholder="请输入班级" class="layui-input" id="classid" readonly>
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">班级</label>
			    <div class="layui-input-block">
			      <input type="text" name="clazzname" lay-verify="required" autocomplete="off" placeholder="请输入班级" class="layui-input" id="classname" readonly>
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">出生日期</label>
			    <div class="layui-input-block">
			      <input type="text" name="birth" id="date" lay-verify="date" autocomplete="off" placeholder="yyyy-mm-dd" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">电话</label>
			    <div class="layui-input-block">
			      <input type="text" name="phone" lay-verify="required|phone" autocomplete="off" placeholder="请输入电话" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">邮箱</label>
			    <div class="layui-input-block">
			      <input type="text" name="mail" lay-verify="email" autocomplete="off" placeholder="请输入邮箱" class="layui-input">
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
    
    <!--选择班级表单-->
    <div class="layui-row" id="selectClass" style="display:none;">
    	<div class="layui-col-md10">
			<form id="classForm" class="layui-form" action="" style="margin-top:20px">
			  
			  <div class="layui-form-item">
			  	<label class="layui-form-label">学院</label>
			  	<div class="layui-input-block">
			  		<select id="instituteSel" name="instituteId" lay-filter="instituteSel">
						<option value="">--请选择学院--</option>
					</select>
			  	</div>
			  </div>
			  
			  <div class="layui-form-item">
			  	<label class="layui-form-label">专业</label>
			  	<div class="layui-input-block">
			  		<select id="specialtySel" name="specialtyId" lay-filter="specialtySel" >
						<option value="">--请选择专业--</option>
					</select>
			  	</div>
			  </div>
			  
			  <div class="layui-form-item">
			  	<label class="layui-form-label">班级</label>
			  	<div class="layui-input-block">
			  		<select id="classSel" name="classes" lay-filter="classSel" >
						<option value="">--请选择班级--</option>
					</select>
			  	</div>
			  </div>
			  
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" lay-submit="" lay-filter="selectclass">选定</button>
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
    		<button class="layui-btn layui-btn-sm" lay-event="add" title="添加"><i class="layui-icon"></i>添加学生</button>
    		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete" title="批量删除"><i class="layui-icon"></i>批量删除</button>
  		</div>
		
		<div class="layui-inline">
			<div class="layui-input-inline">
    			<input type="text" id="s_studentNo" name="s_studentNo" lay-verify="" placeholder="请输入学号" autocomplete="off" class="layui-input">
			</div>
		</div>		

  		<div class="layui-inline">
			<div class="layui-input-inline">
    			<input type="text" id="s_studentName" name="s_studentName" lay-verify="" placeholder="请输入学生姓名" autocomplete="off" class="layui-input">
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
                    { type: 'checkbox', fixed: 'left' }, 
                    { field: 'id', title: 'ID', sort: true, hide:true },
                    { field: 'no', title: '学号', sort: true }, 
                    { field: 'name', title: '姓名' }, 
                    { field: 'sex', title: '性别', sort: true }, 
                    { field: 'clazzid', title: '班级id', hide:true },
                    { field: 'clazzname', title: '班级'}, 
                    { field: 'birth', title: '生日'}, 
                    { field: 'phone', title: '电话'},
                    { field: 'mail', title: '邮箱'},
                    { fixed: 'right',title: '操作', width: 256, align: 'center', toolbar: '#barDemo' }
                ]
            ],
	        url: '${path }/student/studentList.htm',
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
                    document.getElementById("studentForm").reset(); //清空表单数据
                    layer.open({ //显示表单
	                    type: 1,
	                    title: "添加学生",
	                    area: ['620px', '520px'],
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
			                var nos = '';
			                layui.each(data,function(k,v){
			                    ids += v.id+',';
			                    nos += v.no+',';
			                });
			                $.ajax({
				                url:'deleteStudent.htm',
				                type:'post',
				                dataType:'json',
				                data:{ids:ids,nos:nos},
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
                case 'search': //搜索
               		var index = layer.msg('查询中，请稍候...',{icon: 16,time:false,shade:0});
                    setTimeout(function(){
                        table.reload('demo', { //表格的id
                            url:'studentList.htm',
                            where: {
                                'name':$('#s_studentName').val(),
                                'no':$('#s_studentNo').val()
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
            	layer.alert(JSON.stringify(data));
            }
            //删除此行
            else if(layEvent === 'del') {
                layer.confirm('确定删除吗？', function(index) {
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
		                url:'deleteStudent.htm',
		                type:'post',
		                dataType:'json',
		                data:{ids:data.id,nos:data.no},
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
                    title: "修改学生信息",
                    area: ['620px', '560px'],
                    content: $('#popUpdateTest')
                });
                form.val("formTest", data)
                setFormValue(obj);
            }
        });
        //修改添加表单的提交操作
        function setFormValue(obj){
        	//选择班级表单的提交
        	form.on('submit(selectclass)', function(massage) {
        		console.log(massage.field.classes);
        		arr=massage.field.classes.split(",");
        		document.getElementById("classid").value=arr[0];
        		document.getElementById("classname").value=arr[1];
        		layer.close(layer.index);
        		return false;
        	});
        	//修改或添加学生表单的提交
	        form.on('submit(submit)', function(massage) {
	            $.ajax({
	                url:'reserveStudent.htm',
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
	                        	obj.update({ //更新表格数据行
	                        		id:massage.field.id,
	                        		no:massage.field.no,
	                        		name:massage.field.name,
	                           		phone:massage.field.phone,
	                           		sex:massage.field.sex,
	                           		birth:massage.field.birth,
	                           		mail:massage.field.mail,
	                           		clazzid:massage.field.clazzid,
	                           		clazzname:massage.field.clazzname
	                           });
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
        //点击班级弹出选择班级表单
        $(document).on('click','#classname',function(){
        	document.getElementById("classForm").reset();
    		$.ajax({
				type : "post",
				url : "${path }/classes/instituteList.htm",
				data : {},
				dataType : "json",
				success : function(d) {
					var list=d.institutelist;
					 var tmp = '<option value="">--请选择学院--</option>';
					 for ( var i in list) {
						 tmp += '<option value="' + list[i].instituteId +  '">' + list[i].instituteName + '</option>';
					}
					 $("#instituteSel").html(tmp);					
					 form.render(); 
				},
				error:function(){
					layer.alert('请求失败，稍后再试', {icon: 5});
				}
			});
		       	layer.open({
	            type: 1,
	            title: "选择班级",
	            area: ['580px', '320px'],
	            content: $('#selectClass')
	        });
    	});
        //选择学院加载专业下拉框
        form.on('select(instituteSel)', function(data) {
			var instituteId = data.value;
			$.ajax({
				type : "post",
				url : "${path }/classes/specialtyList.htm",
				data : {instituteId:instituteId},
				dataType : "json",
				success : function(d) {
					var list=d.specialtylist;
					var temp='<option value="">--请选择班级--</option>';
					$("#classSel").html(temp);
				 	var tmp = '<option value="">--请选择专业--</option>';
			 		for ( var i in list) {
				 		tmp += '<option value="' + list[i].specialtyId +  '">' + list[i].specialtyName + '</option>';
					}
				 	$("#specialtySel").html(tmp);					
				 	form.render(); 
				},
				error:function(){
					layer.alert('请求失败，稍后再试', {icon: 5});
				} 
			});
		});
        //选择专业加载班级下拉框
        form.on('select(specialtySel)', function(data) {
			var specialtyId = data.value;
			$.ajax({
				type : "post",
				url : "${path }/classes/classesSelect.htm",
				data : {specialtyId:specialtyId},
				dataType : "json",
				success : function(d) {
					console.log(d);
					var list=d.classlist;
				 	var tmp = '<option value="">--请选择班级--</option>';
			 		for ( var i in list) {
				 		tmp += '<option value="' + list[i].id + "," + list[i].name + '">' + list[i].name + '</option>';
					}
				 	$("#classSel").html(tmp);					
				 	form.render(); 
				},
				error:function(){
					layer.alert('请求失败，稍后再试', {icon: 5});
				} 
			});
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
