<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
    <h1>这是save页面</h1>
    <form action="/user/save" method="post">
        <input type="text" name="userName"><br>
        <input type="text" name="password"><br>
        <button>提交</button>
    </form>

</body>
</html>
