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
        isCoach:true,
        isUser:true,
        appmntsList:[]
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