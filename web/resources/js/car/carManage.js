new Vue({
    el:"#app",
    mounted:async function () {
        this.loading = true;
        await this.getCSchoolByUid();
        await this.getCarByCSId();
        this.loading = false;
    },
    data() {
        let that = this;
        return {
            CSchoolId: '',
            photoDlgUrl:'',
            photoDlg:false,
            carDlg: false,
            loading: false,
            isUpd:false,
            limitedFlg:false,
            carList: [],
            carTotal:0,
            search:'',
            form: {
                carId:'',
                carNumber: '',
                carBrands: '',
                carModel: '',
                userId: '',
                carFlag: '',
                photos:[],
            },
            rules: {
                carNumber: [
                    {required: true, message: '请输入车牌号', trigger: 'blur'},
                    {max: 7, message: '车牌号名称长度不能超过10位', trigger: 'blur'}
                ],
                carBrands: [
                    {required: true, message: '请输入品牌', trigger: 'blur'},
                    {max: 10, message: '品牌长度不能超过10位', trigger: 'blur'}
                ],
                userId: [
                    {required: true, message: '请选择车辆所属', trigger: 'change', validator: that.check}
                ],
                carModel: [
                    {required: true, message: '请选择车辆类型', trigger: 'blur'},
                ],
                carFlag: [
                    {required: true, message: '请选择车辆状态', trigger: 'blur'},
                ],
                photos: [
                    {required: true, message: '请选择图片', trigger: 'blur'},
                ],
            },
            carModelList: [{carModel: "1", label: "手动挡"},
                           {carModel: "2", label: "自动挡"}],
            carFlagList: [{carFlag: "0", label: "未分配", disabled: true},
                          {carFlag: "1", label: "正常", disabled: false},
                          {carFlag: "2", label: "维修中", disabled: false},
                          {carFlag: "3", label: "报废", disabled: false}],
            coachList: [],
            uploadData:{
                photoType:"car",
                photoObject:'',
            }
        }
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
                    that.CSchoolId=data.carSchoolId;
                },
                error: function (e) {
                    console.log(e);
                    window.location.href = "error";
                }
            });
        },
        getCarByCSId(){
            let that=this;
            $.ajax({
                url:"Car/getCarByCS",
                data:{
                    cSchoolId:that.CSchoolId
                },
                success:function (data){
                    that.carList=data;
                    that.carTotal=that.carList.length;
                },
                error:function (e){
                    console.log(e);
                    window.location.href="error";
                }
            });
        },
        getCoachByCSId() {
            let that=this;
            $.ajax({
                url:"Coach/getCoachByCSId",
                data:{
                    cSchoolId:that.CSchoolId
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
        addCar(){
            this.carDlg=true;
            this.getCoachByCSId();
        },
        save(){
            let that= this;
            if(!this.isUpd){
                this.$refs.form.validate(valid => {
                    if (valid) {
                        that.loading=true;
                        $.ajax({
                            url: "Car/addCar",
                            data: {
                                carNumber:this.form.carNumber,
                                carBrands:this.form.carBrands,
                                carModel:this.form.carModel,
                                cSchoolId:this.CSchoolId,
                                userId:this.form.userId,
                                updDate:new Date()
                            },
                            success: function (data) {
                                if(data){
                                    that.$notify({
                                        title: '成功',
                                        message: '添加成功',
                                        type: 'success',
                                        duration:1500,
                                        onClose(){
                                            location.reload();
                                        }});
                                    that.carDlg=false;
                                }else{
                                    that.$notify({
                                        title: '失败',
                                        message: '添加失败',
                                        type: 'error'
                                    });}
                            },
                            error: function (e) {
                                that.$notify({
                                    title: '失败',
                                    message: '添加失败,错误信息' + e,
                                    type: 'error',
                                    duration:1500,
                                    onClose(){
                                        top.location.href="error";
                                    }
                                });
                            }
                        });
                        that.uploadPhoto();
                        that.loading= false;
                    } else {
                        return false;
                    }
                });
            }else{
                this.$refs.form.validate(valid => {
                    if (valid) {
                        that.loading=true;
                        $.ajax({
                            url: "Car/updCar",
                            data: {
                                carId:this.form.carId,
                                carNumber:this.form.carNumber,
                                carBrands:this.form.carBrands,
                                carModel:this.form.carModel,
                                cSchoolId:this.CSchoolId,
                                userId:this.form.userId,
                                carFlag:this.form.carFlag,
                                updDate:new Date()
                            },
                            success: function (data) {
                                if(data){
                                    that.$notify({
                                        title: '成功',
                                        message: '更新成功',
                                        type: 'success',
                                        duration:1500,
                                        onClose(){
                                            location.reload();
                                        }});
                                    that.carDlg=false;
                                }else{
                                    that.$notify({
                                        title: '失败',
                                        message: '更新失败',
                                        type: 'error'
                                    });}
                            },
                            error: function (e) {
                                that.$notify({
                                    title: '失败',
                                    message: '更新失败,错误信息' + e,
                                    type: 'error',
                                    duration:1500,
                                    onClose(){
                                        top.location.href="error";
                                    }
                                });
                            }
                        });
                        that.uploadPhoto();
                        that.loading= false;
                    } else {
                        return false;
                    }
                });
            }
        },
        updCar(row){
            this.carDlg=true;
            this.isUpd=true;
            this.getCoachByCSId();
            this.getCarPhoto(row.carId);
            this.form.carId=row.carId;
            this.form.carModel=row.carModel;
            this.form.carBrands=row.carBrands;
            this.form.carNumber=row.carNumber;
            if(row.user){
                this.form.userId=row.user.userId;
            }
            this.form.carFlag=row.carFlag;
        },
        carModelFormatter(row, column, cellValue) {
            if(cellValue==="1"){
                return "手动挡";
            }else{
                return "自动挡";
            }
        },
        carFlagFormatter(row, column, cellValue) {
            let Flag='';
            switch (cellValue){
                case "0": Flag="未分配";break;
                case "1": Flag="正常";break;
                case "2": Flag="预约中";break;
                case "3": Flag="维修中";break;
                case "4": Flag="报废";break;
                default:break;
            }
            return Flag;
        },
        check(rule, value, callback) {
            if (this.form.carFlag === "1" && !value) {
                callback(new Error('请选择车辆所属'));
            } else {
                callback();
            }
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
            this.uploadData.photoObject=this.form.carId;
            this.$refs.photo.submit();
        },
        getCarPhoto(carId){
            let that=this;
            $.ajax({
                url:'Photo/getPhotos',
                data:{
                    photoType:"car",
                    photoObject:carId,
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
                    photoType:"car",
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
        ModelFilter(value, row) {
            return row.carModel === value;
        },
        FlagFilter(value, row) {
            return row.carFlag === value;
        }
    },
    computed:{
        doSearch() {
            const search = this.search;
            if (search) {
                return this.carList.filter((dataNews) => {
                    return Object.keys(dataNews).some((key) => {
                        if(typeof dataNews[key]==="object"&&dataNews[key]){
                            return Object.keys(dataNews[key]).some((oKey) => {
                                console.log(dataNews[key][oKey])
                                return String(dataNews[key][oKey]).indexOf(search) > -1;
                            })
                        }
                        return String(dataNews[key]).indexOf(search) > -1;
                    });
                });
            }
            return this.carList;
        }
    }
});