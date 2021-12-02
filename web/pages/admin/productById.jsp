<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${sessionScope.product_byId.name}的产品信息</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript" ></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css" type="text/css"/>
    <style>
        body{
            padding: 10px 20px;
            text-align: center;
            overflow: hidden;
        }
        .grid-demo{
            width: 100%;
            height: 400px;
        }
        /*图片外框*/
        .productImg{
            width: 100%;
        }
        /*图片*/
        .productImg img{
            width: 100%;
        }
        /*信息表格*/
        .layui-table{
            width: 100%;
            margin: 50px 20px;
        }
        /*右边信息表格的th, td*/
        .grid-demo-bg2 th{
            width: 200px;
        }
        .grid-demo-bg2 td{
            width: 400px;
        }
    </style>
</head>
<body>
<c:choose>
    <c:when test="${sessionScope.product_byId == null}">
        <blockquote class="layui-elem-quote">产品信息</blockquote>
        <h2>没有查询到此产品</h2>
        <a href="managerIndex.jsp" class="layui-btn layui-btn-normal">返回</a>
    </c:when>
    <c:otherwise>
        <blockquote class="layui-elem-quote">${sessionScope.product_byId.name}的产品信息</blockquote>
        <div class="layui-row">
            <div class="layui-col-md6">
                <div class="grid-demo grid-demo-bg1">
                    <div class="productImg">
                        <img src="${pageContext.request.contextPath}/img${sessionScope.product_byId.url}" alt="图片加载失败">
                    </div>
                </div>
            </div>
            <div class="layui-col-md6">
                <div class="grid-demo grid-demo-bg2">
                    <table class="layui-table" lay-size="lg" lay-even lay-skin="nob">
                        <colgroup>
                            <col width="100">
                            <col width="100">
                            <col width="100">
                            <col width="100">
                            <col width="150">
                            <col>
                        </colgroup>
                        <tr>
                            <th>产品名</th><td>${sessionScope.product_byId.name}</td>
                        </tr>
                        <tr>
                            <th>价格</th><td>${sessionScope.product_byId.price}</td>
                        </tr>
                        <tr>
                            <th>类型</th><td>${sessionScope.product_byId.type}</td>
                        </tr>
                        <tr>
                            <th>颜色</th><td>${sessionScope.product_byId.color}</td>
                        </tr>
                        <tr>
                            <th>库存</th><td>${sessionScope.product_byId.stock}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <a href="managerIndex.jsp" class="layui-btn layui-btn-normal">返回</a>
    </c:otherwise>
</c:choose>
</body>
</html>
