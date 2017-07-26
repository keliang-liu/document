<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        <jsp:param name="active" value="customer/public"/>
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
                    <h3 class="box-title">公海客户</h3>
                    <div class="box-tools pull-right">
                        <button id = "addBtn" class="btn btn-success btn-sm"><i class="fa fa-plus"></i> 新增客户</button>
                        <button id="exportExcel" class="btn btn-primary btn-sm"><i class="fa fa-file-excel-o"></i> 导出Excel</button>

                        <a href="/customer/public/import" class="btn btn-info btn-sm"><i class="fa fa-file"></i>成批导入</a>
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
                            <th>描述</th>
                        </tr>
                        <c:choose>
                            <c:when test="${not empty page.list}">
                                <c:forEach items="${page.list}" var="customer">
                                    <tr rel="${customer.id}" class="customer_info">
                                        <td><span class="name-avatar" style= "background-color:${customer.sex == '先生' ? 'blue' : 'pink'}">${fn:substring(customer.name, 0,1 )}</span></td>
                                        <td>${customer.name}</td>
                                        <td>${customer.position}</td>
                                        <td>${customer.lastContactTime}</td>
                                        <td class="star">${customer.level}</td>
                                        <td><i class="fa fa-phone"></i> ${customer.tel} <br></td>
                                        <td>${customer.reminder}</td>
                                    </tr>

                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6">暂无数据！</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>

                </div>
                <div class="box-footer">
                    <c:if test="${page.pages > 1}">
                        <ul class="pagination pull-right" id="pagination"></ul>
                    </c:if>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->

        </section>
        <!-- /.content -->
        <div class="modal fade" id="addModal">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加公海客户</h4>
              </div>
              <div class="modal-body">
                  <form id="addForm">
                      <div class="form-group">
                          <label>姓名</label>
                          <input type="text" class="form-control" name="name">
                      </div>
                      <div class="form-group">
                          <label>性别</label>
                          <div>
                              <label class="radio-inline">
                                  <input type="radio" name="sex"  value="先生" checked> 先生
                              </label>
                              <label class="radio-inline">
                                  <input type="radio" name="sex"  value="女士"> 女士
                              </label>
                          </div>
                      </div>
                      <div class="form-group">
                          <label>职位</label>
                          <input type="text" class="form-control" name="position">
                      </div>
                      <div class="form-group">
                          <label>联系方式</label>
                          <input type="text" class="form-control" name="tel">
                      </div>
                      <div class="form-group">
                          <label>地址</label>
                          <input type="text" class="form-control" name="address">
                      </div>
                      <div class="form-group">
                          <label>所属行业</label>
                          <select class="form-control" name="trade">
                              <option value=""></option>
                              <option value="互联网">互联网</option>
                              <option value="电力能源">电力能源</option>
                              <option value="其他">其他</option>
                          </select>
                      </div>
                      <div class="form-group">
                          <label>客户来源</label>
                          <select name="source" class="form-control">
                              <option value=""></option>
                              <option value="DM广告">DM广告</option>
                              <option value="电视媒体">电视媒体</option>
                              <option value="网络媒体">网络媒体</option>
                              <option value="顾客推荐">顾客推荐</option>
                              <option value="主动上门">主动上门</option>
                              <option value="其他">其他</option>
                          </select>
                      </div>
                      <div class="form-group">
                          <label>级别</label>
                          <select class="form-control" name="level">
                              <option value=""></option>
                              <option value="★">★</option>
                              <option value="★★">★★</option>
                              <option value="★★★">★★★</option>
                              <option value="★★★★">★★★★</option>
                              <option value="★★★★★">★★★★★</option>
                          </select>
                      </div>
                      <div class="form-group">
                          <label>备注</label>
                          <input type="text" class="form-control" name="remark">
                      </div>
                  </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
              </div>
            </div>
          </div>
        </div>
    </div>

    <!-- /.content-wrapper -->

    <%@ include file="../base/base-footer.jsp"%>

</div>
<!-- ./wrapper -->

<%@include file="../base/base-js.jsp"%>
<script src="/static/js/jquery.twbsPagination.min.js"></script>
<script src="/static/js/validate/jquery.validate.min.js"></script>
<script src="/static/js/layer/layer.js"></script>

<script>
    $(function(){

        <c:if test="${page.pages > 1}">
            $("#pagination").twbsPagination({
               totalPages : ${page.pages},
               visiblePages : 7,
                href: "/customer/public?p={{number}}&keyword=${keyword}",
                first: "首页",
                prev: "上一页",
                next:"下一页",
                last:"末页"
            });
       </c:if>



        $(".customer_info").click(function () {
           var id = $(this).attr("rel");
           window.location.href = "/customer/public/" + id;

        });


        $("#addBtn").click(function () {

            $("#addModal").modal({
                show : true,
                backdrop  : 'static'
            })
        });

        $("#saveBtn").click(function(){

            $("#addForm").validate({
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
                    $.post("/customer/public/add",$("#addForm").serialize()).done(function(data){
                        if(data.state == 'success') {
                            $("#addForm")[0].reset();
                            layer.msg("添加成功");
                            window.history.go(0);
                        }else {
                            layer.msg(data.message);
                        }
                    }).error(function(){
                        layer.msg("服务器异常");
                    });

                }
            });
        });

        $("#saveBtn").click(function () {
            $("#addForm").submit();
        });

        //导出excel
        $("#exportExcel").click(function () {
            window.location.href = "/customer/public/export";
        });


    });
</script>
</body>

</html>
