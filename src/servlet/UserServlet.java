package servlet;

import com.google.gson.Gson;
import dao.imp.UserDaoImp;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(value = "/userServlet")
@MultipartConfig
public class UserServlet extends BaseServlet {
    private UserDaoImp dao = new UserDaoImp();

    // 用户登录
    protected void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        //获取前端用户名和密码
        String username = request.getParameter("fname");
        String password = request.getParameter("fpassword");
        //获取自动登陆的值
        String autoLogin = request.getParameter("check");
        //查询并获得用户
        User user = dao.queryUserByNameAndPass(username, password);
        if (user != null) {
            // 自动登陆的值为on
            if ("on".equals(autoLogin)) {
                Cookie uCookie = new Cookie("user", "uCookie");
                uCookie.setMaxAge(60 * 60 * 24);    //设置Cookie存活时长
                uCookie.setPath(request.getContextPath() + "/");
                response.addCookie(uCookie);
                session.setAttribute("user", user);

                if (user.getIsAdmin() == 1) {   //如果是管理员
                    response.sendRedirect(request.getContextPath() + "/pages/admin/managerIndex.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/indexServlet");
                }
            } else {    //不是自动登录
                session.setAttribute("user", user);
                session.removeAttribute("loginMsg");
                if (user.getIsAdmin() == 1 || user.getIsAdmin() == 2  ) {   //如果是管理员 | 超级管理员
                    response.sendRedirect(request.getContextPath() + "/pages/admin/managerIndex.jsp");
                } else{
                    response.sendRedirect(request.getContextPath() + "/indexServlet");
                }
            }
            System.out.println(user.toString() + "\n");
        } else {
            session.setAttribute("loginMsg", "账号或密码错误");
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        }
    }

    // 退出登录
    protected void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //注销账户
        // 清除session
        request.getSession().removeAttribute("user");

        // 把cookie设为null，cook名要与已有的cookie同名
        Cookie uCookie = new Cookie("user", null);
        uCookie.setMaxAge(0);   //存活时间设为为0
        uCookie.setPath(request.getContextPath() + "/");
        response.addCookie(uCookie);

        //最后跳回登录页
        response.sendRedirect("index.jsp");
    }

    //注册账户
    protected void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        //获取注册提交的参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String sex = request.getParameter("sex");
        String tel = request.getParameter("tel");
        String birth = request.getParameter("birth");
        String address = request.getParameter("address");

        if(sex==null || "".equals(sex)){
            sex = "保密";
        }else if("1".equals(sex)){
            sex = "男";
        }else if("0".equals(sex)){
            sex = "女";
        }else {
            sex = "其他";
        }

        if(birth == null || "".equals(birth)){
            birth = "没有生日信息";
        }
        if(address == null || "".equals(address)){
            address = "暂无地址";
        }
        //Part用来上传文件
        Part part = request.getPart("headImg_upload");

        //将文件保存到服务器的根目录(web)下
        String path = this.getServletContext().getRealPath("/img");
        File file = new File(path);
        //判断该path下的文件是否存在
        if (!file.exists()) {
            file.mkdirs();  //不存在则创建
        }
        //设置上传的文件的名称
        String header = part.getHeader("content-disposition");
        //设置上传的文件的后缀名
        String fName = header.substring(header.lastIndexOf("."), header.length() - 1);
        //将文件写入到路径中
        part.write(path + "\\headImg\\" + username + fName);
        String iUrl = "headImg/" + username + fName;
        System.out.println("上传头路径：" +path + iUrl);

        //将数据封装都javabean中，然后保存到数据库中
        User user = new User(null, username, password, sex, tel, birth, address, iUrl, null);
        System.out.println(user);

        boolean isAdd = dao.addUser(user);
        if (isAdd) {
            response.getWriter().print("注册成功，1秒后跳转到登录页面！");
            response.setHeader("Refresh", "1;URL="+request.getContextPath()+"/pages/login.jsp");
        } else {
            response.getWriter().print("注册失败，1秒后跳转到注册页面！");
            response.setHeader("Refresh", "1,URL="+request.getContextPath()+"/pages/register.jsp");
        }

    }

    //验证用户名是否存在
    protected void judgeUsername(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String username = request.getParameter("username");
        User user = dao.queryUserByUserName(username);

        Gson gson = new Gson();
        String success = gson.toJson("SUCCESS");
        String failed = gson.toJson("FAILED");  //前端data的值

        if (user != null) {
            out.write(failed);
        } else {
            out.write(success);
        }
    }

    //修改个人信息
    protected void upDateInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int uid = Integer.parseInt(request.getParameter("uid"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String sex = request.getParameter("sex");
        String tel = request.getParameter("tel");
        String birth = request.getParameter("birth");
        String address = request.getParameter("address");

        String sexStr = null;
        if ("".equals(sex)){
            sexStr = "保密";
        }else if ("0".equals(sex)){
            sexStr = "女";
        }else if ("1".equals(sex)){
            sexStr = "男";
        }

        //Part用来上传文件
        Part part = request.getPart("newHeadImg");

        //将文件保存到服务器的根目录(web)下
        String path = this.getServletContext().getRealPath("/img");
        File file = new File(path);
        //判断该path下的文件是否存在
        if (!file.exists()) {
            file.mkdirs();  //不存在则创建
        }
        //设置上传的文件的名称
        String header = part.getHeader("content-disposition");
        //设置上传的文件的后缀名
        String fName = header.substring(header.lastIndexOf("."), header.length() - 1);
        //将文件写入到路径中
        part.write(path + "\\headImg\\" + username + fName);
        String iUrl = "headImg/" + username + fName;
        System.out.println("上传头路径：" +path + iUrl);

        User user = new User(uid, username, password, sexStr, tel, birth, address, iUrl);

        boolean isOk = dao.upDateUser(user);
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        if (isOk){
            response.sendRedirect(request.getContextPath() +"/pages/personal.jsp");
        }else {
            response.sendRedirect(request.getContextPath() +"/pages/editUser.jsp");
        }
        System.out.println(user);

    }
}
