<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-5-29
  Time: 下午 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>登录账户</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/scalefixed.css"/>
    <link rel="shortcut icon" type="text/css" href="${pageContext.request.contextPath}/img/head/logo2.png"/>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <style>
        body{

        }
        #goToReg{
            display: inline-block;
            overflow: hidden;
            font-size: 16px;
            color: #1429A0;
            padding-bottom: 15px;
        }
        #username, #pass, #btn{
            border-radius: 3px;
        }
    </style>
</head>
<body style="text-align: center">
<c:choose>
    <%--用户user== null代表没有用户登陆--%>
    <c:when test="${sessionScope.user == null}">
    <div id="header1"> <%-- 导入头部jsp--%></div>
     <div id="app">
        <%--登陆表单--%>
        <form action="${pageContext.request.contextPath}/userServlet?action=login" method="post">
            <div class="login_warp">
                <div class="loginbox fl">
                    <div class="login_header">
                        <span>账号登录</span>
                    </div>
                    <div class="login_content">
                        <div class="Cbody_item">
                            <div class="form_item"><input type="text" id="username" name="fname" placeholder="用户名"></div>
                            <div class="form_item"><input type="password" id="pass" name="fpassword" placeholder="密码"></div>
                            <div class="form_item">
                                <div class="fl"><input type="checkbox" name="check">记住密码</div>
                            </div>
                            <div class="form_item">
                                <button id="btn" type="submit">登录</button>
                            </div>
                            <span class="loginMsg" style="color:red;">${sessionScope.loginMsg}</span>
                        </div>
                    </div>
                </div>
            </div>
        </form>
     </div>

        <a href="${pageContext.request.contextPath}/pages/register.jsp">
            <p id="goToReg">注册账户></p>
        </a>

        <footer id="index_foot">
            <p style="overflow: hidden">© 1995-2020 三星（中国）投资有限公司 版权所有</p>
            <p style="overflow: hidden">三星（中国）投资有限公司授权北京鹏泰宝尊电子商务有限公司运营三星网上商城并销售产品</p>
        </footer>
    </c:when>
    <c:otherwise>
    </c:otherwise>
</c:choose>
</body>
<script type="text/javascript">
    window.onload = function (){
        $("#header1").load("${pageContext.request.contextPath}/pages/header.jsp");
    }
</script>
</html>

