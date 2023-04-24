new Vue({
    el: '#app',
    mounted:async function () {
        this.loading = true;
        await this.getcarModel();
        this.loading = false;
    },
    data: {
        carModel: '1',
        carModelDig:false,
        appmntsDig:false,
        rNameDig:false,
        loading:false,
        coachList:[],
        form:{
            userId:'',
            objectId:'',
            startDate:'',
            endDate:'',
            time:''
        }
    },
    methods: {
        getcarModel(){
          this.carModelDig=true;
        },
        getCoachByModel(){
            this.carModelDig=false;
            let that=this;
            $.ajax({
                url:"Coach/getCoachByModel",
                data:{
                    carModel:that.carModel
                },
                success:function (data) {
                    that.coachList=data;
                }
            });
        },
        doAppmnts(row){
            let roleFlag=sessionStorage.getItem("roleFlag");
            if(roleFlag==="2") {
                this.appmntsDig = true;
                this.form.objectId = row.userId;
            }else{
                this.$alert("<strong>未成年用户无法预约<strong>!</br>" +
                    "若您已成年，请先在<span style='color: red'>用户信息管理</span>" +
                    "中进行<span style='color: red'>实名认证</span>。",
                    "未实名/未成年用户",
                    {dangerouslyUseHTMLString: true});
            }
        },
        dateStrToDate(str){
            let [hours, minutes] = str.split(':');
            let date = new Date();
            date.setHours(hours);
            date.setMinutes(minutes);
            date.setSeconds(0);
            return date;
        },
        updTime(){
            if(this.form.startDate&&this.form.endDate) {
                let startDate=this.dateStrToDate(this.form.startDate);
                let endDate=this.dateStrToDate(this.form.endDate);
                this.form.time=((endDate - startDate)/3600000).toFixed(2);
            }
        },
        addAppmnts(){
            let that=this;
            this.appmntsDig = false
            this.loading=true
            $.ajax({
                url:"Appmnts/addAppmnts",
                type:"POST",
                dataType:'json',
                data:{
                    userId: sessionStorage.getItem("userId"),
                    objectId:this.form.objectId,
                    time:this.form.time,
                    startDate: this.dateStrToDate(that.form.startDate),
                    endDate: this.dateStrToDate(that.form.endDate)
                },
                success:function (data) {
                    if (data) {
                        that.$notify({
                            title: '成功',
                            message: '预约成功',
                            type: 'success',
                            duration:1500,
                            onClose(){
                                location.reload();
                            }
                        });
                    } else {
                        that.$notify({
                            title: '警告',
                            message: '预约失败',
                            type: 'warning'
                        });
                    }
                },
                error: function (e) {
                    that.$notify({
                        title: '失败',
                        message: '预约失败,错误信息' + e,
                        type: 'error',
                        duration:1500,
                        onClose(){
                            top.location.href="error";
                        }
                    });
                }
            });
            that.loading= false;
        }
    }
})
