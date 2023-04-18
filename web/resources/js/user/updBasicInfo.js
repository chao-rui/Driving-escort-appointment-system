new Vue({
    el: '#app',
    create(){
        this.getUserInfo();
    },
    data() {
        return {
            form: {
                userName: '',
                gender: '',
                phone: '',
                birthYear: ''
            },
            loading: false,
            rules: {
                userName: [
                    {required: true, message: '请输入用户名', trigger: 'blur'},
                    {max: 10, message: '用户名长度不能超过10位', trigger: 'blur'}
                ],
                gender: [
                    {required: true, message: '请输入手机号码', trigger: 'blur'},
                    {pattern: /^1\d{10}$/, message: '手机号码必须是11位数字', trigger: 'blur'}
                ],
                birthYear: [
                    {required: true, message: '请输入出生年', trigger: 'blur'},
                ]
            }
        };
    },
    methods: {
        getUserInfo(){

        }
    }
})
