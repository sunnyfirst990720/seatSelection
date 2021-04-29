<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>
<!DOCTYPE html>
<html>
  <head>
    <title>聊天内容管理</title>
<script type="text/javascript">
	$(function(){
		$.ajax({
			url:'${path}/book/bookList.htm?rows=5&page=1',  //第一页前5条数据
			dataType:'json',
			type:'post',
			async:false,
			success:function(data){
				var books = data.rows;
				var str = "";
				for(var i=0;i<books.length;i++){
					var book = books[i];
					str += "<div style='width:100%;height:140px;'>";
					str += "<div style='width:20%;height:138px;'>";
					str += "<img src='"+book.cover+"' style='width:100%;height:100%'>";
					str += "</div><div style='text-align:left;width:30%;height:138px;float:left;margin-left:21%;margin-top:-138px'>";
					str += "主题：《"+book.name+"》<br/><br/><br/>日期："+book.author+"<br/><br/><br/>地点："+book.publish;
					str += "</div><div style='text-align:left;width:30%;height:138px;float:left;margin-left:52%;margin-top:-138px'>消息内容：" + book.remarks;
					str += "</div></div><br/>";
					str += "<div style='width:100%;height:2px;background:blue'></div><br/>";
				}
				$("#a").html(str);
			}
		});
	});
</script>
</head>
<body style="margin: 5px;" >
	<div style="width:100%;height:100%;" id = "a">
	
	</div>
</body>
</html>