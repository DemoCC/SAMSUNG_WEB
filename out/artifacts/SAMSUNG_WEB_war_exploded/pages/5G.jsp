<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-5-30
  Time: 下午 5:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>5G</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/5G.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/comment.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bottom.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/linkList.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/scalefixed.css"/>
    <link rel="shortcut icon" type="text/css" href="${pageContext.request.contextPath}/img/head/logo2.png"/>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div id="header1">  <!-- 导入头部jsp --> </div>

<p class="p1">
    与4G相比，5G上行速度要快得多，其拥有双向大带宽、低时延等特点，可以充分提升用户的体验。
    依靠未来完善的5G网络，我们不仅可以在全球范围实时现场直播大型活动和演出，
    还可以满足您对商业化、生活化的娱乐、游戏、购物等小型4K直播需求，
    让您在享受高清流畅画面的同时，体验视频、连麦等精彩的即时互动。
</p>

<div class="homeBox">
    <img src="${pageContext.request.contextPath}/img/5G/5GKV2_021.webp" >
</div>

<!-- 5G设备推荐 -->
<div class="title2">
    <h1 align="center">5G设备</h1>
</div>

<div class="smartPhoneBox">
<c:choose>
    <c:when test="${requestScope.pList_5G == null}">
        <p align="center">暂无产品</p>
    </c:when>
    <c:otherwise>
        <c:forEach var="product" items="${requestScope.pList_5G}" varStatus="status">
            <div class="phoneListItem">
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${product.id}">
                    <img src="${pageContext.request.contextPath}/img/${product.url}">
                    <p>${product.name}</p>
                    <h4>￥${product.price}</h4>
                </a>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>
</div>

<!-- 底部各种链接 -->
<div id="AllLink">
    <!-- 导入linkList.html -->
</div>

</body>

<script type="text/javascript">
    // 导入header.html
    $("#header1").load("${pageContext.request.contextPath}/pages/header.jsp");

    //导入linkList.html
    $("#AllLink").load("${pageContext.request.contextPath}/pages/linkList.html");

</script>
</html>
