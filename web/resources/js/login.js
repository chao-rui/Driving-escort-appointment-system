new Vue({
    el: '#app',
    data:{
        userId:'',
        password:''
    },
    methods:{
        register(){
            window.location.href="/register"
        },
        login(){
            $.ajax({
                url:"/user/login",
                type:"POST",
                data:{
                    "userId":this.userId,
                    "password":this.password
                },
                success:function(data){
                    $("body").html(data);
                }
            })
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