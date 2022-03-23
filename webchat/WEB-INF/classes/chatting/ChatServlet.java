
package chatting;
import java.io.*;
import java.lang.Thread.State;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.sql.*;


@ServerEndpoint(value = "/chat/{username}")
public class ChatServlet {

   public static Set<Session> userSessions = Collections.newSetFromMap(new ConcurrentHashMap<Session, Boolean>());

    HashMap<Integer,String> map=new HashMap<Integer,String>();

    public static Set<String> names = Collections.newSetFromMap(new ConcurrentHashMap<String, Boolean>());

    @OnOpen
    public void onOpen(Session curSession,@PathParam("username") String username) throws IOException
    {
        curSession.getUserProperties().put("username", username);
        userSessions.add(curSession);
        names.add(username);
        
      
       System.out.println("New user:"+username);
       int n=Integer.valueOf(curSession.getId());
       String name=username;
       map.put(n,name);
       
       for(Map.Entry<Integer,String> m : map.entrySet())
       {    
           System.out.println(m.getKey()+" "+m.getValue());    
       }  
       
       System.out.println("available users online");


     

        Connection c = null;
        Statement st= null;
       
        try {
           Class.forName("org.postgresql.Driver");
           c = DriverManager
              .getConnection("jdbc:postgresql://localhost:5432/"+username,
              "postgres", "1234");

            
              c.setAutoCommit(false);

           System.out.println("Opened database successfully");
   
         
       
           st = c.createStatement();
           ResultSet rs = st.executeQuery( "SELECT table_name FROM information_schema.tables WHERE table_schema='public'  AND table_type='BASE TABLE';" );
           while ( rs.next() ) {
              String  chat = rs.getString("TABLE_NAME");
              if(!(chat.equals("friends")))
              {
                curSession.getBasicRemote().sendText("friends: "+chat);
                ResultSet r=st.executeQuery("select * from "+chat+";");
                    while(r.next())
                    {
                        String  cstr = r.getString("chat");
                        curSession.getBasicRemote().sendText(cstr);
                    }
                   
              }
             
              System.out.println(chat);
             
           }

           rs.close();
           st.close();
           c.close();
           for(String str:names)
           {
              
              System.out.println(str);
           }
           
           
           
    
          
        }
        catch(Exception e)
        {
            System.out.println(e);
        }


        for(String str:names)
        {
           if(!(str.equals(username)))
           {
               curSession.getAsyncRemote().sendText(str+" joined");
           }
           System.out.println(str);
        }
        

        for(Session ses :userSessions)
        {
            if(ses!=curSession)
            {
                ses.getAsyncRemote().sendText(name+" joined");
            }
            
        }

    }

            
    @OnClose
    public void onClose(Session curSession)
    {
        
      
        int n=Integer.valueOf(curSession.getId());
        
        String name=map.get(n);

        System.out.println("Session closed");

        userSessions.remove(curSession);
     
        for(Session ses :userSessions)
        {
            ses.getAsyncRemote().sendText(name+" left");
        }
 
        map.remove(n);
    }
    
    @OnMessage
    public void onMessage(String message, Session userSession)
    {
       
        String msg[]=message.split(">>");
        
        String sender=msg[0];
        String receiver=msg[2];
        String chat=msg[0]+":"+msg[1];


        for(Session ses : userSessions)
        {
            
            String sesname=(String)ses.getUserProperties().get("username");

            if( sesname.equals(sender))
            {
                ses.getAsyncRemote().sendText(chat);
              


                            
                        Connection c = null;
                        Connection con=null;
                        Statement st=null;
                        Statement stmt = null;
                        try {
                        Class.forName("org.postgresql.Driver");
                        String user=sender;
                        c = DriverManager
                            .getConnection("jdbc:postgresql://localhost:5432/"+user,
                            "postgres", "1234");
                            con = DriverManager
                            .getConnection("jdbc:postgresql://localhost:5432/"+receiver,
                            "postgres", "1234");

                        c.setAutoCommit(false);
                        con.setAutoCommit(false);

                        System.out.println("message going to insert");
                
                        stmt = c.createStatement();
                        String sql="";
                        st=con.createStatement();

                        sql = "INSERT INTO "+receiver+" values('"+chat+"');";
                        
                        stmt.executeUpdate(sql);

                        sql = "INSERT INTO "+sender+" values('"+chat+"');";
                        
                        st.executeUpdate(sql);
                        

                        System.out.println("inserted successfully");

                        stmt.close();
                        c.commit();
                        st.close();
                        con.commit();
                        con.close();
                        c.close();
                        } catch (Exception e) {
                        System.err.println( e.getClass().getName()+": "+ e.getMessage() );
                        
                        }
      
            }
            if( sesname.equals(receiver))
            {
                ses.getAsyncRemote().sendText(chat);
            }






             
      
           
        }
         
    }

    public Set<Session> getSession()
    {
        return userSessions;
    }

  

    
}