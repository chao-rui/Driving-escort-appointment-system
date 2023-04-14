new Vue({
    el: '#app',
    data:{
        today:'',
        src:'show?url=common/main'
    },
    methods:{
        changeContext(Index,menuItem){
            this.src="show?url="+Index;
        }
    }
})