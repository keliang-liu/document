<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>凯盛软件CRM-首页</title>
    <%@ include file="../base/base-css.jsp"%>
    <link rel="stylesheet" href="/static/plugins/tree/css/metroStyle/metroStyle.css">
    <link rel="stylesheet" href="/static/plugins/datatables/dataTables.bootstrap.css">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">
    <%@include file="../base/base-side.jsp"%>
    <!-- 右侧内容部分 -->
    <div class="content-wrapper">

        <!-- Main content -->
        <section class="content">

            <div class="row">
                <div class="col-md-2">
                    <div class="box">
                        <div class="box-body">
                            <button class="btn btn-default" id="addDeptBtn">添加部门</button>
                            <ul id="ztree" class="ztree"></ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-10">
                    <!-- Default box -->
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">员工管理</h3>
                            <button id="delDeptBtn" class="btn btn-info" style="display: none" id="">删除部门</button>
                            <div class="box-tools pull-right">
                                <button type="button" class="btn btn-box-tool"  title="Collapse" id="addBtn">
                                    <i class="fa fa-plus" ></i> 添加员工</button>
                            </div>
                        </div>
                        <div class="box-body">
                            <table class="table" id="accountTable">
                                <thead>
                                <tr>
                                    <th>姓名</th>
                                    <th>部门</th>
                                    <th>手机</th>
                                    <th>#</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                    <!-- /.box -->
                </div>
            </div>
        </section>

       <div class="modal fade" id="addAccountModal">
         <div class="modal-dialog">
           <div class="modal-content">
             <div class="modal-header">
                 <input type="hidden" id="deptId"/>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
               <h4 class="modal-title" id="myModalLabel">添加员工姓名</h4>
             </div>
             <div class="modal-body">
                 <form id="addAccountForm">
                     <div class="form-group">
                         <label>姓名</label>
                         <input type="text" name="userName" class="form-control">
                     </div>
                     <div class="form-group">
                         <label>密码(默认的密码是123123)</label>
                         <input type="password" name="password" class="form-control" value="123123">
                     </div>
                     <div class="form-group">
                         <label>手机号</label>
                         <input type="text" name="mobile" class="form-control">
                     </div>
                     <label>部门</label>
                     <div class="checkbox" id="checkboxArea">

                     </div>
                 </form>

             </div>
             <div class="modal-footer">
               <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
               <button type="button" class="btn btn-primary" id="addAccountBtn">添加</button>
             </div>
           </div>
         </div>
       </div>

        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <%@ include file="../base/base-footer.jsp"%>

</div>
<!-- ./wrapper -->

