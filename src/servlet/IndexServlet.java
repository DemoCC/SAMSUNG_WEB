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

@WebServlet(value = "/indexServlet")
public class IndexServlet extends HttpServlet {
    ProductDaoImp dao = new ProductDaoImp();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Product> productList = new ArrayList<Product>();
        //添加产品
        /* 想展示的产品的id
         */
        int[] ids = {301, 401, 601, 501, 503, 110, 111, 113};
        for (int id : ids) {
            Product product = dao.getProductById(id);
            productList.add(product);
        }
        System.out.println("调用indexServlet-----");

        HttpSession session = request.getSession();
        session.setAttribute("productList", productList);
        request.getRequestDispatcher("/index.jsp").forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

}
