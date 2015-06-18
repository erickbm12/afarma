package com.afarma.banco;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Conexao {
    public static Connection getConnection() throws Exception{
        try{

            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(
                    "jdbc:mysql://localhost/afarma","root","");


          /*  InitialContext ctx = new InitialContext();
            DataSource ds =
            (DataSource) ctx.lookup("java:comp/env/jdbc/livraria");
            return ds.getConnection();
           *
           */
        }catch(Exception e){
            throw new Exception("Erro em getConnection: "+":\n"+e.getMessage());
        }
    }
public static void CloseConnection(Connection conn,
        Statement stmt, ResultSet rs) throws Exception{
    close(conn,stmt,rs);
}

public static void CloseConnection(Connection conn, Statement stmt)
        throws Exception{
         close(conn,stmt,null);
}

private static void close(Connection conn,
        Statement stmt, ResultSet rs)
         throws Exception{
    try{
        if(rs!=null) rs.close();
        if(stmt!=null) stmt.close();
        if(conn!=null) conn.close();

    }catch(Exception e){
            throw new Exception(e.getMessage());
        }
}

}
