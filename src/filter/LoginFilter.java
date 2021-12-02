package filter;

import dao.imp.UserDaoImp;
import domain.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "/userServlet")
public class LoginFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse ServletResponse = (HttpServletResponse) resp;

//		获取一个名为autologin的cookie (username-password),并取得其值（value）
        Cookie[] cookies = request.getCookies();
        String value = null;
        // 查找名为autologin的cookie，找到之后获取其值
        for(int i=0; cookies!=null && i< cookies.length;i++) {
            String name = cookies[i].getName();  // cookie--key
            if("autoLogin".equals(name)) {
                value = cookies[i].getValue(); //value: username-password
                break;
            }
        }
        if(value != null) { // 获取value中用户名和密码，做自动登录
            String[] parts = value.split("-");
            String username = parts[0];
            String password = parts[1];
            // 验证
            UserDaoImp dao = new UserDaoImp();
            User user = dao.queryUserByNameAndPass(username, password);
            if(user != null) {
                // 将用户名和密码保存到session对象
                request.getSession().setAttribute("user", user);
            }
        }
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
