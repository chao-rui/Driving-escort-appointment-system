<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/4/17
  Time: 9:11
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/login.css">
    <script src="${pageContext.request.contextPath}/resources/js/plugins/jquery-3.6.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins/vue.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins/element-ui.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/user/updPassword.js" type="module"></script>
    <title>基础信息修改</title>
</head>
<body>
<div id="app" v-loading="loading">
    <el-card class="box-card">
        <el-form :model="form" ref="form" id="form" METHOD="post" :rules="rules" label-width="80px">
            <div>
                <h1>密码修改</h1>

                <el-form-item label="旧密码" prop="oldPwd">
                    <el-input v-model="form.oldPwd" show-password maxlength="20"></el-input>
                </el-form-item>

                <el-form-item label="新密码" prop="newPwd">
                    <el-input v-model="form.newPwd" show-password maxlength="20"></el-input>
                </el-form-item>

                <el-form-item label="密码确认" prop="pwdCheck">
                    <el-input v-model="form.pwdCheck" show-password maxlength="20"></el-input>
                </el-form-item>

                <el-button type="primary" @click="save">更新</el-button>

            </div>
        </el-form>
    </el-card>
</div>
</body>
</html>

