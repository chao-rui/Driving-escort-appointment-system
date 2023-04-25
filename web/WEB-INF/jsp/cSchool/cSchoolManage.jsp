<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/4/17
  Time: 9:17
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
    <script src="${pageContext.request.contextPath}/resources/js/cSchool/cSchoolManage.js" type="module"></script>
    <title>驾校管理</title>
</head>
<body>
<div id="app" v-loading="loading">
    <el-row style="margin-bottom: 10px;height: 360px">
        <el-col :span="16">
            <el-card style="margin-right: 10px">
                <el-form :model="form" ref="form" id="form" METHOD="post" :rules="rules">
                    <el-form-item label="驾校名称" prop="carSchoolName" label-width="80px">
                        <el-input v-model="form.carSchoolName" maxlength="20"></el-input>
                    </el-form-item>

                    <el-form-item label="联系方式" prop="carSchoolPhone" label-width="80px">
                        <el-input v-model="form.carSchoolPhone" maxlength="11"></el-input>
                    </el-form-item>

                    <el-form-item label="驾校地址" prop="carSchoolAdders" label-width="80px">
                        <el-input v-model="form.carSchoolAdders" maxlength="20"></el-input>
                    </el-form-item>


                    <el-form-item label="驾校简介" prop="carSchoolDesc" label-width="80px">
                        <el-input type="textarea" show-word-limit v-model="form.carSchoolDesc"
                                  maxlength="200"></el-input>
                    </el-form-item>

                    <el-button type="primary" @click="save">更新</el-button>

                </el-form>
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
        <h1>员工一览</h1>
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
                    <el-button @click="delCoach(scope.row)" type="text" size="small">查看</el-button>
                </template>
            </el-table-column>
        </el-table>
    </el-card>
</div>
</body>
</html>
