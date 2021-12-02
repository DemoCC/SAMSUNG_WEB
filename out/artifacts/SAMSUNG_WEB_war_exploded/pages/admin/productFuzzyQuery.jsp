<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-6-17
  Time: 下午 6:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>产品信息</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css">
    <style type="text/css">
        body{
            margin: 10px 30px;
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
    <c:when test="${requestScope.pList_Fuzz.size() == 0}">
        <h2 align="center">未查询到产品</h2>
        <a href="${pageContext.request.contextPath}/pages/admin/managerIndex.jsp" class="layui-btn layui-btn-normal a_back">返回</a>
    </c:when>
    <c:otherwise>
        <div class="outBox">
            <blockquote class="layui-elem-quote">产品信息</blockquote>
            <table class="layui-table myTable" lay-even lay-skin="nob">
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
                <c:forEach var="product" items="${requestScope.pList_Fuzz}" varStatus="status">
                    <tr>
                        <td>${product.id}</td>
                        <td id="td_pName">${product.name}</td>
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
            <%-- 隐藏标签，存关键字--%>
<%--            <span style="display: none" id="key">${requestScope.key_FuzzyQuery}</span>--%>
        </div>
        <a href="${pageContext.request.contextPath}/pages/admin/managerIndex.jsp" class="layui-btn layui-btn-normal a_back">返回</a>
    </c:otherwise>
</c:choose>
</body>
<script type="text/javascript">
    // const pName = $("#td_pName").text();    //获取产品名
    // const key = $("#key").text();           //获取查询的关键字
    // alert(pName);
    // alert(key);
    // // key.substring(1, key.length)：去掉那个关键字前的大写字母
    // pName.substring(6 , key.length).css('color','green');
    // if (pName.includes(key.substring(1, key.length))){

    // }else {

    // }
</script>
</html>
