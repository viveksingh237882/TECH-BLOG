package com.tech.blog.dao;

import java.sql.*;
import java.lang.*;
import com.tech.blog.entities.User;
import static org.eclipse.jdt.internal.compiler.parser.Parser.name;

public class UserDao {

    private Connection con;
    private String password;

    public UserDao(Connection con) {
        this.con = con;
    }
//    metho insert

    public boolean saveUser(User user) {
        boolean f = false;
        try {

            String query = "insert into user(name,email,password,gender,about) values(?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());

            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }
//    getting the user using the emailId andpassword

    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;

        try {
            String query = "select *from user where email=? and password=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            ResultSet set = pstmt.executeQuery();

            if (set.next()) {
                user = new User();
//                getting the name ffrom databases
//                String name=set.getString("name");
//                setting the name to user
//                user.setName(name);
                user.setName(set.getString("name"));
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("Email"));
                user.setPassword(set.getString("password"));
                user.setAbout(set.getString("about"));
                user.setGender(set.getString("gender"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));

            }

        } catch (Exception e) {
            e.printStackTrace();

        }

        return user;
    }

    public boolean updateUser(User user) {
        boolean f = false;
        try {
            String query = "update user set name=?,email=?,password=?,gender=?,about=?,profile=?where id=?";
            PreparedStatement p = con.prepareStatement(query);
            p.setString(1, user.getName());
            p.setString(2, user.getEmail());
            p.setString(3, user.getPassword());
            p.setString(4, user.getGender());
            p.setString(5, user.getAbout());
            p.setString(6, user.getProfile());
            p.setInt(7, user.getId());

            p.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public User getUserByUserId(int userId) {

        User user = null;

        try {
            String q = "select *from user where id=?";
            PreparedStatement ps = this.con.prepareStatement(q);
            ps.setInt(1, userId);
            ResultSet set = ps.executeQuery();
            if (set.next()) {
                user=new User();
                user.setName(set.getString("name"));
//                user.setName(name);
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("Email"));
                user.setPassword(set.getString("password"));
                user.setAbout(set.getString("about"));
                user.setGender(set.getString("gender"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));

            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return user;
    }
}
