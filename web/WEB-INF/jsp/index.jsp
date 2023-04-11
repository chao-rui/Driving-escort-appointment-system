<%@ page import="entity.User" %><%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/3/30
  Time: 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%User user = (User) request.getSession().getAttribute("user");%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/element-ui.css">
    <link rel="stylesheet" href="resources/css/index.css">
    <script src="resources/js/jquery-3.6.4.min.js"></script>
    <script src="resources/js/vue.js"></script>
    <script src="resources/js/element-ui.js"></script>
    <script src="resources/js/index.js" type="module"></script>
    <meta charset="UTF-8">
    <title>首页</title>
</head>
<body>
<div id="app">
    <el-container>
        <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
            <el-menu :default-openeds="['2']" :router='true'>
                <el-menu-item index="/home">
                    <i class="el-icon-s-home"></i>
                    <span slot="title">首页</span>
                </el-menu-item>
                <el-submenu index="2">
                    <template slot="title"><i class="el-icon-user-solid"></i>个人信息管理</template>
                    <el-menu-item-group>
                        <el-menu-item index="/updUInfo">基础信息修改</el-menu-item>
                        <el-menu-item index="/updPwd">密码修改</el-menu-item>
                        <el-menu-item index="/2-3">实名认证</el-menu-item>
                        <el-menu-item index="/2-4">身份认证</el-menu-item>
                    </el-menu-item-group>
                </el-submenu>
            </el-menu>
        </el-aside>

        <el-container>
            <el-header style="text-align: right; font-size: 12px">
                <el-dropdown>
                    <i class="el-icon-setting" style="margin-right: 15px"></i>
                    <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item>查看</el-dropdown-item>
                        <el-dropdown-item>新增</el-dropdown-item>
                        <el-dropdown-item>删除</el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
                <span><%=user.getUserName()%></span>
            </el-header>

            <el-main>
            </el-main>
        </el-container>
    </el-container>
</div>
</body>
</html>