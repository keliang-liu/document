<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>凯盛软件CRM-首页</title>
    <%@ include file="../base/base-css.jsp"%>
    <link rel="stylesheet" href="/static/plugins/datetimepicker/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="/static/plugins/datepicker/datepicker3.css">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">
   <%-- <%@include file="../base/base-side.jsp"%>--%>
    <jsp:include page="../base/base-side.jsp">
        <jsp:param name="active" value="/task/search"/>
    </jsp:include>

    <!-- 右侧内容部分 -->
    <div class="content-wrapper">

        <!-- Main content -->
        <section class="content">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">新增待办任务</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool">
                            <i class="fa fa-plus"></i> 返回列表
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <form action="/task/new" id="addForm" method="post">
                        <input type="hidden" value="${sessionScope.currentAccount.id}" name="accountId">
                        <input type="hidden" value="${customerId}" name="customerId">
                        <input type="hidden" value="${salesId}" name="salesId">
                        <div class="form-group">
                            <label>任务名称</label>
                            <input type="text" class="form-control" name="taskName">
                        </div>
                        <div class="form-group">
                            <label>完成日期</label>
                            <input type="text" class="form-control" id="datepicker" name="completeTime">
                        </div>
                        <div class="form-group">
                            <label>提醒时间</label>
                            <input type="text" class="form-control" id="datepicker2" name="reminderTime">
                        </div>
                    </form>
                </div>
                <!-- /.box-body -->
                <div class="box-footer">
                    <button class="btn btn-primary" id="addBtn">保存</button>
                </div>
            </div>

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <%@ include file="../base/base-footer.jsp"%>

</div>
<!-- ./wrapper -->

<%@include file="../base/base-js.jsp"%>

<script src="/static/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="/static/plugins/datepicker/locales/bootstrap-datepicker.zh-CN.js"></script>
<script src="/static/plugins/datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script src="/static/plugins/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="/static/js/moment.js"></script>
<script src="/static/js/validate/jquery.validate.min.js"></script>

<script>
    $(function(){

        $("#datepicker").datepicker({
            format : 'yyyy-mm-dd',
            language : 'zh-CN',
            autoclose: true,
            todayHighlight : true,
            startDate : moment().format('yyyy-MM-dd')
        }).on("changeDate",function(e){
            var today = moment().format("YYYY-MM-DD");

            datepicker.datetimepicker("setStartDate",today);
            datepicker.datetimepicker("setEndDate",e.format("yyyy-mm-dd"));
        });


        var datepicker = $("#datepicker2").datetimepicker({
            format : 'yyyy-mm-dd HH:ii',
            language : 'zh-CN',
            autoclose : true,
            todayHighlight : true,
        });



        $("#addBtn").click(function(){
            $("#addForm").submit();
        });

        $("#addForm").validate({

            errorClass : 'text-danger',
            errorElement : 'span',

            rules : {
                taskName : {
                    required : true,

                },
                completeTime : {
                    required : true,
                }
            },

            messages : {
                taskName : {
                    required : "请输入代办事项的名称",
                },
                completeTime : {

                    required : "请输入要完成的时间",
                }

            }

        });



    });


</script>
</body>
</html>
