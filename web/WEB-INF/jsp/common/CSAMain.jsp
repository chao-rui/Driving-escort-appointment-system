<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/4/14
  Time: 13:18
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/main.css">
    <script src="${pageContext.request.contextPath}/resources/js/plugins/jquery-3.6.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins/vue.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins/element-ui.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/common/CSAMain.js" type="module"></script>
    <title>首页</title>
</head>
<body>
<div id="app">
    <el-card>
        <el-table
                :data="applyList">
            <el-table-column
                    prop="workId"
                    label="工号">
            </el-table-column>
            <el-table-column
                    prop="user.userRname"
                    label="姓名">
            </el-table-column>
            <el-table-column
                    prop="updateDate"
                    label="申请时间"
                    width="100px">
            </el-table-column>

            <el-table-column
                    label="操作"
                    width="180px">
                <template slot-scope="scope">
                    <el-button @click="updApply(scope.row,1)" type="success">通过</el-button>
                    <el-button @click="updApply(scope.row,0)" type="danger">拒绝</el-button>
                </template>
            </el-table-column>
        </el-table>
    </el-card>
</div>
</body>
</html>
