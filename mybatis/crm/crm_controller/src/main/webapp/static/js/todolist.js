(function() {
    //未完成时的div
    var list1 = document.querySelector("#list1");
    //已完成的div
    var list2 = document.querySelector("#list2");
    
    var input = document.querySelector(".text input");

    var store = [
        {title: "学下java" , done:false},
        {title: "去超市买东西",done:false},
        {title: "做饭",done:false}
    ];

    for(var i = 0; i < store.length; i++) {
        createElements(store[i]);
    }

    function createElements(todo) {
        var checkboxlist = document.createElement("div");
        var spanText = document.createElement("span");
        var a = document.createElement("a");
        var span = document.createElement("span");
        var text = document.createTextNode(todo.title);

        checkboxlist.setAttribute("class","checkbox");
        a.setAttribute("href","javascript:;");

        spanText.appendChild(text);
        span.appendChild(a);
        checkboxlist.appendChild(span);
        checkboxlist.appendChild(spanText);

        if(todo.done) {
            list2.appendChild(checkboxlist);
        }else {
            list1.appendChild(checkboxlist);
        }
    }

    
    input.onkeydown = function(event) {
        if(event.keyCode == 13) {
            if(input.value.trim()) { //在Javascript里面只要字符串为null 或者为空就返回false
                var todo = {
                title : input.value,
                done:false,
            }
            createElements(todo);
            input.value = "";
            }
            
        }
    }

    document.onclick = function(event) {
        var obj = event.target;
        if(obj.getAttribute("href") == "javascript:;") {
            var divChlid = obj.parentNode.parentNode;
             var div = divChlid.parentNode;
             if(div.getAttribute("id") == "list1") {
                 list2.appendChild(divChlid);
             } else {
                 list1.appendChild(divChlid);
             }
        }
        
    }
    


})();