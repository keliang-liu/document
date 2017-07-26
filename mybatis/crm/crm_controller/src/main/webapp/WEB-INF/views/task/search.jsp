<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>凯盛软件CRM-首页</title>
    <%@ include file="../base/base-css.jsp"%>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">
    <%--<%@include file="../base/base-side.jsp"%>--%>
    <jsp:include page="../base/base-side.jsp">
        <jsp:param name="active" value="/task/search"/>
    </jsp:include>

    <!-- 右侧内容部分 -->
    <div class="content-wrapper">

        <!-- Main content -->
        <section class="content">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">计划任务</h3>
                    <div class="box-tools pull-right">
                        <a href="/task/new"  class="btn btn-success btn-sm"><i class="fa fa-plus"></i> 新增任务</a>
                        <c:if test="${empty showAll}">
                            <a href="/task/search?showAll=all" class="btn btn-primary btn-sm"><i class="fa fa-eye"></i> 显示所有任务</a>
                        </c:if>
                        <c:if test="${not empty showAll}">
                            <a href="/task/search" class="btn btn-primary btn-sm"><i class="fa fa-eye"></i> 显示未完成的任务</a>
                        </c:if>

                    </div>
                </div>
                <div class="box-body">
                    <ul class="todo-list">
                        <c:choose>
                            <c:when test="${not empty taskList}">
                                <c:forEach items="${taskList}" var="task">

                                    <li class="${task.state == 0 ? 'done' : ''} ">
                                        <input type="checkbox" ${task.state == 0 ? 'checked': '' } class="todoList" value="${task.id}" rel="${task.state}"/>
                                        <span class="text">${task.taskName}</span>
                                        <c:if test="${not empty task.customerId}">
                                            <a href="/customer/my/${task.customerId}"><i class="fa fa-user-o"></i>${task.customer.name}</a>
                                        </c:if>
                                        <c:if test="${not empty task.salesId}">
                                            <a href="/sales/my/${task.salesId}/info"><i class="fa fa-money"></i>${task.sales.chanceName}</a>
                                        </c:if>
                                        <small class="label label-danger "><i class="fa fa-clock-o"></i>${task.completeTime}</small>
                                        <div class="tools">
                                            <i class="fa fa-edit editBtn"  rel="${task.id}"></i>
                                            <i class="fa fa-trash-o delBtn"  rel="${task.id}"></i>
                                        </div>

                                    </li>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <li>暂无数据！</li>
                            </c:otherwise>
                        </c:choose>

                        
                    </ul>
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
<script src="/static/js/layer/layer.js"></script>
<script>
    $(function(){

       $(".todoList").click(function () {
           var id = $(this).val();
           window.location.href = '/task/edit/' + id + "?showAll=${showAll}" ;
       });

       $(".delBtn").click(function () {
           var id = $(this).attr("rel");
           layer.confirm("确定要删除吗？",function () {
                $.get("/task/del/" + id).done(function(data){

                    if(data.state == 'success') {
                        layer.alert("删除成功",function(){
                            window.history.go(0);
                        });
                    }else{
                        layer.msg(data.message);
                    }

                }).error(function(){
                    layer.msg("服务器异常");
                });
           })

       })

    });

</script>
</body>
</html>
