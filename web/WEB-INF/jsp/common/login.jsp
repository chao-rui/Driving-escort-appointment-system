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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/plugins/element-ui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/centerCard.css">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/img/logo.webp" />
    <script src="${pageContext.request.contextPath}/resources/js/plugins/jquery-3.6.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins/vue.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins/element-ui.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/common/login.js" type="module"></script>
    <title>驾驶陪练预约系统</title>
</head>
<body>
<div id="app">
    <el-card class="box-card" v-loading="loading">
        <el-form METHOD="post" :model="form" ref="form" :rules="rules">
            <div>
                <h1>登录</h1>

                <el-form-item label="账号" prop="userId">
                    <el-input name="userId" v-model="form.userId" maxlength="10"></el-input>
                </el-form-item>

                <el-form-item label="密码" prop="password">
                    <el-input name="password" v-model="form.password" show-password maxlength="20"></el-input>
                </el-form-item>
            </div>
        </el-form>
        <el-row>
            <el-col :span="4" :offset="7"><el-button type="primary" @click="login">登录</el-button></el-col>
            <el-col :span="4" :offset="2"><el-button type="primary" @click="register">注册</el-button></el-col>
            <el-col :span="4" :offset="3">
                <el-link type="danger" href="forgetPwd" style="margin-top: 25px">忘记密码</el-link>
            </el-col>
        </el-row>
    </el-card>
</div>
</body>
</html>