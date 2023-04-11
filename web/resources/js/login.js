new Vue({
    el: '#app',
    data:{
        userId:'',
        password:''
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
            userId: '',
            password:''
        }
    }
}