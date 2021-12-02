<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-6-7
  Time: 下午 3:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加商品</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css" type="text/css"/>
    <style>
        body{
            text-align: center;
        }
        #myForm label{
            display: inline-block;
            width: 150px;
            text-align: right;
        }
        .layui-input{
            width: 200px;
            margin-top: 12px;
            display: inline;
        }
       .imgDiv{
           display: inline-block;
           width: 200px;
           margin-top: 15px;
       }
       /*提交*/
        .submitBtn{
            width: 80px;
            height: 35px;
            border: none;
            outline: none;
            background: #009688;
            margin: 15px 20px;
            border-radius: 2px;
            color: white;
        }
    </style>
</head>
<body>
    <blockquote class="layui-elem-quote">添加商品</blockquote>
    <form id="myForm" action="${pageContext.request.contextPath}/productServlet_Admin?action=addProduct" method="post" enctype="multipart/form-data">
        <label>商品名称：</label>
        <input type="text" id="name" name="pName" placeholder="请输入商品名称" autocomplete="off" class="layui-input">
        <br>
        <label>商品价格：</label>
        <input type="text" id="price" name="price" placeholder="请输入商品价格" autocomplete="off" class="layui-input">
        <br>
        <label>商品颜色：</label>
        <input type="text" id="color" name="color" placeholder="请输入商品颜色" autocomplete="off" class="layui-input">
        <br>
        <label>商品类型：</label>
        <input type="text" id="type" name="type" placeholder="请输入商品类型" autocomplete="off" class="layui-input">
        <br>
        <label>商品库存：</label>
        <input type="text" id="stock" name="stock" placeholder="请输入商品库存" autocomplete="off" class="layui-input">
        <br>
        <label>商品图片：</label>
        <div class="imgDiv">
            <input type="file" id="productImg" name="productImg">
        </div>
        <br>
        <input type="submit" value="添加" class="submitBtn">
    </form>
<script>
//表单验证
function isEmpty(obj){
    if(obj == ""){
        return true;
    }else{
        return false;
    }
}

$("#myForm").bind("submit",function(){
    const name = $("#name").val();
    const price = $("#price").val();
    const color = $("#color").val();
    const type = $("#type").val();
    const stock = $("#stock").val();
    const productImg = $("#productImg").val();

    if(isEmpty(name) || isEmpty(price) || isEmpty(color) || isEmpty(type) || isEmpty(stock)
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

</script>
</body>
</html>
