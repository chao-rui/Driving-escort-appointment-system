new Vue({
    el: '#app',
    data() {
        var that = this;
        return {
            form: {
                userName: '',
                phone: '',
                password: '',
                pwdCheck: ''
            },
            loading: false,
            userIdDlg:false,
            userId:'',
            rules: {
                userName: [
                    {required: true, message: '请输入用户名', trigger: 'blur'},
                    {max: 10, message: '用户名长度不能超过10位', trigger: 'blur'}
                ],
                phone: [
                    {required: true, message: '请输入手机号码', trigger: 'blur'},
                    {pattern: /^1\d{10}$/, message: '手机号码必须是11位数字', trigger: 'blur'}
                ],
                password: [
                    {required: true, message: '请输入密码', trigger: 'blur'},
                    {max: 20, message: '密码长度不能超过20位', trigger: 'blur'},
                    {pattern: /^[a-zA-Z0-9]+$/, message: '密码只能包含字母和数字', trigger: 'blur'}
                ],
                pwdCheck: [
                    {required: true, message: '请再次输入密码', trigger: 'blur'},
                    {validator: that.check, trigger: 'blur'}
                ]
            }
        };
    },
    methods: {
        getNewId() {
            let that = this;
            $.ajax({
                url: "/user/getNewId",
                type: "POST",
                success: function (data) {
                    that.userId=data;
                    that.loading = false;
                    that.userIdDlg=true;
                },
                errors: function (e) {
                    console.log(e);
                }
            });
        },
        register() {
            let that = this;
            this.$refs.form.validate(valid => {
                if (valid) {
                    that.loading=true;
                    $.ajax({
                        url: "/user/register",
                        type: "POST",
                        data: {
                            "userName": this.form.userName,
                            "password": this.form.password,
                            "phone": this.form.phone
                        },
                        success: function (data) {
                            if (data) {
                                that.getNewId();
                            }
                        },
                        errors: function (e) {
                            console.log(e);
                        }
                    });
                    that.loading = false;
                } else {
                    // 验证失败，显示错误信息
                    return false;
                }
            });
        },
        check(rule, value, callback) {
            if (value !== this.form.password) {
                callback(new Error('两次输入密码不一致!'));
            } else {
                callback();
            }
        },
        toLogin(){
            window.location.href="/";
        }
    }
})
