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
    <el-row style="margin-bottom: 10px;height: 360px">
        <el-col :span="16">
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
                            prop="applyState"
                            label="状态"
                            width="180px">
                    </el-table-column>
                </el-table>
            </el-card>
        </el-col>
        <el-col :span="8">
            <el-card style="height: 360px">
                <el-row style="text-align: center">
                    <el-rate v-model="form.appraiseCarSchool" disabled text-color="#ff9900" score-template="{value}"></el-rate>
                </el-row>
                <el-row style="text-align: center">
                    <strong style="font-size: xxx-large;color: gold">{{form.appraiseCarSchool}}</strong>
                </el-row>
                <el-row style="text-align: center;margin-bottom: 5px">
                    <strong style="font-size: small;color: red">{{form.appraiseContext}}</strong>
                </el-row>
                <el-row>

                </el-row>
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
             width="30%">
        <span>请选择车辆类型</span>
        <el-radio-group v-model="carModel">
            <el-radio label="1" border>手动挡</el-radio>
            <el-radio label="2" border>自动挡</el-radio>
        </el-radio-group>
        <span slot="footer" class="dialog-footer">
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
                        :picker-options="pickerOptions">
                </el-date-picker>
            </el-form-item>

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
