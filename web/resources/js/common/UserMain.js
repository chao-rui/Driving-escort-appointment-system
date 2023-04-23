new Vue({
    el: '#app',
    mounted:async function () {
        this.loading = true;
        await this.getcarModel();
        this.loading = false;
    },
    data: {
        carModel: '',
        dialogVisible:false,
        loading:false,
        coachList:[]
    },
    methods: {
        getcarModel(){
          this.dialogVisible=true;
        },
        getCoachByModel(){
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
        }
    }
})
