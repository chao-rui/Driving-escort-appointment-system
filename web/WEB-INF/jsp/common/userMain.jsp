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
    <script src="${pageContext.request.contextPath}/resources/js/common/UserMain.js" type="module"></script>
    <title>首页</title>
</head>
<body>
<div id="app" v-loading="loading">
    <el-card>
        <el-table
                :data="coachList"
                style="width: 100%">
            <el-table-column
                    prop="workId"
                    label="工号"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="user.userRname"
                    label="姓名"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="user.phone"
                    label="联系方式">
            </el-table-column>
            <el-table-column
                    prop="appraiseCoach"
                    label="评价">
            </el-table-column>
            <el-table-column
                    label="操作"
                    width="100">
                <template slot-scope="scope">
                    <el-button @click="addAppmnts(scope.row)" type="text" size="small">预约</el-button>
                </template>
            </el-table-column>
        </el-table>
    </el-card>
    <el-dialog
            title="提示"
            :visible.sync="dialogVisible"
             width="30%"
            @closed="getCoachByModel">
        <span>请选择车辆类型</span>
        <el-radio-group v-model="carModel">
            <el-radio label="1" border>手动挡</el-radio>
            <el-radio label="2" border>自动挡</el-radio>
        </el-radio-group>
        <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
        </span>
    </el-dialog>
</div>
</body>
</html>
