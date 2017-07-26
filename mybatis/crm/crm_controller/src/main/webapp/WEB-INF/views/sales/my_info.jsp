<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>凯盛软件CRM-首页</title>
    <%@ include file="../base/base-css.jsp"%>
    <style>
        .td_title {
            font-weight: bold;
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
    <%--<%@include file="../base/base-side.jsp"%>--%>
    <jsp:include page="../base/base-side.jsp">
        <jsp:param name="active" value="/sales/my"/>
    </jsp:include>

    <!-- 右侧内容部分 -->
    <div class="content-wrapper">

        <!-- Main content -->
        <section class="content">
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    ${message}
                    <button class="close" data-dismiss="alert"><span>&times;</span></button>
                </div>
            </c:if>


            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">销售机会基本资料</h3>
                    <div class="box-tools">
                        <a href="/sales/my" class="btn btn-primary btn-sm"><i class="fa fa-arrow-left"></i> 返回列表</a>
                        <button id="delBtn" class="btn btn-danger btn-sm"><i class="fa fa-trash-o"></i> 删除</button>
                    </div>
                </div>
                <div class="box-body no-padding">
                    <table class="table">
                        <tr>
                            <td class="td_title">机会名称</td>
                            <td>${sales.chanceName}</td>
                            <td class="td_title">价值</td>
                            <td><fmt:formatNumber value="${sales.worth}"/> </td>
                            <td class="td_title">当前进度</td>
                            <td>
                                ${sales.currentProgress}
                                <button class="btn btn-xs btn-success" id="showChangeProgressModalBtn"><i class="fa fa-pencil"></i></button>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="box-footer">
                    <span style="color: #ccc" class="pull-right">
                        创建日期：<fmt:formatDate value="${sales.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                    </span>
                </div>
            </div>

            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">关联客户资料</h3>
                </div>
                <div class="box-body no-padding">
                    <table class="table">
                        <tr>
                            <td class="td_title">姓名</td>
                            <td>${customer.name}</td>
                            <td class="td_title">职位</td>
                            <td>${customer.position}</td>
                            <td class="td_title">联系电话</td>
                            <td>${customer.tel}</td>
                        </tr>
                        <tr>
                            <td class="td_title">所属行业</td>
                            <td>${customer.trade}</td>
                            <td class="td_title">客户来源</td>
                            <td>${customer.source}</td>
                            <td class="td_title">级别</td>
                            <td class="star">${customer.level}</td>
                        </tr>
                        <c:if test="${not empty customer.address}">
                            <tr>
                                <td class="td_title">地址</td>
                                <td colspan="5">${customer.address}</td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty customer.remark}">
                            <tr>
                                <td class="td_title">备注</td>
                                <td colspan="5">${customer.remark}</td>
                            </tr>
                        </c:if>
                    </table>
                </div>
            </div>

            <div class="row">
                <div class="col-md-8">
                   <h4>
                       跟进记录
                       <small><button class="btn btn-success btn-xs" id="showRecordModal"><i class="fa fa-plus"></i></button></small>
                   </h4>
                    <ul class="timeline">
                        <c:if test="${ empty salesRecordList}">
                            <li>
                                <i class="fa fa-circle-o bg-red"></i>
                                <div class="timeline-item">
                                    <div class="time-body">
                                        暂无数据！
                                    </div>
                                </div>
                            </li>
                        </c:if>
                        <c:forEach items="${salesRecordList}" var="record">
                            <c:choose>
                                <c:when test="${record.content == '将当前进度修改为[成交]'}">
                                    <li>
                                        <i class="fa fa-check bg-green"></i>
                                        <div class="timeline-item">
                                            <span class="time"><i class="fa fa-clock-o"></i> <fmt:formatDate value="${record.updateTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                            <div class="timeline-body">
                                                ${record.content}
                                            </div>
                                        </div>
                                    </li>
                                </c:when>
                                <c:when test="${record.content == '将当前进度修改为[暂时搁置]'}">
                                    <li>
                                        <i class="fa fa-close bg-red"></i>
                                        <div class="timeline-item">
                                            <span class="time"><i class="fa fa-clock-o"></i> <fmt:formatDate value="${record.updateTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                            <div class="timeline-body">
                                                    ${record.content}
                                            </div>
                                        </div>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li>
                                        <i class="fa fa-info bg-blue"></i>
                                        <div class="timeline-item">
                                            <span class="time"><i class="fa fa-clock-o"></i> <fmt:formatDate value="${record.updateTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                            <div class="timeline-body">
                                                    ${record.content}
                                            </div>
                                        </div>
                                    </li>
                                </c:otherwise>
                            </c:choose>

                        </c:forEach>
                    </ul>
                </div>
                <div class="col-md-4">

                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">代办事项</h3>
                            <div class="box-tools">
                                <a href="/task/new?salesId=${sales.id}" class="btn btn-xs"><i class="fa fa-plus"></i></a>
                            </div>
                        </div>
                        <div class="box-body">
                            <ul class="todo-list">
                                <c:choose>
                                    <c:when test="${not empty taskList}">
                                        <c:forEach items="${taskList}" var="task">
                                            <c:if test="${task.salesId == sales.id}">
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
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <li>暂无数据！</li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">相关资料</h3>
                        </div>
                        <div class="box-body">

                        </div>
                    </div>
                </div>
            </div>

        </section>

        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <%@ include file="../base/base-footer.jsp"%>

</div>
<div class="modal fade" id="changeProgressModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">改变进度</h4>
            </div>
            <div class="modal-body">
                <form  action="/sales/my/progress/change" method="post" id="progressChangeForm">
                    <input type="hidden" name="customerId" value="${customer.id}"/>
                    <input type="hidden" name="salesId" value="${sales.id}"/>
                    <select name="progress" class="form-control">
                        <option value=""></option>
                        <c:forEach items="${progressList}" var="progress">
                            <option value="${progress}">${progress}</option>
                        </c:forEach>
                    </select>

                </form>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary" id="progressChangeBtn">修改</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="changeContentModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="ModalLabel">添加跟进记录</h4>
      </div>
      <div class="modal-body">
          <form action="/sales/my/${sales.id}/content/change" method="post" id="changeContentForm">
              <input type="hidden" name="customerId" value="${customer.id}">
              <textarea name="content" cols="30" rows="10" class="form-control"></textarea>
          </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="changeContentBtn">修改</button>
      </div>
    </div>
  </div>
</div>


<!-- ./wrapper -->

<%@include file="../base/base-js.jsp"%>
<script src="/static/js/layer/layer.js"></script>
<script>
    $("#showChangeProgressModalBtn").click(function(){

        $("#changeProgressModal").modal({
            show : 'true',
            backdrop : 'static'
        });
    });

    $("#progressChangeBtn").click(function(){
        $("#progressChangeForm").submit();
    });

    $("#showRecordModal").click(function(){

        $("#changeContentModal").modal({

            show : true,
            backdrop : 'static'
        })

    });

    $("#changeContentBtn").click(function(){
        $("#changeContentForm").submit();
    });

    $(".todoList").click(function(){
        var id = $(this).val();
        window.location.href = "/task/edit/" + id + "?salesId=${sales.id}";
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

</script>

</body>
</html>
