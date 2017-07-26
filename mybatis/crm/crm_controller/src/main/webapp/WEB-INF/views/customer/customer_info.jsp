<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>凯盛软件CRM-客户详情</title>
    <%@ include file="../base/base-css.jsp"%>
    <link rel="stylesheet" href="/static/plugins/select2/select2.css">
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
    <c:choose>
        <c:when test="${customer.accountId != 1}">
            <jsp:include page="../base/base-side.jsp">
                <jsp:param name="active" value="customer/my"/>
            </jsp:include>
        </c:when>
        <c:otherwise>
            <jsp:include page="../base/base-side.jsp">
                <jsp:param name="active" value="customer/public"/>
            </jsp:include>
        </c:otherwise>
    </c:choose>

    <!-- 右侧内容部分 -->
    <div class="content-wrapper">

        <!-- Main content -->
        <section class="content">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">客户资料</h3>
                    <div class="box-tools">
                        <c:if test="${customer.accountId != 1}">
                            <a href="/customer/my" class="btn btn-primary btn-sm"><i class="fa fa-arrow-left"></i> 返回列表</a>
                        </c:if>
                        <c:if test="${customer.accountId == 1}">
                            <a href="/customer/public" class="btn btn-primary btn-sm"><i class="fa fa-arrow-left"></i> 返回列表</a>
                        </c:if>
                        <c:if test="${customer.accountId != 1}">
                            <a href="/customer/my/${customer.id}/edit" class="btn bg-purple btn-sm"><i class="fa fa-pencil"></i> 编辑</a>
                        </c:if>

                        <c:if test="${customer.accountId != 1}">
                            <button id="transferOtherBtn" class="btn bg-orange btn-sm"><i class="fa fa-exchange"></i> 转交他人</button>
                            <button  id="transferPublicBtn" class="btn bg-maroon btn-sm"><i class="fa fa-recycle"></i> 放入公海</button>
                        </c:if>
                        <c:if test="${customer.accountId == 1}">
                            <a href="/customer/public/${customer.id}/tran/my" class="btn bg-orange btn-sm"><i class="fa fa-exchange"></i>抢占客户</a>
                        </c:if>
                        <button id="delBtn" rel="${customer.id}" class="btn btn-danger btn-sm"><i class="fa fa-trash-o"></i> 删除</button>
                    </div>
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
                <div class="box-footer">
                    <c:if test="${not empty customer.reminder}">
                        <span style="color : #ccc"><i class="fa fa-exchange"></i>${customer.reminder}</span>
                    </c:if>
                    <span style="color: #ccc" class="pull-right">
                        创建日期： <fmt:formatDate value="${customer.createTime}" type="both" pattern="yyyy-MM-dd HH:mm"/> &nbsp;&nbsp;&nbsp;&nbsp;
                        <c:if test="${not empty customer.updateTime}">
                            最后修改日期：<fmt:formatDate value="${customer.updateTime}" type="both" pattern="yyyy-MM-dd HH:mm"/>
                        </c:if>
                    </span>
                </div>
            </div>

            <div class="row">
                <div class="col-md-8">
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">销售机会</h3>
                            <a href="/sales/my/new?custId=${customer.id}" class="btn btn-success btn-xs pull-right"><i class="fa fa-plus"></i></a>
                        </div>
                        <div class="box-body">
                            <ul class="list-group">
                                <c:choose>
                                    <c:when test="${not empty salesList}">
                                        <c:forEach items="${salesList}" var="sales">
                                            <li class="list-group-item">${sales.chanceName}</li>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="list-group-item">暂无销售机会!</li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="box">
                        <div class="box-body">
                            <img src="/customer/qrCode/${customer.id}">

                        </div>
                    </div>

                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">代办事项</h3>
                            <div class="box-tools">
                                <a href="/task/new?customerId=${customer.id}" class="btn btn-xs"><i class="fa fa-plus"></i></a>

                            </div>
                        </div>
                        <div class="box-body">
                            <ul class="todo-list">
                                <c:choose>
                                    <c:when test="${not empty taskList}">
                                        <c:forEach items="${taskList}" var="task">
                                            <c:if test="${task.customerId == customer.id}">
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
<div class="modal fade" id="transModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">转交他人</h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
              <select  id="accountSelect" class="form-control" style="width : 100%">
                  <option value=""></option>
                  <c:forEach items="${accountList}" var="account">
                      <c:if test="${sessionScope.currentAccount.id != account.id}">
                          <option value="${account.id}">${account.userName}</option>
                      </c:if>
                  </c:forEach>
              </select>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="trans">转交</button>
      </div>
    </div>
  </div>
</div>
<!-- ./wrapper -->

<%@include file="../base/base-js.jsp"%>
<script src="/static/plugins/layer/layer.js"></script>
<script src="/static/js/layer/layer.js"></script>
<script src="/static/plugins/select2/select2.min.js"></script>
<script>


    $(function () {


        var id = ${customer.id};

        $("#accountSelect").select2();

        $("#transferOtherBtn").click(function(){

            $("#transModal").modal({
                show : true,
            })

        });

        $("#trans").click(function () {
            var accountId = $("#accountSelect").val();
            if(!accountId) {
                layer.msg("请选择要转交的人");
                return
            }
            layer.confirm("确定要转交客户吗？",function(){
                window.location.href = "/customer/my/" + id + "/tran/" + accountId;
            })
        });

        $("#transferPublicBtn").click(function () {
            layer.confirm("确认要包客户放进到公海吗？",function () {
                window.location.href = "/customer/my/" + id + "/tran/public";
            })
        });

        $(".todoList").click(function(){
            var id = $(this).val();
            window.location.href = '/task/edit/' + id + "?custId=${customer.id}";
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

