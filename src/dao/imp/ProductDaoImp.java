package dao.imp;

import dao.BaseDao;
import dao.ProductDao;
import domain.PageBean;
import domain.Product;

import java.util.List;

public class ProductDaoImp extends BaseDao implements ProductDao {

    /**
     * 根据产品id查询产品
     * @param id 产品id
     * @return 返回一个产品信息
     */
    @Override
    public Product getProductById(int id) {
        String sql = "select * from products where id = ?";
        return queryForOne(Product.class, sql, id);
    }

    /**
     * 查询所有产品信息
     * PageBean bean
     * @return 返回所有产品信息列表
     */
    @Override
    public List<Product> getAllProducts(PageBean<Product> bean) {
        String sql = "select * from products where type <> '其他' order by id desc limit ?, ?";
        return queryForList(Product.class, sql, bean.getStartIndex(), bean.getPageSize());
    }

    /**
     * 获取产品总条数
     * @return 返回产品总条数
     */
    @Override
    public int getProductTotal() {
        String sql = "select count(*) from products";
        return ((Long) queryForSingleValue(sql)).intValue();
    }

    /**
     * 添加产品
     * @param  product 创建产品
     * @return 产品添加成功返回true
     */
    @Override
    public boolean addProduct(Product product) {
        String sql = "insert into products(name,price,color,type,stock,url)values(?,?,?,?,?,?)";
        int num = update(sql, product.getName(), product.getPrice(), product.getColor(), product.getType(), product.getStock(), product.getUrl());

        if (num > 0)
            return true;
        return false;
    }

    /**
     * 根据类别查询产品
     * @param type 产品类别
     * @return 返回产品列表
     */
    @Override
    public List<Product> queryProductsByType(String type, PageBean<Product> pageBean) {
        String sql = "select * from products where type = ? order by id desc limit ?, ?" ;
        return queryForList(Product.class, sql, type, pageBean.getStartIndex(), pageBean.getPageSize());
    }

    /**
     * 查询某类型产品总条数
     * @return 返回某类型产品总条数
     */
    @Override
    public int getProductTotalByType(String type) {
        String sql = "select count(*) from products where type = ?";
        return ((Long) queryForSingleValue(sql, type)).intValue();
    }

    /**
     * 根据id删除商品
     * @param pid 商品id
     * @return 如果删除成功则返回true
     */
    @Override
    public boolean delProduct(int pid) {
        String sql = "delete from products where id = ? ";
        int num = update(sql, pid);
        if (num > 0)
            return true;
        return false;
    }

    /**
     * 更新产品
     * @param product 产品对象
     * @return 返回true代表更新成功
     */
    @Override
    public boolean upDateProduct(Product product) {
        String sql = "update products set name=?, price=?, color=?, type=?, stock=?, url=? where id=?";
        int num = update(sql, product.getName(), product.getPrice(), product.getColor(), product.getType(), product.getStock(), product.getUrl(), product.getId());
        if (num > 0)
            return true;
        return false;
    }

    /** 后台用的，没有分页
     * 根据产品分类查询产品
     * @param type 类别
     * @return 返回产品列表
     */
    @Override
    public List<Product> queryProductsByType(String type) {
        String sql = "select * from products where type=?";
        return queryForList(Product.class, sql, type);
    }

    /**
     * 关键字模糊查询
     * @param key 关键字
     * @return 返回商品列表
     */
    @Override
    public List<Product> productFuzzyQuery(String key) {
        key="%"+key+"%";
        String sql = "select * from products where name like ? ";
        return queryForList(Product.class, sql, key);
    }
//
//    public static void main(String[] args) {
//
//        List<Product> list = new ProductDaoImp().productFuzzyQuery("note");
//        System.out.println(list);
//    }

}
