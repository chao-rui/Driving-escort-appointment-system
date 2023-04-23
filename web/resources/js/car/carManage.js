new Vue({
    el:"#app",
    mounted:async function () {
        this.loading = true;
        await this.getCSchoolByUid();
        await this.getCarByCSId();
        this.loading = false;
    },
    data:{
        CSchoolId:'',
        dialogVisible: false,
        loading:false,
        carList:[],
        form:{
            carNumber:'',
            carBrands:'',
            carModel:'',
            userId:'',
            carFlag:'',
        },
        rules:{
            carNumber: [
                {required: true, message: '请输入车牌号', trigger: 'blur'},
                {max: 7, message: '车牌号名称长度不能超过10位', trigger: 'blur'}
            ],
            carBrands: [
                {required: true, message: '请输入品牌', trigger: 'blur'},
                {max: 10, message: '品牌长度不能超过10位', trigger: 'blur'}
            ],
            carModel: [
                {required: true, message: '请选择车辆类型', trigger: 'blur'},
            ],
            carFlag: [
                {required: true, message: '请选择车辆状态', trigger: 'blur'},
            ],
        },
        carModelList:[{
            carModel:"1",
            label:"手动挡"
        },{
            carModel:"2",
            label:"自动挡"
        }],
        carFlagList:[{
            carFlag: "0",
            label:"未分配"
        },{
            carFlag: "1",
            label:"正常"
        },{
            carFlag: "2",
            label:"预约中"
        },{
            carFlag: "3",
            label:"维修中"
        },{
            carFlag: "4",
            label:"报废"
        }],
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
                    that.CSchoolId=data.carSchoolId;
                },
                error: function (e) {
                    console.log(e);
                    window.location.href = "error";
                }
            });
        },
        getCarByCSId(){
            let that=this;
            $.ajax({
                url:"Car/getCarByCS",
                data:{
                    cSchoolId:that.CSchoolId
                },
                success:function (data){
                    that.carList=data;
                },
                error:function (e){
                    console.log(e);
                    window.location.href="error";
                }
            });
        },
        getCoachByCSId() {
            let that=this;
            $.ajax({
                url:"Coach/getCoachByCSId",
                data:{
                    cSchoolId:that.CSchoolId
                },
                success:function (data){
                    that.coachList=data;
                    console.log(data);
                },
                error:function (e) {
                    console.log(e);
                    window.location.href="error";
                }
            });
        },
        addCar(){
            this.dialogVisible=true;
            this.getCoachByCSId();
        },
        save(){

        }
    }
});