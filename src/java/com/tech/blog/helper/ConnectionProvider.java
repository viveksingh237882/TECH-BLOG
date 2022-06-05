
package com.tech.blog.helper;
import java.sql.*;
import java.util.*;


public class ConnectionProvider {
    private static Connection con;
    
    public static Connection getConnection()
    {
        
        
        try
        {
        
        if(con==null)
        {
        
            //loading a adriver class
            Class.forName("com.mysql.cj.jdbc.Driver");

            //creating a connection
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog","root","2002");
        }
        
        
        
        }catch(Exception e)
        {
            e.printStackTrace();
        }
    
    return con;
    }
    
            }
