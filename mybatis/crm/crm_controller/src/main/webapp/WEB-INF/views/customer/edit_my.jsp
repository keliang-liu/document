<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>凯盛软件CRM-修改客户</title>
    <%@ include file="../base/base-css.jsp"%>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">
    <%--<%@include file="base/base-side.jsp"%>--%>
    <jsp:include page="../base/base-side.jsp">
        <jsp:param name="active" value="customer/my"/>
    </jsp:include>
    <!-- 右侧内容部分 -->
    <div class="content-wrapper">

        <!-- Main content -->
        <section class="content">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">修改客户</h3>
                    <div class="box-tools pull-right">
                        <a href="/customer/my/${customer.id}" class="btn btn-info"><i class="fa fa-arrow-left"></i> 返回列表</a>
                    </div>
                </div>
                <div class="box-body">
                    <form id="addForm" action="/customer/my/${customer.id}/edit" method="post">
                        <input type="hidden" name="accountId" value="${customer.accountId}">
                        <input type="hidden" name="id" value="${customer.id}">
                        <div class="form-group">
                            <label>姓名</label>
                            <input type="text" class="form-control" name="name" value="${customer.name}">
                        </div>
                        <div class="form-group">
                            <label>性别</label>
                            <div>
                                <label class="radio-inline">
                                    <input type="radio" name="sex"  value="先生" ${customer.sex == '先生' ? 'checked' : ''}> 先生
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="sex"  value="女士" ${customer.sex == '女士' ? 'checked' : ''}> 女士
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>职位</label>
                            <input type="text" class="form-control" name="position" value="${customer.position}">
                        </div>
                        <div class="form-group">
                            <label>联系方式</label>
                            <input type="text" class="form-control" name="tel" value="${customer.tel}">
                        </div>
                        <div class="form-group">
                            <label>地址</label>
                            <input type="text" class="form-control" name="address" value="${customer.address}">
                        </div>
                        <div class="form-group">
                            <label>所属行业</label>
                            <select class="form-control" name="trade">
                                <option value=""></option>
                                <c:forEach items="${tradeList}" var="trade">
                                    <option value="${trade}" ${customer.trade == trade ? 'selected' : ''}>${trade}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>客户来源</label>
                            <select name="source" class="form-control">
                                <option value=""></option>
                                <c:forEach items="${sourceList}" var="source">
                                    <option value="${source}" ${customer.source == source ? 'selected' : ''}>${source}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>级别</label>
                            <select class="form-control" name="level">
                                <option value=""></option>
                                <option ${customer.level == '★' ? 'selected' : ''} value="★">★</option>
                                <option ${customer.level == '★★' ? 'selected' : ''} value="★★">★★</option>
                                <option ${customer.level == '★★★' ? 'selected' : ''} value="★★★">★★★</option>
                                <option ${customer.level == '★★★★' ? 'selected' : ''} value="★★★★">★★★★</option>
                                <option ${customer.level == '★★★★★' ? 'selected' : ''} value="★★★★★">★★★★★</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>备注</label>
                            <input type="text" class="form-control" name="remark" value="${customer.remark}">
                        </div>
                    </form>
                </div>
                <div class="box-footer">
                    <button  class="btn btn-primary" id="addBtn">修改</button>
                </div>
                <!-- /.box-body -->
            </div>


        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <%@ include file="../base/base-footer.jsp"%>

</div>
<!-- ./wrapper -->

<%@include file="../base/base-js.jsp"%>
<script src="/static/js/layer/layer.js"></script>
<script src="/static/js/validate/jquery.validate.min.js"></script>
<script>

    $("#addBtn").click(function () {

        $("#addForm").submit();
    });

    /*/!*$("#addForm").validate({

        errorClass : 'text-danger',
        errorElement : 'span',
        rules : {
            name : {
                required : true,

            },
            position : {

                required : true,
            },
            tel : {
                required : true,
                remote : '/manage/customer/validate/tel',
                digits : true,
            },
            address : {
                required : true,

            },
            level : {
                required : true,
            },

        },
        messages : {
            name : {
                required : "请输入姓名",

            },
            position : {
                required : "请输入职位",
            },
            tel : {
                required : "请输入联系方式",
                remote : "该电话号码已经存在",
                digits : "请输入正整数",
            },
            address : {
                required : "请输入地址",

            },
            level : {
                required : "请选择级别",
            },


        },
        submitHandler : function () {
            $.post("/manage/customer/add",$("#addForm").serialize()).done(function(data){
                 if(data.state == 'success') {
                     layer.msg("添加成功");
                 }else {
                     layer.msg(data.message);
                 }
            }).error(function(){
                layer.msg("服务器异常");
            });

        }*!/


     });*/


</script>

</body>


</html>
