package domain;

import lombok.*;

/**
 * 使用lombok jar包实现
 */
@Getter
@Setter
@Data   //Get & Set & ToString
@NoArgsConstructor  //无参构造方法
@AllArgsConstructor //有参构造方法

public class User {
    private Integer id;
    private String name;
    private String password;
    private String sex;
    private String tel;
    private String birth;
    private String address;
    private String headImgUrl;
    private Integer isAdmin;

    //用户修改自己信息时的构造方法，没有管理员和购物车属性
    public User(int uid, String username, String password, String sex, String tel, String birth, String address, String iUrl) {
        this.id = uid;
        this.name = username;
        this.password = password;
        this.sex = sex;
        this.tel = tel;
        this.birth = birth;
        this.address = address;
        this.headImgUrl = iUrl;
    }
}

