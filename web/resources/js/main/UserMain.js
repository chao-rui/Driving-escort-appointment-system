new Vue({
    el: '#app',
    mounted:async function () {
        this.loading = true;
        this.countApp= +this.getCountSome('countApp');
        this.sumApp= +this.getCountSome('sumApp');
        this.RecAppInU();
        await this.getcarModel();
        this.loading = false;
    },
    data: {
        carModel: '1',
        carModelDig:false,
        appmntsDig:false,
        checked:true,
        rNameDig:false,
        loading:false,
        countApp:'0',
        sumApp:'0',
        applyList:[],
        coachList:[],
        form:{
            userId:'',
            objectId:'',
            startDate:'',
            endDate:'',
            time:'',
            date:''
        },
        recApp:{
            object:{
                userRname:'-',
                phone:'-'
            },
            startDate:'-',
            appointmentState:'-',
        },
        pickerOptions:{
            disabledDate(time){
                const now = new Date()
                const today = new Date(now.getFullYear(), now.getMonth(), now.getDate())
                const dayOfWeek = today.getDay()
                const thisMonday = new Date(today)
                thisMonday.setDate(today.getDate() - dayOfWeek + (dayOfWeek === 0 ? -6 : 1))
                const thisSunday = new Date(thisMonday)
                thisSunday.setDate(thisMonday.getDate() + 6)
                return time.getTime() < now.getTime() || time.getTime() > thisSunday.getTime()
            }
        },
    },
    methods: {
        getcarModel(){
            if(localStorage.getItem("carModel")){
                this.carModel=localStorage.getItem("carModel");
            }else{
                this.carModelDig=true;
            }
        },
        getCoachByModel(){
            this.carModelDig=false;
            if(this.checked){
                localStorage.setItem("carModel",this.carModel);
            }
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
            let date = new Date(this.form.date);
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
        },
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
    }
})
