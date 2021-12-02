<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-6-17
  Time: 下午 5:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>类别查询</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css">
    <style type="text/css">
        body{
            padding: 10px 30px;
        }
        .a_back{
            position: absolute;
            top: 20px;
            right: 50px;
        }
    </style>
</head>
<body>
    <c:choose>
        <c:when test="${requestScope.pList_type.size() == 0}">
            <h2 align="center">未查询到产品</h2>
            <a href="${pageContext.request.contextPath}/pages/admin/managerIndex.jsp" class="layui-btn layui-btn-normal a_back">返回</a>
        </c:when>
        <c:otherwise>
            <blockquote class="layui-elem-quote">产品信息</blockquote>
            <table class="layui-table" lay-even lay-skin="nob">
                <colgroup>
                    <col width="50">
                    <col width="220">
                    <col width="90">
                    <col width="90">
                    <col width="90">
                    <col width="90">
                    <col width="200">
                </colgroup>
                <thead>
                <tr>
                    <th>ID</th> <th>产品名称</th> <th>价格</th>
                    <th>类型</th><th>颜色</th><th>库存</th><th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="product" items="${requestScope.pList_type}" varStatus="status">
                    <tr>
                        <td>${product.id}</td>
                        <td>${product.name}</td>
                        <td>${product.price}</td>
                        <td>${product.type}</td>
                        <td>${product.color}</td>
                        <td>${product.stock}</td>
                        <td>
                            <a type="button" href="${pageContext.request.contextPath}/productServlet_Admin?action=goUpDataPro&pid=${product.id}" class="layui-btn layui-btn-sm layui-btn-warm">修改</a>
                            <a href="${pageContext.request.contextPath}/productServlet_Admin?action=delProduct&id=${product.id}" class="layui-btn layui-btn-sm layui-btn-danger">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <a href="${pageContext.request.contextPath}/pages/admin/managerIndex.jsp" class="layui-btn layui-btn-normal a_back">返回</a>
        </c:otherwise>
    </c:choose>
</body>
</html>
