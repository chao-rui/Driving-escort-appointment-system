new Vue({
    el: '#app',
    data: {
        from:{
            userName: '',
            phone: '',
            password: '',
            pwdCheck: ''
        },
        userId: '',
        loading: false,
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
                {
                    validator: (rule, value, callback) => {
                        if (value !== this.form.password) {
                            callback(new Error('两次输入的密码不一致'));
                        } else {
                            callback();
                        }
                    },
                    trigger: 'blur'
                }
            ]
        }
    },
    methods: {
        getNewId() {
            let that = this;
            $.ajax({
                url: "/user/getNewId",
                type: "POST",
                success: function (data) {
                    that.$alert('请牢记你的账号:</br><strong style="font-size:40px;color: red">' + data + '</strong>',
                        '您的账号', {
                            dangerouslyUseHTMLString: true,
                            callback: action => {
                                window.location.href = '/';
                            }
                        });
                },
                errors: function (e) {
                    console.log(e);
                }
            });
        },
        register() {
            this.loading = true;
            let that = this;
            this.$refs.form.validate(valid => {
                if (valid) {
                    $.ajax({
                        url: "/user/register",
                        type: "POST",
                        data: {
                            "userName": this.from.userName,
                            "password": this.from.password,
                            "phone": this.from.phone
                        },
                        success: function (data) {
                            that.loading = false;
                            if (data === "true") {
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
        }
    }
})
export default {
    data() {
        return {
            userName: '',
            phone: '',
            password: '',
            pwdCheck: ''
        }
    }
}