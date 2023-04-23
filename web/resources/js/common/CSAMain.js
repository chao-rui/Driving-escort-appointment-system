new Vue({
    el: '#app',
    mounted:async function () {
        this.loading = true;
        await this.getCSchoolByUid();
        await this.getApplyByCSId();
        this.loading = false;
    },
    data:{
        CSchoolId:'',
        applyList:[],
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
                            type: 'success'
                        });
                        window.location.href="index"
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
        }
    }
})
