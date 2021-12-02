<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-6-8
  Time: 下午 3:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>全部商品</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
    <script href="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/page.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/showProducts.css">
</head>
<body>
<div id="header1"><!--导入头部jsp--></div>
<div class="product_content">
<c:choose>
    <c:when test="${sessionScope.pList.data.size() == 0}">
        <h3 align="center">暂无商品</h3>
    </c:when>
    <c:otherwise>
        <c:forEach var="product" items="${sessionScope.pList.data}" varStatus="status">
            <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${product.id}">
            <div class="itemBox">
                <div><img src="${pageContext.request.contextPath}/img/${product.url}" alt="图片加载失败"></div>
                <p class="p_pName">${product.name}</p>
                <p class="p_color">${product.color}</p>
                <p class="p_price">￥${product.price}</p>
            </div>
            </a>
        </c:forEach>
        <%--分页--%>
        <div style="text-align: center">
            <ul class="page" style="text-align:center; margin-top:10px;">
                <!-- 判断是否是第一页 -->
                <c:if test="${sessionScope.pList.pageNumber == 1 }">
                    <li class="disable">
                        <a href="javascript:void(0)" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <!-- 不是第一页 -->
                <c:if test="${sessionScope.pList.pageNumber != 1 }">
                    <li>
                        <a href="${pageContext.request.contextPath }/productServlet?action=queryAllProducts&pageNumber=${sessionScope.pList.pageNumber-1}"
                           aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <!-- 展示所有页码 -->
                <c:forEach begin="1" end="${sessionScope.pList.totalPage }" var="n">
                    <!-- 判断是否是当前页 -->
                    <c:if test="${sessionScope.pList.pageNumber == n }">
                        <li class="actives"><a href="javascript:void(0)">${n }</a></li>
                    </c:if>
                    <c:if test="${sessionScope.pList.pageNumber != n }">
                        <li>
                            <a href="${pageContext.request.contextPath }/productServlet?action=queryAllProducts&pageNumber=${n}">${n }</a>
                        </li>
                    </c:if>
                </c:forEach>
                <!-- 判断是否是最后一页 -->
                <c:if test="${sessionScope.pList.pageNumber == sessionScope.pList.totalPage }">
                    <li class="disable">
                        <a href="javascript:void(0)" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.pList.pageNumber != sessionScope.pList.totalPage }">
                    <li>
                        <a href="${pageContext.request.contextPath }/productServlet?action=queryAllProducts&pageNumber=${sessionScope.pList.pageNumber+1}"
                           aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
    </c:otherwise>
</c:choose>
</div>
</body>
<script type="text/javascript">
    $("#header1").load("${pageContext.request.contextPath}/pages/header.jsp");
</script>
</html>
