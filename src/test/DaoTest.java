package test;

import dao.imp.UserDaoImp;
import domain.User;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DaoTest {
    public static void main(String[] args) {
        UserDaoImp dao = new UserDaoImp();
        User user = dao.queryUserById(101);

//        Path path = Paths.get("C:\\Users\\KLX\\Pictures\\samsung\\headImg\\aaa.txt");
//        try {
//            Files.delete(path);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }

    }
}
