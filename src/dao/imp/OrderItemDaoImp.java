package dao.imp;

import dao.BaseDao;
import dao.OrderItemDao;
import domain.OrderItemVO;
import domain.PageBean;

import java.util.List;

public class OrderItemDaoImp extends BaseDao implements OrderItemDao{

    /**
     * 生成一个订单
     * @param orderItem 订单对象
     * @return 返回true代表订单生成成功
     */
    @Override
    public boolean createOrderItem(OrderItemVO orderItem) {
        String sql = "insert into orders(id, uid, quantity, orderMoney, createTime, status, receiver, receiverAddress)values(?,?,?,?,?,?,?,?)";
        int num = update(sql, orderItem.getId(),
                                orderItem.getUid(),
                                orderItem.getQuantity(),
                                orderItem.getOrderMoney(),
                                orderItem.getCreateTime(),
                                orderItem.getStatus(),
                                orderItem.getReceiver(),
                                orderItem.getReceiverAddress()
                        );
        if (num > 0)
            return true;
        return false;
    }

    /**
     * 查询此用户的订单
     * @param uid 用户id
     * @param pageBean 分页
     * @return 返回此用户所有订单
     */
    @Override
    public List<OrderItemVO> queryOrders(int uid, PageBean<OrderItemVO> pageBean) {
        String sql = "select * \n" +
                "from orders join users on orders.uid = users.id join products on orders.pid = products.id \n" +
                "where orders.uid = ? order by orders.id limit ?,? ";
        return queryForList(OrderItemVO.class, sql, uid, pageBean.getStartIndex(), pageBean.getPageSize());
    }
}
