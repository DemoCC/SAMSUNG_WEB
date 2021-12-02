package dao.imp;

import dao.BaseDao;
import dao.CartItemDao;
import domain.CartItemVO;

import java.util.List;

public class CartItemDaoImp extends BaseDao implements CartItemDao {
    /**
     * 添加购物车
     * @param cartItem 购物车条目
     * @return 返回true代表添加成功
     */
    @Override
    public boolean addCartItem(CartItemVO cartItem) {
        String sql = "insert into cart(id, uid, pid, productName, productImgUrl, quantity, totalMoney)values(?,?,?,?,?,?,?)";
        int num = update(sql, cartItem.getId(), cartItem.getUid(), cartItem.getPid(), cartItem.getProductName(), cartItem.getProductImgUrl(), cartItem.getQuantity(), cartItem.getTotalMoney());
        if (num > 0 )
            return true;
        return false;
    }

    /**
     * 根据用户id查询购物车
     * @param uid 用户id
     * @return 返回购物车商品列表
     */
    @Override
    public List<CartItemVO> queryCart(int uid) {
        String sql = "select * from cart where cart.uid = ?";
        return queryForList(CartItemVO.class, sql, uid);
    }

    /**
     * 根据条目id删除条目
     * @param itemId 条目id
     * @return 删除成功返回true
     */
    @Override
    public boolean deleteCartItem(int itemId) {
        String sql = "delete from cart where id = ?";
        int num = update(sql, itemId);
        if (num > 0)
            return true;
        return false;
    }

    /**
     * 清空购物车
     * @return 返回true清空成功
     */
    @Override
    public boolean clearCart(int uid) {
        String sql = "delete from cart where uid = ?";
        int num = update(sql, uid);
        if (num > 0)
            return true;
        return false;
    }

}