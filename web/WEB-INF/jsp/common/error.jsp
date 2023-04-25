<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/4/19
  Time: 14:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/plugins/element-ui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/error.css">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/img/logo.webp" />
    <script src="${pageContext.request.contextPath}/resources/js/plugins/jquery-3.6.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins/vue.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins/element-ui.js"></script>
    <title>错误</title>
</head>
<body>
<div id="app">
    <el-card class="box-card">
        <h1>出错啦</h1>
        <p>很抱歉，我们无法处理该请求。</p>
        <p>可能是由于：</p>
        <ul>
            <li>您输入的URL有误</li>
            <li>您正在尝试访问不再可用的页面</li>
            <li>我们的服务器遇到了问题</li>
        </ul>
        <p>您可以尝试：</p>
        <ul>
            <li>稍后再试</li>
            <li><a href="/" target="_parent">重新登录</a></li>
        </ul>
    </el-card>
</div>
</body>
<script>
    new Vue({
        el:"#app"
    });
</script>
</html>
