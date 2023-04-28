new Vue({
    el: '#app',
    mounted:function (){
        this.getUserInfo();
        if(sessionStorage.getItem("roleFlag")!=="1"){
            this.readOnly=true;
        }
    },
    data:{
        readOnly:false,
        form: {
            userName: '',
            gender: '',
            phone: '',
            email:'',
            birthYear: ''
        },
        loading: false,
        rules: {
            userName: [
                {required: true, message: '请输入用户名', trigger: 'blur'},
                {max: 10, message: '用户名长度不能超过10位', trigger: 'blur'}
            ],
            gender:[{required: true, message: '请选择性别', trigger: 'blur'}],
            phone: [
                {required: true, message: '请输入手机号码', trigger: 'blur'},
                {pattern: /^1\d{10}$/, message: '手机号码必须是11位数字', trigger: 'blur'}
            ],
            email: [
                {required: true, message: '请输入邮箱', trigger: 'blur'},
                {pattern: /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/, message: '邮箱格式错误', trigger: 'blur'}
            ],
            birthYear: [
                {required: true, message: '请输入出生年', trigger: 'blur'},
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
                    that.form.userName=data.userName;
                    that.form.birthYear=data.birthYear+"";
                    that.form.gender=data.gender;
                    that.form.phone=data.phone;
                    that.form.email=data.email;
                }
            });
        },
        save(){
            let that= this;
            this.$refs.form.validate(valid => {
                if (valid) {
                    that.loading=true;
                    $.ajax({
                        url: "user/updUserInfo",
                        data: {
                            userName: this.form.userName,
                            gender: this.form.gender,
                            phone: this.form.phone,
                            email:this.form.email,
                            birthYear: this.form.birthYear,
                            userId: sessionStorage.getItem("userId")
                        },
                        success: function (data) {
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
