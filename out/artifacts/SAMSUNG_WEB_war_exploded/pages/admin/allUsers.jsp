<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-6-4
  Time: 下午 9:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>所有用户</title>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript" ></script>
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/page.css">
</head>
<style>
    #div_upData{
        padding: 5px 30px;
    }
    .layui-input-inline input{
        width: 130px;
        height: 35px;
    }
</style>
<body>
<c:choose>
    <c:when test="${sessionScope.uList.data.size() == 0}">
        <blockquote class="layui-elem-quote">暂无用户信息</blockquote>
    </c:when>
    <c:otherwise>
    <div>
        <blockquote class="layui-elem-quote">普通用户信息</blockquote>
        <table class="layui-table" lay-even lay-skin="nob">
            <colgroup>
                <col width="70">
                <col width="70">
                <col width="50">
                <col width="100">
                <col width="80">
                <col width="130">
                <col width="140">
            </colgroup>
            <thead>
            <tr>
                <th>用户ID</th><th>用户名</th> <th>性别</th> <th>电话</th> <th>生日</th> <th>地址</th><th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="user" items="${sessionScope.uList.data}" varStatus="status">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.name}</td>
                    <td>${user.sex}</td>
                    <td>${user.tel}</td>
                    <td>${user.birth}</td>
                    <td>${user.address}</td>
                    <td>
                        <button id="setAdmin" class="layui-btn layui-btn-sm layui-btn-normal" onclick="setAdmin(${user.id});">设为管理员</button>
                        <button onclick="delUser(${user.id});" class="layui-btn layui-btn-sm layui-btn-danger">删除</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
                <%-- 获取一下当前登录用户的id,删除用户时不能删正在登录的用户--%>
                <span id="loginUId" style="display: none">${sessionScope.user.id}</span>
        <%--分页--%>
        <div style="text-align: center">
            <ul class="page" style="text-align:center; margin-top:10px;">
                <!-- 判断是否是第一页 -->
                <c:if test="${sessionScope.uList.pageNumber == 1 }">
                    <li class="disable">
                        <a href="javascript:void(0)" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <!-- 不是第一页 -->
                <c:if test="${sessionScope.uList.pageNumber != 1 }">
                    <li>
                        <a href="${pageContext.request.contextPath }/userServlet_Admin?action=queryAllUsers&pageNumber=${sessionScope.uList.pageNumber-1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <!-- 展示所有页码 -->
                <c:forEach begin="1" end="${sessionScope.uList.totalPage }" var = "n">
                    <!-- 判断是否是当前页 -->
                    <c:if test="${sessionScope.uList.pageNumber == n }">
                        <li class="actives"><a href="javascript:void(0)">${n }</a></li>
                    </c:if>
                    <c:if test="${sessionScope.uList.pageNumber != n }">
                        <li><a href="${pageContext.request.contextPath }/userServlet_Admin?action=queryAllUsers&pageNumber=${n}">${n}</a></li>
                    </c:if>
                </c:forEach>
                <!-- 判断是否是最后一页 -->
                <c:if test="${sessionScope.uList.pageNumber == sessionScope.uList.totalPage }">
                    <li  class="disable">
                        <a href="javascript:void(0)" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.uList.pageNumber != sessionScope.uList.totalPage }">
                    <li>
                        <a href="${pageContext.request.contextPath }/userServlet_Admin?action=queryAllUsers&pageNumber=${sessionScope.uList.pageNumber+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
    <%--隐藏的用户更新div，给弹出层调用--%>
    <div id="div_upData" style="display: none">
        <form class="layui-form" lay-filter='myForm1' action="${pageContext.request.contextPath}/userServlet_Admin?action=upDataUser" enctype="multipart/form-data" method="post">
            <div class="layui-form-item"><!--头像-->
                <div class="layui-input-inline">
                    <input type="file" name="uploadHead" placeholder="选择头像" autocomplete="off">
                </div>
            </div>
            <div class="layui-form-item"><!--用户名-->
                <div class="layui-input-inline">
                    <input type="text" name="newUsername" lay-verify="required" placeholder="请输入新用户名" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item"><!--密码-->
                <div class="layui-input-inline">
                    <input type="password" name="newPassword" placeholder="请输入新密码" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item"><!--生日-->
                <div class="layui-input-inline">
                    <input type="text" name="newBirth" id="date" lay-verify="date" placeholder="请输入生日" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item"><!--手机号-->
                <div class="layui-input-inline">
                    <input type="tel" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input" placeholder="请输入手机号">
                </div>
            </div>
            <div class="layui-form-item"><!--地址-->
                <div class="layui-input-inline">
                    <input type="text" name="newAddress" lay-verify="required" placeholder="请输入新的地址" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item"><!--设置管理员-->
                <label class="layui-form-label">设为管理员</label>
                <div class="layui-input-block">
                    <input type="checkbox" name="close" lay-skin="switch" lay-text="ON|OFF">
                </div>
            </div>
            <div class="layui-form-item"><!--提交-->
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit lay-filter="formDemo">确认修改</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    </c:otherwise>
</c:choose>
<script>
//删除用户
function delUser(uid) {
    layer.confirm(
        '确定要删除用户吗？',
        {icon: 3},
        function () {
            const loginUId = $("#loginUId").text();
            if (uid == loginUId){
                layer.alert('不能删除当前登录的用户', {icon: 7});
            }else{
                $.ajax({
                    url: '/SAMSUNG_WEB/userServlet_Admin?action=delUser',
                    type: 'get',
                    data: {
                        uid: uid
                    },
                    dataType: 'json',
                    success: function(data){
                        if (data === "OK"){
                            layer.msg('删除成功',
                                {icon: 1, time: 700},
                                function () {
                                    window.location.replace('/SAMSUNG_WEB/userServlet_Admin?action=queryAllUsers');
                                }
                            );
                        }
                        if (data === "ERROR"){
                            layer.msg( '删除失败',
                                {icon: 2, time: 700},
                                function () {
                                    window.location.replace('/SAMSUNG_WEB/userServlet_Admin?action=queryAllUsers');
                                }
                            );
                        }
                    }
                });
            }
        },
        layer.close()
    );
}
//设置管理员
function setAdmin(uid){
    layer.confirm(
        '确定要设为管理员吗？',
        {icon: 3},
        function () {
            $.ajax({
                url: '/SAMSUNG_WEB/userServlet_Admin?action=setAdmin',
                type: 'get',
                data: {
                    uid: uid
                },
                dataType: 'json',
                success: function (data) {
                    if (data === "OK"){
                        layer.msg(
                            '设置成功',
                            {icon: 1, time: 500},
                            function () {
                                window.location.replace('/SAMSUNG_WEB/userServlet_Admin?action=queryAllUsers')
                            }
                        );
                    }
                    if (data === "ERROR"){
                        layer.msg(
                            '设置失败',
                            {icon: 2, time: 500},
                            function () {
                                window.location.replace('/SAMSUNG_WEB/userServlet_Admin?action=queryAllUsers')
                            }
                        );
                    }
                }
            });
        },
        layer.close()
    );
}

</script>
</body>
</html>
