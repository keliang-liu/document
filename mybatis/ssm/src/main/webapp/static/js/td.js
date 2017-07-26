$(function() {

    //未完成的
    var $list1 = $("#list1");
    //已完成的
    var $list2 = $("#list2");
    var $input = $(".anv input");

    function createElement(todo) {
        var html ='<div class = "li"><span class="checkbox"><a href="javascript:;"></a></span><span class="textspan">'+ todo.title +'</span><i class="fa fa-times"></i></div>';
        if(todo.done) {
            $list2.append(html);
        }else {
            $list1.append(html);
        }
    }

    $input.keydown(function(event) {
        if(event.keyCode == 13) {
           if($(this).val().trim()) {
                var todo = {
                    title : $input.val(),
                    done : false
                }
                createElement(todo);
                $input.val("");
           }
        }
     })

     $(document).delegate(".checkbox a","click",function(){
        var $li = $(this).parents(".li");
        var $ul = $li.parent();

        if($ul.hasClass("done")) {
            $list1.append($li);
        }else {
            $list2.append($li);
        }


     })
     
     $(document).delegate(".fa-times","click",function(){
        var $li = $(this).parents(".li");
        if(confirm("是否要删除")) {
             $li.remove();
        }
       
     })

     document.onclick = function(event) {
        var obj = event.target;
        if(obj.getAttribute("class") == "textspan") {
            var value = obj.innerText;
            var input ='<input type="text" style="padding:0px;margin:0px;background-color:transparent;outline:none;border:0px;" value ='+ value + '>';
            obj.removeChild(obj.firstChild);
            $(obj).append(input);
            obj.firstChild.select();
            obj.firstChild.onkeydown = function(event) {
                if(event.keyCode == 13) {
                    if(!this.value.trim()) {
                        this.placeholder = "输入的不能为空";
                    }else {
                        obj.innerText = this.value;
                        $(this).remove()
                    }
                }
            }
        }

     }

});