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
        <script src="${pageContext.request.contextPath}/resources/js/car/carManage.js" type="module"></script>
        <title>车辆管理</title>
    </head>
</head>
<body>
<div id="app" v-loading="loading">
    <el-card>
        <h1>车辆一览</h1>
        <el-button type="primary" @click="addCar">新增车辆</el-button>
        <el-table
                :data="carList"
                style="width: 100%">
            <el-table-column
                    prop="carNumber"
                    label="车牌号"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="carBrands"
                    label="品牌"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="carModel"
                    label="类型">
            </el-table-column>
            <el-table-column
                    prop="userRName"
                    label="所属">
            </el-table-column>
            <el-table-column
                    prop="carFlag"
                    label="状态">
            </el-table-column>
            <el-table-column
                    label="操作"
                    width="100">
                <template slot-scope="scope">
                    <el-button @click="updCar(scope.row)" type="text" size="small">编辑</el-button>
                </template>
            </el-table-column>
        </el-table>
    </el-card>
    <el-dialog
            title="车辆信息"
            :visible.sync="dialogVisible"
            width="30%">
        <el-form :model="form" ref="form" id="form" METHOD="post" :rules="rules">
            <div>

                <el-form-item label="车牌号" prop="carNumber" label-width="80px">
                    <el-input v-model="form.carNumber" maxlength="7"></el-input>
                </el-form-item>

                <el-form-item label="品牌" prop="carBrands" label-width="80px">
                    <el-input v-model="form.carBrands" maxlength="10"></el-input>
                </el-form-item>

                <el-form-item label="类型" prop="carModel" label-width="80px">
                    <el-select v-model="form.carModel" filterable placeholder="请选择" style="width: 100%">
                        <el-option
                                v-for="item in carModelList"
                                :key="item.carModel"
                                :label="item.label"
                                :value="item.carModel">
                        </el-option>
                    </el-select>
                </el-form-item>

                <el-form-item label="所属" prop="userId" label-width="80px">
                    <el-select v-model="form.userId" filterable placeholder="请选择" style="width: 100%">
                        <el-option
                                v-for="item in coachList"
                                :key="item.user.userId"
                                :label="item.user.userRname"
                                :value="item.userId">
                        </el-option>
                    </el-select>
                </el-form-item>

                <el-form-item label="状态" prop="carFlag" label-width="80px">
                    <el-select v-model="form.carFlag" filterable placeholder="请选择" style="width: 100%">
                        <el-option
                                v-for="item in carFlagList"
                                :key="item.carFlag"
                                :label="item.label"
                                :value="item.carFlag">
                        </el-option>
                    </el-select>
                </el-form-item>

                <span slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="save">提交</el-button>
                    <el-button @click="dialogVisible = false">取 消</el-button>
                </span>

            </div>
        </el-form>
    </el-dialog>
</div>
</body>
</html>
