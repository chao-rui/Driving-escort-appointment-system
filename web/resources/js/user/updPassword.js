new Vue({
    el: '#app',
    data() {
        var that = this;
        return {
            form: {
                oldPwd:'',
                newPwd: '',
                pwdCheck: ''
            },
            loading: false,
            rules: {
                oldPwd: [
                    {required: true, message: '请输入密码', trigger: 'blur'},
                    {max: 20, message: '密码长度不能超过20位', trigger: 'blur'},
                    {pattern: /^[a-zA-Z0-9]+$/, message: '密码只能包含字母和数字', trigger: 'blur'}
                ],
                newPwd: [
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
        save(){
            let that= this;
            this.$refs.form.validate(valid => {
                if (valid) {
                    that.loading=true;
                    $.ajax({
                        url: "user/updPassword",
                        data: {
                            newPassword: this.form.newPwd,
                            userId: sessionStorage.getItem("userId"),
                            password: this.form.oldPwd
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
                                    message: '更新失败,原密码错误',
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
        },
        check(rule, value, callback) {
            if (value !== this.form.password) {
                callback(new Error('两次输入密码不一致!'));
            } else {
                callback();
            }
        }
    }
})
