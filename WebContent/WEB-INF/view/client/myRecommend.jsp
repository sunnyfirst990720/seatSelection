<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	//设定context path
	String path = request.getContextPath();
	if("/".equals(path.trim())) path = "";
	pageContext.setAttribute("path",path);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>我的推荐</title> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- Custom Theme files -->
<link href="${path }/css/bootstrap.css" type="text/css" rel="stylesheet" media="all">
<link href="${path }/css/style.css" type="text/css" rel="stylesheet" media="all">
<link href="${path }/css/font-awesome.css" rel="stylesheet">  <!-- font-awesome icons --> 
<!-- //Custom Theme files -->
<!--layui-->
<link rel="stylesheet" href="${path }/layui/css/layui.css" media="all">
<script type="text/javascript" src="${path }/layui/layui.js" charset="utf-8"></script>
<!--//layui-->
<!-- js -->
<script src="${path }/js/jquery-2.2.3.min.js"></script>   
<!-- //js -->
<!-- web-fonts -->
<link href="http://fonts.googleapis.com/css?family=Roboto+Condensed:300,300i,400,400i,700,700i" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<!-- //web-fonts --> 
</head>
<body>
	<!-- header -->
	<div class="header">
		<nav class="navbar navbar-default">
			<div class="container" style="width: 72%;">
				<div class="navbar-header navbar-left wthree">
					<h1><a href="${path }/link/index.htm">Library<span>Seat Reservation</span></a></h1>
				</div>
				
				<div class="header-right wthree">
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse navbar-right" id="bs-example-navbar-collapse-1">					
						<ul class="nav navbar-nav navbar-left cl-effect-14" style="margin-top: 30px;">
							<li><a href="${path }/link/index.htm" class="active">自习室主页</a></li>
							<!--<li><a href="index.html">本馆简介</a></li>-->
							<li><a href="${path }/link/openTime.htm">开放时间</a></li>
							<li><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">座位管理 <span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li><a href="${path }/link/seatsRule.htm">座位管理规则</a></li>
									<li><a href="${path }/link/selectSeat.htm">预约座位</a></li>
									<li><a href="${path }/link/mySeat.htm">我的座位</a></li>
									<%-- <li><a href="${path }/link/codes.htm">常用座位</a></li> --%>
								</ul>
							</li>
							<li><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">个人中心 <span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li><a href="javascript:changePass();">修改密码</a></li>
									<li><a href="${path }/link/myInfo.htm">个人信息</a></li>
									<%-- <li><a href="${path }/link/myRecommend.htm">我的推荐</a></li> --%>
								</ul>
							</li> 
							<li><a href="${path }/link/recommend.htm">读者推荐</a></li>
							<li><a href="${path }/link/contact.htm">联系我们</a></li>			
						</ul>
						<a id="updataImg" style="cursor:pointer"><img id="headPortrait" alt="image" class="img-circle" src="${currentUser.headPortrait }" height="100" width="100" style="margin-top: 10px;"/></a>
						<!-- <button id="loginButton" class="layui-btn layui-btn-lg layui-btn-radius layui-btn-normal" onclick="login()" style="margin-top: 8px;margin-left: 20px;">用户登录</button> -->
						<button class="layui-btn layui-btn-lg layui-btn-radius layui-btn-normal"style="margin-left:10px;margin-top:10px" onclick="javascrtpt:window.location.href='${path }/logout.htm'">退出登录</button>
						<div class="clearfix"> </div>
					</div><!-- //navigation -->
				</div>
				<div class="clearfix"> </div>
			</div>	
		</nav>		
	</div>	
	<!-- //header -->
	<!-- banner -->
	<div class="banner-1">
	</div> 
	<!-- //banner -->
	<!-- contact -->
	<div class="w3_wthree_agileits_icons main-grid-border">
		<div class="container">
			<div class="w3ls-title"> 
				<h3 class="agileits-title w3title1">我的推荐</h3>
			</div>
			<div class="about-w3ls-row"> 
				<table class="layui-hide" id="demo" lay-filter="test"></table>  
				<div class="clearfix"> </div> 
			</div>
			
		</div>	
	</div>
	<!-- //contact -->
	<!-- footer -->
	<div class="footer-w3copy w3-agileits">
		<p>Copyright &copy; 2021.SunHaoYi</p>
	</div>
	<!-- //footer -->    
	
	<!--弹出框  修改密码 -->
    <div class="layui-row" id="popUpdatePass" style="display:none;">
    	<div class="layui-col-md10">
			<form id="passForm" class="layui-form" action="" lay-filter="formTest" style="margin-top:20px">
			  
			  <div class="layui-form-item layui-hide">
			    <label class="layui-form-label">用户ID</label>
			    <div class="layui-input-block">
			      <input type="text" name="userId" value="${currentUser.userId }" lay-verify="" autocomplete="off" placeholder="请输入用户ID" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">旧密码</label>
			    <div class="layui-input-block">
			      <input type="password" name="oldpassword" lay-verify="pass" autocomplete="off" placeholder="请输入旧密码" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">新密码</label>
			    <div class="layui-input-block">
			      <input type="password" name="newpassword" lay-verify="pass" autocomplete="off" placeholder="请输入新密码" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn layui-btn-lg layui-btn-radius layui-btn-normal" lay-submit="" lay-filter="submitPass">立即提交</button>
			    </div>
			  </div>
			</form>
    	</div>
    </div>
	 <!--//弹出框  修改密码-->
    
    <!--行工具样式-->
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
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
			<button class="layui-btn layui-btn-sm" lay-event="search" title="搜索"><i class="layui-icon layui-icon-search"/>搜索</button>
		</div>
	</div>
	</script>
	
	<!--表单样式 初始隐藏 -->
    <div class="layui-row" id="popUpdateTest" style="display:none;">
    	<div class="layui-col-md10">
			<form id="userForm" class="layui-form" action="" lay-filter="formTest" style="margin-top:20px">
			  <div class="layui-form-item">
			    <label class="layui-form-label">图片</label>
			    <div class="layui-input-block">
			      <img alt="封面图片" src="" id="img_id" height="200" width="140" align="middle">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">名称</label>
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
			      <textarea name="remarks" placeholder="" class="layui-textarea" readonly style="height:200px"></textarea>
			    </div>
			  </div>
			  
			</form>
    	</div>
    </div>
	
    <script src="${path }/js/bootstrap.js"></script>
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
            height: 'full',
            title: '书籍表',
            page: true, //开启分页
            toolbar: '#toolbarDemo' ,//开启工具栏，此处显示默认图标，可以自定义模板，详见文档,
            initSort: {
              field: 'lentime' //排序字段，对应 cols 设定的各字段名
              ,type: 'desc' //排序方式  asc: 升序、desc: 降序、null: 默认排序
            },
            limits:[10,20,30,40],
            limit:40,
            cols: [//表头
                [ 
                	{ field: 'number', title: '排名',width:60,fixed:'left',type:'numbers'},
                    { field: 'id', title: '资料id', sort: true, hide:true },
                    { field: 'cover', title: '书籍封面',hide:true },
                    { field: 'name', title: '题名', sort: true,width:200}, 
                    { field: 'author', title: '作者' }, 
                    { field: 'publish', title: '出版信息', sort: true }, 
                    { field: 'findnumber', title: '索书号',width:128 },
                    { field: 'lentime', title: '推荐次数',width:128, sort: true},
                    { field: 'remarks', title: '简介',hide:true },
                    { fixed: 'right',title: '其他操作', width: 128, align: 'center', toolbar: '#barDemo' }
                ]
            ],
	        url: '${path }/book/bookList.htm',
	        //data:{'studentno':document.getElementById("studentNo").value},
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
                            url:'${path }/book/bookList.htm',
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
	                url:'reserveUser.htm',
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
<!--修改密码js  -->
<script>
function changePass(){
	document.getElementById("passForm").reset(); //清空表单数据
	layer.open({ //显示表单
        type: 1,
        title: "修改密码",
        area: ['380px', '240px'],
        content: $('#popUpdatePass')//引用的弹出层的页面层的方式加载修改界面表单
    });
};
layui.use(['form','upload','layer'], function(){
  var upload = layui.upload
  , form = layui.form
  , layer = layui.layer;
 
//上传头像
  var uploadInst = upload.render({
    elem: '#updataImg'
    ,url: '${path}/user/updataPortrait.htm' //上传接口
    ,data:{userId:"${currentUser.userId }"}
    ,done: function(res){
    	if(res.code == 0){
    		$('#headPortrait').attr('src',res.src);
    		layer.msg("修改成功", {icon: 6});
    	}
    }
    ,error: function(){
      alert("上传失败");
    }
  });
  form.on('submit(submitPass)', function(massage) {
  		$.ajax({
            url:'http://localhost:8086/LibrarySeatSystem/updatePassword.htm',
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
                       layer.closeAll();//关闭所有的弹出层
                    }, 1000);
                }else{
                    layer.msg(returnCode, {icon: 5}); //操作失败
                }
            }
        })
        return false;
  }) 
});
</script>
</body>
</html>