new Vue({
    el: '#app',
    mounted:function (){
        this.getCSchoolAll();
    },
    data:{
        CSchoolInfo:[{carSchoolId: '0', carSchoolName: '测试'}],
        tabName:"first",
        formCoach: {
            workId: '',
            CSchoolId: '',
        },
        formCSA:{
            CSchoolName:'',
            key:''
        },
        formCS:{
            CSchoolAdder:'',
            CSchoolPhone:'',
            updDate: ''
        },
        loading: false,
        dialogVisible:false,
        rulesCoach: {
            workId: [
                {required: true, message: '请输入工号', trigger: 'blur'},
                {max: 10, message: '工号长度不能超过10位', trigger: 'blur'}
            ],
            CSchoolId: [
                {required: true, message: '请选择所属驾校', trigger: 'blur'},
            ],
        },
        rulesCSA:{
            CSchoolName: [
                {required: true, message: '请输入驾校名称', trigger: 'blur'},
                {max: 10, message: '工号长度不能超过10位', trigger: 'blur'}
            ],
            key: [
                {required: true, message: '请输入邀请码', trigger: 'blur'},
            ]
        },
        rulesCS:{
            CSchoolAdder:[
                {required: true, message: '请输入驾校地址', trigger: 'blur'},
                {max: 40, message: '地址长度不能超过40字', trigger: 'blur'}
            ],
            CSchoolPhone:[
                {required: true, message: '请输入手机号码', trigger: 'blur'},
                {pattern: /^1\d{10}$/, message: '手机号码必须是11位数字', trigger: 'blur'}
            ]
        }
    },
    methods: {
        getCSchoolAll() {
            let that=this;
            $.ajax({
                url: "CarSchool/getCSchoolAll",
                success: function (data) {
                    that.CSchoolInfo=data;
                },
                error: function (e) {
                    console.log(e);
                    window.location.href="error"
                }
            });
        },
        saveCoach(){
            let that= this;
            this.$refs.formCoach.validate(valid => {
                if (valid) {
                    that.loading=true;
                    $.ajax({
                        url: "Coach/addCoach",
                        data: {
                            workId: this.formCoach.workId,
                            carSchoolId: this.formCoach.CSchoolId,
                            userId: sessionStorage.getItem("userId")
                        },
                        success: function (data) {
                            that.$notify({
                                title: '成功',
                                message: '更新成功',
                                type: 'success'
                            });
                            top.location.href="index";
                        },
                        error: function (e) {
                            that.$notify({
                                title: '失败',
                                message: '更新失败,错误信息' + e,
                                type: 'error'
                            });
                        }
                    });
                    that.loading= false;
                } else {
                    return false;
                }
            });
        },
        saveCSA(){
            let that= this;
            this.$refs.formCSA.validate(valid => {
                if (valid) {
                    that.dialogVisible = true;
                } else {
                    return false;
                }
            });
        },
        saveCS(){
            let that=this;
            this.$refs.formCS.validate(valid=>{
                if(valid){
                    that.loading=true;
                    $.ajax({
                        url: "CarSchool/addCSchool",
                        data: {
                            cSchoolAdmin:sessionStorage.getItem("userId"),
                            cSchoolName:that.formCSA.CSchoolName,
                            cSchoolAdders:that.formCS.CSchoolAdder,
                            cSchoolPhone:that.formCS.CSchoolPhone,
                            appraiseCS:0,
                            updDate:new Date(),
                        },
                        success: function (data) {
                            that.$notify({
                                title: '成功',
                                message: '更新成功',
                                type: 'success'
                            });
                            top.location.href="index";
                        },
                        error: function (e) {
                            that.$notify({
                                title: '失败',
                                message: '更新失败,错误信息' + e,
                                type: 'error'
                            });
                        }
                    });
                    that.loading= false;
                }else{
                    return false;
                }
            });
        }
    }
})
