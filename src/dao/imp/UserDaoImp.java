package dao.imp;

import dao.BaseDao;
import dao.UserDao;
import domain.PageBean;
import domain.User;

import java.util.List;

public class UserDaoImp extends BaseDao implements UserDao {

    /**
     * 根据名称和密码查询用户
     * @param username, password
     * @return 如果返回true代表用户存在，反之不存在
     */
    @Override
    public User queryUserByNameAndPass(String username, String password) {
        String sql = "select * from users where name = ? && password = ?";
        return queryForOne(User.class, sql, username, password);
    }

    /**
     * 添加（注册）用户
     * @param user 创建一个用户
     * @return 如果返回true代表添加成=成功，反之失败
     */
    @Override
    public boolean addUser(User user) {
        String sql = "insert into users (name, password, sex, tel, birth, address, headImgUrl) " +
                "values(?, ?, ?, ?, ?, ?, ?)";
        int num = update(sql, user.getName(), user.getPassword(), user.getSex(), user.getTel(), user.getBirth(), user.getAddress(), user.getHeadImgUrl());

        if (num > 0)
            return true;
        return false;
    }

    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @return 如果查询到则返回用户
     */
    @Override
    public User queryUserByUserName(String username) {
        String sql = "select * from users where name = ?";
        return queryForOne(User.class, sql, username);
    }

    /**
     * 查询所有用户
     * @jurisdiction 权限
     * @return 返回所有用户列表
     */
    @Override
    public List<User> queryAllUsers(PageBean<User> pageBean, int jurisdiction) {
        String sql = "select * from users where isAdmin=? order by id desc limit ?, ?";
        return queryForList(User.class, sql, jurisdiction, pageBean.getStartIndex(), pageBean.getPageSize());
    }

    /**
     * 获取用户数量
     * @return 返回所有用户数量
     */
    @Override
    public int getUserTotal() {
        String sql = "select count(*) from users";
        return ((Long) queryForSingleValue(sql)).intValue();
    }

    /**
     * 根据id查询用户
     * @param id 用户id
     * @return 如果存在则返回user
     */
    @Override
    public User queryUserById(int id) {
        String sql = "select * from users where id = ?";
        return queryForOne(User.class, sql, id);
    }

    /**
     * 查询管理员
     * @return 返回管理员列表
     */
    @Override
    public List<User> queryAdmins() {
        String sql = "select * from users where isAdmin = 1 || isAdmin = 2";
        return queryForList(User.class, sql);
    }

    /**
     * 根据id删除用户
     * @param id
     * @return 删除成返回true
     */
    @Override
    public boolean delUserById(int id) {
        String sql = "delete from users where id = ?";
        int num = update(sql, id);
        if(num > 0)
            return true;
        return false;
    }

    /**
     * 更新用户
     * @param user 用户
     * @return 返回true代表更新user成功
     */
    @Override
    public boolean upDateUser(User user) {
        String sql = "update users set name=?, password=?, sex=?, tel=?, birth=?, address=?, headImgUrl=? where id=?";
        int num = update(sql, user.getName(), user.getPassword(), user.getSex(), user.getTel(), user.getBirth(), user.getAddress(), user.getHeadImgUrl(), user.getId());

        if (num>0)
            return true;
        return false;
    }

    /**
     * 设置用户为管理员
     * @param uid 用户id
     * @return 返回true设置成功
     */
    @Override
    public boolean setAdmin(int uid) {
        String sql = "update users set isAdmin = 1 where id = ?";
        int num = update(sql, uid);
        if (num > 0)
            return true;
        return false;
    }

    /**
     * 移除用户管理员权限
     * @param uid 用户id
     * @return 返回true设置成功
     */
    @Override
    public boolean removeAdmin(int uid) {
        String sql = "update users set isAdmin = 0 where id = ?";
        int num = update(sql, uid);
        if ( num > 0)
            return true;
        return false;
    }

}
