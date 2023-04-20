new Vue({
    el: '#app',
    data() {
        var that = this;
        return {
            loading:false,
            form: {
                userId: '',
                password: '',
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
                ]
            }
        };
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
        ]
    },
    methods: {
        login(){
            let that=this;
            this.loading=true;
            this.$refs.form.validate(valid => {
                if (valid) {
                    $.ajax({
                        url: "login",
                        type: "POST",
                        data: {
                            "userId": this.form.userId,
                            "password": this.form.password,
                        },
                        success: function (data) {
                            if (data) {
                                sessionStorage.setItem("userId", data.userId);
                                sessionStorage.setItem("roleFlag", data.roleFlag);
                                window.location.href="index"
                            } else {
                                alert("账号或密码错误！")
                            }
                            that.loading=false;
                        },
                        errors: function (e) {
                            alert("登录出错！请刷新页面重试")
                        }
                    });
                } else {
                    // 验证失败，显示错误信息
                    return false;
                }
            })
        },
        register() {
            window.location.href = "register"
        }
    }
})