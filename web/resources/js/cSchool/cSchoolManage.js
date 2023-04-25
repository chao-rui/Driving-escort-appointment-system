new Vue({
    el:"#app",
    mounted:async function () {
        this.loading = true;
        await this.getCSchoolByUid();
        await this.getCoachByCSId();
        this.countCoach= +this.getCountSome('countCoach');
        this.countCar= +this.getCountSome('countCar');
        this.countApp= +this.getCountSome('countApp');
        this.sumApp= +this.getCountSome('sumApp');
        this.loading = false;
    },
    data:{
        loading:false,
        countCoach:'',
        countCar:'',
        countApp:'',
        sumApp:'',
        form:{
            carSchoolId:'',
            carSchoolName:'',
            carSchoolAdders:'',
            carSchoolPhone:'',
            carSchoolDesc:'',
            appraiseCarSchool:0,
            appraiseContext:''
        },
        rules:{
            cSchoolName: [
                {required: true, message: '请输入驾校名称', trigger: 'blur'},
                {max: 10, message: '驾校名称长度不能超过10位', trigger: 'blur'}
            ],
            cSchoolAdders: [
                {required: true, message: '请输入驾校地址', trigger: 'blur'},
                {max: 20, message: '驾校地址长度不能超过20位', trigger: 'blur'}
            ],
            cSchoolPhone: [
                {required: true, message: '请输入手机号码', trigger: 'blur'},
                {pattern: /^1\d{10}$/, message: '手机号码必须是11位数字', trigger: 'blur'}
            ],
            cSchoolDesc: [
                {required: true, message: '请输入驾校简介', trigger: 'blur'},
                {max: 10, message: '用户名长度不能超过200字', trigger: 'blur'}
            ],
        },
        coachList:[]
    },
    methods:{
        async getCSchoolByUid() {
            let that = this;
            await $.ajax({
                url: "CarSchool/getCSchoolByUid",
                data: {
                    userId: sessionStorage.getItem("userId")
                },
                success: function (data) {
                    that.form = data;
                    if(that.form.appraiseCarSchool===0){
                        that.form.appraiseContext="刚刚起步，请开始加油吧"
                    }else if(that.form.appraiseCarSchool<3){
                        that.form.appraiseContext="找到原因，为更好的服务而奋斗吧"
                    }else{
                        that.form.appraiseContext="已经很优秀了，请继续保持"
                    }
                },
                error: function (e) {
                    console.log(e);
                    window.location.href = "error";
                }
            });
        },
        save(){
            let that=this;
            $.ajax({
                url:"CarSchool/updCSchool",
                data:{
                    cSchoolId:that.form.carSchoolId,
                    cSchoolName: that.form.carSchoolName,
                    cSchoolAdders: that.form.carSchoolAdders,
                    cSchoolDesc: that.form.carSchoolDesc,
                    cSchoolPhone: that.form.carSchoolPhone,
                    updDate:new Date()
                },
                success:function (data){
                    if (data) {
                        that.$notify({
                            title: '成功',
                            message: '更新成功',
                            type: 'success'
                        });
                    } else {
                        that.$notify({
                            title: '警告',
                            message: '更新失败,请重试',
                            type: 'warning'
                        });
                    }
                },
                error:function (e) {
                    that.$notify({
                        title: '失败',
                        message: '更新失败,错误信息' + e,
                        type: 'error'
                    });
                }
            });
        },
        getCoachByCSId(){
            let that=this;
            $.ajax({
                url:"Coach/getCoachByCSId",
                data:{
                    cSchoolId:that.form.carSchoolId
                },
                success:function (data){
                    that.coachList=data;
                },
                error:function (e) {
                    console.log(e);
                    window.location.href="error";
                }
            });
        },
        getCountSome(object){
            let result='';
            $.ajax({
                url:'Stats/'+object+'InCS',
                async:false,
                data:{
                    cSchoolId:this.form.carSchoolId,
                },
                success:function (data){
                    result=data;
                },
                error:function (e) {
                    console.log(e);
                    top.location.href="error";
                }
            });
            return result;
        }
    }
});