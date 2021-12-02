package dao;

import domain.OrderItemVO;
import domain.PageBean;

import java.util.List;

public interface OrderItemDao {
    /**
     * 生成一个订单
     * @param orderItemVO 订单对象
     * @return 返回true代表订单生成成功
     */
    boolean createOrderItem(OrderItemVO orderItemVO);


    /**
     * 根据用户id查询此用户未完成的订单，并放入购物车
     * @param uid 用户id
     * @param pageBean 分页
     * @return 返回此用户未完成的所有订单
     */
    List<OrderItemVO> queryOrders(int uid, PageBean<OrderItemVO> pageBean);

}
