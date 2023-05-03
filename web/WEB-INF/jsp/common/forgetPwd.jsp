<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/4/28
  Time: 17:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <script src="${pageContext.request.contextPath}/resources/js/common/forgetPwd.js" type="module"></script>
    <title>重置密码</title>
</head>
<body>
<div id="app">
    <el-card class="box-card" v-loading="loading">
        <el-steps :active="active" finish-status="success" align-center>
            <el-step title="输入账号" description="请先输入账号"></el-step>
            <el-step title="填写验证码" description="请检查邮件，并填写验证码和新密码"></el-step>
            <el-step title="成功" description="重置成功啦，快去登录吧"></el-step>
        </el-steps>
        <div id="setup1" v-if="setup1">
            <el-form METHOD="post" :model="form" ref="setup1" :rules="rules">
                <div id="steup1" v-if="setup1">
                    <el-form-item label="账号" prop="userId">
                        <el-input name="userId" v-model="form.userId" maxlength="10"></el-input>
                    </el-form-item>
                    <el-button type="primary" @click="sendEmail" style="margin-top: 50px">提交</el-button>
                </div>
            </el-form>
        </div>
        <div id="setup2" v-if="setup2">
            <el-form METHOD="post" :model="form" ref="setup2" :rules="rules">
                <div id="steup2" v-if="setup2">
                    <el-form-item label="验证码" prop="code">
                        <el-input name="code" v-model="form.code" maxlength="5"></el-input>
                    </el-form-item>
                    <el-form-item label="新密码" prop="newPwd">
                        <el-input v-model="form.newPwd" show-password maxlength="20"></el-input>
                    </el-form-item>
                    <el-form-item label="密码确认" prop="pwdCheck">
                        <el-input v-model="form.pwdCheck" show-password maxlength="20"></el-input>
                    </el-form-item>
                    <el-button type="primary" @click="checkCode" style="margin-top: 50px">提交</el-button>
                </div>
            </el-form>
        </div>
        <div id="steup3" v-if="setup3">
            <p>重置成功啦，快去登录吧</p>
            <el-button type="primary" @click="toLogin" style="margin-top: 50px">去登录</el-button>
        </div>
    </el-card>
</div>
</body>
</html>
