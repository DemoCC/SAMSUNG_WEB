package servlet.admin;

import com.google.gson.Gson;
import dao.ProductDao;
import dao.imp.ProductDaoImp;
import domain.PageBean;
import domain.Product;
import servlet.BaseServlet;

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

@WebServlet(value = "/productServlet_Admin")
@MultipartConfig
public class ProductServlet_Admin extends BaseServlet {
    ProductDao pDao = new ProductDaoImp();

    public Integer pageNumber = 1;  //当前页
    public Integer pageSize = 5;    //页面展示条数

    //查询所有产品
    public void queryAllProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        PageBean<Product> bean = new PageBean<>();
        try {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        } catch (Exception e) {
            System.out.println("第一次访问分页异常");
        }
        int total = pDao.getProductTotal();
        bean.setPageNumber(pageNumber);
        bean.setPageSize(pageSize);
        bean.setTotalRecord(total);

        List<Product> pList_Admin = pDao.getAllProducts(bean);
        bean.setData(pList_Admin);

        session.setAttribute("pList_Admin", bean);
        response.sendRedirect(request.getContextPath() + "/pages/admin/allProducts.jsp");
    }

    //使用ID查询产品
    public void queryProductById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();

        int pid = Integer.parseInt(request.getParameter("pid"));
        try {
            Product product_byId = pDao.getProductById(pid);
//            session.setAttribute("product",product_byId);
            Gson gson = new Gson();
            String json = gson.toJson(product_byId);
            System.out.println(json);
            out.write(json);
        }catch (Exception e){
            e.printStackTrace();
            out.write("FAILED");
        }

    }

    //添加产品
    public void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pName = request.getParameter("pName");
        double price = Double.parseDouble(request.getParameter("price"));
        String color = request.getParameter("color");
        String type = request.getParameter("type");
        int stock = Integer.parseInt(request.getParameter("stock"));

        //Part用来上传文件
        Part part = null;
        try {
            part = request.getPart("productImg");
        } catch (IOException e) {
            System.out.println("没有选择图片异常");
        }
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
        part.write(path + "\\products\\" + pName + fName);
        String iUrl = "\\products\\" + pName + fName;
        System.out.println("产品名上传路径：" + path + iUrl);

        Product product = new Product(null, pName, price, color, type, stock, iUrl);

        boolean isAdd = pDao.addProduct(product);
        if (isAdd) {
            response.sendRedirect(request.getContextPath() + "/productServlet_Admin?action=queryAllProducts");
        } else {
            response.getWriter().print("上传失败");
        }
    }

    //根据id删除商品
    public void delProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        int pid = Integer.parseInt(request.getParameter("pid"));

        //删除数据的同时把产品的图片文件也删掉
        Product product = pDao.getProductById(pid);
        Path path = Paths.get(request.getServletContext().getRealPath("/") + "/img/" + product.getUrl());
        System.out.println("删除商品的时候删除的图片：" + path);
        //删除图片
        Files.delete(path);
        //删除
       boolean isSuccess = pDao.delProduct(pid);

       Gson gson = new Gson();
       String ok = gson.toJson("OK");
       String error = gson.toJson("ERROR");
       if (isSuccess){
           out.write(ok);
       }else {
           out.write(error);
       }

    }

    //显示修改产品信息jsp
    public void goUpDataPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        int pid = Integer.parseInt(request.getParameter("pid"));
        Product product = pDao.getProductById(pid);

        request.setAttribute("product", product);
        request.getRequestDispatcher("pages/admin/updataProduct.jsp").forward(request, response);

    }

    //修改产品信息
    public void upDateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pid = Integer.parseInt(request.getParameter("pid"));
        String pName = request.getParameter("pName");
        Double price = Double.valueOf(request.getParameter("price"));
        String color = request.getParameter("color");
        String type = request.getParameter("type");
        if ("".equals(type)){
            type = "其他";
        }else if("1".equals(type)){
            type = "手机";
        }else if("2".equals(type)){
            type = "穿戴";
        }else if("3".equals(type)){
            type = "办公";
        }
        int stock = Integer.parseInt(request.getParameter("stock"));

        //Part用来上传文件
        Part part = null;
        try {
            part = request.getPart("productImg");
        } catch (IOException e) {
            System.out.println("没选择文件异常");
        }
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
        part.write(path + "\\products\\" + pName + fName);
        String iUrl = "\\products\\" + pName + fName;
        System.out.println("产品图片上传路径：" + path + iUrl);

        Product product = new Product(pid, pName, price, color, type, stock, iUrl);

        boolean isUpdate = pDao.upDateProduct(product);
        if (isUpdate){
            response.sendRedirect(request.getContextPath() + "/productServlet_Admin?action=queryAllProducts");
        }else {
            response.getWriter().print("修改失败，2秒后跳回到后台主页！");
            response.setHeader("Refresh", "2;URL="+request.getContextPath()+"/pages/admin/managerIndex.jsp");
        }
    }

    //分类查询产品
    public void queryProductsByType(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        List<Product> pList_type = pDao.queryProductsByType(type);

        request.setAttribute("pList_type", pList_type);
        request.getRequestDispatcher("pages/admin/productsByType.jsp").forward(request, response);

    }

    //产品模糊查询
    public void productFuzzyQuery(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String key = request.getParameter("key");

        request.setAttribute("key_FuzzyQuery", key);
        List<Product> pList_Fuzz = pDao.productFuzzyQuery(key);
        request.setAttribute("pList_Fuzz", pList_Fuzz);
        request.getRequestDispatcher("pages/admin/productFuzzyQuery.jsp").forward(request, response);

    }
}
