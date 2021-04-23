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
	<title>${notice.title }</title>
	<link rel="shortcut icon" href="favicon.ico"> <link href="${path }/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="${path }/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">

    <link href="${path }/css/animate.min.css" rel="stylesheet">
    <link href="${path }/css/style.min862f.css?v=4.1.0" rel="stylesheet">
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content  animated fadeInRight article">
        <div class="row">
            <div class="col-lg-10 col-lg-offset-1">
                <div class="ibox">
                    <div class="ibox-content">
                        <div class="text-center article-title">
                            <h1>
                            	${notice.title }
                            </h1>
                            <br>
                            <h2>
                            	${notice.time }
                            </h2>
                        </div>
                        ${notice.content }
                    </div>
                </div>
            </div>
        </div>

    </div>
</body>

</html>
