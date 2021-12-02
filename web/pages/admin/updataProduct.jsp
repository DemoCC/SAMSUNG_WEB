<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-6-16
  Time: 下午 11:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改产品信息</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript" ></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css" type="text/css"/>
    <style type="text/css">
        .formBox{
            width: 400px;
            margin: 0 auto;
        }
        /*输入框和下拉框 */
        .formBox input{
            width: 200px;
            margin: 6px 0;
            display: inline;
            line-height: 35px;
            border: 1px solid #c0c4cc;
            border-radius: 2px;
            padding: 0 5px;
        }
        .pType{
            display: inline;
            margin: 0;
            padding: 0;
        }
        /*下拉框*/
        .pType{
            width: 200px;
            height: 35px;
            border: 1px solid #c0c4cc;
            margin: 6px 0;
        }
        /*提交按钮*/
        .submitBtn{
            width: 150px !important;
            background: #009688;
            color: #ffffff;
            outline: none;
            margin-left: 95px !important;
        }
    </style>
</head>
<body>
<blockquote class="layui-elem-quote">修改产品信息</blockquote>
<div class="formBox ">
    <form id="myForm" action="${pageContext.request.contextPath}/productServlet_Admin?action=upDateProduct" method="post" enctype="multipart/form-data">
        <input type="text" name="pid" value="${requestScope.product.id}" style="display: none">
        <label>产品名称：</label>
        <input type="text" name="pName" id="pName" value="${requestScope.product.name}" autocomplete="off" >
        <br>
        <label>产品价格：</label>
        <input type="text" id="price" name="price" value="${requestScope.product.price}" autocomplete="off" >
        <br>
        <label>产品颜色：</label>
        <input type="text" name="color" id="color" value="${requestScope.product.color}" autocomplete="off" >
        <br>
        <label>产品类型：</label>
        <select class="pType" name="type" id="pType">
            <option value=""> 类型</option>
            <option value="1">手机</option>
            <option value="2">穿戴</option>
            <option value="3">办公</option>
        </select>
        <br>
        <label>产品库存：</label>
        <input type="text" id="stock" name="stock" value="${requestScope.product.stock}" autocomplete="off" >
        <br>
        <div class="imgDiv">
            <label>产品图片：</label>
            <input type="file" id="productImg" name="productImg">
        </div>
        <input type="submit" value="确认修改" class="submitBtn">
    </form>
</div>
<script type="text/javascript">
//表单验证
function isEmpty(obj){
    if(obj == ""){
        return true;
    }else{
        return false;
    }
}

$("#myForm").bind("submit",function(){
    const pName = $("#pName").val();
    const price = $("#price").val();
    const color = $("#color").val();
    const pType = $("#pType").val();
    const stock = $("#stock").val();
    const productImg = $("#productImg").val();

    if(isEmpty(pName) || isEmpty(price) || isEmpty(color) || isEmpty(pType) || isEmpty(stock)
        || isEmpty(productImg)){
        layer.alert('请完善信息', {icon: 7});
        return false;
    }else {
        return true;
    }
});

//验证价格
$("#price").keyup(function () {
    let price = $("#price").val();
    let reg_price = /^\+?[1-9][0-9]*$/;
    if (!reg_price.test(price)){
        layer.alert('请输入正整数',{icon: 7});
        $("#price").val("");
        return false
    }
});
//验证库存
$("#stock").keyup(function () {
    let stock = $("#stock").val();
    let reg_stock = /^\+?[1-9][0-9]*$/;
    if (!reg_stock.test(stock)){
        layer.alert('请输入正整数',{icon: 7});
        $("#price").val("");
        return false
    }
    //判断是否有小数
    const point = String(stock).indexOf(".") + 1;
    if (point>0){
        layer.alert('库存不能为小数',{icon: 7});
        $("#stock").val("");
        return false
    }
});

layui.use(['form', 'dropdown', 'layer', 'table'], function() {
    const dropdown = layui.dropdown,
            layer = layui.layer;

})
</script>
</body>
</html>
