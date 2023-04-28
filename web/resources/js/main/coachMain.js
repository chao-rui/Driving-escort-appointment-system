new Vue({
    el: '#app',
    mounted:function () {
        this.loading = true;
        this.RecAppInCo();
        this.getCoachByUid();
        this.countApp= +this.getCountSome('countApp');
        this.sumApp= +this.getCountSome('sumApp');
        this.getAppmntsByOId();
        this.loading = false;
    },
    data:{
        countApp:'',
        sumApp:'',
        appraiseCoach:0,
        appraiseContext:'',
        appmntsList:[],
        recApp:{
            user:{
                userName:'',
                phone:''
            },
            startDate:'',
            appointmentState:'',
        },
    },
    methods: {
        getCoachByUid() {
            let that = this;
            $.ajax({
                url: "Coach/getCoachByUserId",
                data: {
                    userId: sessionStorage.getItem("userId")
                },
                success: function (data) {
                    that.appraiseCoach= data.appraiseCoach;
                    if(that.appraiseCoach===0){
                        that.appraiseContext="刚刚起步，请开始加油吧"
                    }else if(that.appraiseCoach<3){
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
        getCountSome(object){
            let result='';
            $.ajax({
                url:'Stats/'+object+'InCo',
                async:false,
                data:{
                    objectId:sessionStorage.getItem("userId"),
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
        RecAppInCo() {
            let that = this;
            $.ajax({
                url: 'Stats/RecAppInCo',
                async: false,
                data: {
                    objectId: sessionStorage.getItem("userId")
                },
                success: function (data) {
                    that.recApp = data;
                },
                error: function (e) {
                    console.log(e);
                    top.location.href = "error";
                }
            });
            switch (this.recApp.appointmentState){
                case '0':this.recApp.appointmentState="未开始";break;
                case '1':this.recApp.appointmentState="预约中";break;
                case '2':this.recApp.appointmentState="已结束";break;
                case '3':this.recApp.appointmentState="已评价";break;
            }
        },
        getAppmntsByOId(){
            let that=this;
            $.ajax({
                url:'Appmnts/getAppmntsByOId',
                data:{
                    objectId:sessionStorage.getItem("userId")
                },
                success:function (data) {
                    for(let i=0;i<data.length;i++){
                        if(data[i].appointmentState==="3"){
                            that.appmntsList.push(data[i]);
                        }
                    }
                },
                error:function (e) {
                    top.location.href="error";
                }
            })
        }
    }
})
