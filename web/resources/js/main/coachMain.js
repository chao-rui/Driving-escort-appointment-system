new Vue({
    el: '#app',
    mounted:async function () {
        this.loading = true;
        await this.getApplyByUId();
        this.countApp= +this.getCountSome('countApp');
        this.sumApp= +this.getCountSome('sumApp');
        this.loading = false;
    },
    data:{
        applyList:[],
        countApp:'',
        sumApp:'',
        appraiseCarSchool:0,
        appraiseContext:''
    },
    methods: {
        async getCSchoolByUid() {
            let that = this;
            await $.ajax({
                url: "CarSchool/getCSchoolByUid",
                data: {
                    userId: sessionStorage.getItem("userId")
                },
                success: function (data) {
                    this.appraiseCarSchool=data.appraiseCarSchool;
                    if(that.appraiseCarSchool===0){
                        that.appraiseContext="刚刚起步，请开始加油吧"
                    }else if(that.appraiseCarSchool<3){
                        that.appraiseContext="找到原因，为更好的服务而奋斗吧"
                    }else{
                        that.appraiseContext="已经很优秀了，请继续保持"
                    }
                },
                error: function (e) {
                    console.log(e);
                    window.location.href = "error";
                }
            });
        },
        getApplyByUId(){
            let that=this;
            if(this.CSchoolId){
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
                });}
        },
        getCountSome(object){
            let result='';
            $.ajax({
                url:'Stats/'+object+'InCo',
                async:false,
                data:{
                    userId:sessionStorage.getItem("userId"),
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
})
