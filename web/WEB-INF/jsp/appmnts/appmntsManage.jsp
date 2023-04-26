<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.User" %><%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/4/17
  Time: 9:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%User user = (User) request.getSession().getAttribute("user");%>
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
            <c:if test="${user.getRoleFlag()== 3}">
            <el-table-column
                    prop="user.userRname"
                    label="用户"
                    :formatter="userRNameFormatter">
            </el-table-column>
            <el-table-column
                    prop="user.phone"
                    label="联系方式">
            </el-table-column>
            </c:if>
            <c:if test="${user.getRoleFlag()== 2}">
            <el-table-column
                    prop="object.userRname"
                    label="教练">
            </el-table-column>
            <el-table-column
                    prop="object.phone"
                    label="教练">
            </el-table-column>
            </c:if>
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
        <c:if test="${user.getRoleFlag()== 2}">
            <el-table-column
                    label="操作"
                    width="100">
                <template slot-scope="scope">
                    <el-button @click="openAppmntsDlg(scope.row)" type="text" size="small">
                        修改</el-button>
                    <el-button @click="openAppraiseDlg(scope.row)" type="text" size="small">
                        评价</el-button>
                </template>
            </el-table-column>
        </c:if>
        </el-table>
    </el-card>
    <el-dialog
            title="预约"
            :visible.sync="appmntsDlg"
            width="30%">
        <el-form :model="form" METHOD="post" label-width="80px">

            <el-form-item label="日期">
                <el-date-picker
                        :disabled="isOutDate"
                        v-model="form.date"
                        type="date"
                        placeholder="选择日期"
                        @change="getFreeRange"
                        :picker-options="pickerOptions">
                </el-date-picker>
            </el-form-item>

            <el-form-item label="开始时间">
                <el-time-select
                        :disabled="isOutDate"
                        placeholder="开始时间"
                        v-model="form.startDate"
                        @change="updTime"
                        :picker-options="{start: '08:00',end: '18:00',maxTime:form.maxTime}">
                </el-time-select>
            </el-form-item>

            <el-form-item label="结束时间">
                <el-time-select
                        disabled
                        placeholder="结束时间"
                        v-model="form.endDate"
                        @change="updTime"
                        :picker-options="{start: '08:00',end: '18:00',minTime: form.startDate}">
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
        <el-button @click="appmntsDlg = false">取 消</el-button>
        <el-button type="primary" @click="updAppmnts">提交</el-button>
        </span>
    </el-dialog>
    <el-dialog
            title="评价"
            :visible.sync="appraiseDlg"
            width="30%">
        <el-form :model="appraise" ref="appraise" :rules="rules">
            <el-form-item prop="value">
                <el-rate v-model="appraise.value" show-text></el-rate>
            </el-form-item>
            <el-form-item prop="context" label="评价内容">
                <el-input type="textarea" maxlength="200" v-model="appraise.context"></el-input>
            </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
        <el-button @click="appraiseDlg = false">取 消</el-button>
        <el-button type="primary" @click="updAppraise">提交</el-button>
        </span>
    </el-dialog>
</div>
</body>
</html>

