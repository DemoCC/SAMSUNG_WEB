<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>后台管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css" type="text/css"/>
    <link rel="shortcut icon" type="text/css" href="${pageContext.request.contextPath}/img/head/logo2.png"/>
    <style>
        #iframe1 {
            width: 97%;
            height: 90%;
            margin: 10px 10px;
            border: none;
            overflow-x: hidden;
        }

        .idQueryArea {
            width: 100%;
            height: 40px;
            margin: 10px 0;
            line-height: 40px;
        }
        /*搜索框*/
        .layui-input {
            width: 120px;
        }
        .layui-form {
            display: inline;
        }
        .layui-nav-item{
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black" style="background: #009688">后台管理</div>
        <ul class="layui-nav layui-layout-left">
            <!-- 移动端显示 -->
            <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
                <i class="layui-icon layui-icon-spread-left"></i>
            </li>
            <%--顶部导航栏--%>
            <li class="layui-nav-item layui-hide-xs">
                <a onclick="queryAllUsers();">信息查询 </a>
            </li>
            <li class="layui-nav-item layui-hide-xs">
                <a href="${pageContext.request.contextPath}/indexServlet">首页 </a>
            </li>
        </ul>
        <%--顶部导航栏右部--%>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                <a href="javascript:;">
                    <img src="${pageContext.request.contextPath}/img/${sessionScope.user.headImgUrl}"
                         class="layui-nav-img">
                    ${sessionScope.user.name}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="${pageContext.request.contextPath}/pages/personal.jsp">个人信息</a></dd>
                    <dd><a href="${pageContext.request.contextPath}/userServlet?action=logout">退出</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item" lay-header-event="menuRight" lay-unselect>
                <a href="javascript:;">
                    <i class="layui-icon layui-icon-more-vertical"></i>
                </a>
            </li>
        </ul>
    </div>
    <%--侧边栏--%>
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">用户管理</a>
                    <dl class="layui-nav-child">
                        <dd><a onclick="queryAllUsers();">普通用户</a></dd>
                        <dd><a onclick="queryAdmins()">管理员</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">产品管理</a>
                    <dl class="layui-nav-child">
                        <dd><a id="a_allProducts" onclick="queryAllProducts();">全部产品</a></dd>
                        <dd><a onclick="addProduct();">添加产品</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div class="idQueryArea">
            <%--ID查询用户--%>
            <form class="layui-form" action="${pageContext.request.contextPath}/userServlet_Admin?action=queryUserById"
                  method="post">
                <div class="layui-input-inline">
                    <label class="layui-form-label">ID查询用户</label>
                    <div class="layui-input-inline">
                        <input type="text" name="uid" required lay-verify="required" placeholder="请输入ID"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-input-inline">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">查询</button>
                </div>
            </form>
            <%--分类查询产品--%>
            <form class="layui-form" action="${pageContext.request.contextPath}/productServlet_Admin?action=queryProductsByType" method="post">
                <div class="layui-input-inline">
                    <label class="layui-form-label">分类查询</label>
                    <div class="layui-input-inline">
                        <input type="text" name="type" required lay-verify="required" placeholder="请输入产品类别"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-input-inline">
                    <button class="layui-btn" lay-submit lay-filter="formDemo" id="typeQueryBtn">查询</button>
                </div>
            </form>
            <%--名称查询产品--%>
            <form class="layui-form"
                  action="${pageContext.request.contextPath}/productServlet_Admin?action=productFuzzyQuery"
                  method="post">
                <div class="layui-input-inline">
                    <label class="layui-form-label">名称查询</label>
                    <div class="layui-input-inline">
                        <input type="text" name="key" required lay-verify="required" placeholder="请输入产品名称"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-input-inline">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">查询</button>
                </div>
            </form>
        </div>
        <iframe name="iframe1" id="iframe1" src="${pageContext.request.contextPath}/userServlet_Admin?action=queryAllUsers">
        </iframe>
    </div>
    <div class="layui-footer">
        <!-- 底部固定区域 -->
        Copyright© 1995-2021 三星（中国）投资有限公司 版权所有
    </div>
</div>
</body>
<script type="text/javascript">

    const iframe1 = document.getElementById("iframe1");

    //点击所有产品时将iframe改为显示所有产品
    function queryAllProducts() {
        iframe1.src = "${pageContext.request.contextPath}/productServlet_Admin?action=queryAllProducts";
    }

    //点击所有用户时将iframe改为显示所有用户
    function queryAllUsers() {
        iframe1.src = "${pageContext.request.contextPath}/userServlet_Admin?action=queryAllUsers";
    }

    //点击管理员将iframe改为显示管理员jsp
    function queryAdmins() {
        iframe1.src = "${pageContext.request.contextPath}/userServlet_Admin?action=queryAdmins";
    }

    //点击添加产品
    function addProduct() {
        iframe1.src = "${pageContext.request.contextPath}/pages/admin/addProduct.jsp";
    }

    //点击添加产品
    function upDataUser() {
        iframe1.src = "${pageContext.request.contextPath}/pages/admin/upDataUser.jsp";
    }


    layui.use(['element', 'layer', 'util'], function () {
        var element = layui.element
            , layer = layui.layer
            , util = layui.util
            , $ = layui.$;

        //头部事件
        util.event('lay-header-event', {
            //左侧菜单事件
            menuLeft: function (othis) {
                layer.msg('展开左侧菜单的操作', {icon: 0});
            }
            , menuRight: function () {
                layer.open({
                    type: 1
                    , content: '<div style="padding: 15px;">处理右侧面板的操作</div>'
                    , area: ['260px', '100%']
                    , offset: 'rt' //右上角
                    , anim: 5
                    , shadeClose: true
                });
            }
        });
    });

</script>
</html>
