new Vue({
    el:"#app",
    mounted:async function () {
        this.loading = true;
        await this.getCSchoolByUid();
        await this.getCoachByCSId();
        this.countCoach= +this.getCountSome('countCoach');
        this.countCar= +this.getCountSome('countCar');
        this.countApp= +this.getCountSome('countApp');
        this.sumApp= +this.getCountSome('sumApp');
        this.getCSPhotos(this.form.carSchoolId);
        this.loading = false;
    },
    data:{
        loading:false,
        countCoach:0,
        countCar:'',
        countApp:'',
        sumApp:'',
        photoDlgUrl:'',
        photoDlg:false,
        limitedFlg:false,
        cSPhotoDlg:false,
        coachDlg:false,
        search:'',
        form:{
            carSchoolId:'',
            carSchoolName:'',
            carSchoolAdders:'',
            carSchoolPhone:'',
            carSchoolDesc:'',
            appraiseCarSchool:0,
            appraiseContext:'',
            photos:[]
        },
        coachForm:{
            userId:'',
            price:'',
            context:''
        },
        uploadData:{
            photoType:"carSchool",
            photoObject:'',
        },
        rules:{
            cSchoolName: [
                {required: true, message: '请输入驾校名称', trigger: 'blur'},
                {max: 10, message: '驾校名称长度不能超过10位', trigger: 'blur'}
            ],
            cSchoolAdders: [
                {required: true, message: '请输入驾校地址', trigger: 'blur'},
                {max: 20, message: '驾校地址长度不能超过20位', trigger: 'blur'}
            ],
            cSchoolPhone: [
                {required: true, message: '请输入手机号码', trigger: 'blur'},
                {pattern: /^1\d{10}$/, message: '手机号码必须是11位数字', trigger: 'blur'}
            ],
            cSchoolDesc: [
                {required: true, message: '请输入驾校简介', trigger: 'blur'},
                {max: 10, message: '用户名长度不能超过200字', trigger: 'blur'}
            ],
        },
        coachRules:{
            price: [
                {required: true, message: '请输入单价，单位小时', trigger: 'blur'},
            ],
            context: [
                {required: true, message: '请输入教练简介', trigger: 'blur'},
                {max: 200, message: '教练简介长度不能超过200位', trigger: 'blur'}
            ]
        },
        coachList:[]
    },
    methods:{
        async getCSchoolByUid() {
            let that = this;
            await $.ajax({
                url: "CarSchool/getCSchoolByUid",
                data: {
                    userId: sessionStorage.getItem("userId")
                },
                success: function (data) {
                    that.form = data;
                    if(that.form.appraiseCarSchool===0){
                        that.form.appraiseContext="刚刚起步，请开始加油吧"
                    }else if(that.form.appraiseCarSchool<3){
                        that.form.appraiseContext="找到原因，为更好的服务而奋斗吧"
                    }else{
                        that.form.appraiseContext="已经很优秀了，请继续保持"
                    }
                },
                error: function (e) {
                    console.log(e);
                    window.location.href = "error";
                }
            });
        },
        save(){
            let that=this;
            $.ajax({
                url:"CarSchool/updCSchool",
                data:{
                    cSchoolId:that.form.carSchoolId,
                    cSchoolName: that.form.carSchoolName,
                    cSchoolAdders: that.form.carSchoolAdders,
                    cSchoolDesc: that.form.carSchoolDesc,
                    cSchoolPhone: that.form.carSchoolPhone,
                    updDate:new Date()
                },
                success:function (data){
                    if (data) {
                        that.$notify({
                            title: '成功',
                            message: '更新成功',
                            type: 'success'
                        });
                    } else {
                        that.$notify({
                            title: '警告',
                            message: '更新失败,请重试',
                            type: 'warning'
                        });
                    }
                },
                error:function (e) {
                    that.$notify({
                        title: '失败',
                        message: '更新失败,错误信息' + e,
                        type: 'error'
                    });
                }
            });
        },
        getCoachByCSId(){
            let that=this;
            $.ajax({
                url:"Coach/getCoachByCSId",
                data:{
                    cSchoolId:that.form.carSchoolId
                },
                success:function (data){
                    that.coachList=data;
                },
                error:function (e) {
                    console.log(e);
                    window.location.href="error";
                }
            });
        },
        getCountSome(object){
            let result='';
            $.ajax({
                url:'Stats/'+object+'InCS',
                async:false,
                data:{
                    cSchoolId:this.form.carSchoolId,
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
        toAppmnts(row) {
            window.location.href="show?url=coach/coachInfo&value="+row.userId;
        },
        handlePictureCardPreview(file) {
            this.photoDlgUrl = file.url;
            this.photoDlg = true;
        },
        limited(file,fileList){
            if(fileList.length>=3){
                this.limitedFlg=true;
            }
            this.form.photos=fileList;
        },
        uploadPhoto(){
            this.uploadData.photoObject=this.form.carSchoolId;
            this.$refs.photo.submit();
            this.cSPhotoDlg=false;
        },
        getCSPhotos(carSchoolId){
            let that=this;
            $.ajax({
                url:'Photo/getPhotos',
                data:{
                    photoType:"carSchool",
                    photoObject:carSchoolId,
                },
                success:function (data) {
                    that.form.photos=[];
                    const host = window.location.host;
                    const protocol = window.location.protocol;
                    let basePath = protocol + "//" + host;
                    if(data){
                        for (let i = 0; i < data.length; i++) {
                            let file={};
                            file.name=data[i].photoObject;
                            file.url=basePath+data[i].photoAdd;
                            that.form.photos.push(file);
                        }
                        if(data.length>=3){
                            that.limitedFlg=true;
                        }else{
                            that.limitedFlg=false;
                        }
                    }
                },
                error:function (e) {
                    console.log(e);
                    window.location.href="error";
                }
            })
        },
        remove(file,fileList){
            this.limited(file,fileList);
            $.ajax({
                url:'Photo/delPhoto',
                data:{
                    photoType:"carSchool",
                    photoObject:file.name,
                },
                success:function (data) {

                },
                errors:function (e) {
                    console.log(e);
                    window.location.href="error";
                }
            })
        },
        toUpdCoach(row){
            this.coachForm.userId=row.userId;
            this.coachForm.price=row.price;
            this.coachForm.context=row.context;
            this.coachDlg=true;
        },
        updCoach() {
            let that = this;
            this.$refs.coachForm.validate(valid => {
                if (valid) {
                    $.ajax({
                        url: "Coach/updCoach",
                        data: this.coachForm,
                        success: function (data) {
                            if (data) {
                                that.$notify({
                                    title: '成功',
                                    message: '更新成功',
                                    type: 'success',
                                    duration: 1500,
                                    onClose() {
                                        location.reload();
                                    }
                                });
                                that.coachDlg = false;
                            } else {
                                that.$notify({
                                    title: '失败',
                                    message: '更新失败',
                                    type: 'error'
                                });
                            }
                        },
                        error: function (e) {
                            that.$notify({
                                title: '失败',
                                message: '更新失败,错误信息' + e,
                                type: 'error',
                                duration: 1500,
                                onClose() {
                                    top.location.href = "error";
                                }
                            });
                        }
                    })
                } else {
                    return false;
                }
            });
        }
    },
    computed:{
        doSearch() {
            const search = this.search;
            if (search) {
                return this.coachList.filter((dataNews) => {
                    return Object.keys(dataNews).some((key) => {
                        if(typeof dataNews[key]==="object"&&dataNews[key]){
                            return Object.keys(dataNews[key]).some((oKey) => {
                                return String(dataNews[key][oKey]).indexOf(search) > -1;
                            })
                        }
                        return String(dataNews[key]).indexOf(search) > -1;
                    });
                });
            }
            return this.coachList;
        }
    }
});