package dao;

import domain.PageBean;
import domain.User;

import java.util.List;

public interface UserDao {
    /**
     * 根据名称和密码查询用户
     * @return 返回一个用户
     */
    User queryUserByNameAndPass(String username, String password);

    /**
     * 添加（注册）用户
     * @param user 创建一个用户
     * @return 如果返回true代表添加成=成功，反之失败
     */
    boolean addUser(User user);

    /**
     * 通过用户名查询用户
     * @return 查询到就返回 true
     */
    User queryUserByUserName(String username);

    /**
     * 查询所有用户
     * @jurisdiction 权限
     * @return 返回所有用户列表
     */
    List<User> queryAllUsers(PageBean<User> pageBean, int jurisdiction);

    /**
     * 获取用户数量
     * @return 返回所有用户数量
     */
    int getUserTotal();

    /**
     * 根据id查询用户
     * @param id 用户id
     * @return 如果存在则返回user
     */
    User queryUserById(int id);

    /**
     * 查询管理员
     * @return 返回管理员列表
     */
    List<User> queryAdmins();

    /**
     * 根据id删除用户
     * @param uid 用户id
     * @return 删除成返回true
     */
    boolean delUserById(int uid);

    /**
     * 更新用户
     * @param user user
     * @return 返回true代表更新成功
     */
    boolean upDateUser(User user);

    /**
     * 设置用户为管理员
     * @param uid 用户id
     * @return 返回true设置成功
     */
    boolean setAdmin(int uid);

    /**
     * 移除用户管理员权限
     * @param uid 用户id
     * @return 返回true设置成功
     */
    boolean removeAdmin(int uid);

}
