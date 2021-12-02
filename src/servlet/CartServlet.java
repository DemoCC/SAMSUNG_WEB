package servlet;

import com.google.gson.Gson;
import dao.imp.CartItemDaoImp;
import dao.imp.ProductDaoImp;
import dao.imp.UserDaoImp;
import domain.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(value = "/cartServlet")
public class CartServlet extends BaseServlet {
    CartItemDaoImp cDao = new CartItemDaoImp();
    UserDaoImp uDao = new UserDaoImp();
    ProductDaoImp pDao = new ProductDaoImp();

    //将商品添加到购物车
    protected void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        //获取前端数据
        //用户id
        int uid = Integer.parseInt(request.getParameter("uid"));
        //产品id
        int pid = Integer.parseInt(request.getParameter("pid"));
        User user = uDao.queryUserById(uid);
        Product product = pDao.getProductById(pid);

        //购买数量
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        //购物车item总金额
        double totalMoney = quantity * product.getPrice();

        CartItemVO cartItem = new CartItemVO(null, uid, pid, product.getName(), product.getUrl(), quantity, totalMoney);
        boolean isCreate = cDao.addCartItem(cartItem);

        Gson gson = new Gson();
        String success = gson.toJson("SUCCESS");
        String failed = gson.toJson("FAILED");

        if (isCreate) {
            out.write(success);
        } else {
            out.write(failed);
        }

    }

    //查询购物车
    protected void queryCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
//       if (session.getAttribute("user") == null){
//           response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
//       }
       int uid = 0;
       try {
           uid = Integer.parseInt(request.getParameter("uid"));
       }catch (Exception e){
           System.out.println("用户未登录");
       }
        //获取购物车列表
        List<CartItemVO> cartItemList = cDao.queryCart(uid);
        //计算商品总数量
        int productTotal = 0;
        for (CartItemVO cartItem : cartItemList){
            productTotal += cartItem.getQuantity();
        }
        //计算购物车总价
        double totalMoney = 0;
        for (CartItemVO cartItem : cartItemList){
            totalMoney += cartItem.getTotalMoney();
        }
        System.out.println("cartItemList:" + cartItemList);
        System.out.println("购物车结算总价：" + totalMoney);
        System.out.println("购物车视频总数量：" + productTotal);

        Gson gson = new Gson();
        String totalMoney2 = gson.toJson(totalMoney);

        if (cartItemList.size() != 0){
            response.getWriter().write(totalMoney2);
        }
        request.setAttribute("cartItemList", cartItemList);
        request.setAttribute("totalMoney", totalMoney);
        request.setAttribute("productTotal",productTotal);

        request.getRequestDispatcher("pages/cart.jsp").forward(request, response);
    }

    //删除购物车条目
    protected void deleteCartItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        int itemId = Integer.parseInt(request.getParameter("itemId"));
        boolean isDelete = cDao.deleteCartItem(itemId);

        Gson gson = new Gson();
        String success = gson.toJson("SUCCESS");
        String failed = gson.toJson("FAILED");
        if (isDelete){
            out.write(success);
        }else {
            out.write(failed);
        }
    }

    //清空购物车
    protected void clearCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int uid = Integer.parseInt(request.getParameter("uid"));

        boolean isClear = cDao.clearCart(uid);
        System.out.println("清空购物车的用户id：" + uid);
        Gson gson = new Gson();
        if (isClear){
            String success = gson.toJson("SUCCESS");
            response.getWriter().write(success);
        }else {
            String failed = gson.toJson("FAILED");
            response.getWriter().write(failed);
        }
    }

}
