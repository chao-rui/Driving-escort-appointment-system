new Vue({
    el:"#app",
    mounted:function () {
        this.loading = true;
        if(sessionStorage.getItem("roleFlag")==="2"){
            this.isCoach=false;
            this.getAppmntsByUId();
        }else{
            this.isUser=false;
            this.getAppmntsByOId();
        }
        this.loading = false;
    },
    data:{
        CSchoolId:'',
        loading:false,
        appmntsDlg:false,
        appraiseDlg:false,
        isOutDate:false,
        appmntsList:[],
        form:{
            userId:'',
            objectId:'',
            appmntsId: '',
            startDate:'',
            endDate:'',
            time:'',
            date:'',
            appmntsState:'',
            maxTime:''
        },
        appraise:{
            value:'5',
            context:'',
        },
        appmntsStateList:[{
            value:'0',
            label:'未开始'
        },{
            value:'1',
            label:'预约中'
        },{
            value:'2',
            label:'已结束'
        },{
            value:'3',
            label:'已评价'
        }],
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
        rules:{
            context: [{required: true, message: '请输入评价内容', trigger: 'blur'},
                {max: 100, message: '评价长度不能超过100位', trigger: 'blur'}]
        }
    },
    methods:{
        getAppmntsByOId(){
            let that=this;
            $.ajax({
                url:"Appmnts/getAppmntsByOId",
                data:{
                    objectId:sessionStorage.getItem("userId")
                },
                success:function (data){
                    that.appmntsList=data;
                },
                error:function (e){
                    console.log(e);
                    window.location.href="error";
                }
            });
        },
        getAppmntsByUId(){
            let that=this;
            $.ajax({
                url:"Appmnts/getAppmntsByUId",
                data:{
                    userId:sessionStorage.getItem("userId")
                },
                success:function (data){
                    that.appmntsList=data;
                    console.log(data);
                },
                error:function (e){
                    console.log(e);
                    window.location.href="error";
                }
            });
        },
        openAppmntsDlg(row){
            console.log(row);
            this.form.userId=row.user.userId;
            this.form.objectId=row.object.userId;
            this.form.appmntsId=row.appointmentId;
            this.isOutDate=new Date()>new Date(row.startDate);
            let [date, timeS] = row.startDate.split(' ');
            let [, timeE] = row.endDate.split(' ');
            this.form.startDate=timeS;
            this.form.endDate=timeE;
            this.form.date=date;
            this.form.time=row.time;
            this.form.appmntsState=row.appointmentState;
            this.appmntsDlg=true;
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
            let that=this;
            let startTime=new Date(that.dateStrToDate(that.form.startDate)).getTime();
            let endTime=startTime+this.form.time*1000*60*60;
            let endDate=new Date(endTime);
            console.log(startTime,endTime,endDate,this.form.time);
            let hours = endDate.getHours();
            let minutes = "0" + endDate.getMinutes();
            this.form.endDate = hours + ':' + minutes.substr(-2);
        },
        openAppraiseDlg(row){
            if(row.appointmentState==="2"){
                this.appraiseDlg=true;
                this.form.appmntsId=row.appointmentId;
            }else{
                this.$alert("预约还未结束或已评价！");
            }
        },
        appmntsStateFormatter(row, column, cellValue) {
            let Flag='';
            switch (cellValue){
                case "0": Flag="未开始";break;
                case "1": Flag="预约中";break;
                case "2": Flag="已结束";break;
                case "3": Flag="已评价";break;
                default:break;
            }
            return Flag;
        },
        userRNameFormatter(row,column,cellValue){
            let name=cellValue.charAt(0);
            if(row.user.gender==="男"){
                return name+"先生";
            }else{
                return name+"女士";
            }
        },
        updAppmnts(){
            let that=this;
            this.loading=true
            $.ajax({
                url:"Appmnts/updAppmnts",
                type:"POST",
                dataType:'json',
                data:{
                    appmntsId:this.form.appmntsId,
                    startDate: this.dateStrToDate(that.form.startDate),
                    endDate: this.dateStrToDate(that.form.endDate),
                    appmntsState:this.form.appmntsState
                },
                success:function (data) {
                    if (data) {
                        that.$notify({
                            title: '成功',
                            message: '修改成功',
                            type: 'success',
                            duration:1500,
                            onClose(){
                                that.appraiseDlg = false;
                                location.reload();
                            }
                        });
                    } else {
                        that.$notify({
                            title: '警告',
                            message: '修改失败',
                            type: 'warning'
                        });
                    }
                },
                error: function (e) {
                    that.$notify({
                        title: '失败',
                        message: '修改失败,错误信息' + e,
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
        updAppraise(){
            let that=this;
            this.loading=true
            $.ajax({
                url:"Appmnts/updAppraise",
                type:"POST",
                dataType:'json',
                data:{
                    appmntsId:this.form.appmntsId,
                    appraise:this.appraise.value,
                    appContext:this.appraise.context
                },
                success:function (data) {
                    if (data) {
                        that.$notify({
                            title: '成功',
                            message: '提交成功',
                            type: 'success',
                            duration:1500,
                            onClose(){
                                that.appmntsDlg = false;
                                location.reload();
                            }
                        });
                    } else {
                        that.$notify({
                            title: '警告',
                            message: '提交失败',
                            type: 'warning'
                        });
                    }
                },
                error: function (e) {
                    that.$notify({
                        title: '失败',
                        message: '提交失败,错误信息' + e,
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
});