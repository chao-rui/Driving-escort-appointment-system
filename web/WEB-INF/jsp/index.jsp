<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/3/30
  Time: 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%User user = (User) request.getSession().getAttribute("user");%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/element-ui.css">
    <link rel="stylesheet" href="resources/css/bootstrap-icons.css">
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
        <el-aside>
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
                <c:if test="${user.getRoleFlag()== 2 || user.getRoleFlag() == 3}">
                    <el-menu-item index="3">
                        <i class="bi bi-calendar2-event-fill" ></i>
                        <span slot="title">预约信息管理</span>
                    </el-menu-item>
                </c:if>
                <c:if test="${user.getRoleFlag() == 4}">
                    <el-menu-item index="4">
                        <i class="bi bi-buildings-fill" ></i>
                        <span slot="title">驾校信息管理</span>
                    </el-menu-item>
                    <el-menu-item index="5">
                        <i class="bi bi-car-front-fill" ></i>
                        <span slot="title">车辆信息管理</span>
                    </el-menu-item>
                </c:if>
                <c:if test="${user.getRoleFlag() == 3 || user.getRoleFlag() == 4}">
                    <el-menu-item index="6">
                        <i class="bi bi-person-x-fill" ></i>
                        <span slot="title">退出驾校</span>
                    </el-menu-item>
                </c:if>
            </el-menu>
        </el-aside>

        <el-container>
            <el-header>
                <%
                    SimpleDateFormat sim=new SimpleDateFormat ("yyyy年MM月dd日 EEEE");
                    String Today = sim.format (new Date());
                %>
                <span><%=Today%></span>
                <span style="text-align: right">
                    <span><%=user.getUserName()%></span>
                    <el-dropdown>
                        <i class="bi bi-arrow-left-square-fill"></i>
                        <el-dropdown-menu slot="dropdown">
                            <el-dropdown-item>退出系统</el-dropdown-item>
                            <el-dropdown-item>注销账号</el-dropdown-item>
                        </el-dropdown-menu>
                    </el-dropdown>
                </span>
            </el-header>

            <el-main>
            </el-main>
        </el-container>
    </el-container>
</div>
</body>
</html>