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
        appmntsDig:false,
        isCoach:true,
        isUser:true,
        appmntsList:[],
        form:{
            userId:'',
            objectId:'',
            startDate:'',
            endDate:'',
            time:'',
            appmntsState:''
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
        }]
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
                },
                error:function (e){
                    console.log(e);
                    window.location.href="error";
                }
            });
        },
        getAppmnts(row){
            this.form.userId=row.user.userId;
            this.form.objectId=row.object.userId;
            this.form.startDate=row.startDate;
            this.form.endDate=row.endDate;
            this.form.time=row.time;
            this.form.appmntsState=row.appointmentState;
            this.appmntsDig=true;
        },
        updAppmnts(row){
            this.form.userId=row.user.userId;
            this.form.objectId=row.object.userId;
            this.form.startDate=row.startDate;
            this.form.endDate=row.endDate;
            this.form.time=row.time;
            this.form.appmntsState=row.appointmentState;
            this.appmntsDig=true;
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
        updAppraise(row){
            if(row.appointmentState==="2"){

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
        }
    }
});