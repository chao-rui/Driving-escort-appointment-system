new Vue({
    el:"#app",
    mounted:function () {
        this.loading = true;
        if(sessionStorage.getItem("roleFlag")==="2"){
            this.isCoach=true;
            this.getAppmntsByOId();
        }else{
            this.isUser=true;
            this.getAppmntsByUId();
        }
        this.loading = false;
    },
    data:{
        CSchoolId:'',
        loading:false,
        isCoach:false,
        isUser:false,
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