<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-6-1
  Time: 下午 12:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/scalefixed.css" type="text/css"/>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/head/logo2.png" type="text/css"/>
</head>
<body style="text-align: center">
<div id="header1"><%-- 导入头部jsp--%> </div>

<h1>账户注册</h1>

<%--输入框们--%>
<form id="myForm" action="${pageContext.request.contextPath}/userServlet?action=register" method="post"
      enctype="multipart/form-data">
    <div id="inPutUserInfo_div">
        <!-- 头像-->
        <div id="headImg_div">
            <input type="file" id="headImg_upload" name="headImg_upload" >
        </div>
        <input type="text" id="username" name="username" placeholder="用户名：">
        <span id="message_username" class="msg_reg"></span>
        <input type="password" id="password" name="password" placeholder="密码：">
        <span id="message_password" class="msg_reg"></span>
        <select class="sex_select" id="sex" name="sex">
            <option value="">性别</option>
            <option value="0">女</option>
            <option value="1">男</option>
            <option value="2">其他</option>
        </select>
        <input type="text" id="tel" name="tel" placeholder="电话：">
        <span id="msg_tel" class="msg_reg"></span>
        <input type="date" id="birth" name="birth" placeholder="生日：">
        <input type="text" id="address" name="address" placeholder="地址：">
    </div>
    <div>
        <%--注册按钮--%>
        <input id="submitBtn" type="submit" value="✔">
    </div>
</form>
<%-- 反馈信息--%>

</body>

<script type="text/javascript">
window.onload = function () {
    $("#header1").load("${pageContext.request.contextPath}/pages/header.jsp");

    $(".msg_reg").css('font-size', '13px');
    $(".msg_reg").css('color', 'red');
    $(".msg_reg").css('position', 'absolute');
    $(".msg_reg").css('right', '310px');
    $(".msg_reg").css('margin-top', '25px');
};

$(function () {
    $("#username").keyup(function () {
        let username = $("#username").val();
        if (username === "" || username == null) {
            $("#message_username").text("用户名不能为空");
            $("#message_username").css("color","red");
            return false;
        } else {
            $("#message_username").text("");
        }
        $.ajax({
            url: '/SAMSUNG_WEB/userServlet?action=judgeUsername',
            type: 'post',
            async: true,   //默认true异步，false同步
            data: {
                username: username
            },
            dataType: 'json',
            success: function (data) {
                console.log(data);
                if (data === "SUCCESS") {
                    $("#message_username").text("用户名可用!");
                    $("#message_username").css('color','green');
                }
                if (data === "FAILED") {
                    $("#message_username").text("该用户名已被注册!");
                    $("#message_username").css('color','red');
                    $("#username").text("");
                    return false;
                } else {
                    $("#message_username").text("");
                }
            }
        })
    });

    //验证密码
    $("#password").keyup(function () {
            const password = $("#password").val();
            if (password == null || password === '') {
                $("#message_password").text("密码不能为空");
                return false;
            } else {
                $("#message_password").text("");
            }
        }
    );

    //验证手机号
    $("#tel").keyup(function () {
        const tel = $("#tel").val();
        const reg_tel = /^1(3[0-9]|4[01456879]|5[0-35-9]|6[2567]|7[0-8]|8[0-9]|9[0-35-9])\d{8}$/;
        if (!reg_tel.test(tel)) {
            $("#msg_tel").text("号码不正确");
            $("#msg_tel").css("color","red");
            $("#tel").text("");
            return false;
        }else if (tel == null || tel == ''){
            $("#msg_tel").text("号码不能为空");
        }else {
            $("#msg_tel").text("");
        }
    });

});

//表单提交
function isEmpty(obj){
    if(obj == ""){
        return true;
    }else{
        return false;
    }
}
$("#myForm").bind("submit",function() {
    const username = $("#username").val();
    const password = $("#password").val();
    const headImg_upload = $("#headImg_upload").val();
    const sex = $("#sex").val();
    const tel = $("#tel").val();
    const birth = $("#birth").val();
    const address = $("#address").val();

    if (isEmpty(username)) {
        layer.alert('用户名不能为空',{icon: 7});
        return false;
    } else if (isEmpty(password)) {
        layer.alert('密码不能为空',{icon: 7});
        return false;
    } else if (isEmpty(headImg_upload)) {
        layer.alert('头像不能为空',{icon: 7});
        return false;
    } else if (isEmpty(tel)) {
        layer.alert('号码不能为空',{icon: 7});
        return false;
    } else if (isEmpty(sex)) {
        layer.alert('性别不能为空',{icon: 7});
        return false;
    } else if (isEmpty(birth)) {
        layer.alert('生日不能为空',{icon: 7});
        return false;
    } else if (isEmpty(address)) {
        layer.alert('地址不能为空',{icon: 7});
        return false;
    } else {
        return true;
    }
});

</script>
</html>
