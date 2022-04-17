<jsp:useBean id="user" class="domain.User" scope="session"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>个人中心</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/personal.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/scalefixed.css" type="text/css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/head/logo2.png" type="text/css"/>
</head>
<body>
<c:choose>
    <%--没有用户登陆--%>
    <c:when test="${sessionScope.user == null}">
        <% response.sendRedirect(request.getContextPath() + "/pages/login.jsp"); %>
    </c:when>
    <%--以下是有用户登陆--%>
    <c:otherwise>
        <div id="header1"> <!-- 导入头部jsp --> </div>
        <div class="infoOutBox">
                <%-- 水平线上半部分--%>
            <div id="div_top">
                    <%-- 头像部分 --%>
                <div id="headImg">
                    <c:choose>
                        <%-- 如果头像路径为空，则使用默认头像 --%>
                        <c:when test="${sessionScope.user.headImgUrl == null }">
                            <%--判断性别--%>
                            <c:choose>
                                <c:when test="${sessionScope.user.sex=='男'}">
                                    <img src="${pageContext.request.contextPath}/img/headImg/sex1.png">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/img/headImg/sex0.png">
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <%--当如果用户头像URL不为空，使用用户数据库里的头像--%>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/img/${sessionScope.user.headImgUrl}" alt="图片加载失败">
                        </c:otherwise>
                    </c:choose>
                </div>  <!--头像框div结束-->
                    <%--用户名--%>
                <p id="username">  ${user.name}  </p>
                <c:if test="${user.isAdmin == 1}">
                    <a id="goManager" href="admin/managerIndex.jsp"><span class="goManager">后台管理</span></a>
                </c:if>
                    <%--退出登录按钮--%>
                <a id="a_logout" href="${pageContext.request.contextPath}/userServlet?action=logout" >
                    <img src="${pageContext.request.contextPath}/img/exit.png">
                </a>
            </div>
                <%--分割线下半部分--%>
            <div id="moreInfo">
                <table border="0">
                    <tr>
                        <td>ID：</td>
                        <td id="td_uid">${user.id}</td>
                    </tr>
                    <tr>
                        <td>性别：</td>
                        <td>${user.sex}</td>
                    </tr>
                    <tr>
                        <td>电话：</td>
                        <td>${user.tel}</td>
                    </tr>
                    <tr>
                        <td>生日：</td>
                        <td>${user.birth}</td>
                    </tr>
                    <tr>
                        <td>地址：</td>
                        <td>${user.address}</td>
                    </tr>
                </table>
                <c:choose>
                    <c:when test="${user.isAdmin == 1 || user.isAdmin == 2}">
                        <div id="manageBox" class="manageBox">
                            <span id="manageSpan" class="manageSpan"><a href="${pageContext.request.contextPath}/pages/admin/managerIndex.jsp">后台管理</a></span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div id="updateBox" class="updateBox">
                            <a href="${pageContext.request.contextPath}/pages/editUser.jsp" id="updateSpan" class="updateSpan">修改信息</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </c:otherwise>
</c:choose>
</body>
<script type="text/javascript">
    window.onload = function () {
        $("#header1").load("${pageContext.request.contextPath}/pages/header.jsp");
    };

</script>
</html>
