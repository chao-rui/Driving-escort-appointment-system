new Vue({
    el: '#app',
    mounted:async function () {
        this.loading = true;
        await this.getcarModel();
        this.getCoachByModel();
        this.getCSchoolById();
        this.countCoach= +this.getCountSome('countCoach');
        this.countCar= +this.getCountSome('countCar');
        this.countApp= +this.getCountSome('countApp');
        this.sumApp= +this.getCountSome('sumApp');
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
        countCoach:'',
        countCar:'',
        coachList:[],
        sFreeRange:[],
        eFreeRange:[],
        originalFRange:[],
        appmntsList:[],
        cSchool:{},
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
        pickerOptions: {
            disabledDate(time) {
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
            date:[{required: true, message: '请选择日期', trigger: 'blur'},],
            startDate:[{required: true, message: '请输入开始时间', trigger: 'blur'},],
            endDate:[{required: true, message: '请输入开始时间', trigger: 'blur'},]
        }
    },
    methods: {
        getcarModel(){
            if(localStorage.getItem("carModel")){
                this.carModel=localStorage.getItem("carModel");
            }else{
                this.carModelDig=true;
            }
        },
        getCSchoolById(){
            let that=this;
            $.ajax({
                url:'CarSchool/getCSchoolById',
                data:{
                    "cSchoolId":cSchoolId
                },
                success:function (data) {
                    that.cSchool=data;
                },
                error:function (e){
                    console.log(e);
                    window.location.href="error";
                }
            });
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
                    "carModel":that.carModel,
                    "cSchoolId": cSchoolId
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
        updTime(value){
            if(this.form.startDate&&this.form.endDate) {
                let startDate=this.dateStrToDate(this.form.startDate);
                let endDate=this.dateStrToDate(this.form.endDate);
                this.form.time=((endDate - startDate)/3600000).toFixed(2);
            }else{
                this.form.time="0.00";
            }
            if(value){
                this.sFreeRange=JSON.parse(JSON.stringify(this.originalFRange));
                this.changeSFreeRange();
            }else{
                this.eFreeRange=JSON.parse(JSON.stringify(this.originalFRange));
                this.changeEFreeRange();
            }
        },
        changeEFreeRange(){
            let index=this.eFreeRange.length;//一个绝对大的值
            for (let i = 0; i < this.eFreeRange.length; i++) {
                if (this.eFreeRange[i].time === this.form.startDate) {
                    index=i;
                }
                if(i<=index){
                    this.eFreeRange[i].disabled = true;
                }else if(this.eFreeRange[i].disabled){
                    index=this.eFreeRange.length;//一个绝对大的值
                }
            }
        },
        changeSFreeRange(){
            let index=0;//一个绝对小的值
            for (let i = this.sFreeRange.length-1; i > 0; i--) {

                if (this.sFreeRange[i].time === this.form.endDate) {
                    index=i;
                }
                if(i>=index){
                    this.sFreeRange[i].disabled = true;
                }else if(this.sFreeRange[i].disabled){
                    index=0;//一个绝对小的值
                }
            }
        },
        addAppmnts(){
            let that=this;
            this.$refs.form.validate(valid => {
                if (valid) {
                    this.appmntsDig = false;
                    this.loading=true;
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
                } else {
                    return false;
                }
            });
        },
        getFreeRange(date){
            let that=this;
            this.loading=true;
            if(date){
                $.ajax({
                    url:"Appmnts/getFreeRange",
                    data:{
                        selectDate:date
                    },
                    success:function (data){
                        that.originalFRange=data;
                        that.sFreeRange=data;
                        that.eFreeRange=data;
                    },
                    error:function (e){
                        console.log(e);
                        window.location.href="error";
                    }
                });
            }
            this.loading=false;
        },
        getCountSome(object){
            let result='';
            $.ajax({
                url:'Stats/'+object+'InCS',
                async:false,
                data:{
                    cSchoolId:cSchoolId,
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
        getAppraise(row){
            let that=this;
            $.ajax({
                url:'Appmnts/getAppmntsByOId',
                data:{
                    objectId:row.userId,
                },
                success:function (data){
                    that.appmntsList=[];
                    for(let i=0;i<data.length;i++){
                        if(data[i].appointmentState==="3"||data[i].appointmentState==="4"){
                            that.appmntsList.push(data[i]);
                        }
                    }
                },
                error:function (e) {
                    console.log(e);
                    top.location.href="error";
                }
            });
        }
    }
})
