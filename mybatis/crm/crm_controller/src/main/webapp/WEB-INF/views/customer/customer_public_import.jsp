<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>凯盛软件CRM-首页</title>
    <link rel="stylesheet" href="/static/upload/webuploader.css"/>
    <%@ include file="../base/base-css.jsp"%>

</head>
<body class="hold-transition skin-blue sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">
    <%--<%@include file="../base/base-side.jsp"%>--%>
    <jsp:include page="../base/base-side.jsp">
        <jsp:param name="active" value="/customer/public"/>
    </jsp:include>
    <!-- 右侧内容部分 -->
    <div class="content-wrapper">

        <!-- Main content -->
        <section class="content">
            <c:if test="${not empty message}">
               <div class="alert alert-info">
                      ${message}
                   <button class="close" data-dismiss="alert"><span>&times;</span></button>
               </div>
            </c:if>
           <form action="/customer/public/import" method="post" enctype="multipart/form-data">
               <input type="file" name="doc">
               <button>上传</button>
           </form>
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <%@ include file="../base/base-footer.jsp"%>

</div>
<!-- ./wrapper -->

<%@include file="../base/base-js.jsp"%>
<script src="/static/upload/webuploader.min.js"></script>
<script>
    /*var uploader = WebUploader.create({
        swf:'/static/upload/Uploader.swf', //指定flash上传文件的位置
        server:'/customer/public/import', //上传文件服务器的地址
        pick:'#picker', //文件选择按钮
        auto : true,
        fileVal:'doc'
    });
    uploader.on('fileQueued',function(file){
        var html = "<li class='list-group-item' id='"+file.id+"'>"+file.name+"<span style='padding-left:20px'></span></li>";
        $("#fileList").append(html);
    });*/



</script>
</body>
</html>
