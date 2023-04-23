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
        loading:false,
        carList:[]
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
        }
    }
});