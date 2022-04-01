
import java.io.IOException;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

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
        try {


         Class.forName("org.sqlite.JDBC");
         c = DriverManager.getConnection("jdbc:sqlite:/C:/sqlite/login/login.db");
         System.out.println("Opened database successfully");

    
       
            
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
             
             
              
           }
           
           if(b==true)
           {
                 int i=0;
                 
               File folder = new File("C:/sqlite/tomcat 9090");
               File[] listOfFiles = folder.listFiles();

               for (File file : listOfFiles) {
                  if (file.isFile()) {
                     
                     String str=(String)file.getName();

                        String s[]=str.split("[.]");
                        System.out.println(s[0]);
                        if(name.equals(s[0]))
                        {
                           i=1;
                        }
                                       
                  }
               }

               if(i==0)
               {
                 

                  Connection newcon = DriverManager
                  .getConnection("jdbc:sqlite:/C:/sqlite/tomcat 9090/"+name+".db");

                  Statement newstate=newcon.createStatement();
                  
                  String friendstable="create table friends(name text);";
                  newstate.executeUpdate(friendstable);

                  System.out.println("friends table created");

                  newstate.close();
                  newcon.close();


               }
             
 
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