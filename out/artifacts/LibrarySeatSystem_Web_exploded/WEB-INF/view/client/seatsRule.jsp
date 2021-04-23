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
<title>选座规则</title> 
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
	<!-- rule -->
	<div class="w3_wthree_agileits_icons main-grid-border">
		<div class="container">
			<div class="w3ls-title"> 
				<h3 class="agileits-title w3title1">座位使用规则</h3>
			</div>
			<div class="about-w3ls-row"> 
				<div class="layui-form">
				  <table class="layui-table">
				    <colgroup>
				      <col width="150">
				      <col width="400">
				    </colgroup>
				    
				    <tbody>
				      <tr>
				        <td>用馆规则</td>
				        <td>来馆选座、到馆签到、离馆退座，临时离开请点击暂离。<br>
						</td>
				      </tr>
				      <tr>
				        <td>明日预约规则</td>
				        <td>22:00点-23:59点开放
						</td>
				      </tr>
				      <tr>
				        <td>违规规则</td>
				        <td>预约后规定时间内未到馆签到记录违规；<br>
							<br>被监督占座不签到记录违规；<br>
							<br>离馆不退座记录违规。<br>
						</td>
				      </tr>
				      <tr>
				        <td>黑名单规则</td>
				        <td>1. 15天内发生3次违规进入黑名单，黑名单禁用系统7天。 <br>
							<br>2. “黑名单解除”道具使用后立即移除黑名单，进入黑名单后清除违规记录不会移除黑名单。 <br>
							<br>3. 违规使用监督占座功能的（如照片严重失实），查证后立即进入长期黑名单且不可使用道具移除。<br>
							<br>4. 已开通学号验证的学校,如果绑定他人学号或者借学号给他人绑定,查证后立即进入长期黑名单且不可使用道具移除。<br>
						</td>
				      </tr>
				      <tr>
				        <td>退座规则</td>
				        <td>1. 退座分为主动退座及被动退座。<br>
							<br>2. 主动退座:自己主动点击退座按钮进行退座，记录完整的时长与积分，并且有积分红包及道具红包掉落的哦。<br>
							<br>3. 被动退座:闭馆时系统会自动清理座位，只记录1/4的时长及积分，不会被记录违规。<br>
						</td>
				      </tr>
				    </tbody>
				  </table>
				  
				  <table class="layui-table">
				    <colgroup>
				      <col width="150">
				      <col width="150">
				      <col width="200">
				      <col width="150">
				    </colgroup>
				    <thead>
				      <tr>
				        <th>暂离保留规则</th>
				        <th>时长</th>
				        <th>可用时间</th>
				        <th>次数</th>
				      </tr> 
				    </thead>
				    <tbody>
				      <tr>
				        <td>暂离保留</td>
				        <td>90分钟</td>
				        <td>00:00-23:59</td>
				        <td>5次</td>
				      </tr>
				      <!-- <tr>
				        <td>午间暂离</td>
				        <td>120分钟</td>
				        <td>11:00-13:00</td>
				        <td>1次</td>
				      </tr>
				      <tr>
				        <td>晚间暂离</td>
				        <td>120分钟</td>
				        <td>16:00-19:00</td>
				        <td>1次</td>
				      </tr> -->
				    </tbody>
				  </table>
				  
				</div>
							
				<div class="clearfix"> </div> 
			</div>
			
		</div>	
	</div>
	<!-- //rule -->

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
	
	<!-- //End-slider-script -->
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
