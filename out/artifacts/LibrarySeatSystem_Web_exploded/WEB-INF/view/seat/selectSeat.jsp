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
<title>选座</title>
<!-- for-mobile-apps -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<!-- //for-mobile-apps -->
<link href='//fonts.googleapis.com/css?family=Kotta+One' rel='stylesheet' type='text/css'>
<link href='//fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
<link href="${path }/css/style-seat.css" rel="stylesheet" type="text/css" media="all" />

<link rel="stylesheet" href="${path }/layui/css/layui.css" media="all">
<script type="text/javascript" src="${path }/layui/layui.js" charset="utf-8"></script>

<script src="${path }/js/jquery.min.js"></script>
<script src="${path }/js/jquery.seat-charts.js"></script>


</head>
<body>
<form id="searchForm" action="" lay-filter="formTest" style="margin-top:30px">
<div class="layui-col-md6 layui-inline">
    <label class="layui-form-label"></label>
    <label class="layui-form-label"></label>
    <div class="layui-input-inline">
        <select type="text" id="s_date" name="date"  autocomplete="off"  lay-verify="required" class="layui-select">
			<option value="">--请选择日期--</option>
		</select>
    </div>  
    <div class="layui-input-inline">
        <select type="text" id="s_time" name="time"  autocomplete="off"  lay-verify="required" class="layui-select">
			<option value="">--请选择时间段--</option>
		</select>
    </div>
    <div class="layui-input-inline">
        <select type="text" id="s_room" name="roomid"  autocomplete="off"  lay-verify="required" class="layui-select">
			<option value="">--请选择阅览室--</option>
		</select>
    </div>
    <div class="layui-inline">
		<button class="layui-btn " lay-submit="" lay-filter="submit">搜索座位</button>
	</div>
</div>
</form>
<div id="flash" >
<div class="content">
	<div class="main">
		<h2>阅览室</h2>
		<div class="demo">
			<!---左边座位列表----->
			<div id="seat-map">
				<!-- <div class="front">屏幕</div> -->				
			</div>
			<!---右边选座信息----->
			<div class="booking-details">
				<ul class="book-left">
					
					<li>Seats</li>
					<li>选择的座位:</li>
				</ul>
				<ul class="book-right">
					<li>: <span id="counter">0</span></li>
				</ul>
				
				<div class="clear"></div>
				<ul id="selected-seats" class="scrollbar scrollbar1"></ul>
			
						
				<button id="senddata" class="checkout-button" onclick="selectSeat()">确认选座</button>	
				<div id="legend"></div>
			</div>
			<div style="clear:both"></div>
	    </div>
	</div>
</div>
</div>
<script src="${path }/js/jquery.nicescroll.js"></script>
<script src="${path }/js/scripts.js"></script>
</body>

<script>

</script>

