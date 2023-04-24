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
                    <el-button @click="getAppmnts(scope.row)" type="text" size="small" v-if="isCoach">查看</el-button>
                    <el-button @click="updAppmnts(scope.row)" type="text" size="small" v-if="isUser">修改</el-button>
                    <el-button @click="updAppraise(scope.row)" type="text" size="small">评价</el-button>
                </template>
            </el-table-column>
        </el-table>
    </el-card>
    <el-dialog
            title="预约"
            :visible.sync="appmntsDig"
            width="30%">
        <el-form :model="form" METHOD="post" label-width="80px">

            <el-form-item label="开始时间">
                <el-time-select
                        placeholder="开始时间"
                        v-model="form.startDate"
                        @change="updTime"
                        :picker-options="{start: '08:30',step: '00:15',end: '18:30',maxTime:form.endDate}">
                </el-time-select>
            </el-form-item>

            <el-form-item label="结束时间">
                <el-time-select
                        placeholder="结束时间"
                        v-model="form.endDate"
                        @change="updTime"
                        :picker-options="{start: '08:30',step: '00:15',end: '18:30',minTime: form.startDate}">
                </el-time-select>
            </el-form-item>

            <el-form-item label="状态">
            <el-select v-model="form.appmntsState" placeholder="请选择">
                <el-option
                        v-for="item in appmntsStateList"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value">
                </el-option>
            </el-select>
            </el-form-item>

        </el-form>
        <span slot="footer" class="dialog-footer">
        <el-button @click="appmntsDig = false">取 消</el-button>
        <el-button type="primary" @click="appmntsDig = false">提交</el-button>
        </span>
    </el-dialog>
</div>
</body>
</html>

