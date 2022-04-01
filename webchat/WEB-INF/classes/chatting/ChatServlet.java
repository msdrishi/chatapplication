
package chatting;
import java.io.*;
import java.util.Collections;
import java.util.HashMap;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;


import java.sql.*;


@ServerEndpoint(value = "/chat/{username}/{port}")
public class ChatServlet {

   public static Set<Session> userSessions = Collections.newSetFromMap(new ConcurrentHashMap<Session, Boolean>());

    HashMap<Integer,String> map=new HashMap<Integer,String>();

    public static Set<String> names = Collections.newSetFromMap(new ConcurrentHashMap<String, Boolean>());

    @OnOpen
    public void onOpen(Session curSession,@PathParam("username") String username,@PathParam("port") String port) throws IOException
    {
        curSession.getUserProperties().put("username", username);
        curSession.getUserProperties().put("port", port);
        userSessions.add(curSession);
        
        names.add(username);
        System.out.println("session port:"+curSession.getRequestURI().getPort());
        System.out.println("session port:"+curSession.getRequestURI().getHost());
   
        System.out.println("session id:"+curSession.getId());
       System.out.println("New user:"+username);
       
      
     
       System.out.println("available users online");


     


        Connection offlinecon = null;
        Statement offst= null;
       
        try {
           Class.forName("org.sqlite.JDBC");
           

           //checking if any offline messages 

           offlinecon = DriverManager
           .getConnection("jdbc:sqlite:/C:/sqlite/offline/"+username+".db");

         
         
          // offlinecon.setAutoCommit(false);

        System.out.println("offline Opened database successfully");

      
    
        offst = offlinecon.createStatement();
        System.out.println("retriving friends");
        ResultSet rss = offst.executeQuery( "SELECT name, sql FROM sqlite_master WHERE type='table' ORDER BY name;");
        while ( rss.next() ) {
           String  chat = rss.getString("name");
           System.out.println(chat);

           if(!(chat.equals("friends")))
           {
             ResultSet r=null;
             Statement nst=offlinecon.createStatement();

             r=offst.executeQuery("select * from "+chat+";");
                 while(r.next())
                 {
                     String  cstr = r.getString("chat");
                     System.out.println("offline message:"+cstr);

    
                     curSession.getBasicRemote().sendText(cstr);
                 }

                 PreparedStatement pstmt = offlinecon.prepareStatement("delete from "+chat+" where not chat =' ';");
                 pstmt.executeUpdate();

                nst.close();
                r.close();
           }
            
           rss.close();
          
          
        }

      
           offlinecon.close();
           offst.close();
       
           System.out.println("online users");
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
               curSession.getBasicRemote().sendText(str+" 34y34yrgws");
           }
         //  System.out.println(str);
        }
        

        for(Session ses :userSessions)
        {
            if(ses!=curSession)
            {
                ses.getAsyncRemote().sendText(username+" 34y34yrgws");
            }
            
        }

    }

            
    @OnClose
    public void onClose(Session curSession)
    {
        
       String name=(String) curSession.getUserProperties().get("username");

        names.remove(name);

        System.out.println("Session closed");

        userSessions.remove(curSession);
     
        for(Session ses :userSessions)
        {
            ses.getAsyncRemote().sendText(name+" hfo8yr679r69");
        }
 
        
    }
    
    @OnMessage
    public void onMessage(String message, Session userSession)
    {

        if(message.contains("diuye3ur02ydpcus"))
        {

               //incoming request
               System.out.println("requesting");
                String request[]=message.split("-");

                String reqname=request[0];
                String sender=request[2];

                for(Session ses: userSessions)
                {
                    String sesname=(String)ses.getUserProperties().get("username");
                    if(sesname.equals(reqname))
                    {
                        ses.getAsyncRemote().sendText("requestf2u3hyr9ydb "+sender);
                    }
                }

        }
        else if(message.contains("accepteoiqy3addf"))
        {
            String arr[]=message.split("-");
            String friend=arr[0];
            String friendport="";
            for(Session ses:userSessions)
            {
                String name=(String)ses.getUserProperties().get("username");
                if(name.equals(friend))
                {
                    friendport=(String)ses.getUserProperties().get("port");
                    break;
                }
                

            }


            String myname=(String)userSession.getUserProperties().get("username");
            String port=(String)userSession.getUserProperties().get("port");

            addfriend(myname,friend,port);
            addfriend(friend, myname,friendport);

            for(Session ses:userSessions)
            {
                String name=(String)ses.getUserProperties().get("username");
                if(name.equals(myname))
                {
                    ses.getAsyncRemote().sendText("alter23ifhped32-"+friend);
                }
                if(name.equals(friend))
                {
                    ses.getAsyncRemote().sendText("alter23ifhped32-"+myname);
                }
            }


        }
        else{

            String msg[]=message.split(">>");
        
            String sender=msg[0];
            String receiver=msg[2];
            String chat=msg[0]+":"+msg[1]+">>"+receiver;

            String fport="";

            for(Session ses:userSessions)
            {
                String sesname=(String)ses.getUserProperties().get("username");
                if(sesname.equals(receiver))
                {
                     fport=(String)ses.getUserProperties().get("port");
                }
            }
    
            
            
           
            if(fport.equals(""))
            {

                System.out.println("person offline");
              
                Connection connect=null;
                Statement st=null;
              
                try {
                    Class.forName("org.sqlite.JDBC");
                  
                    connect = DriverManager
                    .getConnection("jdbc:sqlite:/C:/sqlite/offline/"+receiver+".db");

                    Statement stt=null;
                    stt=connect.createStatement();
                    stt.executeUpdate("CREATE TABLE IF NOT EXISTS "+sender+" (chat text);");
                    stt.close();
                    
                   
                   
            
                

                System.out.println("message going to insert");
        
           
                String sql="";
                st=connect.createStatement();

           
                sql = "INSERT INTO "+sender+" values('"+chat+"');";
                System.out.println( "INSERT INTO "+sender+" values('"+chat+"');");
                
                st.executeUpdate(sql);
                

                System.out.println("inserted successfully");

               
                st.close();
                connect.close();
               
                } 
                catch (Exception e) {
                System.err.println( e.getClass().getName()+": "+ e.getMessage() );
                
                }

            }


            for(Session ses : userSessions)
            {
                
                String sesname=(String)ses.getUserProperties().get("username");
    
    
                if( sesname.equals(sender))
                {
                    ses.getAsyncRemote().sendText(chat);
                   
                }
                if( sesname.equals(receiver))
                {
                    ses.getAsyncRemote().sendText(chat);
                }
    
    
            }

             
      
           
        }
         
    }


    @OnError
    public void error(Session session, Throwable t) {
        System.out.println(t);
    }


    
    public Set<Session> getSession()
    {
        return userSessions;
    }

    
    public Set<String> getOnlineUser()
    {
        return names;
    }


    public void addfriend(String myname,String friend,String port)
    {
     

        Connection off=null;
        Statement offst=null;

        System.out.println("myname:"+myname);
        System.out.println("friend:"+friend);
        try {

           Class.forName("org.sqlite.JDBC");
         
            off = DriverManager
           .getConnection("jdbc:sqlite:/C:/sqlite/offline/"+myname+".db");

            offst=off.createStatement();
            String str="create table "+friend+"(chat text);";
            offst.executeUpdate(str);
            System.out.println("new friend table created in offline also");

          

            off.close();
            offst.close();
           

          
           }
           catch (Exception e) {
                     e.printStackTrace();
               }

    }
  

    
}