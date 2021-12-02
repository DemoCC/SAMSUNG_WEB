package dao;

import domain.CartItemVO;

import java.util.List;

public interface CartItemDao {
    /**
     * 添加购物车
     * @param cartItem 购物车条目
     * @return 返回true代表添加成功
     */
    boolean addCartItem(CartItemVO cartItem);

    /**
     * 根据用户id查询购物车
     * @param uid 用户id
     * @return 返回购物车商品列表
     */
    List<CartItemVO> queryCart(int uid);

    /**
     * 根据条目id删除条目
     * @param itemId 条目id
     * @return 删除成功返回true
     */
    boolean deleteCartItem(int itemId);

    /**
     * 清空购物车
     * @return 返回true清空成功
     */
    boolean clearCart(int uid);


}
