new Vue({
    el: '#app',
    data:{
        today:'',
        src:'show?url=common/main',
        isChecked:false
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
        exitCS() {
            let that = this;
            this.$confirm('此操作将会从您的驾校删除您的个人信息，是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(async () => {
                await that.checkId();
                if (that.isChecked) {
                    $.ajax({
                        url: "/Coach/delCoach",
                        type: "POST",
                        data: {
                            "userId": sessionStorage.getItem("userId"),
                        },
                        success: function (data) {
                            if (data) {
                                window.location.href = "/"
                            } else {
                                that.$message({
                                    type: 'error',
                                    message: '请求失败'
                                });
                            }
                        },
                        errors: function (e) {
                            that.$message({
                                type: 'error',
                                message: '请求失败'
                            });
                        }
                    });
                } else {
                    this.$message({
                        type: 'error',
                        message: '密码错误'
                    });
                }
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消操作'
                });
            });
        },
        logout() {
            let that=this;
            this.$confirm('此操作将永久删除您账户内的所有信息，是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(async () => {
                await this.checkId();
                if (that.isChecked) {
                    $.ajax({
                        url: "/user/updRole",
                        data: {
                            "roleFlag": 0,
                            "userId":sessionStorage.getItem("userId")
                        },
                        type: "POST",
                        success: function (data) {
                            if (data) {
                                window.location.href = "/"
                            } else {
                                that.$message({
                                    type: 'error',
                                    message: '请求失败'
                                });
                            }
                        },
                        errors: function (e) {
                            that.$message({
                                type: 'error',
                                message: '请求失败'
                            });
                        }
                    });
                }else {
                    this.$message({
                        type: 'error',
                        message: '密码错误'
                    });
                }
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消删除'
                });
            });
        },
        async checkId(){
            let that=this;
            await this.$prompt('请输入密码以验证身份', '验证', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                inputPattern: /^[a-zA-Z0-9]+$/,
                inputErrorMessage: '密码格式不正确'
            }).then(async ({value}) => {
                $.ajax({
                    url: "login",
                    type: "POST",
                    data: {
                        "userId": sessionStorage.getItem("userId"),
                        "password": value,
                    },
                    success: await function (data) {
                        if (data != null) {
                            that.isChecked = true
                        } else {
                            this.$message({
                                type: 'error',
                                message: '密码错误'
                            });
                        }
                    },
                    errors: function (e) {
                        this.$message({
                            type: 'error',
                            message: '请求失败'
                        });
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