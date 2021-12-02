<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-5-29
  Time: 下午 9:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
    <title></title>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
</head>
<!-- 头部导航栏 -->
<header class="headerBox">
    <a href="${pageContext.request.contextPath}/indexServlet"><img src="${pageContext.request.contextPath}/img/head/samsung-logo.svg" class="logo"></a>

    <ul id="ul_nav" class="ul_nav">
        <li class="li_navtips3"><a href="${pageContext.request.contextPath}/productServlet?action=queryAllProducts" class="navtips">全部产品</a></li>
        <li><a href="${pageContext.request.contextPath}/productServlet?action=queryProductsByType&type=手机" class="navtips">手机/平板 </a></li>
        <li><a href="${pageContext.request.contextPath}/productServlet?action=queryProductsByType&type=穿戴" class="navtips">穿戴/音乐 </a></li>
        <li><a href="${pageContext.request.contextPath}/productServlet?action=queryProductsByType&type=家电" class="navtips">家电/智家 </a></li>
        <li><a href="${pageContext.request.contextPath}/productServlet?action=queryProductsByType&type=办公" class="navtips">电脑/办公 </a></li>

        <li class="li_navtips2"><a href="${pageContext.request.contextPath}/fiveGServlet" class="navtips">Galaxy&nbsp;5G </a></li>
        <li><a href="${pageContext.request.contextPath}/netStoreServlet" class="navtips">网上商城</a></li>
        <li><a href="${pageContext.request.contextPath}/cartServlet?action=queryCart&uid=${sessionScope.user.id}" class="navtips">购物车 </a></li>
        <c:choose>
            <c:when test="${sessionScope.user == null}">
                <li id="li_login"><a href="${pageContext.request.contextPath}/pages/login.jsp" class="navtips">登录</a></li>
            </c:when>
            <c:otherwise>
                <li id="li_login"><a href="${pageContext.request.contextPath}/pages/personal.jsp" class="navtips">${sessionScope.user.name}</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
</header>
<script type="text/javascript">


</script>
