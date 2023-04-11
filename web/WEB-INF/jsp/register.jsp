<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/3/30
  Time: 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/element-ui.css">
    <link rel="stylesheet" href="resources/css/login.css">
    <script src="resources/js/jquery-3.6.4.min.js"></script>
    <script src="resources/js/vue.js"></script>
    <script src="resources/js/element-ui.js"></script>
    <script src="resources/js/register.js" type="module"></script>
    <meta charset="UTF-8">
    <title>注册</title>
</head>
<body>
<div id="app" v-loading="loading">
    <el-card class="box-card">
        <el-form :model="form" ref="form" id="form" action="user/register" METHOD="post" :rules="rules">
            <div>
                <h1>注册</h1>

                <el-form-item label="用户名" prop="userName">
                    <el-input v-model="from.userName" maxlength="10" ></el-input>
                </el-form-item>

                <el-form-item label="手机号" prop="phone">
                    <el-input v-model="from.phone" type="tel" pattern="[0-9]{11}" maxlength="11"></el-input>
                </el-form-item>

                <el-form-item label="密码" prop="password">
                    <el-input v-model="from.password" show-password maxlength="20"></el-input>
                </el-form-item>

                <el-form-item label="密码确认" prop="pwdCheck">
                    <el-input v-model="from.pwdCheck" show-password maxlength="20"></el-input>
                </el-form-item>

                <el-menu-item>
                <el-button type="primary" @click="register">注册</el-button>
                </el-menu-item>
            </div>
        </el-form>
    </el-card>
</div>
</body>
</html>