<%@include file="../base/base-js.jsp"%>
<script src="/static/js/validate/jquery.validate.min.js"></script>
<script src="/static/plugins/tree/js/jquery.ztree.all.min.js"></script>
<script src="/static/plugins/layer/layer.js"></script>
<script src="/static/plugins/datatables/jquery.dataTables.js"></script>
<script src="/static/plugins/datatables/dataTables.bootstrap.js"></script>
<script>
    $(function(){

        var dataTable = $("#accountTable").DataTable({
            "processing" : true,
            "serverSide" : true,
            "paging" : false,
            "ordering" : false,
            "searching" : false,
            "ajax" : {
                url : "/manage/account/load.json",
                data : function(data){
                    data.deptId = $("#deptId").val();
                }
            },
            "language":{
                "info":  "显示 _START_ 到 _END_ 共 _TOTAL_ 条数据",
            },

            "columns" : [
                {"data" : "userName"},
                {"data" : function(row){
                    var result = "";
                    for(var i = 0; i < row.deptList.length; i ++) {

                        result += row.deptList[i].deptName + "&nbsp;&nbsp;";
                    }
                    return result;
                } },

                {"data" : "mobile"},

                {"data" : function(row) {
                    return "<a href='javascript:;' rel='" + row.id + "' class='del'><i class='fa fa-trash text-danger'></i></a>";
                }}
            ]

        });

        $(document).delegate(".del","click",function(){
            var id = $(this).attr("rel");
            layer.confirm("是否要删除",function(){
                $.get("/manage/account/del/" + id).done(function(data){
                    if(data.state == 'success') {
                        layer.msg("删除成功");
                        dataTable.ajax.reload();
                    }else {
                        layer.msg(data.message);
                    }
                }).error(function(){
                    layer.msg("服务器异常");
                });
            });

        })

        var ztreeObj;

        var setting = {
            /*数据类型*/
            data:{
                simpleData:{
                    enable:true
                },
                /*key:{
                    name:"deptName"
                }*/
            },

            /*异步加载数据*/
            async:{
                enable:true,
                url:"/manage/account/dept.json"
            },
            /*回掉函数*/
            callback:{
                onClick:function(event,treeId,treeNode,clickFlag){
                   /* alert(treeNode.id + treeNode.name + treeNode.pId);*/
                   $("#deptId").val(treeNode.id);
                   $("#delDeptBtn").attr("id",treeNode.id).show();
                   dataTable.ajax.reload();
                }
            }

        };
        /*删除部门的异步请求*/
        $("#delDeptBtn").click(function(){
             var id = $(this).attr("id");
            if(id == 1000) {
                return
            }
             $.get("/manage/account/dept/del/" + id).done(function(data){
                 if(data.state == 'success') {
                     ztreeObj.reAsyncChildNodes(null, "refresh");
                     layer.msg("删除成功");
                     $("#delDeptBtn").hide();
                 }else {
                    layer.msg(data.message);
                 }
                 }).error(function(){
                 layer.msg("服务器异常");
             });

         })

        ztreeObj = $.fn.zTree.init($("#ztree"),setting);
        /*添加部门的信息*/
        $("#addDeptBtn").click(function(){
            layer.prompt({"title":"请输入部门的名字"},function(text,index){
                layer.close(index);
                $.post("/manage/account/dept/new",{"deptName":text,"pId":1000}).done(function(data){
                    if(data.state == 'success'){
                        layer.msg("保存成功");
                        ztreeObj.reAsyncChildNodes(null, "refresh");
                    }else{
                        layer.msg(data.message);
                    }

                }).error(function(){
                    layer.msg("服务器异常");
                });

            })

        });

        /*一步添加部门的信息*/

        $("#addBtn").click(function(){
            $("#checkboxArea").html("");
            $.get("/manage/account/get/depts").done(function(data){

                if(!data.data.length || data.data.length == 1 ) {
                    layer.msg("请添加部门后再来添加员工");
                    return ;
                }
                if(data.state == 'success'){
                    for(var i = 0; i < data.data.length; i ++) {
                        var obj = data.data[i];
                        if(obj.id != 1000) {
                            var html = '<label class="checkbox-inline"><input type="checkbox" name="deptId" value='+obj.id+'>'+obj.deptName+'</label>'
                            $(html).appendTo($("#checkboxArea"));
                        }
                    }
                }else {
                    layer.msg(data.message);
                }
            }).error(function(){
                layer.msg("服务器异常");
            });

            $("#addAccountModal").modal({
                show:true,
                backdrop:'static'
            });
        });
        /*添加员工*/
        $("#addAccountBtn").click(function(){

            $("#addAccountForm").submit();

        });

        /*提交前验证表单信息*/
        $("#addAccountForm").validate({

            errorClass:"text-danger",
            errorElement : "span",
            rules:{
                userName : {
                    required : true,
                },
                password : {
                    required : true,
                },

                mobile : {
                    required : true,
                    digits : true,
                    rangelength : [11,11],
                },

                deptId : {
                    required : true,
                }

            },
            messages : {

                userName : {
                    required : "请输入账号",
                },
                password : {
                    required : "请输入密码",
                },

                mobile : {
                    required : "请输入手机号",
                    digits : "请输入整数",
                    rangelength : "手机号必须是11位",
                },

                deptId : {
                    required : "请选择部门"
                }

            },
            submitHandler : function () {
                $.post("/manage/account/new",$("#addAccountForm").serialize()).done(function(data){
                    if(data.state == "success") {
                        $("#addAccountForm")[0].reset();//这个表明再提交表单后把表单内容重置
                        $("#addAccountModal").modal('hide');//让模态框消失
                        layer.msg("添加成功");
                        dataTable.ajax.reload();//让dataTables重新装载信息

                    }else {
                        layer.msg(data.message);
                    }

                }).error(function(){
                    layer.msg("服务器异常");
                });

            },

        });



    });


</script>
</body>
</html>
