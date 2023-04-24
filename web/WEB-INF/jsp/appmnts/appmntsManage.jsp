<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/4/17
  Time: 9:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <script src="${pageContext.request.contextPath}/resources/js/appmnts/appmntsManage.js" type="module"></script>
        <title>预约管理</title>
    </head>
</head>
<body>
<div id="app" v-loading="loading">
    <el-card>
        <el-table
                :data="appmntsList"
                style="width: 100%">
            <el-table-column
                    v-if="isCoach"
                    prop="user.userRname"
                    label="用户"
                    :formatter="userRNameFormatter">
            </el-table-column>
            <el-table-column
                    v-if="isCoach"
                    prop="user.phone"
                    label="联系方式">
            </el-table-column>
            <el-table-column
                    v-if="isUser"
                    prop="object.userRname"
                    label="教练">
            </el-table-column>
            <el-table-column
                    v-if="isUser"
                    prop="object.phone"
                    label="教练">
            </el-table-column>
            <el-table-column
                    prop="startDate"
                    label="开始时间">
            </el-table-column>
            <el-table-column
                    prop="endDate"
                    label="结束时间">
            </el-table-column>
            <el-table-column
                    prop="appraise"
                    label="评价">
            </el-table-column>
            <el-table-column
                    prop="appointmentState"
                    label="状态"
                    :formatter="appmntsStateFormatter">
            </el-table-column>
            <el-table-column
                    label="操作"
                    width="100">
                <template slot-scope="scope">
                    <el-button @click="delCoach(scope.row)" type="text" size="small">查看</el-button>
                </template>
            </el-table-column>
        </el-table>
    </el-card>
</div>
</body>
</html>

