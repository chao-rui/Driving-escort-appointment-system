new Vue({
    el: '#app',
    mounted:function (){
        if(sessionStorage.getItem("roleFlag")!=="1"){
            this.readOnly=true;
            this.getUserInfo();
        }
    },
    data:{
        form: {
            userRName: '',
            idNumber: '',
        },
        readOnly:false,
        loading: false,
        rules: {
            userRName: [
                {required: true, message: '请输入真实姓名', trigger: 'blur'},
                {max: 10, message: '真实姓名长度不能超过10位', trigger: 'blur'}
            ],
            idNumber: [
                {required: true, message: '请输入身份证号', trigger: 'blur'},
                {pattern: /^1\d{17}$/, message: '手机号码必须是18位数字', trigger: 'blur'}
            ]
        }
    },
    methods: {
        getUserInfo(){
            let that= this;
            $.ajax({
                url:"user/getUserInfo",
                contentType: "application/json",
                dataType:"JSON",
                data:{
                    "userId":sessionStorage.getItem("userId")
                },
                success:function (data){
                    console.log(data);
                    that.form.userRName=data.userRname;
                    that.form.idNumber=data.idNumber;
                }
            });
        },
        save(){
            let that= this;
            this.$refs.form.validate(valid => {
                if (valid) {
                    that.loading=true;
                    $.ajax({
                        url: "user/setRName",
                        data: {
                            userRName: this.form.userName,
                            idNumber: this.form.idNumber,
                            userId: sessionStorage.getItem("userId")
                        },
                        success: function (data) {
                            that.$notify({
                                title: '成功',
                                message: '更新成功',
                                type: 'success'
                            });
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
        }
    }
})
