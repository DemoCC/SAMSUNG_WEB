package servlet;

import dao.imp.ProductDaoImp;
import domain.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(value = "/netStoreServlet")
public class NetStoreServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDaoImp dao = new ProductDaoImp();
        HttpSession session = request.getSession();

        //获取需要显示的产品列表
        List<Product> netStoreList1 = new ArrayList<>();
        //推荐列表
        int[] ids = {801, 802, 803, 804, 901};
        for (int id : ids) {
            Product product = dao.getProductById(id);
            netStoreList1.add(product);
        }
        System.out.println("--------netStore的列表1--------");
        for (Product product : netStoreList1) {
            System.out.println(product);
        }

        List<Product> netStoreList2 = new ArrayList<>();
        //手机列表
        int[] ids2 = {501, 503, 601, 701};
        for (int id : ids2) {
            Product product = dao.getProductById(id);
            netStoreList2.add(product);
        }
        //穿戴列表
        List<Product> netStoreList3 = new ArrayList<>();
        int[] ids3 = {310, 311, 312, 313};
        for (int id : ids3) {
            Product product = dao.getProductById(id);
            netStoreList3.add(product);
        }

        session.setAttribute("netStoreList1", netStoreList1);
        session.setAttribute("netStoreList2", netStoreList2);
        session.setAttribute("netStoreList3", netStoreList3);
        response.sendRedirect("pages/netstore.jsp");

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
