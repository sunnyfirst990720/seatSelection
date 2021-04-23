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
	<title>信用积分列表</title>
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
    <div class="layui-row" id="detaildiv" style="display:none;">
    	<div class="layui-col-md10">
			<table class="layui-hide" id="detail" lay-filter="detail"></table>
    	</div>
    </div>
    
    <!--添加扣分记录表单  -->
    <div class="layui-row" id="addillegal" style="display:none;">
    	<div class="layui-col-md10">
			<form id="illegalForm" class="layui-form" action="" lay-filter="illegalForm" style="margin-top:20px">
			  
			  <div class="layui-form-item layui-hide">
			    <label class="layui-form-label">ID</label>
			    <div class="layui-input-block">
			      <input type="text" name="id" lay-verify="" autocomplete="off" placeholder="" class="layui-input" readonly>
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">学号</label>
			    <div class="layui-input-block">
			      <input type="text" name="studentno" lay-verify="required" autocomplete="off" placeholder="请输入学号" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">时间</label>
			    <div class="layui-input-block">
			      <input type="text" name="time" id="date" lay-verify="required" autocomplete="off" placeholder="yyyy-MM-dd HH:mm:ss" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">扣分</label>
			    <div class="layui-input-block">
			      <input type="number" name="score" lay-verify="number" autocomplete="off" placeholder="请输入分数" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">备注</label>
			    <div class="layui-input-block">
			      <input type="text" name="remarks" lay-verify="" autocomplete="off" placeholder="请输入备注" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" lay-submit="" lay-filter="illegalsubmit">提交</button>
			    </div>
			  </div>
			</form>
    	</div>
    </div>
    
    <!--行工具样式-->
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除记录</a>
    </script>
	
	<!--详情页面工具栏  -->
	<script type="text/html" id="barDetail">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
	
	<!-- 头工具栏样式 -->
	<script type="text/html" id="toolbarDemo">
	<div class="layui-form-item">
  		<div class="layui-inline">
			<label class="layui-form-label">姓名</label>
			<div class="layui-input-inline">
    			<input type="text" id="s_studentName" name="s_studentName" lay-verify="" placeholder="请输入姓名" autocomplete="off" class="layui-input">
			</div>
		</div>
		
		<div class="layui-inline">
			<label class="layui-form-label">学号</label>
			<div class="layui-input-inline">
    			<input type="text" id="s_studentNo" name="s_studentNo" lay-verify="" placeholder="请输入学号" autocomplete="off" class="layui-input">
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
		var index;
		var selectrow;
		var selectdetail;
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
                    { field: 'studentno', title: '学号', sort: true }, 
                    { field: 'studentname', title: '姓名' }, 
                    { field: 'total', title: '积分'}, 
                    { fixed: 'right',title: '操作', width: 256, align: 'center', toolbar: '#barDemo' }
                ]
            ],
	        url: '${path }/score/scoreList.htm',
	        method: 'post',
            done: function (res) {
                console.log(res);
            }
        });
		
      //监听详情表单 头 工具栏事件
        table.on('toolbar(detail)', function(obj) {
            var checkStatus = table.checkStatus(obj.config.id),
            data = checkStatus.data; //获取选中的数据
            switch(obj.event) {
                case 'add':
                	document.getElementById("illegalForm").reset(); //清空表单数据
                	index=layer.open({
                        type: 1,
                        title: "添加积分记录",
                        area: ['520px', '340px'],
                        content: $('#addillegal')
                    });
                	setIllegalFormValue(obj);
                    break;
                case 'delete':
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
			                $.ajax({
				                url:'${path }/illegal/deleteIllegal.htm',
				                type:'post',
				                dataType:'json',
				                data:{ids:ids},
				                success:function (result){
				                    var returnCode = result.returnCode;
				                    if(returnCode == 200){
				                        layer.msg("已成功删除"+result.delNums+"条数据！", {icon: 6});
				                        table.reload('detail');
				                      //初始表格更新选中行
				                        var selectdata = selectrow.data;
				                        var tem = 0;
				                        layui.each(data,function(k,v){
						                    tem += v.score;
						                });
				                        selectrow.update({
				                        	total:selectdata.total+tem
				                        });
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
      	
      //监听详情表单 行 工具栏事件 
        table.on('tool(detail)', function(obj) { 
            var data = obj.data ,//获得当前行数据
                layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'del') {
                layer.confirm('确定删除吗？', function(index) {
                	
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
		                url:'${path }/illegal/deleteIllegal.htm',
		                type:'post',
		                dataType:'json',
		                data:{ids:data.id},
		                success:function (result){
		                    var returnCode = result.returnCode;
		                    if(returnCode == 200){
		                    	obj.del(); //删除对应行结构
		                        layer.msg("已成功删除!", {icon: 6});
		                      //初始表格更新选中行
		                        var selectdata = selectrow.data;
		                        var tem = data.score;
		                        selectrow.update({
		                        	total:selectdata.total+tem
		                        });
		                    }else{
		                        layer.msg(returnCode, {icon: 5});
		                    }
		                }
		            })
                });
            }
            //编辑
            else if(layEvent === 'edit') {
                index=layer.open({
                    type: 1,
                    title: "修改记录信息",
                    area: ['520px', '340px'],
                    content: $('#addillegal')
                });
                form.val("illegalForm", data)
                setIllegalFormValue(obj);
                selectdetail=obj;
            }
        });
      	
        //监听头工具栏事件
        table.on('toolbar(test)', function(obj) {
            var checkStatus = table.checkStatus(obj.config.id),
            data = checkStatus.data; //获取选中行的数据
            switch(obj.event) {
                case 'search': //搜索
               		var index = layer.msg('查询中，请稍候...',{icon: 16,time:false,shade:0});
                    setTimeout(function(){
                        table.reload('demo', { //表格的id
                            url:'scoreList.htm',
                            where: {
                                'studentname':$('#s_studentName').val(),
                                'studentno':$('#s_studentNo').val()
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
            	table.render({
                    elem: '#detail',
                    width:'800',
                    height: '520',
                    title: '积分详情',
                    page: true, //开启分页
                    toolbar: 'default' ,//开启工具栏，此处显示默认图标，可以自定义模板，详见文档,
                    limits:[10,20,30,40],
                    limit:10,
                    cols: [//表头
                        [ 
                            { type: 'checkbox', fixed: 'left' },
                            { field: 'id',width:100, title: 'id', sort: true,hide:true },
                            { field: 'studentno',width:100, title: '学号', sort: true }, 
                            { field: 'studentname',width:80, title: '姓名' }, 
                            { field: 'time',width:170, title: '时间'}, 
                            { field: 'score',width:60, title: '积分'},
                            { field: 'remarks', title: '违章'},
                            { fixed: 'right',title: '操作', width:140, align: 'center', toolbar: '#barDetail' }
                        ]
                    ],
        	        url: '${path}/illegal/illegalList.htm?studentno='+data.studentno,
        	        method: 'post',
                    done: function (res) {
                        console.log(res);
                    }
                });
            	layer.open({
                    type: 1,
                    title: "积分详情",
                    area: ['800px', '600px'],
                    content: $('#detaildiv')
                });
            	selectrow=obj;
            }
            //删除此行
            else if(layEvent === 'del') {
                layer.confirm('确定删除吗？', function(index) {
                	
                    obj.del(); //删除对应行结构
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
		                url:'${path}/score/deleteScore.htm',
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
            //编辑
            else if(layEvent === 'edit') {
            	//显示编辑项
            	document.getElementById("roleIdhide").style.display='';
                document.getElementById("scoreIdhide").style.display='';
                layer.open({
                    type: 1,
                    title: "修改用户信息",
                    area: ['600px', '480px'],
                    content: $('#popUpdateTest')
                });
                form.val("formTest", data)
                setFormValue(obj);
            }
        });
        //修改添加表单的提交操作
        function setFormValue(obj){
        
	        form.on('submit(submit)', function(massage) {
	        	var rolename=massage.field.roleName;
                switch (rolename) 
                { 
                  case "超级管理员":massage.field.roleId=1; 
                  break; 
                  case "教师":massage.field.roleId=2; 
                  break; 
                  case "学生":massage.field.roleId=3; 
                  break; 
                }
	            $.ajax({
	                url:'reserveScore.htm',
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
	                        		roleId:massage.field.roleId,
	                           		scoreName:massage.field.scoreName,
	                           		password:massage.field.password,
	                           		roleName:massage.field.roleName,
	                           		scoreDescription:massage.field.scoreDescription,
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
        function setIllegalFormValue(obj){
            
	        form.on('submit(illegalsubmit)', function(massage) {
	            $.ajax({
	                url:'${path}/illegal/reserveIllegal.htm',
	                type:'post',
	                dataType:'json',
	                data:massage.field,
	                success:function (result){
	                    var returnCode = result.returnCode;
	                    if(returnCode == 200){ //修改成功
	                        layer.msg("修改成功", {icon: 6});
	                        setTimeout(function(){
	                        	obj.update(massage.field);
	                        	layer.close(index);
	                        }, 1000);
	                      //初始表格更新选中行
	                        var datadetail = selectdetail.data;
	                        var data = selectrow.data;
	                        var newscore = massage.field.score;
	                        var oldscore = datadetail.score;
	                        var tem = newscore - oldscore;
	                        selectrow.update({
	                        	total:data.total-tem
	                        });
	                        
	                    }else if(returnCode == 300){ //添加成功
	                        layer.msg("添加成功", {icon: 6});
	                        setTimeout(function(){
	                        	table.reload('detail', {
                        		  page: {
                        		    curr: 1 //重新从第 1 页开始
                        		  }
                        		});
	                           	layer.close(index);
	                        }, 1000);
	                        //初始表格更新选中行
	                        var data = selectrow.data;
	                        //layer.alert(JSON.stringify(data));
	                        var tem = massage.field.score;
	                        selectrow.update({
	                        	total:data.total-tem
	                        });
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
  
  
  //日期时间选择器
  laydate.render({
    elem: '#date'
    ,type: 'datetime'
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
