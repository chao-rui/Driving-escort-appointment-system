new Vue({
    el: '#app',
    mounted:function (){
        this.getCSchoolAll();
        this.getApplyByUId();
        this.getUserPhoto();
    },
    data:{
        CSchoolInfo:[],
        tabName:"first",
        isApply:false,
        photoDlgUrl:'',
        photoDlg:false,
        limitedFlg:false,
        uploadData:{
            photoType:"user",
            photoObject:'',
        },
        formCoach: {
            workId: '',
            CSchoolId: '',
            photos: []
        },
        formCSA:{
            CSchoolName:'',
            key:''
        },
        formCS:{
            CSchoolAdder:'',
            CSchoolPhone:'',
            updDate: ''
        },
        loading: false,
        dialogVisible:false,
        applyState:'开始认证',
        rulesCoach: {
            workId: [
                {required: true, message: '请输入工号', trigger: 'blur'},
                {max: 10, message: '工号长度不能超过10位', trigger: 'blur'}
            ],
            CSchoolId: [
                {required: true, message: '请选择所属驾校', trigger: 'blur'},
            ],
            photo: [
                {required: true, message: '请选择个人证件照', trigger: 'blur'},
            ],
        },
        rulesCSA:{
            CSchoolName: [
                {required: true, message: '请输入驾校名称', trigger: 'blur'},
                {max: 10, message: '工号长度不能超过10位', trigger: 'blur'}
            ],
            key: [
                {required: true, message: '请输入邀请码', trigger: 'blur'},
            ]
        },
        rulesCS:{
            CSchoolAdder:[
                {required: true, message: '请输入驾校地址', trigger: 'blur'},
                {max: 40, message: '地址长度不能超过40字', trigger: 'blur'}
            ],
            CSchoolPhone:[
                {required: true, message: '请输入手机号码', trigger: 'blur'},
                {pattern: /^1\d{10}$/, message: '手机号码必须是11位数字', trigger: 'blur'}
            ]
        }
    },
    methods: {
        getCSchoolAll() {
            let that=this;
            $.ajax({
                url: "CarSchool/getCSchoolAll",
                success: function (data) {
                    that.CSchoolInfo=data;
                },
                error: function (e) {
                    console.log(e);
                    window.location.href="error"
                }
            });
        },
        getApplyByUId(){
            let that=this;
            $.ajax({
                url:"Apply/getApplyByUId",
                data:{
                    userId:sessionStorage.getItem("userId")
                },
                success:function (data){
                    if(data.length!==0) {
                        that.formCoach.workId = data[0].workId;
                        that.formCoach.CSchoolId = data[0].carSchool.carSchoolId;
                        that.tabName = "first";
                        that.isApply = true;
                        that.applyState='审核中'
                    }
                },
                error: function (e) {
                    console.log(e);
                    window.location.href="error"
                }
            });
        },
        saveCoach(){
            let that= this;
            this.$refs.formCoach.validate(valid => {
                if (valid) {
                    that.loading=true;
                    this.uploadPhoto();
                    $.ajax({
                        url: "Apply/addApply",
                        data: {
                            userId: sessionStorage.getItem("userId"),
                            workId: this.formCoach.workId,
                            cSchoolId: this.formCoach.CSchoolId,
                            updDate:new Date()
                        },
                        success: function (data) {
                            that.$notify({
                                title: '成功',
                                message: '申请成功',
                                type: 'success',
                                duration:1500,
                                onClose(){
                                    top.location.href = "index";
                                }
                            });
                        },
                        error: function (e) {
                            that.$notify({
                                title: '失败',
                                message: '申请失败,错误信息' + e,
                                type: 'error'
                            });
                        }
                    });
                    that.loading= false;
                } else {
                    return false;
                }
            });
        },
        saveCSA(){
            let that= this;
            this.$refs.formCSA.validate(valid => {
                if (valid) {
                    that.dialogVisible = true;
                } else {
                    return false;
                }
            });
        },
        saveCS(){
            let that=this;
            this.$refs.formCS.validate(valid=>{
                if(valid){
                    that.loading=true;
                    $.ajax({
                        url: "CarSchool/addCSchool",
                        data: {
                            cSchoolAdmin:sessionStorage.getItem("userId"),
                            cSchoolName:that.formCSA.CSchoolName,
                            cSchoolAdders:that.formCS.CSchoolAdder,
                            cSchoolPhone:that.formCS.CSchoolPhone,
                            appraiseCS:0,
                            updDate:new Date(),
                        },
                        success: function (data) {
                            that.$notify({
                                title: '成功',
                                message: '更新成功',
                                type: 'success',
                                duration:1500,
                                onClose(){
                                    top.location.href = "index";
                                }
                            });
                        },
                        error: function (e) {
                            that.$notify({
                                title: '失败',
                                message: '更新失败,错误信息' + e,
                                type: 'error'
                            });
                        }
                    });
                    that.loading= false;
                }else{
                    return false;
                }
            });
        },
        handlePictureCardPreview(file) {
            this.photoDlgUrl = file.url;
            this.photoDlg = true;
        },
        limited(file,fileList){
            if(fileList.length>=1){
                this.limitedFlg=true;
            }
            this.formCoach.photos=fileList;
        },
        uploadPhoto(){
            this.uploadData.photoObject=sessionStorage.getItem("userId");
            this.$refs.photo.submit();
        },
        getUserPhoto(){
            let that=this;
            $.ajax({
                url:'Photo/getPhoto',
                data:{
                    photoType:"user",
                    photoObject:sessionStorage.getItem("userId"),
                },
                success:function (data) {
                    that.formCoach.photos=[];
                    const host = window.location.host;
                    const protocol = window.location.protocol;
                    let basePath = protocol + "//" + host;
                    if(data){
                        let file={};
                        file.name=data.photoObject;
                        file.url=basePath+data.photoAdd;
                        that.formCoach.photos.push(file);
                    }
                    if(that.formCoach.photos.length>=1){
                        that.limitedFlg=true;
                    }else{
                        that.limitedFlg=false;
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
                    photoType:"user",
                    photoObject:file.name,
                },
                success:function (data) {

                },
                errors:function (e) {
                    console.log(e);
                    window.location.href="error";
                }
            })
        }
    }
})
