<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>凯盛软件CRM-首页</title>
    <%@ include file="base/base-css.jsp"%>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">
    <%--<%@include file="base/base-side.jsp"%>--%>
    <jsp:include page="base/base-side.jsp">
        <jsp:param name="active" value="home"/>
    </jsp:include>
    <!-- 右侧内容部分 -->
    <div class="content-wrapper">

        <!-- Main content -->
        <section class="content">

            <div class="container">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        修改个人信息
                    </div>
                    <div class="panel-body">
                        <form method="post" id="modifyForm">
                            <div class="form-group">
                                <label>原始密码</label>
                                <input type="password" class="form-control"  name="oldPassword"/>
                            </div>
                            <div class="form-group">
                                <label>新密码</label>
                                <input type="password" class="form-control" id="password" name="password"/>
                            </div>
                            <div class="form-group">
                                <label>再次确认密码</label>
                                <input type="password" class="form-control"  name="rePassword"/>
                            </div>
                        </form>
                    </div>
                    <div class="panel-footer">
                        <button type="button" id="modifyBtn" class="btn btn-info">修改</button>
                    </div>
                </div>

            </div>


        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <%@ include file="base/base-footer.jsp"%>

</div>
<!-- ./wrapper -->

<%@include file="base/base-js.jsp"%>
<script src="/static/js/validate/jquery.validate.min.js"></script>
<script src="/static/js/layer/layer.js"></script>
<script>
    $("#modifyBtn").click(function(){

        $("#modifyForm").submit();

    })

    $("#modifyForm").validate({

       errorClass : 'text-danger',
       errorElement : 'span',
       rules : {

           oldPassword : {
               required : true,

           },
           password : {
               required : true,

           },

           rePassword : {
               required : true,
               equalTo : '#password'
           }

       },
       messages : {

           oldPassword : {
               required : "请输入原始密码",

           },
           password : {
               required : "请输入新密码",

           },

           rePassword : {
               required : "请输确认密码",
               equalTo : "两次密码输入的不一致"
           }


       },
       submitHandler : function () {

           $.post("/profile",$("#modifyForm").serialize()).done(function(data){
               if(data.state == 'success') {
                    layer.msg("修改成功");
               }else {
                   layer.msg(data.message);s
               }
           }).error(function(){
               layer.msg("服务器异常");
           });

       }

    });

</script>
</body>
</html>

