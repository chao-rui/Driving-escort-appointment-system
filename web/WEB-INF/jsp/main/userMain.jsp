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
                            prop="user.userRname"
                            label="姓名">
                    </el-table-column>
                    <el-table-column
                            prop="updateDate"
                            label="申请时间"
                            width="100px">
                    </el-table-column>

                    <el-table-column
                            prop="applyState"
                            label="状态"
                            width="180px">
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
                    <el-button @click="doAppmnts(scope.row)" type="text" size="small">预约</el-button>
                </template>
            </el-table-column>
        </el-table>
    </el-card>
    <el-dialog
            title="提示"
            :visible.sync="carModelDig"
            width="30%"
            center>
        <span>请选择车辆类型</span>
        <el-radio-group v-model="carModel" style="margin-top: 10px;text-align: center;width: 100%">
            <el-radio label="1" border style="width: 100px;height: 100px">手动挡</el-radio>
            <el-radio label="2" border style="width: 100px;height: 100px">自动挡</el-radio>
        </el-radio-group>
        <span slot="footer" class="dialog-footer">
            <el-checkbox v-model="checked" style="margin-right: 40px">设为默认</el-checkbox>
            <el-button type="primary" @click="getCoachByModel">确 定</el-button>
        </span>
    </el-dialog>
    <el-dialog
            title="预约"
            :visible.sync="appmntsDig"
            width="30%"
            @closed="getCoachByModel">
        <el-form :model="form" METHOD="post" label-width="80px">

            <el-form-item label="日期">
                <el-date-picker
                        v-model="form.date"
                        type="date"
                        placeholder="选择日期"
                        @change="getFreeRange"
                        :picker-options="pickerOptions">
                </el-date-picker>
            </el-form-item>

            <el-form-item label="开始时间">
<%--                <el-time-select--%>
<%--                        placeholder="开始时间"--%>
<%--                        v-model="form.startDate"--%>
<%--                        format="HH:mm"--%>
<%--                        @change="updTime"--%>
<%--                        :picker-options="{start: '08:00',end: '18:00',maxTime:form.endDate}">--%>
<%--                </el-time-select>--%>
                <el-select v-model="form.startDate" clearable
                           style="width: 220px" placeholder="开始时间"
                           @change="updTime">
                    <template #prefix>
                        <i class="el-input__icon el-icon-time"></i>
                    </template>
                    <el-option
                            v-for="item in freeRange"
                            :key="item.index"
                            :label="item.time"
                            :value="item.time">
                    </el-option>
                </el-select>
            </el-form-item>

            <el-form-item label="结束时间">
<%--                <el-time-select--%>
<%--                        placeholder="结束时间"--%>
<%--                        v-model="form.endDate"--%>
<%--                        @change="updTime"--%>
<%--                        :picker-options="{start: '08:00',end: '18:00',minTime: form.startDate}">--%>
<%--                </el-time-select>--%>
                <el-select v-model="form.endDate" clearable
                           style="width: 220px" placeholder="结束时间"
                           @change="updTime">
                    <template #prefix>
                        <i class="el-input__icon el-icon-time"></i>
                    </template>
                    <el-option
                            v-for="item in freeRange"
                            :key="item.index"
                            :label="item.time"
                            :value="item.time">
                    </el-option>
                </el-select>
            </el-form-item>

            <el-form-item label="时长">
                <el-input v-model="form.time" :disabled="true" style="width: 220px">
                    <template slot="append">小时</template>
                </el-input>
            </el-form-item>

        </el-form>
        <span slot="footer" class="dialog-footer">
        <el-button @click="appmntsDig = false">取 消</el-button>
        <el-button type="primary" @click="addAppmnts">提交</el-button>
        </span>
    </el-dialog>
</div>
</body>
</html>
