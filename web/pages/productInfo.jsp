<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>商品信息</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/scalefixed.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/productInfo.css">
</head>
<body>
<%--导航栏 --%>
<div class="header_pInfo">
    <ul>
        <li><a href="${pageContext.request.contextPath}/indexServlet">首页</a></li>
        <li>></li>  <!--商品列表-->
        <li><a href="${pageContext.request.contextPath}/productServlet?action=queryAllProducts">全部商品列表</a></li>
        <li>></li> <!--商品名称-->
        <li>${sessionScope.product_moreInfo.name}</li>
    </ul>
    <a href="${pageContext.request.contextPath}/cartServlet?action=queryCart&uid=${sessionScope.user.id}">
        <img src="${pageContext.request.contextPath}/img/buyCar.png">
    </a>
</div>
<%---------------------------------------------------------------------------------------------------------%>
<%--中部主体--%>
<div class="body_center">
    <div class="layui-row">
        <%--产品大图--%>
        <div class="layui-col-xs6">
            <div class="grid-demo grid-demo-bg1">
                <img src="${pageContext.request.contextPath}/img/${sessionScope.product_moreInfo.url}" alt="图片加载失败">
            </div>
        </div>
        <%--右边信息--%>
        <div class="layui-col-xs6">
            <div class="grid-demo grid-demo-bg2">
                <h1>${sessionScope.product_moreInfo.name}</h1> <%--商品名--%>
                <p>颜色</p>
                <h3 class="h3_color">${sessionScope.product_moreInfo.color}</h3> <%--颜色--%>
                <p>配送地址</p>
                <h3>${sessionScope.user.address}</h3> <%--配送地址--%>
                <div class="buyNumBox">
                    <div id="span_add" class="span_add" onclick="addNum();">+</div>
                    <div id="span_quantity" class="span_quantity">1</div>
                    <div id="span_reduce" class="span_reduce" onclick="reduceNum();">-</div>
                </div>
                <div>总价：</div>
                <div id="totalMoney" class="totalMoney">${sessionScope.product_moreInfo.price}</div>
                <c:choose>
                    <c:when test="${sessionScope.user == null}">
                        <a href="${pageContext.request.contextPath}/pages/login.jsp">您还没有登录，请登录</a>
                    </c:when>
                    <c:otherwise>
                        <button id="addCart">加入购物车</button>
                    </c:otherwise>
                </c:choose>
                <%--隐藏数据--%>
                <span id="span_uid" style="display: none">${sessionScope.user.id}</span>
                <span id="span_pid" style="display: none">${sessionScope.product_moreInfo.id}</span>
            </div>
        </div>
    </div>
</div>
<%-------------------------------------------------------------------------------------------%>
</body>
<script type="text/javascript">
    $("#addCart").click(function (quantity, uid, pid) {
        quantity = $("#span_quantity").text();
        uid = $("#span_uid").text();
        pid = $("#span_pid").text();

        $.ajax({
            url:'/SAMSUNG_WEB/cartServlet?action=addToCart',
            type:'post',
            data:{
                quantity:quantity,
                uid:uid,
                pid:pid
            },
            dataType:'json',
            success:function (data) {
                if (data === 'SUCCESS'){
                   layer.msg(
                       '添加成功', {icon: 1, time :1000}
                   )}
                if (data === 'FAILED'){
                    layer.msg(
                        "添加失败",{icon: 2, time: 1000}
                    )
                }
            }
        })
    });

    const obj = $("#span_quantity");
    const obj2 = $("#totalMoney");

    let quantity = parseInt(obj.text());
    let totalMoney = parseInt(obj2.text());

    function addNum() {
        if (quantity === 5){
            alert("最多只能添加5台");
            return false
        }
        quantity = quantity + 1;
        var totalMoney1 = quantity * totalMoney;
        obj.text(quantity);
        obj2.text(totalMoney1);

    }
    function reduceNum() {
        if (quantity > 1){
            quantity = quantity - 1;
            var totalMoney2 = quantity * totalMoney;
            obj.text(quantity);
            obj2.text(totalMoney2);
        }
    }


</script>
</html>
