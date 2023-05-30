<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/4/24
  Time: 10:26
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
    <script src="${pageContext.request.contextPath}/resources/js/coach/coachInfo.js" type="module"></script>
</head>
<script>
    const CoachId="${value}"
</script>
<body>
<div id="app">
    <el-page-header @back="goBack"
                    :content="pageHeader">
    </el-page-header>
    <el-row style="margin-bottom: 20px">
        <el-col :span="12">
            <el-card style="height: 210px; margin-right:20px">
                <el-row>
                    <el-col :span="16" style="border-right:1px solid #dcdfe6">
                        <el-row style="text-align: center">
                            <el-rate v-model="appraiseCoach" disabled text-color="#ff9900"
                                     score-template="{value}">
                            </el-rate>
                        </el-row>
                        <el-row style="text-align: center">
                            <strong style="font-size: xxx-large;color: gold">{{appraiseCoach}}</strong>
                        </el-row>
                        <el-row style="text-align: center;margin-bottom: 20px">
                            <strong style="font-size: small;color: red">{{appraiseContext}}</strong>
                        </el-row>
                    </el-col>
                    <el-col :span="8">
                        <el-row>
                            <div>
                                <el-statistic :value="countApp" title="预约次数" suffix="次"
                                              style="width: 150px;margin-left: 0">
                                </el-statistic>
                            </div>
                        </el-row>
                        <el-row>
                            <div>
                                <el-statistic :value="sumApp" title="预约时长" suffix="小时"
                                              style="width: 150px;margin-left: 0">
                                </el-statistic>
                            </div>
                        </el-row>
                    </el-col>
                </el-row>
            </el-card>
        </el-col>
        <el-col :span="12">
            <el-card style="height: 210px">
                <el-descriptions title="最近一次预约" :column="2" border>
                    <el-descriptions-item label="用户">{{recApp.user.userName}}</el-descriptions-item>
                    <el-descriptions-item label="联系电话">{{recApp.user.phone}}</el-descriptions-item>
                    <el-descriptions-item label="开始时间">{{recApp.startDate}}</el-descriptions-item>
                    <el-descriptions-item label="状态">
                        <el-tag size="small">{{recApp.appointmentState}}</el-tag>
                    </el-descriptions-item>
                </el-descriptions>
            </el-card>
        </el-col>
    </el-row>
    <el-card>
        <el-table
                :data="appmntsList"
                style="width: 100%">
            <el-table-column
                    prop="user.userName"
                    label="用户名">
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
                    prop="appraiseContext"
                    label="评价内容">
            </el-table-column>
        </el-table>
        <el-pagination
                :page-size="10"
                layout="total, prev, pager, next"
                :total="appmntsTotal"
                style="text-align: center">
        </el-pagination>
    </el-card>
</div>
</body>
</html>
