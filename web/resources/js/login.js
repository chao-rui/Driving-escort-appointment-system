new Vue({
    el: '#app',
    data() {
        var that = this;
        return {
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
        register() {
            window.location.href = "/register"
        }
    }
})