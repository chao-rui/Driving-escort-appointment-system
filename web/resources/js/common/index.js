new Vue({
    el: '#app',
    data:{
        today:'',
        src:'show?url=common/main'
    },
    methods:{
        changeContext(Index,menuItem){
            this.src="show?url="+Index;
        },
        close(){
            this.$confirm('确认退出系统？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                window.location.href="/";
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消退出'
                });
            });
        },
        exitCS(){
            this.$confirm('此操作将会从您的驾校删除您的个人信息，是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                $.ajax({
                    url: "/Coach/delCoach",
                    type: "POST",
                    data: {
                        "userId": sessionStorage.getItem("userId"),
                    },
                    success: function (data) {
                        if(data){
                            window.location.href="/"
                        }else{
                            alert("操作失败！")
                        }
                    },
                    errors: function (e) {
                        alert("操作失败！")
                    }
                });
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消操作'
                });
            });
        },
        logout(){
            this.$confirm('此操作将永久删除您账户内的所有信息，是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                $.ajax({
                    url: "/Coach/delCoach",
                    type: "POST",
                    success: function (data) {
                        if(data){
                            window.location.href="/"
                        }else{
                            alert("操作失败！")
                        }
                    },
                    errors: function (e) {
                        alert("操作失败！")
                    }
                });
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消删除'
                });
            });
        },
        checkId(){
            this.$prompt('请输入密码以验证身份', '验证', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                inputPattern: /^[a-zA-Z0-9]+$/,
                inputErrorMessage: '密码格式不正确'
            }).then(({ value }) => {
                $.ajax({
                    url: "login",
                    type: "POST",
                    data: {
                        "userId": sessionStorage.getItem("userId"),
                        "password":value,
                    },
                    success: function (data) {
                        if(data){
                            window.location.href="/"
                        }else{
                            alert("操作失败！")
                        }
                    },
                    errors: function (e) {
                        alert("操作失败！")
                    }
                });
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '取消操作'
                });
            });
        }
    }
})