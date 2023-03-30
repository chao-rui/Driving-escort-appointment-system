<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/3/30
  Time: 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>驾驶陪练预约系统</title>
</head>
<body>

<form action="login" METHOD="post">
    <div>
        <h1>登录</h1>

        <label for="userId"><b>账号</b></label>
        <input type="text" placeholder="请输入账号" id="userId" name="userId" required>

        <label for="password"><b>密码</b></label>
        <input type="password" placeholder="请输入密码" id="password" name="password" required>

        <button type="submit">登录</button>
    </div>

    <div style="background-color:#f1f1f1">
        <button type="button">取消</button>
        <span>忘记<a href="#">密码?</a></span>
    </div>
</form>

</body>
</html>