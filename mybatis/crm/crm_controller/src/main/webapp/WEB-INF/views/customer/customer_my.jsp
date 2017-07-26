<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>凯盛软件CRM-首页</title>
    <%@ include file="../base/base-css.jsp"%>
    <style>
        .name-avatar {
            display: inline-block;
            width: 50px;
            height: 50px;
            background-color: #ccc;
            border-radius: 50%;
            text-align: center;
            line-height: 50px;
            font-size: 24px;
            color: #FFF;
        }
        .table>tbody>tr:hover {
            cursor: pointer;
        }
        .table>tbody>tr>td {
            vertical-align: middle;
        }
        .star {
            font-size: 20px;
            color: #ff7400;
        }
    </style>
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
                    <h3 class="box-title">搜索</h3>
                </div>
                <div class="box-body">
                    <form class="form-inline">
                        <div class="form-group">
                            <input type="text" name="keyword" placeholder="姓名或者电话号码" value="${keyword}" class="form-control">
                            <button class="btn btn-success"><i class="fa fa-search"></i></button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">我的客户</h3>
                    <div class="box-tools pull-right">
                        <a href="/manage/customer/add" class="btn btn-success btn-sm"><i class="fa fa-plus"></i> 新增客户</a>
                        <button id="excel" class="btn btn-primary btn-sm"><i class="fa fa-file-excel-o"></i> 导出Excel</button>
                    </div>
                </div>
                <div class="box-body no-padding">
                    <c:if test="${not empty message}">
                        <div class="alert alert-info">
                            ${message}
                            <button class="close" data-dismiss="alert"><span>&times;</span></button>
                        </div>

                    </c:if>
                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <th width="80"></th>
                            <th>姓名</th>
                            <th>职位</th>
                            <th>跟进时间</th>
                            <th>级别</th>
                            <th>联系方式</th>
                        </tr>
                        <c:choose>
                            <c:when test="${not empty page.list}">
                                <c:forEach items="${page.list}" var="customer">
                                    <tr rel="${customer.id}" class="customer_info">
                                        <td><span class="name-avatar" style= "background-color:${customer.sex == '先生' ? 'blue' : 'pink'}">${fn:substring(customer.name, 0,1 )}</span></td>
                                        <td>${customer.name}</td>
                                        <td>${customer.position}</td>
                                        <td><fmt:formatDate value="${customer.lastContactTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                        <td class="star">${customer.level}</td>
                                        <td><i class="fa fa-phone"></i> ${customer.tel} <br></td>
                                    </tr>

                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6">你还没有一个各户，请加油努力💪</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                    <c:if test="${page.pages > 1}">
                        <ul class="pagination pull-right" id="pagination"></ul>
                    </c:if>
                </div>
                <!-- /.box-body -->
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
<script src="/static/js/jquery.twbsPagination.min.js"></script>
<script src="/static/js/layer/layer.js"></script>
<script>
    $(function(){

        <c:if test="${page.pages > 1}">
            $("#pagination").twbsPagination({
               totalPages : ${page.pages},
               visiblePages : 7,
                href: "/customer/my?p={{number}}&keyword=${keyword}",
                first: "首页",
                prev: "上一页",
                next:"下一页",
                last:"末页"
            });
       </c:if>

        $(".customer_info").click(function(){
              var id = $(this).attr("rel");
              window.location.href = "/customer/my/" + id;

        });

        $("#excel").click(function(){
            layer.confirm("确定要导出excel吗?",function (index) {
                layer.close(index);
                window.location.href = "/customer/my/export";
            })
        });

    })
</script>
</body>

</html>
