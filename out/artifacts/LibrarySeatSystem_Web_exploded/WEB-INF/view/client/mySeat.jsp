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
<title>我的座位</title> 
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
				<h3 class="agileits-title w3title1">我的座位</h3>
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
    
    
    <!--格式转换  -->
	<script type="text/html" id="statusTpl">
  		{{#  if(d.status === 1){ }}
    		<span style="color: #3366FF;">预约成功，待签到</span>
		{{#  } else if(d.status === 2){ }}
    		<span style="color: #3366FF;">已签到，正常使用中</span>
  		{{#  } else { }}
    		<span style="color: #660000;">暂时离开</span>
  		{{#  } }}
	</script>
    
    <!--行工具样式-->
    <script type="text/html" id="barDemo">
		<a class="layui-btn layui-btn-xs" lay-event="sign">签到</a>
        <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="leave">暂离</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="cancel">退座</a>
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
            title: '座位表',
           // page: true, //开启分页
            //toolbar: '#toolbarDemo' ,//开启工具栏，此处显示默认图标，可以自定义模板，详见文档,
            initSort: {
              field: 'lentime' //排序字段，对应 cols 设定的各字段名
              ,type: 'desc' //排序方式  asc: 升序、desc: 降序、null: 默认排序
            },
            limits:[10,20,30,40],
            limit:40,
            cols: [//表头
                [ 
                	{ field: 'number', title: '序号',width:60,fixed:'left',type:'numbers'},
                    { field: 'id', title: '座位id', sort: true, hide:true },
                    { field: 'roomid', title: '阅览室id',hide:true },
                    { field: 'roomname', title: '阅览室', sort: true,width:128}, 
                    { field: 'date', title: '日期' },
                    { field: 'time', title: '时间段' },
                    { field: 'studentno', title: '学号',hide:true}, 
                    { field: 'row', title: '行' ,width:80}, 
                    { field: 'col', title: '列' ,width:80},
                    { field: 'status', title: '状态', templet: '#statusTpl' },
                    { field: 'keyword', title: '关键字',hide:true },
                    { fixed: 'right',title: '操作', width: 232, align: 'center', toolbar: '#barDemo' }
                ]
            ],
	        url: '${path }/seat/mySeat.htm',
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
            //签到
            if(layEvent === 'sign') {
            	data.status=2;
            	$.ajax({
	                url:'${path }/seat/reserveSeat.htm',
	                type:'post',
	                dataType:'json',
	                data:data,
	                success:function (result){
	                    var returnCode = result.returnCode;
	                    if(returnCode == 200){
	                    	obj.update(data);//更新状态
	                        layer.msg("签到成功!", {icon: 6});
	                    }else{
	                        layer.msg(returnCode, {icon: 5});
	                    }
	                }
	            })
            }else if(layEvent === 'leave'){ //暂离
            	if(data.status==1){
            		layer.msg("请先签到！", {icon: 5});
            	}else if(data.status==3){
            		layer.msg("您已处于暂离状态，请勿重复设置！", {icon: 5});
            	}else{
            		data.status=3;
                	$.ajax({
    	                url:'${path }/seat/reserveSeat.htm',
    	                type:'post',
    	                dataType:'json',
    	                data:data,
    	                success:function (result){
    	                    var returnCode = result.returnCode;
    	                    if(returnCode == 200){
    	                    	obj.update(data);//更新状态
    	                        layer.msg("已设置暂离，回来后别忘记再次签到哦!", {icon: 6});
    	                    }else{
    	                        layer.msg(returnCode, {icon: 5});
    	                    }
    	                }
    	            })
            	}
            }else if(layEvent === 'cancel'){ //退座
            	$.ajax({
	                url:'${path }/seat/cancelSeat.htm',
	                type:'post',
	                dataType:'json',
	                data:{seatkeyword:data.keyword},
	                success:function (result){
	                    var returnCode = result.returnCode;
	                    if(returnCode == 200){
	                    	obj.del(); //删除对应行结构
	                        layer.msg("退座成功!", {icon: 6});
	                    }else{
	                        layer.msg(returnCode, {icon: 5});
	                    }
	                }
	            })
            }
            
        });
        
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