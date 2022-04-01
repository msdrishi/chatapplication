
import java.io.IOException;
import java.sql.*;



import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Ajaxservlet")
public class Ajaxservlet extends  HttpServlet
{
    

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException
    {
        response.setContentType("text/plain");
       String message=request.getParameter("message");
       String owner=request.getParameter("owner");
       String friend=request.getParameter("friend");
       System.out.println(message+" - "+owner+" - "+friend);

       insertdatabase(message,owner,friend);


    

     
    }


    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException
    {
        response.setContentType("text/plain");
       String friend=request.getParameter("name");
       String owner=request.getParameter("owner");
       System.out.println(friend+" - "+owner);

       addfriend(friend,owner);


    

     
    }
 
 
public void addfriend(String friend,String owner)
{
    Connection c = null;
    Statement st= null;

    Statement stmt=null;

    try {

       Class.forName("org.sqlite.JDBC");
       c = DriverManager
       .getConnection("jdbc:sqlite:/C:/sqlite/tomcat 9090/"+owner+".db");


        st=c.createStatement();
        String sql="create table "+friend+"(chat text);";
        st.executeUpdate(sql);
        System.out.println("new friend table created");

    
        stmt=c.createStatement();

        sql="INSERT INTO FRIENDS VALUES ('"+friend+"');";

        stmt.executeUpdate(sql);
        System.out.println("add to friendslist");

        
       
        stmt.close();
        st.close();
        c.close();

        



      
       }
       catch (Exception e) {
                 e.printStackTrace();
           }

}

    

public void insertdatabase(String message,String owner,String friend)
{  
   
    Connection connect=null;
    Statement st=null;
  
    try {
        Class.forName("org.sqlite.JDBC");
      
        connect = DriverManager
        .getConnection("jdbc:sqlite:/C:/sqlite/tomcat 9090/"+owner+".db");

   
        Statement stt=null;
        stt=connect.createStatement();
        stt.executeUpdate("CREATE TABLE IF NOT EXISTS "+friend+" (chat text);");
        stt.close();
       

    

    System.out.println("message going to insert");


    String sql="";
    st=connect.createStatement();


    sql = "INSERT INTO "+friend+" values('"+message+"');";
    System.out.println( "INSERT INTO "+friend+" values('"+message+"');");
    
    st.executeUpdate(sql);
    

    System.out.println("inserted successfully");

   
    st.close();
    connect.close();
   
    } 
    catch (Exception e) {
    System.err.println( e.getClass().getName()+": "+ e.getMessage() );
    
    }
  
}


}




