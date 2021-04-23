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
<title>我的信息</title> 
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
	<input type="text" id="studentNo" name="userId" value="${currentUser.userName }" class="layui-hide">
	<!-- contact -->
	<div class="w3_wthree_agileits_icons main-grid-border">
		<div class="container">
			<div class="w3ls-title"> 
				<h3 class="agileits-title w3title1">个人信息</h3>
			</div>
			<div class="about-w3ls-row"> 
			
				<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="align:center">
				  <ul class="layui-tab-title">
				  	<li></li>
				  	<li></li>
				  	<li></li>
				  	<li></li>
				  	<li></li>
				    <li></li>
				    <li class="layui-this" style="font-size:20px;">基本信息</li>
				    <li style="font-size:20px;">我的积分</li>
				    <li style="font-size:20px;">违规记录</li>
				  </ul>
				  <div class="layui-tab-content" style="height: 600px;">
				  	<div class="layui-tab-item"></div>
				  	<div class="layui-tab-item"></div>
				  	<div class="layui-tab-item"></div>
				  	<div class="layui-tab-item"></div>
				  	<div class="layui-tab-item"></div>
				  	<div class="layui-tab-item"></div>
				    <div class="layui-tab-item layui-show">
				    	<div class="layui-col-md6" style="margin-left:260px">
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
							      <input type="text" name="no" lay-verify="required" autocomplete="off" placeholder="请输入学号" class="layui-input" readonly>
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
							      <button class="layui-btn layui-btn-lg layui-btn-normal" lay-submit="" lay-filter="submit" style="margin-left:60px; margin-top:20px;width:240px;">提交修改</button>
							    </div>
							  </div>
							</form>
				    	</div>
				    </div>
				    <div class="layui-tab-item">
				    	<table class="layui-hide" id="demo" lay-filter="test"></table>
				    </div>
				    <div class="layui-tab-item">
				    	<table class="layui-hide" id="detail" lay-filter="detail"></table>
				    </div>
				  </div>
				</div>  
				
				<div class="clearfix"> </div> 
			</div>
			
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
			      <button class="layui-btn" lay-submit="" lay-filter="selectclass" style="margin-left:60px;width:120px;">选  定</button>
			    </div>
			  </div>
			</form>
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
	
    <script src="${path }/js/bootstrap.js"></script>

<script>
layui.use(['table','form','upload','layer'], function(){
  var upload = layui.upload
  , table = layui.table
  , form = layui.form
  , layer = layui.layer;
 
  $(document).ready(function (){
		$.ajax({
            url:'http://localhost:8086/LibrarySeatSystem/student/findOneStudent.htm',
            type:'post',
            dataType:'json',
            data:{no:document.getElementById("studentNo").value},
            success:function (result){
            	form.val("formTest", result.studentInfo)
            	console.log(result.studentInfo);
            }
	     })
	});
  	
	//总积分
  	table.render({
      elem: '#demo',
      height: 'full',
      title: '积分表',
      limits:[10,20,30,40],
      limit:20,
      cols: [//表头
          [ 
              { field: 'id', title: 'ID', sort: true, hide:true },
              { field: 'studentno', title: '学号', sort: true }, 
              { field: 'studentname', title: '姓名' }, 
              { field: 'total', title: '剩余积分'}, 
          ]
      ],
      url: '${path }/score/scoreList.htm',
      data:{'studentno':document.getElementById("studentNo").value},
      method: 'post',
      done: function (res) {
          console.log(res);
      }
  	});
  	
	//详细扣分记录
  	table.render({
        elem: '#detail',
        height: 'full',
        title: '积分详情',
        limits:[10,20,30,40],
        limit:20,
        cols: [//表头
            [ 
                { field: 'id',width:100, title: 'id', sort: true,hide:true },
                { field: 'studentno',width:120, title: '学号', sort: true }, 
                { field: 'studentname',width:100, title: '姓名' }, 
                { field: 'time',width:240, title: '时间'}, 
                { field: 'score',width:100, title: '扣除积分'},
                { field: 'remarks', title: '违章'},
            ]
        ],
        url: '${path}/illegal/illegalList.htm?studentno='+document.getElementById("studentNo").value,
        method: 'post',
        done: function (res) {
            console.log(res);
        }
    });
	
	//选择班级表单的提交
	form.on('submit(selectclass)', function(massage) {
		console.log(massage.field.classes);
		arr=massage.field.classes.split(",");
		document.getElementById("classid").value=arr[0];
		document.getElementById("classname").value=arr[1];
		layer.close(layer.index);
		return false;
	});	
  
  	//修改学生表单的提交
  	form.on('submit(submit)', function(massage) {
      $.ajax({
          url:'http://localhost:8086/LibrarySeatSystem/student/reserveStudent.htm',
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
  	});
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
layui.use('element', function(){
  var $ = layui.jquery
  ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
  
  //触发事件
  var active = {
    tabAdd: function(){
      //新增一个Tab项
      element.tabAdd('demo', {
        title: '新选项'+ (Math.random()*1000|0) //用于演示
        ,content: '内容'+ (Math.random()*1000|0)
        ,id: new Date().getTime() //实际使用一般是规定好的id，这里以时间戳模拟下
      })
    }
    ,tabDelete: function(othis){
      //删除指定Tab项
      element.tabDelete('demo', '44'); //删除：“商品管理”
      
      
      othis.addClass('layui-btn-disabled');
    }
    ,tabChange: function(){
      //切换到指定Tab项
      element.tabChange('demo', '22'); //切换到：用户管理
    }
  };
  
  $('.site-demo-active').on('click', function(){
    var othis = $(this), type = othis.data('type');
    active[type] ? active[type].call(this, othis) : '';
  });
  
  //Hash地址的定位
  var layid = location.hash.replace(/^#test=/, '');
  element.tabChange('test', layid);
  
  element.on('tab(test)', function(elem){
    location.hash = 'test='+ $(this).attr('lay-id');
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