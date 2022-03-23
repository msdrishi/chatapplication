
import java.io.IOException;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/access")
public class access extends  HttpServlet
{
    

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException
    {
        
        String name=request.getParameter("username");
        String pass=request.getParameter("password");

        Connection c = null;
        Statement st= null;
        boolean b=false;
        Statement stu=null;
        Connection con =null;
        try {
           Class.forName("org.postgresql.Driver");
           c = DriverManager
              .getConnection("jdbc:postgresql://localhost:5432/Login",
              "postgres", "1234");

             con = DriverManager
             .getConnection("jdbc:postgresql://localhost:5432/",
             "postgres", "1234");

            
              c.setAutoCommit(false);

           System.out.println("Opened database successfully");
   
         
       
           st = c.createStatement();
      

           ResultSet rs = st.executeQuery( "SELECT * FROM LOGINDETAILS;" );
           while ( rs.next() ) {
              String  uname = rs.getString("username");
              String  upass = rs.getString("password");
            
              if(name.equals(uname)) 
              {
                if(pass.equals(upass))
                {
                      b=true;
                      System.out.println("correct");
                     
                     
                      break;
                }
              }
             
             
              System.out.println();
           }
           
           if(b==true)
           {
                  stu=con.createStatement();
                  int i=0;
                  try {
                     PreparedStatement ps = con.prepareStatement("SELECT datname FROM pg_database WHERE datistemplate = false;");
                     ResultSet rs2 = ps.executeQuery();
                     while (rs2.next()) {
                        System.out.println(rs2.getString(1));
                        if(rs2.getString(1).equals(name))
                        {
                           i=1;
                        }
                     }
                     rs2.close();
                     ps.close();
         
               } catch (Exception e) {
                     e.printStackTrace();
               }

               if(i==0)
               {
                  String dbquery="CREATE DATABASE "+name+";";
                  stu.executeUpdate(dbquery);
               }
               stu.close();
               con.close(); 
 
           }
           

           st.close();
           c.close();
         

        } 
        catch ( Exception e )
        {
           System.err.println( e.getClass().getName()+": "+ e.getMessage() );
        }

       if(b==true)
       {
          
        HttpSession session=request.getSession();
        session.setAttribute("username",name);
        response.sendRedirect("index.jsp");
       }
       else{
        HttpSession session=request.getSession();
        session.setAttribute("invalid","wrong username or password");
        response.sendRedirect("Login.jsp");
       }
       
   
       
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException
    {
        
        String name=request.getParameter("friend");
        String Myname=request.getParameter("Myname");

        
       
   
        HttpSession session=request.getSession();
        session.setAttribute("friend",name);
        session.setAttribute("myname", Myname);
        response.sendRedirect("Privatechat.jsp");
     
    }


  

     
}