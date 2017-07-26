(function() {

    //var list1 = document.querySelector("#list1");
    
    var list1 = document.querySelector("#list1");
    var list2 = document.querySelector("#list2");
    var input = document.querySelector(".tx");

    // var store = [
    //     {title : "学习英语" , done :false},
    //     {title : "去超市买水果", done : false}
    // ];

    // for(var i = 0; i < store.length; i ++) {
    //     createElement(store[i]);
    // }

    function createElement(todo) {
        //创建标签
        var box = document.createElement("span");
        var textspan = document.createElement("span");
        var a = document.createElement("a");
        var div = document.createElement("div");
        var text = document.createTextNode(todo.title);
        var timesspan = document.createElement("span");
        var times = document.createElement("i");
        //这个是给标签添加属性
        box.setAttribute("class","box");
        a.setAttribute("href","javascript:;");
        div.setAttribute("class","checkbox");
        timesspan.setAttribute("id","times");
        times.setAttribute("class","fa fa-times");
        textspan.setAttribute("class","text1");
        //组合标签
        textspan.appendChild(text);
        timesspan.appendChild(times);
        box.appendChild(a);
        div.appendChild(box);
        div.appendChild(textspan);
        div.appendChild(timesspan); 
        if(todo.done) {
            list2.appendChild(div);
        }else {
            list1.appendChild(div);
        }

    }

    input.onkeydown = function(event) {
         if(event.keyCode == 13) {
             var todo = {
                 title : input.value,
                 done : false,
             }
             input.value = "";
             createElement(todo);
         }

    }

    document.onclick = function(event) {
        var obj = event.target;
        if(obj.getAttribute("href") == "javascript:;") {
            var checkbox = obj.parentNode.parentNode;
            var checkboxlist = checkbox.parentNode;
            if(checkboxlist.getAttribute("id") == "list1") {
                list2.append(checkbox);
            }else {
                list1.append(checkbox);
            }
        }

        if(obj.getAttribute("class") == "fa fa-times") {
            var checkbox = obj.parentNode.parentNode;
            var checkboxlist = checkbox.parentNode;
           
            if(checkboxlist.getAttribute("id") == "list1") {
                list1.removeChild(checkbox);
            }else {
                list2.removeChild(checkbox);
            }
            
        }
          if(obj.getAttribute("class") == "text1") {
            var input = document.createElement("input");
            var str = obj.innerText;
            input.setAttribute("type","text");
            input.style.margin = 0 + "px";
            input.style.border = 0 + "px";
            input.style.backgroundColor = "transparent";
            input.style.outline = "none";
            input.value = str;
            obj.removeChild(obj.firstChild);
            obj.appendChild(input);
            input.onmouseover = function() {
                this.select();
            }
            input.onkeydown = function(event) {
                if(event.keyCode == 13) {
                    if(!(input.value.trim())) {
                        input.placeholder = "输入不能为空";
                    }else  {
                        var res = input.value;
                        obj.removeChild(input);
                        obj.innerText = res;
                    }
                   
                }
            }
            
            
        }
    
    }
 


})();