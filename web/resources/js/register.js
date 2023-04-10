new Vue({
    el: '#app',
    data:{
        userName:'',
        phone:'',
        password:'',
        pwdCheck:''
    },
    methods:{
        register(){
           window.location.href="/register"
        }
    }
})
export default {
    data() {
        return {
            userName: '',
            phone:'',
            password:'',
            pwdCheck:''
        }
    }
}