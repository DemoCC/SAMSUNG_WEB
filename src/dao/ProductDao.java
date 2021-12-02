package dao;

import domain.PageBean;
import domain.Product;

import java.util.List;

public interface ProductDao {
    /**
     * 根据id获取商品信息
     * @param id
     * @return 返回一个商品
     */
    Product getProductById(int id);

    /**
     * 查询所有产品信息
     * @return 返回所有产品信息列表
     */
    List<Product> getAllProducts(PageBean<Product> bean);

    /**
     * 获取产品总数量
     * @return 返回产品的总数量
     */
    int getProductTotal();

    /**
     * 添加产品
     * @return 产品添加成功返回true
     */
    boolean addProduct(Product product);

    /**
     * 根据类别查询产品
     * @param type 产品类别
     * @return 返回产品列表
     */
    List<Product> queryProductsByType(String type, PageBean<Product> pageBean);

    /**
     * 查询某类型产品总条数
     * @param type 产品类型
     * @return 返回某类型产品总条数
     */
    int getProductTotalByType(String type);

    /**
     * 根据id删除商品
     * @param pid 商品id
     * @return 如果删除成功则返回true
     */
    boolean delProduct(int pid);

    /**
     * 更新产品
     * @param product 产品对象
     * @return 返回true代表更新成功
     */
    boolean upDateProduct(Product product);

    /**
     * 根据产品分类查询产品
     * @param type 类别
     * @return 返回产品列表
     */
    List<Product> queryProductsByType(String type);

    /**
     * 关键字模糊查询
     * @param key 关键字
     * @return 返回商品列表
     */
    List<Product> productFuzzyQuery(String key);

}
