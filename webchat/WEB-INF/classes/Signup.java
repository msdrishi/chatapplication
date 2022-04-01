
import java.io.IOException;
import java.sql.*;



import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/signup")
public class Signup extends  HttpServlet
{
    

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException
    {
        
        String name=request.getParameter("username-signup");
        String pass=request.getParameter("password-signup");

        System.out.println(name +" "+ pass);

        Connection c = null;
        Statement st= null;
      
        try {

            
         Class.forName("org.sqlite.JDBC");
         c = DriverManager.getConnection("jdbc:sqlite:/C:/sqlite/login/login.db");
       

          c.setAutoCommit(false);

           System.out.println("Opened database successfully");
   
         
       
           st = c.createStatement();
        

           st.executeUpdate("insert into logindetails values('"+name+"','"+pass+"');");
           System.out.println("data inserted successfully");
            
           st.close();
           c.commit();
           c.close();


           HttpSession session=request.getSession();

           session.setAttribute("signup", "login created successfully");


           response.sendRedirect("Login.jsp");
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
   

  

     
}
}
