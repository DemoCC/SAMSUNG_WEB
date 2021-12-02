package servlet;

import com.google.gson.Gson;
import dao.imp.OrderItemDaoImp;
import dao.imp.UserDaoImp;
import domain.OrderItemVO;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(value = "/orderServlet")
public class OrderServlet extends BaseServlet {
    UserDaoImp uDao = new UserDaoImp();
    OrderItemDaoImp oDao = new OrderItemDaoImp();
    //添加订单
    protected void createOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        int uid = Integer.parseInt(request.getParameter("uid"));
        //获取系当前时间和用户id字符串作为订单id
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HHmmss");
        Date date = new Date(System.currentTimeMillis());
        String id = sdf.format(date) + "-" + uid;

        int productTotal = Integer.parseInt(request.getParameter("productTotal"));
        Double orderMoney = Double.valueOf(request.getParameter("orderMoney"));

        //订单生成时间
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date2 = new Date(System.currentTimeMillis());
        String dateStr = sdf2.format(date2);

        String status = "已完成";
        User user = uDao.queryUserById(uid);
        String receiver = user.getName();
        String receiverAddress = user.getAddress();

        OrderItemVO orderItem = new OrderItemVO(id, uid, productTotal, orderMoney, dateStr, status, receiver, receiverAddress);
        boolean isCreate = oDao.createOrderItem(orderItem);

        Gson gson = new Gson();
        String success = gson.toJson("SUCCESS");
        String failed = gson.toJson("FAILED");
        if (isCreate){
            out.write(success);
        }else {
            out.write(failed);
        }

    }

    //查询所有订单
    protected void queryOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
