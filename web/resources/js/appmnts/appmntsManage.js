new Vue({
    el:"#app",
    mounted:function () {
        this.loading = true;
        if(sessionStorage.getItem("roleFlag")==="2"){
            this.isCoach=false;
            this.getAppmntsByOId();
        }else{
            this.isUser=false;
            this.getAppmntsByUId();
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
        },
        getAppmntsByUId(){
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