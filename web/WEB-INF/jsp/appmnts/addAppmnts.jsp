<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/4/27
  Time: 18:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String cSchool = (String) request.getAttribute("value"); %>
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
    <script src="${pageContext.request.contextPath}/resources/js/appmnts/addAppmnts.js" type="module"></script>
</head>
<script>
    const cSchoolId="${value}"
</script>
<body>
<div id="app" v-loading="loading">
    <el-page-header @back="goBack"
                    :content="pageHeader">
    </el-page-header>
    <el-carousel :interval="4000" type="card" height="200px">
        <el-carousel-item v-for="item in photos" :key="item.name">
            <el-image :src="item.url" ></el-image>
        </el-carousel-item>
    </el-carousel>
    <el-row style="margin-bottom: 10px;height: 360px">
        <el-col :span="16">
            <el-card style="margin-right: 10px;height: 360px">
                <el-form :model="cSchool" disabled>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="驾校名称" prop="carSchoolName" style="width: 90%">
                                <el-input v-model="cSchool.carSchoolName" maxlength="20"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="联系方式" prop="carSchoolPhone">
                                <el-input v-model="cSchool.carSchoolPhone" maxlength="11"></el-input>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-form-item label="驾校地址" prop="carSchoolAdders">
                        <el-input v-model="cSchool.carSchoolAdders" maxlength="20"></el-input>
                    </el-form-item>


                    <el-form-item label="驾校简介" prop="carSchoolDesc">
                        <el-input type="textarea" show-word-limit v-model="cSchool.carSchoolDesc"
                                  maxlength="200"></el-input>
                    </el-form-item>
                </el-form>
            </el-card>
        </el-col>
        <el-col :span="8">
            <el-card style="height: 360px">
                <el-row style="text-align: center">
                    <el-rate v-model="cSchool.appraiseCarSchool" disabled text-color="#ff9900"
                             score-template="{value}"></el-rate>
                </el-row>
                <el-row style="text-align: center">
                    <strong style="font-size: xxx-large;color: gold">{{cSchool.appraiseCarSchool}}</strong>
                </el-row>
                <el-row style="text-align: center;margin-bottom: 5px">
                    <strong style="font-size: small;color: red">{{cSchool.appraiseContext}}</strong>
                </el-row>
                <el-row>
                    <el-col :span="12">
                        <div>
                            <el-statistic :value="countCoach" title="员工数量" suffix="人"></el-statistic>
                        </div>
                    </el-col>
                    <el-col :span="12">
                        <div>
                            <el-statistic :value="countCar" title="车辆数量" suffix="辆"></el-statistic>
                        </div>
                    </el-col>
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
                @expand-change="getCoachInfo"
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
                    prop="price"
                    label="单价（每小时）">
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
            <el-table-column type="expand">
                <template slot-scope="props" style="background-color: #ecf8ff">
                    <el-row>
                        <el-col :span="3">
                            <el-image :src="coachPhoto.url" style="width: 100px; height: 100px"></el-image>
                        </el-col>
                        <br :span="21">
                            {{props.row.user.userRname}}, {{props.row.user.gender}},生于{{props.row.user.birthYear}}。</br>
                            评价：{{props.row.context}}
                        </el-col>
                    </el-row>
                    <el-divider></el-divider>
                    <el-row :gutter="20" v-for="(appmnts,index) in appmntsList" :key="index">
                        <el-col :span="12">
                            <div>
                                来自用户
                                <strong style="color: red">{{appmnts.user.userName}}</strong>的
                                <strong style="color: red">{{appmnts.appraise}}</strong>星评价：
                                <strong>{{appmnts.appraiseContext}}</strong>
                            </div>
                        </el-col>
                        <el-col :span="6" :offset="6"><div>{{appmnts.endDate}}</div></el-col>
                    </el-row>
                </template>
            </el-table-column>
        </el-table>
    </el-card>
    <el-dialog
            title="提示"
            :visible.sync="carModelDig"
            :before-close="getCoachByModel"
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
        <el-form :model="form" METHOD="post" label-width="80px" ref="form" :rules="rules">

            <el-form-item label="日期" prop="date">
                <el-date-picker
                        v-model="form.date"
                        type="date"
                        placeholder="选择日期"
                        @change="getFreeRange"
                        :picker-options="pickerOptions">
                </el-date-picker>
            </el-form-item>

            <el-form-item label="开始时间" prop="startDate">
                <el-select v-model="form.startDate" clearable
                           style="width: 220px" placeholder="开始时间"
                           @change="updTime(0)">
                    <template #prefix>
                        <i class="el-input__icon el-icon-time"></i>
                    </template>
                    <el-option
                            v-for="item in sFreeRange"
                            :key="item.index"
                            :label="item.time"
                            :value="item.time"
                            :disabled="item.disabled">
                    </el-option>
                </el-select>
            </el-form-item>

            <el-form-item label="结束时间" prop="endDate">
                <el-select v-model="form.endDate" clearable
                           style="width: 220px" placeholder="结束时间"
                           @change="updTime(1)">
                    <template #prefix>
                        <i class="el-input__icon el-icon-time"></i>
                    </template>
                    <el-option
                            v-for="item in eFreeRange"
                            :key="item.index"
                            :label="item.time"
                            :value="item.time"
                            :disabled="item.disabled">
                    </el-option>
                </el-select>
            </el-form-item>

            <el-form-item label="时长">
                <el-input v-model="form.time" :disabled="true" style="width: 220px">
                    <template slot="append">小时</template>
                </el-input>
            </el-form-item>

            <el-form-item label="总价">
                ￥<strong style="font-size: 40px;color: red">{{total}}</strong>
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
