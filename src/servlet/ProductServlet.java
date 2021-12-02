package servlet;

import dao.ProductDao;
import dao.imp.ProductDaoImp;
import domain.PageBean;
import domain.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/productServlet")
public class ProductServlet extends BaseServlet {
    ProductDao dao = new ProductDaoImp();
    public Integer pageNumber = 1;  //当前页
    public Integer pageSize = 16;   //页面展示条数

    //查询所有产品
    protected void queryAllProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("第一次访问分页异常");
        }
        PageBean<Product> bean = new PageBean<>();
        int total = dao.getProductTotal();
        bean.setPageNumber(pageNumber);
        bean.setPageSize(pageSize);
        bean.setTotalRecord(total);
        List<Product> pList = dao.getAllProducts(bean);
        bean.setData(pList);

        session.setAttribute("pList", bean);
        response.sendRedirect(request.getContextPath() + "/pages/showAllProducts.jsp");
    }

    //进入商品详情页
    protected void productInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        int id = Integer.parseInt(request.getParameter("id"));
        Product product = dao.getProductById(id);
        session.setAttribute("product_moreInfo", product);

        response.sendRedirect("pages/productInfo.jsp");

    }

    //根据类型查询产品
    protected void queryProductsByType(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String type = request.getParameter("type");

        PageBean<Product> bean = new PageBean<>();
        bean.setPageNumber(pageNumber);
        bean.setPageSize(pageSize);
        int total = dao.getProductTotalByType(type);
        System.out.println(type + "," + total);
        bean.setTotalRecord(total);

        List<Product> pList_type = dao.queryProductsByType(type, bean);
        System.out.println("pList_type：" + pList_type);
        bean.setData(pList_type);

        session.setAttribute("pList_type", bean);
        response.sendRedirect("pages/showProductsByType.jsp");

    }
}
