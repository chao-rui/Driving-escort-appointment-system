new Vue({
    el: '#app',
    data() {
        var that = this;
        return {
            loading:false,
            setup1:true,
            setup2:false,
            setup3:false,
            form: {
                userId: '',
                code:'',
                password: '',
                pwdCheck:''
            },
            rules: {
                userId: [
                    {required: true, message: '请输入账号', trigger: 'blur'},
                    {max: 10, message: '账号长度不能超过10位', trigger: 'blur'}
                ],
                password: [
                    {required: true, message: '请输入密码', trigger: 'blur'},
                    {max: 20, message: '密码长度不能超过20位', trigger: 'blur'},
                    {pattern: /^[a-zA-Z0-9]+$/, message: '密码只能包含字母和数字', trigger: 'blur'}
                ],
                pwdCheck: [
                    {required: true, message: '请再次输入密码', trigger: 'blur'},
                    {validator: that.check, trigger: 'blur'}
                ],
                code:[{required: true, message: '请再次输入验证码', trigger: 'blur'},
                    {pattern: /^[a-zA-Z0-9]+$/, message: '验证码只能包含字母和数字', trigger: 'blur'}],
            }
        };
    },
    methods: {
        sendEmail(){
            let that=this;
            this.loading=true;
            this.$refs.setup1.validate(valid => {
                if (valid) {
                    $.ajax({
                        url: "user/sendEmail",
                        type: "POST",
                        data: {
                            "userId": this.form.userId,
                        },
                        success: function (data) {
                            if (data) {
                                that.setup1=false;
                                that.setup2=true;
                            } else {
                                alert("该账号不存在！")
                            }
                            that.loading=false;
                        },
                        errors: function (e) {
                            console.log(e);
                            window.location.href="error";
                        }
                    });
                } else {
                    // 验证失败，显示错误信息
                    return false;
                }
            })
        },
        checkCode(){
            let that=this;
            this.loading=true;
            this.$refs.setup2.validate(valid => {
                if (valid) {
                    $.ajax({
                        url: "user/clsPwd",
                        type: "POST",
                        data: {
                            "code":this.form.code,
                            "userId":this.form.userId,
                            "password":this.form.password
                        },
                        success: function (data) {
                            if (data) {
                                that.setup2=false;
                                that.setup3=true;
                            } else {
                                alert("验证码错误！")
                            }
                            that.loading=false;
                        },
                        errors: function (e) {
                            console.log(e);
                            window.location.href="error";
                        }
                    });
                } else {
                    // 验证失败，显示错误信息
                    return false;
                }
            })
        },
        toLogin(){
            window.location.href="/";
        },
        check(rule, value, callback) {
            if (value !== this.form.newPwd) {
                callback(new Error('两次输入密码不一致!'));
            } else {
                callback();
            }
        }
    }
})