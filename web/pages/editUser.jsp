<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-6-21
  Time: 上午 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改个人信息</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/linkList.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/scalefixed.css"/>
    <link rel="shortcut icon" type="text/css" href="${pageContext.request.contextPath}/img/head/logo2.png"/>
    <style>
        body{
            text-align: center;
        }

        /*弹出层div*/
        .editUserBox{
            width: 500px;
            margin: 10px auto;
        }

        .myForm div{
            width: 500px;
            height: 40px;
            margin: 10px 0;
            border-radius: 2px;
        }
        .myForm input{
            width: 220px;
            height: 40px;
            line-height: 40px;
            padding: 3px 5px;
            border: 1px solid #cccccc;
            border-radius: 2px;
        }
        .myForm label{
            width: 100px;
            margin: 0 10px;
            text-align: right;
            display: inline-block;
        }
        .myForm select{
            width: 220px;
            height: 40px;
            border: 1px solid #cccccc;
            border-radius: 2px;
        }

        .submitBtn{
            width: 100px;
            height: 40px ;
            background: #4169E1;
            color: white;
            border: 0;
            outline: none;
            border-radius: 2px;
            margin-left: 65px;
        }
    </style>
</head>
<body>
<div id="header1"> <!-- 导入header.jsp --></div>
<div id="editUserBox" class="editUserBox">
    <form id="myForm" class="myForm" action="${pageContext.request.contextPath}/userServlet?action=upDateInfo"  method="post" enctype="multipart/form-data" >
        <input style="display: none" name="uid" value="${sessionScope.user.id}">
        <div class="headImgBox">
            <label>头像：</label>
            <input type="file" name="newHeadImg" id="newHeadImg">
        </div>
        <div class="nameBox">
            <label class="">用户名：</label>
            <input type="text" id="username" name="username" placeholder="${sessionScope.user.name}">
            <span id="msg_username" class="msg_editUser"></span>
        </div>
        <div class="passBox">
            <label class="">密码：</label>
            <input type="password" id="password" name="password" placeholder="******" autocomplete="off">
            <span id="msg_password" class="msg_editUser"></span>
        </div>
        <div class="sexBox">
            <label class="">性别：</label>
            <select id="sex" class="" name="sex">
                <option value="">选择性别</option>
                <option value="1">男</option>
                <option value="0">女</option>
            </select>
        </div>
        <div class="telBox">
            <label class="">手机号：</label>
            <input type="text" id="tel" name="tel" placeholder="${sessionScope.user.tel}">
            <span id="msg_tel" class="msg_editUser"></span>
        </div>
        <div class="birthBox">
            <label class="">生日：</label>
            <input type="date" name="birth" id="birth" value="${sessionScope.user.birth}">
        </div>
        <div class="addressBox">
            <label class="">地址：</label>
            <input type="text" id="address" name="address" placeholder="${sessionScope.user.address}" autocomplete="off">
        </div>
        <button type="submit" class="submitBtn">确认修改</button>
    </form>
</div>
</body>
<script type="text/javascript">
    window.onload = function () {
        $("#header1").load("${pageContext.request.contextPath}/pages/header.jsp");

        $(".msg_editUser").css('font-size', '13px');
        $(".msg_editUser").css('color', 'red');
        $(".msg_editUser").css('position', 'absolute');
        $(".msg_editUser").css('right', '310px');
        $(".msg_editUser").css('margin-top', '10px');
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
                    $("#msg_password").text("密码不能为空");
                    return false;
                } else {
                    $("#msg_password").text("");
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
            }else if (tel == null || tel === ''){
                $("#msg_tel").text("号码不能为空");
            }else{
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
        const newHeadImg = $("#newHeadImg").val();
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
        } else if (isEmpty(newHeadImg)) {
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

    })
</script>
</html>
