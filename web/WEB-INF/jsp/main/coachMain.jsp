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
    <title>Title</title>
</head>
<body>
<div id="app">
    <el-row>
        <el-col span="12">
            <el-card>
                <el-row style="text-align: center">
                    <el-rate v-model="form.appraiseCarSchool" disabled text-color="#ff9900"
                             score-template="{value}">
                    </el-rate>
                </el-row>
                <el-row style="text-align: center">
                    <strong style="font-size: xxx-large;color: gold">{{form.appraiseCarSchool}}</strong>
                </el-row>
                <el-row style="text-align: center;margin-bottom: 45px">
                    <strong style="font-size: small;color: red">{{form.appraiseContext}}</strong>
                </el-row>
                <el-row>
                    <el-col :span="12">
                        <div>
                            <el-statistic :value="value1" title="预约次数" suffix="次"></el-statistic>
                        </div>
                    </el-col>
                    <el-col :span="12">
                        <div>
                            <el-statistic :value="value2" title="预约时长" suffix="小时"></el-statistic>
                        </div>
                    </el-col>
                </el-row>
            </el-card>
        </el-col>
        <el-col span="12">
            <el-descriptions title="最近预约">
                <el-descriptions-item label="姓名">kooriookami</el-descriptions-item>
                <el-descriptions-item label="手机号">18100000000</el-descriptions-item>
                <el-descriptions-item label="居住地">苏州市</el-descriptions-item>
                <el-descriptions-item label="备注">
                    <el-tag size="small">学校</el-tag>
                </el-descriptions-item>
                <el-descriptions-item label="联系地址">江苏省苏州市吴中区吴中大道 1188 号</el-descriptions-item>
            </el-descriptions>
        </el-col>
    </el-row>
</div>
</body>
</html>
