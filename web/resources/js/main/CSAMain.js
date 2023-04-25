new Vue({
    el: '#app',
    mounted:async function () {
        this.loading = true;
        await this.getCSchoolByUid();
        await this.getApplyByCSId();
        this.countCoach= +this.getCountSome('countCoach');
        this.countCar= +this.getCountSome('countCar');
        this.countApp= +this.getCountSome('countApp');
        this.sumApp= +this.getCountSome('sumApp');
        this.loading = false;
    },
    data:{
        CSchoolId:'',
        applyList:[],
        countCoach:'',
        countCar:'',
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
                    that.CSchoolId=data.carSchoolId;
                    that.appraiseCarSchool=data.appraiseCarSchool;
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
        getApplyByCSId(){
            let that=this;
            if(this.CSchoolId){
                $.ajax({
                    url:"Apply/getApplyByCSId",
                    data:{
                        cSchoolId:that.CSchoolId
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
        updApply(row,operate){
            let that=this;
            $.ajax({
                url:"Apply/updApply",
                data:{
                    applyId:row.applyId,
                    operate:operate,
                    updDate:new Date()
                },
                success:function (data){
                    if (data) {
                        that.$notify({
                            title: '成功',
                            message: '更新成功',
                            type: 'success',
                            duration:1500,
                            onClose(){
                                location.reload();
                            }
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
        getCountSome(object){
            let result='';
            $.ajax({
                url:'Stats/'+object+'InCS',
                async:false,
                data:{
                    cSchoolId:this.CSchoolId,
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
