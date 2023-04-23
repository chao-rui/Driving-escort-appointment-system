<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/4/17
  Time: 9:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Cache-Control" content="no-cache">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/plugins/element-ui.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/fullPage.css">
        <script src="${pageContext.request.contextPath}/resources/js/plugins/jquery-3.6.4.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/plugins/vue.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/plugins/element-ui.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/car/carManage.js" type="module"></script>
        <title>车辆管理</title>
    </head>
</head>
<body>
<div id="app" v-loading="loading">
<el-card>
    <h1>车辆一览</h1>
    <el-table
            :data="carList"
            style="width: 100%">
        <el-table-column
                prop="carNumber"
                label="车牌号"
                width="180">
        </el-table-column>
        <el-table-column
                prop="carBrands"
                label="品牌"
                width="180">
        </el-table-column>
        <el-table-column
                prop="carModel"
                label="类型">
        </el-table-column>
        <el-table-column
                prop="userRName"
                label="所属">
        </el-table-column>
        <el-table-column
                prop="carFlag"
                label="状态">
        </el-table-column>
        <el-table-column
                label="操作"
                width="100">
            <template slot-scope="scope">
                <el-button @click="delCoach(scope.row)" type="text" size="small">编辑</el-button>
            </template>
        </el-table-column>
    </el-table>
</el-card>
</div>
</body>
</html>
