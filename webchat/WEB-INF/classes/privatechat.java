
import java.io.*;
import java.net.*;
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
import chatting.ChatServlet;


@ServerEndpoint(value = "/chat/{username}/{friend}")
public class privatechat {

     public static Set<Session> AllSessions = Collections.newSetFromMap(new ConcurrentHashMap<Session, Boolean>());

     ChatServlet ob=new ChatServlet();
     
     HashMap<Integer,String> map=new HashMap<Integer,String>();

    
   String friend="";
  


    @OnOpen
    public void onOpen(Session curSession,@PathParam("username") String username,@PathParam("friend") String friend) throws IOException
    {
       AllSessions=ob.getSession();
       System.out.println("New user:"+username);
       System.out.println("New friend:"+friend);
       System.out.println("session:"+curSession);
       int n=Integer.valueOf(curSession.getId());
       String name=username;
       this.friend=friend;
       map.put(n,name);
       
       for(Map.Entry m : map.entrySet())
       {    
           System.out.println(m.getKey()+" "+m.getValue());    
       }  

       
    }

            
    @OnClose
    public void onClose(Session curSession)
    {
        
      
        int n=Integer.valueOf(curSession.getId());
        
        String name=map.get(n);

        System.out.println("Session closed");

        AllSessions.remove(curSession);
       
    }
    
    @OnMessage
    public void onMessage(String message, Session userSession)
    {  
        for(Session ses : AllSessions)
        {
           if(friend.equals(ses.getUserProperties().get("username")))
           {
              ses.getAsyncRemote().sendText(message);
              userSession.getAsyncRemote().sendText(message);
           }
            System.out.println("message:"+message+" username:"+ses.getUserProperties().get("username")+" Session id:"+ses);
           
            
      
           
        }

       
    }
}