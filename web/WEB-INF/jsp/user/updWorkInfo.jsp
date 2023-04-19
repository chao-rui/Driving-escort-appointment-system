<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/4/17
  Time: 9:12
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
    <script src="${pageContext.request.contextPath}/resources/js/user/updWorkInfo.js" type="module"></script>
    <title>身份认证</title>
</head>
<body>
<div id="app" v-loading="loading">
    <el-card class="box-card">
        <el-tabs v-model="tabName">
            <el-tab-pane label="教练" name="first">
                <el-form :model="form" ref="form" id="form" METHOD="post" :rules="rules" label-width="80px">
                    <div>
                        <h1>身份认证</h1>

                        <el-form-item label="工号" prop="userRName">
                            <el-input v-model="form.userRName" show-password maxlength="10"></el-input>
                        </el-form-item>

                        <el-form-item label="所属驾校" prop="idNumber">
                            <el-input v-model="form.idNumber" show-password maxlength="18"></el-input>
                        </el-form-item>

                        <el-button type="primary" @click="save">开始认证</el-button>

                    </div>
                </el-form>
            </el-tab-pane>
            <el-tab-pane label="驾校管理员" name="second">
                <el-form :model="form" ref="form" id="form" METHOD="post" :rules="rules" label-width="80px">
                    <div>
                        <h1>身份认证</h1>

                        <el-form-item label="所属驾校" prop="userRName">
                            <el-input v-model="form.userRName" show-password maxlength="10"></el-input>
                        </el-form-item>

                        <el-form-item label="邀请码" prop="idNumber">
                            <el-input v-model="form.idNumber" show-password maxlength="18"></el-input>
                        </el-form-item>

                        <el-button type="primary" @click="save">开始认证</el-button>

                    </div>
                </el-form>
            </el-tab-pane>
        </el-tabs>
    </el-card>
</div>
</body>
</html>
