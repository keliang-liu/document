<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>凯盛软件CRM-首页</title>
    <%@ include file="../base/base-css.jsp"%>
    <style>
        .table>tbody>tr:hover {
            cursor: pointer;
        }
        .table>tbody>tr>td {
            vertical-align: middle;
        }

    </style>
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
            <!-- Default box -->
            <div class="box">
                <div class="box-header with-border">
                    <h3>搜索</h3>
                </div>
                <div class="box-body">
                    <form class="form-inline" method="get">
                        <div class="form-group">
                            <input type="text" name="keyword" value="${keyword}" placeholder="请输入客户姓名" class="form-control">
                            <button class="btn btn-success"><i class="fa fa-search"></i>搜索</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">我的销售机会</h3>

                    <div class="box-tools pull-right">
                        <a href="/sales/my/new" class="btn  btn-success">
                          <i class="fa fa-plus"></i> 添加机会
                        </a>
                    </div>
                </div>
                <div class="box-body">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <td>机会名称</td>
                            <td>关联客户</td>
                            <td>机会价值</td>
                            <td>当前进度</td>
                            <td>最后跟进时间</td>
                        </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty page.list}">
                                    <c:forEach items="${page.list}" var="sales">
                                        <tr class="salesId" rel="${sales.id}">
                                            <td>${sales.chanceName}</td>
                                            <td>${sales.customer.name}</td>
                                            <td><fmt:formatNumber value="${sales.worth}"/></td>
                                            <td>${sales.currentProgress}</td>
                                            <td><fmt:formatDate value="${sales.lastContactTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6">
                                            <span>暂无数据！请抓紧记录吧</span>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                    <div class="box-footer">
                        <c:if test="${page.pages > 1}">
                            <ul class="pagination pull-right" id="pagination"></ul>
                        </c:if>
                    </div>
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
<script src="/static/js/jquery.twbsPagination.min.js"></script>
<script src="/static/js/layer/layer.js"></script>
<script>
    $(function(){
        <c:if test="${page.pages > 1}">
            $("#pagination").twbsPagination({

                totalPages : ${page.pages},
                visiblePages : 3,
                href : '/sales/my?p={{number}}&keyword=' + encodeURIComponent("${keyword}"),
                prev : "上一页",
                first : '首页',
                last : '尾页',
                next : '下一页'
            });
        </c:if>

        $(".salesId").click(function(){
            var id = $(this).attr("rel");
            window.location.href = '/sales/my/' + id + '/info';

        })



    });


</script>
</body>

</html>
