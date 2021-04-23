<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	//设定context path
	String path = request.getContextPath();
	if("/".equals(path.trim())) path = "";
	pageContext.setAttribute("path",path);
%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
    <meta charset="utf-8">
    <title>图表</title>
</head>
<body style="height: 100%; margin: 0">
<div id="container" style="height: 100%"></div>
<script type="text/javascript" src="${path }/js/echarts.min.js"></script>
<script src="${path }/js/jquery.min.js?v=2.1.4"></script>
<script type="text/javascript">
var dom = document.getElementById("container");
var myChart = echarts.init(dom);
var app = {};
option = null;
option = {
    tooltip : {
        trigger: 'axis'
    },
    legend: {
        data:['1号阅览室','2号阅览室','3号阅览室','4号阅览室']
    },
    toolbox: {
        show : true,
        feature : {
            dataView : {show: true, readOnly: false},
            magicType : {show: true, type: ['line', 'bar']},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : true,
    xAxis : [
        {
            type : 'category',
            data : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'1号阅览室',
            type:'bar',
            //data:[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3],
            markPoint : {
                data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                ]
            },
            markLine : {
                data : [
                    {type : 'average', name: '平均值'}
                ]
            }
        },
        {
            name:'2号阅览室',
            type:'bar',
            markPoint : {
                data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                ]
            },
            markLine : {
                data : [
                    {type : 'average', name: '平均值'}
                ]
            }
        },
        {
            name:'3号阅览室',
            type:'bar',
            markPoint : {
                data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                ]
            },
            markLine : {
                data : [
                    {type : 'average', name: '平均值'}
                ]
            }
        },
        {
            name:'4号阅览室',
            type:'bar',
            markPoint : {
                data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                ]
            },
            markLine : {
                data : [
                    {type : 'average', name: '平均值'}
                ]
            }
        }
    ]
};
$(document).ready
(
	function()
	{
		$.ajax({
            url:'${path }/chart/findSeatChart.htm'
            ,data:''
            ,type:'post'
            ,dataType:'json'
            ,success:function (result) {
                option.title=result.title;
                //option.legend.data=result.legend.data;
                option.series[0].data=result.datarray[0];
                option.series[1].data=result.datarray[1];
                option.series[2].data=result.datarray[2];
                option.series[3].data=result.datarray[3];
                if (option && typeof option === "object") {
                	console.log(option);
				    myChart.setOption(option, true);
				}
            }
        });
	}
);
</script>
</body>
</html>