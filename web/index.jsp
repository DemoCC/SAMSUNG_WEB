<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>三星商城</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <%--layui--%>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/layui/css/layui.css"/>
    <!-- 本页面的css-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css"/>
    <!-- 头部的css-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css"/>
    <!-- 底部各种列表的css-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/linkList.css"/>
    <!-- 缩放修复的css-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/scalefixed.css"/>
    <link rel="shortcut icon" type="text/css" href="${pageContext.request.contextPath}/img/head/logo2.png"/>
</head>
<body>

<div id="out1">
    <!-- header -->
    <div id="header1"> <!-- 导入header.jsp --></div>
<%-------------------------------------------------------------------------------------------%>
    <!-- 轮播图 -->
    <!-- 创建一个外部的div作为大的容器 -->
    <div class="layui-carousel" id="swiperOut" style="overflow: hidden">
        <div carousel-item>
            <div class="swiper-item">
                <img src="${pageContext.request.contextPath}/img/swiper/lunbo_n10.png">
            </div>
            <div class="swiper-item">
                <img src="${pageContext.request.contextPath}/img/swiper/lunbo_n10_1.png">
            </div>
            <div class="swiper-item">
                <img src="${pageContext.request.contextPath}/img/swiper/lunbo_n10_3.png">
            </div>
            <div class="swiper-item">
                <img src="${pageContext.request.contextPath}/img/swiper/lunbo_n10_4.png">
            </div>
        </div>
    </div>
</div>
<%--------------------------------------------------------------------------------------------%>
<!-- 移动产品展区 -->
<div class="mobleProBox">
    <div class="productListBox">
        <h1 align="center">移动产品</h1>
        <!-- 手机名称列表 -->
        <ul class="ul_nameList">
            <li>
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${sessionScope.productList[1].id}">
                    ${sessionScope.productList[0].name}&nbsp;|&nbsp;${sessionScope.productList[1].name}
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${sessionScope.productList[2].id}">
                    ${sessionScope.productList[2].name}
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${sessionScope.productList[4].id}">
                    ${sessionScope.productList[3].name}&nbsp;|&nbsp;${sessionScope.productList[4].name}
                </a>
            </li>
        </ul>
    </div>
    <!-- 手机图片 -->
    <div class="PhoneImgBox" align="center">
        <img src="${pageContext.request.contextPath}/img/${sessionScope.productList[1].url}" class="pImg" alt="图片加载失败">
        <h1>${sessionScope.productList[1].name}</h1>
        <div class="buyBox">
            <h1>
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${sessionScope.productList[1].id}"
                   class="buy">
                    立即购买
                </a>
            </h1>
        </div>
    </div>
</div>
<%---------------------------------------------------------------------------------------------%>
<!-- 家电展区 -->
<div class="TVBox">
    <div class="productListBox">
        <h1 align="center">家电/影音</h1>
        <!-- 家电名称列表 -->
        <ul class="ul_nameList">
            <li>
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${sessionScope.productList[5].id}">${sessionScope.productList[5].name}</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${sessionScope.productList[6].id}">${sessionScope.productList[6].name}</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${sessionScope.productList[7].id}">${sessionScope.productList[7].name}</a>
            </li>
        </ul>
    </div>
    <div class="homeImgBox" align="center">
        <h1>${sessionScope.productList[7].name}</h1>
        <div class="buyBox">
            <h1>
                <a href="${pageContext.request.contextPath}/productServlet?action=productInfo&id=${sessionScope.productList[7].id}" class="buy">
                    立即购买
                </a>
            </h1>
        </div>
    </div>
</div>
<%----------------------------------------------------------------------------------------------%>
<div class="statement">
    <p>*本网站提供的屏幕和图像内容，是仅为说明目的而展示的模拟画面。
        产品图片以及型号、数据、功能、性能、规格参数、用户界面和其他产品信息等仅供参考，
        三星有可能对上述内容进行改进，具体信息请参照产品实物、产品说明书。
        除非经特殊说明，本网站中所涉及的数据均为三星内部测试结果，涉及的对比均为与三星产品相比较。
    </p>
</div>
<!-- 底部各种链接 -->
<div id="AllLink"> <!-- 导入linkList.html--> </div>

</body>
<script type="text/javascript">
    window.onload = function () {
        // 导入头部html
        $("#header1").load("${pageContext.request.contextPath}/pages/header.jsp");

        // 导入底部链接html
        $("#AllLink").load("pages/linkList.html");

        //轮播
        layui.use('carousel', function(){
            var carousel = layui.carousel;
            //建造实例
            carousel.render({
                elem: '#swiperOut',
                width: '100%', //设置容器宽度,
                height: '500',
                interval: '1500',   //轮播间隔时间
                arrow: 'always'     //始终显示箭头
                // anim: 'updown',       //轮播方式
                //,anim: 'updown'  //切换动画方式
            });
        });

    }
</script>
</html>
