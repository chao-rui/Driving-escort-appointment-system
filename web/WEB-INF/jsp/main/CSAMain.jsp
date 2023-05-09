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
    <script src="${pageContext.request.contextPath}/resources/js/main/CSAMain.js" type="module"></script>
    <title>首页</title>
</head>
<body>
<div id="app">
    <el-row style="margin-bottom: 20px">
        <el-col :span="14">
            <el-card style="margin-right: 20px;height: 350px">
                <el-table
                        :data="applyList"
                        style="height: 210px">
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
                            width="150">
                    </el-table-column>
                    <el-table-column
                            label="操作"
                            width="200">
                        <template slot-scope="scope">
                            <el-button @click="updApply(scope.row,1)" type="success">通过</el-button>
                            <el-button @click="updApply(scope.row,0)" type="danger">拒绝</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-card>
        </el-col>
        <el-col :span="10">
            <el-card>
            <el-row style="text-align: center">
                <el-rate v-model="appraiseCarSchool"
                             disabled
                             text-color="#ff9900"
                             score-template="{value}">
                </el-rate>
            </el-row>
            <el-row style="text-align: center">
                <strong style="font-size: xxx-large;color: gold">
                    {{appraiseCarSchool}}
                </strong>
            </el-row>
            <el-row style="text-align: center">
                <strong style="font-size: small;color: red">
                    {{appraiseContext}}
                </strong>
            </el-row>
            <el-row>
                <el-col :span="12">
                    <el-statistic :value="countCoach" title="员工数量" suffix="人"></el-statistic>
                </el-col>
                <el-col :span="12">
                    <el-statistic :value="countCar" title="车辆数量" suffix="辆"></el-statistic>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="12">
                    <el-statistic :value="countApp" title="预约次数" suffix="次"></el-statistic>
                </el-col>
                <el-col :span="12">
                    <el-statistic :value="sumApp" title="预约时长" suffix="小时"></el-statistic>
                </el-col>
            </el-row>
            </el-card>
        </el-col>
    </el-row>
    <el-card style="width: 100%">
        <el-table
                :data="appmntsList">
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
    </el-card>
</div>
</body>
</html>
