<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-5-30
  Time: 下午 6:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>网上商城</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/netstore.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bottom.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/linkList.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/showProducts.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/scalefixed.css"/>
    <link rel="shortcut icon" type="text/css" href="${pageContext.request.contextPath}/img/head/logo2.png"/>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div id="header1">
    <!-- 导入头部html -->
</div>

<!-- 本月精选大标题 -->
<div class="bigTitleBox">
    <h1 align="center">本月精选</h1>
</div>
<div class="imgBox">
    <table border="0" cellspacing="20" cellpadding="0" class="table1">
        <tr>
            <td rowspan="2" class="bigImg">
                <img src="${pageContext.request.contextPath}/img/${sessionScope.netStoreList1[0].url}">
            </td>
            <td class="smallImgtd">
                <img src="${pageContext.request.contextPath}/img/${sessionScope.netStoreList1[1].url}">
                <p>${sessionScope.netStoreList1[1].name}</p>
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${sessionScope.netStoreList1[1].id}">立即购买</a>
            </td>
            <td class="smallImgtd">
                <img src="${pageContext.request.contextPath}/img/${sessionScope.netStoreList1[2].url}">
                <p>${sessionScope.netStoreList1[2].name}</p>
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${sessionScope.netStoreList1[2].id}">立即购买</a>
            </td>
        </tr>
        <tr>
            <td class="smallImgtd">
                <img src="${pageContext.request.contextPath}/img/${sessionScope.netStoreList1[3].url}">
                <p>${sessionScope.netStoreList1[3].name}</p>
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${sessionScope.netStoreList1[3].id}">立即购买</a>
            </td>
            <td class="smallImgtd">
                <img src="${pageContext.request.contextPath}/img/${sessionScope.netStoreList1[4].url}">
                <p>${sessionScope.netStoreList1[4].name}</p>
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${sessionScope.netStoreList1[4].id}">立即购买</a>
            </td>
        </tr>
    </table>
</div>
<%--手机部分--%>
<div class="smartPhoneBox">
    <h1 align="center">智能手机</h1>
    <c:choose>
        <c:when test="${sessionScope.netStoreList2 == null}">
            <p align="center">暂无产品</p>
        </c:when>
        <c:otherwise>
        <c:forEach var="product" items="${sessionScope.netStoreList2}" varStatus="status">
            <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${product.id}">
                <div class="itemBox">
                    <div><img src="${pageContext.request.contextPath}/img/${product.url}" alt="图片加载失败"></div>
                    <p class="p_pName">${product.name}</p>
                    <p class="p_color">${product.color}</p>
                    <p class="p_price">￥${product.price}</p>
                </div>
            </a>
        </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
<!-- 可穿戴设备 -->
<div class="smartPhoneBox">
    <h1 align="center">可穿戴设备</h1>
    <c:choose>
        <c:when test="${sessionScope.netStoreList3 == null}">
            <p align="center">暂无产品</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="product" items="${sessionScope.netStoreList3}" varStatus="status">
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${product.id}">
                    <div class="itemBox">
                        <div><img src="${pageContext.request.contextPath}/img/${product.url}" alt="图片加载失败"></div>
                        <p class="p_pName">${product.name}</p>
                        <p class="p_color">${product.color}</p>
                        <p class="p_price">￥${product.price}</p>
                    </div>
                </a>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<div id="AllLink">
    <!-- 导入linkList.jsp -->
</div>

</body>
<script type="text/javascript">
    // 导入linkList.jsp
    $("#header1").load("${pageContext.request.contextPath}/pages/header.jsp");

    // 导入linkList.jsp
    $("#AllLink").load("${pageContext.request.contextPath}/pages/linkList.html");

</script>

</html>

