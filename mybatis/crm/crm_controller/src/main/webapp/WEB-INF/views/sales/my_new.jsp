<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>凯盛软件CRM-首页</title>
    <%@ include file="../base/base-css.jsp"%>
    <link rel="stylesheet" href="/static/plugins/select2/select2.css">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">
    <%--<%@include file="../base/base-side.jsp"%>--%>
    <jsp:include page="../base/base-side.jsp">
        <jsp:param name="active" value="/sales/my"/>
    </jsp:include>
    <!-- 右侧内容部分 -->
    <div class="content-wrapper">

        <!-- Main content -->
        <section class="content">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">我的销售机会</h3>

                    <div class="box-tools pull-right">
                        <a href="/sales/my"  type="button" class="btn btn-info">
                            <i class="fa fa-back">返回列表</i>
                        </a>
                    </div>
                </div>

            <!-- /.box-body -->
                <div class="box-body">
                    <form id="addForm">
                        <div class="form-group">
                            <label>机会名称</label>
                            <input type="text" class="form-control" name="chanceName">
                        </div>
                        <div class="form-group">
                            <label>关联客户</label>
                            <select name="customerId" id="cust" class="form-control" style="width : 100%">
                                <option value=""></option>
                                <c:if test="${empty customerList}">
                                    <option value="">请先添加你的客户</option>
                                </c:if>
                                <c:if test="${not empty customerList}">
                                    <c:forEach items="${customerList}" var="cust">
                                        <c:if test="${cust.id == custId}">
                                            <option value="${cust.id}" selected readonly="readonly">${cust.name}('${cust.tel}')</option>
                                        </c:if>
                                        <c:if test="${cust.id != custId}">
                                            <option value="${cust.id}" >${cust.name}('${cust.tel}')</option>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>机会价值</label>
                            <input type="text" class="form-control" name="worth">
                        </div>
                        <div class="form-group">
                            <label>当前进度</label>
                            <select name="currentProgress" class="form-control" id="progress" style="width : 100%">
                                <option value=""></option>
                                <c:forEach items="${progressList}" var="progress">
                                    <option value="${progress}">${progress}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>详细内容</label>
                            <textarea name="remark" class="form-control"></textarea>
                        </div>
                    </form>
                </div>
                <div class="box-footer">
                    <button class="btn btn-primary" id="addBtn">保存</button>
                </div>

            </div>
        <!-- /.box -->
    </section>

        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <%@ include file="../base/base-footer.jsp"%>

</div>
<!-- ./wrapper -->

<%@include file="../base/base-js.jsp"%>
<script src="/static/plugins/select2/select2.min.js"></script>
<script src="/static/js/validate/jquery.validate.min.js"></script>
<script src="/static/js/layer/layer.js"></script>
<script>
    $(function(){

       $("#cust").select2();
       $("#progress").select2();

       $("#addBtn").click(function () {
           $("#addForm").submit();
       })

       $("#addForm").validate({

          errorClass : 'text-danger',
          errorElement : 'span',
          rules : {
              chanceName:{
                  required : true,
              },
              customerId : {
                  required : true,
              },
              worth:{
                  required : true,
                  number : true,
              },
              currentProgress : {
                  required : true,
              },

          },
          messages : {
              chanceName:{
                  required : "请输入机会名称",
              },
              customerId : {
                  required : "请选择关联的客户",
              },
              worth:{
                  required : "请输入机会的价值",
                  number : "只能输入数字",
              },
              currentProgress : {
                  required : "请选择当前进度",
              },

          },
          submitHandler : function () {
              $.ajax({
                type : 'post',
                url : '/sales/my/new',
                data : $("#addForm").serialize(),
                beforeSend : function(){
                    $("#addBtn").attr("disabled","disabled").text("提交中...");
                },
                success : function(data){

                    if(data.state == 'success'){
                       window.location.href = '/sales/my';
                    }else {
                        layer.msg(data.message);
                    }
                },
                error : function(){
                    layer.msg("系统异常");
                },
                complete : function(){
                    $("#addBtn").removeAttr("disabled").text("保存");
                }

              });

          }

       });

    });

</script>
</body>
</html>
