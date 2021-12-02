<%@ page import="domain.User" %>
<%@ page import="dao.imp.UserDaoImp" %><%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-5-29
  Time: 下午 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>购物车</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/linkList.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/scalefixed.css" type="text/css"/>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/head/logo2.png"/>
</head>
<body>
<c:choose>
    <c:when test="${sessionScope.user == null}">
        <% response.sendRedirect(request.getContextPath() + "/pages/login.jsp"); %>
    </c:when>
    <c:otherwise>
        <div id="header1">  <!--导入头部jsp--> </div>
        <c:choose>
            <c:when test="${requestScope.cartItemList.size() == 0}">
            <div class="content">
                <img src="${pageContext.request.contextPath}/img/buyCar2.png">
                <p>您的购物车还没有商品</p>
                <a href="${pageContext.request.contextPath}/indexServlet">立即选购</a>
            </div>
            </c:when>
            <c:otherwise>
            <%--显示未完成的订单--%>
            <div class="contentBox">
                <h2 align="center">您的购物车信息</h2>
                <div class="cart_itemHead">
                    <ul class="ul_head">
                        <li>商品信息</li>
                        <li>购买数量</li>
                        <li>总价</li>
                        <li>操作</li>
                    </ul>
                </div>
                <c:forEach var="cart_item" items="${requestScope.cartItemList}" varStatus="status">
                    <div class="cart_item">
                        <div class="layui-row layui-col-space1">
                            <div class="layui-col-md3">
                                <div class="grid-demo grid-demo-bg1">
                                    <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${cart_item.pid}">
                                    <img src="${pageContext.request.contextPath}/img/${cart_item.productImgUrl}" alt="图片迷路了">
                                    <span>${cart_item.productName}</span>
                                    </a>
                                </div>
                            </div>
                            <div class="layui-col-md3">
                                <div class="grid-demo grid-demo-bg">
                                    <span>×${cart_item.quantity}</span>
                                </div>
                            </div>
                            <div class="layui-col-md3">
                                <div class="grid-demo grid-demo-bg">
                                    <span>￥${cart_item.totalMoney}</span>
                                </div>
                            </div>
                            <div class="layui-col-md3">
                                <div class="grid-demo grid-demo-bg">
                                    <span onclick="deleteItem();" class="a_delete">删除</span>
                                </div>
                            </div>
                            <%--隐藏的id--%>
                            <span style="display: none" id="itemId_span">${cart_item.id}</span>
                            <span style="display: none" id="uid_span">${cart_item.uid}</span>
                            <span style="display: none" id="pid_span">${cart_item.pid}</span>
                        </div>
                    </div>
                </c:forEach>
                <div class="settlementFoot">
                    <span id="clearAll">清空购物车</span>
                    <span>
                        商品总数量：<span id="productTotal">${requestScope.productTotal}</span>
                    </span>
                    <span>
                        总价：￥<span id="totalMoney">${requestScope.totalMoney}</span>
                    </span>
                    <span id="settlement">结算</span>
                </div>
            </div>
            <div id="payDiv" style="display: none; padding: 10px 10px">
                <h1 align="center">支持微信支付宝付款</h1>
                <div class="aliPay">
                    <img src="${pageContext.request.contextPath}/img/pay/aliPay.jpg">
                </div>
                <div class="weChatPay">
                    <img src="${pageContext.request.contextPath}/img/pay/weChatPay.png">
                </div>
            </div>
            </c:otherwise>
        </c:choose>
        <div id="AllLink"> <!-- 导入底部html --></div>
    </c:otherwise>
</c:choose>
<script type="text/javascript">
    //获取商品总数量
    const productTotal = $("#productTotal").text();
    //获取用户id
    const uid = $("#uid_span").text();
    //删除购物车item
    function deleteItem() {
        layer.confirm(
            '确定要删除吗？',
            {icon: 3, title: "删除商品"},
            function () {
                const itemId = $("#itemId_span").text();
                $.ajax({
                    url: '/SAMSUNG_WEB/cartServlet?action=deleteCartItem',
                    type: 'get',
                    async: true,
                    data: {
                        itemId: itemId
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data === "SUCCESS") {
                            layer.msg('删除成功', {icon: 1, time: 400},
                            function () {
                                window.location.replace("/SAMSUNG_WEB/cartServlet?action=queryCart&uid=${sessionScope.user.id}")
                            })
                        }
                        if (data === "FAILED") {
                            layer.msg('删除失败', {icon: 2, time: 400});
                            window.location.replace("/SAMSUNG_WEB/cartServlet?action=queryCart&uid=${sessionScope.user.id}")
                        }
                    }
                });
            });
    }
    //清空购物车
    $("#clearAll").click(function () {
        layer.confirm(
            '确定要清空吗？？？',
            { icon: 3, title: '清空购物车'},
            function() {
                $.ajax({
                    url: '/SAMSUNG_WEB/cartServlet?action=clearCart',
                    type: 'post',
                    data: {
                        uid: uid
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data === "SUCCESS"){
                            layer.msg(
                                '清空成功', {icon: 1, time:500},
                                function () {
                                    window.location.replace("/SAMSUNG_WEB/cartServlet?action=queryCart");
                                }
                            );
                        }else {
                            layer.msg("清空失败", {icon: 2, time:500},
                            function () {
                                window.location.replace("/SAMSUNG_WEB/cartServlet?action=queryCart");
                            })
                        }
                    }
                });
                layer.closeAll()
            });
    });
    //结算
    const totalMoney = $("#totalMoney").text();
    $("#settlement").click(function () {
        layer.open({
            type: 1,
            area: ['1000px','550px'],
            offset: 'auto',
            title: '请支付',
            content: $("#payDiv"),
            end: function(){
                $('#payDiv').css({'display':'none'});
                return false;
            }
        });
        // $.ajax({
        //     url: '/SAMSUNG_WEB/orderServlet?action=createOrder',
        //     type: 'get',
        //     data: {
        //         uid: uid,
        //         productTotal: productTotal,
        //         orderMoney: totalMoney
        //     },
        //     dataType: 'json',
        //     success: function (data) {
        //         if (data === "SUCCESS"){
        //             layer.msg( "结算成功", {icon: 1},
        //                 function () {
        //                     $.ajax({
        //                         url: '/SAMSUNG_WEB/cartServlet?action=clearCart',
        //                         type: 'post',
        //                         data: {
        //                             uid: uid
        //                         }
        //                     })
        //                 }
        //             )
        //         }
        //         if(data === "FAILED"){
        //             layer.msg( "结算失败", {icon: 2})
        //         }
        //     }
        // })
    });

    // 导入header.jsp
    $("#header1").load("${pageContext.request.contextPath}/pages/header.jsp");
    // 导入linkList.html
    $("#AllLink").load("${pageContext.request.contextPath}/pages/linkList.html");
</script>
</body>
</html>

