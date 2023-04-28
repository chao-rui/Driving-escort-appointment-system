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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/fullPage.css">
    <script src="${pageContext.request.contextPath}/resources/js/plugins/jquery-3.6.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins/vue.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins/element-ui.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/main/UserMain.js" type="module"></script>
    <title>首页</title>
</head>
<body>
<div id="app" v-loading="loading">
    <el-row style="margin-bottom: 20px">
        <el-col :span="12">
            <el-card style=" height: 360px;margin-right: 20px">
                <el-table
                        :data="applyList">
                    <el-table-column
                            prop="workId"
                            label="工号">
                    </el-table-column>
                    <el-table-column
                            prop="carSchool.carSchoolName"
                            label="驾校">
                    </el-table-column>
                    <el-table-column
                            prop="updateDate"
                            label="申请时间">
                    </el-table-column>

                    <el-table-column
                            prop="applyState"
                            label="状态"
                            :formatter="applyStateFormatter">
                    </el-table-column>
                </el-table>
            </el-card>
        </el-col>
        <el-col :span="12">
            <el-card style="height: 360px;width: 100%">
                <strong>总计</strong>
                <el-row>
                    <el-col :span="12">
                        <div>
                            <el-statistic :value="countApp" title="预约次数" suffix="次"></el-statistic>
                        </div>
                    </el-col>
                    <el-col :span="12">
                        <div>
                            <el-statistic :value="sumApp" title="预约时长" suffix="小时"></el-statistic>
                        </div>
                    </el-col>
                </el-row>
                <el-divider></el-divider>
                <el-descriptions title="最近一次预约" :column="2" border>
                    <el-descriptions-item label="教练">{{recApp.object.userRname}}</el-descriptions-item>
                    <el-descriptions-item label="联系电话">{{recApp.object.phone}}</el-descriptions-item>
                    <el-descriptions-item label="开始时间">{{recApp.startDate}}</el-descriptions-item>
                    <el-descriptions-item label="状态"><el-tag size="small">{{recApp.appointmentState}}</el-tag></el-descriptions-item>
                </el-descriptions>
            </el-card>
        </el-col>
    </el-row>
    <el-card style="margin-right: 20px">
    <el-table
            :data="carSchoolList">
        <el-table-column
                prop="carSchoolName"
                label="驾校">
        </el-table-column>
        <el-table-column
                prop="carSchoolAdders"
                width="500px"
                label="地址">
        </el-table-column>
        <el-table-column
                prop="carSchoolPhone"
                label="联系方式">
        </el-table-column>
        <el-table-column
                prop="appraiseCarSchool"
                label="评价">
        </el-table-column>
        <el-table-column
                label="操作">
            <template slot-scope="scope">
                <el-button @click="toAppmnts(scope.row)" type="primary">查看</el-button>
            </template>
        </el-table-column>
    </el-table>
    </el-card>
</div>
</body>
</html>
