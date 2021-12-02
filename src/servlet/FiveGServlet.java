package servlet;

import dao.imp.ProductDaoImp;
import domain.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(value = "/fiveGServlet")
public class FiveGServlet extends BaseServlet {
    ProductDaoImp pDao = new ProductDaoImp();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> pList_5G = new ArrayList<>();
        int[] ids = {401, 901, 902, 702, 602, 503, 402, 903};

        for (int id : ids) {
            pList_5G.add(pDao.getProductById(id));
        }
        System.out.println("5G设备：" + pList_5G);
        request.setAttribute("pList_5G",pList_5G);
        request.getRequestDispatcher("pages/5G.jsp").forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
