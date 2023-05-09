<%--
  Created by IntelliJ IDEA.
  User: wangrongchao
  Date: 2023/4/17
  Time: 9:12
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/centerCard.css">
    <script src="${pageContext.request.contextPath}/resources/js/plugins/jquery-3.6.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins/vue.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins/element-ui.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/user/updWorkInfo.js" type="module"></script>
    <title>身份认证</title>
</head>
<body>
<div id="app" v-loading="loading">
    <el-card class="box-card">
        <el-tabs v-model="tabName">
            <el-tab-pane label="教练" name="first" :disabled="isApply">
                <el-form :model="formCoach" ref="formCoach" id="formCoach"  :rules="rulesCoach" label-width="80px" :disabled="isApply">
                    <div>
                        <h1>身份认证</h1>

                        <el-form-item label="工号" prop="workId">
                            <el-input v-model="formCoach.workId" maxlength="10"></el-input>
                        </el-form-item>

                        <el-form-item label="所属驾校" prop="CSchoolId">
                            <el-select v-model="formCoach.CSchoolId" filterable placeholder="请选择" style="width: 100%">
                                <el-option
                                        v-for="item in CSchoolInfo"
                                        :key="item.carSchoolId"
                                        :label="item.carSchoolName"
                                        :value="item.carSchoolId">
                                </el-option>
                            </el-select>
                        </el-form-item>

                        <el-form-item label="照片" prop="photo" label-width="80px" style="text-align: start">
                            <el-upload
                                    ref="photo"
                                    action="Photo/addPhoto"
                                    multiple
                                    list-type="picture-card"
                                    :file-list="formCoach.photos"
                                    :data="uploadData"
                                    :on-preview="handlePictureCardPreview"
                                    :auto-upload="false"
                                    :on-change="limited"
                                    :on-remove="remove"
                                    :class="{hide:limitedFlg}"
                                    :limit="1">
                                <i class="el-icon-plus"
                                   style="height:100%;
                                  display: flex;
                                  justify-content: center;
                                  align-items: center;"></i>
                                <div slot="tip" class="el-upload__tip">请上传个人证件照</div>
                            </el-upload>
                            <el-dialog :visible.sync="photoDlg" append-to-body>
                                <img width="100%" :src="photoDlgUrl" alt="">
                            </el-dialog>
                        </el-form-item>

                        <el-button type="primary" @click="saveCoach">{{applyState}}</el-button>

                    </div>
                </el-form>
            </el-tab-pane>
            <el-tab-pane label="驾校管理员" name="second" :disabled="isApply">
                <el-form :model="formCSA" ref="formCSA" id="formCSA"  :rules="rulesCSA" label-width="80px" :disabled="isApply">
                    <div>
                        <h1>身份认证</h1>

                        <el-form-item label="驾校名称" prop="CSchoolName">
                            <el-input v-model="formCSA.CSchoolName" maxlength="10"></el-input>
                        </el-form-item>

                        <el-form-item label="邀请码" prop="key">
                            <el-input v-model="formCSA.key"  maxlength="18"></el-input>
                        </el-form-item>

                        <el-button type="primary" @click="saveCSA">开始认证</el-button>

                    </div>
                </el-form>
            </el-tab-pane>
        </el-tabs>
    </el-card>
    <el-dialog
            title="补充信息"
            :visible.sync="dialogVisible"
            width="30%">
        <el-form :model="formCS" ref="formCS" id="formCS" METHOD="post" :rules="rulesCS">
            <div>
                <h1>驾校信息补充</h1>

                <el-form-item label="驾校地址" prop="CSchoolAdder">
                    <el-input v-model="formCS.CSchoolAdder" maxlength="40"></el-input>
                </el-form-item>

                <el-form-item label="联系方式" prop="CSchoolPhone">
                    <el-input v-model="formCS.CSchoolPhone"  maxlength="11"></el-input>
                </el-form-item>

                <span slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="saveCS">提交</el-button>
                    <el-button @click="dialogVisible = false">取 消</el-button>
                </span>

            </div>
        </el-form>
    </el-dialog>
</div>
</body>
</html>
