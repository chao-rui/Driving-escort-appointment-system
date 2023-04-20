new Vue({
    el:"#app",
    mounted:async function () {
        this.loading = true;
        await this.getCSchoolByUid();
        await this.getCoachByCSId();
        this.loading = false;
    },
    data:{
        rate:0,
        loading:false,
        form:{
            carSchoolId:'',
            carSchoolName:'',
            carSchoolAdders:'',
            carSchoolPhone:'',
            carSchoolDesc:'',
            appraiseCarSchool:0
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
                    that.rate = data.appraiseCarSchool;
                    that.form = data;
                },
                error: function (e) {
                    console.log(e);
                    window.location.href = "error";
                }
            });
        },
        save(){

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
        delCoach(){

        }
    }
});