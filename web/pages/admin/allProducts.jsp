<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-6-4
  Time: 下午 5:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/page.css">
<%--<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">--%>
<html>
<head>
    <title>所有产品</title>
    <style type="text/css">
        #showPInfo{
            padding: 0;
            margin-left: 50px;
        }
        .productImg img{
            width: 350px;
            height: 300px;
        }
        /*弹出层的表格宽度*/
        .popupTable th{
            width: 200px;
        }
        .popupTable td{
            width: 600px;
        }
    </style>
</head>
<body style="margin: 0 10px">
<blockquote class="layui-elem-quote">所有产品信息</blockquote>
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
            <c:forEach var="product" items="${sessionScope.pList_Admin.data}" varStatus="status">
            <tr>
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td>${product.price}</td>
                <td>${product.type}</td>
                <td>${product.color}</td>
                <td>${product.stock}</td>
                <td>
                    <button id="seeProduct" onclick="showProductInfo(${product.id});" class="layui-btn layui-btn-sm layui-btn-normal">查看</button>
                    <a type="button" href="${pageContext.request.contextPath}/productServlet_Admin?action=goUpDataPro&pid=${product.id}" class="layui-btn layui-btn-sm layui-btn-warm">修改</a>
                    <a onclick="delProduct(${product.id});" class="layui-btn layui-btn-sm layui-btn-danger">删除</a>
                </td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
<div id="showPInfo" style="display:none;">
<div class="layui-row">
        <div class="layui-col-xs6">
            <div class="grid-demo grid-demo-bg1">
                <div class="productImg">
                    <img id="productImg" src="" alt="图片加载失败">
                </div>
            </div>
        </div>
        <div class="layui-col-xs6">
            <div class="grid-demo">
                <table class="layui-table popupTable" lay-size="lg" lay-even lay-skin="nob">
                    <colgroup>
                        <col width="100">
                        <col width="100">
                        <col width="100">
                        <col width="100">
                        <col width="150">
                        <col>
                    </colgroup>
                    <tr>
                        <th>产品名</th><td id="td_pName"></td>
                    </tr>
                    <tr>
                        <th>价格</th><td id="td_price"></td>
                    </tr>
                    <tr>
                        <th>类型</th><td id="td_type"></td>
                    </tr>
                    <tr>
                        <th>颜色</th><td id="td_color"></td>
                    </tr>
                    <tr>
                        <th>库存</th><td id="td_stock"></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    </div>
<%--分页--%>
<div style="text-align: center">
        <ul class="page" style="text-align:center; margin-top:10px;">
            <!-- 判断是否是第一页 -->
            <c:if test="${sessionScope.pList_Admin.pageNumber == 1 }">
                <li class="disable">
                    <a href="javascript:void(0)" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
            </c:if>
            <!-- 不是第一页 -->
            <c:if test="${sessionScope.pList_Admin.pageNumber != 1 }">
                <li>
                    <a href="${pageContext.request.contextPath }/productServlet_Admin?action=queryAllProducts&pageNumber=${sessionScope.pList_Admin.pageNumber-1}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
            </c:if>
            <!-- 展示所有页码 -->
            <c:forEach begin="1" end="${sessionScope.pList_Admin.totalPage }" var = "n">
                <!-- 判断是否是当前页 -->
                <c:if test="${sessionScope.pList_Admin.pageNumber == n }">
                    <li class="actives"><a href="javascript:void(0)">${n }</a></li>
                </c:if>
                <c:if test="${sessionScope.pList_Admin.pageNumber != n }">
                    <li><a href="${pageContext.request.contextPath }/productServlet_Admin?action=queryAllProducts&pageNumber=${n}">${n }</a></li>
                </c:if>
            </c:forEach>
            <!-- 判断是否是最后一页 -->
            <c:if test="${sessionScope.pList_Admin.pageNumber == sessionScope.pList_Admin.totalPage }">
                <li  class="disable">
                    <a href="javascript:void(0)" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${sessionScope.pList_Admin.pageNumber != sessionScope.pList_Admin.totalPage }">
                <li>
                    <a href="${pageContext.request.contextPath }/productServlet_Admin?action=queryAllProducts&pageNumber=${sessionScope.pList_Admin.pageNumber+1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </div>
<script type="text/javascript">
//查看商品详细信息
function showProductInfo(pid) {
    $.ajax({
        url: '/SAMSUNG_WEB/productServlet_Admin?action=queryProductById',
        type: 'get',
        async: false,
        data: {
            pid: pid
        },
        dataType: 'json',
        success: function(data) {
            $("#productImg").attr("src","/SAMSUNG_WEB/img/"+ data.url);
            $("#td_pName").text(data.name);
            $("#td_price").text(data.price);
            $("#td_color").text(data.color);
            $("#td_type").text(data.type);
            $("#td_stock").text(data.stock);
        }
    });
    layer.open({
        type: 1,
        area: ['900px','380px'],
        offset: 'auto',
        title: '商品信息',
        content: $("#showPInfo"),
        end: function(){
            $('#showPInfo').css({'display':'none'});
            return false;
        }
    });
}

//删除商品
function delProduct(pid) {
    layer.confirm(
        '确定要删除此商品吗？',
        {icon: 3},
        function () {
            $.ajax({
                url: '/SAMSUNG_WEB/productServlet_Admin?action=delProduct',
                type: 'get',
                data: {
                    pid: pid
                },
                dataType: 'json',
                success: function (data) {
                    if (data === 'OK'){
                        layer.msg('删除成功', {icon: 1, time: 600},
                            function () {
                                window.location.replace("/SAMSUNG_WEB/productServlet_Admin?action=queryAllProducts");
                            }
                        );
                    } if (data === 'ERROR'){
                        layer.msg('删除失败', {icon: 2, time: 600},
                            function () {
                                window.location.replace("/SAMSUNG_WEB/productServlet_Admin?action=queryAllProducts");
                            }
                        );
                    }
                }

            })
        }
    );

}


</script>
</body>
</html>
