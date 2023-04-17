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
    <link rel="stylesheet" href="resources/css/plugins/element-ui.css">
    <link rel="stylesheet" href="resources/css/common/login.css">
    <link rel="icon" type="image/x-icon" href="resources/img/1.webp" />
    <script src="resources/js/plugins/jquery-3.6.4.min.js"></script>
    <script src="resources/js/plugins/vue.js"></script>
    <script src="resources/js/plugins/element-ui.js"></script>
    <script src="resources/js/common/login.js" type="module"></script>
    <title>驾驶陪练预约系统</title>
</head>
<body>
<div id="app">
    <el-card class="box-card">
        <el-form action="login" METHOD="post" :model="form" ref="form" :rules="rules">
            <div>
                <h1>登录</h1>

                <el-form-item label="账号" prop="userId">
                    <el-input name="userId" v-model="form.userId" maxlength="10"></el-input>
                </el-form-item>

                <el-form-item label="密码" prop="password">
                    <el-input name="password" v-model="form.password" show-password maxlength="20"></el-input>
                </el-form-item>
                <el-button type="primary" native-type="submit">登录</el-button>
                <el-button type="primary" @click="register">注册</el-button>
            </div>
        </el-form>
    </el-card>
</div>
</body>
</html>