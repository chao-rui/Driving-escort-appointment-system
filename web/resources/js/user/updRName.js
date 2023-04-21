new Vue({
    el: '#app',
    mounted:function (){
        if(sessionStorage.getItem("roleFlag")!=="1"){
            this.readOnly=true;
            this.getUserInfo();
        }
    },
    data:{
        form: {
            userRName: '',
            idNumber: '',
        },
        readOnly:false,
        loading: false,
        rules: {
            userRName: [
                {required: true, message: '请输入真实姓名', trigger: 'blur'},
                {max: 10, message: '真实姓名长度不能超过10位', trigger: 'blur'}
            ],
            idNumber: [
                {required: true, message: '请输入身份证号', trigger: 'blur'},
                {pattern: /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/, message: '身份证号格式不正确', trigger: 'blur'}
            ]
        }
    },
    methods: {
        getUserInfo(){
            let that= this;
            $.ajax({
                url:"user/getUserInfo",
                contentType: "application/json",
                dataType:"JSON",
                data:{
                    "userId":sessionStorage.getItem("userId")
                },
                success:function (data){
                    that.form.userRName=data.userRname;
                    that.form.idNumber=data.idNumber;
                }
            });
        },
        save(){
            let that= this;
            this.$refs.form.validate(valid => {
                if (valid) {
                    that.loading=true;
                    $.ajax({
                        url: "user/setRName",
                        data: {
                            userRName: this.form.userRName,
                            idNumber: this.form.idNumber,
                            userId: sessionStorage.getItem("userId")
                        },
                        success: function (data) {
                            if(data) {
                                that.$notify({
                                    title: '成功',
                                    message: '更新成功',
                                    type: 'success'
                                });
                                top.location.href = "index";
                            }else{
                                that.$notify({
                                    title: '警告',
                                    message: '更新失败,请重试',
                                    type: 'warning'
                                });
                            }
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
                } else {
                    return false;
                }
            });
        }
    }
})
