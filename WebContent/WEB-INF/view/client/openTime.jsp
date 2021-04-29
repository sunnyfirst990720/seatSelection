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
<title>开放时间</title> 
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
					<h1><a href="${path }/link/index.htm">StudyRoom<span>Seat Reservation</span></a></h1>
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
							<li><a href="${path }/link/recommend.htm">聊天墙</a></li>
							<li><a href="${path }/link/contact.htm">问题反馈</a></li>
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
	<!--开放时间  -->
	<div class="about">
		<div class="container">  
			<div class="w3ls-title">
				<h3 class="agileits-title">开放时间</h3> 
			</div> 
			<div class="about-w3ls-row"> 
				<div class="layui-form">
				  <table class="layui-table">
				    <colgroup>
				      <col width="150">
				      <col width="150">
				      <col width="200">
				    </colgroup>
				    
				    <tbody>
				      <tr>
				        <td>入口处</td>
				        <td>7:00 - 23:00</td>
				        <td></td>
				      </tr>
				    </tbody>
				  </table>
				  
				  <table class="layui-table">
				    <colgroup>
				      <col width="150">
				      <col width="150">
				      <col width="200">
				    </colgroup>
				    
				    <tbody>
				      <tr>
				        <td>办公室</td>
				        <td>5月1日-10月31日 上午8：00-12：00

							<br>下午14：30-17：30
							
							<br>11月1日-（次年）4月30日 上午8：00-12：00
							
							<br>下午14：00-17：00</td>
				        <td>周一至周五14：30

							<br>办理违纪相关事宜</td>
				      </tr>
				      <tr>
				        <td>复印处（一楼大厅）</td>
				        <td>5月1日-10月31日 上午8：00-12：00

							<br>下午14：30-22：00
							
							<br>11月1日-(次年)4月30日 上午8：00-12：00
							
							<br>下午14：00-21：30</td>
				        <td>周一至周日</td>
				      </tr>
				    </tbody>
				  </table>
				  
				  <table class="layui-table">
				    <colgroup>
				      <col width="150">
				      <col width="150">
				      <col width="200">
				    </colgroup>
				    
				    <tbody>
				      <tr>
				        <td>一号自习室（201）</td>
				        <td>8:00-22:00</td>
				        <td>周一至周日</td>
				      </tr>
				      <tr>
				        <td>二号自习室（202）</td>
				        <td>5月1日-10月31日 上午8：00-12：00

							<br>下午14：30-22：00
							
							<br>11月1日-(次年)4月30日 上午8：00-12：00
							
							<br>下午14：00-21：30</td>
				        <td>周一至周日</td>
				      </tr>
				      <tr>
				        <td>三号自习室

							<br>（西区203）</td>
				        <td>5月1日-10月31日 上午8：00-12：00

							<br>下午14：30-22：00
							
							<br>11月1日-(次年)4月30日 上午8：00-12：00
							
							<br>下午14：00-21：30</td>
				        <td>周一至周五白天

							<br>闭架开放</td>
				      </tr>
				      <tr>
				        <td>二楼中厅</td>
				        <td>7:00-22:00</td>
				        <td>周一至周日</td>
				      </tr>
				      <tr>
				        <td>四号自习室（301）</td>
				        <td>5月1日-10月31日 上午8：00-12：00

							<br>下午14：30-22：00
							
							<br>11月1日-(次年)4月30日 上午8：00-12：00
							
							<br>下午14：00-21：30</td>
				        <td>周一至周日</td>
				      </tr>
				    </tbody>
				  </table>
				  
				  <table class="layui-table">
				    <colgroup>
				      <col width="150">
				      <col width="150">
				      <col width="200">
				    </colgroup>
				    
				    <tbody>
				      <tr>
				        <td>电子阅览室（601）</td>
				        <td>5月1日-10月31日，上午8:00-12:00 下午 14:30-21:45

							<br>11月1日-次年4月30日 上午8:00-12:00 下午14:00-22:00</td>
				        <td>周一至周日</td>
				      </tr>
				      <tr>
				        <td>自修室（602）</td>
				        <td>8：00-22:00</td>
				        <td>周一至周日</td>
				      </tr>
				    </tbody>
				  </table>
				  
				  <table class="layui-table">
				    <colgroup>
				      <col width="150">
				      <col width="150">
				      <col width="200">
				    </colgroup>
				    
				    <tbody>
				      <tr>
				        <td>办公室及其他部室</td>
				        <td>5月1日-10月31日 上午8：00-12：00 下午14：30-17：30

							<br>11月1日-（次年）4月30日 上午8：00-12：00 下午14：00-17：00</td>
				        <td>周六、周日

							<br>休息</td>
				      </tr>
				    </tbody>
				  </table>
				  
				</div>
							
				<div class="clearfix"> </div> 
			</div>
			周三上午8：00—9：30组织业务学习
			<br>
			<br>说明：
			<br>
			<br>1、各自习室在关闭前需10-15分钟整理时间。
			<br>2、开放时间内遇有临时停电时安排规则参见临时停电闭馆规定。
			<br>3、寒暑假、法定公众假日开放的安排规则参见图书馆放假工作安排。
			<br>4、寒暑假、法定公众假日及其它非正常情况下具体开放时间请留意图书馆开闭馆最新通知。
			<br>5、咨询电话：13864192336
		</div>
	</div>		
	
	
	
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
	
    <script src="${path }/js/bootstrap.js"></script>

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