<script type="text/javascript">
	var keyword='';
	var selectedcount=0;
	var mapArr=new Array();
	var selectedArr=new Array();
	var leaveArr=new Array();
	var myseat='';
	var price = 10;
	var sc = null;
	$(document).ready(function() {
		
		layui.use(['table', 'form', 'layer'], function() {
		    var form = layui.form
		        , table = layui.table
		        , layer = layui.layer
		        , vipTable = layui.vip_table
		        , $ = layui.jquery;
		    
		    //日期下拉框
		    $.ajax({
				type : "post",
				url : "${path }/seat/dateCombo.htm",
				data : {},
				dataType : "json",
				success : function(d) {
					var list=d;
					 var tmp = '';
					 for ( var i in list) {
						 tmp += '<option value="' + list[i].zhi +  '">' + list[i].biaoqian + '</option>';
					}
					 $("#s_date").html(tmp);					
					 form.render("select"); 
				},
				error:function(){
					layer.alert('请求失败，稍后再试', {icon: 5});
				}
			});
		    
		    //时间段下拉框
		    $.ajax({
				type : "post",
				url : "${path }/seat/timeCombo.htm",
				data : {},
				dataType : "json",
				success : function(d) {
					var list=d;
					 var tmp = '';
					 for ( var i in list) {
						 tmp += '<option value="' + list[i].zhi +  '">' + list[i].biaoqian + '</option>';
					}
					 $("#s_time").html(tmp);					
					 form.render("select"); 
				},
				error:function(){
					layer.alert('请求失败，稍后再试', {icon: 5});
				}
			});
		    
		    //阅览室下拉框
		    $.ajax({
				type : "post",
				url : "${path }/seat/roomCombo.htm",
				data : {},
				dataType : "json",
				success : function(d) {
					var list=d;
					 var tmp = '';
					 for ( var i in list) {
						 tmp += '<option value="' + list[i].id +  '">' + list[i].name + '</option>';
					}
					 $("#s_room").html(tmp);					
					 form.render("select"); 
				},
				error:function(){
					layer.alert('请求失败，稍后再试', {icon: 5});
				}
			});
		    
		    //search 提交操作
		    form.on('submit(submit)', function(massage) {
		    	document.getElementById('flash').innerHTML=
		    		'<div class="content"><div class="main"><h2>'+$('#s_room').val()+'号阅览室</h2><div class="demo"><div id="seat-map"></div><div class="booking-details"><ul class="book-left"><li>Seats</li><li>选择的座位:</li></ul><ul class="book-right"><li>: <span id="counter">0</span></li></ul><div class="clear"></div><ul id="selected-seats" class="scrollbar scrollbar1"></ul><button id="senddata" class="checkout-button" onclick="selectSeat()">确认选座</button><div id="legend"></div></div><div style="clear:both"></div></div></div></div>';
		  		
		    	keyword=$('#s_date').val()+'-'+$('#s_time').val()+'-'+$('#s_room').val()+'-';
		        $.ajax({
		            url:'${path}/seat/combolist.htm',
		            type:'post',
		            dataType:'json',
		            data:{date:$('#s_date').val(),time:$('#s_time').val(),roomid:$('#s_room').val()},
		            success:function (result){
		            	layer.msg("查询成功", {icon: 6});
		                console.log(result);
		                var row = result.row;
		                var col = result.col;
		                selectedcount=0; //选择的座位数量置零
		                mapArr=[];//map清空
		                for (var i=0;i<row;i++)
		                { 
		                    var str='';
		                    for(j=0;j<col;j++)
		                    {
		                    	str+='a';
		                    }
		                    mapArr.push(str);
		                }
		                selectedArr=[];//已选择的座位清空
		                leaveArr=[];//暂离座位清空
		                var list=result.seatList;
		                for (x in list)  // x 为属性名
		                {
		                	if(list[x].status=="1"||list[x].status=="2"){
		                		//if(list[x].studentno == )
		                		selectedArr.push(list[x].row+'_'+list[x].col);
	      					}
		                	else if(list[x].status==3){
		                		leaveArr.push(list[x].row+'_'+list[x].col);
		                	}
		                }
		                //开始渲染座位
		                var $cart = $('#selected-seats'), //座位区
		        		$counter = $('#counter'), //票数
		        		$total = $('#total'); //票价总额
		        		
		        		sc = $('#seat-map').seatCharts({
		        			map: mapArr, 
		        			naming : {//设置行列等信息
		        				top : true,//显示顶部横坐标（行）
		        				getLabel : function (character, row, column) {
		        					return column;
		        				}
		        			},
		        			legend : { //定义 图例
		        				node : $('#legend'),
		        				items : [
		        					[ 'a', 'available',   '空闲' ],
		        					[ 'a', 'unavailable', '有人'],
		        					[ 'a', 'selected', '选中'],
		        					[ 'a', 'leave', '暂离']
		        				]					
		        			},
		        			click: function () { //点击事件
		        				if (this.status() == 'available') { //若为可选座状态，添加座位
		        					$('<li>第'+(this.settings.row+1)+'排 第'+this.settings.label+'列</li>')
		        						.attr('id', 'cart-item-'+this.settings.id)
		        						.data('seatId', this.settings.id)
		        						.appendTo($cart);
									
		        					$counter.text(sc.find('selected').length+1);//统计选票数量
		        					selectedcount++;
		        					keyword=keyword+(this.settings.row+1)+'-'+this.settings.label;
		        					myseat=(this.settings.row+1)+'_'+this.settings.label;
		        					console.log(keyword);
		        					console.log(myseat);
		        					return 'selected';
		        				} else if (this.status() == 'selected') { //若为选中状态
		        						
		        						$counter.text(sc.find('selected').length-1);//更新票数量
		        						selectedcount--;
		        							
		        						$('#cart-item-'+this.settings.id).remove();//删除已预订座位
		        						keyword = keyword.substring(0,21);//删除keyword中的座位信息
		        						myseat='';
		        						console.log(keyword);
		        						console.log(myseat);
		        						return 'available';//返回状态 可选择的
		        				} else if (this.status() == 'unavailable') { //若为已售出状态
		        					return 'unavailable'; //返回状态 已售出
		        				}else if(this.status() == 'leave' ){
									return 'leave';
								}else {
		        					return this.style();
		        				}
		        			}
		        		});
		        		//设置已被选座位
		        		sc.get(selectedArr).status('unavailable');
		        		//设置暂离座位
		        		sc.get(leaveArr).status('leave');
		            }
		        })
		        return false;
		    })   
		    
		});
		
	});
	function selectSeat(){
		if(selectedcount == 0){
			layer.msg("您还没有选座哦！", {icon: 5});
		}else if(selectedcount > 1){
			layer.msg("请一次选择一个座位！", {icon: 5});
		}else{
			console.log(keyword);
			$.ajax({
				url:'${path}/seat/saveSeat.htm',
				data:{keyword:keyword},
				success:function(result){
					var returnCode = result.returnCode;
	                if(returnCode == 200){
	                    layer.msg("预约成功!", {icon: 6});
	                    var arr=new Array();
	                    arr.push(myseat);
	                    sc.get(arr).status('unavailable');//预约成功，更改选择座位的颜色。
	                }else{
	                    layer.msg(returnCode, {icon: 5});
	                }
				}
			});
		}
	}
</script>

</html>
