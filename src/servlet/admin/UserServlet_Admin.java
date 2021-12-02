package servlet.admin;

import com.google.gson.Gson;
import dao.imp.UserDaoImp;
import domain.PageBean;
import domain.User;
import servlet.BaseServlet;
import util.WebBeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@WebServlet(value = "/userServlet_Admin")
@MultipartConfig
public class UserServlet_Admin extends BaseServlet {
    UserDaoImp dao = new UserDaoImp();
    private Integer pageNumber = 1; //当前页
    private Integer pageSize = 5;   //每页显示的条数

    //查询所有用户
    public void queryAllUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        PageBean<User> pageBean = new PageBean<>();
        try {
//            pageNumber = Integer.valueOf(request.getParameter("pageNumber"));
            pageNumber= WebBeanUtils.parseInt(request.getParameter("pageNumber"),1);
        }catch (Exception e){
            e.printStackTrace();
            System.out.println("第一次访问");
        }
        int total = dao.getUserTotal();
        pageBean.setPageNumber(pageNumber);
        pageBean.setPageSize(pageSize);
        pageBean.setTotalRecord(total);
        int jurisdiction = 0;   //权限为普通用户的
        List<User> uList = dao.queryAllUsers(pageBean, jurisdiction);
        pageBean.setData(uList);

        session.setAttribute("uList", pageBean);
        response.sendRedirect("pages/admin/allUsers.jsp");

    }

    //通过ID查询用户
    public void queryUserById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDaoImp dao = new UserDaoImp();
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("uid"));
        User user_byId = dao.queryUserById(id);

        //将查到的user存入显示全部用户的表里，然后跳转到显示全部用户的jsp
        session.setAttribute("user_byId", user_byId);
        response.sendRedirect("pages/admin/userById.jsp");
    }

    //查询管理员
    public void queryAdmins(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> uList_admin = dao.queryAdmins();
        HttpSession session = request.getSession();
        if (uList_admin != null) {
            session.setAttribute("uList_admin", uList_admin);
            response.sendRedirect("pages/admin/showAdmins.jsp");
        }
    }

    //删除用户
    public void delUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("uid"));
        User user = dao.queryUserById(id);
        PrintWriter out = response.getWriter();

        //把上传的头像也删掉
        Path path = Paths.get(request.getServletContext().getRealPath("/") + "img/" + user.getHeadImgUrl());
        System.out.println("删除头像：" +path);
        try {
            Files.delete(path);
        }catch (Exception e){
            System.out.println("头像路径不存在");
        }

        boolean isDel = dao.delUserById(id);

        Gson gson = new Gson();
        String ok = gson.toJson("OK");
        String error = gson.toJson("ERROR");
        if (isDel){
            out.write(ok);
        }else {
            out.write(error);
        }
    }

    //设置为管理员
    public void setAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        int uid = Integer.parseInt(request.getParameter("uid"));

        boolean isOk = dao.setAdmin(uid);

        Gson gson = new Gson();
        String ok = gson.toJson("OK");
        String error = gson.toJson("ERROR");
        if (isOk){
            out.write(ok);
        }else {
            out.write(error);
        }

    }

    //移除管理员
    public void removeAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        int uid = Integer.parseInt(request.getParameter("uid"));
        boolean isRemove = dao.removeAdmin(uid);

        Gson gson = new Gson();
        String ok = gson.toJson("OK");
        String error = gson.toJson("ERROR");

        if(isRemove){
            out.write(ok);
        }else {
            out.write(error);
        }
    }
}
