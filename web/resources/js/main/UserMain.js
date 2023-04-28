new Vue({
    el: '#app',
    mounted:async function () {
        this.loading = true;
        this.countApp= +this.getCountSome('countApp');
        this.sumApp= +this.getCountSome('sumApp');
        this.applyList=this.getApplyByUId();
        this.RecAppInU();
        this.getCSchoolAll();
        this.loading = false;
    },
    data: {
        carModel: '1',
        rNameDig:false,
        loading:false,
        countApp:'0',
        sumApp:'0',
        applyList:[],
        carSchoolList:[],
        recApp:{
            object:{
                userRname:'-',
                phone:'-'
            },
            startDate:'-',
            appointmentState:'-',
        }
    },
    methods: {
        getCountSome(object){
            let result='';
            $.ajax({
                url:'Stats/'+object+'InU',
                async:false,
                data:{
                    userId:sessionStorage.getItem("userId")
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
        },
        RecAppInU(){
            let that=this;
            $.ajax({
                url:'Stats/RecAppInU',
                async:false,
                data:{
                    userId:sessionStorage.getItem("userId")
                },
                success:function (data){
                    if(data){
                        that.recApp=data;
                    }
                },
                error:function (e) {
                    console.log(e);
                    top.location.href="error";
                }
            });
            switch (this.recApp.appointmentState){
                case '0':this.recApp.appointmentState="未开始";break;
                case '1':this.recApp.appointmentState="预约中";break;
                case '2':this.recApp.appointmentState="已结束";break;
                case '3':this.recApp.appointmentState="已评价";break;
            }
        },
        getApplyByUId(){
            let that=this;
            $.ajax({
                url:"Apply/getApplyByUId",
                data:{
                    userId:sessionStorage.getItem("userId")
                },
                success:function (data){
                    that.applyList=data;
                },
                error:function (e){
                    console.log(e);
                    window.location.href="error";
                }
            });
        },
        getCSchoolAll() {
            let that=this;
            $.ajax({
                url: "CarSchool/getCSchoolAll",
                success: function (data) {
                    that.carSchoolList=data;
                },
                error: function (e) {
                    console.log(e);
                    window.location.href="error"
                }
            });
        },
        applyStateFormatter(row, column, cellValue) {
            let Flag = '';
            switch (cellValue) {
                case "0":
                    Flag = "待审核";
                    break;
                case "1":
                    Flag = "未通过";
                    break;
                default:
                    break;
            }
            return Flag;
        },
        toAppmnts(row){
            window.location.href="show?url=appmnts/addAppmnts&value="+row.carSchoolId;
        }
    }
})
