<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/4/14
  Time: 9:52
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
    <script src="${pageContext.request.contextPath}/resources/js/user/updBasicInfo.js" type="module"></script>
    <title>基础信息修改</title>
</head>
<body>
<div id="app" v-loading="loading">
    <el-card class="box-card">
        <el-form :model="form" ref="form" id="form" action="user/register" METHOD="post" :rules="rules" label-width="80px">
            <div>
                <h1>基础信息更新</h1>

                <el-form-item label="用户名" prop="userName">
                    <el-input v-model="form.userName" maxlength="10" ></el-input>
                </el-form-item>

                <el-form-item label="性 别" prop="gender">
                    <el-radio v-model="form.gender" label="男">男</el-radio>
                    <el-radio v-model="form.gender" label="女">女</el-radio>
                </el-form-item>

                <el-form-item label="手机号" prop="phone">
                    <el-input v-model="form.phone" type="tel" pattern="[0-9]{11}" maxlength="11"></el-input>
                </el-form-item>


                <el-form-item label="出生年" prop="birthYear">
                    <el-date-picker v-model="form.birthYear" type="year" placeholder="选择年"></el-date-picker>
                </el-form-item>

                <el-button type="primary" @click="register">更新</el-button>

            </div>
        </el-form>
    </el-card>
</div>
</body>
</html>
